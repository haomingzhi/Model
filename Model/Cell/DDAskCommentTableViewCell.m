//
//  DDAskCommentTableViewCell.m
//  NIM
//
//  Created by apple on 2018/7/31.
//  Copyright © 2018年 Netease. All rights reserved.
//

#import "DDAskCommentTableViewCell.h"
#import "UIView+NTES.h"
#import "UIImageView+WebCache.h"
@interface DDAskCommentTableViewCell()
@property(nonatomic,strong)UIImageView *imgV;
@property(nonatomic,strong)UILabel *nameLb;
@property(nonatomic,strong)UILabel *infoLb;
@property(nonatomic,strong)UIButton *cBtn;
@property(nonatomic,strong)UIButton *fBtn;
@property(nonatomic,strong)UILabel *titleLb;
@property(nonatomic,strong)UILabel *timeLb;
@property(nonatomic,strong)UIImageView *goodMarkImgV;
@property(nonatomic,strong)UIButton *btn;
@property(nonatomic,strong)NSDictionary *dataDic;
@end

@implementation DDAskCommentTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.titleLb];
        [self.contentView addSubview:self.imgV];
        [self.contentView addSubview:self.nameLb];
        [self.contentView addSubview:self.infoLb];
        [self.contentView addSubview:self.cBtn];
        [self.contentView addSubview:self.fBtn];
        [self.contentView addSubview:self.titleLb];
        [self.contentView addSubview:self.btn];
         [self.contentView addSubview:self.goodMarkImgV];
      [self.contentView addSubview:self.timeLb];
        
    }
    return self;
}

 - (void)refresh:(NSDictionary *)dic
{
    _dataDic = dic;
    self.nameLb.text = dic[@"name"];
    self.infoLb.text = dic[@"info"];
    [self.imgV sd_setImageWithURL:[NSURL URLWithString:dic[@"imgUrl"]] placeholderImage:[UIImage imageNamed:dic[@"img"]]];
    self.timeLb.text = dic[@"time"];
    self.titleLb.text = dic[@"title"];
    [_cBtn setImageEdgeInsets:UIEdgeInsetsMake(2, 0, 2, 32)];
    [_fBtn setImageEdgeInsets:UIEdgeInsetsMake(2, 0, 2, 32)];
    [_cBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -16, 0, 0)];
    [_fBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -16, 0, 0)];
    [_cBtn setImage:[UIImage imageNamed:@"评论"] forState:UIControlStateNormal];
    [_fBtn setImage:[UIImage imageNamed:@"点赞"] forState:UIControlStateNormal];
    [_cBtn setTitle:dic[@"cCount"] forState:UIControlStateNormal];
    [_fBtn setTitle:dic[@"fCount"] forState:UIControlStateNormal];
    _goodMarkImgV.image = [UIImage imageNamed:@"最佳回复"];
    [_btn setTitle:@"设为最佳" forState:UIControlStateNormal];
    [self setNeedsLayout];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    NSInteger top = 17;
    if ([_dataDic[@"mode"] integerValue] == 0) {
        top = 35;
        _goodMarkImgV.hidden = NO;
        _btn.hidden = YES;
    }
    else if ([_dataDic[@"mode"] integerValue] == 1)
    {
        top = 17;
        _goodMarkImgV.hidden = YES;
        _btn.hidden = YES;
    }
    else if ([_dataDic[@"mode"] integerValue] == 2)
    {
        top = 35;
        _goodMarkImgV.hidden = YES;
        _btn.hidden = NO;
    }
    else
    {
        top = 17;
        _goodMarkImgV.hidden = YES;
        _btn.hidden = NO;
    }
    
    _imgV.height = 35;
    _imgV.width = 35;
    _imgV.top = top;
    _imgV.left = 18;
    _imgV.layer.cornerRadius = _imgV.height/2.0;
    _imgV.layer.masksToBounds = YES;
    
    _nameLb.width = 200;
    _nameLb.height = 20;
    _nameLb.textColor = UIColorFromRGB(0x3A424D);
    _nameLb.font = [UIFont systemFontOfSize:12];
    _nameLb.left = 10 + _imgV.left + _imgV.width;
    _nameLb.top = _imgV.top;
    
    _infoLb.left = _nameLb.left;
    _infoLb.width = self.width - _infoLb.left - 18;
    _infoLb.height = 16.5;
    _infoLb.textColor = UIColorFromRGB(0xA2A3A7);
    _infoLb.font = [UIFont systemFontOfSize:12];
    _infoLb.top = 1 + _nameLb.top + _nameLb.height;
    
    _goodMarkImgV.height = 70;
    _goodMarkImgV.width = 70;
    _goodMarkImgV.layer.cornerRadius = _goodMarkImgV.height/2.0;
    _goodMarkImgV.layer.masksToBounds = YES;
    _goodMarkImgV.left = self.width - 18 - _goodMarkImgV.width;
    _goodMarkImgV.top = 3;
    
    _btn.width = 60;
    _btn.height = 18;
    _btn.layer.cornerRadius = 6;
    _btn.layer.borderColor = UIColorFromRGB(0x20A0FF).CGColor;
    _btn.layer.borderWidth = 0.5;
    _btn.left = self.width - 18 - _btn.width;
    _btn.top = _infoLb.top - 3;
    _btn.titleLabel.font = [UIFont systemFontOfSize:11];
    [_btn setTitleColor:UIColorFromRGB(0x20A0FF) forState:UIControlStateNormal];
    
    _titleLb.width = self.width - 36;
    _titleLb.height = 10000000000;
    _titleLb.numberOfLines = 0;
    _titleLb.font = [UIFont systemFontOfSize:16];
    _titleLb.textColor = UIColorFromRGB(0x3A424D);
    [_titleLb sizeToFit];
    _titleLb.left = 18;
    _titleLb.top = 27 + _imgV.height + _imgV.top;
    
    _timeLb.width = 120;
    _timeLb.height = 22;
    _timeLb.font = [UIFont systemFontOfSize:12];
    _timeLb.textColor = UIColorFromRGB(0xA2A3A7);
    _timeLb.left = 18;
    _timeLb.top = 42 + _titleLb.top + _titleLb.height;
    
    _fBtn.width = 50;
    _fBtn.height = 22;
    _fBtn.top = _timeLb.top;
    _fBtn.left = self.width - 18 - _fBtn.width;
    
    _cBtn.width = 50;
    _cBtn.height = 22;
    _cBtn.top = _timeLb.top;
    _cBtn.left = _fBtn.left - 8 - _cBtn.width;
    
    self.height = 26 + _timeLb.height + _timeLb.top;
}

-(UIImageView*)imgV
{
    if (!_imgV) {
        _imgV = [UIImageView new];
    }
    return _imgV;
}

-(UILabel *)nameLb
{
    if (!_nameLb) {
        _nameLb = [UILabel new];
    }
    return _nameLb;
}

-(UILabel *)infoLb
{
    if (!_infoLb) {
        _infoLb = [UILabel new];
    }
    return _infoLb;
}

-(UILabel *)titleLb
{
    if (!_titleLb) {
        _titleLb = [UILabel new];
    }
    return _titleLb;
}
-(UILabel *)timeLb
{
    if (!_timeLb) {
        _timeLb = [UILabel new];
    }
    return _timeLb;
}
-(UIButton *)cBtn
{
    if (!_cBtn) {
        _cBtn = [UIButton new];
          _cBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        _cBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [_cBtn setTitleColor:UIColorFromRGB(0xA2A3A7) forState:UIControlStateNormal];
    }
    return _cBtn;
}

-(UIButton *)fBtn
{
    if (!_fBtn) {
        _fBtn = [UIButton new];
          _fBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        _fBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [_fBtn setTitleColor:UIColorFromRGB(0xA2A3A7) forState:UIControlStateNormal];
    }
    return _fBtn;
}

-(UIButton *)btn
{
    if (!_btn) {
        _btn = [UIButton new];
    }
    return _btn;
}

-(UIImageView *)goodMarkImgV
{
    if (!_goodMarkImgV) {
        _goodMarkImgV = [UIImageView new];
    }
    return _goodMarkImgV;
}
@end
