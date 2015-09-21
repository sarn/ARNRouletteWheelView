# ARNRouletteWheelView

[![Version](https://img.shields.io/cocoapods/v/ARNRouletteWheelView.svg?style=flat)](http://cocoapods.org/pods/ARNRouletteWheelView)
[![License](https://img.shields.io/cocoapods/l/ARNRouletteWheelView.svg?style=flat)](http://cocoapods.org/pods/ARNRouletteWheelView)
[![Platform](https://img.shields.io/cocoapods/p/ARNRouletteWheelView.svg?style=flat)](http://cocoapods.org/pods/ARNRouletteWheelView)

## Overview

A custom UICollectionView layout which resembles a spinning roulette wheel. The cells are laid out on an invisible wheel and the wheel spins by scrolling horizontally. 

![](rouletteViewDemo.gif?raw=true "ARNRouletteWheelView in action")

This custom layout is based on the article by Rounak Jain. Thanks for the awesome article and work. The article is available here: http://www.raywenderlich.com/107687/uicollectionview-custom-layout-tutorial-spinning-wheel

## Usage

Add the <tt>ARNRouletteWheelView</tt> to your <tt>UIViewController</tt>, overwrite the default cell with your custom <tt>ARNRouletteWheelCell</tt> subclass and optionally tweak the settings like wheel radius, the spacing between items and the size of the items.

To have a full screen <tt>ARNRouletteWheelView</tt>:
```  objective-c
ARNRouletteWheelView *rouletteWheelView = [[ARNRouletteWheelView alloc] initWithFrame:self.view.frame];
rouletteWheelView.dataSource = self;

// overwrite default cell with a custom subcell
[rouletteWheelView registerClass:[ARNPosterCell class] forCellWithReuseIdentifier:@"ARNPosterCell"];

// custom settings
// [rouletteWheelView setRadius:2000.0f];
// [rouletteWheelView setInterItemSpacing:1.5f];
// [rouletteWheelView setItemSize:CGSizeMake(100.0f, 100.0f)];

[self.view addSubview:rouletteWheelView];
```

Your custom <tt>ARNRouletteWheelCell</tt> subclass could look like this:
```  objective-c
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
```

## Example Project

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

* ARC
* iOS7

## Installation

ARNRouletteWheelView is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "ARNRouletteWheelView"
```

## Author

Stefan Arn

## License

ARNRouletteWheelView is available under the MIT license. See the LICENSE file for more info.
