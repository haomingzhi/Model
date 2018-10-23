//
//  TipImgAndTitleTableViewCell.m
//  yihui
//
//  Created by air on 15/8/31.
//  Copyright (c) 2015年 ORANLLC_IOS1. All rights reserved.
//

#import "TipImgAndTitleTableViewCell.h"

@implementation TipImgAndTitleTableViewCell
{
  UILabel *_cpTitleLb;
    IBOutlet UILabel *_titleDetailLb;
    IBOutlet UILabel *_titleLb;
    IBOutlet UIImageView *_tipImgV;
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
    _titleLb.text = dataDic[@"title"];
    _titleDetailLb.text = dataDic[@"detail"];
    _tipImgV.image = [UIImage imageNamed:dataDic[@"img"]];
    if (dataDic[@"titleFont"]) {
        _titleLb.font = dataDic[@"titleFont"];
    }
    if (dataDic[@"titleColor"]) {
        _titleLb.textColor = dataDic[@"titleColor"];
    }
    if (dataDic[@"detailColor"]) {
        _titleDetailLb.textColor = dataDic[@"detailColor"];
    }
    [super setCellData:dataDic];
}

-(void)fitHeadMode
{
    self.height = 36;
    _tipImgV.x = 15;
    _tipImgV.y = self.height/2.0 - _tipImgV.height/2.0;
     _titleLb.font = [UIFont systemFontOfSize:14];
    _titleLb.y = self.height/2.0 - _titleLb.height/2.0;
    _titleLb.x = _tipImgV.x + _tipImgV.width + 10;
    CGSize sz = [_titleLb.text size:_titleLb.font constrainedToSize:CGSizeMake(10000, 16)];
    _titleLb.width = sz.width;
    _titleDetailLb.hidden = YES;
    _cpTitleLb = [self.contentView viewWithTag:921];
    if (!_cpTitleLb) {
        _cpTitleLb = [UILabel new];
        
        _cpTitleLb.tag = 921;
     
      
    }
    _cpTitleLb.width = _titleLb.width;
    _cpTitleLb.height = _titleLb.height;
    _cpTitleLb.y = _titleLb.y;
    _cpTitleLb.font = _titleLb.font;
    _cpTitleLb.textColor = _titleLb.textColor;

       _cpTitleLb.x = (_titleLb.width + 15 +_titleLb.x);
      [self.contentView addSubview:_cpTitleLb];
    _cpTitleLb.text = _titleLb.text;
    UIView *v = [self.contentView viewWithTag:8765];
    if (!v) {
        v = [UIView new];
        v.tag = 8765;
    }
    v.x = 0;
    v.y = 0;
    v.height = 35;
    v.width = 38;
    v.backgroundColor = kUIColorFromRGB(color_2);
    [self.contentView addSubview:v];
    [self.contentView bringSubviewToFront:_tipImgV];
     if(_titleLb.width > __SCREEN_SIZE.width - 15)
     {
         _cpTitleLb.hidden = NO;
     }
    else
    {
        _cpTitleLb.hidden = YES;
    }
}

-(UILabel *)getTextLb
{
    return _titleLb;
}

-(UILabel *)getCTextLb
{
    return _cpTitleLb;
}

@end
