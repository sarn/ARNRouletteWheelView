//
//  ARNRouletteWheelLayout.m
//  myVisit
//
//  Created by Stefan Arn on 04/09/15.
//  Copyright (c) 2015 Stefan Arn. All rights reserved.
//
//  Based on code and calculations found here:
//  http://www.raywenderlich.com/107687/uicollectionview-custom-layout-tutorial-spinning-wheel
//  Thanks to Rounak Jain for the awesome work

#import "ARNRouletteWheelLayout.h"
#import "ARNRouletteWheelLayoutAttributes.h"

@interface ARNRouletteWheelLayout ()

@property (nonatomic, strong) NSArray *attributeList;

@end

@implementation ARNRouletteWheelLayout

- (instancetype)init
{
    self = [super init];
    if(self)
    {
        [self setup];
    }
    return self;
}

// common setup method used by init's
- (void)setup
{
    // set default values
    _radius = 500.0f;
    _interItemSpacing = 1.0f;
    _attributeList = [NSArray array];
    
    // itemSize
    // cells should have the same aspect ratio as the device
    CGFloat biggerScreenSideSize = MAX([[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height);
    CGFloat smallerScreenSideSize = MIN([[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height);
    CGFloat screenSizeRatio = biggerScreenSideSize / smallerScreenSideSize;
    CGFloat itemWidth = smallerScreenSideSize / 3.0f;
    CGFloat itemHeight = itemWidth * screenSizeRatio;
    _itemSize = CGSizeMake(itemWidth, itemHeight);
}


#pragma mark -
#pragma mark providing layout attributes

+ (Class)layoutAttributesClass {
    return [ARNRouletteWheelLayoutAttributes class]; // use this custom layout attributes
}

- (void)prepareLayout {
    [super prepareLayout];
    
    if(self.collectionView != nil) {
        // start in the middle of the screen
        CGFloat centerX = self.collectionView.contentOffset.x + (self.collectionView.bounds.size.width / 2.0);
        // set the anchor point to the center of the roulette wheel starting from the view center
        CGFloat anchorPointY = ((self.itemSize.height/2.0) + self.radius) / self.itemSize.height;
        
        // -- calculate start and end index needed --
        // only calculate the attributes of the cells that are on the screen
        // only create views that are visible -> performance boost right here
        
        // the angle which the screen is exposing - the stuff that is visible is inside that angle
        CGFloat theta = atan2(self.collectionView.bounds.size.width / 2.0, self.radius + (self.itemSize.height / 2.0) - (self.collectionView.bounds.size.height / 2.0));
        
        // init to all cells
        NSInteger startIndex = 0;
        NSInteger endIndexTmp = [self.collectionView numberOfItemsInSection:0] - 1;
        
        CGFloat angle = [self angle];
        CGFloat anglePerItem = [self anglePerItem];
        
        // if the angle of the first item lies outside of the left side of the screen (-theta)
        if (angle < -theta) {
            // then get the first item that is visible on the left side of the screen
            startIndex = floor((-theta - angle)/anglePerItem);
        }
        // get the last item that is visible on the right side of the screen.
        NSInteger endIndex = MIN(endIndexTmp, ceil((theta - angle)/anglePerItem));
        
        // edge case: if one scrolls really fast and all cells go offscreen
        if (endIndex < startIndex) {
            endIndex = 0;
            startIndex = 0;
        }
        
        // -- let's create the layout attributes for each indexPath --
        NSMutableArray *layoutAttributes = [NSMutableArray array];
        for (NSInteger i = startIndex; i <= endIndex; i++) {
            ARNRouletteWheelLayoutAttributes *rouletteWheelLayoutAttributes = [ARNRouletteWheelLayoutAttributes layoutAttributesForCellWithIndexPath:[NSIndexPath indexPathForItem:i inSection:0]];
            // size the item
            rouletteWheelLayoutAttributes.size = self.itemSize;
            // center the item at the center of the screen
            rouletteWheelLayoutAttributes.center = CGPointMake(centerX, CGRectGetMidY(self.collectionView.bounds));
            // rotate the item
            rouletteWheelLayoutAttributes.angle = angle + (anglePerItem * i);
            // move the item to the corect position on the wheel
            rouletteWheelLayoutAttributes.anchorPoint = CGPointMake(0.5f, anchorPointY);
            [layoutAttributes addObject:rouletteWheelLayoutAttributes];
        }
        self.attributeList = layoutAttributes;
    }
}

- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity {
    CGPoint finalContentOffset = proposedContentOffset;
    
    if (self.collectionView != nil) {
        CGFloat factor = -[self angleAtExtreme] / (self.collectionViewContentSize.width - self.collectionView.bounds.size.width);
        CGFloat proposedAngle = proposedContentOffset.x * factor;
        CGFloat ratio = proposedAngle / [self anglePerItem];
        CGFloat multiplier;
        if (velocity.x > 0) {
            multiplier = ceil(ratio);
        } else if (velocity.x < 0) {
            multiplier = floor(ratio);
        } else {
            multiplier = round(ratio);
        }
        finalContentOffset.x = multiplier * [self anglePerItem] / factor;
    }
    
    return finalContentOffset;
}


#pragma mark -
#pragma mark must overwrites

- (CGSize)collectionViewContentSize {
    CGSize contentSize = CGSizeZero;
    if(self.collectionView != nil) {
        CGFloat collectionViewWidth = [self.collectionView numberOfItemsInSection:0] * self.itemSize.width;
        CGFloat collectionViewHeight = self.collectionView.bounds.size.height;
        contentSize = CGSizeMake(collectionViewWidth, collectionViewHeight);
    }
    return contentSize;
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    // we can return the complete list here and don't have to check if the elements
    // in the array are on the screen or not. this work is done by the prepareLayout
    // which populates this array only with the attributes of the views that are currently
    // on the screen. A check here would be redundant.
    return self.attributeList;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *layoutAttributes = nil;
    if (self.attributeList != nil && [self.attributeList count] > indexPath.row) {
        id obj = [self.attributeList objectAtIndex:indexPath.row];
        if(obj != nil && [obj isKindOfClass:[UICollectionViewLayoutAttributes class]])
        {
            layoutAttributes = obj;
        }
    }
    return layoutAttributes;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES; // invalidate the layout as it scrolls, and call prepareLayout
}


#pragma mark -
#pragma mark angle helper methods

- (CGFloat)angle {
    CGFloat angle = 0.0f;
    if (self.collectionView != nil) {
        angle = [self angleAtExtreme] * self.collectionView.contentOffset.x / (self.collectionViewContentSize.width - self.collectionView.bounds.size.width);
    }
    return angle;
}

- (CGFloat)angleAtExtreme {
    CGFloat angleAtExtreme = 0.0f;
    if (self.collectionView != nil && [self.collectionView numberOfItemsInSection:0] > 0) {
        angleAtExtreme = -([self.collectionView numberOfItemsInSection:0] - 1) * [self anglePerItem];
    }
    return angleAtExtreme;
}

- (CGFloat)anglePerItem {
    return (self.itemSize.width * self.interItemSpacing) / self.radius;
}


#pragma mark -
#pragma mark getter and setters

- (void)setRadius:(CGFloat)radius {
    _radius = radius;
    [self invalidateLayout];
}

- (void)setInterItemSpacing:(CGFloat)interItemSpacing {
    _interItemSpacing = interItemSpacing;
    [self invalidateLayout];
}

- (void)setItemSize:(CGSize)itemSize {
    _itemSize = itemSize;
    [self invalidateLayout];
}

@end
