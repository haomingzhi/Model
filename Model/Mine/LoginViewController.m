//
//  WCYLoginViewController.m
//  SCWCYClient
//
//  Created by apple on 14-5-22.
//  Copyright (c) 2014年 SunnadaSoft. All rights reserved.
//

#import "LoginViewController.h"
//#import "RegisterViewController.h"
#import "JYCommonTool.h"
#import "ZLPhotoPickerViewController.h"
#import "ZLPhotoAssets.h"
#import "MineViewController.h"
#import "TabViewControllerManager.h"
#import "CityChoiceViewController.h"
#import "RegisterViewController.h"
#import "ForgetPwdViewController.h"
//#import <UniversalFramework/UMSocial.h>
//#import <UniversalFramework/WXApi.h>
//#import "FindInfoViewController.h"

@interface LoginViewController ()<UserRegisterDelegate,MyTextFieldDelegate,ZLPhotoPickerViewControllerDelegate,UIActionSheetDelegate>
{
     ZLPhotoPickerViewController *_pickerVC;
     IBOutlet UIImageView *_loginBackgroundImgV;
     __weak IBOutlet UILabel *_division;//分割线
     __weak IBOutlet UILabel *lbl1;//密码Lbl
     __weak IBOutlet UILabel *lbl;//用户名Lbl
     __weak IBOutlet UIView *viewThirdLoginContainer;
     __weak IBOutlet UILabel *_userName;
     UILabel *identifyingCode;
     BOOL isRememPwd;
     int count;
     BOOL getRandomSucessed;
     NSTimer *timer;
     IBOutlet UIButton *_qqBtn;
     IBOutlet UIButton *_wxBtn;
     IBOutlet UILabel *_loginTipLb;
     IBOutlet UILabel *_seplitLineLb;
     IBOutlet UILabel *_seplitLine2Lb;
     UIButton *_curTabBtn;
     UIButton *_eyesBtn;
     UIView *_normLoginPhoneVv;
     UIView *_normLoginPwdVv;

     UIView *_quickLoginPhoneVv;
     UIView *_quickLoginPwdVv;
}
@end

@implementation LoginViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{

     self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
     if (self) {
          // Custom initialization
          [BSUtility saveDefault:BU_K_VERSION AndValue:busiSystem.appVer];
          [BSUtility saveDefault:BU_K_APPID AndValue:busiSystem.appId];
          isRememPwd = YES;
     }
     return self;
}

- (void)viewDidLoad
{
     [super viewDidLoad];
     self.edgesForExtendedLayout = UIRectEdgeTop;


     //    self.title = @"";
     //    self.view.backgroundColor =kUIColorFromRGB(color_F3F3F3);
     self.navigationController.view.backgroundColor = kUIColorFromRGB(color_2);
     self.title = @"";
     self.navigationController.navigationBar.barTintColor = [UIColor clearColor];
     self.userNameTextField.delegate = self;
     self.userNameTextField.kbMovingView = self.view;
     _userNameTextField.clearButtonMode = UITextFieldViewModeWhileEditing;

     self.userNameTextField.leftViewMode = UITextFieldViewModeAlways;
     self.userNameTextField.x = 42;
     self.userPwdTextField.x = 42;
     self.userPwdTextField.width = __SCREEN_SIZE.width - 42*2;
     self.userNameTextField.width = __SCREEN_SIZE.width - 42*2;
     self.userNameTextField.y = 226;
     _eyesBtn = [UIButton new];
     _eyesBtn.width = 30;
     _eyesBtn.height = 30;
     [_eyesBtn setImage:[UIImage imageContentWithFileName:@"eyes"] forState:UIControlStateNormal];
     [_eyesBtn setImage:[UIImage imageContentWithFileName:@"eyesClose"] forState:UIControlStateSelected];
     [_eyesBtn addTarget:self action:@selector(showPwdHandle:) forControlEvents:UIControlEventTouchUpInside];
     _eyesBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
     _userPwdTextField.rightViewMode = UITextFieldViewModeAlways;
     self.userPwdTextField.rightView = _eyesBtn;
     self.userPwdTextField.secureTextEntry = !_eyesBtn.selected;
     self.userPwdTextField.y = self.userNameTextField.y + self.userNameTextField.height +30;

     lbl.height = 0.5;
     lbl.width = __SCREEN_SIZE.width - 42*2;
     lbl.x = 42;
     lbl.backgroundColor = kUIColorFromRGB(color_lineColor);
     lbl.y = self.userNameTextField.y + _userNameTextField.height +10;

     self.userPwdTextField.y = lbl.y + lbl.height +10;

     lbl1.height = 0.5;
     lbl1.width = __SCREEN_SIZE.width - 42*2;
     lbl1.x = 42;
     lbl1.backgroundColor = kUIColorFromRGB(color_lineColor);
     lbl1.y = self.userPwdTextField.y + _userPwdTextField.height +10;

     UIView *qv = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 23, 14)];
     UIImageView *iqv = [[UIImageView alloc] initWithImage:[UIImage imageContentWithFileName:@"login_phone2"]];
     iqv.y = qv.height/2.0 - iqv.height/2.0;
     //     qv.width = 23;
     [qv addSubview:iqv];
     _quickLoginPhoneVv = qv;

     UIView *vv = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 23, 25)];
     UIImageView *iv = [[UIImageView alloc] initWithImage:[UIImage imageContentWithFileName:@"login_phone"]];
     iv.y = vv.height/2.0 - iv.height/2.0;
     _normLoginPhoneVv = vv;
     [vv addSubview:iv];
     self.userNameTextField.leftView = vv;
     //    self.userNameTextField.leftMargin = 25;

     self.userPwdTextField.leftViewMode = UITextFieldViewModeAlways;

     UIView *vq = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 23, 10)];
     UIImageView *iw = [[UIImageView alloc] initWithImage:[UIImage imageContentWithFileName:@"login_code"]];
     iw.y = iw.height/2.0 - iw.height/2.0;
     [vq addSubview:iw];
     _quickLoginPwdVv = vq;


     UIView *vv2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 23, 25)];
     UIImageView *iv2 = [[UIImageView alloc] initWithImage:[UIImage imageContentWithFileName:@"login_pwd"]];
     iv2.y = vv2.height/2.0 - iv2.height/2.0;
     [vv2 addSubview:iv2];
     _normLoginPwdVv = vv2;
     self.userPwdTextField.leftView = vv2;

     self.userPwdTextField.rightViewMode = UITextFieldViewModeAlways;
     //明文
     //     UIButton *vv3 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
     //    [vv3 setImage:[UIImage imageContentWithFileName:@"eyes"] forState:UIControlStateNormal];
     //    vv3.contentHorizontalAlignment = UIViewContentModeRight;
     //    [vv3 addTarget:self action:@selector(showPwd:) forControlEvents:UIControlEventTouchUpInside];
     //    self.userPwdTextField.rightView = vv3;



     //    [_userLoginBtn corner:[UIColor clearColor] radius:4 borderWidth:0];
     [_headPortrait corner:[UIColor clearColor] radius:15 borderWidth:0];

     self.userPwdTextField.delegate = self;
     self.userPwdTextField.kbMovingView = self.view;
     _userPwdTextField.clearButtonMode = UITextFieldViewModeWhileEditing;

     [self.buttonReigster setBackgroundColor:[UIColor clearColor]];
     [self.buttonReigster setTitleColor:kUIColorFromRGB(color_5) forState:UIControlStateNormal];
     [_userLoginBtn setBackgroundColor:kUIColorFromRGB(color_3)];
     [_userLoginBtn setTitleColor:kUIColorFromRGB(color_2) forState:UIControlStateNormal] ;
     _userLoginBtn.x = 42;
     _userLoginBtn.width = __SCREEN_SIZE.width - 42*2;

     //注册
     _buttonReigster.x = 37;
     //    _buttonReigster.autoresizingMask = UIViewAutoresizingFlexibleRightMargin |UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleTopMargin;
     _buttonReigster.contentHorizontalAlignment = UIViewContentModeLeft;
     _buttonReigster.width = 200;
     _buttonReigster.titleLabel.font = [UIFont systemFontOfSize:13];
     [_buttonReigster setTitle:@"手机号码首次登录将为您自动注册" forState:UIControlStateNormal];
     [_buttonReigster setTitleColor:kUIColorFromRGB(color_0xb0b0b0) forState:UIControlStateNormal];
     _buttonReigster.y = lbl1.y + lbl1.height + 20;
     _buttonReigster.userInteractionEnabled = YES;
     _buttonReigster.hidden = NO;

     //忘记密码
     //     _buttonForget.autoresizingMask = UIViewAutoresizingFlexibleRightMargin |UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleTopMargin;
     [_buttonForget setTitleColor:kUIColorFromRGB(color_0xb0b0b0) forState:UIControlStateNormal];
     _buttonForget.y = _buttonReigster.y;
     _buttonForget.x = __SCREEN_SIZE.width - 42- _buttonForget.width;
     _buttonForget.hidden = YES;
     _buttonReigster.userInteractionEnabled = NO;

     _userLoginBtn.y = lbl1.y + lbl1.height +80;
     [_userLoginBtn setBackgroundColor:kUIColorFromRGB(color_0xb0b0b0)];
     _userLoginBtn.layer.cornerRadius = _userLoginBtn.height/2.0;
     //     _userLoginBtn.layer.masksToBounds = YES;
     _userLoginBtn.layer.shadowColor = kUIColorFromRGB(color_0xf74056).CGColor;
     _userLoginBtn.layer.shadowOffset = CGSizeMake(0, 0);
     _userLoginBtn.layer.shadowRadius = 0.0;
     _userLoginBtn.layer.shadowOpacity = 0.43;

     _loginBackgroundImgV.image = [UIImage imageContentWithFileName:@"loginBg"];
     _loginBackgroundImgV.hidden = NO;
     _loginBackgroundImgV.height = __SCREEN_SIZE.height;
     _loginBackgroundImgV.width = __SCREEN_SIZE.width;
     [self addGesture];

     viewThirdLoginContainer.hidden = YES;
     viewThirdLoginContainer.userInteractionEnabled = NO;
     //     viewThirdLoginContainer.y = 480;
     //     viewThirdLoginContainer.hidden = NO;
     //         [self initThirdLogin];
     UIView *containreView = [UIView new];
     containreView.width = __SCREEN_SIZE.width - 10;
     containreView.height = __SCREEN_SIZE.height - 140;
     containreView.layer.cornerRadius = 12;
     containreView.layer.masksToBounds = YES;
     containreView.y = 159;
     containreView.x = 5;
     UIView *sbConView = [UIView new];
     sbConView.height = containreView.height - 45;
     sbConView.y = 45;
     sbConView.width = containreView.width;
     sbConView.x = 0;
     sbConView.backgroundColor = kUIColorFromRGB(color_2);
     [containreView addSubview:sbConView];
     [self.view insertSubview:containreView aboveSubview:_loginBackgroundImgV];

     UIButton *tab1Btn = [UIButton new];
     tab1Btn.height = 45;
     tab1Btn.backgroundColor = kUIColorFromRGB(color_2);
     tab1Btn.width = containreView.width/2.0;
     [tab1Btn setTitle:@"快捷登录" forState:UIControlStateNormal];
     [tab1Btn setTitleColor:kUIColorFromRGB(color_3) forState:UIControlStateNormal];
     [containreView addSubview:tab1Btn];
     tab1Btn.tag = 7722;
     [tab1Btn addTarget:self action:@selector(changeTab:) forControlEvents:UIControlEventTouchUpInside];
     _curTabBtn = tab1Btn;

     UIButton *tab2Btn = [UIButton new];
     tab2Btn.height = 45;
     tab2Btn.tag = 7711;
     tab2Btn.backgroundColor = kUIColorFromRGBWithAlpha(color_3, 0.3);
     tab2Btn.width = containreView.width/2.0;
     tab2Btn.x = tab2Btn.width;
     [tab2Btn setTitle:@"普通登录" forState:UIControlStateNormal];
     [tab2Btn setTitleColor:kUIColorFromRGB(color_2) forState:UIControlStateNormal];
     [containreView addSubview:tab2Btn];
     [tab2Btn addTarget:self action:@selector(changeTab:) forControlEvents:UIControlEventTouchUpInside];
     self.identifyingCodeBtn.y = _userPwdTextField.y;
     [_identifyingCodeBtn setTitleColor:kUIColorFromRGB(color_0xf82D45) forState:UIControlStateNormal];
     _identifyingCodeBtn.layer.cornerRadius = 6.0;
     _identifyingCodeBtn.layer.borderColor = kUIColorFromRGB(color_0xf82D45).CGColor;
     _identifyingCodeBtn.layer.borderWidth = 0.5;
     _identifyingCodeBtn.hidden = YES;



     _identifyingCodeBtn.hidden = NO;
     _identifyingCodeBtn.userInteractionEnabled = YES;
     _userPwdTextField.rightView = nil;
     _userPwdTextField.secureTextEntry = NO;
     _userPwdTextField.width = 160;
     _userPwdTextField.leftView = _quickLoginPwdVv;
     _userPwdTextField.text = @"";
     _userNameTextField.leftView = _quickLoginPhoneVv;
     _userPwdTextField.keyboardType = UIKeyboardTypePhonePad;

     _userPwdTextField.placeholder = @"请输入验证码";
     //     _userPwdTextField.delegate = self;
     [_userNameTextField addTarget:self action:@selector(textFieldDidChange) forControlEvents:UIControlEventEditingChanged];

     [_userPwdTextField addTarget:self action:@selector(textFieldDidChange) forControlEvents:UIControlEventEditingChanged];


     //app协议
     UIButton *agreementBtn = [[UIButton alloc]initWithFrame:CGRectMake(__SCREEN_SIZE.width/2.0 - 110, __SCREEN_SIZE.height-TABBARNONEHEIGHT-30-15, 220, 15)];
     [agreementBtn fitImgAndTitleMode];
     agreementBtn.customTitleLb.text = @"登录即代表已阅读并同意";
     agreementBtn.customTitleLb.font = [UIFont systemFontOfSize:12];
     agreementBtn.customTitleLb.textColor = kUIColorFromRGB(color_5);
     agreementBtn.customTitleLb.textAlignment = NSTextAlignmentCenter;
     [agreementBtn.customTitleLb sizeToFit];
     agreementBtn.customTitleLb.x = 0;
     agreementBtn.customTitleLb.y = agreementBtn.height/2.0 - agreementBtn.customTitleLb.height/2.0;

     agreementBtn.customDetailLb.text = @"《app服务协议》";
     agreementBtn.customDetailLb.font = [UIFont systemFontOfSize:12];
     agreementBtn.customDetailLb.textColor = kUIColorFromRGB(color_0xf82D45);
     agreementBtn.customDetailLb.textAlignment = NSTextAlignmentCenter;
     [agreementBtn.customDetailLb sizeToFit];
     agreementBtn.customDetailLb.x = agreementBtn.customTitleLb.x+agreementBtn.customTitleLb.width;
     agreementBtn.customDetailLb.y = agreementBtn.customTitleLb.y;

     [agreementBtn addTarget:self action:@selector(showAgreeMentAction) forControlEvents:UIControlEventTouchUpInside];
     [self.view addSubview:agreementBtn];
     if(__LESSTHENIPHONE5)
     {
          agreementBtn.y = __SCREEN_SIZE.height-TABBARNONEHEIGHT- 30;
     }
//     if (@available(iOS 11.0, *)) {
//          ((UIScrollView *)self.view).contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
//     } else {
//          self.automaticallyAdjustsScrollViewInsets = NO;
//     }
}

-(void)showAgreeMentAction{
//     FindInfoViewController *vc = [FindInfoViewController new];
//     vc.name = @"app服务协议";
//     vc.content = busiSystem.agent.config.userAgreement?:@"";
//     [self.navigationController pushViewController:vc animated:YES];
}


-(void)showPwdHandle:(UIButton *)btn
{
     btn.selected = !btn.selected;
     _userPwdTextField.secureTextEntry = !btn.selected;
}
-(void)changeTab:(UIButton *)btn
{
     if (btn.selected) {
          return;
     }
     btn.selected = !btn.selected;
     if (btn.selected) {
          btn.backgroundColor = kUIColorFromRGB(color_2);
          [btn setTitleColor:kUIColorFromRGB(color_3) forState:UIControlStateNormal];
          //          _userPwdTextField
          if (_curTabBtn != btn) {
               _curTabBtn.backgroundColor = kUIColorFromRGBWithAlpha(color_3, 0.3);
               [_curTabBtn setTitleColor:kUIColorFromRGB(color_2) forState:UIControlStateNormal];
               _curTabBtn.selected = NO;
          }
          if (btn.tag == 7722) {//快捷登录
               _identifyingCodeBtn.hidden = NO;
               _identifyingCodeBtn.userInteractionEnabled = YES;
               _userPwdTextField.rightView = nil;
               _userPwdTextField.secureTextEntry = NO;
               _userPwdTextField.width = 160;
               _userPwdTextField.leftView = _quickLoginPwdVv;
               _userPwdTextField.text = @"";
               _userNameTextField.leftView = _quickLoginPhoneVv;
               _userPwdTextField.keyboardType = UIKeyboardTypePhonePad;

               _userPwdTextField.placeholder = @"请输入验证码";
               _buttonReigster.hidden = NO;
               _buttonForget.hidden = YES;
               _buttonForget.userInteractionEnabled = NO;
          }
          else
          {//密码登录
               _identifyingCodeBtn.hidden = YES;
               _userPwdTextField.rightView = _eyesBtn;
               _userPwdTextField.width = __SCREEN_SIZE.width - 42*2;
               _userPwdTextField.secureTextEntry = ! _eyesBtn.selected;
               _userPwdTextField.leftView = _normLoginPwdVv;
               _userNameTextField.leftView = _normLoginPhoneVv;
               _userPwdTextField.text = @"";
               _userPwdTextField.keyboardType = UIKeyboardTypeDefault;
               _userPwdTextField.placeholder = @"请输入密码";
               _buttonReigster.hidden = YES;
               _buttonForget.hidden = NO;
               _buttonForget.userInteractionEnabled = YES;
          }
          _curTabBtn = btn;
          [self textFieldDidChange];
     }
     else
     {
          btn.backgroundColor = kUIColorFromRGBWithAlpha(color_3, 0.3);
          [btn setTitleColor:kUIColorFromRGB(color_2) forState:UIControlStateNormal];
     }
}

-(void)addGesture{
     UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction)];
     [self.view addGestureRecognizer:tap];

}
-(void)tapAction{
     [self.view endEditing:YES];
}

-(void)showPwd:(id)o
{
     _userPwdTextField.secureTextEntry = !_userPwdTextField.secureTextEntry;
}

//-(void)viewWillAppear:(BOOL)animated
//{

//    CGSize navBarSize = CGSizeMake(__SCREEN_SIZE.width, __NAVBAR_HEIGHT + __STATUSBAR_HEIGHT);
//    //    //   if (_tableView.contentOffset.y >= _tableView.contentInset.top && _tableView.contentOffset.y <= _tableView.contentInset.top + 3) {
//    [self.navigationController.navigationBar  setBackgroundImage:[UIImage imageWithColor:kUIColorFromRGBWithAlpha(color_mainTheme,0) withBounds:CGRectMake(0, 0, navBarSize.width,navBarSize.height)] forBarPosition:UIBarPositionTopAttached barMetrics:UIBarMetricsDefault];
//    //    //    }
//    //    _navLineImg = self.navigationController.navigationBar.shadowImage;
//    self.navigationController.navigationBar.translucent = YES;
//    self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
//}



- (void)pushLoginViewControllerType:(ViewControllerTpye)type
{
     LoginViewController * loginVC =[[LoginViewController alloc] init];
     //    loginVC.type =type;
     [self.navigationController pushViewController:loginVC animated:YES];
}

//初始化第三方登陆
-(void) initThirdLogin
{
     //    NSInteger starX = 32;
     //    NSInteger width = 44;
     //    NSInteger PaddingX = (__SCREEN_SIZE.width - starX *2 -width *3 )/2;
     //    UIButton *buttonQQ = (UIButton *)[viewThirdLoginContainer viewWithTag:2];
     //    buttonQQ.frame = CGRectMake(starX + width + PaddingX, buttonQQ.frame.origin.y, buttonQQ.frame.size.width, buttonQQ.frame.size.height);
     //    [BSUtility loopView:viewThirdLoginContainer condition:^BOOL(UIView *v) {
     //        return [v isKindOfClass:[UIButton class]];
     //    } finded:^BOOL(UIView *findedView) {
     //        UIButton *b = (UIButton *)findedView;
     //        [b setButtonTitleStyle:ButtonTitleStyleBottom padding:5];
     //        return NO;
     //    }];
     if (__IPHONE5) {
          viewThirdLoginContainer.height = 112;
          viewThirdLoginContainer.y = __SCREEN_SIZE.height - viewThirdLoginContainer.height ;
     }
     else if(__LESSTHENIPHONE5)
     {
          viewThirdLoginContainer.y = __SCREEN_SIZE.height - viewThirdLoginContainer.height - 64;
     }
     _qqBtn.height = 70;
     _qqBtn.customTitleLb.textColor = kUIColorFromRGB(color_2);
     _qqBtn.customTitleLb.text = @"QQ";
     _qqBtn.width = 60;
     _qqBtn.customTitleLb.y = 55;
     _qqBtn.customTitleLb.x = 5;
     _qqBtn.customTitleLb.width = 50;
     _qqBtn.customImgV.image = [UIImage imageContentWithFileName:@"login_qq"];
     _qqBtn.customImgV.width = 50;
     _qqBtn.customImgV.height = 50;
     _qqBtn.customImgV.x = 5;
     _qqBtn.customImgV.y = 0;
     _qqBtn.x = __SCREEN_SIZE.width/2.0 + 25;
     _wxBtn.height = 70;
     _wxBtn.customTitleLb.textColor = kUIColorFromRGB(color_2);
     _wxBtn.customTitleLb.text = @"微信";
     _wxBtn.customTitleLb.width = 50;
     _wxBtn.width = 60;
     _wxBtn.customTitleLb.y = 55;
     _wxBtn.customTitleLb.x = 5;
     _wxBtn.customImgV.image = [UIImage imageContentWithFileName:@"login_weixin"];
     _wxBtn.customImgV.width = 50;
     _wxBtn.customImgV.height = 50;
     _wxBtn.customImgV.x = 5;
     _wxBtn.customImgV.y = 0;
     _wxBtn.x = __SCREEN_SIZE.width/2.0 - 25 - _qqBtn.width;
     if(![UMWarp hasInstalledWx])
     {
          _wxBtn.hidden = YES;
          _qqBtn.x = __SCREEN_SIZE.width/2.0 - _qqBtn.width/2.0;
     }


     _loginTipLb.textColor = kUIColorFromRGB(color_lineColor);
     _loginTipLb.font = [UIFont systemFontOfSize:14];
     CGSize s = [_loginTipLb.text size:_loginTipLb.font constrainedToSize:CGSizeMake(200, 20)];
     _loginTipLb.width = s.width;
     _loginTipLb.x = __SCREEN_SIZE.width/2.0 - _loginTipLb.width/2.0;

     _seplitLineLb.height = 0.5;
     _seplitLineLb.width = (__SCREEN_SIZE.width - 110 - _loginTipLb.width)/2.0;
     _seplitLineLb.x = 30;
     _seplitLineLb.backgroundColor = kUIColorFromRGB(color_lineColor);

     _seplitLine2Lb.height = 0.5;
     _seplitLine2Lb.width = _seplitLineLb.width;
     _seplitLine2Lb.x = __SCREEN_SIZE.width - 30 - _seplitLine2Lb.width;
     _seplitLine2Lb.backgroundColor = kUIColorFromRGB(color_lineColor);

}

//-(void)viewWillAppear:(BOOL)animated
//{
//
//////    self.title = @"登陆";
////    //[super viewWillAppear:animated];
////    //self.navigationController.navigationBarHidden = YES;
//}

-(void)viewDidAppear:(BOOL)animated
{
     //    if (!busiSystem.agent.isCancel && !busiSystem.agent.isLogin && self.buttonRemember.selected && self.userNameTextField.text.length >0 && self.userPwdTextField.text.length >0 )
     //    {
     //        [self doLogin];
     //    }}
}
-(void)viewWillDisappear:(BOOL)animated
{
     CGSize navBarSize = CGSizeMake(__SCREEN_SIZE.width, __NAVBAR_HEIGHT + __STATUSBAR_HEIGHT);
     [self.navigationController.navigationBar  setBackgroundImage:[UIImage imageWithColor:kUIColorFromRGBWithAlpha(color_2,1) withBounds:CGRectMake(0, 0, navBarSize.width,navBarSize.height)] forBarPosition:UIBarPositionTopAttached barMetrics:UIBarMetricsDefault];
     self.navigationController.navigationBar.translucent = NO;
     self.navigationController.view.backgroundColor = kUIColorFromRGB(color_2);
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}

//-(void)viewDidDisappear:(BOOL)animated
//{
//      CGSize navBarSize = CGSizeMake(__SCREEN_SIZE.width, __NAVBAR_HEIGHT + __STATUSBAR_HEIGHT);
//    [self.navigationController.navigationBar  setBackgroundImage:[UIImage imageWithColor:kUIColorFromRGBWithAlpha(color_2,1) withBounds:CGRectMake(0, 0, navBarSize.width,navBarSize.height)] forBarPosition:UIBarPositionTopAttached barMetrics:UIBarMetricsDefault];
//}

- (void)didReceiveMemoryWarning
{
     [super didReceiveMemoryWarning];
     // Dispose of any resources that can be recreated.
}



#pragma mark -- Notification Mehthod

-(void)updateCheckNotification:(BSNotification*)noti
{
     if (noti.error.code == 1)
     {
          if (busiSystem.version.isTip)
          {
               //            //弹出框出现提示。。
               //            MiniVersionCheckTipViewController *vc = [[MiniVersionCheckTipViewController alloc] init];
               //            MyDialog *dlg = [[MyDialog alloc] initWithViewController:vc];
               //            [dlg show];
               return;
          }
     }
}

-(void)loginNotification:(BSNotification*)noti
{
     //    BASENOTIFICATION(noti);
     if (noti.error.code == 0) {
          busiSystem.agent.isLogin = YES;
//          HUDDISMISS;
          //    if (!busiSystem.agent.isLogin) {
          //        HUDCRY(busiSystem.agent.RetMsg, 2);
          //        return;
          //    }
          [self finishLogin];
          //          [busiSystem.agent checkAuth:nil callback:nil];
     }
     else
     {
          //        if ([noti.error.domain isEqualToString:@"Token已过期失效"]) {
          //            [busiSystem.agent checkAuth:self callback:@selector(checkAuthNotification:)];
          //        }
          //        else
//          HUDCRY(noti.error.domain, 2);

     }
     //    if (noti.error.code ==0) {\
     //        HUDDISMISS;\
     //    }\
     //    else {\
     //        if ([self isKindOfClass:NSClassFromString(@"BaseViewController")] && [busiSystem.errorMonitors indexOfObject:@(noti.error.code)] != NSNotFound)\
     //        {\
     //            BSNetworkCommand *cmd = noti.cmd;\
     //            [self performSelector:@selector(addToHistoryCommand:) withObject:cmd];\
     //            [self performSelector:@selector(showLoadingFailureCoverView:) withObject:@"加载失败,请点击屏幕重试"];\
     //            [SVProgressHUD dismiss];\
     //        }\
     //        else \
     //            HUDCRY(noti.error.domain, TOAST_LONGERTIMER); \
     //        return;\
     //    }\

     //    [self setUserMessage];

}

-(void)checkAuthNotification:(BSNotification *)noti
{
     [self doLogin];

}
-(void)finishLogin
{
     busiSystem.agent.isNeedRefreshTabD = YES;
     busiSystem.agent.isNeedRefreshTabC = YES;
     busiSystem.agent.isNeedRefreshTabB = YES;
     busiSystem.agent.isNeedRefreshTabA = YES;
     //    UITabBarController *tbVc = (UITabBarController *)self.view.window.rootViewController;
     //    tbVc.selectedIndex = 0;
     if (self.handleGoBack) {
          self.handleGoBack(@{});
     }
     [self dismissViewControllerAnimated:YES completion:nil];
     [self.navigationController popToRootViewControllerAnimated:YES];
     busiSystem.agent.password =  self.userPwdTextField.text;
     busiSystem.agent.tel = self.userNameTextField.text;
     [BUPushManager setTags:nil alias:busiSystem.agent.tel callbackSelector:@selector(tagsAliasCallback:tags:alias:) object:self];
     self.userPwdTextField.text = @"";
     self.userNameTextField.text = @"";
     busiSystem.agent.isDaySigin = NO;

     //     [[NSNotificationCenter defaultCenter] postNotificationName:@"login" object:nil];
}

- (void)tagsAliasCallback:(int)iResCode tags:(NSSet*)tags alias:(NSString*)alias {
     NSLog(@"rescode2: %d, \ntags: %@, \nalias: %@\n", iResCode, tags , alias);
}
-(void)checkVerifyNotification:(BSNotification*)noti
{
     //    BASENOTIFICATION(noti);
     if (noti.error.code == 0) {
//          HUDDISMISS;
          busiSystem.agent.regModel.Phone =_userNameTextField.text;
          if (_isBackPwd==NO) {
               [self pushLoginViewControllerType:USERNAME];
          }
          else{
               //        RegisterViewController * rVC =[[RegisterViewController alloc]initWithType:BUPASSWORDTYPE_REGISTER];
               //        rVC.isBackPwd =self.isBackPwd;
               //        [self.navigationController pushViewController:rVC animated:YES];
          }
     }
     else
     {
//          HUDCRY(noti.error.domain, 1);
     }

}

-(void)resetUserInfo
{
     NSInteger phoneNumble =[_userNameTextField.text integerValue];
     NSString *name = [self.userNameTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@" "]];
     NSString *pwd = [self.userPwdTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@" "]];
     if (name.length == 0)
     {
          TOASTSHOWUNDERVIEW(@"手机号不能为空！", self.userNameTextField, CGPointMake(0,10));
          return;
     }
     else if (name.length < 12&&phoneNumble ==0)
     {
          TOASTSHOW(@"请输入11位手机号！");
          return;
     }
     else if (pwd.length ==0)
     {
          TOASTSHOWUNDERVIEW(@"验证码不能为空！", self.userPwdTextField, CGPointMake(0,10));
          return;
     }
     else
     {
          [busiSystem.agent checkVerify:_userNameTextField.text Verify:_userPwdTextField.text observer:self callback:@selector(checkVerifyNotification:)];
     }
     //    NSNumber * isRemember =[[NSUserDefaults standardUserDefaults]objectForKey:@"isRemember"];
     //    if (![isRemember boolValue])
     //    {
     //        [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"account"];
     //        [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"password"];
     //        [[NSUserDefaults standardUserDefaults]setObject:[NSNumber numberWithBool:false]
     //                                                 forKey:@"isRemember"];
     //        [[NSUserDefaults standardUserDefaults]synchronize];
     //    }
}



-(void)goSetPwd
{
     if (_isBackPwd ==YES) {
          [self resetUserInfo];
          return;
     }
     if (self.userNameTextField.text.length == 0)
     {
          TOASTSHOWUNDERVIEW(@"内容不能为空！", self.userNameTextField, CGPointMake(0,10));
          return;
     }

     BOOL include =[self isIncludeSpecialCharact:self.userNameTextField.text];
     if (include ==YES) {
          TOASTSHOWUNDERVIEW(@"用户名含特殊字符！", self.userNameTextField, CGPointMake(0,10));
          return;
     }
     BOOL te =NO;
     for(int i=0; i< [self.userNameTextField.text length];i++){
          int a = [self.userNameTextField.text characterAtIndex:i];
          if( a > 0x4e00 && a < 0x9fff)
          {
               te=YES;
          }
     }
     if (te==YES) {
          if (self.userNameTextField.text.length <2||self.userNameTextField.text.length >15)
          {
               TOASTSHOWUNDERVIEW(@"字符长度不符！", self.userNameTextField, CGPointMake(0,10));
               return;
          }
     }
     else
     {
          if (self.userNameTextField.text.length <4||self.userNameTextField.text.length >30)
          {
               TOASTSHOWUNDERVIEW(@"字符长度不符！", self.userNameTextField, CGPointMake(0,10));
               return;
          }
     }
     [busiSystem.agent checkUserName:self.userNameTextField.text observer:self callback:@selector(checkUserNameNotification:)];
}

-(void)checkUserNameNotification:(BSNotification*)noti
{
     //    BASENOTIFICATION(noti);
     if (noti.error.code == 0) {
//          HUDDISMISS;
          busiSystem.agent.regModel.Name =self.userNameTextField.text;
     }
     else
     {
//          HUDCRY(noti.error.domain, 1);
     }

     //    if (_headPortrait.imageView.image!=[UIImage imageNamed:@"defaultAvatar"]) {
     //        busiSystem.agent.regModel.Img =_headPortrait.imageView.image;
     //    }
     //    RegisterViewController * rVC =[[RegisterViewController alloc]initWithType:BUPASSWORDTYPE_REGISTER];
     //    rVC.isBackPwd =self.isBackPwd;
     //    [self.navigationController pushViewController:rVC animated:YES];
}

-(BOOL)isIncludeSpecialCharact: (NSString *)str {
     //***需要过滤的特殊字符：~￥#&*<>《》()[]{}【】^@/￡¤￥|§¨「」『』￠￢￣~@#￥&*（）——+|《》$_€。
     NSRange urgentRange = [str rangeOfCharacterFromSet: [NSCharacterSet characterSetWithCharactersInString: @"~￥#&*<>《》()[]{}【】^@/￡¤￥|§¨「」『』￠￢￣~@#￥&*（）——+|《》$_€"]];
     if (urgentRange.location == NSNotFound)
     {
          return NO;
     }
     return YES;
}

#pragma mark -- Private Method

-(void)setUserMessage
{
     NSString *name = [self.userNameTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@" "]];
     NSString *password = isRememPwd ? [self.userPwdTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@" "]] :@"";
     //    [[NSUserDefaults standardUserDefaults]setObject:_type==RELOGIN?busiSystem.agent.Phone:name forKey:@"account"];
     [[NSUserDefaults standardUserDefaults]setObject:password forKey:@"password"];
     [[NSUserDefaults standardUserDefaults]setObject:[NSNumber numberWithBool:isRememPwd]
                                              forKey:@"isRemember"];
     [[NSUserDefaults standardUserDefaults]synchronize];
}

-(void)getUserMessage
{
     NSString * name =[[NSUserDefaults standardUserDefaults]objectForKey:@"account"];
     NSString * password =[[NSUserDefaults standardUserDefaults]objectForKey:@"password"];
     NSNumber * isRemember =[[NSUserDefaults standardUserDefaults]objectForKey:@"isRemember"];
     self.userNameTextField.text = name;
     if (name != NULL && password != NULL && isRemember != NULL) {
          self.userPwdTextField.text = password;
          isRememPwd = YES;
          self.buttonRemember.selected = isRememPwd;
     }
}
-(void) doQuickLogin
{
     [self.view endEditing:YES];
     NSString *name = [self.userNameTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@" "]];
     NSString *password = [self.userPwdTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@" "]];
     if (name.length == 0)
     {
          TOASTSHOWUNDERVIEW(@"手机号码不能为空", self.userNameTextField, CGPointMake(0,10));
          return;
     }
     else if (![JYCommonTool isMobileNum:self.userNameTextField.text])
     {
          TOASTSHOWUNDERVIEW(@"手机号码无效", self.userNameTextField, CGPointMake(0,10));
          return;
     }
//     HUDSHOW(@"正在登录中...");
     [busiSystem.agent mobileLogin:password withMobile:name observer:self callback:@selector(loginNotification:)];
}
-(void) doLogin{
     [self.view endEditing:YES];
     //    [self.userPwdTextField resignFirstResponder];
     NSString *name = [self.userNameTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@" "]];
     NSString *password = [self.userPwdTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@" "]];
     //    if (_type!=4) {
     if (name.length == 0)
     {
          TOASTSHOWUNDERVIEW(@"手机号码不能为空", self.userNameTextField, CGPointMake(0,10));
          return;
     }
     else if (![JYCommonTool isMobileNum:self.userNameTextField.text])
     {
          TOASTSHOWUNDERVIEW(@"手机号码无效", self.userNameTextField, CGPointMake(0,10));
          return;
     }
     else if (password.length == 0 ){
          TOASTSHOWUNDERVIEW(@"密码不能为空", self.userPwdTextField, CGPointMake(0,10));
          return;
     }
     //    else if (password.length < 6)
     //    {
     //        TOASTSHOW(@"密码长度不足");
     //        return;
     //    }
     else{
//          HUDSHOW(@"正在登录中...");
          [busiSystem.agent login:self.userNameTextField.text
                         password:self.userPwdTextField.text
                         observer:self
                         callback:@selector(loginNotification:)];
     }
     //    }
     //    else{
     //        if (password.length == 0 ){
     //            TOASTSHOWUNDERVIEW(@"密码不能为空", self.userPwdTextField, CGPointMake(0,10));
     //            return;
     //        }
     //        //    else if (password.length < 6)
     //        //    {
     //        //        TOASTSHOW(@"密码长度不足");
     //        //        return;
     //        //    }
     //        else{
     //            HUDSHOW(@"正在登录中...");
     //            [busiSystem.agent login:busiSystem.agent.Phone
     //                           password:self.userPwdTextField.text
     //                           observer:self
     //                           callback:@selector(loginNotification:)];
     //        }
     //    }

}

-(void)doRegister{
     [self.userPwdTextField resignFirstResponder];
     NSString *name = [self.userNameTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@" "]];
     NSString *password = [self.userPwdTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@" "]];
     if (name.length == 0)
     {
          TOASTSHOWUNDERVIEW(@"名称不能为空", self.userNameTextField, CGPointMake(0,10));
          return;
     }
     else if (password.length == 0 ){
          TOASTSHOWUNDERVIEW(@"密码不能为空", self.userPwdTextField, CGPointMake(0,10));
          return;
     }
     else{
          [busiSystem.agent checkVerify:_userNameTextField.text Verify:_userPwdTextField.text observer:self callback:@selector(checkVerifyNotification:)];
     }
}

#pragma mark -- MiniUserRegisterDelegate

-(void)registerWithUserId:(NSString*)userId  password:(NSString*)password
{
     self.userNameTextField.text = userId;
     self.userPwdTextField.text = password;
     [self doLogin];
}

#pragma mark --MyTextFieldDelegate
-(NSString*)floatTextForMyTextField:(MyTextField*)textField
{
     if  (textField == self.userNameTextField)
          return [textField.text  formatWithFormatString:@"XXX XXXX XXXX"];
     return NULL;
}
//是否可以点击登录按钮
-(void)textFieldDidChange{
     if ([JYCommonTool isMobileNum:_userNameTextField.text]  && ((_curTabBtn.tag != 7711 && getRandomSucessed && _userPwdTextField.text.length >=4)|| (_curTabBtn.tag == 7711 && _userPwdTextField.text.length >=6) )) {
          [_userLoginBtn setBackgroundColor:kUIColorFromRGB(color_0xf74056)];
          _userLoginBtn.layer.shadowRadius = 8.0;
          _userLoginBtn.userInteractionEnabled = YES;
     }else{
          [_userLoginBtn setBackgroundColor:kUIColorFromRGB(color_0xb0b0b0)];
          _userLoginBtn.layer.shadowRadius = 0.0;
          _userLoginBtn.userInteractionEnabled = NO;
     }
}

#pragma mark ---ZLPhotoPickerViewControllerDelegate
-(void)pressTitleButton:(UIButton *)btn
{
     [_pickerVC  popView];
}

- (void)pickerViewControllerDoneAsstes:(NSArray *)assets{
     NSMutableArray *mArr = [NSMutableArray array];
     [assets enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
          ZLPhotoAssets *asset = (ZLPhotoAssets *)obj;
          UIImage *img = [asset originImage];
          [mArr addObject:img];
     }];
     _headPortrait.backgroundColor =[UIColor clearColor];
     busiSystem.agent.regModel.Img =mArr[0];
     [_headPortrait setImage:mArr[0] forState:0];
     //    [_headPortrait setBackgroundImage:mArr[0] forState:UIControlStateNormal];
     [_pickerVC dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -- Handle Method
//登录
- (IBAction)loginHandle:(id)sender {
     switch (0) {
               //        case 0:
               //        {
               //            [self doLogin];·
               //        }
               //            break;
               //        case 1:
               //        {
               //            _isBackPwd ==YES?[self goSetPwd]:[self resetUserInfo];
               //        }
               //            break;
               //        case 2:
               //        {
               //            [self goSetPwd];
               //        }
               //            break;

          default:
          {
               if(_curTabBtn.tag == 7711)
               {
                    [self doLogin];
               }else
               {
                    [self doQuickLogin];
               }
          }
               break;
     }

}

-(void)viewWillAppear:(BOOL)animated
{
     CGSize navBarSize = CGSizeMake(__SCREEN_SIZE.width, __NAVBAR_HEIGHT + __STATUSBAR_HEIGHT);
     [self.navigationController.navigationBar  setBackgroundImage:[UIImage imageWithColor:kUIColorFromRGBWithAlpha(color_2,0) withBounds:CGRectMake(0, 0, navBarSize.width,navBarSize.height)] forBarPosition:UIBarPositionTopAttached barMetrics:UIBarMetricsDefault];
     self.navigationController.navigationBar.translucent = YES;
     self.navigationController.navigationBar.shadowImage = [UIImage new];
     [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}
//记住密码
- (IBAction)remPwdHandle:(id)sender {
     UIButton *btn = (UIButton *)sender;
     isRememPwd = !isRememPwd;
     if (isRememPwd) {
          btn.selected = TRUE;
     }else{
          btn.selected = FALSE;
     }
}

//忘记密码
- (IBAction)forgetPwdHandle:(id)sender {
     [self.view endEditing:YES];
     ForgetPwdViewController *vc = [[ForgetPwdViewController alloc] initWithNibName:@"RegisterViewController" bundle:nil];
     vc.type = 2;
     [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)handleTextFieldReturn:(id)sender {
     if (sender == self.userNameTextField)
     {
          [self.userPwdTextField becomeFirstResponder];
     }
     else if (sender == self.userPwdTextField)
     {
          if(_curTabBtn.tag == 7711)
          {
               [self doLogin];
          }else
          {
               [self doQuickLogin];
          }
     }
}

//获取验证码
- (IBAction)identifyingCodeAction:(id)sender {
     [self.userPwdTextField resignFirstResponder];
     NSInteger phoneNumble =[_userNameTextField.text integerValue];
     NSString *name = [self.userNameTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@" "]];
     if (name.length == 0)
     {
          TOASTSHOWUNDERVIEW(@"手机号不能为空！", self.userNameTextField, CGPointMake(0,10));
          return;
     }
     else if (name.length < 12&&phoneNumble ==0)
     {
          TOASTSHOW(@"请输入11位手机号！");
          return;
     }
     else
     {
          timer=[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerFireMethod:) userInfo:nil repeats:YES];
          //        identifyingCode =[[UILabel alloc]initWithFrame:_identifyingCodeBtn.frame];
          //        identifyingCode.font =_identifyingCodeBtn.titleLabel.font;
          //        [_identifyingCodeBtn addSubview:identifyingCode];
          self.identifyingCodeBtn.userInteractionEnabled = NO;
          [busiSystem.agent sendSms:_userNameTextField.text  observer:self callback:@selector(sendSmsNotification:)];
     }
}

-(void)timerFireMethod:(NSTimer *)theTimer {
     if (count == 60) {
          [theTimer invalidate];
          count = 0;
          //        self.identifyingCodeBtn.hidden =NO;
          //        identifyingCode.text =@"获取验证码";
          [self.identifyingCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
          [self.identifyingCodeBtn setUserInteractionEnabled:YES];
     }else{
          //        self.identifyingCodeBtn.hidden =YES;
          count++;
          //        identifyingCode.text =[[NSString alloc] initWithFormat:@"剩余%d秒",60-count];
          [self.identifyingCodeBtn setTitle:[[NSString alloc] initWithFormat:@"剩余%d秒",60-count] forState:UIControlStateNormal];
          [self.identifyingCodeBtn setUserInteractionEnabled:NO];
     }
}

-(void)sendSmsNotification:(BSNotification *) noti
{
     //    BASENOTIFICATION(noti);
     if (noti.error.code ==0) {
          getRandomSucessed = YES;
          TOASTSHOW(@"验证码已发送,请查收");
     }
     else{
          NSString *hintStr = [NSString stringWithFormat:@"验证码发送失败:%@",noti.error.domain];
          TOASTSHOW(hintStr);
          [timer invalidate];
          count = 0;
          [self.identifyingCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
          [self.identifyingCodeBtn setUserInteractionEnabled:YES];
     }
}

//头像
- (IBAction)headPortraitAction:(id)sender {
     //    if (_type==2){
     //        _pickerVC = [[ZLPhotoPickerViewController alloc]init];
     //        _pickerVC.topShowPhotoPicker = YES;
     //        _pickerVC.isCanAutoChangeCheck = YES;
     //        _pickerVC.delegate = self;
     //        _pickerVC.maxCount = 1;
     //        _pickerVC.status = PickerViewShowStatusCameraRoll;
     //        [_pickerVC showPickerVc:self];
     //    }
     //    else{
     return;
     //    }
}

- (IBAction)registerHandle:(id)sender {
     [self.view endEditing:YES];
     RegisterViewController *vc = [RegisterViewController new];
     //    [self.navigationController pushViewController:vc animated:YES];
     //     ForgetPwdViewController *vc = [[ForgetPwdViewController alloc] initWithNibName:@"RegisterViewController" bundle:nil];
     //     vc.type = 1;
     [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark --ActionDelegate
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
     switch (buttonIndex) {
          case 0:
          {
               [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"account"];
               [[NSUserDefaults standardUserDefaults]  synchronize];
               LoginViewController * loginVC =[[LoginViewController alloc] init];
               //            loginVC.type =LOGIN;
               UINavigationController *navSvc = [[UINavigationController alloc] initWithRootViewController:loginVC];
               self.view.window.rootViewController =navSvc;
          }
               break;
          case 1:
          {
               [self pushLoginViewControllerType:REGISTER];

          }
               break;

          default:
               break;
     }

}


- (IBAction)handleThirdLogin:(id)sender {


     //    NSInteger tag = ((UIButton *)sender).tag;
     //    NSString *snsName = @[UMShareToWechatSession,UMShareToQQ,UMShareToSina][tag -1];
     //    [UMWarp login:self snsName:snsName callback:^(NSString *userid, NSString *userName) {
     //        HUDSHOW(@"正在登录中...");
     //        [busiSystem.agent thirdLogin:userid userName:userName auth: @[@"weixin",@"qq",@"weibo"][tag-1] observer:self callback:@selector(loginNotification:)];
     //    }];
     NSInteger tag = ((UIButton *)sender).tag;
     //    BindEmailViewController *vc = [[BindEmailViewController alloc] initWithNibName:@"BindEmailViewController" bundle:nil];
     //    [self.navigationController pushViewController:vc animated:YES];
     NSString *snsName = @[@"wxsession",@"qq"][tag -1];
     if ([UMWarp hasInstalledQQ]) {
          //          HUDSHOW(@"授权中...");
     }

     [UMWarp login:self snsName:snsName callback:^(NSString *userid, NSString *userName) {
          NSLog(@"sslogin:%@  %@",userid,userName);
          PlatformMode  p = PlatformWeChat;
          NSString *type = @"1";
          if (tag == 2) {
               p = PlatformQQ;
               type = @"2";
          }
//          HUDSHOW(@"授权中...");
          [UMWarp getUserInfo:p callBack:^(NSDictionary *dic) {
               NSLog(@"logsssdd:%@",dic);
               [busiSystem.agent thirdLogin:dic[@"headImg"] withNickname:dic[@"name"] withUid:dic[@"uid"]  withType:type observer:self callback:@selector(loginNotification:)];
               //               [busiSystem.agent isUserUID:dic[@"uid"] observer:self callback:@selector(isUserIdNotification:) extro:@{@"uid":dic[@"uid"],@"type":type,@"acc":dic[@"name"]}];
          }];
          //        HUDSHOW(@"正在登录中...");
          //        [busiSystem.agent thirdLogin:userid userName:userName auth: @[@"weixin",@"qq",@"weibo"][tag-1] observer:self callback:@selector(loginNotification:)];
     }];
}



-(BOOL) textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
     //    return YES;
     UITextField *tf = (UITextField *)textField;
     NSInteger tfTag = tf.tag;
     if ([string isEqualToString:@"\n" ]|| [string isEqualToString:@""])
          return YES;
     switch (tfTag) {
          case 0:
          {
               BOOL bResult =[BSUtility contextDomainLimit:string ValidDomain:[NSString stringWithFormat:@"%@%@%@",NUMBERS,ALPHA,JGGZW]];
               switch (0) {
                    case 2:
                    {
                         if (bResult&&range.location<30) {
                              return TRUE;
                         }else{
                              return FALSE;
                         }
                    }
                         break;
                    case 0:
                    {
                         if (bResult&&range.location<30) {
                              return TRUE;
                         }else{
                              return FALSE;
                         }
                    }
                         break;
                    default:
                    {
                         if (bResult&&range.location<11) {
                              return TRUE;
                         }else{
                              return FALSE;
                         }
                    }
                         break;
               }

          }
               break;
               //        case 1:
               //        {
               //            BOOL bResult =[BSUtility contextDomainLimit:string ValidDomain:NUMBERS];
               //            //限制只能输入数字
               //            if (bResult&&range.location<6) {
               //                return TRUE;
               //            }else{
               //                return FALSE;
               //            }
               //        }
               //            break;

          default:
               break;
     }
     return TRUE;
}

-(void)showYouGetOut:(NSString *)str
{
     [[CommonAPI managerWithVC:self] showConfirmView:@"提示" withMsg:str];
}
static LoginViewController *vc;
static UINavigationController *nav;
+(void)toLogin:(UIViewController *)pvc
{
     static dispatch_once_t onceToken;
     dispatch_once(&onceToken, ^{
          vc = [LoginViewController new];
          vc.mode = 1;
          nav = [[UINavigationController alloc] initWithRootViewController:vc];
          [vc setNavigateLeftButton:@"nav_close"];
          vc.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
     });
     vc.userPwdTextField.text = @"";
     vc.userNameTextField.text = @"";
     vc.title = @"";
     [vc->timer invalidate];
     vc->count = 0;
     //        self.identifyingCodeBtn.hidden =NO;
     //        identifyingCode.text =@"获取验证码";
     [vc textFieldDidChange];
     [vc.identifyingCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
     [vc.identifyingCodeBtn setUserInteractionEnabled:YES];
     vc.identifyingCodeBtn.backgroundColor = kUIColorFromRGB(color_2);
     [pvc presentViewController:nav animated:YES completion:nil];
}


-(void)handleReturnBack:(id)sender
{
     if (_mode == 0) {
          if (_isPushHome) {
               self.tabBarController.selectedIndex = 0;
               [self.navigationController popToRootViewControllerAnimated:YES];
               //              [self dismissViewControllerAnimated:YES completion:nil];


          }else
               [super handleReturnBack:sender];
     }
     else
     {
          [self dismissViewControllerAnimated:YES completion:nil];
     }


}
@end
