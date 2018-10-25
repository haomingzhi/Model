//
//  DDTextFieldCodeTableViewCell.m
//  DDZX_js
//
//  Created by apple on 2018/8/23.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import "DDTextFieldCodeTableViewCell.h"
#import "UIView+NTES.h"

@interface DDTextFieldCodeTableViewCell()
@property(nonatomic,strong)UITextField *textTf;
@property(nonatomic,strong)UILabel *lineLb;
@property(nonatomic,strong)UIButton *codeBtn;
 @property(nonatomic,strong)NSTimer *timer;
@property(nonatomic,assign)NSInteger flag;
@end

@implementation DDTextFieldCodeTableViewCell
{
   
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.textTf];
        [self.contentView addSubview:self.lineLb];
        [self.contentView addSubview:self.codeBtn];
         _textTf.keyboardType = UIKeyboardTypePhonePad;
        self.flag = 60;
    }
    return self;
}
-(NSString *)text
{
    return _textTf.text;
}
-(UIButton *)codeBtn
{
    if (!_codeBtn) {
        _codeBtn = [UIButton new];
        _codeBtn.width = 80;
        _codeBtn.height = 20;
        [_codeBtn setTitleColor:UIColorFromRGB(0xFA8E31) forState:UIControlStateNormal];
        [_codeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        _codeBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        _codeBtn.centerY = self.height/2.0;
        _codeBtn.left = UIScreenWidth - 18 - _codeBtn.width;
        [_codeBtn addTarget:self action:@selector(codeClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _codeBtn;
}

-(void)codeClick:(UIButton *)btn
{
    if (_codeWillSendCallBack) {
        if(!_codeWillSendCallBack(@{}))
        {
            return;
        }
    }
    btn.userInteractionEnabled = NO;
     [self.codeBtn setTitle:[NSString stringWithFormat:@"%@秒",@(self.flag)] forState:UIControlStateNormal];
    __weak typeof(self) weak_self = self;
    if (@available(iOS 10.0, *)) {
        _timer = [NSTimer timerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
            weak_self.flag--;
            if (weak_self.flag > 0) {
                [weak_self.codeBtn setTitle:[NSString stringWithFormat:@"%@秒",@(weak_self.flag)] forState:UIControlStateNormal];
            }
            else
            {
                weak_self.flag = 60;
                btn.userInteractionEnabled = YES;
                [weak_self.codeBtn setTitle:[NSString stringWithFormat:@"%@",@"重新获取"] forState:UIControlStateNormal];
                [weak_self.timer invalidate];
            }
            
        }];
    } else {
        // Fallback on earlier versions
        _timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(timeHandle:) userInfo:nil repeats:YES];
    }
   [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSDefaultRunLoopMode];
    if (_codeCallBack) {
        _codeCallBack(@{});
    }
}

-(void)timeHandle:(NSTimer *)t
{
    self.flag--;
    if (self.flag > 0) {
        [self.codeBtn setTitle:[NSString stringWithFormat:@"%@秒",@(self.flag)] forState:UIControlStateNormal];
      
    }
    else
    {
        self.flag = 60;
        self.codeBtn.userInteractionEnabled = YES;
        [self.codeBtn setTitle:[NSString stringWithFormat:@"%@",@"重新获取"] forState:UIControlStateNormal];
           [self.timer invalidate];
    }
}

-(UITextField *)textTf
{
    if (!_textTf) {
        _textTf = [UITextField new];
        _textTf.height = 35;
        _textTf.left = 18;
        _textTf.width = UIScreenWidth - 36 - 88;
        _textTf.textColor = UIColorFromRGB(0x3A424D);
        _textTf.font = [UIFont systemFontOfSize:26];
    }
    return _textTf;
}


-(UILabel *)lineLb
{
    if (!_lineLb) {
        _lineLb = [UILabel new];
        _lineLb.width = UIScreenWidth - 36;
        _lineLb.height = 0.5;
        _lineLb.backgroundColor = UIColorFromRGB(0xE5E5E5);
        _lineLb.top = 35.5;
        _lineLb.left = 18;
    }
    return _lineLb;
}

-(void)refresh:(NSDictionary *)dic
{
    _textTf.text = dic[@"title"];
    [self setNeedsLayout];
}

+(BOOL)phoneNumberIsTrue:(NSString *)phoneNumber{
    
//    /**
//     * 移动号段正则表达式
//     */
//    NSString *CM_NUM =@"^((13[4-9])|(147)|(15[0-2,7-9])|(178)|(18[2-4,7-8]))//d{8}|(1705)//d{7}$";
//    /**
//     * 联通号段正则表达式
//     */
//    NSString *CU_NUM =@"^((13[0-2])|(145)|(15[5-6])|(176)|(18[5,6]))//d{8}|(1709)//d{7}$";
//    /**
//     * 电信号段正则表达式
//     */
//    NSString *CT_NUM =@"^((133)|(153)|(177)|(18[0,1,9]))//d{8}$";
//    NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM_NUM];
//    BOOL isMatch1 = [pred1 evaluateWithObject:phoneNumber];
//    NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU_NUM];
//    BOOL isMatch2 = [pred2 evaluateWithObject:phoneNumber];
//    NSPredicate *pred3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
//    BOOL isMatch3 = [pred3 evaluateWithObject:phoneNumber];
//
//    if (isMatch1 || isMatch2 || isMatch3 ) {
//        return YES;
//    }else{
//        return NO;
//    }
  
        NSString *phoneRegex1=@"1[34578]([0-9]){9}";
        NSPredicate *phoneTest1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex1];
        return  [phoneTest1 evaluateWithObject:phoneNumber];
  
}
@end
