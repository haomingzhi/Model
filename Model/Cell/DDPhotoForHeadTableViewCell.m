//
//  DDPhotoForHeadTableViewCell.m
//  DDZX_js
//
//  Created by apple on 2018/8/27.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import "DDPhotoForHeadTableViewCell.h"
#import "UIView+NTES.h"
#import "UIImageView+WebCache.h"

@interface DDPhotoForHeadTableViewCell()
@property(nonatomic,strong)UIImageView *imgV;
@property(nonatomic,strong)UILabel *titleLb;
@property(nonatomic,strong)UIImageView *arrowImgV;
@end

@implementation DDPhotoForHeadTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.imgV];
        [self.contentView addSubview:self.arrowImgV];
        [self.contentView addSubview:self.titleLb];
    }
    return self;
}

-(void)refresh:(NSDictionary *)dic
{
    self.titleLb.text = dic[@"title"];
    if (dic[@"mark"]) {
        NSString *st = dic[@"title"];
        NSRange rg = [st rangeOfString:dic[@"mark"]];
        NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:st];
        [attrStr addAttribute:NSForegroundColorAttributeName
                        value:UIColorFromRGB(0x3A424D)
                        range:NSMakeRange(0, attrStr.length)];
        [attrStr addAttribute:NSForegroundColorAttributeName
                        value:UIColorFromRGB(0xDC4141)
                        range:rg];
        _titleLb.attributedText =  attrStr;
    }
    [self.imgV sd_setImageWithURL:[NSURL URLWithString:dic[@"imgUrl"]] placeholderImage:[UIImage imageNamed:dic[@"img"]]];
    [self setNeedsLayout];
}

-(UIImageView *)imgV
{
    if (!_imgV) {
        _imgV = [UIImageView new];
        _imgV.height = 30;
        _imgV.width = 30;
        _imgV.layer.cornerRadius = _imgV.height/2.0;
        _imgV.layer.masksToBounds = YES;
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

-(UILabel *)titleLb
{
    if (!_titleLb) {
        _titleLb = [UILabel new];
        _titleLb.height = 20;
        _titleLb.width = 140;
        _titleLb.font = [UIFont systemFontOfSize:14];
        _titleLb.textColor = UIColorFromRGB(0x3A424D);
    }
    return _titleLb;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    _titleLb.left = 18;
    _titleLb.centerY = self.height/2.0;
    
    _imgV.centerY = self.height/2.0;
    _imgV.left = self.width - 34 - _imgV.width;
    
    _arrowImgV.left = UIScreenWidth - 18 - _arrowImgV.width;
    _arrowImgV.centerY = self.height/2.0;
}
@end
