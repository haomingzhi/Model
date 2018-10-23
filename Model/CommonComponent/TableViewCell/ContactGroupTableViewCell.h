//
//  ContactGroupTableViewCell.h
//  yihui
//
//  Created by orange on 15/10/19.
//  Copyright (c) 2015年 ORANLLC_IOS1. All rights reserved.
//

#import <UIKit/UIKit.h>
#
@interface ContactGroupTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *logoImage;
@property (strong, nonatomic) IBOutlet UIImageView *selectImage;
@property (strong, nonatomic) IBOutlet UILabel *name;
@property (strong, nonatomic) IBOutlet UILabel *content;
@property (strong, nonatomic) IBOutlet UIButton *contactBtn;
@property (nonatomic, strong) void (^contactGroupBlock) (BOOL select);
- (IBAction)handleClick:(UIButton *)sender;

-(void)setCellData:(NSDictionary *)dic;
@end
