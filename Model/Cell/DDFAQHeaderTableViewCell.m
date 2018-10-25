//
//  DDFAQHeaderTableViewCell.m
//  NIM
//
//  Created by apple on 2018/7/31.
//  Copyright © 2018年 Netease. All rights reserved.
//

#import "DDFAQHeaderTableViewCell.h"
#import "UIView+NTES.h"
#import "UIImageView+WebCache.h"

@interface DDFAQHeaderTableViewCell()
@property(nonatomic,strong)UILabel *nameLb;
@property(nonatomic,strong)UILabel *infoLb;
@property(nonatomic,strong)UIImageView *imgV;
@end

@implementation DDFAQHeaderTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.nameLb];
           [self.contentView addSubview:self.infoLb];
        [self.contentView addSubview:self.imgV];
    }
    return self;
}

-(void)refresh:(NSDictionary *)dic
{
    self.nameLb.text = dic[@"name"];
    self.infoLb.text = dic[@"info"];
    [self.imgV sd_setImageWithURL:[NSURL URLWithString:dic[@"imgUrl"]] placeholderImage:[UIImage imageNamed:dic[@"img"]]];
    [self setNeedsLayout];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    _imgV.left = 18;
    _imgV.centerY = self.height/2.0;
    
    _nameLb.left = _imgV.left + _imgV.width + 5;
    _nameLb.width = 200;
    _nameLb.height = 16.5;
    _nameLb.centerY = self.height/2.0;
    
    _infoLb.width = self.width - 36 - _nameLb.width;
    _infoLb.height = 16.5;
    _infoLb.left = self.width - 18 - _infoLb.width;
    _infoLb.centerY = self.height/2.0;
    _infoLb.textAlignment = NSTextAlignmentRight;
}

-(UILabel *)infoLb
{
    if (!_infoLb) {
        _infoLb = [UILabel new];
        _infoLb.textColor = UIColorFromRGB(0xA2A3A7);
        _infoLb.font = [UIFont systemFontOfSize:12];
    }
    return _infoLb;
}

-(UILabel *)nameLb
{
    if (!_nameLb) {
        _nameLb = [UILabel new];
        _nameLb.textColor = UIColorFromRGB(0xA2A3A7);
        _nameLb.font = [UIFont systemFontOfSize:12];
    }
    return _nameLb;
}

-(UIImageView *)imgV
{
    if (!_imgV) {
        _imgV = [UIImageView new];
        _imgV.height = 17;
        _imgV.width = 17;
    }
    return _imgV;
}

@end
