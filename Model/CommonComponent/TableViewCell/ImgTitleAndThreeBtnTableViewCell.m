//
//  ImgTitleAndThreeBtnTableViewCell.m
//  oranllcshoping
//
//  Created by air on 2017/7/28.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import "ImgTitleAndThreeBtnTableViewCell.h"

@implementation ImgTitleAndThreeBtnTableViewCell
{

    IBOutlet UIImageView *_imgV;
    IBOutlet UILabel *_titleLb;
    IBOutlet UIButton *_aBtn;
    IBOutlet UIButton *_bBtn;
    IBOutlet UIButton *_cBtn;
    NSDictionary *_dataDic;
    IBOutlet UIView *_containerView;
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
    _dataDic = dataDic;
    _imgV.image = [UIImage imageContentWithFileName:_dataDic[@"img"]];
    _titleLb.text = _dataDic[@"title"];
    [_aBtn setTitle:_dataDic[@"aTitle"] forState:UIControlStateNormal];
    [_bBtn setTitle:_dataDic[@"bTitle"] forState:UIControlStateNormal];
    [_cBtn setTitle:_dataDic[@"cTitle"] forState:UIControlStateNormal];
}

-(void)fitAttentionMode
{
    self.height = 75;
    _containerView.height = 65;
    _containerView.width = __SCREEN_SIZE.width;
    UIView *line = [self.contentView viewWithTag:999];
    if (!line) {
         line  = [[UIView alloc] initWithFrame:CGRectMake(0, 0, __SCREEN_SIZE.width, 0.5)];
        line.tag = 999;
    }
    line.y = 10;
    line.backgroundColor = kUIColorFromRGB(color_lineColor);
    [self.contentView addSubview:line];
    self.contentView.backgroundColor = kUIColorFromRGB(color_0xf0f0f0);
    _containerView.backgroundColor = kUIColorFromRGB(color_2);
    _imgV.height = 39;
    _imgV.width = 39;
    _imgV.x = 15;
    _imgV.y = 13;
    
    _titleLb.x = _imgV.width + _imgV.x + 10;
    _titleLb.y = 10;
    _titleLb.height = 15;
    _titleLb.width = _containerView.width - 100 - _titleLb.x;
    
    _aBtn.y = _titleLb.y + _titleLb.height;
    _aBtn.x = _imgV.width + _imgV.x + 10;
     [self setFitBtnMode:_aBtn];
     [self setFitBtnMode:_bBtn];
   
    
    _cBtn.width = 80;
    _cBtn.height = 31;
   
     _cBtn.layer.cornerRadius = 4;
    _cBtn.y = 17;
    _cBtn.x = _containerView.width - 15 - _cBtn.width;
     
     _bBtn.y = _titleLb.y + _titleLb.height;
     _bBtn.x =_aBtn.x + _aBtn.width + 8;
     if ([_cBtn.titleLabel.text isEqualToString:@"已关注"]) {
          _cBtn.backgroundColor = kUIColorFromRGB(color_3);
          [_cBtn setTitleColor:kUIColorFromRGB(color_2) forState:UIControlStateNormal];
          _cBtn.titleLabel.font = [UIFont systemFontOfSize:13];
     }
     else
     {
          _cBtn.backgroundColor = kUIColorFromRGB(color_0xb0b0b0);
          [_cBtn setTitleColor:kUIColorFromRGB(color_2) forState:UIControlStateNormal];
          _cBtn.titleLabel.font = [UIFont systemFontOfSize:13];
     }
}

-(void)fitAttentionModeB
{
     self.height = 75;
     _containerView.height = 65;
     _containerView.width = __SCREEN_SIZE.width;
     UIView *line = [self.contentView viewWithTag:999];
     if (!line) {
          line  = [[UIView alloc] initWithFrame:CGRectMake(0, 0, __SCREEN_SIZE.width, 0.5)];
          line.tag = 999;
     }
     line.y = 10;
     line.backgroundColor = kUIColorFromRGB(color_lineColor);
     [self.contentView addSubview:line];
     self.contentView.backgroundColor = kUIColorFromRGB(color_0xf0f0f0);
     _containerView.backgroundColor = kUIColorFromRGB(color_2);
     _imgV.height = 39;
     _imgV.width = 39;
     _imgV.x = 15;
     _imgV.y = 13;
     
     _titleLb.x = _imgV.width + _imgV.x + 10;
     _titleLb.y = 10;
     _titleLb.height = 15;
     _titleLb.width = _containerView.width - 100 - _titleLb.x;
     
     _aBtn.y = _titleLb.y + _titleLb.height;
     _aBtn.x = _imgV.width + _imgV.x;
     [self setFitBtnMode:_aBtn withTitle:_dataDic[@"aTitle"] withImg:_dataDic[@"aimg"]];
     [self setFitBtnMode:_bBtn withTitle:_dataDic[@"bTitle"] withImg:_dataDic[@"bimg"]];

     
     _cBtn.width = 80;
     _cBtn.height = 31;
     
     _cBtn.layer.cornerRadius = 4;
     _cBtn.y = 17;
     _cBtn.x = _containerView.width - 15 - _cBtn.width;
     
     _bBtn.y = _titleLb.y + _titleLb.height;
     _bBtn.x =_aBtn.x + _aBtn.width + 8;
     if ([_cBtn.titleLabel.text isEqualToString:@"已关注"]) {
          _cBtn.backgroundColor = kUIColorFromRGB(color_3);
          [_cBtn setTitleColor:kUIColorFromRGB(color_2) forState:UIControlStateNormal];
          _cBtn.titleLabel.font = [UIFont systemFontOfSize:13];
     }
     else
     {
          _cBtn.backgroundColor = kUIColorFromRGB(color_0xb0b0b0);
          [_cBtn setTitleColor:kUIColorFromRGB(color_2) forState:UIControlStateNormal];
          _cBtn.titleLabel.font = [UIFont systemFontOfSize:13];
     }
}



-(void)fitFansMode
{
     [self fitAttentionMode];
}


-(void)setFitBtnMode:(UIButton *)btn //withTitle:(NSString *)title
{
    btn.height = 34;
    btn.width =  100;
     btn.titleLabel.font = [UIFont systemFontOfSize:13];
     [btn setTitleColor:kUIColorFromRGB(color_0xb0b0b0) forState:UIControlStateNormal];
    [btn sizeToFit];
}

-(void)setFitBtnMode:(UIButton *)btn  withTitle:(NSString *)title withImg:(NSString *)img
{
     btn.height = 34;
     btn.width =  58;
     [btn fitImgAndTitleMode];
     btn.customImgV.width = 14;
     btn.customImgV.height = 16;
     btn.customImgV.x = 8;
     btn.customImgV.y = 11;
     btn.customImgV.image = [UIImage imageContentWithFileName:img];
     btn.customImgV.contentMode = UIViewContentModeCenter;
     
     btn.customTitleLb.y = 11;
     btn.customTitleLb.width = 32;
     btn.customTitleLb.height = 13;
     btn.customTitleLb.x = btn.customImgV.x + btn.customImgV.width + 8;
     btn.customTitleLb.textColor = kUIColorFromRGB(color_0xb0b0b0);
     btn.customTitleLb.font = [UIFont systemFontOfSize:13];
     btn.customTitleLb.text = title;
}

@end
