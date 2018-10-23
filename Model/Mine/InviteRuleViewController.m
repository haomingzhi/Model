//
//  InviteRuleViewController.m
//  oranllcshoping
//
//  Created by air on 2017/8/7.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import "InviteRuleViewController.h"

@interface InviteRuleViewController ()

@end

@implementation InviteRuleViewController
-(id)init
{
     self = [super initWithNibName:@"QuestionViewController" bundle:nil];
     return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     self.title = @"邀请好友规则介绍";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)initTableView
{
     self.tableView.refreshHeaderView = nil;
     self.contentCell = [OnlyTitleTableViewCell createTableViewCell];
     [self.contentCell setCellData:@{@"title":@"• 参与者资格：所有优品汇注册用户均可参与。活动期间每位用户分享邀请码均可获得总值120元的优惠券(有效期7天)，每日分享次数不设上限。\n• 新用户领取优惠券并完成注册后，视作邀请新用户成功，新用户会获得总值为180元的优惠券，有效期为系统显示为准，同时邀请人获得60元优惠券；邀请的新用户完成首单后，邀请人可再获得60元优惠券(有效期7天)。\n• 每成功邀请一位好友还可获得10成长值和5优币的奖励，如果好友首次下单并完成付款还可获得奖励20成长值和10优币的奖励。\n • 为了杜绝刷单等妨碍正常用户的恶意行为，系统会在下单后进行核查，同一手机号、支付宝、优品汇帐号、设备号、订单收件人均视为同一用户。对于恶意刷单的用户，取消购买资格。\n• 有任何疑问请在app内，咨询优品汇在线客服。\n• 优品汇保留法律范围内的最终解释权，如有其它疑问请咨询官方客服。"}];
     [self.contentCell fitEvaRuleMode];
     self.tableView.backgroundColor = kUIColorFromRGB(color_2);
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
     CGFloat height = self.contentCell.height;
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
