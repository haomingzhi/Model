//
//  MsgTableViewCell.m
//  taihe
//
//  Created by air on 2016/11/8.
//  Copyright © 2016年 ORANLLC_IOS1. All rights reserved.
//

#import "MsgTableViewCell.h"

@implementation MsgTableViewCell
{
    IBOutlet UILabel *_timeLb;
    IBOutlet UILabel *_titleLb;

}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setCellData:(NSDictionary *)dataDic
{
    _titleLb.text = dataDic[@"title"];
    _timeLb.text = dataDic[@"time"];
}

-(void)fitMsgMode
{
    _titleLb.y = 15;
    _titleLb.x = 15;
    _titleLb.width = __SCREEN_SIZE.width - 30;
    _titleLb.height = 50;
    _titleLb.font = [UIFont systemFontOfSize:15];
    _titleLb.textColor = kUIColorFromRGB(0x222222);
    _titleLb.numberOfLines = 2;
    [_titleLb sizeToFit];
    
    _timeLb.width = 140;
    _timeLb.height = 14;
    _timeLb.font = [UIFont systemFontOfSize:13];
    _timeLb.textColor = kUIColorFromRGB(color_6);
    _timeLb.textAlignment = NSTextAlignmentRight;
    _timeLb.x = __SCREEN_SIZE.width - 15 - _timeLb.width;
    _timeLb.y = 90 - 15 - _timeLb.height;
}

@end
