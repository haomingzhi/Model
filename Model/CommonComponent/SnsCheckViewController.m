//
//  SnsCheckViewController.m
//  lovecommunity
//
//  Created by air on 16/7/1.
//  Copyright © 2016年 ORANLLC_IOS1. All rights reserved.
//

#import "SnsCheckViewController.h"
#import "TextFieldTableViewCell.h"
#import "OnlyBottomBtnTableViewCell.h"
#import "OnlyTitleTableViewCell.h"
#import "PayPwdViewController.h"
#import "BUSystem.h"
@interface SnsCheckViewController ()
{
    OnlyTitleTableViewCell *_tipCell;
    TextFieldTableViewCell *_snsCell;
   OnlyBottomBtnTableViewCell* _submitCell;
    OnlyTitleTableViewCell *_sendTipCell;
   BOOL _hasSendCode;
}
@end

@implementation SnsCheckViewController

- (void)viewDidLoad {
    [self initTextCell];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"忘记支付密码";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initTextCell
{
    _tipCell = [OnlyTitleTableViewCell createTableViewCell];
    NSString *phone = busiSystem.agent.userInfo.tel;
    phone = [phone stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
    [_tipCell setCellData:@{@"title":[NSString stringWithFormat:@"本次操作需要短信确认，验证码已发送至手机:%@，请按提示操作",phone]}];
    [_tipCell fitCodeMode];
    _snsCell = [TextFieldTableViewCell createTableViewCell];
    [_snsCell setCellData:@{@"placeholder":@"输入验证码"}];
    [_snsCell fitModeF:self withSel:@selector(checkSns:)];
    _snsCell.textTf.keyboardType = UIKeyboardTypeNumberPad;
    [_snsCell.textTf addTarget:self action:@selector(textChange:) forControlEvents:UIControlEventEditingChanged];
    
}

-(void)checkSns:(UIButton *)btn
{
    NSString *phone = busiSystem.agent.userInfo.tel;
    phone = [phone stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
    [_sendTipCell setCellData:@{@"title":[NSString stringWithFormat:@"已向手机%@发送验证码",phone],@"textColor":kUIColorFromRGB(color_5)}];
    btn.enabled = NO;
    btn.tag = 60;
    [btn setTitle:@"60s" forState:UIControlStateNormal];
    [self performSelector:@selector(setSendSnsBtn:) withObject:btn afterDelay:1];
    [busiSystem.agent sendSms:busiSystem.agent.userInfo.tel  observer:self callback:@selector(sendSmsNotificaiton:)];
}

-(void)setSendSnsBtn:(UIButton *)btn
{
    if (btn.tag == 0) {
        btn.enabled = YES;
         [btn setTitle:@"获取验证码" forState:UIControlStateNormal];
        return;
    }
    btn.tag = btn.tag - 1;
     [btn setTitle:[NSString stringWithFormat:@"%lds",btn.tag] forState:UIControlStateNormal];
     [self performSelector:@selector(setSendSnsBtn:) withObject:btn afterDelay:1];
}

-(void)sendSmsNotificaiton:(BSNotification *)noti
{
    if(noti.error.code == 0)
    {
    TOASTSHOW(@"验证码发送成功");
     _hasSendCode = YES;
    [self textChange:nil];
    }else
    {
        HUDCRY(noti.error.domain, 2);
    }
}

-(void)initTableView:(MyTableView *)tableView
{
    tableView.refreshHeaderView = nil;
    _sendTipCell = [[NSBundle mainBundle] loadNibNamed:@"OnlyTitleTableViewCell" owner:nil options:nil].lastObject;
    
    __weak SnsCheckViewController *weakSelf = self;
    [tableView registerNib:[UINib nibWithNibName:@"OnlyTitleTableViewCell" bundle:nil] forCellReuseIdentifier:@"OnlyTitleTableViewCell"];
   _submitCell = [[NSBundle mainBundle] loadNibNamed:@"OnlyBottomBtnTableViewCell" owner:nil options:nil].lastObject;
    [_submitCell setCellData:@{@"title":@"下一步"}];
    [_submitCell fitCodeMode];
    [_submitCell setHandleAction:^(NSDictionary *ddic) {
        [weakSelf submit];
    }];
     [_submitCell  setBtnEnabled:NO];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.backgroundColor = kUIColorFromRGB(color_9);
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger row = 3;
    
    return row;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0)
    {
        return 50;
    }else
    if(indexPath.row == 1)
    {
        return 45;
    }
    else if(indexPath.row == 2)
    {
        return 94;
    }
    return 35;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell ;
    cell = [self createFirstSectionCell:indexPath withTableView:tableView];
    cell.backgroundColor = kUIColorFromRGB(color_2);
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


-(UITableViewCell *)createFirstSectionCell:(NSIndexPath *)indexPath withTableView:(UITableView *)tableView
{
//    __weak SnsCheckViewController *weakSelf = self;
    UITableViewCell *cell;
    if(indexPath.row == 0)
    {
        cell = _tipCell;
    }
        else
    if (indexPath.row == 1) {
        cell = _snsCell;
          cell.backgroundColor = kUIColorFromRGB(color_2);
        [_snsCell hiddenSeparatorView];
    }
    else if (indexPath.row == 2)
    {
        cell = _submitCell;
       
    }
    else
    {
        cell = _sendTipCell;
        
        [(OnlyTitleTableViewCell *)cell setCenterMode:35 withY:10];
        cell.backgroundColor = kUIColorFromRGB(color_9);
        
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

-(void)submit
{
    [self.view endEditing:YES];
    HUDSHOW(@"加载中");
    NSString *code = _snsCell.textTf.text;
    [busiSystem.agent checkSmsCode:code observer:self callback:@selector(checkSmsCodeNotification:)];
   // [busiSystem.agent addBankCard:_userInfo[@"name"] withBankCard:_userInfo[@"account"] withTell:busiSystem.agent.tell withCode:code observer:self callback:@selector(addBankCardNotification:)];
}

-(void)checkSmsCodeNotification:(BSNotification*)noti
{
    if (noti.error.code == 0) {
        HUDDISMISS;
        [self toNextVC];
    }
    else
    {
        HUDCRY(noti.error.domain, 2);
    }
}

-(void)toNextVC
{
    PayPwdViewController *vc = [PayPwdViewController new];
    vc.mode = 3;
    vc.userInfo = @{@"code":_snsCell.textTf.text};
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)addBankCardNotification:(BSNotification *)noti
{
//    busiSystem.agent.
   
    if ( noti.error.code == 1) {
        TOASTSHOW( noti.error.domain);
        return;
    }
    else
    [self toWithdrawWay:@""];
}

-(void)toWithdrawWay:(NSString *)cid
{
   // WithdrawWayViewController *vc =[[WithdrawWayViewController alloc] initWithNibName:@"UnBindWithdrawWayViewController" bundle:nil];
  //  vc.mode = 1;
  //   vc.userInfo = @{@"id":cid,@"phone":_userInfo[@"phone"],@"name":_userInfo[@"name"]};
  //  [self.navigationController pushViewController:vc animated:YES];
}

- (void)textChange:(UITextField *)textField  {
    if (textField.text.length >= 4 && _hasSendCode) {
        [_submitCell  setBtnBackgroundColor:kUIColorFromRGB(color_3)];
         [_submitCell setBtnTitleColor:kUIColorFromRGB(color_5)];
        [_submitCell  setBtnEnabled:YES];
    }
    else
    {
        [_submitCell  setBtnBackgroundColor:kUIColorFromRGB(color_8)];
         [_submitCell setBtnTitleColor:kUIColorFromRGB(color_2)];
        [_submitCell  setBtnEnabled:NO];
    }
    //    return YES;
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
