//
//  DDTitleDetailBtn.m
//  DDZX_js
//
//  Created by apple on 2018/8/23.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import "DDTitleDetailBtn.h"
#import "UIView+NTES.h"
@interface DDTitleDetailBtn()
@property(nonatomic,strong)UILabel *titleLb;
@property(nonatomic,strong)UILabel *detailLb;
@end
@implementation DDTitleDetailBtn

-(id)init
{
    self = [super init];
    if (self) {
        [self addSubview:self.titleLb];
        [self addSubview:self.detailLb];
        self.height = 48;
        self.width = 100;
    }
    return self;
}

-(void)setTitle:(NSString *)title
{
    _titleLb.text = title;
    _title = title;
}

-(void)setDetail:(NSString *)detail
{
    _detailLb.text = detail;
    _detail = detail;
}

-(UILabel *)titleLb
{
    if (!_titleLb) {
        _titleLb = [UILabel new];
        _titleLb.textAlignment = NSTextAlignmentCenter;
        _titleLb.font = [UIFont systemFontOfSize:18];
        _titleLb.textColor = UIColorFromRGB(0x3A424D);
    }
    return _titleLb;
}

-(UILabel *)detailLb
{
    if (!_detailLb) {
        _detailLb = [UILabel new];
          _detailLb.textAlignment = NSTextAlignmentCenter;
        _detailLb.font = [UIFont systemFontOfSize:14];
        _detailLb.textColor = UIColorFromRGB(0xA2A3A7);
    }
    return _detailLb;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    _titleLb.width = self.width;
    _titleLb.height = 25;
    _titleLb.top = 3;
    _titleLb.left = 0;
    
    _detailLb.width = self.width;
    _detailLb.height = 20;
    _detailLb.top = 3 + _titleLb.top + _titleLb.height;
}
@end
