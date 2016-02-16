//
//  CustomCollectionViewController.m
//  MultiDirectionCollectionViewObjc
//
//  Created by Kyle Andrews on 2/15/16.
//  Copyright © 2016 Kyle Andrews. All rights reserved.
//

#import "CustomCollectionViewController.h"
#import "CustomCollectionViewCell.h"
#import "CustomCollectionViewLayout.h"

@implementation CustomCollectionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    CustomCollectionViewLayout *layout = (CustomCollectionViewLayout *)self.collectionViewLayout;
    layout.cellAttrsDictionary = [[NSMutableDictionary alloc] init];
    layout.contentSize = CGSizeZero;
    layout.dataSourceDidUpdate = YES;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    NSLog(@"numberOfSectionsInCollectionView %d", 50);
    return 50;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSLog(@"numberOfItemsInSection %d", 20);
    return 20;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"cellForItemAtIndexPath %@", indexPath);
    CustomCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"customCell" forIndexPath:indexPath];
    cell.label.text = [NSString stringWithFormat:@"Sec:%ld Item:%ld", (long)indexPath.section, (long)indexPath.item];
    return cell;
}

@end
