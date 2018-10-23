//
//  SelledSeverViewController.m
//  oranllcshoping
//
//  Created by air on 2017/7/26.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import "SelledSeverViewController.h"
#import "ApplySalesReturnViewController.h"
#import "RecordInfoViewController.h"
#import "AuditProgressViewController.h"
#import "ImgAndThreeTitleTableViewCell.h"
#import "TitleDetailTableViewCell.h"
#import "OnlyBottomBtnTableViewCell.h"
#import "ImgTitleAndImgTableViewCell.h"
#import "GoodsInfoViewController.h"
#import "LoginViewController.h"
//#import "HuanxinKefuManager.h"
@interface SelledSeverViewController ()
{
     XHScrollMenuHelper *scrollMenuHelper;
   
     NSMutableArray *headViews;
     BOOL isFirstAppear;
}
@end

@implementation SelledSeverViewController
-(void) myViewDidLoad{
     [self setMainVc:self];
//     currentOrderStatue = 0;
      self.tabView.width = __SCREEN_SIZE.width;
     scrollMenuHelper = [[XHScrollMenuHelper alloc] init];
     [self.tabView addSubview: [scrollMenuHelper scrollMenuWithTitleAndFrame:CGRectMake(0, 0, self.tabView.frame.size.width, self.tabView.frame.size.height) titles:[self getScrollMenuTitles] target:self action:@selector(handleChangeOrderType:)]];
//     [self scrollMenu].selectedIndex = 0;
     [self.tabView layoutIfNeeded];
     UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 39.5, __SCREEN_SIZE.width, 0.5)];
     line.backgroundColor = kUIColorFromRGB(color_lineColor);
     [self.view addSubview:line];
     [self initTableView:_tableViewA];
     [self initTableView:_tableViewB];
//     [self initTableView:_tableViewC];
//     [self initTableView:_tableViewD];
     //     [self initTableView:_tableViewE];
     [super myViewDidLoad];
     
}

-(void)initTableView:(MyTableView *)tb
{
     tb.refreshHeaderView = nil;
     
     [ImgAndThreeTitleTableViewCell registerTableViewCell:tb];
     [TitleDetailTableViewCell registerTableViewCell:tb];
     [OnlyBottomBtnTableViewCell registerTableViewCell:tb];
     [ImgTitleAndImgTableViewCell registerTableViewCell:tb];
     //     [TitleDetailTableViewCell registerTableViewCell:tb];
}

-(void)handleReturnBack:(id)sender
{
     [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
     self.scrollViewList = @[self.tableViewA,self.tableViewB];
     for (int i = 0; i < self.scrollViewList.count; i ++) {
          UITableView *tb = (UITableView *)self.scrollViewList[i];
          tb.backgroundColor = kUIColorFromRGB(color_0xf0f0f0);
          [self.scrollView addSubview:tb];
     }
     [super viewDidLoad];
     isFirstAppear = YES;
     self.title = @"退换售后";
//     [self setNavigateRightButton:@"nav_kefu"];
     //    self.dataModel.currentMyOrder = NULL;
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshData) name:@"refreshSelledServerData" object:nil];
     HUDSHOW(@"加载中");
     [self getData];
}
-(void)dealloc
{
     [[NSNotificationCenter defaultCenter] removeObserver:self];
}
-(void)refreshData
{
 [self getData];
}
-(void)getData
{
     if (self.currentOrderStatue == 0) {
          [busiSystem.myPathManager saleList:@"0" withUserid:busiSystem.agent.userId observer:self callback:@selector(getListNotification:) extraInfo:@{@"tabv":_tableViewA}];
     }
     else
     {
     [busiSystem.myPathManager saleList:@"1" withUserid:busiSystem.agent.userId observer:self callback:@selector(getListNotification:) extraInfo:@{@"tabv":_tableViewB}];
     }
}

-(void)getListNotification:(BSNotification*)noti
{
     if (noti.error.code == 0) {
          HUDDISMISS;
          MyTableView *tableView = noti.extraInfo[@"tabv"];
           NSString *tag = @"xxcc1";
          if (tableView == _tableViewA) {
               tableView.dataArr = [NSMutableArray arrayWithArray:busiSystem.myPathManager.saleList];
               tableView.hasMore = busiSystem.getOrderListManager.pageInfo.hasMore;
          }
          else
          {
                  tag = @"xxcc2";
          tableView.dataArr = [NSMutableArray arrayWithArray:busiSystem.myPathManager.saleList];
          tableView.hasMore = busiSystem.getAfterSaleListManager.pageInfo.hasMore;
          }
          [tableView reloadData];

          [[JYNoDataManager manager] addNodataView:tableView withTip:@"暂无信息" withImg:@"nodata" withCount:tableView.dataArr.count withTag:tag];
          [[JYNoDataManager manager] fitModeY:150];

     }
     else
     {

          HUDCRY(noti.error.domain, 1);
     }
}

-(void)handleDidRightButton:(id)sender
{
     if (!busiSystem.agent.isLogin) {
          [LoginViewController toLogin:self];
          return;
     }
//     [HuanxinKefuManager kefuHandle:self];
}
-(NSArray *) getScrollMenuTitles
{
     return @[@"售后服务",@"申请记录"];
}
-(void) viewWillAppear:(BOOL)animated
{
     [super viewWillAppear:animated];
     //       [self scrollMenu].selectedIndex = 1;
     [self setTableView];
     if (!isFirstAppear) {
          //        [self reloadData];
     }
     isFirstAppear = NO;
}

-(void) viewDidAppear:(BOOL)animated
{
     //    if (self.dataModel.currentMyOrder != NULL) {
     //        if (currentOrderStatue != [self.dataModel.currentMyOrder.status integerValue]) {
     //            currentOrderStatue = [self.dataModel.currentMyOrder.status integerValue];
//     [[self scrollMenu] setSelectedIndex:0 animated:NO calledDelegate:YES];
     //        }
     //
     //    }
}

-(UIScrollView *)scrollView
{
     return self.ScrollViewOrder;
}

-(XHScrollMenu*) scrollMenu
{
     return (XHScrollMenu *)self.tabView.subviews.lastObject;
}

- (void)didReceiveMemoryWarning {
     [super didReceiveMemoryWarning];
     // Dispose of any resources that can be recreated.
}

//-(UIView *) getUnfoundView
//{
//    NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"OrderUnfound" owner:nil options:nil];
//    UIView *headView = [nib objectAtIndex:0];
//   headView.backgroundColor = kUIColorFromRGB(color_white);
//    headView.frame =CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
//
//    UILabel *labelUnfound = (UILabel *)[headView viewWithTag:2];
//    labelUnfound.textColor = kUIColorFromRGB(color_mainTheme);
//    UILabel *label2 = (UILabel *)[headView viewWithTag:3];
//    label2.textColor = kUIColorFromRGB(color_unSelColor);
//    UILabel *goShopping = (UILabel *)[headView viewWithTag:4];
//    [goShopping richText:@"我要Shopping" color:[UIColor orangeColor] ];
//    CGRect frame = headView.frame;
//    frame.size.height = self.view.frame.size.height;
//    headView.frame = frame;
//    UIButton *buttonGoShopping = (UIButton *)[headView viewWithTag:5];
//    [buttonGoShopping addTarget:self action:@selector(handleGoShopping:) forControlEvents:UIControlEventTouchUpInside];
//    return headView;
//}

-(void) setTableView
{
     //    if (!headViews) {
     //
     //        headViews = [[NSMutableArray alloc] init];
     //
     //        [headViews addObject:[self getUnfoundView]];
     //
     //
     //        [headViews addObject:[self getUnfoundView]];
     //
     //        [headViews addObject:[self getUnfoundView]];
     //
     //
     //
     //        [headViews addObject:[self getUnfoundView]];
     //
     //
     //        [headViews addObject:[self getUnfoundView]];
     //
     //    }
     
}





#pragma mark --UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(MyTableView *)tableView
{
     NSInteger count = tableView.dataArr.count;
     return count;
}

- (NSInteger)tableView:(MyTableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
//      BUGetOrder *o = tableView.dataArr[section];
     NSInteger count = 3;//o.goodsList.count + 2;
     return count;
}

- (UITableViewCell *)tableView:(MyTableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
     UITableViewCell *cell;
     cell = [self createOrderCell: indexPath withTableView:tableView];
     return cell;
}

-(UITableViewCell *)createOrderCell:(NSIndexPath *)indexPath withTableView:(MyTableView *)tableView
{
   BUSaleList *s  = tableView.dataArr[indexPath.section];
     BUGetOrder *o = s.orderInfo;
     UITableViewCell *cell;
      if(indexPath.row == 1){
          
//           BUGetOrder *gs;// = o.goodsList[indexPath.row - 1];
          cell = [ImgAndThreeTitleTableViewCell dequeueReusableCell:tableView];

           NSDictionary *dic = [o getDicB:0];//@{@"title":@"iPhoneX",@"source":[NSString stringWithFormat:@"全网通/黑色/64G/12月"],@"time":[NSString stringWithFormat:@"租金：￥188.00"],@"default":@"default",@"num":@"预授押金：￥6499.00"};


          [(ImgAndThreeTitleTableViewCell *)cell setCellData:dic];
          [(ImgAndThreeTitleTableViewCell *)cell fitSelledServerMode];
          [(ImgAndThreeTitleTableViewCell*)cell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(136, 0, 0, 0)];
}
     else if(indexPath.row == 0)
     {
          cell = [TitleDetailTableViewCell dequeueReusableCell:tableView];
          NSDictionary *dic = [o getAfterSellDic:0];//@{@"title":[NSString stringWithFormat:@"订单编号：%@",@"012345668"],@"detail":@"下单时间：2017-05-01 16:00"};//[o getAfterSellDic:0]
          if(_tableViewB == tableView)
          {
               dic = [s getDic];
          }
          [(TitleDetailTableViewCell *)cell setCellData:dic];
          [(TitleDetailTableViewCell *)cell fitSelledSeverModeB];
            [(JYAbstractTableViewCell*)cell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(31, 0, 0, 0)];
     }
     else
     {
          if (tableView == _tableViewA) {
//               o.afterSaleState = 1;
//               if (o.afterSaleState == 1) {
                     cell = [OnlyBottomBtnTableViewCell dequeueReusableCell:tableView];
                    [(OnlyBottomBtnTableViewCell *)cell setCellData:@{@"title":@"申请售后",@"indexPath":indexPath}];
                    [(OnlyBottomBtnTableViewCell *)cell fitSelledSeverMode];
                    [(OnlyBottomBtnTableViewCell *)cell setHandleAction:^(NSDictionary *dic){
                         [self toApplySalesReturnVC:dic[@"indexPath"]];
                    }];
//               }
//               else
//               {
//                    cell = [ImgTitleAndImgTableViewCell dequeueReusableCell:_tableView];
//                    [(ImgTitleAndImgTableViewCell *)cell setCellData:@{@"title":@"该商品已超过售后期",@"img":@"icon_warn"}];
//                    [(ImgTitleAndImgTableViewCell *)cell fitSelledSeverMode];
//               }

               
               
          }
          else
          {
               cell = [ImgTitleAndImgTableViewCell dequeueReusableCell:tableView];
               [(ImgTitleAndImgTableViewCell *)cell setCellData:[s getAfterSellDic]];
               [(ImgTitleAndImgTableViewCell *)cell fitSelledSeverMode];
          }
     }
     cell.selectionStyle = UITableViewCellSelectionStyleNone;
     return  cell;
}


#pragma mark --UITableViewDelegate

//设置section头的高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
     return 0.001;
}

- (CGFloat)tableView:(MyTableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
     BUGetOrder *o = tableView.dataArr[indexPath.section];
     CGFloat height = 106;
     if (indexPath.row == 0) {
          height = 31;
     }
     else if(indexPath.row == 1)
     {
          height = 136;
     }
     else
     {
          height = 45;
     }
     return height;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
     return 10;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
     return nil;
}
//行的选择
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
     [tableView deselectRowAtIndexPath:indexPath animated:NO];
     if (_tableViewB == tableView) {
          BUSaleList *o = _tableViewB.dataArr[indexPath.section];
//          if (indexPath.row == 2) {
//                   BUGetOrder *o = _tableViewB.dataArr[indexPath.section];
               RecordInfoViewController *vc= [RecordInfoViewController new];
               vc.orderBackID = o.afterId;
               [self.navigationController pushViewController:vc animated:YES];
//          }
//          else  if(indexPath.row == 1){
//
////               GoodsInfoViewController *vc = [GoodsInfoViewController new];
////               BUGoods *sd;// = o.goodsList[indexPath.row - 1];
////                vc.ID = sd.goodsId;
////               [self.navigationController pushViewController:vc animated:YES];
//          }
     }
     else
     {
// BUGetOrder *o = _tableViewA.dataArr[indexPath.section];
//            if(indexPath.row != 0 && indexPath.row != 2 + 1 && 2 != 0){
//                 BUGoods *sd ;//= o.goodsList[indexPath.row - 1];
//          GoodsInfoViewController *vc = [GoodsInfoViewController new];
//                 vc.ID = sd.goodsId;
//           [self.navigationController pushViewController:vc animated:YES];
//            }
     }
     
}
#pragma mark --handle

-(void) handleChangeOrderType:(id) sender
{
     XHMenu *menu = (XHMenu *) sender;
     NSInteger index = menu.index;
     self.currentOrderStatue = index ;
     [self menuSelectedIndex:self.currentOrderStatue];
     HUDSHOW(@"加载中");
     [self getData];
     //    HUDSHOW(LoadingHintString);
     //    [self.dataModel getMyOrderList:currentOrderStatue  observer:self callback:@selector(getMyOrderListOutput:)];
}




#pragma mark --notification



-(void) getMyOrderListOutput:(BSNotification *) noti
{
     if (noti.error.code != -1) {
          MyTableView *tv = (MyTableView *)self.scrollViewList[self.currentOrderStatue];
          [tv.refreshFooterView resetState:YES];
     }
     //    BASENOTIFICATION(noti);
     //    [self reloadData];
}

//-(NSArray *) dataSource
//{
//    return [self.dataModel getOrdersByStatue:currentOrderStatue];
//}

//-(void) reloadData
//{
//    MyTableView *tv = (MyTableView *)self.scrollViewList[currentOrderStatue];
////    tv.hasMore = self.dataModel.pageinfo.hasMore;
//    if (self.dataSource == NULL || self.dataSource.count ==0) {
//        tv.tableHeaderView = headViews[currentOrderStatue];
//    }
//    else {
//        tv.tableHeaderView = NULL;
//    }
//    [self menuSelectedIndex:currentOrderStatue];
//    [((UITableView *)self.scrollViewList[currentOrderStatue]) reloadData];
//}

//-(BUTradeOrderManager *) dataModel
//{
//    return busiSystem.orderManager;
//}
#pragma mark --handle

//-(void) handleGoShopping:(id) sender
//{
//    self.tabBarController.selectedViewController = self.tabBarController.viewControllers[2];
//}

#pragma mark --page
-(void)refreshCurentPage
{
     //   [self.dataModel getMyOrderList:currentOrderStatue  observer:self callback:@selector(getMyOrderList2Output:)];
}

-(void) getMyOrderList2Output:(BSNotification *) noti
{
     //    [self refreshTableHeaderNotification:noti myTableView:self.scrollViewList[currentOrderStatue]];
     //    BASENOTIFICATION(noti);
     //    [self reloadData];
     
}

-(void) loadNextPage
{
     //    [self.dataModel nextPage:self callback:@selector(getMyOrderListOutput:)];
     if (self.currentOrderStatue == 0) {
          [busiSystem.getOrderListManager getOrderListNextPage:self callback:@selector(getListNotification:) extraInfo:@{@"tabv":_tableViewA}];
     }
     else
     {
          [busiSystem.getAfterSaleListManager getListNextPage:self callback:@selector(getListNotification:) extraInfo:@{@"tabv":_tableViewB}];
     }
}


-(void)toApplySalesReturnVC:(NSIndexPath*)indexPath
{
    BUSaleList *s  = _tableViewA.dataArr[indexPath.section];
     BUGetOrder *o = s.orderInfo;
     ApplySalesReturnViewController *vc = [ApplySalesReturnViewController new];
     vc.orderId = o.orderID;
     [vc setHandleGoBack:^(id userData) {
          [self getData];
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
