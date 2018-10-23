//
//  WaitEvaOrderInfoViewController.m
//  oranllcshoping
//
//  Created by air on 2017/7/26.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import "WaitEvaOrderInfoViewController.h"
//#import "GoodsInfoViewController.h"
//#import "CartViewController.h"
//#import "PublishEvaViewController.h"
//#import "MyEvaViewController.h"
//#import "SelledSeverViewController.h"
//#import "EvaluateInfoViewController.h"
#import "PublishEvaViewController.h"
//#import "ApplySalesReturnViewController.h"
//#import "OrderTrackingViewController.h"

@interface WaitEvaOrderInfoViewController ()

@end

@implementation WaitEvaOrderInfoViewController
-(id)init
{
     self = [super initWithNibName:@"OrderInfoViewController" bundle:nil];
     return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(void)addBottomMenuView
{
     
     __weak OrderInfoViewController *weakSelf = self;
     
     
     [self.stateCell setCellData:@{@"title":@"交易完成",@"detail":@"",@"img":@"icon_order_finish"}];
     [self.stateCell fitOrderInfoModeA];
     
     
     
     
     
     self.submitCell.width = __SCREEN_SIZE.width;
     self.submitCell.y = __SCREEN_SIZE.height - 64 - 44;
     NSString *as =@"评价商品" ;// @"查看评价";//
     [self.submitCell setCellData:@{@"title":as,@"bTitle":@"申请售后",@"cTitle":@"删除订单"}];
     
     [self.submitCell fitMyOrderInfoMode];
     [self.view addSubview:self.submitCell];
 
     [self.submitCell setHandleAction:^(id o) {
        PublishEvaViewController *vc = [PublishEvaViewController new];
//          vc.order  = weakSelf.order;
        [weakSelf.navigationController pushViewController:vc animated:YES];
//          [vc setHandleGoBack:^(id userData) {
//
//          }];
     }];

     [self.submitCell setExtrHandleAction:^(id o) {
        
//        ApplySalesReturnViewController *vc = [ApplySalesReturnViewController new];
//        vc.order  = weakSelf.order;
//        [weakSelf.navigationController pushViewController:vc animated:YES];
//          SelledSeverViewController *vc = [SelledSeverViewController new];
//          [weakSelf.navigationController pushViewController:vc animated:YES];

     }];
     [self.submitCell setExtrHandleAction2:^(id o){
          [[CommonAPI managerWithVC:weakSelf] showAlert:@selector(toDeleteOrder:) withTitle:nil withMessage:@"是否删除订单？" withObj:@{}];
     }];
//     [self.submitCell setExtrHandleAction3:^(id o){
//
//     }];
//     //    }
}


-(void)toDeleteOrder:(NSDictionary *)dic{
     if ([dic[@"code"] integerValue] == 0) {
          
//          [self operOrder:@"2" orderId:self.order.orderID];
     }
}
-(void)operOrder:(NSString *)type orderId:(NSString *)orderId{
     HUDSHOW(@"加载中");
     [busiSystem.orderManager operOrder:busiSystem.agent.userId orderId:orderId type:type observer:self callback:@selector(operOrderNotification:)];
}

-(void)operOrderNotification:(BSNotification *)noti{
     HUDDISMISS;
     if (noti.error.code == 0) {
          //          [self getData];
          //          [_tableView reloadData];
          HUDSMILE(@"订单已删除", 2);
          [self performSelector:@selector(goback) withObject:nil afterDelay:2];
     }else{
          HUDCRY(noti.error.domain, 2);
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
     return  5;
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
     if (section == 4) {
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
               height = 45;
          }
     }
     
     else if (indexPath.section == 1)
     {
          height = 80;
          
     }
     
     else if (indexPath.section == 2)
     {
          height = 80;
          if (indexPath.row == 0) {
               height = 31;
          }
          else
          {
               height = 106;
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
                    if (indexPath.row == 4) {
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
//               row = self.order.outMyOrderItem.count+1;
               break;
          case 3:
               row = 5;
               break;
               
          case 4:
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
               cell = self.stateCell;
               [self.stateCell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(cell.height, 0, 0, 0)];
          }
          else
          {
               cell = self.stateInfoCell;
               [self.stateInfoCell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(45, 0, 0, 0)];
          }
     }
     
     
     else if (indexPath.section == 1)
     {
          
          cell = self.addressCell;
          [self.addressCell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(80, 0, 0, 0)];
          
          
     }
     
     else if (indexPath.section == 2)
     {
          if (indexPath.row == 0) {
               cell = self.goodsTipCell;
               [self.goodsTipCell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(31, 0, 0, 0)];
          }
          else
          {
               cell = [ImgAndThreeTitleTableViewCell dequeueReusableCell:self.tableView];
//               BUCartGoods *g = self.order.outMyOrderItem[indexPath.row-1];
//               [(ImgAndThreeTitleTableViewCell *)cell setCellData:[g getDic:2]];
               [(ImgAndThreeTitleTableViewCell *)cell fitFillInOrderMode];
               [(ImgAndThreeTitleTableViewCell*)cell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(106, 0, 0, 0)];
          }
          
     }
     else if (indexPath.section == 3)
     {
          if (indexPath.row == 0) {
               cell = self.orderTipCell;
               [self.orderTipCell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(41, 0, 0, 0)];
          }
          
          else
               if (indexPath.row == 4) {
                    cell = self.actDiscountCell;
                    [self.actDiscountCell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(35, 0, 0, 0)];
               }
               else if(indexPath.row == 1)
               {
                    cell = self.goodsTotalCell;
                    
               }
               else if(indexPath.row == 2)
               {
                    cell = self.carriageCell;
               }
               else if(indexPath.row == 3)
               {
                    cell = self.couponCell;
               }
          
               else
               {
                    cell = self.youbiDiscountCell;
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
               //               if (indexPath.row == 4) {
               //                    cell = _payTimeCell;
               //                    [_payTimeCell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(35, 0, 0, 0)];
               //               }
               //               else
               if (indexPath.row == 1) {
                    cell = self.submitTimeCell;
               }
          
               else   if (indexPath.row == 2) {
                    cell = self.payWayCell;
               }
               else   if (indexPath.row == 3) {
                    cell = self.payMoneyCell;
                    ;
               }
               else   if (indexPath.row == 4) {
                    cell = self.payTimeCell;
                    [self.payTimeCell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(35, 0, 0, 0)];
               }
          
     }
     cell.selectionStyle = UITableViewCellSelectionStyleNone;
     return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     if(indexPath.section == 1)
     {
          if (indexPath.row != 0) {
//               BUGoods *gd = self.orderDetail.goodsList[indexPath.row - 1];
//               if (gd.productType == 1) {
//                    GoodsInfoViewController *vc = [GoodsInfoViewController new];
//
//                    vc.ID = gd.goodsId;
//                    [self.navigationController pushViewController:vc animated:YES];
//               }
//               else if (gd.productType == 2)
//               {
//                    ServerInfoViewController *vc = [ServerInfoViewController new];
//                    vc.ID = gd.goodsId;
//                    [self.navigationController pushViewController:vc animated:YES];
//               }
//               else if (gd.productType == 3)
//               {
////                    ReplacementViewController *vc = [ReplacementViewController new];
////                    vc.hidesBottomBarWhenPushed = YES;
////                    vc.ID = gd.goodsId;
////                    vc.secondHandGoods = nil;
////                    [self.navigationController pushViewController:vc animated:YES];
//               }
          }
          
     }
     else if(indexPath.section == 0 && indexPath.row == 1){
//          OrderTrackingViewController *vc = [OrderTrackingViewController new];
//          vc.order = self.order;
//          [self.navigationController pushViewController:vc animated:YES];
     }
}

@end
