//
//  WatiRecOrderInfoViewController.m
//  oranllcshoping
//
//  Created by air on 2017/7/26.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import "WatiRecOrderInfoViewController.h"
//#import "GoodsInfoViewController.h"
//#import "OrderTrackingViewController.h"
@interface WatiRecOrderInfoViewController ()
{
     TitleDetailTableViewCell *_fukuanTimeCell;
}
@end

@implementation WatiRecOrderInfoViewController
-(id)init
{
     self = [super initWithNibName:@"OrderInfoViewController" bundle:nil];
     return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     [self.payWayCell  setCellData:@{@"title":@"支付方式:",@"detail":@"微信支付"}];
     [self.payWayCell fitOrderInfoModeE];

     [self.payMoneyCell  setCellData:@{@"title":@"实付金额:",@"detail":@"¥1000.00"}];
     [self.payMoneyCell fitOrderInfoModeE];

     _fukuanTimeCell = [TitleDetailTableViewCell createTableViewCell];
     [_fukuanTimeCell  setCellData:@{@"title":@"付款时间:",@"detail":@"2017-05-01 16:01"}];
     [_fukuanTimeCell fitOrderInfoModeE];
     
}
-(void)addBottomMenuView
{
     

     
     __weak OrderInfoViewController *weakSelf = self;
     self.submitCell.width = __SCREEN_SIZE.width;
     self.submitCell.y = __SCREEN_SIZE.height - NAVBARHEIGHT - TABHEIGHT;
     NSString *str = @"确认收货";
     if ( 1) {
          str = @"";
     }
     [self.submitCell setCellData:@{@"title":str}];
     [self.submitCell fitMyOrderInfoMode];
     
     if (1) {
          self.tableView.height = __SCREEN_SIZE.height - NAVBARHEIGHT;
     }else
     {
          [self.view addSubview:self.submitCell];
     }

     [self.submitCell setHandleAction:^(id o) {
//          NSString *str = @"确认收货";

//          BUGetOrder *od = [BUGetOrder new];
//          od.orderId = self.orderDetail.orderId;
          [[CommonAPI managerWithVC:weakSelf] showAlertView:@"确认收货" withMsg:[NSString stringWithFormat:@"确认收货后开始计算租赁时间？"] withBtnTitle:@"确认"   withSel:@selector(toProcessResult:) withUserInfo:@{}];
     }];

//     [self.submitCell setExtrHandleAction:^(id o) {
//        OrderTrackingViewController *vc = [OrderTrackingViewController new];
//        [weakSelf.navigationController pushViewController:vc animated:YES];
//     }];
}

-(void) getOrderDetailNotification:(BSNotification *) noti
{
     if (noti.error.code == 0) {
//          HUDDISMISS;
//          self.orderDetail = busiSystem.getOrderListManager.orderDetail;
//          NSString *sstr = @"普通快递";
//          if ([self.orderDetail.expressType  isEqualToString:@"2"]) {
//               sstr = @"自提";
//                  [self.stateCell setCellData:@{@"title":@"等待自提",@"detail":@"",@"img":@"waitSend"}];
//          }
//          else if ([self.orderDetail.expressType isEqualToString:@"3"])
//          {
//          sstr = @"跑腿";
//                  [self.stateCell setCellData:@{@"title":@"等待配送",@"detail":@"",@"img":@"waitSend"}];
//          }
//          else
//          {
                  [self.stateCell setCellData:@{@"title":@"等待配送",@"detail":@"普通快递",@"img":@"waitSend"}];
//          }
          [self.stateCell fitOrderInfoModeA];

//          [self.stateInfoCell setCellData:@{@"title":[NSString stringWithFormat:@"您的订单已经进入库房，准备出库"],@"detail":self.orderDetail.receiveAddress?:@""}];
//          [self.stateInfoCell fitOrderInfoModeB];


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

          [self.payMoneyCell  setCellData:@{@"title":@"实付金额:",@"detail":[NSString stringWithFormat:@"¥%@",self.orderDetail.othInfo.payMoney]}];
          //         [_payMoneyCell  setCellData:@{@"title":@"实付金额:",@"detail":price}];
          [self.payMoneyCell fitOrderInfoModeE];

          [_fukuanTimeCell  setCellData:@{@"title":@"付款时间:",@"detail":[NSString stringWithFormat:@"%@",self.orderDetail.othInfo.payTime]}];
          [_fukuanTimeCell fitOrderInfoModeE];
          [self.payTimeCell setCellData:@{@"title":@"备注:",@"detail":self.orderDetail.othInfo.note?:@"无"}];
          [self.payTimeCell fitOrderInfoModeFC];
          NSString *str = @"确认收货";
          
          [self.submitCell setCellData:@{@"title":str}];
          [self.submitCell fitMyOrderInfoMode];
          [self.tableView reloadData];
     }else{
//          HUDCRY(noti.error.domain, 2);
     }

}



-(void)toProcessResult:(NSDictionary *)dic{
     if ([dic[@"code"] integerValue] == 0) {
          self.submitCell.hidden = YES;
           self.tableView.height = __SCREEN_SIZE.height - 64;
//          BUGetOrder *od = [BUGetOrder new];
//          od.orderID = self.orderDetail.orderID;
//          [[NSNotificationCenter defaultCenter] postNotificationName:@"confirmOrderData" object:nil userInfo:@{@"order":od}];
     }
}
-(void)operOrder:(NSString *)type orderId:(NSString *)orderId{
//     HUDSHOW(@"加载中");
     [busiSystem.orderManager operOrder:busiSystem.agent.userId orderId:orderId type:type observer:self callback:@selector(operOrderNotification:)];
}

-(void)operOrderNotification:(BSNotification *)noti{
//     HUDDISMISS;
     if (noti.error.code == 0) {
          //          [self getData];
          //          [_tableView reloadData];
//          HUDSMILE(@"已确认收货", 2);
          [self performSelector:@selector(goback) withObject:nil afterDelay:2];
     }else{
//          HUDCRY(noti.error.domain, 2);
     }
     
}

-(void)goback{
     if (self.handleGoBack) {
          self.handleGoBack(@{});
     }
     [self.navigationController popViewControllerAnimated:YES];
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
               height = 40;
          }
          else
          {
               height = 80;
          }
     }
     
//     else if (indexPath.section == 1)
//     {
//          height = 80;
//
//     }

     else if (indexPath.section == 1)
     {
          height = 80;
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
                    else if (indexPath.row == 7) {
                         height = 35;
                    }
                    else
                    {
                         height = 20;
                    }

     }
     else //if (indexPath.section == 4)
     {
          if (indexPath.row == 0) {
               height = 26;
          }
          else
               if (indexPath.row == 5) {
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
//          case 1:
//               row = 1 ;
               break;
          case 1:
               row = 2;//self.orderDetail.goodsList.count;
               break;
          case 2:
               row = 9;
               break;
               
          case 3:
               row = 6;
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
               cell = self.stateCell;
               [self.stateCell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(cell.height, 0, 0, 0)];
          }
          else
          {
               cell = self.addressCell;
//                         [self.addressCell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(80, 0, 0, 0)];
//               cell = self.stateInfoCell;
//               [self.stateInfoCell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(65, 0, 0, 0)];
          }
     }
     
     
//     else if (indexPath.section == 1)
//     {
//
//          cell = self.addressCell;
//          [self.addressCell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(80, 0, 0, 0)];
//
//
//     }

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
                         cell = self.payWayCell;

                    }
                    else  if (indexPath.row == 5){
                         cell = self.payTimeCell;
//                         [self.payTimeCell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(35, 0, 0, 0)];
                    }
          else
          {
 cell = _fukuanTimeCell;
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
     else if(indexPath.section == 0 && indexPath.row == 1){
//          OrderTrackingViewController *vc = [OrderTrackingViewController new];
//          vc.order = self.order;
//          [self.navigationController pushViewController:vc animated:YES];
     }
}


@end
