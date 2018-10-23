//
//  TimeBackOrderInfoViewController.m
//  rentingshop
//
//  Created by air on 2018/4/10.
//  Copyright © 2018年 ORANLLC_IOS1. All rights reserved.
//

#import "TimeBackOrderInfoViewController.h"
#import "SecondCallViewController.h"
#import "SendBackGoodsViewController.h"
@interface TimeBackOrderInfoViewController ()
{
     TitleDetailTableViewCell *_fukuanTimeCell;
     TitleDetailTableViewCell *_shifuCell;
 TitleDetailTableViewCell *_qizuTimeCell;
}
@end

@implementation TimeBackOrderInfoViewController

-(id)init
{
     self = [super initWithNibName:@"OrderInfoViewController" bundle:nil];
     return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     _fukuanTimeCell = [TitleDetailTableViewCell createTableViewCell];
     [_fukuanTimeCell  setCellData:@{@"title":@"付款时间:",@"detail":@"2017-05-01 16:01"}];
     [_fukuanTimeCell fitOrderInfoModeE];

     _qizuTimeCell = [TitleDetailTableViewCell createTableViewCell];
     [_qizuTimeCell  setCellData:@{@"title":@"起租时间:",@"detail":@"收货后第二天开始计算"}];
     [_qizuTimeCell fitOrderInfoModeE];

     [self.payWayCell  setCellData:@{@"title":@"支付方式:",@"detail":@"在线支付/微信支付"}];
     [self.payWayCell fitOrderInfoModeE];

     _shifuCell = [TitleDetailTableViewCell createTableViewCell];
     [_shifuCell  setCellData:@{@"title":@"实付金额:",@"detail":@"¥180.00"}];
     [_shifuCell fitOrderInfoModeE];


}
-(void) getOrderDetailNotification:(BSNotification *) noti
{
     if (noti.error.code == 0) {
          HUDDISMISS;
          self.orderDetail = busiSystem.getOrderListManager.orderDetail;
          NSString *st = @"到期退还";
          NSString *ss = @"已到期";
          if (self.orderDetail.state == 5) {
               st = @"退还审核中";
               ss = @"";
          }
          else if(self.orderDetail.isChao > 0)
          {
               ss = [NSString stringWithFormat:@"已到期:%ld天",self.orderDetail.isChao];
          }
          [self.stateCell setCellData:@{@"title":st,@"detail":ss,@"img":@"timeOut"}];
          [self.stateCell fitOrderInfoModeA];

          [self.stateInfoCell setCellData:@{@"title":[NSString stringWithFormat:@"感谢您在平台购物，欢迎光临"],@"detail":@""}];
          [self.stateInfoCell fitOrderInfoModeH];


          //          NSString *tell = @"";
          //          if (_orderDetail.receiveTel.length>=11) {
          //               tell = [_orderDetail.receiveTel stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
          //          }
          //                    NSString *title = [NSString stringWithFormat:@"%@ %@",self.orderDetail.receiveUser?:@"",tell];
          [self.addressCell setCellData:@{@"title":[NSString stringWithFormat:@"%@ %@",self.orderDetail.receiveUser,self.orderDetail.receiveTel],@"detail":self.orderDetail.receiveAddress?:@""}];
          [self.addressCell fitOrderInfoModeC];
          NSString *qishu = @"天";
          NSString *qi = @"元/天";
          if (self.orderDetail.leaseType == 0) {
               qi = @"元/月";
               qishu = @"月";
          }
          [self.goodsTotalCell  setCellData:@{@"title":@"订单租期",@"detail":[NSString stringWithFormat:@"%ld%@",self.orderDetail.leaseinfo.period,qishu]}];
          [self.goodsTotalCell fitOrderInfoModeD];

          [self.carriageCell  setCellData:@{@"title":@"单期租金",@"detail":[NSString stringWithFormat:@"%@%@",self.orderDetail.leaseinfo.leaseMoney,qi]}];
          [self.carriageCell fitOrderInfoModeE:qi];

          [self.couponCell  setCellData:@{@"title":@"配送方式",@"detail":@"单程包邮"}];
          [self.couponCell fitOrderInfoModeEB];

          [self.youbiDiscountCell  setCellData:@{@"title":@"优惠券",@"detail":[NSString stringWithFormat:@"%@元",self.orderDetail.leaseinfo.couponMoney]}];
          [self.youbiDiscountCell fitOrderInfoModeE:@"元"];

          [self.actDiscountCell  setCellData:@{@"title":@"意外保险",@"detail":[NSString stringWithFormat:@"%@",self.orderDetail.leaseinfo.productInsuranceMoney]}];
          [self.actDiscountCell fitOrderInfoModeER];

          [self.billTypeCell  setCellData:@{@"title":@"押金",@"detail":[NSString stringWithFormat:@"￥%@",self.orderDetail.leaseinfo.productCostMoney]}];
          [self.billTypeCell fitOrderInfoModeER];
          [self.billriseCell  setCellData:@{@"title":@"免押金额",@"detail":[NSString stringWithFormat:@"￥%@",self.orderDetail.leaseinfo.creditMoney]}];
          [self.billriseCell fitOrderInfoModeF];
          [self.billContentCell  setCellData:@{@"title":@"实付款 ",@"detail":[NSString stringWithFormat:@"￥%@",self.orderDetail.leaseinfo.payMoney],@"detail2":[NSString stringWithFormat:@"可退押金：￥%@",self.orderDetail.leaseinfo.depositMoney]}];
          [self.billContentCell fitOrderInfoModeFF];

          [self.orderNoCell  setCellData:@{@"title":@"订单编号:",@"detail":self.orderDetail.othInfo.orderNO?:@""}];
          [self.orderNoCell fitOrderInfoModeDD];
          [self.submitTimeCell  setCellData:@{@"title":@"提交时间:",@"detail":self.orderDetail.othInfo.createTime?:@""}];
          [self.submitTimeCell fitOrderInfoModeE];




          [_qizuTimeCell  setCellData:@{@"title":@"起租时间:",@"detail":[NSString stringWithFormat:@"%@",self.orderDetail.othInfo.leaseBeginTime]}];
          [_qizuTimeCell fitOrderInfoModeE];

          [self.payMoneyCell  setCellData:@{@"title":@"到期时间:",@"detail":[NSString stringWithFormat:@"%@",self.orderDetail.othInfo.leaseEndTime]}];
          [self.payMoneyCell fitOrderInfoModeE];

          NSString *py = @"未支付";
          if (self.orderDetail.othInfo.payType == 1) {
               py = @"支付宝支付";
          }
          else if (self.orderDetail.othInfo.payType == 2)
          {
               py = @"微信支付";
          }
          [self.payWayCell  setCellData:@{@"title":@"支付方式:",@"detail":py?:@""}];
          [self.payWayCell fitOrderInfoModeE];


        [_shifuCell  setCellData:@{@"title":@"实付金额:",@"detail":[NSString stringWithFormat:@"¥%@",self.orderDetail.othInfo.payMoney]}];
          [_shifuCell fitOrderInfoModeE];

             [_fukuanTimeCell  setCellData:@{@"title":@"付款时间:",@"detail":[NSString stringWithFormat:@"%@",self.orderDetail.othInfo.payTime]}];
          [_fukuanTimeCell fitOrderInfoModeE];

          [self.payTimeCell setCellData:@{@"title":@"备注:",@"detail":self.orderDetail.othInfo.note?:@"无"}];
          [self.payTimeCell fitOrderInfoModeFC];

          [self.tableView reloadData];
     }else{
          HUDCRY(noti.error.domain, 2);
     }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)addBottomMenuView
{

     __weak TimeBackOrderInfoViewController *weakSelf = self;
     self.submitCell.width = __SCREEN_SIZE.width;
     self.submitCell.y = __SCREEN_SIZE.height - NAVBARHEIGHT - TABHEIGHT;
//     self.order.leaseCount = 1;
//     self.order.state = 6;
     if(self.order.leaseCount > 0)
     {
       [self.submitCell setCellData:@{@"title":@"退还商品",@"bTitle":@"续缴租金",@"bTitleX":@YES}];
} else
{
      [self.submitCell setCellData:@{@"detail":@"",@"title":@"退还商品",@"titleX":@YES}];
}
     if ( self.order.state == 5) {
          [self.submitCell setCellData:@{@"detail":@""}];
          self.tableView.height = __SCREEN_SIZE.height - NAVBARHEIGHT;
          self.submitCell.hidden = YES;
     }
     [self.submitCell fitMyOrderInfoModeB];
//     if (_lookMode == 1) {
//          self.tableView.height = __SCREEN_SIZE.height - NAVBARHEIGHT;
//     }else
//     {
          [self.view addSubview:self.submitCell];
//     }
 if(self.order.leaseCount > 0)
 {
     [self.submitCell setHandleAction:^(id o) {
        [[CommonAPI managerWithVC:weakSelf] showAlertView:@"提示" withMsg:@"请缴纳剩余租金后退还商品?" withBtnTitle:@"确定"   withSel:@selector(toXuZuProcessResult:) withUserInfo:@{}];
//          SendBackGoodsViewController *vc = [SendBackGoodsViewController new];
//          vc.orderDetail = weakSelf.orderDetail;
//          [weakSelf.navigationController pushViewController:vc animated:YES];
     }];
     [self.submitCell setExtrHandleAction:^(id o){
          SecondCallViewController *vc = [SecondCallViewController new];
          vc.mode = 1;
          vc.orderId = weakSelf.orderDetail.orderID;
          [weakSelf.navigationController pushViewController:vc animated:YES];

     }];
         }
     else
     {
          [self.submitCell setHandleAction:^(id o) {

               SendBackGoodsViewController *vc = [SendBackGoodsViewController new];
               vc.orderDetail = weakSelf.orderDetail;
               [weakSelf.navigationController pushViewController:vc animated:YES];
          }];
     }
     //    else
     //    {
     //        [_submitCell setCellData:@{@"title":@"删除订单"}];
     //        [self.view addSubview:_submitCell];
     //        [_submitCell setHandleAction:^(id o) {
     ////            [weakSelf deleteOption];
     //        }];
     //    }
}
-(void)toXuZuProcessResult:(NSDictionary *)dic{
//     __weak TimeBackOrderInfoViewController *weakSelf = self;
     if ([dic[@"code"] integerValue] == 0) {

     }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
     return  4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
     if (section == 4) {
          return 50;
     }
     return 10;
}
-(UIView *)createSectionFootView
{
     UIView *v = [UIView new];
     v.height = 10;
     UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 9.5, __SCREEN_SIZE.width, 0.5)];
     line.backgroundColor = kUIColorFromRGB(color_lineColor);
     v.backgroundColor = kUIColorFromRGB(color_0xf0f0f0);
     line.tag = 9887;
     [v addSubview:line];
     return v;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
     if (section == 3) {
          return nil;
     }
     return [self createSectionFootView];;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
     CGFloat height = 44;
     if (indexPath.section == 0) {
          if (indexPath.row == 0) {
               height = 41;
          }
          else
          {
               height = 80;
          }
     }

     else if (indexPath.section == 1)
     {
          if (indexPath.row == 0) {
               height = 31;
          }
          else
          {
               height = 136;
          }

     }
     else if (indexPath.section == 2)
     {
          if (indexPath.row == 0) {
               height = 41;
          }
          else
               if (indexPath.row == 1) {
                    height = 26;
               }
               else
                    if (indexPath.row == 8) {
                         height = 56;
                    }
                    else
                         if (indexPath.row == 7) {
                              height = 35;
                         }
                         else
                         {
                              height = 20;
                         }

     }
     //     else if (indexPath.section == 3)
     //     {
     //          if (indexPath.row == 0) {
     //               height = 26;
     //          }
     //          else
     //               if (indexPath.row == 2) {
     //                    height = 35;
     //               }
     //               else
     //               {
     //                    height = 20;
     //               }
     //
     //     }
     else
     {
          if (indexPath.row == 0) {
               height = 26;
          }
          else
               if (indexPath.row == 7) {
                    height = 35;
               }
               else
               {
                    height = 20;
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
               row = 2;
               break;
          case 2:
               row = 9;
               break;

          case 3:
               row = 8;
               break;
               //          case 4:
               //               row = 3;
               //               break;

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
               cell = self.stateCell;
               [self.stateCell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(41, 0, 0, 0)];
          }
          else
          {
               //               cell = self.stateInfoCell;
               //               [self.stateInfoCell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(65, 0, 0, 0)];
               cell = self.addressCell;
//               [self.addressCell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(80, 0, 0, 0)];
          }
     }

     else if (indexPath.section == 1)
     {
          if (indexPath.row == 0) {
               cell = self.goodsTipCell;
               [self.goodsTipCell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(31, 0, 0, 0)];
          }
          else
          {
               BUProInfo *p =  self.orderDetail.proInfo;
               cell = [ImgAndThreeTitleTableViewCell dequeueReusableCell:self.tableView];
                 NSDictionary *dic = [p getDic:self.orderDetail.leaseType withQishu:self.orderDetail.leaseinfo.period];//@{@"title":@"DJI大疆 晓 Mavic Air 便携可折叠 4K无人机",@"source":[NSString stringWithFormat:@""],@"time":[NSString stringWithFormat:@"商品价值：3800.00元"],@"default":@"default",@"markArr":@[@"包邮",@"全新"]};
               [(ImgAndThreeTitleTableViewCell *)cell setCellData:dic];
               [(ImgAndThreeTitleTableViewCell *)cell fitOrderInfoMode];
//               [(ImgAndThreeTitleTableViewCell*)cell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(136, 0, 0, 0)];
          }

     }
     else if (indexPath.section == 2)
     {
          if (indexPath.row == 0) {
               cell = self.orderTipCell;
               [self.orderTipCell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(41, 0, 0, 0)];
          }

          else
               if (indexPath.row == 4) {
                    cell = self.youbiDiscountCell;

               }
               else if(indexPath.row == 1)
               {
                    cell = self.goodsTotalCell;

               }
               else if(indexPath.row == 2)
               {
                    cell = self.carriageCell;
               }
               else  if(indexPath.row == 3)
               {
                    cell = self.couponCell;
               }

               else  if(indexPath.row == 5)
               {
                    cell = self.actDiscountCell;
               }
               else  if(indexPath.row == 6)
               {
                    cell = self.billTypeCell;
               }
               else  if(indexPath.row == 7)
               {
                    cell = self.billriseCell;
                    [self.billriseCell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(35, 0, 0, 0)];
               }

               else
               {
                    cell = self.billContentCell;
//                    [self.billContentCell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(56, 0, 0, 0)];
               }


     }
     //     else if (indexPath.section == 3)
     //     {
     //          if (indexPath.row == 0) {
     //               cell = self.billTypeCell;
     //          }
     //
     //          else
     //               if (indexPath.row == 2) {
     //                    cell = self.billContentCell;
     //                    [self.billContentCell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(35, 0, 0, 0)];
     //               }
     //               else
     //               {
     //                    cell = self.billriseCell;
     //               }
     //
     //     }
     else
     {
          if (indexPath.row == 0) {
               cell = self.orderNoCell;
          }

          else
               if (indexPath.row == 3) {
                    cell = self.payMoneyCell;

               }
               else
                    if (indexPath.row == 1) {
                         cell = self.submitTimeCell;
                    }

                    else   if (indexPath.row == 2) {
                         cell = _qizuTimeCell;

                    }
                    else  if (indexPath.row == 7){
                         cell = self.payTimeCell;
//                         [self.payTimeCell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(35, 0, 0, 0)];
                    }
                    else   if (indexPath.row == 4) {
                         cell = self.payWayCell;

                    }
                    else   if (indexPath.row == 6) {
                         cell = _fukuanTimeCell;

                    }

                    else
                    {
                         cell = _shifuCell;
                    }

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
