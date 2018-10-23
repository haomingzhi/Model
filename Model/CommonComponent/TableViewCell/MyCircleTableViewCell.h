//
//  MyCircleTableViewCell.h
//  yihui
//
//  Created by orange on 15/9/24.
//  Copyright (c) 2015年 ORANLLC_IOS1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyCircleTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *logoImage;
@property (strong, nonatomic) IBOutlet UIImageView *selectImage;
@property (strong, nonatomic) IBOutlet UILabel *name;
@property (strong, nonatomic) IBOutlet UILabel *content;
@property (strong, nonatomic) IBOutlet UILabel *time;
-(void)setCellData:(NSDictionary *)dic;
@end
