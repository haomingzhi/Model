//
//  BlankTableViewCell.m
//  lovecommunity
//
//  Created by air on 16/6/13.
//  Copyright © 2016年 ORANLLC_IOS1. All rights reserved.
//

#import "BlankTableViewCell.h"

@implementation BlankTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)fitModiPwdMode
{
    self.height = 15;
    self.backgroundColor = kUIColorFromRGB(color_4);
}
@end
