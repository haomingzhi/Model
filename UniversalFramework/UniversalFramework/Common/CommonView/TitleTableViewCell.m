//
//  PayWayTitleTableViewCell.m
//  ChaoLiu
//
//  Created by air on 15/7/21.
//  Copyright (c) 2015年 ORANLLC_IOS1. All rights reserved.
//

#import "TitleTableViewCell.h"

@implementation TitleTableViewCell
{

    IBOutlet UILabel *_titleLb;
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setCellData:(NSDictionary *)dataDic
{
    [super setCellData:dataDic];
    _titleLb.text = dataDic[TitleTableViewCell_title];
}
@end
