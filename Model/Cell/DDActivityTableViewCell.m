//
//  DDActivityTableViewCell.m
//  DDZX_js
//
//  Created by apple on 2018/8/21.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import "DDActivityTableViewCell.h"
#import "UIView+NTES.h"
#import "UIImageView+WebCache.h"
@interface DDActivityTableViewCell()
@property(nonatomic,strong)UIImageView *imgV;
@property(nonatomic,strong)UILabel *titleLb;
@property(nonatomic,strong)UILabel *markLb;
@property(nonatomic,strong)UILabel *infoLb;
@property(nonatomic,strong)UILabel *locLb;
@property(nonatomic,strong)UIImageView *posImgV;
@property(nonatomic,strong)UILabel *pointLb;
@property(nonatomic,strong)UIImageView *markImgV;
@end

@implementation DDActivityTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.imgV];
        [self.imgV addSubview:self.markImgV];
        [self.contentView addSubview:self.titleLb];
        [self.contentView addSubview:self.markLb];
        [self.contentView addSubview:self.infoLb];
        [self.contentView addSubview:self.posImgV];
        [self.contentView addSubview:self.locLb];
        [self.contentView addSubview:self.pointLb];
    }
    return self;
}

-(UIImageView *)markImgV
{
    if (!_markImgV) {
        _markImgV = [UIImageView new];
        _markImgV.height = 22;
        _markImgV.width = 65;
        _markImgV.top = 10;
    }
    return _markImgV;
}

-(void)refresh:(NSDictionary *)dic
{
    
    [_imgV sd_setImageWithURL:[NSURL URLWithString:dic[@"imgUrl"]] placeholderImage:[UIImage imageNamed:@"暂无消息表情"]];
    _titleLb.text = dic[@"title"];
    _markLb.text = dic[@"mark"];
    _infoLb.text = dic[@"info"];
    _locLb.text = dic[@"loc"];
    _pointLb.text = dic[@"point"];
    _markImgV.image = [UIImage imageNamed:dic[@"markImg"]];
    [self setNeedsLayout];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
  
    self.imgV.left = 18;
    self.imgV.top = 22;
    self.imgV.width = 90;
    self.imgV.height = 75;
    self.imgV.layer.cornerRadius = 6;
    self.imgV.layer.masksToBounds = YES;
    
    self.titleLb.top = 22;
    self.titleLb.left = self.imgV.width + self.imgV.left + 15;
    self.titleLb.width = UIScreenWidth - 18 - self.titleLb.left;
    self.titleLb.height = 45;
    self.titleLb.numberOfLines = 2;
    [self.titleLb sizeToFit];
    self.titleLb.height = MAX(self.titleLb.height, 42);
    
    self.markLb.width = 45;
    self.markLb.height = 14;
    self.markLb.layer.cornerRadius = self.markLb.height/2.0;
    self.markLb.layer.masksToBounds = YES;
    self.markLb.top = 2 + self.height/2.0;
    self.markLb.left = self.titleLb.left;
    
    self.infoLb.left = 10 + self.markLb.width + self.markLb.left;
    self.infoLb.width = UIScreenWidth - self.infoLb.left - 18;
    self.infoLb.height = 14;
    self.infoLb.top = self.markLb.top;
    
    self.posImgV.left = self.markLb.left;
    self.posImgV.width = 12;
    self.posImgV.height = 12;
    self.posImgV.top = self.markLb.height + self.markLb.top + 5;
    
    self.locLb.left = 5 + self.posImgV.width + self.posImgV.left;
    self.locLb.width = 120;
    self.locLb.height = 12;
    self.locLb.top = self.posImgV.top;
    
    self.pointLb.width = 100;
    self.pointLb.height = 20;
    self.pointLb.left = UIScreenWidth - 18 - self.pointLb.width;
    self.pointLb.top = self.height - 20 - self.pointLb.height;
}

-(UIImageView *)imgV
{
    if (!_imgV) {
        _imgV = [UIImageView new];
    }
    return _imgV;
}

-(UIImageView *)posImgV
{
    if (!_posImgV) {
        _posImgV = [UIImageView new];
        _posImgV.image = [UIImage imageNamed:@"位置"];
    }
    return _posImgV;
}

-(UILabel *)titleLb
{
    if (!_titleLb) {
        _titleLb = [UILabel new];
        _titleLb.textColor = UIColorFromRGB(0x3A424D);
        _titleLb.font = [UIFont systemFontOfSize:14];
    }
    return _titleLb;
}

-(UILabel *)markLb
{
    if (!_markLb) {
        _markLb = [UILabel new];
        _markLb.textColor = UIColorFromRGB(0xFA8E31);
        _markLb.font = [UIFont systemFontOfSize:9];
        _markLb.layer.borderColor = UIColorFromRGB(0xFA8E31).CGColor;
        _markLb.layer.borderWidth = 0.5;
        _markLb.textAlignment = NSTextAlignmentCenter;
    }
    return _markLb;
}

-(UILabel *)infoLb
{
    if (!_infoLb) {
        _infoLb = [UILabel new];
        _infoLb.textColor = UIColorFromRGB(0x3A424D);
        _infoLb.font = [UIFont systemFontOfSize:11];
    }
    return _infoLb;
}

-(UILabel *)pointLb
{
    if (!_pointLb) {
        _pointLb = [UILabel new];
        _pointLb.textColor = UIColorFromRGB(0xFA8E31);
        _pointLb.font = [UIFont systemFontOfSize:14];
        _pointLb.textAlignment = NSTextAlignmentRight;
    }
    return _pointLb;
}

-(UILabel *)locLb
{
    if (!_locLb) {
        _locLb = [UILabel new];
        _locLb.textColor = UIColorFromRGB(0xA2A3A7);
        _locLb.font = [UIFont systemFontOfSize:11];
    }
    return _locLb;
}
@end
