//
//  TextFieldTableViewCell.m
//  ulife
//
//  Created by air on 15/12/23.
//  Copyright © 2015年 ORANLLC_IOS1. All rights reserved.
//

#import "TextFieldTableViewCell.h"

@implementation TextFieldTableViewCell
{
    NSInteger _maxCount;
    IBOutlet UIView *_containerView;
    NSDictionary *_dataDic;
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


-(void)setCellData:(NSDictionary *)dataDic
{
    _textTf.text = dataDic[@"title"];
    _textTf.placeholder = dataDic[@"placeholder"];
    _dataDic = dataDic;
}

-(void)fitMode
{
    _textTf.backgroundColor = kUIColorFromRGB(color_2);
    _textTf.layer.borderColor = kUIColorFromRGB(color_lineColor).CGColor;
    _textTf.layer.borderWidth = 1;
    _textTf.layer.cornerRadius = 2;
    _textTf.layer.masksToBounds = YES;
    _textTf.x = 35;
    _textTf.y = 10;
    _textTf.height = 30;
    _textTf.width = __SCREEN_SIZE.width - 70;
    //    [_textTf setLeftMargin:10];
    _textTf.leftViewMode = UITextFieldViewModeAlways;
    _textTf.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
    self.height = 50;
    
}

-(void)fitModeB
{
    _textTf.backgroundColor = kUIColorFromRGB(color_2);
    _textTf.layer.borderColor = kUIColorFromRGB(color_lineColor).CGColor;
    _textTf.layer.borderWidth = 1;
    _textTf.layer.cornerRadius = 2;
    _textTf.layer.masksToBounds = YES;
    _textTf.x = 15;
    _textTf.y = 1;
    _textTf.height = 32;
    _textTf.width = __SCREEN_SIZE.width - 30;
    //    [_textTf setLeftMargin:10];
    _textTf.keyboardType = UIKeyboardTypeDecimalPad;
    _textTf.leftViewMode = UITextFieldViewModeAlways;
    _textTf.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
    self.height = 49;
}


-(void)fitModeC:(NSString *)leftTitle
{
    self.height = 66;
    self.clipsToBounds = YES;
    _containerView.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _containerView.x = 15;
    _containerView.y = 30;
    _containerView.height = 37;
    _containerView.width = __SCREEN_SIZE.width - 30;
    _containerView.layer.borderWidth = 1;
    _containerView.layer.borderColor = kUIColorFromRGB(color_lineColor).CGColor;
    _containerView.layer.cornerRadius = 1;
    
    UILabel *lb = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 40, 21)];
    lb.text = leftTitle;
    lb.textColor = kUIColorFromRGB(color_1);
    lb.font = [UIFont systemFontOfSize:14];
    _textTf.leftView = lb;
    _textTf.leftViewMode = UITextFieldViewModeAlways;
    _textTf.y = _containerView.height/2.0 - _textTf.height/2.0;
    _textTf.width = _containerView.width - 10;
}

-(void)fitModeD:(NSString *)leftTitle
{
    self.height = 66;
    self.clipsToBounds = YES;
    _containerView.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _containerView.x = 15;
    _containerView.y = -1;
    _containerView.height = 37;
    _containerView.width = __SCREEN_SIZE.width - 30;
    _containerView.layer.borderWidth = 1;
    _containerView.layer.borderColor = kUIColorFromRGB(color_lineColor).CGColor;
    _containerView.layer.cornerRadius = 1;
    
    UILabel *lb = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 40, 21)];
    lb.text = leftTitle;
    lb.textColor = kUIColorFromRGB(color_1);
    lb.font = [UIFont systemFontOfSize:14];
    _textTf.leftView = lb;
    _textTf.leftViewMode = UITextFieldViewModeAlways;
    _textTf.y = _containerView.height/2.0 - _textTf.height/2.0;
    _textTf.width = _containerView.width - 10;
}

-(void)fitModeE:(id)obj withSel:(SEL)sel
{
     _containerView.backgroundColor = [UIColor clearColor];
     _textTf.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _textTf.x = 15;
     _textTf.y = 30;
     _textTf.height = 40;
     _textTf.width = __SCREEN_SIZE.width - 30;
     _textTf.leftViewMode = UITextFieldViewModeAlways;
     _textTf.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
     UIButton *rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 75, 30)];
     rightBtn.titleLabel.font = [UIFont systemFontOfSize:13];
     [rightBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
     [rightBtn setTitleColor:kUIColorFromRGB(color_3) forState:UIControlStateNormal];
     rightBtn.backgroundColor = kUIColorFromRGB(color_2);

     [rightBtn addTarget:obj action:sel forControlEvents:UIControlEventTouchUpInside];
     rightBtn.layer.cornerRadius = 6;
         rightBtn.layer.borderWidth = 0.5;
         rightBtn.layer.borderColor = kUIColorFromRGB(color_3).CGColor;
     rightBtn.layer.masksToBounds = YES;
     _textTf.rightView = rightBtn;
     _textTf.rightViewMode = UITextFieldViewModeAlways;
     rightBtn.tag = 98960;
     _textTf.leftViewMode = UITextFieldViewModeAlways;
     UIView *vv = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 23, 25)];
     UIImageView *iv = [[UIImageView alloc] initWithImage:[UIImage imageContentWithFileName:@"login_phone_orallc"]];
     iv.y = 3;
     [vv addSubview:iv];
     _textTf.leftView = vv;
     _textTf.y = self.height/2.0 - _textTf.height/2.0;
     self.height = 46;
     rightBtn.y = self.height/2.0 - rightBtn.height/2.0;
     _containerView.y = 0;
     _containerView.height = 46;
}

-(void)fitModeF:(id)obj withSel:(SEL)sel
{
    [self fitModeE:obj withSel:sel];
   UIButton *rightBtn =  _textTf.rightView ;
    rightBtn.layer.borderWidth = 0;
    rightBtn.backgroundColor = kUIColorFromRGB(color_3);
    self.height = 45;
    _containerView.height = 45;
    _containerView.y = 0;
    rightBtn.y = self.height/2.0 - rightBtn.height/2.0;
}

-(void)fitRegMode
{
     self.height = 46;
      _containerView.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
      _containerView.y = 0;
     _containerView.height = 46;
     _containerView.width = __SCREEN_SIZE.width;
     _textTf.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _textTf.leftViewMode = UITextFieldViewModeAlways;
     _textTf.keyboardType = UIKeyboardTypePhonePad;
     UIView *vv = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 77, 25)];
     UILabel *iv = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 77, 25)];
//     iv.y = 5;
     iv.font = [UIFont systemFontOfSize:15];
     iv.text = @"验证码";
     iv.textColor = kUIColorFromRGB(color_1);
     [vv addSubview:iv];
     _textTf.leftView = vv;
     _textTf.width = __SCREEN_SIZE.width - 30;
     _textTf.x = 15;
     _textTf.height = 40;
     _textTf.y = self.height/2.0 - _textTf.height/2.0;
     _textTf.font = [UIFont systemFontOfSize:15];
     _textTf.attributedPlaceholder  = [[NSAttributedString alloc] initWithString:_textTf.placeholder attributes:@{NSForegroundColorAttributeName:  kUIColorFromRGB(color_6)}];
     //    self.backgroundColor = kUIColorFromRGB(color_4);
     //    _textTf.backgroundColor = kUIColorFromRGB(color_4);
     //    _containerView.backgroundColor = [UIColor clearColor];
}

-(void)fitRegMode:(NSString*)img
{
    [self fitForgetPwdNextMode:img];
}

-(void)fitForgetPwdNextMode:(NSString*)img
{
     self.height = 50;
     _textTf.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _textTf.leftViewMode = UITextFieldViewModeAlways;
     UIView *vv = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 23, 25)];
     UIImageView *iv = [[UIImageView alloc] initWithImage:[UIImage imageContentWithFileName:img]];
     iv.y = 3;
     [vv addSubview:iv];
     _textTf.leftView = vv;
     _textTf.width = __SCREEN_SIZE.width - 30;
     _textTf.x = 15;
     _textTf.height = 25;
     _textTf.y = self.height/2.0 - _textTf.height/2.0;
     _textTf.font = [UIFont systemFontOfSize:15];
     _textTf.attributedPlaceholder  = [[NSAttributedString alloc] initWithString:_textTf.placeholder attributes:@{NSForegroundColorAttributeName:  kUIColorFromRGB(color_6)}];
     _textTf.secureTextEntry = NO;
     _textTf.keyboardType = UIKeyboardTypePhonePad ;
     //    self.backgroundColor = kUIColorFromRGB(color_4);
     //    _textTf.backgroundColor = kUIColorFromRGB(color_4);
     //    _containerView.backgroundColor = kUIColorFromRGB(color_4);
}

-(void)fitForgetPwdNextMode
{
     self.height = 50;
     _textTf.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _textTf.leftViewMode = UITextFieldViewModeAlways;
     UIView *vv = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 23, 25)];
     UIImageView *iv = [[UIImageView alloc] initWithImage:[UIImage imageContentWithFileName:@"fpwd_open"]];
     iv.y = 3;
     [vv addSubview:iv];
     _textTf.leftView = vv;
     _textTf.width = __SCREEN_SIZE.width - 30;
     _textTf.x = 15;
     _textTf.height = 25;
     _textTf.y = self.height/2.0 - _textTf.height/2.0;
     _textTf.font = [UIFont systemFontOfSize:15];
     _textTf.attributedPlaceholder  = [[NSAttributedString alloc] initWithString:_textTf.placeholder attributes:@{NSForegroundColorAttributeName:  kUIColorFromRGB(color_6)}];
     _textTf.secureTextEntry = YES;
     _textTf.keyboardType = UIKeyboardTypeASCIICapable;
     //    self.backgroundColor = kUIColorFromRGB(color_4);
     //    _textTf.backgroundColor = kUIColorFromRGB(color_4);
     //    _containerView.backgroundColor = kUIColorFromRGB(color_4);
}

-(void)fitRegModeWithTagName:(NSString*)str
{
     self.height = 46;
     _containerView.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _containerView.y = 0;
     _containerView.height = 46;
     _containerView.width = __SCREEN_SIZE.width;
     _textTf.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _textTf.leftViewMode = UITextFieldViewModeAlways;
     UIView *vv = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 77, 25)];
     UILabel *iv = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 77, 25)];
//     iv.y = 5;
     iv.font = [UIFont systemFontOfSize:15];
     iv.text = str;
     iv.textColor = kUIColorFromRGB(color_1);
     [vv addSubview:iv];
     _textTf.leftView = vv;
     _textTf.width = __SCREEN_SIZE.width - 30;
     _textTf.x = 15;
     _textTf.height = 25;
     _textTf.y = self.height/2.0 - _textTf.height/2.0;
     _textTf.font = [UIFont systemFontOfSize:15];
     _textTf.attributedPlaceholder  = [[NSAttributedString alloc] initWithString:_textTf.placeholder attributes:@{NSForegroundColorAttributeName:  kUIColorFromRGB(color_6)}];
     _textTf.secureTextEntry = YES;
     _textTf.keyboardType = UIKeyboardTypeASCIICapable;
     //    self.backgroundColor = kUIColorFromRGB(color_4);
     //    _textTf.backgroundColor = kUIColorFromRGB(color_4);
     //    _containerView.backgroundColor = kUIColorFromRGB(color_4);
}

-(void)fitForgetPwdNextModeA:(UIImage *)img
{
     self.height = 50;
     _textTf.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _textTf.leftViewMode = UITextFieldViewModeAlways;
     UIView *vv = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 23, 25)];
     UIImageView *iv = [[UIImageView alloc] initWithImage:img];
     iv.y = vv.height/2.0 - iv.height/2.0;
     [vv addSubview:iv];
     _textTf.leftView = vv;
     _textTf.width = __SCREEN_SIZE.width - 30;
     _textTf.x = 15;
     _textTf.height = 25;
     _textTf.y = self.height/2.0 - _textTf.height/2.0;
     _textTf.font = [UIFont systemFontOfSize:15];
     _textTf.attributedPlaceholder  = [[NSAttributedString alloc] initWithString:_textTf.placeholder attributes:@{NSForegroundColorAttributeName:  kUIColorFromRGB(color_6)}];
     _textTf.secureTextEntry = YES;
     _textTf.keyboardType = UIKeyboardTypeASCIICapable;
     //    self.backgroundColor = kUIColorFromRGB(color_4);
     //    _textTf.backgroundColor = kUIColorFromRGB(color_4);
     //    _containerView.backgroundColor = kUIColorFromRGB(color_4);
}





-(void)fitForgetPwdNextModeB:(id)obj withSel:(SEL)sel
{
     self.height = 41;
     _textTf.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _textTf.leftViewMode = UITextFieldViewModeNever;
     _textTf.keyboardType = UIKeyboardTypePhonePad;
     _containerView.y = 0 ;
     _containerView.x = 0;
     _containerView.height = 40;
     //     UIView *vv = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 38, 25)];
     //     UIImageView *iv = [[UIImageView alloc] initWithImage:[UIImage imageContentWithFileName:@"login_phone"]];
     //     iv.y = 3;
     //     iv.x = 15;
     //     [vv addSubview:iv];
     //     _textTf.leftView = vv;
     _textTf.width = __SCREEN_SIZE.width - 30;
     _textTf.x = 15;
     _textTf.height = 40;
     _textTf.y = self.height/2.0 - _textTf.height/2.0;
     _textTf.font = [UIFont systemFontOfSize:15];
     _textTf.attributedPlaceholder  = [[NSAttributedString alloc] initWithString:_textTf.placeholder attributes:@{NSForegroundColorAttributeName:  kUIColorFromRGB(color_0xb0b0b0)}];
     //     _textTf.layer.cornerRadius = 5;
     //     _textTf.layer.borderColor = kUIColorFromRGB(color_lineColor).CGColor;
     _textTf.layer.borderWidth = 0;
     
     UIButton *rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 75, 33)];
     rightBtn.titleLabel.font = [UIFont systemFontOfSize:13];
     [rightBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
     [rightBtn setTitleColor:kUIColorFromRGB(color_0xb0b0b0) forState:UIControlStateNormal];
     
     [rightBtn addTarget:obj action:sel forControlEvents:UIControlEventTouchUpInside];
     rightBtn.layer.cornerRadius = 3;
     rightBtn.layer.borderWidth = 0.5;
     rightBtn.layer.borderColor = kUIColorFromRGB(color_0xb0b0b0).CGColor;
     rightBtn.layer.masksToBounds = YES;
     
     UIView *vvv = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 80, 33)];
     [vvv addSubview:rightBtn];
     vvv.x = __SCREEN_SIZE.width - 15 - vvv.width;
     vvv.y = self.height/2.0 - vvv.height/2.0;
     [self.contentView addSubview:vvv];
     _textTf.rightViewMode = UITextFieldViewModeNever;
     rightBtn.tag = 98960;

}

-(void)fitForgetPwdNextModeB:(NSString*)imgName
{
    self.height = 50;
    _textTf.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _textTf.leftViewMode = UITextFieldViewModeAlways;
    UIView *vv = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 23, 25)];
    UIImageView *iv = [[UIImageView alloc] initWithImage:[UIImage imageContentWithFileName:imgName]];
    iv.y = 3;
    [vv addSubview:iv];
    _textTf.leftView = vv;
    _textTf.width = __SCREEN_SIZE.width - 30;
    _textTf.x = 15;
    _textTf.height = 25;
    _textTf.y = self.height/2.0 - _textTf.height/2.0;
    _textTf.font = [UIFont systemFontOfSize:15];
    _textTf.attributedPlaceholder  = [[NSAttributedString alloc] initWithString:_textTf.placeholder attributes:@{NSForegroundColorAttributeName:  kUIColorFromRGB(color_6)}];
    _textTf.secureTextEntry = YES;
    _textTf.keyboardType = UIKeyboardTypeASCIICapable;
    self.backgroundColor = kUIColorFromRGB(color_4);
    _textTf.backgroundColor = kUIColorFromRGB(color_4);
    _containerView.backgroundColor = kUIColorFromRGB(color_4);
}



- (IBAction)editChange:(UITextField *)textView {
    if(textView.markedTextRange != nil || _maxCount == 0)
        return;
    if (textView.text.length > _maxCount) {
        TOASTSHOW(@"标题最多只能输入25个字");
        textView.text = [textView.text substringToIndex:_maxCount];
    }
}

-(void)fitRegNextMode
{
      _textTf.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    self.height = 50;
    _textTf.width = __SCREEN_SIZE.width - 30;
    _textTf.x = 15;
    _textTf.height = 25;
    _textTf.y = self.height/2.0 - _textTf.height/2.0;
    _textTf.font = [UIFont systemFontOfSize:15];
    _textTf.attributedPlaceholder  = [[NSAttributedString alloc] initWithString:_textTf.placeholder attributes:@{NSForegroundColorAttributeName:  kUIColorFromRGB(color_6)}];
    UIView *vv = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 23, 25)];
       _textTf.leftViewMode = UITextFieldViewModeAlways;
    UIImageView *iv = [[UIImageView alloc] initWithImage:[UIImage imageContentWithFileName:@"lg_nick"]];
    iv.y = 3;
    [vv addSubview:iv];
    _textTf.leftView = vv;
}
-(UIButton *)getCodeBtn
{
    UIButton *btn = [self viewWithTag:98960];
    return btn;
}

-(void)fitMeetingMode{
    _textTf.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    self.height = 115;
    _textTf.width = __SCREEN_SIZE.width - 30;
    _textTf.x = 15;
    _textTf.height = 85;
    _textTf.y = self.height/2.0 - _textTf.height/2.0;
    _textTf.font = [UIFont systemFontOfSize:15];
//    _textTf.pla
}

-(void)fitPublishActMode
{
    
    UILabel *txtLb = [self.contentView viewWithTag:10332];
    if (!txtLb) {
        txtLb = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150, 40)];
        txtLb.tag = 10332;
        txtLb.x = 15;
        txtLb.y = 13;
        txtLb.text = @"活动地点";
        txtLb.numberOfLines = 2;
        txtLb.textColor = kUIColorFromRGB(color_6);
        txtLb.font = [UIFont systemFontOfSize:15];
    }
    [txtLb sizeToFit];
    
    [self.contentView addSubview:txtLb];
    _textTf.placeholder = @"";
        _textTf.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    self.height = 40;
        _textTf.width = __SCREEN_SIZE.width - 30 - 47 - txtLb.width;
        _textTf.x = txtLb.x + txtLb.width + 47;
        _textTf.height = 25;
        _textTf.y = self.height/2.0 - _textTf.height/2.0;
        _textTf.font = [UIFont systemFontOfSize:15];
        _textTf.attributedPlaceholder  = [[NSAttributedString alloc] initWithString:_textTf.placeholder attributes:@{NSForegroundColorAttributeName:  kUIColorFromRGB(color_6)}];
    
    
    }

-(void)fitCerMode
{
     self.height = 44;
    UILabel *txtLb = [self.contentView viewWithTag:10332];
    if (!txtLb) {
        txtLb = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150, 40)];
        txtLb.tag = 10332;
        txtLb.x = 15;
        txtLb.y = 13;
        txtLb.text = _dataDic[@"detail"];
        txtLb.numberOfLines = 1;
        txtLb.textColor = kUIColorFromRGB(color_6);
        txtLb.font = [UIFont systemFontOfSize:15];
    }
    [txtLb sizeToFit];
    txtLb.y = self.height/2.0 - txtLb.height/2.0;
    [self.contentView addSubview:txtLb];
    _textTf.placeholder = @"";
    _textTf.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
   
    _textTf.width = __SCREEN_SIZE.width - 30 - 47 - txtLb.width;
    _textTf.x = txtLb.x + txtLb.width + 47;
    _textTf.height = 25;
    _textTf.y = self.height/2.0 - _textTf.height/2.0;
    _textTf.font = [UIFont systemFontOfSize:15];
    _textTf.textAlignment = NSTextAlignmentRight;
    _textTf.keyboardType = UIKeyboardTypeDefault;
//    _textTf.attributedPlaceholder  = [[NSAttributedString alloc] initWithString:_textTf.placeholder attributes:@{NSForegroundColorAttributeName:  kUIColorFromRGB(color_6)}];
}

//-(void)fitPublishMode
//{
//    _textTf.placeholder = @"请输入标题（5-25个字）";
//    _textTf.width = __SCREEN_SIZE.width - 30;
//    _maxCount = 25;
//    _textTf.clearButtonMode = UITextFieldViewModeNever;
//}

-(void)fitRentHouseMode{
    _textTf.placeholder = @"标题（10-25个字）";
    _textTf.width = __SCREEN_SIZE.width - 30;
    _maxCount = 25;
    _textTf.clearButtonMode = UITextFieldViewModeNever;
}

-(void)fitEidtNickNameMode
{
    self.height = 45;
    _textTf.x = 15;
    _textTf.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _textTf.width = __SCREEN_SIZE.width - 30;
    _textTf.y = 0;
    _textTf.height = 45;
    //    _textTf.layer.borderColor = kUIColorFromRGB(color_lineColor).CGColor;
    _textTf.layer.borderWidth = 0;
    //    _textTf.layer.cornerRadius = 3;
    //    _textTf.layer.masksToBounds = YES;
    _textTf.textAlignment = NSTextAlignmentLeft;
    //    _textField.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    _textTf.leftViewMode = UITextFieldViewModeNever;
    //    UIView *vv2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 15, 15)];
    //    _textTf.leftView = vv2;
    _textTf.backgroundColor = kUIColorFromRGB(color_2);
    _containerView.y = 0;
    _containerView.height = 45;
    _containerView.x = 0;
    _containerView.backgroundColor = kUIColorFromRGB(color_2);
    self.backgroundColor = kUIColorFromRGB(color_2);
//    _textTf.placeholder = @"";
}
-(void)fitPublishSecHandModeB
{
     self.height = 45;

     _containerView.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _containerView.x = 0;
     _containerView.y = 0;
     _containerView.height = 46;
     _containerView.width = __SCREEN_SIZE.width;
     _containerView.layer.borderWidth = 0;
     //     _containerView.layer.borderColor = kUIColorFromRGB(color_lineColor).CGColor;

     _textTf.width = _containerView.width - 30;
     _textTf.height = _containerView.height;
     _textTf.x = 15;
     _textTf.y = _containerView.height/2.0 - _textTf.height/2.0;
     UIImageView *imgv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 13, 17)];
     imgv.image = [UIImage imageContentWithFileName:@"nav_pos"];
     UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 27, 17)];
     [v addSubview:imgv];
     _textTf.leftView = v;
     _textTf.leftViewMode = UITextFieldViewModeAlways;
  _textTf.font = [UIFont systemFontOfSize:14];
     _containerView.backgroundColor = kUIColorFromRGB(color_2);
     self.backgroundColor = kUIColorFromRGB(color_0xf0f0f0);
}

-(void)fitPublishSecHandModeC
{
     self.height = 45;

     _containerView.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _containerView.x = 0;
     _containerView.y = 0;
     _containerView.height = 46;
     _containerView.width = __SCREEN_SIZE.width;
     _containerView.layer.borderWidth = 0;
     //     _containerView.layer.borderColor = kUIColorFromRGB(color_lineColor).CGColor;

     _textTf.width = _containerView.width - 30;
     _textTf.height = _containerView.height;
     _textTf.font = [UIFont systemFontOfSize:14];
     _textTf.x = 15;
     _textTf.y = _containerView.height/2.0 - _textTf.height/2.0;
     UIImageView *imgv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 13, 17)];
     imgv.image = [UIImage imageContentWithFileName:@"nav_pos"];
     UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 27, 17)];
     [v addSubview:imgv];
     _textTf.leftView = v;
     _textTf.leftViewMode = UITextFieldViewModeAlways;
//     imgv.hidden = YES;
     _containerView.backgroundColor = kUIColorFromRGB(color_2);
     self.backgroundColor = kUIColorFromRGB(color_0xf0f0f0);
     
//     UIImageView *imgv2 = [self.contentView viewWithTag:973];
//     if (!imgv2) {
//          imgv2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 19, 19)];
//          imgv2.tag = 973;
//
//          imgv2.y = self.height/2.0 - imgv2.height/2.0;
//
//
//     }
//     imgv2.x = 15;
//     //    if (upDown) {
//     imgv2.image = [UIImage imageContentWithFileName:@"adr_add"];
//     [self.contentView addSubview:imgv2];
//     _textTf.x = imgv2.x + imgv2.width + 15;
     if([_dataDic[@"title" ] isEqualToString:@"请新增服务地址"])
     {
//          imgv2.hidden = NO;
          imgv.width = 19;
          imgv.height = 19;
          imgv.image = [UIImage imageContentWithFileName:@"adr_add"];
     }
     else
     {
//          imgv2.hidden = YES;
          imgv.width = 13;
          imgv.height = 17;
           imgv.image = [UIImage imageContentWithFileName:@"nav_pos"];
     }
          
}

-(void)fitPublishSecHandMode
{
     self.height = 45;
     _textTf.x = 15;
     _textTf.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _textTf.width = __SCREEN_SIZE.width - 30;
     _textTf.y = 0;
     _textTf.height = 45;
     //    _textTf.layer.borderColor = kUIColorFromRGB(color_lineColor).CGColor;
     _textTf.layer.borderWidth = 0;
     //    _textTf.layer.cornerRadius = 3;
     //    _textTf.layer.masksToBounds = YES;
     _textTf.textAlignment = NSTextAlignmentLeft;
     //    _textField.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
     _textTf.leftViewMode = UITextFieldViewModeNever;
     //    UIView *vv2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 15, 15)];
     //    _textTf.leftView = vv2;
     _textTf.backgroundColor = kUIColorFromRGB(color_2);
     _textTf.font = [UIFont systemFontOfSize:14];
     _containerView.y = 0;
     _containerView.height = 45;
     _containerView.x = 0;
     _containerView.backgroundColor = kUIColorFromRGB(color_2);
     self.backgroundColor = kUIColorFromRGB(color_2);

     UILabel *lb = [self.contentView viewWithTag:7333];
     if (!lb) {
          lb = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 40, 21)];
          lb.tag = 7333;
     }
          lb.text = _dataDic[@"detail"];
          lb.textColor = kUIColorFromRGB(color_8);
          lb.font = [UIFont systemFontOfSize:15];
          _textTf.rightView = lb;
          _textTf.rightViewMode = UITextFieldViewModeAlways;

}
-(void)fitFeedbackMode
{
     self.height = 45;
     self.clipsToBounds = YES;
     _containerView.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _containerView.x = 15;
     _containerView.y = 10;
     _containerView.height = 35;
     _containerView.width = __SCREEN_SIZE.width - 30;
     _containerView.layer.borderWidth = 0.5;
     _containerView.layer.borderColor = kUIColorFromRGB(color_lineColor).CGColor;
//     _containerView.layer.cornerRadius = 1;
     
//     UILabel *lb = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 40, 21)];
//     lb.text = @"";
//     lb.textColor = kUIColorFromRGB(color_1);
//     lb.font = [UIFont systemFontOfSize:14];
//     _textTf.leftView = lb;
//     _textTf.leftViewMode = UITextFieldViewModeAlways;
     _textTf.y = _containerView.height/2.0 - _textTf.height/2.0;
     _textTf.width = _containerView.width - 10;
     _containerView.backgroundColor = kUIColorFromRGB(color_2);
     self.backgroundColor = kUIColorFromRGB(color_0xf0f0f0);
}

-(void)fitApplyReturnMode
{
     [self fitFeedbackMode];
}

-(void)fitApplyReturnModeB:(NSString *)leftTitle
{
     self.height = 40;
     self.clipsToBounds = YES;
     _containerView.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _containerView.x = 0;
     _containerView.y = 0;
     _containerView.height = 40;
     _containerView.width = __SCREEN_SIZE.width;
     _containerView.layer.borderWidth = 0;
//     _containerView.layer.borderColor = kUIColorFromRGB(color_lineColor).CGColor;
     
     _textTf.width = _containerView.width;
     _textTf.height = _containerView.height;
     _textTf.x = 0;
     _textTf.y = _containerView.height/2.0 - _textTf.height/2.0;
    
     UILabel *lb = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 110, 14)];
     lb.text = leftTitle;
     lb.textColor = kUIColorFromRGB(color_5);
     lb.font = [UIFont systemFontOfSize:14];
     UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 125, 14)];
     [v addSubview:lb];
     _textTf.leftView = v;
     _textTf.leftViewMode = UITextFieldViewModeAlways;
     
     _containerView.backgroundColor = kUIColorFromRGB(color_2);
     self.backgroundColor = kUIColorFromRGB(color_0xf0f0f0);
}

-(void)fitModiPwdMode:(NSString*)text
{
     self.height = 45;
     _textTf.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _textTf.leftViewMode = UITextFieldViewModeAlways;
     UIView *vv = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 111, 25)];
     UILabel *iv = [[UILabel alloc] init];
     iv.y = 5;
     iv.x = 16;
     iv.width = 90;
     iv.height = 14;
     iv.text = text;
     iv.textColor = kUIColorFromRGB(color_1);
     iv.font = [UIFont systemFontOfSize:14];
     [vv addSubview:iv];
     _textTf.leftView = vv;
     _textTf.width = __SCREEN_SIZE.width ;
     _textTf.x = 0;
     _textTf.height = 15;
     _textTf.y =  14;//self.height/2.0 - _textTf.height/2.0;
     _textTf.font = [UIFont systemFontOfSize:13];
     _textTf.attributedPlaceholder  = [[NSAttributedString alloc] initWithString:_textTf.placeholder attributes:@{NSForegroundColorAttributeName:  kUIColorFromRGB(color_0xb0b0b0)}];
     _textTf.secureTextEntry = NO;
     //     _textTf.keyboardType = UIKeyboardTypePhonePad ;
     //     _textTf.layer.cornerRadius = 5;
     //     _textTf.layer.borderColor = kUIColorFromRGB(color_lineColor).CGColor;
     _textTf.layer.borderWidth = 0;
     //     _textTf.layer.masksToBounds = YES;
}

-(void)fitZhiMaAuthMode
{
     _textTf.x = 15;
     _textTf.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _textTf.width = __SCREEN_SIZE.width - 66;
     _textTf.y = 0;
     _textTf.height = 52;
     //    _textTf.layer.borderColor = kUIColorFromRGB(color_lineColor).CGColor;
     _textTf.layer.borderWidth = 0;
     //    _textTf.layer.cornerRadius = 3;
     //    _textTf.layer.masksToBounds = YES;
     _textTf.textAlignment = NSTextAlignmentLeft;
     //    _textField.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
     _textTf.leftViewMode = UITextFieldViewModeNever;
     //    UIView *vv2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 15, 15)];
     //    _textTf.leftView = vv2;
     _textTf.backgroundColor = kUIColorFromRGB(color_F2F2F2);
     _textTf.font = [UIFont systemFontOfSize:13];
     _containerView.y = 0;
     _containerView.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _containerView.height = 52;
     _containerView.x = 33;
     _containerView.backgroundColor = kUIColorFromRGB(color_F2F2F2);
     self.backgroundColor = kUIColorFromRGB(color_F2F2F2);
     UILabel *rlb = [self.contentView viewWithTag:6333];
     if (!rlb) {
          rlb = [[UILabel alloc] initWithFrame:CGRectMake(__SCREEN_SIZE.width - 33, 0, 0.5, 52)];
          rlb.tag = 6333;
          rlb.backgroundColor = kUIColorFromRGB(color_lineColor);
     }
     [self.contentView addSubview:rlb];

     UILabel *llb = [self.contentView viewWithTag:9333];
     if (!llb) {
          llb = [[UILabel alloc] initWithFrame:CGRectMake(33, 0, 0.5, 52)];
          llb.tag = 9333;
           llb.backgroundColor = kUIColorFromRGB(color_lineColor);
     }
     [self.contentView addSubview:llb];

     UILabel *lb = [self.contentView viewWithTag:7333];
     if (!lb) {
          lb = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 40, 21)];
          lb.tag = 7333;
     }
     lb.text = _dataDic[@"detail"];
     lb.textColor = kUIColorFromRGB(color_8);
     lb.font = [UIFont systemFontOfSize:15];
     _textTf.rightView = lb;
     _textTf.rightViewMode = UITextFieldViewModeAlways;

     self.height = 52;
}
@end
