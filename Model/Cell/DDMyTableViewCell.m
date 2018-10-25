//
//  DDMyTableViewCell.m
//  DDZX_js
//
//  Created by apple on 2018/8/23.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import "DDMyTableViewCell.h"
#import "UIView+NTES.h"

@interface DDMyTableViewCell()
@property(nonatomic,strong)UILabel *markLb;
@property(nonatomic,strong)UILabel *titleLb;
@property(nonatomic,strong)UIImageView *imgV;
@property(nonatomic,strong)UIImageView *arrowImgV;
@end

@implementation DDMyTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.markLb];
        [self.contentView addSubview:self.titleLb];
        [self.contentView addSubview:self.imgV];
        [self.contentView addSubview:self.arrowImgV];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    _titleLb.left = 68;
    _titleLb.centerY = self.height/2.0;
    _arrowImgV.left = UIScreenWidth - 18 - _arrowImgV.width;
    _arrowImgV.centerY = self.height/2.0;
    _markLb.left = _arrowImgV.left - 5 - _markLb.width;
    _markLb.centerY = self.height/2.0;
    _imgV.left = 18;
    _imgV.centerY = self.height/2.0;
   if( _markLb.text.length == 0)
   {
          _markLb.hidden = YES;
   }
    else
    {
        _markLb.hidden = NO;
    }
}

-(UILabel *)titleLb
{
    if (!_titleLb) {
        _titleLb = [UILabel new];
        _titleLb.width = 180;
        _titleLb.height = 20;
        _titleLb.textColor = UIColorFromRGB(0x3A424D);
        _titleLb.font = [UIFont systemFontOfSize:14];
    }
    return _titleLb;
}

-(UIImageView *)imgV
{
    if (!_imgV) {
        _imgV = [UIImageView new];
        _imgV.height = 18;
        _imgV.width = 18;
    }
    return _imgV;
}

-(UIImageView *)arrowImgV
{
    if (!_arrowImgV) {
        _arrowImgV = [UIImageView new];
        _arrowImgV.height = 14;
        _arrowImgV.width = 14;
        _arrowImgV.image = [UIImage imageNamed:@"进入 copy"];
    }
    return _arrowImgV;
}

-(UILabel *)markLb
{
    if (!_markLb) {
        _markLb = [UILabel new];
        _markLb.width = 17;
        _markLb.height = 17;
        _markLb.layer.cornerRadius = _markLb.height/2.0;
        _markLb.layer.masksToBounds = YES;
        _markLb.textColor = UIColorFromRGB(0xffffff);
        _markLb.backgroundColor = UIColorFromRGB(0xDC4141);
        _markLb.textAlignment = NSTextAlignmentCenter;
        _markLb.font = [UIFont systemFontOfSize:12];
        _markLb.top = 32;
        _markLb.left = -11;
    }
    return _markLb;
}

-(void)refresh:(NSDictionary *)dic
{
    _titleLb.text = dic[@"title"];
    _imgV.image = [UIImage imageNamed:dic[@"img"]];
    _markLb.text = dic[@"mark"];
    [self setNeedsLayout];
}



@end
