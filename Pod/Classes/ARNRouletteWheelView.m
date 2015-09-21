//
//  ARNRouletteWheelView.m
//  myVisit
//
//  Created by Stefan Arn on 04/09/15.
//  Copyright (c) 2015 Stefan Arn. All rights reserved.
//
//  Based on code and calculations found here:
//  http://www.raywenderlich.com/107687/uicollectionview-custom-layout-tutorial-spinning-wheel
//  Thanks to Rounak Jain for the awesome work

#import "ARNRouletteWheelView.h"
#import "ARNRouletteWheelLayout.h"
#import "ARNRouletteWheelCell.h"

@implementation ARNRouletteWheelView

- (instancetype)init
{
    self = [super initWithFrame:CGRectZero collectionViewLayout:[self rouletteLayout]];
    if(self)
    {
        [self setup];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame collectionViewLayout:[self rouletteLayout]];
    if(self)
    {
        [self setup];
    }
    return self;
}

// common setup method used be init's
- (void)setup
{
    // set default values
    self.backgroundColor = [UIColor clearColor];
    self.showsVerticalScrollIndicator = NO;
    [self registerClass:[ARNRouletteWheelCell class] forCellWithReuseIdentifier:@"ARNRouletteWheelCell"];
}

- (UICollectionViewLayout *)rouletteLayout
{
    return [[ARNRouletteWheelLayout alloc] init];
}


#pragma mark -
#pragma mark custom configuration setters

- (void)setRadius:(CGFloat)radius {
    ((ARNRouletteWheelLayout *)self.collectionViewLayout).radius = radius;
}

- (void)setInterItemSpacing:(CGFloat)interItemSpacing {
    ((ARNRouletteWheelLayout *)self.collectionViewLayout).interItemSpacing = interItemSpacing;
}

- (void)setItemSize:(CGSize)itemSize {
    ((ARNRouletteWheelLayout *)self.collectionViewLayout).itemSize = itemSize;
}

@end
