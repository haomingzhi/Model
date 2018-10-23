//
//  WCYLoginViewController.h
//  SCWCYClient
//
//  Created by apple on 14-5-22.
//  Copyright (c) 2014年 SunnadaSoft. All rights reserved.
//


#import "BUSystem.h"

typedef enum {
    LOGIN =0,//登录
    REGISTER,//注册
    USERNAME,//用户名
    PASSWORD,//密码
    RELOGIN,
}ViewControllerTpye;

@interface LoginViewController : JYBaseViewController<MyTextFieldDelegate,UITextFieldDelegate>
@property (nonatomic, assign)NSInteger mode;//0 push 1 present
@property (weak, nonatomic) IBOutlet MyInputView *userNameTextField;//用户名
@property (weak, nonatomic) IBOutlet MyInputView *userPwdTextField;//密码

@property (weak, nonatomic) IBOutlet UIImageView *NameImage;
@property (weak, nonatomic) IBOutlet UIImageView *PwdImage;
//@property (nonatomicku,assign) BOOL _isPwd;//是否忘记密码

@property (weak, nonatomic) IBOutlet UIButton *userLoginBtn;//登录按钮
@property (weak, nonatomic) IBOutlet UIButton *buttonRemember;//
@property (weak, nonatomic) IBOutlet UIButton *identifyingCodeBtn;//验证码
@property (weak, nonatomic) IBOutlet UIButton *headPortrait;//头像按钮

//@property (nonatomic, assign)ViewControllerTpye type;//界面类型

@property (weak, nonatomic) IBOutlet UIButton *buttonForget;//忘记密码按钮

@property (weak, nonatomic) IBOutlet UIButton *buttonReigster;//注册按钮
-(void)showYouGetOut:(NSString *)str;
@property (nonatomic)BOOL isBackPwd;

- (IBAction)loginHandle:(id)sender;//登录点击事件
- (IBAction)remPwdHandle:(id)sender;
- (IBAction)forgetPwdHandle:(id)sender;//忘记密码
- (IBAction)handleTextFieldReturn:(id)sender;
- (IBAction)registerHandle:(id)sender;//注册
//第三方登陆
- (IBAction)handleThirdLogin:(id)sender;
@property (nonatomic,assign) BOOL isPushHome;

+(void)toLogin:(UIViewController *)pvc;
-(void)resetUserInfo;
@end
