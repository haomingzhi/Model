//
//  MyPwdTextField.h
//  MiniClient
//
//  Created by apple on 14-8-6.
//  Copyright (c) 2014年 SunnadaSoft. All rights reserved.
//

#import "MyTextField.h"

/*密码输入框，最多支持6位*/
@interface MyPwdTextField : MyTextField
@property(nonatomic)BOOL isShowBorder;//每个圆点都在框内
@property(nonatomic)CGFloat pwdWidth;//密码小框宽度
@property(nonatomic,strong)UIColor* pwdBorderColor;
@end
