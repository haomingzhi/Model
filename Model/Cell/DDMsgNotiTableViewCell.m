//
//  DDMsgNotiTableViewCell.m
//  DDZX_js
//
//  Created by apple on 2018/8/23.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import "DDMsgNotiTableViewCell.h"
#import "UIView+NTES.h"
//#import "UIImageView+WebCache.h"

@interface DDMsgNotiTableViewCell()
@property(nonatomic,strong)UIImageView *imgV;
@property(nonatomic,strong)UILabel *titleLb;
@property(nonatomic,strong)UILabel *infoLb;
@property(nonatomic,strong)UILabel *timeLb;
@end


@implementation DDMsgNotiTableViewCell
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
    [_imgV setImage:[UIImage imageNamed:dic[@"img"]]];
    _titleLb.text = dic[@"title"];
    _infoLb.text = dic[@"info"];
    _timeLb.text = dic[@"time"];
    [self setNeedsLayout];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    _imgV.left = 18;
    _imgV.centerY = 44;
    _titleLb.left = 10 + _imgV.width + _imgV.left;
    _titleLb.top = _imgV.top;
    _titleLb.width = self.width - 58 - _titleLb.left;
    _infoLb.left = _titleLb.left;
    _infoLb.top = _titleLb.top + _titleLb.height + 4;
    _infoLb.width = _titleLb.width;
    [_infoLb sizeToFit];
    
    _timeLb.left = self.width - 18 - _timeLb.width;
    _timeLb.top = _titleLb.top + 3;
}

-(UIImageView *)imgV
{
    if (!_imgV) {
        _imgV = [UIImageView new];
        _imgV.width = 36;
        _imgV.height = 36;
        _imgV.layer.cornerRadius = 6;
        _imgV.layer.masksToBounds = YES;
        _imgV.image = [UIImage imageNamed:@"审核通知"];
    }
    return _imgV;
}

-(UILabel *)titleLb
{
    if (!_titleLb) {
        _titleLb = [UILabel new];
        _titleLb.textColor = UIColorFromRGB(0x3A424D);
        _titleLb.font = [UIFont systemFontOfSize:14];
        _titleLb.height = 20;
    }
    return _titleLb;
}

-(UILabel *)timeLb
{
    if (!_timeLb) {
        _timeLb = [UILabel new];
        _timeLb.textColor = UIColorFromRGB(0xA2A3A7);
        _timeLb.font = [UIFont systemFontOfSize:12];
        _timeLb.height = 17;
        _timeLb.width = 120;
        _timeLb.textAlignment = NSTextAlignmentRight;
    }
    return _timeLb;
}
-(UILabel *)infoLb
{
    if (!_infoLb) {
        _infoLb = [UILabel new];
        _infoLb.textColor = UIColorFromRGB(0xA2A3A7);
        _infoLb.font = [UIFont systemFontOfSize:12];
        _infoLb.height = 100000;
        _infoLb.numberOfLines = 0;
    }
    return _infoLb;
}

@end
