//
//  WaitPayOrderInfoViewController.m
//  oranllcshoping
//
//  Created by air on 2017/7/26.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import "WaitPayOrderInfoViewController.h"
//#import "PayOrderViewController.h"
//#import "GoodsInfoViewController.h"
#import "CancelOrderViewController.h"

@interface WaitPayOrderInfoViewController ()
{
     NSTimer  *_timer;
     NSInteger _hour;

}

@end

@implementation WaitPayOrderInfoViewController
-(id)init
{
     self = [super initWithNibName:@"OrderInfoViewController" bundle:nil];
     return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void) getOrderDetailNotification:(BSNotification *) noti
{
     if (noti.error.code == 0) {
//          HUDDISMISS;
//          self.orderDetail = busiSystem.getOrderListManager.orderDetail;
           if ( 2) {
                      [self.stateCell setCellData:@{@"title":@"等待发货",@"detail":@"",@"img":@"waitSend"}];
                [self.stateCell fitOrderInfoModeA];
           }else
           {
                _hour = 0;
//                NSInteger lmt = 30;//busiSystem.agent.config.payLimit;

               NSInteger tt = -[BSUtility numberOfSecsFromTodayByTime:self.orderDetail.payEndTime timeStringFormat:@"yyyy-MM-dd HH:mm:ss"];
                if(tt > 0)
                {
                _minute = tt/60 - 1;
                _second = 60 - tt%60;
                      _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeChange) userInfo:nil repeats:YES];
                }else
                {
                     _minute = 0;
                     _second = 0;
                }

          [self.stateCell setCellData:@{@"title":@"等待付款",@"detail":[NSString stringWithFormat:@"剩余:%02d:%02d",_minute,_second],@"img":@"icon_order_waitPay"}];
                 [self.stateCell fitOrderInfoModeAA];
           }


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
//          [self.payWayCell  setCellData:@{@"title":@"起租时间:",@"detail":@"收货后第二天开始计算"}];
//          [self.payWayCell fitOrderInfoModeE];
//          [self.payMoneyCell  setCellData:@{@"title":@"到期时间:",@"detail":@"按租期时间计算"}];
//          [self.payMoneyCell fitOrderInfoModeE];
          [self.payTimeCell setCellData:@{@"title":@"备注:",@"detail":self.orderDetail.othInfo.note?:@"无"}];
          [self.payTimeCell fitOrderInfoModeFC];
//          NSString *state = @"";// self.orderDetail.payTypeName?:@"";
//          if (self.orderDetail.othInfo.payType == 1) {
//               state = @"支付宝支付";
//          }else{
//               state = @"微信支付";
//          }
//          [self.payWayCell  setCellData:@{@"title":@"支付方式:",@"detail":state}];
//          [self.payWayCell fitOrderInfoModeE];
          //           price = [NSString stringWithFormat:@"¥%.2f",_orderDetail.payPrice];
          //          [_payMoneyCell  setCellData:@{@"title":@"实付金额:",@"detail":price}];
//          [self.payMoneyCell fitOrderInfoModeE];
          [self.submitCell setCellData:@{@"title":@"立即付款",@"bTitle":@"取消订单",@"detail":[NSString stringWithFormat:@"应付金额:￥%@",self.orderDetail.othInfo.payMoney]}];
          if ( self.orderDetail.state == 2) {
               [self.submitCell setCellData:@{@"detail":@""}];
               self.tableView.height = __SCREEN_SIZE.height - NAVBARHEIGHT;
               self.submitCell.hidden = YES;
          }
          else
          {
                self.submitCell.hidden = NO;
               self.tableView.height = __SCREEN_SIZE.height - NAVBARHEIGHT - TABHEIGHT - 1;

          }
          [self.submitCell fitMyOrderInfoModeB];
          [self.tableView reloadData];
     }else{
//          HUDCRY(noti.error.domain, 2);
     }

}
-(void)timeChange{
     _second --;
     if (_second < 0) {
          _second = 59;
          _minute --;
          if (_minute <0) {
//               _minute = 59;
//               _hour --;
//               if (_hour <0) {
                    [_timer invalidate];
//                    _hour = 0;
                    _minute = 0;
                    _second = 0;
//               }
          }
     }
     [self.stateCell setCellData:@{@"title":@"等待付款",@"detail":[NSString stringWithFormat:@"剩余:%02d:%02d",_minute,_second],@"img":@"icon_order_waitPay"}];
      [self.stateCell fitOrderInfoModeAA];

      
}
-(void)addBottomMenuView
{
     
     __weak WaitPayOrderInfoViewController *weakSelf = self;
     self.submitCell.width = __SCREEN_SIZE.width;
     self.submitCell.y = __SCREEN_SIZE.height - NAVBARHEIGHT - TABHEIGHT;
     [self.submitCell setCellData:@{@"title":@"立即付款",@"bTitle":@"取消订单",@"detail":@"应付金额:￥"}];
     if ( self.orderDetail.state == 2) {
 [self.submitCell setCellData:@{@"detail":@""}];
           self.tableView.height = __SCREEN_SIZE.height - NAVBARHEIGHT;
          self.submitCell.hidden = YES;
     }
     [self.submitCell fitMyOrderInfoModeB];
//     if (_lookMode == 1) {
// self.tableView.height = __SCREEN_SIZE.height - NAVBARHEIGHT;
//     }else
//     {
     [self.view addSubview:self.submitCell];
//     }
     //    if (_mode == 0) {
     //        [_submitCell removeFromSuperview];
     //    }
     //    else if (_mode == 1)
     //    {
     //        [_submitCell setCellData:@{@"title":@"确认完成"}];
     //        [self.view addSubview:_submitCell];
     //
             [self.submitCell setHandleAction:^(id o) {
//                  BUSubmitOrder *od = [BUSubmitOrder new];
//                  od.orderId = weakSelf.orderDetail.orderID;
//                  od.payMoney = [weakSelf.orderDetail.othInfo.payMoney floatValue];
//                  PayOrderViewController *vc = [PayOrderViewController new];
//                  vc.order = od;
//                  vc.mode = 1;
//                  vc.sec = weakSelf.second;
//                  vc.min = weakSelf.minute;
//                  vc.orderType = @"1";
//                  vc.typeId = od.orderId;
//                  [vc setHandleGoBack:^(id userData) {
//                        busiSystem.agent.isNeedRefreshTabD = YES;
//                  }];
//                  [weakSelf.navigationController pushViewController:vc animated:YES];
             }];
     [self.submitCell setExtrHandleAction:^(id o){
           [[CommonAPI managerWithVC:weakSelf] showAlertView:@"取消订单" withMsg:@"是否确认取消订单?" withBtnTitle:@"确认"   withSel:@selector(toCancelProcessResult:) withUserInfo:@{}];

     }];
     //    }
     //    else
     //    {
     //        [_submitCell setCellData:@{@"title":@"删除订单"}];
     //        [self.view addSubview:_submitCell];
     //        [_submitCell setHandleAction:^(id o) {
     ////            [weakSelf deleteOption];
     //        }];
     //    }
}
-(void)toCancelProcessResult:(NSDictionary *)dic{
         __weak WaitPayOrderInfoViewController *weakSelf = self;
     if ([dic[@"code"] integerValue] == 0) {
//          BUGetOrder *od = [BUGetOrder new];
//          od.orderID = self.orderDetail.orderID;
          [self.stateCell setCellData:@{@"title":@"交易关闭",@"detail":@"",@"img":@"icon_order_cancel"}];
          [self.submitCell setCellData:@{@"title":@"删除订单",@"detail":@""}];
//          [[NSNotificationCenter defaultCenter] postNotificationName:@"cancelOrderData" object:nil userInfo:@{@"order":od?:@""}];
          [self.navigationController popViewControllerAnimated:YES];
            busiSystem.agent.isNeedRefreshTabD = YES;
          [self.submitCell setHandleAction:^(id o){
               //          CartViewController *vc = [CartViewController new];
               //          [weakSelf.navigationController pushViewController:vc animated:YES];
               [[CommonAPI managerWithVC:weakSelf] showAlert:@selector(toDeleteOrder:) withTitle:@"删除订单" withMessage:@"是否删除该订单？" withObj:@{}];
          }];
          //          [self operOrder:@"2" orderId:self.order.orderID];
     }
}
-(void)toDeleteOrder:(NSDictionary *)dic{
     if ([dic[@"code"] integerValue] == 0) {
//          BUGetOrder *od = [BUGetOrder new];
//          od.orderID = self.orderDetail.orderID;
//          [[NSNotificationCenter defaultCenter] postNotificationName:@"delOrderData" object:nil userInfo:@{@"order":od}];
//          [self.navigationController popViewControllerAnimated:YES];
          busiSystem.agent.isNeedRefreshTabD = YES;
          //          [self operOrder:@"2" orderId:self.order.orderID];
     }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
               if (indexPath.row == 2) {
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
               row = 2;//self.orderDetail.goodsList.count + 1;
               break;
          case 2:
               row = 9;
               break;
               
          case 3:
               row = 3;
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

               cell = self.addressCell;
//                         [self.addressCell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(80, 0, 0, 0)];
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
//                     [self.billContentCell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(56, 0, 0, 0)];
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
          
//          else
//               if (indexPath.row == 3) {
//                    cell = self.payMoneyCell;
//
//               }
               else
                    if (indexPath.row == 1) {
                         cell = self.submitTimeCell;
                    }
          
//                    else   if (indexPath.row == 2) {
//                         cell = self.payWayCell;
//
//                    }
                    else{
                         cell = self.payTimeCell;
//                           [self.payTimeCell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(35, 0, 0, 0)];
                    }
     }
     cell.selectionStyle = UITableViewCellSelectionStyleNone;
     return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     if(indexPath.section == 1)
     {
          if (indexPath.row == 1) {
               [self toGoodsInfoVC:self.orderDetail.proInfo.productId];

          }
    
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
