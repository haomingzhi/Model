                                              //
//  RegisterViewController.m
//  taihe
//
//  Created by air on 2016/11/9.
//  Copyright © 2016年 ORANLLC_IOS1. All rights reserved.
//

#import "RegisterViewController.h"
#import "RegPwdViewController.h"
#import "UserAgreementViewController.h"
#import "BUSystem.h"
#import "DealPasswordViewController.h"
#import "JYCommonTool.h"
#import "BlankTableViewCell.h"
#import "OnlyBottomBtnTableViewCell.h"
@interface RegisterViewController ()
{
    NSInteger _time;
    BOOL _hasSendCode;
    BOOL _canEditCode;
    
       UIButton *_qqBtn;
       UIButton *_wxBtn;
       UILabel *_loginTipLb;
       UILabel *_seplitLineLb;
       UILabel *_seplitLine2Lb;
      UIView *_viewThirdLoginContainer;
}


@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"注册";
    _time = 60;
     _canEditCode = YES;
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.shadowImage = nil;
    [self initTableView];
     [self initThirdLogin];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewDidAppear:(BOOL)animated
{
     [_phoneCell.textTf becomeFirstResponder];
}
-(void)initTableView
{
    __weak RegisterViewController *weakSelf = self;
     _phoneCell = [TextFieldTableViewCell createTableViewCell];
     [_phoneCell setCellData:@{@"placeholder":@"请输入11位数字手机号码"}];
     [_phoneCell.textTf addTarget:self action:@selector(textChange:) forControlEvents:UIControlEventEditingChanged];
     _phoneCell.textTf.delegate = self;
     [_phoneCell fitRegModeWithTagName:@"手机号"];
     _phoneCell.textTf.keyboardType = UIKeyboardTypeNumberPad;
     _phoneCell.textTf.secureTextEntry = NO;

    _codeCell = [TextFieldTableViewCell createTableViewCell];
    [_codeCell setCellData:@{@"placeholder":@"输入验证码"}];
     [_codeCell fitModeE:self withSel:@selector(checkSns:)];
     [_codeCell.textTf addTarget:self action:@selector(textChange:) forControlEvents:UIControlEventEditingChanged];
     [_codeCell fitRegMode];
    _codeCell.textTf.delegate = self;
    
    
    _pwdCell = [TextFieldTableViewCell createTableViewCell];
    [_pwdCell setCellData:@{@"placeholder":@"请设置6-20位数字加字母或符号"}];
//    [_pwdCell addTarget:self action:@selector(textChange:) forControlEvents:UIControlEventEditingChanged];
//    [_pwdCell fitRegModeWithTagName:@"fpwd_pwd"];
    [_pwdCell.textTf addTarget:self action:@selector(textChange:) forControlEvents:UIControlEventEditingChanged];
     _pwdCell.textTf.keyboardType = UIKeyboardTypeASCIICapable;
     _pwdCell.textTf.secureTextEntry = YES;
     [_pwdCell fitRegModeWithTagName:@"密 码"];
     UIButton *btn = [UIButton new];
     btn.width = 30;
     btn.height = 30;
     [btn setImage:[UIImage imageContentWithFileName:@"eyes"] forState:UIControlStateNormal];
      [btn setImage:[UIImage imageContentWithFileName:@"eyesClose"] forState:UIControlStateSelected];
     [btn addTarget:self action:@selector(showPwdHandle:) forControlEvents:UIControlEventTouchUpInside];
     btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
     _pwdCell.textTf.rightViewMode = UITextFieldViewModeAlways;
     _pwdCell.textTf.rightView = btn;

    _surepwdCell = [TextFieldTableViewCell createTableViewCell];
    [_surepwdCell setCellData:@{@"placeholder":@"再次输入密码"}];
//    [_surepwdCell addTarget:self action:@selector(textChange:) forControlEvents:UIControlEventEditingChanged];
    [_surepwdCell fitRegMode:@"fpwd_open"];
    [_surepwdCell.textTf addTarget:self action:@selector(textChange:) forControlEvents:UIControlEventEditingChanged];
     _surepwdCell.textTf.keyboardType = UIKeyboardTypeASCIICapable;
     _surepwdCell.textTf.secureTextEntry = YES;
     [_surepwdCell fitForgetPwdNextModeA:[UIImage imageNamed:@"login_pwd2"]];

    _nextCell = [OnlyBottomBtnTableViewCell createTableViewCell];
     [_nextCell setCellData:@{@"title":@"注册"}];
    [_nextCell fitRegMode];
    [_nextCell setHandleAction:^(id o) {
        [weakSelf submit];
    }];
    [_nextCell  setBtnBackgroundColor:kUIColorFromRGB(color_8)];
    [_nextCell setBtnTitleColor:kUIColorFromRGB(color_2)];
    [_nextCell  setBtnEnabled:NO];

     _toLoginBtnCell = [OnlyBottomBtnTableViewCell createTableViewCell];
     [_toLoginBtnCell setCellData:@{@"title":@"已有账号登录"}];
     [_toLoginBtnCell fitRegModeB];
     [_toLoginBtnCell setHandleAction:^(id sender) {
          [weakSelf.navigationController popViewControllerAnimated:YES];
     }];
     _tableView.backgroundColor = kUIColorFromRGB(color_2);
     _tableView.bounces = NO;
    self.tableView.refreshHeaderView = nil;
}
-(void)showPwdHandle:(UIButton *)btn
{
     btn.selected = !btn.selected;
     _pwdCell.textTf.secureTextEntry = !btn.selected;
}
-(void)toUserAgreeVC
{
    UserAgreementViewController *vc= [UserAgreementViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}

//-(void)submit
//{
//    [self.view endEditing:YES];
//    HUDSHOW(@"提交中");
//    [busiSystem.agent getUserCodeState:self.phoneCell.textTf.text withCode:self.codeCell.textTf.text observer:self callback:@selector(getUserCodeStateNotification:)];
//}
//
//-(void)getUserCodeStateNotification:(BSNotification *)noti
//{
//    if (noti.error.code == 0) {
//        HUDDISMISS;
//        [self toNextVC];
//    }
//    else
//    {
//        HUDCRY(noti.error.domain, 1);
//    }
//}

-(void)submit
{
    [self.view endEditing:YES];
    if (![JYCommonTool isMobileNum:self.phoneCell.textTf.text]) {
//        HUDCRY(@"手机号格式有误", 2);
        return;
    }
//    if (![self.pwdCell.textTf.text isEqualToString:self.surepwdCell.textTf.text]) {
//        HUDCRY(@"密码不一致", 2);
//        return;
//    }
//    if (![BSUtility isRightNameStyle:_nickCell.textTf.text withMax:16 withMin:4]) {
//        HUDCRY(@"昵称未填或太短", 1);
//        return;
//    }
    
//    HUDSHOW(@"提交中");
    [busiSystem.agent registerUser:self.phoneCell.textTf.text withPwd:self.pwdCell.textTf.text  withCode:self.codeCell.textTf.text  observer:self callback:@selector(registerUserNotification:)];
    //    RegisterNextViewController *vc = [RegisterNextViewController new];
    //    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:self.userInfo];
    //    dic[@"pwd"] = self.phoneCell.textTf.text;
    //    vc.userInfo = dic;
    //    [self.navigationController pushViewController:vc animated:YES];
}

-(void)registerUserNotification:(BSNotification *)noti
{
    if (noti.error.code == 0) {
        [busiSystem.agent login:self.phoneCell.textTf.text password:self.pwdCell.textTf.text  observer:self callback:@selector(loginNotification:)];
    }
    else
    {
//        HUDCRY(noti.error.domain, 1);
    }
}

-(void)loginNotification:(BSNotification *)noti
{
    if (noti.error.code == 0) {
//        HUDSMILE(@"注册成功", 2);
        [self performSelector:@selector(finishReg) withObject:nil afterDelay:2];
        
    }
    else
    {
//        HUDCRY(noti.error.domain, 1);
    }
}

-(void)finishReg
{
     busiSystem.agent.isNeedRefreshTabD = YES;
    busiSystem.agent.isNeedRefreshTabC = YES;
    busiSystem.agent.isNeedRefreshTabB = YES;
    busiSystem.agent.isNeedRefreshTabA = YES;
    UITabBarController *tbVc = (UITabBarController *)self.view.window.rootViewController;
    tbVc.selectedIndex = 0;
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)toNextVC
{
    RegPwdViewController *vc = [[RegPwdViewController alloc] initWithNibName:@"RegisterViewController" bundle:nil];
    vc.userInfo = @{@"tel":self.phoneCell.textTf.text,@"code":self.codeCell.textTf.text};
    [self.navigationController pushViewController:vc animated:YES];

}

-(void)getCode
{
    [busiSystem.agent sendSms:_phoneCell.textTf.text observer:self callback:@selector(sendSmsNotification:)];
}

-(void)sendSmsNotification:(BSNotification *)noti
{
    if (noti.error.code == 0) {
        TOASTSHOW(@"验证码发送成功");
        _hasSendCode = YES;
        [self textChange:nil];
    }else{
//         HUDCRY(noti.error.domain, 2);
         
    }
}

-(void)checkSns:(UIButton *)btn
{
     if (![JYCommonTool isMobileNum:_phoneCell.textTf.text]) {
          TOASTSHOW(@"请输入正确的电话号码!");
          return;
     }
//    NSString *phone = busiSystem.agent.Phone;
//    phone = [phone stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
//    [_sendTipCell setCellData:@{@"title":[NSString stringWithFormat:@"已向手机%@发送验证码",phone],@"textColor":kUIColorFromRGB(color_10)}];
    btn.userInteractionEnabled = NO;
    btn.tag = 60;
    [btn setTitle:@"60s" forState:UIControlStateNormal];
    _canEditCode = YES;
    [self performSelector:@selector(setSendSnsBtn:) withObject:btn afterDelay:1];
//    [busiSystem.agent sendSms:busiSystem.agent.tell type:@"2" observer:self callback:@selector(sendSmsNotificaiton:)];
    [self getCode];
}

-(void)setSendSnsBtn:(UIButton *)btn
{
    if (btn.tag == 0) {
        btn.userInteractionEnabled = YES;
        btn.tag = 60;
        _time = 60;
        [btn setTitle:@"获取验证码" forState:UIControlStateNormal];
        [self textChange:nil];
        return;
    }
    btn.tag = btn.tag - 1;
    _time--;
    [btn setTitle:[NSString stringWithFormat:@"%lds",btn.tag] forState:UIControlStateNormal];
    [self performSelector:@selector(setSendSnsBtn:) withObject:btn afterDelay:1];
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 46;
    if (indexPath.row == 4) {
        height = 87;
    }
    else if (indexPath.row == 5)
    {
        height = 30;
    }
    return height;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger row = 6;
    
    return row;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
        UITableViewCell *cell;
    if (indexPath.row == 0) {
        cell = _phoneCell;
        [_phoneCell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(46, 0, 0, 0)];
    }
    else if (indexPath.row == 1)
    {
        cell = _codeCell;
         [_codeCell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(46, 0, 0, 0)];
    }
    else if (indexPath.row == 2)
    {
        cell = _pwdCell;
         [_pwdCell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(46, 0, 0, 0)];
    }
    
    else if (indexPath.row == 3)
    {
        cell = [BlankTableViewCell createTableViewCell];
//         [_surepwdCell showCustomSeparatorView:kUIColorFromRGB(color_3) withInsets:UIEdgeInsetsMake(46, 15, 0, 15)];
    }
    else if (indexPath.row == 4)
    {
        cell = _nextCell;
    }else
    {
        cell = _toLoginBtnCell;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

- (void)textChange:(UITextField *)textField  {
    if (textField == _phoneCell.textTf) {
        if (_phoneCell.textTf.text.length > 10 && _time == 60) {
            [_phoneCell getCodeBtn].userInteractionEnabled = YES;
             [[_phoneCell getCodeBtn] setTitleColor:kUIColorFromRGB(color_2) forState:UIControlStateNormal];
        }
        else
        {
             [_phoneCell getCodeBtn].userInteractionEnabled = NO;
             [[_phoneCell getCodeBtn] setTitleColor:kUIColorFromRGB(color_2) forState:UIControlStateNormal];
        }
    }
    
    if (_codeCell.textTf.text.length >= 1 && _phoneCell.textTf.text.length > 10 && _hasSendCode && _pwdCell.textTf.text.length >= 6 ) {
        [_nextCell  setBtnBackgroundColor:kUIColorFromRGB(color_0xf82D45)];
        [_nextCell  setBtnEnabled:YES];
         [_nextCell setBtnTitleColor:kUIColorFromRGB(color_2)];
         [_nextCell getBtn].layer.shadowRadius = 8.0;
    }
    else
    {
        [_nextCell  setBtnBackgroundColor:kUIColorFromRGB(color_8)];
        [_nextCell setBtnTitleColor:kUIColorFromRGB(color_2)];
        [_nextCell  setBtnEnabled:NO];
         [_nextCell getBtn].layer.shadowRadius = 0.0;
//         _nextCell.userInteractionEnabled = NO;
    }
    //    return YES;
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField;
{
    if (_canEditCode) {
        return YES;
    }
    return NO;
}
- (IBAction)test:(id)sender {
    
    
    DealPasswordViewController *vc = [DealPasswordViewController toDealVC:self];
    [vc  fitMode];
    vc.doneCallBack = ^(id o){
//        HUDSMILE(@"申请完成，注册成功", 2);
    };
}
-(void)viewWillAppear:(BOOL)animated
{
     self.navigationController.navigationBar.shadowImage = nil;
     self.navigationController.view.backgroundColor = kUIColorFromRGB(color_2);
     self.panGesture.enabled = NO;
}

//-(void)
-(void)initThirdLogin
{
     _viewThirdLoginContainer = [UIView new];
     _viewThirdLoginContainer.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleRightMargin;
     _viewThirdLoginContainer.width = __SCREEN_SIZE.width;
     _viewThirdLoginContainer.height = 160;
     _viewThirdLoginContainer.y = 420;
     [self.tableView addSubview:_viewThirdLoginContainer];
     if (__IPHONE5) {
           _viewThirdLoginContainer.y = 380;
//          _viewThirdLoginContainer.height = 112;
//          _viewThirdLoginContainer.y = __SCREEN_SIZE.height - _viewThirdLoginContainer.height;
     }
     else if(__LESSTHENIPHONE5)
     {
          _viewThirdLoginContainer.y = __SCREEN_SIZE.height - _viewThirdLoginContainer.height - 64;
     }

     _qqBtn = [UIButton new];
     [_viewThirdLoginContainer addSubview:_qqBtn];
     _qqBtn.height = 70;
     _qqBtn.customTitleLb.textColor = kUIColorFromRGB(color_2);
     _qqBtn.customTitleLb.text = @"QQ";
     _qqBtn.width = 60;
     _qqBtn.y = 46;
     _qqBtn.customTitleLb.y = 55;
     _qqBtn.customTitleLb.x = 5;
     _qqBtn.customTitleLb.width = 50;
     _qqBtn.customImgV.image = [UIImage imageContentWithFileName:@"login_qq"];
     _qqBtn.customImgV.width = 50;
     _qqBtn.customImgV.height = 50;
     _qqBtn.customImgV.x = 5;
     _qqBtn.customImgV.y = 0;
     _qqBtn.x = __SCREEN_SIZE.width/2.0 + 25;

     _wxBtn = [UIButton new];
     [_viewThirdLoginContainer addSubview:_wxBtn];
     _wxBtn.height = 70;
     _wxBtn.customTitleLb.textColor = kUIColorFromRGB(color_2);
     _wxBtn.customTitleLb.text = @"微信";
     _wxBtn.customTitleLb.width = 50;
     _wxBtn.width = 60;
     _wxBtn.y = 46;
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

     _loginTipLb = [UILabel new];
     _loginTipLb.width = 200;
     _loginTipLb.height = 14;
     _loginTipLb.textColor = kUIColorFromRGB(color_lineColor);
     _loginTipLb.font = [UIFont systemFontOfSize:14];
     _loginTipLb.text = @"第三方登录";
     CGSize s = [_loginTipLb.text size:_loginTipLb.font constrainedToSize:CGSizeMake(200, 20)];
     _loginTipLb.width = s.width;
     _loginTipLb.x = __SCREEN_SIZE.width/2.0 - _loginTipLb.width/2.0;
     [_viewThirdLoginContainer addSubview:_loginTipLb];

     _seplitLineLb = [UILabel new];
     _seplitLineLb.height = 0.5;
     _seplitLineLb.width = (__SCREEN_SIZE.width - 110 - _loginTipLb.width)/2.0;
     _seplitLineLb.x = 30;
     _seplitLineLb.y = 10;
     _seplitLineLb.backgroundColor = kUIColorFromRGB(color_lineColor);
     [_viewThirdLoginContainer addSubview:_seplitLineLb];

     _seplitLine2Lb = [UILabel new];
     _seplitLine2Lb.height = 0.5;
      _seplitLine2Lb.y = 10;
     _seplitLine2Lb.width = _seplitLineLb.width;
     _seplitLine2Lb.x = __SCREEN_SIZE.width - 30 - _seplitLine2Lb.width;
     _seplitLine2Lb.backgroundColor = kUIColorFromRGB(color_lineColor);
     [_viewThirdLoginContainer addSubview:_seplitLine2Lb];
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
