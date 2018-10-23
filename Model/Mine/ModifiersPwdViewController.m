//
//  ModifiersPwdViewController.m
//  taihe
//
//  Created by air on 2016/11/9.
//  Copyright © 2016年 ORANLLC_IOS1. All rights reserved.
//

#import "ModifiersPwdViewController.h"
#import "BlankTableViewCell.h"
#import "ForgetPwdViewController.h"
#import "BUSystem.h"
#import "LoginViewController.h"
#import "PersonInfoViewController.h"

@interface ModifiersPwdViewController ()
{
    BlankTableViewCell *_blankCell;
    TextFieldTableViewCell *_comfirmCell;
}
@end

@implementation ModifiersPwdViewController
-(id)init
{
     self = [super initWithNibName:@"RegisterViewController" bundle:nil];
     return self;
}

- (void)viewDidLoad {
    _blankCell = [BlankTableViewCell createTableViewCell];
    [_blankCell fitModiPwdMode];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"修改密码";
    [self fitMode];
     [self setNavigateRightButton:@"完成" font:[UIFont systemFontOfSize:15] color:kUIColorFromRGB(color_1)];
}
-(void)initThirdLogin
{
}
-(void)viewWillAppear:(BOOL)animated
{
     [self setNavigateLeftButton:@"nav_back"];
     self.panGesture.enabled = YES;
}
-(void)viewDidAppear:(BOOL)animated
{
   [self.phoneCell.textTf becomeFirstResponder];
}
-(void)fitMode
{
    [self.phoneCell setCellData:@{@"placeholder":@"请输入旧密码"}];
    [self.phoneCell fitModiPwdMode:@"旧密码"];
     self.phoneCell.textTf.kbMovingView = self.view;
    self.phoneCell.textTf.keyboardType = UIKeyboardTypeASCIICapable;
    self.phoneCell.textTf.secureTextEntry = YES;
    self.codeCell = [TextFieldTableViewCell createTableViewCell];
    [self.codeCell setCellData:@{@"placeholder":@"请输入新密码（6至20位数字或字母）"}];
    [self.codeCell fitModiPwdMode:@"新密码"];
     self.codeCell.textTf.secureTextEntry = YES;
      [self.codeCell.textTf addTarget:self action:@selector(textChange:) forControlEvents:UIControlEventEditingChanged];
      self.codeCell.textTf.kbMovingView = self.view;
    _comfirmCell = [TextFieldTableViewCell createTableViewCell];
    [_comfirmCell setCellData:@{@"placeholder":@"请再次输入新密码"}];
    [_comfirmCell fitModiPwdMode:@"确认密码"];
     _comfirmCell.textTf.secureTextEntry = YES;
     _comfirmCell.textTf.keyboardType = UIKeyboardTypeASCIICapable;
      [_comfirmCell.textTf addTarget:self action:@selector(textChange:) forControlEvents:UIControlEventEditingChanged];
       _comfirmCell.textTf.kbMovingView = self.view;
    [self.nextCell setCellData:@{@"title":@"确认"}];
    [self.nextCell  setBtnBackgroundColor:kUIColorFromRGB(color_8)];
    [self.nextCell  setBtnTitleColor:kUIColorFromRGB(color_2)];
    [self.nextCell  setBtnEnabled:NO];
//    [self.nextCell fitModiPwdMode:self withSel:@selector(forgetHandle:)];
//    [self.nextCell setHandleAction:^(id o) {
//        
//    }];

     self.tableView.backgroundColor = kUIColorFromRGB(color_0xf0f0f0);
}

-(void)handleDidRightButton:(id)sender
{
     [self.view endEditing:YES];
     [self submit];
}
-(void)submit
{
    [self.view endEditing:YES];
    if (self.codeCell.textTf.text.length < 6 || self.codeCell.textTf.text.length > 12 ) {
        HUDCRY(@"密码需为6-20位数字或数字英文组合", 2);
        return;
    }
    if (![self.codeCell.textTf.text isEqualToString:_comfirmCell.textTf.text]) {
        HUDCRY(@"2次输入的新密码不一致",1);
        return;
    }
    HUDSHOW(@"提交中");
    [busiSystem.agent changeUserPassword :@"1" withOldPwd:self.phoneCell.textTf.text withNewPwd:_comfirmCell.textTf.text observer:self callback:@selector(passwordModifyNotification:)];
}

-(void)passwordModifyNotification:(BSNotification *)noti
{
    if (noti.error.code == 0) {
        HUDSMILE(@"修改成功", 1);
        busiSystem.agent.password = _comfirmCell.textTf.text;
        [self performSelector:@selector(toLoginVC) withObject:nil afterDelay:1];
    }
    else
    {
        HUDCRY(noti.error.domain, 1);
    }
}

-(void)toLoginVC
{
//    busiSystem.agent.isLogin =NO;
//    busiSystem.agent.token = nil;
//    //        busiSystem.agent.header = nil;
//    busiSystem.agent.isCancel =YES;
//    
//    busiSystem.agent.isNeedRefreshTabC = YES;
//    busiSystem.agent.isNeedRefreshTabB = YES;
//    busiSystem.agent.isNeedRefreshTabA = YES;
//    [LoginViewController toLogin:self];
//    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    [self.navigationController popViewControllerAnimated:YES];

}

-(void)forgetHandle:(UIButton *)btn
{
//    ForgetPwdViewController *vc = [[ForgetPwdViewController alloc] initWithNibName:@"RegisterViewController" bundle:nil];
//    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger row = 3;
    
    return row;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.001;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
     CGFloat height = 45;
     return height;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    if (indexPath.row == 0) {
        cell = self.phoneCell;
        [self.phoneCell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(45, 0, 0, 0)];
    }
    else if (indexPath.row == 1)
    {
        cell = self.codeCell;
        [self.codeCell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(45, 0, 0, 0)];
    }
//    else if (indexPath.row == 2)
//    {
//        cell = _blankCell;
//        [_blankCell showCustomSeparatorView:kUIColorFromRGB(color_mainTheme) withInsets:UIEdgeInsetsMake(41, 0, 0, 0)];
//    }
    else if (indexPath.row == 2)
    {
        cell = _comfirmCell;
              [_comfirmCell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(45, 0, 0, 0)];
    }else
    {
        cell = self.nextCell;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)textChange:(UITextField *)textField  {
    
    if (self.codeCell.textTf.text.length >= 6 && self.phoneCell.textTf.text.length >= 6 &&_comfirmCell.textTf.text.length >= 6) {
        [self.nextCell  setBtnBackgroundColor:kUIColorFromRGB(color_3)];
         [self.nextCell  setBtnTitleColor:kUIColorFromRGB(color_5)];
        [self.nextCell  setBtnEnabled:YES];
    }
    else
    {
        [self.nextCell  setBtnBackgroundColor:kUIColorFromRGB(color_8)];
         [self.nextCell  setBtnTitleColor:kUIColorFromRGB(color_2)];
        [self.nextCell  setBtnEnabled:NO];
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
