//
//  ARNRouletteWheelLayoutAttributes.m
//  myVisit
//
//  Created by Stefan Arn on 11/09/15.
//  Copyright (c) 2015 Stefan Arn. All rights reserved.
//

#import "ARNRouletteWheelLayoutAttributes.h"

@implementation ARNRouletteWheelLayoutAttributes

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
// set default values
- (void)setup
{
    _anchorPoint = CGPointMake(0.5f, 0.5f); // the point which all rotations and scaling transforms take place
    _angle = 0.0f; // the views specific angle
}


#pragma mark -
#pragma mark setters and getters

- (void)setAngle:(CGFloat)angle {
    _angle = angle;
    
    // cells on the right overlap left ones
    // Since angle is expressed in radians, we amplify its value by 1'000'000
    // to ensure that adjacent values don’t get rounded up to the same value of zIndex
    self.zIndex = roundf(_angle * 1000000);
    
    // rotate the view itself
    self.transform = CGAffineTransformMakeRotation(_angle);
}


#pragma mark -
#pragma mark conformity

- (id)copyWithZone:(NSZone *)zone {
    id obj = [super copyWithZone:zone];
    if (obj != nil && [obj isKindOfClass:[ARNRouletteWheelLayoutAttributes class]]) {
        ARNRouletteWheelLayoutAttributes *rouletteWheelLayoutAttributesCopy = (ARNRouletteWheelLayoutAttributes *) obj;
        rouletteWheelLayoutAttributesCopy.anchorPoint = self.anchorPoint;
        rouletteWheelLayoutAttributesCopy.angle = self.angle;
        return rouletteWheelLayoutAttributesCopy;
    } else {
        return obj;
    }
}

- (BOOL)isEqual:(id)object {
    if (object == self) {
        return YES;
    }
    
    if(![super isEqual:object]) {
        return NO;
    }
    
    if ([object isKindOfClass:[ARNRouletteWheelLayoutAttributes class]]) {
        ARNRouletteWheelLayoutAttributes *rouletteWheelLayoutAttributes = (ARNRouletteWheelLayoutAttributes *)object;
        
        if (CGPointEqualToPoint(self.anchorPoint, rouletteWheelLayoutAttributes.anchorPoint) &&
            self.angle == rouletteWheelLayoutAttributes.angle) {
            return YES;
        }
    }
    
    return NO;
}

@end
