//
//  WithdrawPasswordViewController.m
//  compassionpark
//
//  Created by air on 2017/4/7.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import "WithdrawPasswordViewController.h"
#import "BUSystem.h"
@implementation WithdrawPasswordViewController
-(id)init
{
    self = [super initWithNibName:@"DealPasswordViewController" bundle:nil];
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self fitMode];
}

-(void)fitMode
{
    self.view.width = 300;
    self.view.height = 166;
     self.titleLb.hidden = YES;
    self.tipLb.numberOfLines = 1;
    self.tipLb.width = 300  - 30;
    self.tipLb.height = 17;
    self.tipLb.x = 15;
    self.tipLb.y = 13;
    self.tipLb.text = @"输入提现密码";
    
   
     self.passwordTf.width = 264;
    self.passwordTf.height = 44;
     self.passwordTf.pwdWidth = 44;
    self.passwordTf.layer.borderColor = kUIColorFromRGB(color_5).CGColor;
    self.passwordTf.layer.cornerRadius = 4;
    self.passwordTf.layer.masksToBounds = YES;
    self.passwordTf.x = 18;
    self.passwordTf.y = 46;
    
    self.forgetBtn.width = 60;
    self.forgetBtn.height = 14;
    self.forgetBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    self.forgetBtn.y = self.passwordTf.y + self.passwordTf.height + 10;
    self.forgetBtn.x = 300 - 18 - 60;
    [self.forgetBtn setTitleColor:kUIColorFromRGB(color_mainTheme) forState:UIControlStateNormal];
    [self.forgetBtn setTitle:@"忘记密码" forState:UIControlStateNormal];
    self.closeBtn.hidden = YES;
    UIButton *canBtn = [self.view viewWithTag:84333];
    if (!canBtn) {
        canBtn = [UIButton new];
        canBtn.x = 0;
        canBtn.y = 121;
        canBtn.width = 150;
        canBtn.height = 45;
        canBtn.tag = 84333;
             [canBtn addTarget:self action:@selector(cancelBtnHandle:) forControlEvents:UIControlEventTouchUpInside];
        [canBtn setTitleColor:kUIColorFromRGB(color_mainTheme) forState:UIControlStateNormal];
        canBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [canBtn setTitle:@"取消" forState:UIControlStateNormal];
    }
    [self.view addSubview:canBtn];
    
    UIButton *sureBtn = [self.view viewWithTag:84666];
    if (!sureBtn) {
        sureBtn = [UIButton new];
        sureBtn.x = 150;
        sureBtn.y = 121;
        sureBtn.width = 150;
        sureBtn.height = 45;
        sureBtn.tag = 84666;
        [sureBtn addTarget:self action:@selector(sureBtnHandle:) forControlEvents:UIControlEventTouchUpInside];
        [sureBtn setTitleColor:kUIColorFromRGB(color_mainTheme) forState:UIControlStateNormal];
        sureBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [sureBtn setTitle:@"确认" forState:UIControlStateNormal];
    }
    [self.view addSubview:sureBtn];
    
    UILabel *hLb = [self.view viewWithTag:11111];
    if (!hLb) {
        hLb = [UILabel new];
        hLb.x = 0;
        hLb.y = 120.5;
        hLb.width = 300;
        hLb.height = 0.5;
        hLb.backgroundColor = kUIColorFromRGB(color_mainTheme);
        hLb.tag = 11111;
        
    }
    [self.view addSubview:hLb];
    
    UILabel *vLb = [self.view viewWithTag:22222];
    if (!vLb) {
        vLb = [UILabel new];
        vLb.x = 150;
        vLb.y = 121;
        vLb.width = 0.5;
        vLb.height = 45;
        vLb.backgroundColor = kUIColorFromRGB(color_mainTheme);
        vLb.tag = 22222;
    }
    [self.view addSubview:vLb];
}

-(void)sureBtnHandle:(UIButton *)btn
{
    if (self.doneCallBack) {
        self.doneCallBack(btn);
    }
}

-(void)cancelBtnHandle:(UIButton *)btn
{
    if (_cancelCallBack) {
        _cancelCallBack(btn);
    }
}

static WithdrawPasswordViewController *dealvc;
+(WithdrawPasswordViewController *)toWithdrawVC:(UIViewController *)parentVC
{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dealvc = [[WithdrawPasswordViewController alloc] init];
        
    });
    dealvc.passwordTf.text = @"";
    //   DealPasswordViewController *dealvc = [DealPasswordViewController new];
    MyDialog *myDialog = [[MyDialog alloc] initWithViewController:dealvc];
    //    vc.view.width = __SCREEN_SIZE.width;
    //    vc.doneCallBack = ^(NSString *pwd){
    //        [weakSelf toAddwithdraw:pwd];
    //    };
    dealvc.view.layer.cornerRadius = 8;
    dealvc.view.layer.masksToBounds = YES;
    [dealvc.passwordTf addTarget:dealvc action:@selector(changeValue:) forControlEvents:UIControlEventEditingChanged];
    dealvc.parentVC = parentVC;
    [myDialog show];
    //    myDialog.dismissOnTouchOutside = YES;
    myDialog.isDownAnimate = YES;
    return dealvc;
}

-(void)changeValue:(UITextField*)txtTf
{
    
    if (txtTf.text.length == 6) {
//        [self.parentDialog dismiss];
        [self.view endEditing:YES];
      
    }
    
}

-(void)validateWithdrawPwdNotification:(BSNotification *)noti
{

    if (noti.error.code == 0) {
        if([busiSystem.payManager.flag isEqualToString:@"1"])
        {
//            HUDDISMISS;
            [[CommonAPI managerWithVC:self.parentVC] showAlertView:nil withMsg:@"支付/提现密码输入错误，请重试" withBtnTitle:@"重试" withCancelBtnTitle:@"忘记密码" withSel:@selector(toProcessResult:) withUserInfo:@{}];
        }else if ([busiSystem.payManager.flag isEqualToString:@"2"])
        {
//            HUDCRY(@"已达最大尝试次数，请10分钟后再试", 2);
//            HUDDISMISS;
            [[CommonAPI managerWithVC:self.parentVC] showConfirmView:nil withMsg:@"已达最大尝试次数，请10分钟后再试"];
        }
        else
        {
            NSString *pwd = noti.extraInfo[@"pwd"];
            if (self.doneCallBack)
            {
                self.doneCallBack(pwd);
            }
        }
    }
}



@end
