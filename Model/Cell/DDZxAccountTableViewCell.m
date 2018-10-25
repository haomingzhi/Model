//
//  DDZxAccountTableViewCell.m
//  NIM
//
//  Created by apple on 2018/7/26.
//  Copyright © 2018年 Netease. All rights reserved.
//

#import "DDZxAccountTableViewCell.h"
#import "UIView+NTES.h"
@interface DDZxAccountTableViewCell()
@property(nonatomic,strong)UITextField *accountTf;
@property(nonatomic,strong)UIImageView *imgV;
@property(nonatomic,strong)UIView *lineV;
@end

@implementation DDZxAccountTableViewCell
-(void)refresh:(NSDictionary *)dic
{
    
}

-(NSString *)text
{
    return _accountTf.text;
}

-(void)setText:(NSString *)text
{
    _accountTf.text = text;
}
-(id)init
{
    self = [super init];
    if (self) {
        [self.contentView addSubview:self.accountTf];
        [self.contentView addSubview:self.lineV];
        [self.contentView addSubview:self.imgV];
        self.height = UIScreenWidth <= 320 ? 60:75;
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.imgV.top = UIScreenWidth <= 320 ? 30:45;
    self.imgV.left = 36;
    self.accountTf.left = self.imgV.width + self.imgV.left + 15;
    self.accountTf.width = UIScreenWidth - self.accountTf.left - 36;
    self.accountTf.top = UIScreenWidth <= 320 ? 25:40;
    self.accountTf.height = 28;
    self.lineV.top = self.height - 1;
     self.lineV.left = 36;
}

-(UITextField *)accountTf
{
    if (!_accountTf) {
        _accountTf = [UITextField new];
//        _accountTf.leftViewMode = UITextFieldViewModeAlways;
//        _accountTf.leftView =
        _accountTf.font = [UIFont systemFontOfSize:20];
            _accountTf.placeholder = @"手机号/账号";
        NSString *str = @"手机号/账号";
        NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:str];
        [attrStr addAttribute:NSForegroundColorAttributeName
                        value:UIColorFromRGB(0xA2A3A7)
                        range:NSMakeRange(0, str.length)];
        [attrStr addAttribute:NSFontAttributeName
                        value:[UIFont systemFontOfSize:14]
                        range:NSMakeRange(0, str.length)];
        _accountTf.attributedPlaceholder =  attrStr;
    }
    return _accountTf;
}
-(UIImageView *)imgV
{
    if (!_imgV) {
        _imgV = [UIImageView new];
        _imgV.width = 17;
        _imgV.height = 17;
        _imgV.image = [UIImage imageNamed:@"账号"];
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

@end
