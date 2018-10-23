//
//  WithdrawViewController.m
//  compassionpark
//
//  Created by air on 2017/2/9.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import "WithdrawViewController.h"
#import "TitleAndTextfieldTableViewCell.h"
#import "TitleDetailTableViewCell.h"
#import "OnlyTitleTableViewCell.h"
#import "OnlyBottomBtnTableViewCell.h"
#import "WithdrawPasswordViewController.h"
#import "WithdrawSuccessViewController.h"
#import "BUSystem.h"
#import "SnsCheckViewController.h"
#import "PayPwdViewController.h"
#import "JYCommonTool.h"
#import "InputPassViewController.h"
@interface WithdrawViewController ()
{
    TitleAndTextfieldTableViewCell *_nameCell;
    TitleAndTextfieldTableViewCell *_aliPayCell;

    TitleDetailTableViewCell *_canWithdrawTipCell;
    OnlyTitleTableViewCell *_tipCell;
    OnlyBottomBtnTableViewCell *_btnCell;
    OnlyTitleTableViewCell *_getTimeTipCell;
}
@property (strong, nonatomic) IBOutlet MyTableView *tableView;
@property (strong, nonatomic)   TitleAndTextfieldTableViewCell *moneyCell;
@property (strong, nonatomic)  InputPassViewController *inputVC;
@end

@implementation WithdrawViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"提现";
    [self initTalbeView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)initTalbeView
{
       __weak WithdrawViewController *weakSelf = self;
    self.tableView.backgroundColor = kUIColorFromRGB(color_9);
    self.tableView.refreshHeaderView = nil;
    _nameCell = [TitleAndTextfieldTableViewCell createTableViewCell];
    [_nameCell setCellData:@{@"title":@"账户名",@"placeholder":@"请输入账户真实姓名"}];
    [_nameCell fitWithdrawMode];
    
     _aliPayCell = [TitleAndTextfieldTableViewCell createTableViewCell];
    [_aliPayCell setCellData:@{@"title":@"支付宝账户",@"placeholder":@"请输入支付宝账号"}];
    [_aliPayCell fitWithdrawMode];
    _aliPayCell.textField.keyboardType = UIKeyboardTypeAlphabet;
    
     _moneyCell = [TitleAndTextfieldTableViewCell createTableViewCell];
//    [_moneyCell setCellData:@{@"title":@"提现金额(元)",@"placeholder":[NSString stringWithFormat:@"单笔最高转出%.2f元",busiSystem.agent.config.withdrawMax]}];
    [_moneyCell fitWithdrawMode];
    _moneyCell.textField.keyboardType = UIKeyboardTypeDecimalPad;
    
     _canWithdrawTipCell = [TitleDetailTableViewCell createTableViewCell];
    [_canWithdrawTipCell setCellData:@{@"title":[NSString stringWithFormat:@"当前可提现收益 %.2f元",busiSystem.agent.userInfo.balance],@"detail":@"全部提现"}];
//    [_canWithdrawTipCell fitWithdrawMode];
    [_canWithdrawTipCell setHandleAction:^(id o) {
        weakSelf.moneyCell.textField.text = [NSString stringWithFormat:@"%.2f",busiSystem.agent.userInfo.balance];
    }];
    
    _tipCell = [OnlyTitleTableViewCell createTableViewCell];
//    [_tipCell setCellData:@{@"title":[NSString stringWithFormat:@"注：您的单笔提现最低额%.2f，单笔提现最高额%.2f",busiSystem.agent.config.withdrawMin,busiSystem.agent.config.withdrawMax ]}];
    [_tipCell fitWithdrawMode];
    
    _btnCell = [OnlyBottomBtnTableViewCell createTableViewCell];
       [_btnCell setCellData:@{@"title":@"确认提现"}];
    [_btnCell fitWithdrawMode];
 
    [_btnCell setHandleAction:^(id o) {
        [weakSelf.view endEditing:YES];
        [weakSelf toFitOption];
    }];
    
    _getTimeTipCell = [OnlyTitleTableViewCell createTableViewCell];
       [_getTimeTipCell setCellData:@{@"title":@"预计3个工作日内到账"}];
        [_getTimeTipCell fitWithdrawModeB];
}

-(void)toFitOption
{
//    if ( _nameCell.textField.text.length == 0||![JYCommonTool isAllChinese:_nameCell.textField.text]|| _nameCell.textField.text.length > 4) {
//        HUDCRY(@"您输入的账号名有误",2);
//        return;
//    }
//    if (![JYCommonTool isMobileNum:_aliPayCell.textField.text] && ![JYCommonTool validateEmail:_aliPayCell.textField.text]) {
//        HUDCRY(@"您输入的支付宝账户有误", 2);
//        return;
//    }
//    if ([_moneyCell.textField.text doubleValue] > busiSystem.agent.config.withdrawAddupMax) {
//        HUDCRY(@"您的提现金额已超过累计提现上限", 2);
//        return;
//    }
//
//    if ([_moneyCell.textField.text doubleValue] < 100 ) {
//        HUDCRY(@"提现金额低于单笔限额", 2);
//        return;
//    }
//
//    if (  [_moneyCell.textField.text doubleValue] > 5000) {
//        HUDCRY(@"提现金额超出单笔限额", 2);
//        return;
//    }

    if (busiSystem.agent.userInfo.hasPayPassword == 0) {
          [[CommonAPI managerWithVC:self] showAlertView:nil withMsg:@"您还未设置支付/提现密码，请前往设置" withBtnTitle:@"取消" withCancelBtnTitle:@"确认" withSel:@selector(toPayPwdSettingHandle:) withUserInfo:@{}];
        return;
    }
    [self toWithdrawVC];
}

-(void)toWithdrawVC
{
//    __weak WithdrawPasswordViewController *vc = [WithdrawPasswordViewController toWithdrawVC:self];
//    vc.doneCallBack = ^(id o){
//        //            HUDSMILE(@"支付", 2);
//        [vc.parentDialog dismiss];
//        [self submit];
//    };
//    vc.cancelCallBack = ^(id o){
//        //         HUDSMILE(@"取消", 2);
//        [vc.parentDialog cancel];
//    };
//    vc.forgetCallBack = ^(id o){
//        [self forgetPwd];
//    };
    __weak WithdrawViewController *weakSelf = self;
    _inputVC = [InputPassViewController createLimitVC];
    [_inputVC setHandleGoBack:^(NSDictionary *dic) {
        int  tag = [dic[@"tag"] intValue];
        //1:忘记密码 2:提现申请
        if(tag == 1) {
//            SnsCheckViewController *vc = [[SnsCheckViewController alloc] initWithNibName:@"UnBindWithdrawWayViewController" bundle:nil];
//            [weakSelf.navigationController pushViewController:vc animated:YES];
            [weakSelf forgetPwd];
        }else{
            [weakSelf checkPwd:dic[@"pass"]];
            
            
        }
    }];
}


-(void)checkPwd:(NSString *)pwd{
    HUDSHOW(@"提交中");
    [busiSystem.agent checkPayPassword:pwd observer:self callback:@selector(checkPayPasswordNotification:)];
}


-(void)checkPayPasswordNotification:(BSNotification *)noti
{
    if (noti.error.code == 0) {
        [self submit];
    }
    else
    {
        HUDDISMISS;
        if ([busiSystem.agent.codeResult integerValue] == 2) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"支付/提现密码输入错误，请重试" delegate:self cancelButtonTitle:nil otherButtonTitles:@"忘记密码",@"重试", nil];
            alert.tag = 1;
            [alert show];
        }else if ([busiSystem.agent.codeResult integerValue] == 3) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"已达最大尝试次数，请10分钟后再试" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            alert.tag = 0;
            [alert show];
        }else
        HUDCRY( noti.error.domain , 1);
    }
}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag == 1) {
        if (buttonIndex == 0) {
            [self forgetPwd];
        }else{
            [self toWithdrawVC];
        }
    }
}


-(void)toPayPwdSettingHandle:(NSDictionary *)dic
{
    NSInteger tag = [dic[@"tag"] integerValue];
    if (tag == 100) {
        PayPwdViewController *vc = [PayPwdViewController new];
        vc.mode = busiSystem.agent.userInfo.hasPayPassword == 0 ? 0:1;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

-(void)toProcessResult:(NSDictionary *)dic
{
    NSInteger tag = [dic[@"tag"] integerValue];
    if (tag == 100) {
        [self.view endEditing:YES];
        [self forgetPwd];
    }
}

- (void)forgetPwd {
    [self.view endEditing:YES];
    SnsCheckViewController *vc = [[SnsCheckViewController alloc] initWithNibName:@"UnBindWithdrawWayViewController" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)toNextVC
{
    WithdrawSuccessViewController *vc = [WithdrawSuccessViewController new];
    vc.userInfo = @{@"money":_moneyCell.textField.text};
    [self.navigationController pushViewController:vc animated:YES];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger row = 7;
    return row;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    
    return 10;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *v = [UIView new];
    v.height = 10;
    v.width = __SCREEN_SIZE.width;
    v.backgroundColor = kUIColorFromRGB(color_9);
    return v;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.001;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger height = 70;
    if (indexPath.row == 0 || indexPath.row == 1 || indexPath.row == 2) {
        height = 45;
    }
    else if (indexPath.row == 3)
    {
        height = 24;
    }
    else if (indexPath.row == 4)
    {
        height = 28;
    }

    else if (indexPath.row == 5)
    {
        height = 94;
    }
    else
    {
        height = 34;
    }

    return height;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    if (indexPath.row == 0) {
        cell = _nameCell;
        [_nameCell showCustomSeparatorView:kUIColorFromRGB(color_mainTheme) withInsets:UIEdgeInsetsMake(45, 0, 0, 0)];
    }
    else if(indexPath.row == 1)
    {
        cell = _aliPayCell;
          [_aliPayCell showCustomSeparatorView:kUIColorFromRGB(color_mainTheme) withInsets:UIEdgeInsetsMake(45, 0, 0, 0)];
    }
    else if(indexPath.row == 2)
    {
        cell = _moneyCell;
    }
    else if(indexPath.row == 3)
    {
        cell = _canWithdrawTipCell;
    }
    else if(indexPath.row == 4)
    {
        cell = _tipCell;
    }
    else if(indexPath.row == 5)
    {
        cell = _btnCell;
    }
    else
    {
        cell = _getTimeTipCell;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)submit
{
//    [busiSystem.agent addUserWithdraw:_aliPayCell.textField.text withMoney:_moneyCell.textField.text withName:[_nameCell textField].text observer:self callback:@selector(addUserWithdrawNotification:)];
}

-(void)addUserWithdrawNotification:(BSNotification *)noti
{
    if (noti.error.code == 0) {
        HUDSMILE(@"提现申请提交成功", 2);
        [self performSelector:@selector(toNextVC) withObject:nil afterDelay:1];
    }
    else
    {
        HUDCRY(noti.error.domain, 2);
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
