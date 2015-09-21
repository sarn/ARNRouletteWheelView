//
//  ARNRouletteWheelView.h
//  myVisit
//
//  Created by Stefan Arn on 04/09/15.
//  Copyright (c) 2015 Stefan Arn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ARNRouletteWheelView : UICollectionView

- (void)setup;
- (UICollectionViewLayout *)rouletteLayout;

- (void)setRadius:(CGFloat)radius;
- (void)setInterItemSpacing:(CGFloat)interItemSpacing;
- (void)setItemSize:(CGSize)itemSize;

@end
