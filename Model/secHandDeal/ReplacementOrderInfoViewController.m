//
//  ReplacementOrderInfoViewController.m
//  intelligentgarbagecollection
//
//  Created by air on 2017/12/6.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import "ReplacementOrderInfoViewController.h"
#import "TwoTabsTableViewCell.h"
#import "TitleDetailTableViewCell.h"
#import "OnlyTitleTableViewCell.h"
//#import "ReplacementViewController.h"
#import "PayOrderViewController.h"
@interface ReplacementOrderInfoViewController ()
{
     OnlyBottomBtnTableViewCell *_menuView;
     TitleDetailTableViewCell *_moneyCell;
     OnlyTitleTableViewCell *_timeCell;
     OnlyTitleTableViewCell *_orderNoCell;
}
@end

@implementation ReplacementOrderInfoViewController


-(id)init
{
     self = [super initWithNibName:@"ReplacementConfirmViewController" bundle:nil];
     return self;
}
- (void)viewDidLoad {
     [self fitMode];
    [super viewDidLoad];
     self.title = @"置换详情页";
    // Do any additional setup after loading the view.
     HUDSHOW(@"加载中");
     [self getData];
}

-(void)initTableView
{
     [super initTableView];
     _moneyCell = [TitleDetailTableViewCell createTableViewCell];
     [_moneyCell setCellData:@{@"title":@"支付金额 ￥ ",@"detail":@"积分抵扣 0"}];
     [_moneyCell fitReplacementOrderInfoMode];

     _timeCell = [OnlyTitleTableViewCell createTableViewCell];
     [_timeCell setCellData:@{@"title":@"支付时间 "}];
     [_timeCell fitReplacementOrderInfoMode];

     _orderNoCell = [OnlyTitleTableViewCell createTableViewCell];
     [_orderNoCell setCellData:@{@"title":@"置换单号 "}];
      [_orderNoCell fitReplacementOrderInfoMode];
}
-(void)fitMode
{

     __weak ReplacementOrderInfoViewController *weakSelf = self;

     _menuView = [OnlyBottomBtnTableViewCell createTableViewCell];
     _menuView.hidden = YES;
     [_menuView setHandleAction:^(id o) {
          BUOrderDetail *odd = busiSystem.getOrderListManager.orderDetail;
          if (odd.state == 2) {
               NSString *str = @"确认置换";
               [[CommonAPI managerWithVC:weakSelf] showAlertView:nil withMsg:[NSString stringWithFormat:@"是否%@？",str] withBtnTitle:@"确定"   withSel:@selector(toProcessResult:) withUserInfo:@{}];
          }
          else if(odd.state == 1)
          {
               BUGetOrder *od = [BUGetOrder new];
               od.orderId =  busiSystem.getOrderListManager.orderDetail.orderId;
               PayOrderViewController *vc = [PayOrderViewController new];
               vc.order = od;
//               vc.mode = 1;
//               vc.sec = weakSelf.second;
//               vc.min = weakSelf.minute;
               [vc setHandleGoBack:^(id userData) {
                    busiSystem.agent.isNeedRefreshTabD = YES;
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshOrderListData" object:nil];

               }];
               [weakSelf.navigationController pushViewController:vc animated:YES];
          }
          else if(odd.state == 0)
          {
 [[CommonAPI managerWithVC:weakSelf] showAlert:@selector(toDeleteOrder:) withTitle:nil withMessage:@"是否删除订单？" withObj:@{}];
          }

     }];
     [_menuView setExtrHandleAction:^(id o) {
               [[CommonAPI managerWithVC:weakSelf] showAlertView:nil withMsg:@"是否确认取消订单?" withBtnTitle:@"确定"   withSel:@selector(toCancelProcessResult:) withUserInfo:@{}];
     }];
}

-(void)toCancelProcessResult:(NSDictionary *)dic{
     __weak ReplacementOrderInfoViewController *weakSelf = self;
     if ([dic[@"code"] integerValue] == 0) {
          BUGetOrder *od = [BUGetOrder new];
          od.orderId = busiSystem.getOrderListManager.orderDetail.orderId;
          [self.titleCell setCellData:@{@"detail":@"交易关闭",@"title":@"二手置换"}];
           [self.titleCell fitReplacementConfirmMode];
          [_menuView setCellData:@{@"title":@"删除订单",@"detail":@""}];
          [[NSNotificationCenter defaultCenter] postNotificationName:@"cancelOrderData" object:nil userInfo:@{@"order":od?:@""}];
          [self.navigationController popViewControllerAnimated:YES];
          busiSystem.agent.isNeedRefreshTabD = YES;
          [_menuView setHandleAction:^(id o){
               //          CartViewController *vc = [CartViewController new];
               //          [weakSelf.navigationController pushViewController:vc animated:YES];
               [[CommonAPI managerWithVC:weakSelf] showAlert:@selector(toDeleteOrder:) withTitle:nil withMessage:@"是否删除订单？" withObj:@{}];
          }];
          //          [self operOrder:@"2" orderId:self.order.orderID];
     }
}
-(void)toDeleteOrder:(NSDictionary *)dic{
     if ([dic[@"code"] integerValue] == 0) {
          BUGetOrder *od = [BUGetOrder new];
          od.orderId =  busiSystem.getOrderListManager.orderDetail.orderId;
          [[NSNotificationCenter defaultCenter] postNotificationName:@"delOrderData" object:nil userInfo:@{@"order":od}];
          [self.navigationController popViewControllerAnimated:YES];
          busiSystem.agent.isNeedRefreshTabD = YES;
          //          [self operOrder:@"2" orderId:self.order.orderID];
     }
}

-(void)toProcessResult:(NSDictionary *)dic{
     if ([dic[@"code"] integerValue] == 0) {
          _menuView.hidden = YES;
//          self.tableView.height = __SCREEN_SIZE.height - 64;
          BUGetOrder *od = [BUGetOrder new];
          od.orderId = busiSystem.getOrderListManager.orderDetail.orderId;
          [[NSNotificationCenter defaultCenter] postNotificationName:@"confirmOrderData" object:nil userInfo:@{@"order":od}];
     }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)addBottomView
{
     _menuView.width = __SCREEN_SIZE.width;
     _menuView.y = __SCREEN_SIZE.height - 64 - 45;
     [self.view addSubview:_menuView];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
     CGFloat height = 44;
     if (indexPath.section == 0) {
          height = 81;
     }
     else
     {
          if (indexPath.row == 0) {
               height = 41;
          }
          else if (indexPath.row == 1)
          {
               height = 115;
          }
          else if (indexPath.row == 2)
          {
               height = 41;
          }
          else if (indexPath.row == 3)
          {
               height = 41;
          }
          else if (indexPath.row == 4)
          {
               height = 41;
          }else
          {
               height = 41;
          }
     }
     return height;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
     NSInteger row = 1;
     if(section == 1)
     {
          row = 5;
     }
     return row;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
     UITableViewCell *cell;
     if (indexPath.section == 0) {
          cell = self.adrCell;
     }
     else
     {
          if (indexPath.row == 0) {
               cell = self.titleCell;
               [self.titleCell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(41, 0, 0, 0)];
          }
          else if (indexPath.row == 1)
          {
               cell = self.secHandCell;
               [self.secHandCell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(115, 0, 0, 0)];
          }
          else if (indexPath.row == 2)
          {
               cell = _moneyCell;
                [_moneyCell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(41, 0, 0, 0)];
          }
          else if (indexPath.row == 3)
          {
               cell = _timeCell;
                [_timeCell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(41, 0, 0, 0)];
          }
          else
          {
               cell = _orderNoCell;
                [_orderNoCell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(41, 0, 0, 0)];
          }

     }
     cell.selectionStyle = UITableViewCellSelectionStyleNone;
     return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     if(indexPath.section == 1 && indexPath.row == 1)
     {

         BUGoods *gds = _getOrder.goodsList.firstObject;
//          ReplacementViewController *vc = [ReplacementViewController new];
//          vc.hidesBottomBarWhenPushed = YES;
//          vc.ID = gds.goodsId;
//            vc.secondHandGoods = nil;
//          [self.navigationController pushViewController:vc animated:YES];
     }
}

-(void)getData
{
     [busiSystem.getOrderListManager getOrderDetail:_getOrder.orderId?:@"" observer:self callback:@selector(getOrderDetailNotification:)];
}

-(void)getOrderDetailNotification:(BSNotification*)noti
{
     if (noti.error.code == 0) {
          HUDDISMISS;
        BUOrderDetail *odd = busiSystem.getOrderListManager.orderDetail;
          _getOrder = [BUGetOrder new];
          _getOrder.money = odd.money;
          _getOrder.integral = odd.integral;
          _getOrder.payTime = odd.payTime;
          _getOrder.orderNo = odd.orderNo;
          _getOrder.orderId = odd.orderId;
          _getOrder.orderType = odd.orderType;
          _getOrder.goodsList = odd.goodsList;
          [_moneyCell setCellData:@{@"title":[NSString stringWithFormat:@"支付金额 ￥ %.2f",_getOrder.money],@"detail":[NSString stringWithFormat:@"积分抵扣 %ld",_getOrder.integral]}];
          [_moneyCell fitReplacementOrderInfoMode];


          [_timeCell setCellData:@{@"title":[NSString stringWithFormat:@"支付时间 %@",_getOrder.payTime?:@""]}];
          [_timeCell fitReplacementOrderInfoMode];

          [_orderNoCell setCellData:@{@"title":[NSString stringWithFormat:@"置换单号 %@",_getOrder.orderNo?:@""]}];
          [_orderNoCell fitReplacementOrderInfoMode];
          BUGoods *gd = _getOrder.goodsList.firstObject;
//          _secHandCell = [ImgAndThreeTitleTableViewCell createTableViewCell];
          [self.secHandCell setCellData:[gd getDic]];
          [self.secHandCell fitMyOrderMode];

          [self.titleCell setCellData:@{@"title":@"二手置换",@"detail":odd.stateName?:@""}];
          [self.titleCell fitReplacementOrderInfoModeB];
          [self.tableView reloadData];
           if (odd.state == 0)
           {
                [_menuView setCellData:@{@"title":@"删除订单",@"detail":@""}];
                  _menuView.hidden = NO;
           }else
          if (odd.state == 1) {
          [_menuView setCellData:@{@"title":@"立即付款",@"bTitle":@"取消订单"}];
                 _menuView.hidden = NO;
          }
          else
               if (odd.state == 2) {
                    [_menuView setCellData:@{@"title":@"确认置换"}];
                     _menuView.hidden = NO;
               }
               else
             {
                    [_menuView setCellData:@{@"title":@""}];
                  _menuView.hidden = YES;
               }
//          [_menuView setCellData:@{@"tab1":@"删除订单",@"tab2":@"退款/退货"}];
            [_menuView fitMyOrderInfoMode];
     }
     else
     {

          HUDCRY(noti.error.domain, 1);
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
