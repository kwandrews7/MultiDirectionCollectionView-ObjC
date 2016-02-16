//
//  CustomCollectionViewLayout.m
//  MultiDirectionCollectionViewObjc
//
//  Created by Kyle Andrews on 2/15/16.
//  Copyright © 2016 Kyle Andrews. All rights reserved.
//

#import "CustomCollectionViewLayout.h"

@implementation CustomCollectionViewLayout

static const double CELL_HEIGHT = 30.0;
static const double CELL_WIDTH = 100.0;

- (CGSize)collectionViewContentSize
{
    return self.contentSize;
}

- (void)prepareLayout
{
    // Only update header cells.
    if (!self.dataSourceDidUpdate) {

        // Determine current content offsets.
        CGFloat xOffset = self.collectionView.contentOffset.x;
        CGFloat yOffset = self.collectionView.contentOffset.y;

        if (self.collectionView.numberOfSections > 0) {
            for (int section = 0; section < self.collectionView.numberOfSections; section++) {

                // Confirm the section has items.
                if ([self.collectionView numberOfItemsInSection:section] > 0) {

                    // Update all items in the first row.
                    if (section == 0) {
                        for (int item = 0; item < [self.collectionView numberOfItemsInSection:section]; item++) {

                            // Build indexPath to get attributes from dictionary.
                            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:item inSection:section];

                            // Update y-position to follow user.
                            UICollectionViewLayoutAttributes *attrs = [self.cellAttrsDictionary objectForKey:indexPath];
                            if (attrs != nil) {
                                CGRect frame = attrs.frame;

                                // Also update x-position for corner cell.
                                if (item == 0) {
                                    frame.origin.x = xOffset;
                                }

                                frame.origin.y = yOffset;
                                attrs.frame = frame;
                            }

                        }

                        // For all other sections, we only need to update
                        // the x-position for the first item.
                    } else {

                        // Build indexPath to get attributes from dictionary.
                        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:section];

                        // Update y-position to follow user.
                        UICollectionViewLayoutAttributes *attrs = [self.cellAttrsDictionary objectForKey:indexPath];
                        if (attrs != nil) {
                            CGRect frame = attrs.frame;
                            frame.origin.x = xOffset;
                            attrs.frame = frame;
                        }
                        
                    }
                }
            }
        }

        // Do not run attribute generation code
        // unless data source has been updated.
        return;
    }

    // Acknowledge data source change, and disable for next time.
    self.dataSourceDidUpdate = NO;

    // Cycle through each section of the data source.
    if (self.collectionView.numberOfSections > 0) {
        for (int section = 0; section < self.collectionView.numberOfSections; section++) {

            // Cycle through each item in the section.
            if ([self.collectionView numberOfItemsInSection:section] > 0) {
                for (int item = 0; item < [self.collectionView numberOfItemsInSection:section]; item++) {

                    // Build the UICollectionViewLayoutAttribtues for the cell.
                    NSIndexPath *cellIndex = [NSIndexPath indexPathForItem:item inSection:section];
                    double xPos = item * CELL_WIDTH;
                    double yPos = section * CELL_HEIGHT;

                    UICollectionViewLayoutAttributes *cellAttributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:cellIndex];
                    cellAttributes.frame = CGRectMake(xPos, yPos, CELL_WIDTH, CELL_HEIGHT);

                    // Determine zIndex based on cell type.
                    if (section == 0 && item == 0) {
                        cellAttributes.zIndex = 4;
                    } else if (section == 0) {
                        cellAttributes.zIndex = 3;
                    } else if (item == 0) {
                        cellAttributes.zIndex = 2;
                    } else {
                        cellAttributes.zIndex = 1;
                    }

                    // Save the attributes.
                    [self.cellAttrsDictionary setObject:cellAttributes forKey:cellIndex];
                }
            }
        }
    }

    // Update content size.
    CGFloat contentWidth = [self.collectionView numberOfItemsInSection:0] * CELL_WIDTH;
    CGFloat contentHeight = self.collectionView.numberOfSections * CELL_HEIGHT;
    self.contentSize = CGSizeMake(contentWidth, contentHeight);
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSMutableArray<UICollectionViewLayoutAttributes *> *attributesInRect = [[NSMutableArray alloc] init];

    for (UICollectionViewLayoutAttributes *cellAttributes in self.cellAttrsDictionary.allValues) {
        if (CGRectIntersectsRect(rect, cellAttributes.frame)) {
            [attributesInRect addObject:cellAttributes];
        }
    }

    return attributesInRect;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return [[self cellAttrsDictionary] objectForKey:indexPath];
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}

@end
