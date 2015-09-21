//
//  ARNPosterCell.m
//  myVisit
//
//  Created by Stefan Arn on 04/09/15.
//  Copyright (c) 2015 Stefan Arn. All rights reserved.
//

#import "ARNPosterCell.h"

@interface ARNPosterCell ()
    @property (nonatomic, strong) UIImageView *imageView;
@end

@implementation ARNPosterCell

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        _imageView.clipsToBounds = YES;
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        [self.contentView addSubview:_imageView];
    }
    return self;
}

- (void)setImage:(UIImage *)image {
    if (image != nil) {
        [self.imageView setImage:image];
    }
}

@end
