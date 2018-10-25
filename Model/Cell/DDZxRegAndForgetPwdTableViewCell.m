//
//  DDZxRegAndForgetPwdTableViewCell.m
//  NIM
//
//  Created by apple on 2018/7/26.
//  Copyright © 2018年 Netease. All rights reserved.
//

#import "DDZxRegAndForgetPwdTableViewCell.h"
#import "UIView+NTES.h"
@interface DDZxRegAndForgetPwdTableViewCell()
@property(nonatomic,strong)UIButton *regBtn;
@property(nonatomic,strong)UIButton *fPwdBtn;
@property(nonatomic,strong)UIView *lineV;
@end

@implementation DDZxRegAndForgetPwdTableViewCell

-(id)init
{
    self = [super init];
    if (self) {
        [self.contentView addSubview:self.regBtn];
        [self.contentView addSubview:self.fPwdBtn];
        [self.contentView addSubview:self.lineV];
    }
    return self;
}

-(void)layoutSubviews
{
    self.lineV.centerX = UIScreenWidth * .5f;
    self.lineV.top = 20;
    
    self.regBtn.top = 16;
    self.fPwdBtn.top = 16;
    
    self.regBtn.left = self.lineV.centerX - 27 - self.regBtn.width;
    self.fPwdBtn.left = self.lineV.centerX + 27;
}

-(UIButton *)regBtn
{
    if (!_regBtn) {
        _regBtn = [UIButton new];
        _regBtn.width = 70;
        _regBtn.height = 23;
        [_regBtn setTitle:@"立即注册" forState:UIControlStateNormal];
        [_regBtn setTitleColor:UIColorFromRGB(0x3A424D) forState:UIControlStateNormal];
        _regBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [_regBtn addTarget:self action:@selector(regClick:) forControlEvents:UIControlEventTouchUpInside];
        self.backgroundColor = [UIColor clearColor];
    }
    return _regBtn;
}

-(void)regClick:(UIButton *)btn
{
    if (_regCallBack) {
        _regCallBack(@{});
    }
}

-(UIButton *)fPwdBtn
{
    if(!_fPwdBtn)
    {
        _fPwdBtn = [UIButton new];
        _fPwdBtn.width = 70;
        _fPwdBtn.height = 23;
         [_fPwdBtn setTitle:@"忘记密码" forState:UIControlStateNormal];
        [_fPwdBtn setTitleColor:UIColorFromRGB(0x3A424D) forState:UIControlStateNormal];
        _fPwdBtn.titleLabel.font = [UIFont systemFontOfSize:16];
         [_fPwdBtn addTarget:self action:@selector(forgetClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _fPwdBtn;
}

-(void)forgetClick:(UIButton *)btn
{
    if (_forgetCallBack) {
        _forgetCallBack(@{});
    }
}

-(UIView *)lineV
{
    if (!_lineV) {
        _lineV = [UIView new];
        _lineV.height = 12;
        _lineV.width = 1;
        _lineV.backgroundColor = UIColorFromRGB(0x3A424D);
    }
    return _lineV;
}

@end
