//
//  OrderInfoViewController.m
//  oranllcshoping
//
//  Created by air on 2017/7/25.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import "OrderInfoViewController.h"
#import "BUSystem.h"

@interface OrderInfoViewController ()
{
   
}



@end

@implementation OrderInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
     self.title = @"订单详情";
     [self initTableView];
     [self addBottomMenuView];
//     HUDSHOW(@"加载中");
     [self getData];
}


-(void)getData{
//     [busiSystem.getOrderListManager getOrderDetail:_order.orderID?:@"" observer:self callback:@selector(getOrderDetailNotification:)];
}


-(void) getOrderDetailNotification:(BSNotification *) noti
{
     if (noti.error.code == 0) {
//          HUDDISMISS;
          _orderDetail = busiSystem.orderManager.orderDetail;

          if (4) {
               [self.stateInfoCell setCellData:@{@"title":@"感谢您在平台购物，欢迎光临",@"detail":@""}];
               [self.stateInfoCell fitOrderInfoModeG];
          }else{
//               [_stateInfoCell setCellData:@{@"title":_orderDetail.trackTitle?:@"",@"detail":_orderDetail.trackTime?:@""}];
               [_stateInfoCell fitOrderInfoModeB];
          }

          NSString *tell = @"";
//          if (_orderDetail.receiveTel.length>=11) {
//               tell = [_orderDetail.receiveTel stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
//          }
//          NSString *title = [NSString stringWithFormat:@"%@ %@",_orderDetail.receiveUser?:@"",tell];
//          [_addressCell setCellData:@{@"title":title,@"detail":_orderDetail.receiveAddress?:@""}];
//          [_addressCell fitOrderInfoModeC];
//          NSString *price = [NSString stringWithFormat:@"¥%.2f",_orderDetail.goodsPrice];
//          [_goodsTotalCell  setCellData:@{@"title":@"商品合计:",@"detail":price}];
//          [_goodsTotalCell fitOrderInfoModeD];
//          price = [NSString stringWithFormat:@"¥%.2f",_orderDetail.freight];
//          [_carriageCell  setCellData:@{@"title":@"运费:",@"detail":price}];
//          [_carriageCell fitOrderInfoModeE];
//          price = [NSString stringWithFormat:@"¥%.2f",_orderDetail.couponPrice];
//          [_couponCell  setCellData:@{@"title":@"优惠劵:",@"detail":price}];
//          [_couponCell fitOrderInfoModeE];
//          price = [NSString stringWithFormat:@"¥%.2f",_orderDetail.actionPrice];
//          [_actDiscountCell  setCellData:@{@"title":@"活动优惠:",@"detail":price}];
//          [_actDiscountCell fitOrderInfoModeF];
//          [_orderNoCell  setCellData:@{@"title":@"订单编号:",@"detail":_orderDetail.orderNO}];
//          [_orderNoCell fitOrderInfoModeD];
//          [_submitTimeCell  setCellData:@{@"title":@"提交时间:",@"detail":_orderDetail.createTime?:@""}];
//          [_submitTimeCell fitOrderInfoModeE];
          NSString *state = @"";
          if (_orderDetail.othInfo.payType == 1) {
               state = @"支付宝支付";
          }else{
               state = @"微信支付";
          }
          [_payWayCell  setCellData:@{@"title":@"支付方式:",@"detail":state}];
          [_payWayCell fitOrderInfoModeE];
//           price = [NSString stringWithFormat:@"¥%.2f",_orderDetail.payPrice];
//          [_payMoneyCell  setCellData:@{@"title":@"实付金额:",@"detail":price}];
          [_payMoneyCell fitOrderInfoModeE];
          [ _payTimeCell setCellData:@{@"title":@"付款时间:",@"detail":_orderDetail.othInfo.payTime?:@""}];
          [_payTimeCell fitOrderInfoModeF];
     }else{
//          HUDCRY(noti.error.domain, 2);
     }

}

-(void)addBottomMenuView
{
     
     __weak OrderInfoViewController *weakSelf = self;
     _submitCell.width = __SCREEN_SIZE.width;
     _submitCell.y = __SCREEN_SIZE.height - NAVBARHEIGHT - 44;
     [_submitCell setCellData:@{@"title":@"确认收货",@"bTitle":@"查看物流"}];
     
     
//     _submitCell.layer.borderColor = kUIColorFromRGB(color_lineColor).CGColor;
//     _submitCell.layer.borderWidth = 0.5;
     
     [_submitCell fitMyOrderInfoMode];
     [self.view addSubview:_submitCell];
     //    if (_mode == 0) {
     //        [_submitCell removeFromSuperview];
     //    }
     //    else if (_mode == 1)
     //    {
     //        [_submitCell setCellData:@{@"title":@"确认完成"}];
     //        [self.view addSubview:_submitCell];
     //
     //        [_submitCell setHandleAction:^(id o) {
     ////            [weakSelf confirm];
     //        }];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)initTableView
{
     _tableView.refreshHeaderView = nil;
     [ImgAndThreeTitleTableViewCell registerTableViewCell:_tableView];
      _submitCell = [OnlyBottomBtnTableViewCell createTableViewCell];
     _stateCell  = [TitleDetailTableViewCell createTableViewCell];
     
     _stateInfoCell = [TitleDetailTableViewCell createTableViewCell];
     
     _addressCell = [TitleDetailTableViewCell createTableViewCell];
     
     _goodsTipCell = [OnlyTitleTableViewCell createTableViewCell];
     
     _orderTipCell = [OnlyTitleTableViewCell createTableViewCell];
     
     _goodsTotalCell = [TitleDetailTableViewCell createTableViewCell];
     
     _carriageCell = [TitleDetailTableViewCell createTableViewCell];
     
     _couponCell = [TitleDetailTableViewCell createTableViewCell];
     
     _youbiDiscountCell = [TitleDetailTableViewCell createTableViewCell];
     
     _actDiscountCell = [TitleDetailTableViewCell createTableViewCell];
     
     _billTypeCell = [TitleDetailTableViewCell createTableViewCell];
     
     _billriseCell = [TitleDetailTableViewCell createTableViewCell];
     
     _billContentCell = [TitleDetailTableViewCell createTableViewCell];
     
     _orderNoCell = [TitleDetailTableViewCell createTableViewCell];
     
     _submitTimeCell = [TitleDetailTableViewCell createTableViewCell];
     
     _payWayCell = [TitleDetailTableViewCell createTableViewCell];
     
     _payMoneyCell = [TitleDetailTableViewCell createTableViewCell];
     
     _payTimeCell = [TitleDetailTableViewCell createTableViewCell];
     

     [_stateCell setCellData:@{@"title":@"等待发货",@"detail":@"",@"img":@"waitSend"}];
     [_stateCell fitOrderInfoModeA];
     [_stateInfoCell setCellData:@{@"title":@"您的订单已经进入库房，准备出库",@"detail":@"2017-05-01 16：01"}];
      [_stateInfoCell fitOrderInfoModeB];
     [_addressCell setCellData:@{@"title":@"",@"detail":@""}];
      [_addressCell fitOrderInfoModeC];
      [_goodsTipCell  setCellData:@{@"title":@"商品信息"}];
     [_goodsTipCell fitOrderInfoModeA];
      [_orderTipCell  setCellData:@{@"title":@"租赁信息"}];
     [_orderTipCell fitOrderInfoModeB];
      [_goodsTotalCell  setCellData:@{@"title":@"租赁期数",@"detail":@"30天"}];
      [_goodsTotalCell fitOrderInfoModeD];
      [_carriageCell  setCellData:@{@"title":@"当前租金",@"detail":@"60.00元/天"}];
     [_carriageCell fitOrderInfoModeE:@"元/天"];
      [_couponCell  setCellData:@{@"title":@"配送方式",@"detail":@"单程包邮"}];
      [_couponCell fitOrderInfoModeEB];
      [_youbiDiscountCell  setCellData:@{@"title":@"优惠券",@"detail":@"60.00元"}];
     [_youbiDiscountCell fitOrderInfoModeE:@"元"];
      [_actDiscountCell  setCellData:@{@"title":@"订单租金",@"detail":@"1800.00"}];
      [_actDiscountCell fitOrderInfoModeER];
     
     [_billTypeCell  setCellData:@{@"title":@"押金",@"detail":@"￥2000.00"}];
        [_billTypeCell fitOrderInfoModeER];
     [_billriseCell  setCellData:@{@"title":@"免押金额",@"detail":@"￥2000.00"}];
        [_billriseCell fitOrderInfoModeF];
     [_billContentCell  setCellData:@{@"title":@"实付款 ",@"detail":@"￥2000.00",@"detail2":@"可退押金：￥0.00"}];
        [_billContentCell fitOrderInfoModeFF];
     [_orderNoCell  setCellData:@{@"title":@"订单编号:",@"detail":@"11977240"}];
        [_orderNoCell fitOrderInfoModeDD];
     [_submitTimeCell  setCellData:@{@"title":@"提交时间:",@"detail":@"2017-05-01 16:00"}];
        [_submitTimeCell fitOrderInfoModeE];
     [_payWayCell  setCellData:@{@"title":@"起租时间:",@"detail":@"收货后第二天开始计算"}];
        [_payWayCell fitOrderInfoModeE];
     [_payMoneyCell  setCellData:@{@"title":@"到期时间:",@"detail":@"按租期时间计算"}];
        [_payMoneyCell fitOrderInfoModeE];
     [ _payTimeCell setCellData:@{@"title":@"备注:",@"detail":@"无"}];
        [_payTimeCell fitOrderInfoModeFC];
     
     _tableView.x = 0;
     _tableView.y = 0;
     _tableView.width = __SCREEN_SIZE.width;
     _tableView.height = __SCREEN_SIZE.height - 64 - 45;
     _tableView.backgroundColor = kUIColorFromRGB(color_0xf0f0f0);
      self.view.backgroundColor = kUIColorFromRGB(color_0xf0f0f0);
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return  6;
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
     if (section == 5) {
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
     if (section == 5) {
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
           height = 65;
          }
     }
     else if (indexPath.section == 1)
     {
         
               height = 81;
          

     }
     else if (indexPath.section == 2)
     {
          if (indexPath.row == 0) {
                height = 31;
          }
          else
          {
                height = 136;
          }

     }
     else if (indexPath.section == 3)
     {
          if (indexPath.row == 0) {
               height = 41;
          }
          else
          if (indexPath.row == 1) {
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
     else if (indexPath.section == 4)
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
     else
     {
          if (indexPath.row == 0) {
               height = 26;
          }
          else
               if (indexPath.row == 4) {
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
            row = 1;
            break;
        case 2:
            row = 2;
            break;
        case 3:
            row = 6;
            break;

        case 4:
            row = 3;
            break;
        case 5:
            row = 5;
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
               cell = _stateCell;
                 [_stateCell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(41, 0, 0, 0)];
          }
          else
          {
               cell = _stateInfoCell;
               [_stateInfoCell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(65, 0, 0, 0)];
          }
     }
     else if (indexPath.section == 1)
     {
          cell = _addressCell;
          [_addressCell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(81, 0, 0, 0)];
          
     }
     else if (indexPath.section == 2)
     {
          if (indexPath.row == 0) {
               cell = _goodsTipCell;
                [_goodsTipCell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(31, 0, 0, 0)];
          }
          else
          {
               cell = [ImgAndThreeTitleTableViewCell dequeueReusableCell:_tableView];
               [(ImgAndThreeTitleTableViewCell *)cell setCellData:@{@"title":@"银色星芒刺绣网纱底裤",@"source":@"薄如蝉翼，丝滑如肌肤",@"time":@"¥99",@"img":@"secKillA",@"num":@"X1"}];
               [(ImgAndThreeTitleTableViewCell*)cell fitOrderInfoMode];
                  [(ImgAndThreeTitleTableViewCell*)cell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(136, 0, 0, 0)];
          }
          
     }
     else if (indexPath.section == 3)
     {
          if (indexPath.row == 0) {
               cell = _orderTipCell;
               [_orderTipCell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(41, 0, 0, 0)];
                         }

          else
               if (indexPath.row == 5) {
                    cell = _actDiscountCell;
                     [_actDiscountCell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(35, 0, 0, 0)];
               }
               else if(indexPath.row == 1)
               {
                    cell = _goodsTotalCell;

               }
               else if(indexPath.row == 2)
               {
                    cell = _carriageCell;
               }
               else if(indexPath.row == 3)
               {
                    cell = _couponCell;
               }

               else
               {
                    cell = _youbiDiscountCell;
               }

          
     }
     else if (indexPath.section == 4)
     {
          if (indexPath.row == 0) {
               cell = _billTypeCell;
          }

          else
               if (indexPath.row == 2) {
                    cell = _billContentCell;
                     [_billContentCell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(35, 0, 0, 0)];
               }
               else
               {
                    cell = _billriseCell;
               }
          
     }
     else
     {
          if (indexPath.row == 0) {
               cell = _orderNoCell;
          }
          
          else
               if (indexPath.row == 4) {
                    cell = _payTimeCell;
                     [_payTimeCell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(35, 0, 0, 0)];
               }
          else
          if (indexPath.row == 1) {
               cell = _submitTimeCell;
          }
          
          else   if (indexPath.row == 2) {
               cell = _payWayCell;
          }
          else{
               cell = _payMoneyCell;
          }
     }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)orderCancel
{
//     [busiSystem.getOrderListManager orderCancel:_orderDetail.orderId?:@"" withUserid:busiSystem.agent.userId?:@"" observer:self callback:@selector(orderCancelNotification:)];
}

-(void)orderCancelNotification:(BSNotification*)noti
{
     if (noti.error.code == 0) {
//          HUDDISMISS;
          [self.navigationController popViewControllerAnimated:YES];
     }
     else
     {

//          HUDCRY(noti.error.domain, 1);
     }
}

-(void)orderPay
{
     NSString *payType = @"0";
//     [busiSystem.getOrderListManager orderPay:payType withOrderid:_orderDetail.orderId withUserid:busiSystem.agent.userId?:@"" observer:self callback:@selector(orderPayNotification:)];
}

-(void)orderPayNotification:(BSNotification *)noti
{
     if (noti.error.code == 0) {
//          HUDDISMISS;

     }
     else
     {

//          HUDCRY(noti.error.domain, 1);
     }
}

-(void)orderFinish
{
//     [busiSystem.getOrderListManager orderFinish:_orderDetail.orderId?:@"" withUserid:busiSystem.agent.userId?:@"" observer:self callback:@selector(orderFinishNotification:)];
}

-(void)orderFinishNotification:(BSNotification*)noti
{
     if (noti.error.code == 0) {
//          HUDDISMISS;

     }
     else
     {

//          HUDCRY(noti.error.domain, 1);
     }
}

-(void)delOrder
{
//     [busiSystem.getOrderListManager orderDel:_orderDetail.orderId?:@"" withUserid:busiSystem.agent.userId?:@"" observer:self callback:@selector(orderDelNotification:)];
}
-(void)orderDelNotification:(BSNotification*)noti
{
     if (noti.error.code == 0) {
//          HUDDISMISS;
          [self.navigationController popViewControllerAnimated:YES];
     }
     else
     {

//          HUDCRY(noti.error.domain, 1);
     }
}

-(void)toGoodsInfoVC:(NSString *)pid
{
//     GoodsInfoViewController *vc = [GoodsInfoViewController new];
//     vc.hidesBottomBarWhenPushed = YES;
//     vc.ID = pid;
//     [self.navigationController pushViewController:vc animated:YES];
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
