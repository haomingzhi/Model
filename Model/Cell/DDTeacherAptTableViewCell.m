//
//  DDTeacherAptTableViewCell.m
//  NIM
//
//  Created by apple on 2018/7/30.
//  Copyright © 2018年 Netease. All rights reserved.
//

#import "DDTeacherAptTableViewCell.h"
#import "UIView+NTES.h"

@interface DDTeacherAptTableViewCell()
@property(nonatomic,strong)UILabel *titleLb;
@property(nonatomic,strong)UILabel *infoLb;
@property(nonatomic,strong)UIView *lineV;
@property(nonatomic,strong)UIImageView *imgV;
@end


@implementation DDTeacherAptTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.titleLb];
        [self.contentView addSubview:self.infoLb];
        [self.contentView addSubview:self.imgV];
        [self.contentView addSubview:self.lineV];
    }
    return self;
}

-(void)refresh:(NSDictionary *)dic
{
    self.titleLb.text = dic[@"title"];
    self.infoLb.text = dic[@"info"];
    self.imgV.image = [UIImage imageNamed:dic[@"img"]];

    [self setNeedsLayout];
}

-(void)layoutSubviews
{
    _imgV.top = 30;
    _imgV.width = 80;
    _imgV.height = 80;
    _imgV.left = self.width - 18 - _imgV.width;
    _titleLb.top = 30;
    _titleLb.width = 200;
    _titleLb.height = 22;
    _titleLb.textColor = UIColorFromRGB(0x3A424D);
    _titleLb.font = [UIFont systemFontOfSize:18];
    _titleLb.left = 18;
    
    _lineV.top = _titleLb.top + _titleLb.height + 2;
    _lineV.left = _titleLb.left;
    
    _infoLb.top = 34 + _titleLb.top + _titleLb.height;
    _infoLb.left = _titleLb.left;
    _infoLb.height = 120;
    _infoLb.width = self.width - 36;
    _infoLb.textColor = UIColorFromRGB(0x3A424D);
    _infoLb.font = [UIFont systemFontOfSize:16];
    _infoLb.numberOfLines = 0;
    [_infoLb sizeToFit];
  
}

-(UILabel *)titleLb
{
    if (!_titleLb) {
        _titleLb = [UILabel new];
    }
    return _titleLb;
}


-(UILabel *)infoLb
{
    if (!_infoLb) {
        _infoLb = [UILabel new];
    }
    return _infoLb;
}

-(UIImageView *)imgV
{
    if (!_imgV) {
        _imgV = [UIImageView new];
    }
    return _imgV;
}

-(UIView *)lineV
{
    if (!_lineV) {
        _lineV = [UIView new];
        _lineV.width = 35;
        _lineV.height = 4;
        _lineV.layer.cornerRadius = _lineV.height/2.0;
        _lineV.layer.masksToBounds = YES;
        _lineV.backgroundColor = UIColorFromRGB(0x20A0FF);
    }
    return _lineV;
}

@end
