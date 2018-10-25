//
//  BindPhoneViewController.m
//  intelligentgarbagecollection
//
//  Created by air on 2017/12/20.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import "BindPhoneViewController.h"
#import "JYCommonTool.h"
#import "BUSystem.h"
@interface BindPhoneViewController ()

@end

@implementation BindPhoneViewController
-(id)init
{
     self = [super initWithNibName:@"RegisterViewController" bundle:nil];
     return self;
}
-(void)initThirdLogin
{

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     self.title = @"绑定手机";
     [self fitMode];
}
-(void)fitMode
{
     [self.toLoginBtnCell getBtn].hidden = YES;
     [self.nextCell setCellData:@{@"title":@"绑定"}];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)submit
{
     [self.view endEditing:YES];
     if (![JYCommonTool isMobileNum:self.phoneCell.textTf.text]) {
//          HUDCRY(@"手机号格式有误", 2);
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

//     HUDSHOW(@"提交中");
//     [busiSystem.agent userBindMobile:self.pwdCell.textTf.text withSmscode:self.codeCell.textTf.text withMobile:self.phoneCell.textTf.text withUserid:busiSystem.agent.userId withType:@"" observer:self callback:@selector(userBindMobileNotification:)];
     //    RegisterNextViewController *vc = [RegisterNextViewController new];
     //    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:self.userInfo];
     //    dic[@"pwd"] = self.phoneCell.textTf.text;
     //    vc.userInfo = dic;
     //    [self.navigationController pushViewController:vc animated:YES];
}

-(void)userBindMobileNotification:(BSNotification*)noti
{
     if (noti.error.code == 0) {
//          HUDSMILE(@"绑定成功", 1);
          [self performSelector:@selector( goNext) withObject:nil afterDelay:1];
     }
     else
     {

//          HUDCRY(noti.error.domain, 1);
     }
}

-(void)goNext
{
//     HUDSHOW(@"加载中");
     [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshPersonData" object:nil];
      [self.navigationController popViewControllerAnimated:YES];

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
