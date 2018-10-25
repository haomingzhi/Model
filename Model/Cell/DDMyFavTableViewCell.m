//
//  DDMyFavTableViewCell.m
//  DDZX_js
//
//  Created by apple on 2018/8/23.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import "DDMyFavTableViewCell.h"
#import "UIView+NTES.h"
#import "UIImageView+WebCache.h"
@interface DDMyFavTableViewCell()
@property(nonatomic,strong)UIImageView *imgV;
@property(nonatomic,strong)UILabel *titleLb;
@property(nonatomic,strong)UILabel *infoLb;
@property(nonatomic,strong)UILabel *timeLb;
@end

@implementation DDMyFavTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.imgV];
        [self.contentView addSubview:self.titleLb];
        [self.contentView addSubview:self.infoLb];
        [self.contentView addSubview:self.timeLb];
    }
    return self;
}

-(void)refresh:(NSDictionary *)dic
{
    [_imgV sd_setImageWithURL:[NSURL URLWithString:dic[@"imgUrl"]] placeholderImage:[UIImage imageNamed:dic[@"img"]]];
    _titleLb.text = dic[@"title"];
    _infoLb.text = dic[@"info"];
    _timeLb.text = dic[@"time"];
    [self setNeedsLayout];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    _imgV.left = 18;
    _imgV.centerY = self.height/2.0;
    _titleLb.left = 10 + _imgV.width + _imgV.left;
    _titleLb.top = _imgV.top;
    _titleLb.width = self.width - 18 - _titleLb.left;
    _infoLb.left = _titleLb.left;
    _infoLb.top = _titleLb.top + _titleLb.height;
    _infoLb.width = _titleLb.width;
    _infoLb.height = 50;
    [_infoLb sizeToFit];
    
    _timeLb.height = 13;
    _timeLb.width = _titleLb.width;
    _timeLb.left = _infoLb.left;
    _timeLb.top = _imgV.height + _imgV.top - _timeLb.height;
}

-(UIImageView *)imgV
{
    if (!_imgV) {
        _imgV = [UIImageView new];
        _imgV.width = 111;
        _imgV.height = 62.5;
        _imgV.layer.cornerRadius = 9;
        _imgV.layer.masksToBounds = YES;
        
    }
    return _imgV;
}

-(UILabel *)titleLb
{
    if (!_titleLb) {
        _titleLb = [UILabel new];
        _titleLb.textColor = UIColorFromRGB(0x3A424D);
        _titleLb.font = [UIFont systemFontOfSize:14];
        _titleLb.height = 19;
    }
    return _titleLb;
}

-(UILabel *)infoLb
{
    if (!_infoLb) {
        _infoLb = [UILabel new];
        _infoLb.textColor = UIColorFromRGB(0x3A424D);
        _infoLb.font = [UIFont systemFontOfSize:12];
        _infoLb.height = 34;
        _infoLb.numberOfLines = 2;
    }
    return _infoLb;
}

-(UILabel *)timeLb
{
    if(!_timeLb)
    {
        _timeLb = [UILabel new];
        _timeLb.textColor = UIColorFromRGB(0xA2A3A7);
        _timeLb.font = [UIFont systemFontOfSize:10];
 
    }
    return _timeLb;
}
@end
