//
//  DDZxPwdTableViewCell.m
//  NIM
//
//  Created by apple on 2018/7/26.
//  Copyright © 2018年 Netease. All rights reserved.
//

#import "DDZxPwdTableViewCell.h"
#import "UIView+NTES.h"
@interface DDZxPwdTableViewCell()
@property(nonatomic,strong)UITextField *pwdTf;
@property(nonatomic,strong)UIImageView *imgV;
@property(nonatomic,strong)UIButton *btn;
@property(nonatomic,strong)UIView *lineV;
@end

@implementation DDZxPwdTableViewCell
-(void)refresh:(NSDictionary *)dic
{
    
}
-(id)init
{
    self = [super init];
    if (self) {
        [self.contentView addSubview:self.pwdTf];
        [self.contentView addSubview:self.imgV];
        [self.contentView addSubview:self.lineV];
        [self.contentView addSubview:self.btn];
        self.height = UIScreenWidth <= 320 ? 60:75;
    }
    return self;
}
-(NSString *)text
{
    return _pwdTf.text;
}

-(void)setText:(NSString *)text
{
    _pwdTf.text = text;
}

-(void)layoutSubviews
{
    self.imgV.top = UIScreenWidth <= 320 ? 30:45;
    self.imgV.left = 36;
    self.pwdTf.left = self.imgV.width + self.imgV.left + 15;
    self.pwdTf.width = UIScreenWidth - self.pwdTf.left - 36 - 22;
    self.pwdTf.top = UIScreenWidth <= 320 ? 25:40;
    self.pwdTf.height = 28;
    self.lineV.top = self.height - 1;
    self.lineV.left = 36;
    self.btn.top = UIScreenWidth <= 320 ? 25:40;
    self.btn.left = UIScreenWidth - 36 - self.btn.width + 8;
}

-(void)onShowClick:(UIButton *)btn
{
    btn.selected =  _pwdTf.secureTextEntry ;
    _pwdTf.secureTextEntry = ! _pwdTf.secureTextEntry;
    
}
-(UITextField *)pwdTf
{
    if (!_pwdTf) {
        _pwdTf = [UITextField new];
        //        _accountTf.leftViewMode = UITextFieldViewModeAlways;
        //        _accountTf.leftView =
        _pwdTf.placeholder = @"密码";
        _pwdTf.secureTextEntry = YES;
        _pwdTf.font = [UIFont systemFontOfSize:20];
        NSString *str = @"密码";
        NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:str];
        [attrStr addAttribute:NSForegroundColorAttributeName
                        value:UIColorFromRGB(0xA2A3A7)
                        range:NSMakeRange(0, str.length)];
        [attrStr addAttribute:NSFontAttributeName
                        value:[UIFont systemFontOfSize:14]
                        range:NSMakeRange(0, str.length)];
        _pwdTf.attributedPlaceholder =  attrStr;
    }
    return _pwdTf;
}
-(UIImageView *)imgV
{
    if (!_imgV) {
        _imgV = [UIImageView new];
        _imgV.width = 17;
        _imgV.height = 17;
            _imgV.image = [UIImage imageNamed:@"密码"];
    }
    return _imgV;
}

-(UIView *)lineV
{
    if (!_lineV) {
        _lineV = [UIView new];
        _lineV.backgroundColor = UIColorFromRGB(0xE5E5E5);
        _lineV.width = UIScreenWidth - 72;
        _lineV.height = 0.5;
    }
    return _lineV;
}

-(UIButton *)btn
{
    if (!_btn) {
        _btn = [UIButton new];
        _btn.width = 30;
        _btn.height = 30;
        _btn.imageEdgeInsets = UIEdgeInsetsMake(8, 8, 8, 8);
        [_btn setImage:[UIImage imageNamed:@"密码不可见"] forState:UIControlStateNormal];
        [_btn setImage:[UIImage imageNamed:@"密码可见"] forState:UIControlStateSelected];
        [_btn addTarget:self action:@selector(onShowClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn;
}

@end
