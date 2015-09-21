//
//  ARNRouletteWheelLayout.h
//  myVisit
//
//  Created by Stefan Arn on 04/09/15.
//  Copyright (c) 2015 Stefan Arn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ARNRouletteWheelLayout : UICollectionViewLayout

@property (nonatomic, assign) CGFloat radius;
@property (nonatomic, assign) CGFloat interItemSpacing;
@property (nonatomic, assign) CGSize itemSize;

@end
