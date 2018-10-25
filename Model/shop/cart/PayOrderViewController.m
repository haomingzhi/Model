//
//  PayOrderViewController.m
//  oranllcshoping
//
//  Created by Steve on 2017/7/27.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import "PayOrderViewController.h"
#import "ImgAndThreeTitleTableViewCell.h"
#import "TitleAndDetailAndImageTableViewCell.h"
#import "OnlyTitleTableViewCell.h"
#import "PaySuccessViewController.h"
#import "MyOrderViewController.h"
#import "JYCommonTool.h"

@interface PayOrderViewController (){
     TitleAndDetailAndImageTableViewCell *_zhifubaoCell;
     TitleAndDetailAndImageTableViewCell *_weixinCell;
     TitleAndDetailAndImageTableViewCell *_bankCell;
     TitleAndDetailAndImageTableViewCell *_applePayCell;
     OnlyTitleTableViewCell *_titleCell;
     ImgAndThreeTitleTableViewCell *_infoCell;
}

@end

@implementation PayOrderViewController

- (void)viewDidLoad {
     [super viewDidLoad];
     
     self.title = @"支付订单";

     [self initTableView];
}

- (void)didReceiveMemoryWarning {
     [super didReceiveMemoryWarning];
     // Dispose of any resources that can be recreated.
}

-(void)handleReturnBack:(id)sender{
     if (_isSubmitOrder) {
          MyOrderViewController *vc = [MyOrderViewController new];
          vc.userInfo = @{@"index":@1};
          vc.hidesBottomBarWhenPushed = YES;
          [self.navigationController pushViewController:vc animated:YES];
     }else
          [self.navigationController popViewControllerAnimated:YES];
     
}

-(void)initTableView{
     
     __weak PayOrderViewController *weakSelf = self;
     
     _titleCell = [OnlyTitleTableViewCell createTableViewCell];
     [_titleCell setCellData:@{@"title":@"支付方式"}];
     [_titleCell fitOrderInfoMode];
     
     _zhifubaoCell = [TitleAndDetailAndImageTableViewCell createTableViewCell];
     [_zhifubaoCell setCellData:@{@"title":@"支付宝支付",@"detail":@"",@"img":@"icon_zhifubao"}];
     [_zhifubaoCell fitPayOrderMode];
     
     _weixinCell = [TitleAndDetailAndImageTableViewCell createTableViewCell];
     [_weixinCell setCellData:@{@"title":@"微信支付",@"detail":@"",@"img":@"icon_weixin"}];
     [_weixinCell fitPayOrderMode];
     
     _bankCell = [TitleAndDetailAndImageTableViewCell createTableViewCell];
     [_bankCell setCellData:@{@"title":@"银联支付",@"detail":@"",@"img":@"icon_bank"}];
     [_bankCell fitPayOrderMode];
     
     _applePayCell = [TitleAndDetailAndImageTableViewCell createTableViewCell];
     [_applePayCell setCellData:@{@"title":@"APPLE PAY",@"detail":@"",@"img":@"icon_applePay"}];
     [_applePayCell fitPayOrderMode];
     
     _infoCell = [ImgAndThreeTitleTableViewCell createTableViewCell];
     if (_mode == 1) {
//          [_infoCell setCellData:@{@"img":@"icon_submit_success",@"title":@"订单提交成功",@"time":[NSString stringWithFormat:@"¥%.2f",_order.payMoney],@"m":@(_min),@"s":@(_sec)}];
          [_infoCell fitPayOrderMode];
     }
     else
     {
//          [_infoCell setCellData:@{@"img":@"icon_submit_success",@"title":@"订单提交成功",@"time":[NSString stringWithFormat:@"¥%.2f",_order.payMoney]}];
          [_infoCell fitPayOrderModeB];
     }
     
     
     _tableView.delegate = self;
     _tableView.dataSource = self;
     _tableView.width = __SCREEN_SIZE.width;
     _tableView.height = __SCREEN_SIZE.height - NAVBARHEIGHT ;
     _tableView.x = 0;
     _tableView.y = 0;
     _tableView.refreshHeaderView = nil;
     _tableView.tableFooterView.userInteractionEnabled = YES;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
     return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
     NSInteger row = 1;
     if (section == 1){
          row = 3;
          
     }
     return row;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
     UITableViewCell *cell;
     if (indexPath.section == 0) {
          cell = _infoCell;
     }
     else{
          if (indexPath.row == 0) {
               cell = _titleCell;
          }else
          if (indexPath.row == 1) {
               cell = _zhifubaoCell;
          }else if (indexPath.row == 2) {
               cell = _weixinCell;
          }else if (indexPath.row == 3) {
               cell = _bankCell;
          }else{
               cell = _applePayCell;
          }
     }
     cell.selectionStyle = UITableViewCellSelectionStyleNone;
     return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
     if (section == 1) {
          return 0.01;
     }
     return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
     return 0.001;
}



-(void)saveAction{
     [self.navigationController popViewControllerAnimated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
     CGFloat height = 40;
     if (indexPath.section == 0) {
          height = 185;
     }
     return height;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//     [self.view endEditing:YES];
     if (indexPath.section == 1) {
          if (indexPath.row == 1) {
               [self orderPay:@"1"];
          }
          else   if (indexPath.row == 2) {
               [self orderPay:@"2"];
          }
     }
}

-(void)orderPay:(NSString *)type{
     
     HUDSHOW(@"加载中");
//     [busiSystem.payManager orderPay:type withOrderid:_order.orderId sourceType:@"1" orderType:_orderType?:@"" typeId:_typeId?:@""  observer:self callback:@selector(orderPayNotification:) extraInfo:@{@"type":type?:@""}];
}



-(void)orderPayNotification:(BSNotification *)noti{
     
     HUDDISMISS;

     
     if (noti.error.code == 0) {
         NSInteger type = [noti.extraInfo[@"type"] integerValue];
          NSString *payBody = busiSystem.payManager.payBody;
          [[CommonAPI managerWithVC:self] toPay:@{@"payBody":payBody,@"method":@(type)} withBlock:^(NSDictionary *dic) {
               if([dic[@"code"] integerValue] == 0)
               {
//                    BUGetOrder *getOrder = busiSystem.payManager.order;
                    PaySuccessViewController *vc = [PaySuccessViewController new];
                    vc.payType = type;
//                    vc.price = _order.payMoney;
                    vc.orderType = _orderType;
                    [self.navigationController pushViewController:vc animated:YES];
                    if (self.handleGoBack) {
                         self.handleGoBack(@{});
                    }

               }
          }];


     }else{
          HUDCRY(noti.error.domain, 2);
     }
     
}

-(void)upOrder{
     HUDSHOW(@"加载中");
//     [busiSystem.payManager upOrder:_order.orderId observer:self callback:@selector(upOrderNotification:)];
}


-(void)upOrderNotification:(BSNotification *)noti{
     
     HUDDISMISS;
     
     
     if (noti.error.code == 0) {
//          BUGetOrder *getOrder = busiSystem.payManager.order;
          PaySuccessViewController *vc = [PaySuccessViewController new];
          vc.payType = 1;
          vc.price = 100.0;
          [self.navigationController pushViewController:vc animated:YES];
          
          
     }else{
          HUDCRY(noti.error.domain, 2);
     }
     
}

@end
