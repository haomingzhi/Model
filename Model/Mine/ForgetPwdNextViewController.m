//
//  ForgetPwdNextViewController.m
//  taihe
//
//  Created by air on 2016/11/9.
//  Copyright © 2016年 ORANLLC_IOS1. All rights reserved.
//

#import "ForgetPwdNextViewController.h"
#import "BUSystem.h"
#import "TwoTabsTableViewCell.h"
@interface ForgetPwdNextViewController ()
{
     TwoTabsTableViewCell *_tabsCell;
}
@end

@implementation ForgetPwdNextViewController

-(id)init
{
     self = [super initWithNibName:@"RegisterViewController" bundle:nil];
     return self;
}
-(void)viewWillAppear:(BOOL)animated
{
     [self setNavigateLeftButton:@"nav_back"];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"修改手机";
    [self fitMode];
}

-(void)fitMode
{
    __weak ForgetPwdNextViewController *weakSelf = self;
    [self.phoneCell setCellData:@{@"placeholder":@"请输入验证码"}];
    [self.phoneCell fitForgetPwdNextMode];
    
     
    self.codeCell = [TextFieldTableViewCell createTableViewCell];
    [self.codeCell setCellData:@{@"placeholder":@"  ",@"title":@"18**88880"}];
     [self.codeCell fitForgetPwdNextModeB:self withSel:@selector(checkSns:)];
      self.codeCell.textTf.enabled = NO;
//     self.codeCell.textTf.editing = NO;
     [self.codeCell getCodeBtn].enabled = YES;
     [self.codeCell getCodeBtn].layer.borderColor = kUIColorFromRGB(color_2).CGColor;
     [self.codeCell getCodeBtn].backgroundColor = kUIColorFromRGB(color_3);
     [[self.codeCell getCodeBtn] setTitleColor:kUIColorFromRGB(color_2) forState:UIControlStateNormal];
//     [[self.codeCell getCodeBtn] addTarget:se÷lf action:@selector(checkSns:) forControlEvents:UIControlEventTouchUpInside];
        [self.codeCell.textTf addTarget:self action:@selector(textChange:) forControlEvents:UIControlEventEditingChanged];
    [self.nextCell setCellData:@{@"title":@"下一步"}];
     [self.nextCell fitModiPhoneMode];
    [self.nextCell setHandleAction:^(id o) {
        [weakSelf submit];
    }];
     [self.tipCell setCellData:@{@"title":@"温馨提示：手机号码修改成功后需要使用新的手机号码进 行登录。"}];
     [self.tipCell fitModiPhoneMode];
     
     _tabsCell = [TwoTabsTableViewCell createTableViewCell];
     [_tabsCell setCellData:@{@"tab1":@"1.验证原号码",@"tab2":@"2.绑定新手机"}];
     [_tabsCell fitModiPhoneMode:0];
     self.tableView.backgroundColor = kUIColorFromRGB( color_0xf0f0f0);
}

- (void)textChange:(UITextField *)textField  {
   
    
    if (self.codeCell.textTf.text.length >= 1 && self.phoneCell.textTf.text.length >= 1) {
        [self.nextCell  setBtnBackgroundColor:kUIColorFromRGB(color_3)];
        [self.nextCell  setBtnEnabled:YES];
    }
    else
    {
        [self.nextCell  setBtnBackgroundColor:kUIColorFromRGB(color_0xb0b0b0)];
        [self.nextCell  setBtnEnabled:NO];
    }
    //    return YES;
}


-(void)submit
{
    [self.view endEditing:YES];
//    if (![self.phoneCell.textTf.text isEqualToString:self.codeCell.textTf.text]) {
//        HUDCRY(@"新密码和确认密码不一致", 1);
//               return;
//               }
     [_tabsCell fitModiPhoneMode:1];
     [self.codeCell setCellData:@{@"placeholder":@"请输入手机号码"}];
     self.codeCell.textTf.enabled = YES;
        [self.phoneCell setCellData:@{@"placeholder":@"请输入验证码"}];
         [self.phoneCell fitForgetPwdNextMode];
//    HUDSHOW(@"加载");
//    [busiSystem.agent updatePwdByForget:_userInfo[@"tel"] Npwd:self.phoneCell.textTf.text observer:self callback:@selector(updatePwdByForgetNotification:)];
}

-(void)updatePwdByForgetNotification:(BSNotification *)noti
{
    if (noti.error.code == 0) {
        HUDDISMISS;
         [self.navigationController popToRootViewControllerAnimated:YES];
    }else
    {
        HUDCRY(noti.error.domain, 1);
    }
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger row = 5;
    
    return row;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
     UITableViewCell *cell;
     if (indexPath.row == 2) {
          cell = self.phoneCell;
                  [self.phoneCell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(41, 0, 0, 0)];
     }
     else if (indexPath.row == 1)
     {
          cell = self.codeCell;
                  [self.codeCell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(41, 0, 0, 0)];
     }
     //    else if (indexPath.row == 2)
     //    {
     //        cell = _blankCell;
     //        [_blankCell showCustomSeparatorView:kUIColorFromRGB(color_mainTheme) withInsets:UIEdgeInsetsMake(10, 0, 0, 0)];
     //    }
     else if (indexPath.row == 0)
     {
          cell = _tabsCell;
                        [_tabsCell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(40, 0, 0, 0)];
     }else if (indexPath.row == 3)
     {
          cell = self.nextCell;
     }
     else
     {
          cell = self.tipCell;
          
     }
     cell.selectionStyle = UITableViewCellSelectionStyleNone;
     return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
     CGFloat height = 50;
     if (indexPath.row == 0) {
          height = 40;
     }
     else if (indexPath.row == 1)
     {
          height = 41;
     }
     else if (indexPath.row == 2)
     {
          height = 41;
     }
     else if (indexPath.row == 3)
     {
          height = 66;
     }
     else
     {
          height = 46;
     }
     return height;
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
