//
//  DDSettingTableViewCell.m
//  DDZX_js
//
//  Created by apple on 2018/8/23.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import "DDSettingTableViewCell.h"
#import "UIView+NTES.h"

@interface DDSettingTableViewCell()
@property(nonatomic,strong)UILabel *titleLb;
@property(nonatomic,strong)UIImageView *arrowImgV;
@property(nonatomic,strong)UILabel *detailLb;
@end

@implementation DDSettingTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.titleLb];
        [self.contentView addSubview:self.arrowImgV];
        [self.contentView addSubview:self.detailLb];
    }
    return self;
}

-(void)refresh:(NSDictionary *)dic
{
    _titleLb.text = dic[@"title"];
    _detailLb.text = dic[@"detail"]?:@"";
    [self setNeedsLayout];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    _titleLb.left = 18;
    _titleLb.centerY = self.height/2.0;
    _arrowImgV.left = UIScreenWidth - 18 - _arrowImgV.width;
    _arrowImgV.centerY = self.height/2.0;
  
    _detailLb.left = _arrowImgV.left - 6 - _detailLb.width;
    _detailLb.width = 120;
    _detailLb.textAlignment = NSTextAlignmentRight;
     _detailLb.centerY = self.height/2.0;
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
-(UILabel *)detailLb
{
    if (!_detailLb) {
        _detailLb = [UILabel new];
        _detailLb.width = 120;
        _detailLb.height = 20;
        _detailLb.textColor = UIColorFromRGB(0xA2A3A7);
        _detailLb.font = [UIFont systemFontOfSize:14];
    }
    return _detailLb;
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


@end
