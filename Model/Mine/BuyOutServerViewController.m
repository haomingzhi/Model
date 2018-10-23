//
//  BuyOutServerViewController.m
//  rentingshop
//
//  Created by air on 2018/3/20.
//  Copyright © 2018年 ORANLLC_IOS1. All rights reserved.
//

#import "BuyOutServerViewController.h"
#import "ImgAndThreeTitleTableViewCell.h"
#import "TitleDetailTableViewCell.h"
#import "OnlyBottomBtnTableViewCell.h"
#import "ImgTitleAndImgTableViewCell.h"
#import "BuyOutRecordInfoViewController.h"
#import "PayOrderViewController.h"
#import "BUSystem.h"
@interface BuyOutServerViewController ()

@end

@implementation BuyOutServerViewController
-(id)init
{
     self = [super initWithNibName:NSStringFromClass([self superclass]) bundle:nil];
     return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     self.title = @"买断申请列表";
     [OnlyBottomBtnTableViewCell registerTableViewCell:self.tableViewB withTag:@"yy"];
     [busiSystem.myPathManager buyoutld:@"1" withUserid:busiSystem.agent.userId observer:self callback:@selector(getListNotification:) extraInfo:@{@"tabv":self.tableViewB}];
}


-(void)handleReturnBack:(id)sender{
     [self.navigationController popToRootViewControllerAnimated:YES];
     self.tabBarController.selectedIndex = 3;
}

-(NSArray *) getScrollMenuTitles
{
     return @[@"可申请 ",@"已申请 "];
}
-(void)fitMenuData:(NSInteger)a withB:(NSInteger)b
{
     UIButton *btn = [self.scrollMenu viewWithTag:100+ 0];
     [btn setTitle:[NSString stringWithFormat:@"可申请 %ld",a] forState:UIControlStateNormal];

     UIButton *btn2 = [self.scrollMenu viewWithTag:100+ 1];
     [btn2 setTitle:[NSString stringWithFormat:@"已申请 %ld",b] forState:UIControlStateNormal];
}
-(void)getData
{
     if (self.currentOrderStatue == 0) {
          [busiSystem.myPathManager buyoutld:@"0" withUserid:busiSystem.agent.userId observer:self callback:@selector(getListNotification:) extraInfo:@{@"tabv":self.tableViewA}];
     }
     else
     {
          [busiSystem.myPathManager buyoutld:@"1" withUserid:busiSystem.agent.userId observer:self callback:@selector(getListNotification:) extraInfo:@{@"tabv":self.tableViewB}];
     }
}

-(void)getListNotification:(BSNotification*)noti
{
     if (noti.error.code == 0) {
          HUDDISMISS;
          MyTableView *tableView = noti.extraInfo[@"tabv"];
          NSString *tag = @"xxcc1";
          if (tableView == self.tableViewA) {
               tableView.dataArr = [NSMutableArray arrayWithArray:busiSystem.myPathManager.buyoutldArr];
//               tableView.hasMore = busiSystem.getOrderListManager.pageInfo.hasMore;
          }
          else
          {
               tag = @"xxcc2";
               tableView.dataArr = [NSMutableArray arrayWithArray:busiSystem.myPathManager.buyoutldArr];
//               tableView.hasMore = busiSystem.getAfterSaleListManager.pageInfo.hasMore;
          }
          [tableView reloadData];
[self fitMenuData:self.tableViewA.dataArr.count withB:self.tableViewB.dataArr.count];
          [[JYNoDataManager manager] addNodataView:tableView withTip:@"暂无信息" withImg:@"nodata" withCount:tableView.dataArr.count withTag:tag];
          [[JYNoDataManager manager] fitModeY:150];

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
-(UITableViewCell *)createOrderCell:(NSIndexPath *)indexPath withTableView:(MyTableView *)tableView
{
   BUBuyoutld *b = tableView.dataArr[indexPath.section];
     BUGetOrder *o = b.orderInfo;
     UITableViewCell *cell;
     if(indexPath.row == 1){

//          BUGoods *gs;// = o.goodsList[indexPath.row - 1];
          cell = [ImgAndThreeTitleTableViewCell dequeueReusableCell:tableView];
          //               BUCartGoods *g = self.order.outMyOrderItem[indexPath.row-1];
          NSDictionary *dic = [o getDicB:0];//@{@"title":@"iPhoneX",@"source":[NSString stringWithFormat:@"全网通/黑色/64G/12月"],@"time":[NSString stringWithFormat:@"租金：￥188.00"],@"default":@"default",@"num":@"预授押金：￥6499.00"};
          [(ImgAndThreeTitleTableViewCell *)cell setCellData:dic];
          [(ImgAndThreeTitleTableViewCell *)cell fitSelledServerMode];
          [(ImgAndThreeTitleTableViewCell*)cell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(136, 0, 0, 0)];
     }
     else if(indexPath.row == 0)
     {
          cell = [TitleDetailTableViewCell dequeueReusableCell:tableView];
          NSDictionary *dic = [b getDic];//@{@"title":[NSString stringWithFormat:@"订单编号：%@",@"012345668"],@"detail":@"下单时间：2017-05-01 16:00"};//[o getAfterSellDic:0]
          if (tableView == self.tableViewA)  {
               dic =[b getDicA];
          }
          [(TitleDetailTableViewCell *)cell setCellData:dic];
          [(TitleDetailTableViewCell *)cell fitSelledSeverMode];
          [(JYAbstractTableViewCell*)cell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(31, 0, 0, 0)];
     }
     else
     {
          if (tableView == self.tableViewA) {
//               o.afterSaleState = 1;
//               if (o.afterSaleState == 1) {
                    cell = [OnlyBottomBtnTableViewCell dequeueReusableCell:tableView];
                    [(OnlyBottomBtnTableViewCell *)cell setCellData:@{@"title":@"申请买断",@"indexPath":indexPath,@"detail":[NSString stringWithFormat:@"合计：¥%.2f",b.orderInfo.payMoney]}];
                    [(OnlyBottomBtnTableViewCell *)cell fitSelledSeverMode];
//                    [(OnlyBottomBtnTableViewCell *)cell setHandleAction:^(NSDictionary *dic){
////                         [self toApplySalesReturnVC:dic[@"indexPath"]];
//                    }];
//               }
//               else
//               {
//                    cell = [ImgTitleAndImgTableViewCell dequeueReusableCell:tableView];
//                    [(ImgTitleAndImgTableViewCell *)cell setCellData:@{@"title":@"该商品已超过售后期",@"img":@"icon_warn"}];
//                    [(ImgTitleAndImgTableViewCell *)cell fitSelledSeverMode];
//               }

 [self toFitOption:b withCell:(OnlyBottomBtnTableViewCell *)cell withTableView:tableView];

          }
          else
          {
//               cell = [ImgTitleAndImgTableViewCell dequeueReusableCell:tableView];
//               [(ImgTitleAndImgTableViewCell *)cell setCellData:[o getAfterSellDic:1]];
//               [(ImgTitleAndImgTableViewCell *)cell fitSelledSeverMode];
               cell = [OnlyBottomBtnTableViewCell dequeueReusableCell:tableView withTag:@"yy"];
               //          BUGetOrder *o = _tableView.dataArr[indexPath.section];
               NSDictionary *dic = [b getDicB];//@{@"title":@"删除订单",@"bTitle":@"重新购买",@"detail":@"应付金额:￥122"};//[o getDicC];
               [(JYAbstractTableViewCell *)cell setCellData:dic];
               //          BUGetOrder *o = [BUGetOrder new];
               //          o.orderType = 4;
                              [self toFitOption:b withCell:(OnlyBottomBtnTableViewCell *)cell withTableView:tableView];
               [(OnlyBottomBtnTableViewCell *)cell fitSelledSeverModeB];

          }
     }
     cell.selectionStyle = UITableViewCellSelectionStyleNone;
     return  cell;
}

-(void)toFitOption:(BUBuyoutld*) o withCell:(OnlyBottomBtnTableViewCell *)cell withTableView:(MyTableView*)tab
{
     if (tab == self.tableViewA) {
          [cell setHandleAction:^(id sender) {
               [[CommonAPI managerWithVC:self] showAlertView:@"是否申请买断该商品？" withMsg:@"确认后请耐心等待客服人员联系" withBtnTitle:@"提交"   withSel:@selector(toProcessResult:) withUserInfo:@{@"order":o}];
          }];
     }
     else
     {
          [cell setHandleAction:^(id sender) {
               [self payMoney:o];
          }];
     }



}

-(void)toProcessResult:(NSDictionary *)dic
{
     NSInteger tag = [dic[@"tag"] integerValue];
     if (tag == 100) {
          NSDictionary *userInfo = dic[@"userInfo"];
          BUBuyoutld *bu = userInfo[@"order"];
          [self addBuyOut:bu];
     }
}

-(void)payMoney:(BUBuyoutld *)b
{
     BUSubmitOrder *od = [BUSubmitOrder new];
     od.orderId = b.orderInfo.orderID;
     od.payMoney = b.buyoutMoney;
     PayOrderViewController *vc = [PayOrderViewController new];
     vc.order = od;
     vc.mode = 0;

     vc.orderType = @"3";
     vc.typeId = b.buyoutId;
     [vc setHandleGoBack:^(id userData) {
          busiSystem.agent.isNeedRefreshTabD = YES;
     }];
     [self.navigationController pushViewController:vc animated:YES];
}

//行的选择
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
     [tableView deselectRowAtIndexPath:indexPath animated:NO];
     if (self.tableViewB == tableView) {
          BUBuyoutld *o = self.tableViewB.dataArr[indexPath.section];
//          if (indexPath.row == 2) {
//               BUGetOrder *o = self.tableViewB.dataArr[indexPath.section];
               BuyOutRecordInfoViewController *vc= [BuyOutRecordInfoViewController new];
               vc.orderBackID = o.buyoutId;
               [self.navigationController pushViewController:vc animated:YES];
//          }
//          else  if(indexPath.row != 0 && indexPath.row != 2 + 1 && 2 != 0){
//
////               GoodsInfoViewController *vc = [GoodsInfoViewController new];
////               BUGoods *sd = o.goodsList[indexPath.row - 1];
////               vc.ID = sd.goodsId;
////               [self.navigationController pushViewController:vc animated:YES];
//          }
     }
     else
     {
//          BUGetOrder *o = self.tableViewA.dataArr[indexPath.section];
          if(indexPath.row != 0 && indexPath.row != 2 + 1 && 2 != 0){
//               BUGoods *sd = o.goodsList[indexPath.row - 1];
//               GoodsInfoViewController *vc = [GoodsInfoViewController new];
//               vc.ID = sd.goodsId;
//               [self.navigationController pushViewController:vc animated:YES];
          }
     }

}

-(void)addBuyOut:(BUBuyoutld*)o
{
//      BUGetOrder *o = self.tableViewA.dataArr[indexPath.section];
     [busiSystem.myPathManager addBuyoutld:o.orderInfo.orderID withUserid:busiSystem.agent.userId observer:self callback:@selector(addBuyoutldNotification:)];
}
-(void)addBuyoutldNotification:(BSNotification *)noti
{
     if (noti.error.code == 0) {
//          HUDDISMISS;
          [self getData];
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
