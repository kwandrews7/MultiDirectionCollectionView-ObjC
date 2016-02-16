//
//  CustomCollectionViewLayout.h
//  MultiDirectionCollectionViewObjc
//
//  Created by Kyle Andrews on 2/15/16.
//  Copyright © 2016 Kyle Andrews. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomCollectionViewLayout : UICollectionViewLayout

@property (nonatomic, strong) NSMutableDictionary *cellAttrsDictionary;
@property (nonatomic) CGSize contentSize;
@property (nonatomic) BOOL dataSourceDidUpdate;

@end
