//
//  DDTeacherHeaderTableViewCell.m
//  NIM
//
//  Created by apple on 2018/7/30.
//  Copyright © 2018年 Netease. All rights reserved.
//

#import "DDTeacherHeaderTableViewCell.h"
#import "UIView+NTES.h"
#import "UIImageView+WebCache.h"
@interface DDTeacherHeaderTableViewCell()
@property(nonatomic,strong)UIImageView *bgImgV;
@property(nonatomic,strong)UIImageView *imgV;
@property(nonatomic,strong)UILabel *nameLb;
@property(nonatomic,strong)UILabel *infoLb;
@end
@implementation DDTeacherHeaderTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.bgImgV];
        [self.contentView addSubview:self.imgV];
         [self.contentView addSubview:self.nameLb];
         [self.contentView addSubview:self.infoLb];
        self.bgImgV.image = [UIImage imageNamed:@"导师信息背景"];
    }
    return self;
}
-(void)refresh:(NSDictionary *)dic
{
    
    [self.imgV sd_setImageWithURL:[NSURL URLWithString:dic[@"imgUrl"]] placeholderImage:[UIImage imageNamed:dic[@"img"]]];
    self.nameLb.text = dic[@"name"];
    self.infoLb.text = dic[@"info"];
    [self setNeedsLayout];
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    _bgImgV.height = self.height;
    _bgImgV.width = self.width;
    
    _imgV.height = 80;
    _imgV.width = 80;
    _imgV.layer.cornerRadius = _imgV.height/2.0;
    _imgV.layer.masksToBounds = YES;
    _imgV.centerX = self.width/2.0;
    _imgV.centerY = self.height/2.0 - 5;
    
    _nameLb.width = self.width;
    _nameLb.height = 25;
    _nameLb.textColor = UIColorFromRGB(0xffffff);
    _nameLb.font = [UIFont systemFontOfSize:18];
    _nameLb.top = _imgV.top + _imgV.height + 2;
    _nameLb.textAlignment = NSTextAlignmentCenter;
    
    _infoLb.width = self.width;
    _infoLb.height = 24;
    _infoLb.textAlignment = NSTextAlignmentCenter;
    _infoLb.font = [UIFont systemFontOfSize:16];
    _infoLb.textColor = UIColorFromRGB(0xffffff);
    _infoLb.top = _nameLb.top + _nameLb.height + 2;
    
    
}

-(UIImageView *)bgImgV
{
    if (!_bgImgV) {
        _bgImgV = [UIImageView new];
    }
    return _bgImgV;
}

-(UIImageView *)imgV
{
    if (!_imgV) {
        _imgV = [UIImageView new];
    }
    return _imgV;
}

-(UILabel *)nameLb
{
    if(!_nameLb)
    {
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

@end
