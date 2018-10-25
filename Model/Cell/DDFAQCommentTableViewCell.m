//
//  DDFAQCommentTableViewCell.m
//  NIM
//
//  Created by apple on 2018/7/31.
//  Copyright © 2018年 Netease. All rights reserved.
//

#import "DDFAQCommentTableViewCell.h"
#import "UIView+NTES.h"
#import "UIImageView+WebCache.h"
@interface DDFAQCommentTableViewCell()
@property(nonatomic,strong)UIImageView *imgV;
@property(nonatomic,strong)UILabel *nameLb;
@property(nonatomic,strong)UILabel *infoLb;
@property(nonatomic,strong)UIImageView *starImgV;
@property(nonatomic,strong)UIButton *cBtn;
@property(nonatomic,strong)UIButton *fBtn;
@property(nonatomic,strong)UILabel *titleLb;
@property(nonatomic,strong)UILabel *rTitleLb;//回复的内容
@property(nonatomic,strong)UIView *rV;
@property(nonatomic,strong)NSDictionary *dataDic;
@end

@implementation DDFAQCommentTableViewCell
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
        [self.contentView addSubview:self.rV];
        [self.rV addSubview:self.rTitleLb];
        
    }
    return self;
}

- (void)refresh:(NSDictionary *)dic{
    _dataDic = dic;
    _titleLb.text = dic[@"title"];
    [_imgV sd_setImageWithURL:[NSURL URLWithString:dic[@"imgUrl"]] placeholderImage:[UIImage imageNamed:dic[@"img"]]];
    _rTitleLb.text = dic[@"rTitle"];
    _nameLb.text = dic[@"name"];
    _infoLb.text = dic[@"info"];
    [_cBtn setImageEdgeInsets:UIEdgeInsetsMake(2, 0, 2, 32)];
     [_fBtn setImageEdgeInsets:UIEdgeInsetsMake(2, 0, 2, 32)];
    [_cBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -16, 0, 0)];
     [_fBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -16, 0, 0)];
    [_cBtn setImage:[UIImage imageNamed:@"评论"] forState:UIControlStateNormal];
     [_fBtn setImage:[UIImage imageNamed:@"点赞"] forState:UIControlStateNormal];
    [_cBtn setTitle:dic[@"cCount"] forState:UIControlStateNormal];
    [_fBtn setTitle:dic[@"fCount"] forState:UIControlStateNormal];
    [self setNeedsLayout];
}


 -(void)layoutSubviews
{
    [super layoutSubviews];
    _imgV.height = 29;
    _imgV.width = 29;
    _imgV.top = 30;
    _imgV.left = 18;
    _imgV.layer.cornerRadius = _imgV.height/2.0;
    _imgV.layer.masksToBounds = YES;
    
    _nameLb.left = 8 + _imgV.left + _imgV.width;
    _nameLb.top = 28;
    _nameLb.width = 120;
    _nameLb.height = 16.5;
    _nameLb.textColor = UIColorFromRGB(0x3A424D);
    _nameLb.font = [UIFont systemFontOfSize:12];
    [_nameLb sizeToFit];
    
    _starImgV.width = 12;
    _starImgV.height = 12;
    _starImgV.left = _nameLb.left + _nameLb.width;
    _starImgV.top = _nameLb.top;
    
    _infoLb.left = _nameLb.left;
    _infoLb.top = _nameLb.top + _nameLb.height + 2;
    _infoLb.height = 15;
    _infoLb.width = 150;
    _infoLb.textColor = UIColorFromRGB(0xA2A3A7);
    _infoLb.font = [UIFont systemFontOfSize:11];
    
    _fBtn.width = 50;
    _fBtn.height = 22;
    _fBtn.top = _nameLb.top + 5;
    _fBtn.left = self.width - 18 - _fBtn.width;
    
    _cBtn.width = 50;
    _cBtn.height = 22;
    _cBtn.top = _nameLb.top + 5;
    _cBtn.left = _fBtn.left - 8 - _cBtn.width;
    
    _titleLb.width = self.width - 36;
    _titleLb.height = 1000000;
    _titleLb.left = 18;
     _titleLb.font = [UIFont systemFontOfSize:14];
    _titleLb.top = 7 + _imgV.top + _imgV.height;
    [_titleLb sizeToFit];
    
    _rV.width = self.width - 36;
    _rV.left = 18;
    _rV.top = 8 + _titleLb.height + _titleLb.top;
    _rV.layer.cornerRadius = 9;
    _rV.layer.masksToBounds = YES;
    _rV.backgroundColor = UIColorFromRGB(0xF5F5F5);
    
    _rTitleLb.width = _rV.width - 20;
    _rTitleLb.textColor = UIColorFromRGB(0xA2A3A7);
    _rTitleLb.top = 6;
    _rTitleLb.left = 10;
    _rTitleLb.height = 100000000;
    _rTitleLb.font = [UIFont systemFontOfSize:12];
    [_rTitleLb sizeToFit];
   
    _rV.height = _rTitleLb.height + _rTitleLb.top + 7;
    if (!_dataDic[@"rTitle"]||[_dataDic[@"rTitle"] isEqualToString:@""]) {
        _rV.hidden = YES;
        self.height = _titleLb.height + _titleLb.top + 23;
        _rTitleLb.attributedText = nil;
    }
    else
    {
        _rV.hidden = NO;
        self.height = _rV.height + _rV.top + 26;
        NSString *rName = _dataDic[@"rName"];
        NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:_rTitleLb.text];
        [attrStr addAttribute:NSForegroundColorAttributeName
                        value:UIColorFromRGB(0xA2A3A7)
                        range:NSMakeRange(0, attrStr.length)];
        [attrStr addAttribute:NSForegroundColorAttributeName
                        value:UIColorFromRGB(0x20A0FF)
                        range:NSMakeRange(0, rName.length)];
        _rTitleLb.attributedText = attrStr;
    }
}

-(UILabel*)nameLb
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

-(UIImageView *)imgV
{
    if (!_imgV) {
        _imgV = [UIImageView new];
        
    }
    return _imgV;
}

-(UILabel *)rTitleLb
{
    if (!_rTitleLb) {
        _rTitleLb = [UILabel new];
        _rTitleLb.numberOfLines = 0;
    }
    return _rTitleLb;
}

-(UILabel *)titleLb
{
    if (!_titleLb) {
        _titleLb = [UILabel new];
        _titleLb.numberOfLines = 0;
    }
    return _titleLb;
}

-(UIView *)rV
{
    if(!_rV)
    {
        _rV = [UIView new];
    }
    return _rV;
}

-(UIImageView *)starImgV
{
    if (!_starImgV) {
        _starImgV = [UIImageView new];
    }
    return _starImgV;
}
@end
