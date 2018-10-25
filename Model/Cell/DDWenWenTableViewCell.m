//
//  DDWenWenTableViewCell.m
//  NIM
//
//  Created by apple on 2018/7/27.
//  Copyright © 2018年 Netease. All rights reserved.
//

#import "DDWenWenTableViewCell.h"
#import "UIView+NTES.h"
#import "UIImageView+WebCache.h"
@interface DDWenWenTableViewCell()
@property(nonatomic,strong)UIImageView *imgV;
@property(nonatomic,strong)UILabel *nameLb;
@property(nonatomic,strong)UILabel *infoLb;
@property(nonatomic,strong)UILabel *titleLb;
@property(nonatomic,strong)UILabel *timeLb;
@property(nonatomic,strong)UIImageView *vImgV;
@property(nonatomic,strong)UILabel *vCountLb;
@property(nonatomic,strong)UIImageView *eImgV;
@property(nonatomic,strong)UILabel *eCountLb;
@property(nonatomic,strong)UIView *containerView;
@end

@implementation DDWenWenTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.containerView];
        [self.containerView addSubview:self.imgV];
         [self.containerView addSubview:self.nameLb];
         [self.containerView addSubview:self.infoLb];
        [self.containerView addSubview:self.titleLb];
         [self.containerView addSubview:self.timeLb];
         [self.containerView addSubview:self.vImgV];
         [self.containerView addSubview:self.vCountLb];
         [self.containerView addSubview:self.eImgV];
         [self.containerView addSubview:self.eCountLb];
    }
    return self;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    self.containerView.width = self.width - 36;
    self.containerView.height = 130;
    self.containerView.layer.cornerRadius = 8;
    self.containerView.backgroundColor = UIColorFromRGB(0xF5F5F5);
    self.containerView.layer.masksToBounds = YES;
    
    self.containerView.left = 18;
    self.containerView.top = 7.5;
    
    self.imgV.height = 29;
    self.imgV.width = 29;
    self.imgV.top = 10;
    self.imgV.left = 15;
    self.imgV.layer.cornerRadius = self.imgV.height/2.0;
    self.imgV.layer.masksToBounds = YES;
    
    self.nameLb.top = 9;
    self.nameLb.left = 8 + self.imgV.width + self.imgV.left;
    self.nameLb.width = self.containerView.width - self.nameLb.left - 8;
    self.nameLb.height = 16;
    self.nameLb.font = [UIFont systemFontOfSize:12];
    self.nameLb.textColor = UIColorFromRGB(0x3A424D);
    
    self.infoLb.top = self.nameLb.top + self.nameLb.height;
    self.infoLb.left = self.nameLb.left;
    self.infoLb.width = self.nameLb.width;
    self.infoLb.height = 15;
    self.infoLb.textColor = UIColorFromRGB(0xA2A3A7);
    self.infoLb.font = [UIFont systemFontOfSize:11];
    
    self.titleLb.left = self.imgV.left;
    self.titleLb.top = 12 + self.imgV.top + self.imgV.height;
    self.titleLb.width = self.containerView.width - self.titleLb.left - 8;
    self.titleLb.height = 80;
    self.titleLb.textColor = UIColorFromRGB(0x3A424D);
    self.titleLb.font = [UIFont systemFontOfSize:17];
    self.titleLb.numberOfLines = 0;
    [self.titleLb sizeToFit];
    
    self.timeLb.left = self.imgV.left;
    self.timeLb.height = 16;
    self.timeLb.top = self.containerView.height - 10 - self.timeLb.height;
    self.timeLb.width = 76;
    self.timeLb.textColor = UIColorFromRGB(0xA2A3A7);
    self.timeLb.font = [UIFont systemFontOfSize:12];
    [self.timeLb size];
    
    self.eCountLb.width = 40;
    self.eCountLb.height = 22;
    self.eCountLb.font = [UIFont systemFontOfSize:12];
    self.eCountLb.textColor = UIColorFromRGB(0xA2A3A7);
    [self.eCountLb sizeToFit];
    self.eCountLb.left = self.containerView.width - 10 - self.eCountLb.width;
    self.eCountLb.top = self.timeLb.top;
    
    self.eImgV.width = 12;
    self.eImgV.height = 10;
    self.eImgV.top = self.containerView.height - 14 - self.eImgV.height;
    self.eImgV.left = self.eCountLb.left - 5 - self.eImgV.width;
    
    self.vCountLb.width = 40;
    self.vCountLb.height = 22;
    self.vCountLb.font = [UIFont systemFontOfSize:12];
    self.vCountLb.textColor = UIColorFromRGB(0xA2A3A7);
    [self.vCountLb sizeToFit];
    self.vCountLb.left = self.eImgV.left - 15 - self.vCountLb.width;
     self.vCountLb.top = self.timeLb.top;
    
    self.vImgV.height = 9;
    self.vImgV.width = 12;
    self.vImgV.top = self.containerView.height - 14 - self.vImgV.height;
    self.vImgV.left = self.vCountLb.left - 5 - self.vImgV.width;
}


-(void)refresh:(NSDictionary *)dic
{
    self.titleLb.text = dic[@"title"];
    self.nameLb.text = dic[@"name"];
    self.infoLb.text = dic[@"info"];
    self.timeLb.text = dic[@"time"];
    [self.imgV sd_setImageWithURL:[NSURL URLWithString:dic[@"imgUrl"]] placeholderImage:[UIImage imageNamed:dic[@"img"]]];
    self.vCountLb.text = dic[@"vCount"];
    self.eCountLb.text = dic[@"eCount"];
    [self setNeedsLayout];
}


-(UIView *)containerView
{
    if (!_containerView) {
        _containerView = [UIView new];
    }
    return _containerView;
}

-(UILabel *)titleLb
{
    if (!_titleLb) {
        _titleLb = [UILabel new];
    }
    return _titleLb;
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

-(UIImageView *)imgV
{
    if (!_imgV) {
        _imgV = [UIImageView new];
    }
    return _imgV;
}

-(UIImageView *)vImgV
{
    if (!_vImgV) {
        _vImgV = [UIImageView new];
        _vImgV.image = [UIImage imageNamed:@"围观人次"];
    }
    return _vImgV;
}

-(UIImageView *)eImgV
{
    if (!_eImgV) {
        _eImgV = [UIImageView new];
        _eImgV.image = [UIImage imageNamed:@"评论次数"];
    }
    return _eImgV;
}

-(UILabel *)eCountLb
{
    if (!_eCountLb) {
        _eCountLb = [UILabel new];
    }
    return _eCountLb;
}

-(UILabel *)vCountLb
{
    if (!_vCountLb) {
        _vCountLb = [UILabel new];
    }
    return _vCountLb;
}

-(UILabel *)timeLb
{
    if (!_timeLb) {
        _timeLb = [UILabel new];
    }
    return _timeLb;
}

@end
