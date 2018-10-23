//
//  SecondCallViewController.m
//  rentingshop
//
//  Created by air on 2018/3/27.
//  Copyright © 2018年 ORANLLC_IOS1. All rights reserved.
//

#import "SecondCallViewController.h"
#import "ImgAndThreeTitleTableViewCell.h"
#import "OnlyTitleTableViewCell.h"
#import "OnlyBottomBtnTableViewCell.h"
#import "TitleDetailTableViewCell.h"
#import "PayOrderViewController.h"
@interface SecondCallViewController ()
{
     OnlyTitleTableViewCell *_goodsTipCell;
     OnlyTitleTableViewCell *_zulingTipCell;
     TitleDetailTableViewCell *_aInfoCell;
     TitleDetailTableViewCell *_bInfoCell;
     OnlyTitleTableViewCell *_tipCell;
     OnlyTitleTableViewCell *_tipContentCell;
}
@property (weak, nonatomic) IBOutlet MyTableView *tableView;
@property (weak, nonatomic) OnlyBottomBtnTableViewCell *submitCell;
@property (weak, nonatomic)BUMainPath *mp;
@end

@implementation SecondCallViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.title = @"续缴租金";
     [self initTableView];
     [self addBottomMenuView];
     HUDSHOW(@"加载中");
     [self getData];
}
-(void)getData
{
     [busiSystem.myPathManager mainPath:self.orderId withUserid:busiSystem.agent.userId?:@"" observer:self callback:@selector(mainPathNotification:)];
}

-(void)mainPathNotification:(BSNotification*)noti
{
     if (noti.error.code == 0) {
          HUDDISMISS;
          self.mp = busiSystem.myPathManager.mainPath;
          [_aInfoCell setCellData:@{@"title":@"租赁期数",@"detail":[NSString stringWithFormat:@"%@月",self.mp.period]}];
          [_aInfoCell fitSecondCallModeB];


          [_bInfoCell setCellData:@{@"title":@"当前租金",@"detail":[NSString stringWithFormat:@"%@元/月",self.mp.leaseMoney]}];
          [_bInfoCell fitSecondCallModeBC];
          [_tableView reloadData];

          [self.submitCell setCellData:@{@"title":@"确认支付",@"detail":[NSString stringWithFormat:@"需付款:¥%@",self.mp.money],@"detail2":[NSString stringWithFormat:@"剩余待支付租金：%@",self.mp.supMoney]}];

          [self.submitCell fitSecondCallMode];
          if (_mode == 0) {
               self.submitCell.getBtn.userInteractionEnabled = NO;
               self.submitCell.getBtn.backgroundColor = kUIColorFromRGB(color_0xb0b0b0);
          }
     }
     else
     {

          HUDCRY(noti.error.domain, 1);
     }
}

- (void)didReceiveMemoryWarning {
     [super didReceiveMemoryWarning];
     // Dispose of any resources that can be recreated.
}

-(void)addBottomMenuView
{

     __weak SecondCallViewController *weakSelf = self;
     self.submitCell = [OnlyBottomBtnTableViewCell createTableViewCell];

     self.submitCell.width = __SCREEN_SIZE.width;
     self.submitCell.y = __SCREEN_SIZE.height - NAVBARHEIGHT - TABHEIGHT - 9;

     [self.submitCell setCellData:@{@"title":@"确认支付",@"detail":@"需付款:¥0",@"detail2":@"剩余待支付租金： 0.00"}];

     [self.submitCell fitSecondCallMode];
     if (_mode == 0) {
          self.submitCell.getBtn.userInteractionEnabled = NO;
          self.submitCell.getBtn.backgroundColor = kUIColorFromRGB(color_0xb0b0b0);
     }
     [self.view addSubview:self.submitCell];

     [self.submitCell setHandleAction:^(id o) {
          [weakSelf submit];
     }];

     
}

-(void)initTableView
{
     _goodsTipCell = [OnlyTitleTableViewCell createTableViewCell];
     [_goodsTipCell setCellData:@{@"title":@"商品信息"}];
     [_goodsTipCell fitSecondCallMode];

     _zulingTipCell = [OnlyTitleTableViewCell createTableViewCell];
  [_zulingTipCell setCellData:@{@"title":@"租赁信息"}];
 [_zulingTipCell fitSecondCallMode];

     _aInfoCell = [TitleDetailTableViewCell createTableViewCell];
     [_aInfoCell setCellData:@{@"title":@"租赁期数",@"detail":@"3月"}];
     [_aInfoCell fitSecondCallModeB];

     _bInfoCell = [TitleDetailTableViewCell createTableViewCell];
       [_bInfoCell setCellData:@{@"title":@"当前租金",@"detail":@"60.00元/月"}];
     [_bInfoCell fitSecondCallModeBC];

     _tipCell = [OnlyTitleTableViewCell createTableViewCell];
     [_tipCell setCellData:@{@"title":@"温馨提示：",@"img":@"icon_warn"}];
 [_tipCell fitSecondCallModeB];
     
     _tipContentCell = [OnlyTitleTableViewCell createTableViewCell];
     [_tipContentCell setCellData:@{@"title":@"从逾期之日起,平台有权根据实际逾期天数，按欠款月份金 额的日千分之三收取违约金"}];
 [_tipContentCell fitSecondCallModeC];
     self.tableView.refreshHeaderView = nil;
     self.tableView.backgroundColor = kUIColorFromRGB(color_f8f8f8);
     [ImgAndThreeTitleTableViewCell registerTableViewCell:_tableView];
     [TitleDetailTableViewCell registerTableViewCell:_tableView withTag:@"aa"];

}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
     return  4;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section;
{

     return  nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{

     return 0.001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
     return 10;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
     return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
     CGFloat height = 44;
     if (indexPath.section == 0) {
          if (indexPath.row == 0) {
               height = 46;
          }
          else
          {
               height = 136;
          }
     }
     else if (indexPath.section == 1)
     {
          if (indexPath.row == 0) {
               height = 46;
          }
          else if(indexPath.row == 1)
          {
               height = 30;
          }
          else
          {
               height = 41;
          }
     }
     else if (indexPath.section == 2)
     {
          height = 70;
     }
     else
     {
          if (indexPath.row == 0) {
               height = 32;
          }
          else
          {
               height = 100;
          }
     }
     return height;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
     NSInteger row = 1;
     switch (section) {
          case 0:
               row = 2;
               break;
          case 1:
               row = 3;
               break;
          case 2:
               row = self.mp.subList.count;
               break;
          case 3:
               row = 2;
               break;
          default:
               break;
     }
     return row;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
     UITableViewCell *cell;
     if (indexPath.section == 0) {
          if (indexPath.row == 0) {
               cell = _goodsTipCell;
               [_goodsTipCell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(46, 0, 0, 0)];
          }
          else
          {
               BUProInfo *p = self.mp.proInfo;
               cell = [ImgAndThreeTitleTableViewCell dequeueReusableCell:tableView];

                 NSDictionary *dic = [p getDic:0 withQishu:[self.mp.period integerValue]];//@{@"title":@"DJI大疆 晓 Mavic Air 便携可折叠 4K无人机",@"source":[NSString stringWithFormat:@""],@"time":[NSString stringWithFormat:@"商品价值：3800.00元"],@"default":@"default",@"markArr":@[@"包邮",@"全新"]};
               [(ImgAndThreeTitleTableViewCell *)cell setCellData:dic];
               [(ImgAndThreeTitleTableViewCell *)cell fitSecondCallMode];
//               [(ImgAndThreeTitleTableViewCell*)cell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(136, 0, 0, 0)];

          }
     }
     else if (indexPath.section == 1)
     {
          if (indexPath.row == 0) {
               cell = _zulingTipCell;
             [_zulingTipCell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(46, 0, 0, 0)];
          }
          else if(indexPath.row == 1)
          {
               cell = _aInfoCell;
          }
          else
          {
           cell = _bInfoCell;
          }
     }
     else if (indexPath.section == 2)
     {
          BUSubList *ll = self.mp.subList[indexPath.row];
          NSDictionary *dic = [ll getDic];//@{@"title":@"¥60.00",@"detail":@"2018-08-08",@"detail2":@"已支付",@"detail3":@""};
          cell = [TitleDetailTableViewCell dequeueReusableCell:_tableView withTag:@"aa"];
          [(TitleDetailTableViewCell *)cell setCellData:dic];
          [(TitleDetailTableViewCell*)cell fitSecondCallMode];
          if(self.mp.subList.count - 1 != indexPath.row)
          {
          [(TitleDetailTableViewCell *)cell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(70, 0, 0, 0)];
          }
          else
          {
               [(TitleDetailTableViewCell *)cell hiddenCustomSeparatorView];
          }
     }
     else
     {
          if (indexPath.row == 0) {
               cell = _tipCell;
          }
          else
          {
               cell = _tipContentCell;
          }
     }
     cell.selectionStyle = UITableViewCellSelectionStyleNone;
     return cell;
}


-(void)submit
{
     BUSubmitOrder *od = [BUSubmitOrder new];
     od.orderId = _orderId;
     od.payMoney = [self.mp.money floatValue];
     PayOrderViewController *vc = [PayOrderViewController new];
     vc.order = od;
     vc.mode = 0;
//     vc.sec = weakSelf.second;
//     vc.min = weakSelf.minute;
     vc.orderType = @"4";
      vc.typeId = _orderId;
     [vc setHandleGoBack:^(id userData) {
          busiSystem.agent.isNeedRefreshTabD = YES;
          [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshOrderListData" object:nil];
     }];
     [self.navigationController pushViewController:vc animated:YES];
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
