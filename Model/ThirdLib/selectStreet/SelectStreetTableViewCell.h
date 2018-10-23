//
//  SelectStreetTableViewCell.h
//  chenxiaoer
//
//  Created by sunmax on 16/3/17.
//  Copyright © 2016年 ORANLLC_IOS1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectStreetTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *geograhicalNames;//地区名称
@property (weak, nonatomic) IBOutlet UILabel *street;//街道
@property (weak, nonatomic) IBOutlet UIImageView *img;

-(void)setCell:(NSString *)geograhicalNames street:(NSString *)street;

@end
