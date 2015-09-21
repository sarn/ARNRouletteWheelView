//
//  ARNRouletteWheelCell.m
//  myVisit
//
//  Created by Stefan Arn on 04/09/15.
//  Copyright (c) 2015 Stefan Arn. All rights reserved.
//

#import "ARNRouletteWheelCell.h"
#import "ARNRouletteWheelLayoutAttributes.h"

@implementation ARNRouletteWheelCell

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // customizations
    }
    return self;
}

- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes {
    [super applyLayoutAttributes:layoutAttributes];
    
    if(layoutAttributes != nil && [layoutAttributes isKindOfClass:[ARNRouletteWheelLayoutAttributes class]]) {
        ARNRouletteWheelLayoutAttributes *rouletteWheelLayoutAttributes = (ARNRouletteWheelLayoutAttributes *)layoutAttributes;
        self.layer.anchorPoint = rouletteWheelLayoutAttributes.anchorPoint;
        
        // update the Y center to reflect the anchor point
        CGPoint center = CGPointMake(self.center.x, self.center.y + ((rouletteWheelLayoutAttributes.anchorPoint.y - 0.5) * CGRectGetHeight(self.bounds)));
        self.center = center;
    }
}

@end
