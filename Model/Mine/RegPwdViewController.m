//
//  RegPwdViewController.m
//  taihe
//
//  Created by air on 2016/11/17.
//  Copyright © 2016年 ORANLLC_IOS1. All rights reserved.
//

#import "RegPwdViewController.h"
#import "RegisterNextViewController.h"
#import "BUSystem.h"
@interface RegPwdViewController ()
{
  TextFieldTableViewCell *_nickCell;
}
@end

@implementation RegPwdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"注册";
    [self fitModeB];
}

-(void)fitModeB
{
   
        [self.nextCell setCellData:@{@"title":@"完成注册"}];
    _nickCell = [TextFieldTableViewCell createTableViewCell];
    [_nickCell setCellData:@{@"placeholder":@"昵称"}];
    [_nickCell fitRegNextMode];
    _nickCell.textTf.delegate = self;
    [_nickCell.textTf addTarget:self action:@selector(textChange:) forControlEvents:UIControlEventEditingChanged];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)submit
{
     [self.view endEditing:YES];
    if (![self.phoneCell.textTf.text isEqualToString:self.codeCell.textTf.text]) {
        HUDCRY(@"密码不一致", 1);
        return;
    }
    if (![BSUtility isRightNameStyle:_nickCell.textTf.text withMax:16 withMin:4]) {
        HUDCRY(@"昵称未填或太短", 1);
        return;
    }
    
    HUDSHOW(@"提交中");
    [busiSystem.agent registerUser:self.userInfo[@"tel"] withPwd:self.phoneCell.textTf.text withCode:self.userInfo[@"code"]  observer:self callback:@selector(registerUserNotification:)];
//    RegisterNextViewController *vc = [RegisterNextViewController new];
//    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:self.userInfo];
//    dic[@"pwd"] = self.phoneCell.textTf.text;
//    vc.userInfo = dic;
//    [self.navigationController pushViewController:vc animated:YES];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger row = 4;
    
    return row;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 50;
    if (indexPath.row == 2) {
        height = 50;
    }
    else if (indexPath.row == 3)
    {
        height = 100;
    }
    return height;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    if (indexPath.row == 0) {
        cell = self.phoneCell;
        [self.phoneCell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(50, 0, 0, 0)];
    }
    else if (indexPath.row == 1)
    {
        cell = self.codeCell;
        [self.codeCell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(50, 0, 0, 0)];
    }
    else if (indexPath.row == 2)
    {
        cell = _nickCell;
    }else
    {
        cell = self.nextCell;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


-(void)registerUserNotification:(BSNotification *)noti
{
    if (noti.error.code == 0) {
        [busiSystem.agent login:self.userInfo[@"tel"] password:self.phoneCell.textTf.text  observer:self callback:@selector(loginNotification:)];
    }
    else
    {
        HUDCRY(noti.error.domain, 1);
    }
}

-(void)loginNotification:(BSNotification *)noti
{
    if (noti.error.code == 0) {
        HUDSMILE(@"注册成功", 2);
        [self performSelector:@selector(finishReg) withObject:nil afterDelay:2];
     
    }
    else
    {
        HUDCRY(noti.error.domain, 1);
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
- (void)textChange:(UITextField *)textField  {

    if (self.codeCell.textTf.text.length > 0 && self.phoneCell.textTf.text.length > 0 && _nickCell.textTf.text.length > 0) {
        [self.nextCell  setBtnBackgroundColor:kUIColorFromRGB(color_3)];
        [self.nextCell  setBtnEnabled:YES];
        
    }
    else
    {
        [self.nextCell  setBtnBackgroundColor:kUIColorFromRGB(color_5)];
        [self.nextCell  setBtnEnabled:NO];
    }
    //    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if(![BSUtility isRightNameStyle:_nickCell.textTf.text withMax:15 withMin:0]&& ![string isEqualToString:@""])
    {
        return NO;
    }
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField;
{
   
    return YES;
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
