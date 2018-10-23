//
//  ForgetPwdViewController.m
//  taihe
//
//  Created by air on 2016/11/9.
//  Copyright © 2016年 ORANLLC_IOS1. All rights reserved.
//

#import "ForgetPwdViewController.h"
#import "ForgetPwdNextViewController.h"
#import "BUSystem.h"
#import "JYCommonTool.h"
#import "OnlyTitleTableViewCell.h"
@interface ForgetPwdViewController ()
{
     UIView *_footerView;
     OnlyTitleTableViewCell *_pwdTipCell;
}
@end

@implementation ForgetPwdViewController
-(id)init
{
     self = [super initWithNibName:@"RegisterViewController" bundle:nil];
     return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     if (_type == 2) {
          self.title = @"忘记密码";
     }else{
          self.title = @"注册";
     }
    
     [self fitMode];
     [self addGesture];
}
-(void)initThirdLogin
{}
-(void)addGesture{
     UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction)];
     [self.view addGestureRecognizer:tap];
     
}
-(void)tapAction{
     [self.view endEditing:YES];
}

-(void)fitMode
{
//    [self.phoneCell fitForgetPwdNextMode:@"login_phone"];
    
//    [self.codeCell fitModeE:self withSel:@selector(checkSns:)];
//    [self.pwdCell setCellData:@{@"placeholder":@"输入密码"}];
//    [self.pwdCell fitForgetPwdNextMode];
////    self.surepwdCell = [TextFieldTableViewCell createTableViewCell];
////    [self.surepwdCell setCellData:@{@"placeholder":@"再次输入密码"}];
//    [self.surepwdCell fitForgetPwdNextModeB];
//    
//    
    [self.nextCell setCellData:@{@"title":@"确定"}];
    [self.nextCell fitForgetPwdMode];
     
//     UIButton *nextBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, __SCREEN_SIZE.height-64-45, __SCREEN_SIZE.width, 45)];
//     [nextBtn addTarget:self action:@selector(submit) forControlEvents:UIControlEventTouchUpInside];
//     [nextBtn setTitle:@"提交" forState:UIControlStateNormal];
//     [nextBtn setTitleColor:kUIColorFromRGB(color_2) forState:UIControlStateNormal];
//     [nextBtn setBackgroundColor:kUIColorFromRGB(color_3)];
//     [self.view addSubview:nextBtn];
     self.tipCell = [TitleAndTextBtnTableViewCell createTableViewCell];
     [self.tipCell  setCellData:@{@"title":@""}];
     [self.tipCell fitRegMode];

     _pwdTipCell = [OnlyTitleTableViewCell createTableViewCell];
     [_pwdTipCell setCellData:@{@"title":@"密码为6~18位，必须包含数字和字母"}];
     [_pwdTipCell fitRegMode];
     
     
     self.pwdCell.textTf.placeholder = @"请输入新密码";
}


-(void)nextAction:(UIButton *)btn
{
     HUDSHOW(@"验证中");
     [busiSystem.agent checkVerify:self.phoneCell.textTf.text Verify:self.codeCell.textTf.text observer:self callback:@selector(checkVerifyNotification:)];
     
     
}

-(void)checkVerifyNotification:(BSNotification *)noti
{
     if (noti.error.code == 0) {
          HUDDISMISS;
          ForgetPwdNextViewController *vc = [[ForgetPwdNextViewController alloc] initWithNibName:@"RegisterViewController" bundle:nil];
          vc.userInfo = @{@"tel":self.phoneCell.textTf.text,@"type":@(_type)};
          vc.title = self.title;
          [self.navigationController pushViewController:vc animated:YES];
     }
     else
     {
          HUDCRY(noti.error.domain, 2);
     }
}

-(void)submit
{
    [self.view endEditing:YES];
    if (![JYCommonTool isMobileNum:self.phoneCell.textTf.text]) {
        HUDCRY(@"手机号格式有误", 2);
        return;
    }
    if (self.pwdCell.textTf.text.length < 6 || self.pwdCell.textTf.text.length > 18 ) {
           HUDCRY(@"密码需为6-12位数字或数字英文组合", 2);
            return;
    }
//    if (![self.pwdCell.textTf.text isEqualToString:self.surepwdCell.textTf.text]) {
//        HUDCRY(@"密码不一致", 2);
//        return;
//    }
     if (_type == 2) {//忘记密码
          [self forgetPwd];
     }else{
          [self registerUser];
     }
    
}


-(void)registerUser{
     HUDSHOW(@"提交中");
     [busiSystem.agent registerUser:self.phoneCell.textTf.text withPwd:self.pwdCell.textTf.text withCode:self.codeCell.textTf.text observer:self callback:@selector(registerUserNotification:)];
     //    RegisterNextViewController *vc = [RegisterNextViewController new];
     //    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:self.userInfo];
     //    dic[@"pwd"] = self.phoneCell.textTf.text;
     //    vc.userInfo = dic;
     //    [self.navigationController pushViewController:vc animated:YES];
}

-(void)registerUserNotification:(BSNotification *)noti
{
     if (noti.error.code == 0) {
//          [busiSystem.agent login:self.phoneCell.textTf.text password:self.pwdCell.textTf.text  observer:self callback:@selector(loginNotification:)];
          HUDSMILE(@"注册成功", 1);
          [self.navigationController popViewControllerAnimated:YES];
     }
     else
     {
          HUDCRY(noti.error.domain, 1);
     }
}

-(void)forgetPwd{
     HUDSHOW(@"提交中");
     [busiSystem.agent forgetPwd:self.phoneCell.textTf.text code:self.codeCell.textTf.text withPwd:self.pwdCell.textTf.text   observer:self callback:@selector(forgetPwdNotification:)];
}

-(void)forgetPwdNotification:(BSNotification *)noti
{
    if (noti.error.code == 0) {
        HUDDISMISS;
         HUDSMILE(@"修改成功", 1);
         [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        HUDCRY(noti.error.domain, 2);
    }
}

-(void)toNext
{
//    ForgetPwdNextViewController *vc = [[ForgetPwdNextViewController alloc] initWithNibName:@"RegisterViewController" bundle:nil];
//    vc.userInfo = @{@"tel":self.phoneCell.textTf.text};
    HUDSMILE(@"修改成功", 1);
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger row = 6;
    
    return row;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
     return 0.001;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
     return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
     return 0.001;
}

-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
//     if (!_footerView) {
//          _footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, __SCREEN_SIZE.width, 150)];
//          _footerView.backgroundColor = self.tableView.backgroundColor;
//          UIButton *nextBtn = [[UIButton alloc]initWithFrame:CGRectMake(42, 90, __SCREEN_SIZE.width-42*2, 45)];
//          [nextBtn addTarget:self action:@selector(submit) forControlEvents:UIControlEventTouchUpInside];
//          [nextBtn setTitle:@"确定" forState:UIControlStateNormal];
//          [nextBtn setTitleColor:kUIColorFromRGB(color_2) forState:UIControlStateNormal];
//          [nextBtn setBackgroundColor:kUIColorFromRGB(color_3)];
//          nextBtn.layer.cornerRadius = 6.0;
//          nextBtn.layer.masksToBounds = YES;
//          [_footerView addSubview:nextBtn];
//     }

     return nil;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    if (indexPath.row == 0) {
        cell = self.phoneCell;
        [self.phoneCell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(46, 0, 0, 0)];
    }
    else if (indexPath.row == 1)
    {
        cell = self.codeCell;
        [(JYAbstractTableViewCell *)cell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(46, 0, 0, 0)];
    }
    else if (indexPath.row == 2)
    {
        cell = self.pwdCell;
        [(JYAbstractTableViewCell *)cell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(46, 0, 0, 0)];
    }
    
    else if (indexPath.row == 3)
    {
        cell = _pwdTipCell;
//        [(JYAbstractTableViewCell *)cell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(50, 0, 0, 0)];
    }
    else if (indexPath.row == 4)
    {
        cell = self.nextCell;
    }else
    {
        cell = self.tipCell;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
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
