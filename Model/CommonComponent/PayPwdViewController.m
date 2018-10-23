//
//  PayPwdViewController.m
//  compassionpark
//
//  Created by air on 2017/2/3.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import "PayPwdViewController.h"
#import "OnlyTitleTableViewCell.h"
#import "PwdTableViewCell.h"
//#import "ForgetPwdNextViewController.h"
#import "SnsCheckViewController.h"
#import "PersonInfoViewController.h"
#import "BUSystem.h"

@interface PayPwdViewController ()
{
    PwdTableViewCell *_payPwdCell;
    PwdTableViewCell *_payPwdAgCell;
    
    OnlyTitleTableViewCell *_inputTipCell;
    OnlyTitleTableViewCell *_inputAgTipCell;
    
    OnlyTitleTableViewCell *_tipCell;
}
@property (strong, nonatomic) IBOutlet MyTableView *tableView;

@end

@implementation PayPwdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
     [self initTableView];
    if (_mode == 0) {
      self.title = @"设置支付密码";
        [self setRightNavBtn];
          [_payPwdAgCell.passwordTf addTarget:self action:@selector(changeValue2:) forControlEvents:UIControlEventEditingChanged];
         [_payPwdCell.passwordTf addTarget:self action:@selector(changeValue:) forControlEvents:UIControlEventEditingChanged];
    }
    else if (_mode == 1)
    {
     self.title = @"设置支付密码";
          [_payPwdCell.passwordTf addTarget:self action:@selector(changeValue:) forControlEvents:UIControlEventEditingChanged];
    }
    else if (_mode == 2)
    {
     self.title = @"修改支付密码";
    
        [self setLeftNavBtn];
         [self setRightNavBtn];
          [_payPwdAgCell.passwordTf addTarget:self action:@selector(changeValue2:) forControlEvents:UIControlEventEditingChanged];
         [_payPwdCell.passwordTf addTarget:self action:@selector(changeValue:) forControlEvents:UIControlEventEditingChanged];
    }
    else
    {
        self.title = @"重置支付密码";
        
        [self setRightNavBtn];
        [_payPwdAgCell.passwordTf addTarget:self action:@selector(changeValue2:) forControlEvents:UIControlEventEditingChanged];
         [_payPwdCell.passwordTf addTarget:self action:@selector(changeValue:) forControlEvents:UIControlEventEditingChanged];
    }
  
}

-(void)viewDidAppear:(BOOL)animated
{
   
  [_payPwdCell.passwordTf becomeFirstResponder];
}

-(void)viewDidDisappear:(BOOL)animated
{
    _payPwdCell.passwordTf.text = @"";
    _payPwdAgCell.passwordTf.text = @"";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setRightNavBtn
{
    [self setNavigateRightButton:@"确认" font:[UIFont systemFontOfSize:15] color:kUIColorFromRGB(color_5)];
}

-(void)setLeftNavBtn
{
        [self setNavigateLeftButton:@"取消" font:[UIFont systemFontOfSize:15] color:kUIColorFromRGB(color_5)];
}

-(void)handleReturnBack:(id)sender
{
    if (_mode == 2) {
          [[CommonAPI managerWithVC:self] showAlert:@selector(toBack:) withTitle:nil withMessage:@"确认取消对支付密码的修改？" withObj:@{}];
    }
    else
    {
        [super handleReturnBack:sender];
    }
}

-(void)toBack:(NSDictionary*)dic
{
    if ([dic[@"code"] integerValue] == 0) {
       [self.navigationController popViewControllerAnimated:YES];
    }
    
}


-(void)handleDidRightButton:(id)sender
{
    [self.view endEditing:YES];
 
    if (_mode == 3) {
        HUDSHOW(@"加载中");
        [busiSystem.agent forgetPwd:busiSystem.agent.userInfo.tel?:@"" code:_userInfo[@"code"]?:@"" withPwd:_payPwdCell.passwordTf.text    observer:self callback:@selector(forgetPwdNotification:)];
    }
    else
    {
        if (![_payPwdCell.passwordTf.text isEqualToString:_payPwdAgCell.passwordTf.text]) {
            HUDCRY(@"两次输入密码不一致",2);
            return;
        }
            HUDSHOW(@"提交中");
        [busiSystem.agent changeUserPassword :@"2" withOldPwd:_userInfo[@"pwd"]?:@"" withNewPwd:_payPwdCell.passwordTf.text observer:self callback:@selector(passwordModifyNotification:)];
    }
}

-(void)checkPayPasswordNotification:(BSNotification *)noti
{
    if (noti.error.code == 0) {
        HUDDISMISS;
        PayPwdViewController *vc = [PayPwdViewController new];
        vc.mode = 2;
        vc.userInfo = @{@"pwd":_payPwdCell.passwordTf.text};
        [self.navigationController pushViewController:vc animated:YES];
        _payPwdCell.passwordTf.text = @"";
    }
    else
    {
        [[CommonAPI managerWithVC:self] showAlertView:nil withMsg:@"支付密码错误，请重试" withBtnTitle:@"忘记密码" withCancelBtnTitle:@"重试" withSel:@selector(toForget:) withUserInfo:@{}];
       // HUDCRY(noti.error.domain, 2);
        HUDDISMISS;
    }
}

-(void)forgetPwdNotification:(BSNotification *)noti
{
    if (noti.error.code == 0) {
        HUDSMILE(@"设置成功", 2);
        busiSystem.agent.userInfo.hasPayPassword = 1;
        [self performSelector:@selector(toNextVC) withObject:nil afterDelay:2];
    }
    else
    {
        HUDCRY(noti.error.domain, 2);
    }
}

-(void)toNextVC
{
    [self.navigationController popToViewController:self.navigationController.viewControllers[2] animated:YES];
}

-(void)passwordModifyNotification:(BSNotification *)noti
{
    if (noti.error.code == 0) {
        HUDSMILE(@"修改成功", 2);
        busiSystem.agent.userInfo.hasPayPassword = 1;
        [self performSelector:@selector(toLoginVC) withObject:nil afterDelay:2];
    }
    else
    {
        HUDCRY(noti.error.domain, 2);
    }
}
-(void)toLoginVC
{
    for (UIViewController *vc  in self.navigationController.viewControllers) {
        if ([vc isKindOfClass:[PersonInfoViewController class]]) {
            [self.navigationController popToViewController:vc animated:YES];
        }
    }
//    [self.navigationController popViewControllerAnimated:YES];
}

-(void)initTableView
{
    
    _tableView.backgroundColor = kUIColorFromRGB(color_9);
    _inputTipCell = [OnlyTitleTableViewCell createTableViewCell];
    [_inputTipCell setCellData:@{@"title":@"请输入支付密码"}];
    [_inputTipCell fitPayPwdMode];
    _inputAgTipCell = [OnlyTitleTableViewCell createTableViewCell];
    [_inputAgTipCell setCellData:@{@"title":@"请再次输入支付密码"}];
    [_inputAgTipCell fitPayPwdMode];
    _payPwdCell = [PwdTableViewCell createTableViewCell] ;
    [_payPwdCell fitMode];
    _payPwdAgCell = [PwdTableViewCell createTableViewCell];
    [_payPwdAgCell fitMode];
    _tipCell = [OnlyTitleTableViewCell createTableViewCell];
    [_tipCell setCellData:@{@"title":@"（密码由6位数字组成）"}];
     [_tipCell fitPayPwdModeB];
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger row = 5;
    if (_mode == 1) {
        row = 2;
    }
    
    return row;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    
    return 0.001;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.001;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 44;
    if(indexPath.row == 0||indexPath.row == 2)
    {
        height = 65;
    }
    else if(indexPath.row == 1 ||indexPath.row == 3)
    {
    height = 52;
    }
    else
    {
        height = 30;
    }
    return height;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    if (indexPath.row == 0) {
       cell = _inputTipCell;
    }
    else if (indexPath.row == 1)
    {
        cell = _payPwdCell;
    }
    else if (indexPath.row == 2)
    {
        cell = _inputAgTipCell;
    }
    else  if (indexPath.row == 3)
    {
        cell = _payPwdAgCell;
    }
    else
    {
        cell = _tipCell;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)forgetPwd {
    [self.view endEditing:YES];
    SnsCheckViewController *vc = [[SnsCheckViewController alloc] initWithNibName:@"UnBindWithdrawWayViewController" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)changeValue2:(UITextField*)txtTf
{
    if (txtTf.text.length == 6) {
        [self.parentDialog dismiss];
        [self.view endEditing:YES];
        if(![_payPwdAgCell.passwordTf.text isEqualToString: _payPwdCell.passwordTf.text])
        {
            HUDCRY(@"两次输入密码不一致", 2);
            _payPwdAgCell.passwordTf.text = @"";
            _payPwdCell.passwordTf.text = @"";
            return;
        }
        
        
    }
}

-(void)changeValue:(UITextField*)txtTf
{
    if (_mode == 1) {
        if (txtTf.text.length == 6) {
            
            HUDSHOW(@"提交中");
            [busiSystem.agent checkPayPassword:_payPwdCell.passwordTf.text observer:self callback:@selector(checkPayPasswordNotification:)];
            
        }
    }
    else
    {
       if (txtTf.text.length == 6) {
           [_payPwdAgCell.passwordTf becomeFirstResponder];
       }
    }
    
    
}

-(void)toForget:(NSDictionary *)dic
{
    if ([dic[@"code"] integerValue] == 0) {
        
        [self forgetPwd];
    }
    else{
    _payPwdCell.passwordTf.text = @"";
    }
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
