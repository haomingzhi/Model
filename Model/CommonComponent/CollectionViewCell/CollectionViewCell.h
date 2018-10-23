//
//  CollectionViewCell.h
//  yihui
//
//  Created by orange on 15/9/28.
//  Copyright (c) 2015年 ORANLLC_IOS1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectionViewCell : UICollectionViewCell
@property (strong, nonatomic) IBOutlet UIImageView *imgCell;
@property (strong, nonatomic) IBOutlet UIButton *deletadeBtn;
@property (strong, nonatomic) void (^deleBlock) (NSInteger item);
 - (IBAction)handleDeletede:(UIButton *)sender;

@end
