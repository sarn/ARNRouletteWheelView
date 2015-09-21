//
//  ARNViewController.m
//  ARNRouletteWheelView
//
//  Created by Stefan Arn on 09/19/2015.
//  Copyright (c) 2015 Stefan Arn. All rights reserved.
//

#import "ARNViewController.h"
#import <ARNRouletteWheelView/ARNRouletteWheelView.h>
#import "ARNPosterCell.h"

@interface ARNViewController ()

@property (nonatomic, strong) ARNRouletteWheelView *rouletteWheelView;
@property (nonatomic, strong) NSArray *testDataArray;

@end

@implementation ARNViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    _testDataArray = [NSArray arrayWithObjects:
                      [UIImage imageNamed:@"01.jpg"],
                      [UIImage imageNamed:@"02.jpg"],
                      [UIImage imageNamed:@"03.jpg"],
                      [UIImage imageNamed:@"04.jpg"],
                      [UIImage imageNamed:@"05.jpg"],
                      [UIImage imageNamed:@"06.jpg"],
                      [UIImage imageNamed:@"07.jpg"],
                      [UIImage imageNamed:@"08.jpg"],
                      [UIImage imageNamed:@"09.jpg"],
                      [UIImage imageNamed:@"10.jpg"],
                      [UIImage imageNamed:@"11.jpg"],
                      [UIImage imageNamed:@"12.jpg"],
                      [UIImage imageNamed:@"13.jpg"],
                      [UIImage imageNamed:@"14.jpg"],
                      [UIImage imageNamed:@"15.jpg"],
                      [UIImage imageNamed:@"16.jpg"],
                      [UIImage imageNamed:@"17.jpg"],
                      [UIImage imageNamed:@"18.jpg"],
                      [UIImage imageNamed:@"19.jpg"],
                      [UIImage imageNamed:@"20.jpg"],
                      [UIImage imageNamed:@"21.jpg"],
                      [UIImage imageNamed:@"22.jpg"],
                      [UIImage imageNamed:@"23.jpg"],
                      [UIImage imageNamed:@"24.jpg"],
                      nil];
    
    self.rouletteWheelView = [[ARNRouletteWheelView alloc] initWithFrame:self.view.frame];
    self.rouletteWheelView.dataSource = self;
    
    // overwrite default cell with a custom subcell
    [self.rouletteWheelView registerClass:[ARNPosterCell class] forCellWithReuseIdentifier:@"ARNPosterCell"];
    
    // custom settings
    // [self.rouletteWheelView setRadius:2000.0f];
    // [self.rouletteWheelView setInterItemSpacing:1.5f];
    // [self.rouletteWheelView setItemSize:CGSizeMake(100.0f, 100.0f)];
    
    [self.view addSubview:self.rouletteWheelView];
}

# pragma mark -
# pragma mark UICollectionViewDataSource methods

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.testDataArray count];
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    // Setup cell identifier
    static NSString *cellIdentifier = @"ARNPosterCell";
    ARNPosterCell *cell = (ARNPosterCell *)[collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    // customize cell
    [cell setImage:[self.testDataArray objectAtIndex:indexPath.row]];
    
    return cell;
}

- (void)dealloc {
    self.rouletteWheelView.dataSource = nil;
}

@end
