//
//  DealPasswordViewController.m
//  lovecommunity
//
//  Created by air on 16/8/24.
//  Copyright © 2016年 ORANLLC_IOS1. All rights reserved.
//

#import "DealPasswordViewController.h"
#import "BUSystem.h"
//#import "ConfirmPasswordViewController.h"
//#import "SettingDealViewController.h"
@interface DealPasswordViewController ()
{
   IBOutlet MyPwdTextField *_pwdTf;
  
}
@end

@implementation DealPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _pwdTf.isShowBorder = YES;
    _pwdTf.borderColor = kUIColorFromRGB(color_4);
    _pwdTf.borderWidth = 0.5;
    _pwdTf.clearButtonMode = UITextFieldViewModeNever;
    _pwdTf.kbMovingView = self.view;
//    _pwdTf.delegate = self;
    _pwdTf.tintColor = [UIColor clearColor];
}

-(MyPwdTextField *)passwordTf
{
    return _pwdTf;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField.text.length < 6) {
        HUDCRY(@"请输入完密码", 2);
        return YES;
    }
     NSString *pwd = _pwdTf.text;
     [self.parentDialog dismiss];
   
    if (_doneCallBack)
    {
        _doneCallBack(pwd);
    }
   
   
    return YES;
}
- (IBAction)closeHandle:(id)sender {
    [self.parentDialog cancel];
}

-(void)viewDidAppear:(BOOL)animated
{
    [_pwdTf becomeFirstResponder];
}
static DealPasswordViewController *dealvc;
+(DealPasswordViewController *)toDealVC:(UIViewController *)parentVC
{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dealvc = [[DealPasswordViewController alloc] init];
        
    });
    dealvc->_pwdTf.text = @"";
//   DealPasswordViewController *dealvc = [DealPasswordViewController new];
    MyDialog *myDialog = [[MyDialog alloc] initWithViewController:dealvc];
    //    vc.view.width = __SCREEN_SIZE.width;
    //    vc.doneCallBack = ^(NSString *pwd){
    //        [weakSelf toAddwithdraw:pwd];
    //    };
    dealvc.view.layer.cornerRadius = 8;
    dealvc.view.layer.masksToBounds = YES;
    [dealvc.passwordTf addTarget:dealvc action:@selector(changeValue:) forControlEvents:UIControlEventEditingChanged];
    dealvc->_parentVC = parentVC;
    [myDialog show];
//    myDialog.dismissOnTouchOutside = YES;
    myDialog.isDownAnimate = YES;
    return dealvc;
}

+(DealPasswordViewController *)toMoreDealVC:(UIViewController *)parentVC
{
    
    
     DealPasswordViewController *  dealvc = [[DealPasswordViewController alloc] init];
        
   
    dealvc->_pwdTf.text = @"";
    //   DealPasswordViewController *dealvc = [DealPasswordViewController new];
    MyDialog *myDialog = [[MyDialog alloc] initWithViewController:dealvc];
    //    vc.view.width = __SCREEN_SIZE.width;
    //    vc.doneCallBack = ^(NSString *pwd){
    //        [weakSelf toAddwithdraw:pwd];
    //    };
    dealvc.view.layer.cornerRadius = 8;
    dealvc.view.layer.masksToBounds = YES;
    [dealvc.passwordTf addTarget:dealvc action:@selector(changeValue:) forControlEvents:UIControlEventEditingChanged];
    dealvc->_parentVC = parentVC;
    [myDialog show];
    //    myDialog.dismissOnTouchOutside = YES;
    myDialog.isDownAnimate = YES;
    return dealvc;
}

-(void)fitModeB:(id)userInfo;
{
    self.view.height = 138;
    _tipLb.text = @"再次输入支付密码";
    _tipLb.y = 36;
    _titleLb.hidden = YES;
    _forgetBtn.hidden = YES;
    _pwdTf.y = 69;
    _userInfo = userInfo;
    _doneCallBack = userInfo[@"doneCallBack"];
    [_pwdTf removeTarget:self action:@selector(changeValue:) forControlEvents:UIControlEventEditingChanged];
    [_pwdTf addTarget:self action:@selector(changeValue2:) forControlEvents:UIControlEventEditingChanged];
}
-(void)changeValue2:(UITextField*)txtTf
{
    if (txtTf.text.length == 6) {
        [self.parentDialog dismiss];
        [self.view endEditing:YES];
        if(![txtTf.text isEqualToString: _userInfo[@"pwd"]])
        {
            HUDCRY(@"两次密码不一致，请重新申请", 2);
            return;
        }
        if (_doneCallBack) {
            _doneCallBack(txtTf.text);
        }
      
    }
}

-(void)changeValue:(UITextField*)txtTf
{
    
    if (txtTf.text.length == 6) {
        [self.parentDialog dismiss];
         [self.view endEditing:YES];
        [self validPwd:txtTf.text];
    }
    
}
-(void)validPwd:(NSString *)pwd
{
    [[DealPasswordViewController toMoreDealVC:_parentVC] fitModeB:@{@"pwd":pwd?:@"",@"doneCallBack":_doneCallBack?:^(id o){}}];
    
//    HUDSHOW(@"加载中");
//    [busiSystem.payManager validateDealPwd:[pwd  md5String] observer:self callback:@selector(validateDealPwdNotification:) extraInfo:@{@"pwd":pwd}];
}

//-(void)validateDealPwdNotification:(BSNotification *)noti
//{
//   
//    if (noti.error.code == 0) {
//        if([busiSystem.payManager.flag isEqualToString:@"1"])
//        {
//            HUDDISMISS;
//            [[CommonAPI managerWithVC:_parentVC] showAlertView:nil withMsg:@"交易密码输入错误，请重试" withBtnTitle:@"重试" withCancelBtnTitle:@"忘记密码" withSel:@selector(toProcessResult:) withUserInfo:@{}];
//        }else if ([busiSystem.payManager.flag isEqualToString:@"2"])
//        {
////            HUDCRY(@"已达最大尝试次数，请10分钟后再试", 2);
//            HUDDISMISS;
//            [[CommonAPI managerWithVC:_parentVC] showConfirmView:nil withMsg:@"已达最大尝试次数，请10分钟后再试"];
//        }
//        else
//        {
//            NSString *pwd = noti.extraInfo[@"pwd"];
//            if (_doneCallBack)
//            {
//                _doneCallBack(pwd);
//            }
//        }
//    }
//}

-(void)fitMode
{
    _forgetBtn.hidden = YES;
    _titleLb.numberOfLines = 3;
    _titleLb.width = 280  - 30;
    _titleLb.height = 50;
    _titleLb.x = 15;
    _titleLb.y = 25;
    _titleLb.text = @"您的手机号还未申请过一卡通卡片，请您先按如下步骤申请卡片，用于今后APP中的订单支付";
    _tipLb.text = @"请输入卡片6位支付密码";
}

- (IBAction)forgetPwdHandle:(id)sender {
    [self.parentDialog cancel];
    if (_forgetCallBack) {
        _forgetCallBack(nil);
    }
//    _parentVC.tabBarController.selectedIndex = 3;
//     [_pwdTf resignFirstResponder];
//    [self.parentDialog cancel];
//    SettingDealViewController *settingDVC = [SettingDealViewController new];
//    settingDVC.callBack = ^(id o){
//        [_parentVC.navigationController popToViewController:_parentVC animated:YES];
//    };
//    settingDVC.userTelPhone = busiSystem.agent.tell;
//      settingDVC.notFormatUserPhone = busiSystem.agent.userInfo.tell;
//    [_parentVC.navigationController pushViewController:settingDVC animated:YES];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [_pwdTf resignFirstResponder];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
