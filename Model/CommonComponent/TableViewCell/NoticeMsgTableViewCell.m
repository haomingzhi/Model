//
//  NoticeMsgTableViewCell.m
//  compassionpark
//
//  Created by air on 2017/3/16.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import "NoticeMsgTableViewCell.h"

@implementation NoticeMsgTableViewCell
{
    IBOutlet UIImageView *_markImgV;

    IBOutlet UILabel *_markLb;
    IBOutlet UILabel *_titleLb;
    IBOutlet UILabel *_lineLb;
    IBOutlet UIImageView *_tipImgV;
    IBOutlet UILabel *_detailLb;
    IBOutlet UILabel *_timeLb;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    [self modifiDeleteBtn];
}
-(void)setCellData:(NSDictionary *)dataDic
{
    _timeLb.text = dataDic[@"time"];
    _titleLb.text = dataDic[@"title"];
    _detailLb.text = dataDic[@"detail"];
    _tipImgV.image = [UIImage imageContentWithFileName:dataDic[@"tipImg"]];
    if ([dataDic[@"isShowMark"] boolValue]) {
        _markLb.hidden = NO;
    }
    else
    {
        _markLb.hidden = YES;
    }
}

-(void)fitMsgMode
{
    self.height = 90;
    self.backgroundColor = kUIColorFromRGB(color_4);
    _tipImgV.x = 15;
    _tipImgV.y = 2;
    _markLb.layer.cornerRadius = 3;
    _markLb.layer.masksToBounds = YES;
    _markLb.backgroundColor = kUIColorFromRGB(color_mainTheme);
    _markLb.x = 27;
    _markLb.y = 5;
    
    _lineLb.x = 0;
    _lineLb.y = 20;
    _lineLb.height = 0.5;
    _lineLb.width = __SCREEN_SIZE.width;
    _lineLb.backgroundColor = kUIColorFromRGB(color_mainTheme);
    
    _timeLb.width = 180;
    _timeLb.x = __SCREEN_SIZE.width - 15 - _timeLb.width;
    _timeLb.height = 14;
    _timeLb.y = 3;
    _timeLb.textAlignment = NSTextAlignmentRight;
    _timeLb.font = [UIFont systemFontOfSize:13];
    _timeLb.textColor = kUIColorFromRGB(color_8);
    
    _titleLb.width = __SCREEN_SIZE.width - 40;
    _titleLb.x = 15;
    _titleLb.y = 34;
    _titleLb.height = 16;
    _titleLb.font = [UIFont systemFontOfSize:15];
    _titleLb.textColor = kUIColorFromRGB(color_1);
    
    _detailLb.x = _titleLb.x;
    _detailLb.width = _titleLb.width;
    _detailLb.height = _detailLb.height;
    _detailLb.y = _titleLb.y + _titleLb.height + 8;
    _detailLb.textColor = kUIColorFromRGB(color_8);
    _detailLb.font = [UIFont systemFontOfSize:15];
    
    _markImgV.width = 7.5;
    _markImgV.height = 13.5;
    _markImgV.image = [UIImage imageContentWithFileName:@"icon_arrow_right"];
    _markImgV.x = __SCREEN_SIZE.width - 15 - _markImgV.width;
    _markImgV.y = (self.height - 20)/2.0 - _markImgV.height/2.0 + 20;
}


@end
