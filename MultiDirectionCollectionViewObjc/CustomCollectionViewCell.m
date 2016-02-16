//
//  CustomCollectionViewCell.m
//  MultiDirectionCollectionViewObjc
//
//  Created by Kyle Andrews on 2/15/16.
//  Copyright © 2016 Kyle Andrews. All rights reserved.
//

#import "CustomCollectionViewCell.h"

@implementation CustomCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    [self setup];
    return self;
}


- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    [self setup];
    return self;
}

- (void) setup
{
    [self.layer setBorderWidth:1.0];
    [self.layer setBorderColor:[UIColor blackColor].CGColor];
    [self.layer setCornerRadius:5.0];
}

@end
