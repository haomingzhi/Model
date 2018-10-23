//
//  TitleAndTimeTableViewCell.m
//  ulife
//
//  Created by air on 15/12/22.
//  Copyright © 2015年 ORANLLC_IOS1. All rights reserved.
//

#import "TitleAndTimeTableViewCell.h"

@implementation TitleAndTimeTableViewCell
{
    IBOutlet UILabel *_titleLb;

    IBOutlet UILabel *_timeLb;
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
    _timeLb.text = dataDic[@"time"];
    _titleLb.text = dataDic[@"title"];
    if ([_titleLb.text isEqualToString:@""]) {
        self.height = 40;
    }
    else
    {
    self.height = 60;
    }
}

@end
