//
//  DDExLogoTableViewCell.m
//  NIM
//
//  Created by apple on 2018/7/26.
//  Copyright © 2018年 Netease. All rights reserved.
//

#import "DDZxLogoTableViewCell.h"
#import "UIView+NTES.h"
@interface DDZxLogoTableViewCell()
@property(nonatomic,strong)UIImageView *imgV;
@property(nonatomic,strong)UILabel *titleLb;
@end

@implementation DDZxLogoTableViewCell
-(id)init
{
    self = [super init];
    if (self) {
        [self.contentView addSubview:self.imgV];
        self.height = 142;
        self.width = UIScreenWidth;
//        [self.contentView addSubview:self.titleLb];
    }
    return self;
}

-(void)layoutSubviews
{
    _imgV.width = 234.5;
    _imgV.height = 42;
    _imgV.top = 45 + 36;
    _imgV.centerX = UIScreenWidth *.5f;
//    _titleLb.top = 54;
//    _titleLb.width = 182;
//    _titleLb.height = 25;
//    _titleLb.font = [UIFont systemFontOfSize:26];
//    _titleLb.textColor = UIColorFromRGB(0xFA8E31);
//    [_titleLb sizeToFit];
//
//    _imgV.left = UIScreenWidth/2.0 - (_imgV.width + _titleLb.width + 10)/2.0;
//    _titleLb.left = _imgV.left + 10 + _imgV.width;
}

-(void)refresh:(NSDictionary *)dic
{
    
}

-(UIImageView *)imgV
{
    if (!_imgV) {
        _imgV = [UIImageView new];
        _imgV.image = [UIImage imageNamed:@"登录页logo"];
    }
    return _imgV;
}

-(UILabel *)titleLb
{
    if (!_titleLb) {
        _titleLb = [UILabel new];
        _titleLb.text = @"校园在线导师端";
    }
    return _titleLb;
}

@end
