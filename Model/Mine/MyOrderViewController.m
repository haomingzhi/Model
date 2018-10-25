//
//  MyOrderViewController.m
//  JiXie
//  我的订单
//  Created by ORANLLC_IOS1 on 15/5/21.
//  Copyright (c) 2015年 ORANLLC_IOS1. All rights reserved.
//

#import "MyOrderViewController.h"
#import "BUSystem.h"
//#import "SendBackGoodsViewController.h"
//#import "TimeBackOrderInfoViewController.h"
#import "OrderInfoViewController.h"
//#import "MyOrderHelper.h"
//#import "RentingOrderInfoViewController.h"
#import "OnlyBottomBtnTableViewCell.h"
#import "TitleDetailTableViewCell.h"
#import "ImgAndThreeTitleTableViewCell.h"
#import "WaitPayOrderInfoViewController.h"
#import "WaitEvaOrderInfoViewController.h"
#import "DoneOrderInfoViewController.h"
#import "CancelOrderInfoViewController.h"
//#import "OrderTrackingViewController.h"

#import "WatiRecOrderInfoViewController.h"
#import "PayOrderViewController.h"
//#import "PublishEvaViewController.h"
//#import "ApplySalesReturnViewController.h"
//#import "ShopInfoViewController.h"
//#import "SecondCallViewController.h"
//#import "MyRunViewController.h"
//#import "CartViewController.h"
//#import "EvaluateInfoViewController.h"
//#import "CancelOrderViewController.h"
@interface MyOrderViewController ()

@end

@implementation MyOrderViewController
{
    XHScrollMenuHelper *scrollMenuHelper;
  
    NSMutableArray *headViews;
    BOOL isFirstAppear;
}

-(void) myViewDidLoad
{
    [self setMainVc:self];
   _currentOrderStatue = [_userInfo[@"index"] integerValue];
      self.tabView.width = __SCREEN_SIZE.width;
    scrollMenuHelper = [[XHScrollMenuHelper alloc] init];
     [self.tabView addSubview: [scrollMenuHelper scrollMenuWithTitleAndFrame:CGRectMake(0, 0, self.tabView.frame.size.width, self.tabView.frame.size.height) titles:[self getScrollMenuTitles] target:self action:@selector(handleChangeOrderType:)]];
//     [self scrollMenu].selectedIndex = _currentOrderStatue;
      [[self scrollMenu] setSelectedIndex:_currentOrderStatue animated:NO calledDelegate:YES];
    [self.tabView layoutIfNeeded];
     UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 44.5, __SCREEN_SIZE.width, 0.5)];
     line.backgroundColor = kUIColorFromRGB(color_lineColor);
     [self.view addSubview:line];
     [self initTableView:_tableViewA];
       [self initTableView:_tableViewB];
       [self initTableView:_tableViewC];
       [self initTableView:_tableViewD];
       [self initTableView:_tableViewE];
    [super myViewDidLoad];
    
}

-(void)initTableView:(MyTableView *)tb
{
     tb.refreshHeaderView = nil;
     [OnlyBottomBtnTableViewCell registerTableViewCell:tb];
     [ImgAndThreeTitleTableViewCell registerTableViewCell:tb];
     [TitleDetailTableViewCell registerTableViewCell:tb];
}

-(void)handleReturnBack:(id)sender
{
//     [self.navigationController popViewControllerAnimated:YES];
     self.tabBarController.selectedIndex = 3;
     [self.navigationController popToRootViewControllerAnimated:YES];
     
}

- (void)viewDidLoad {
    self.scrollViewList = @[self.tableViewA,self.tableViewB,self.tableViewC,self.tableViewD,self.tableViewE];
    for (int i = 0; i < self.scrollViewList.count; i ++) {
        UITableView *tb = (UITableView *)self.scrollViewList[i];
        tb.backgroundColor = kUIColorFromRGB(color_0xf0f0f0);
        [self.scrollView addSubview:tb];
    }
    [super viewDidLoad];
    isFirstAppear = YES;
    self.title = @"我的订单";
//    self.dataModel.currentMyOrder = NULL;
//     HUDSHOW(@"加载中");
//     [self getData];
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(delOrderData:) name:@"delOrderData" object:nil];
      [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cancelOrderData:) name:@"cancelOrderData" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(confirmOrderData:) name:@"confirmOrderData" object:nil];
       [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshOrderListData) name:@"refreshOrderListData" object:nil];
}

-(void)refreshOrderListData
{
     [self getData];
}

-(void)dealloc
{
     [[NSNotificationCenter defaultCenter] removeObserver:self];
}
-(void)delOrderData:(NSNotification*)noti
{
//  BUGetOrder *od =  noti.userInfo[@"order"];
//     [self delOrder:od];
}

-(void)cancelOrderData:(NSNotification*)noti
{
//     BUGetOrder *od =  noti.userInfo[@"order"];
//     [self orderCancel:od];
}

-(void)confirmOrderData:(NSNotification*)noti
{
//     BUGetOrder *od =  noti.userInfo[@"order"];
//     [self orderFinish:od];
}

-(void)getData
{

//     [busiSystem.getOrderListManager getOrderList:busiSystem.agent.userId withOrderStatus:[NSString stringWithFormat:@"%ld",_currentOrderStatue] observer:self callback:@selector(getOrderListNotification:) extraInfo:@{@"type":@(_currentOrderStatue )}];
}

-(void)getOrderListNotification:(BSNotification*)noti
{
     if (noti.error.code == 0) {
//          HUDDISMISS;
          MyTableView *_curTableView;
          NSInteger type = [noti.extraInfo[@"type"] integerValue];
          if (type == 0) {
               _curTableView = _tableViewA;

          }
          else if(type == 1)
          {
          _curTableView = _tableViewB;
          }
          else if (type == 2)
          {
          _curTableView = _tableViewC;
          }
          else if (type == 3)
          {
            _curTableView = _tableViewD;
          }
          else
          {
               _curTableView = _tableViewE;
          }
//          _curTableView.dataArr = [NSMutableArray arrayWithArray:busiSystem.getOrderListManager.dataArr];
//          _curTableView.hasMore = busiSystem.getOrderListManager.pageInfo.hasMore;
          [_curTableView reloadData];
          [[JYNoDataManager manager] addNodataView:_curTableView withTip:@"暂无信息" withImg:@"nodata" withCount:_curTableView.dataArr.count withTag:[NSString stringWithFormat:@"serShop%ld",type]];
          [[JYNoDataManager manager] fitModeY:150];
     }
     else
     {

//          HUDCRY(noti.error.domain, 1);
     }
}
-(NSArray *) getScrollMenuTitles
{
    return @[@"全部",@"待付款",@"发货中",@"租赁中",@"到期退还"];
}
-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setTableView];
     self.panGesture.enabled = NO;
//    if (isFirstAppear) {
//
//          [[self scrollMenu] setSelectedIndex:_currentOrderStatue animated:NO calledDelegate:YES];
//    }
    isFirstAppear = NO;
}

-(void)viewDidDisappear:(BOOL)animated
{
     [super viewDidDisappear:animated];
     self.panGesture.enabled = YES;
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

}





#pragma mark --UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(MyTableView *)tableView
{
     NSInteger count = tableView.dataArr.count;
    return count;
}

- (NSInteger)tableView:(MyTableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
//       BUGetOrder *od = tableView.dataArr[section];
     NSInteger count = 3;//2 + od.goodsList.count;
    return count;
}

- (UITableViewCell *)tableView:(MyTableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
     UITableViewCell *cell;
     if (self.tableViewA == tableView) {
           cell = [self createOneOrderCell: indexPath withTableView:tableView];
     }
     else if (self.tableViewB == tableView)
     {
          cell = [self createTwoOrderCell: indexPath withTableView:tableView];
     }
     else if (self.tableViewC == tableView)
     {
          cell = [self createThreeOrderCell: indexPath withTableView:tableView];
     }
     else if (self.tableViewD == tableView)
     {
          cell = [self createFourOrderCell: indexPath withTableView:tableView];
     }
     else
     {
          cell = [self createFiveOrderCell: indexPath withTableView:tableView];
     }
    return cell;
}

-(UITableViewCell *)createOneOrderCell:(NSIndexPath *)indexPath withTableView:(MyTableView *)tableView
{
//     BUGetOrder *o = tableView.dataArr[indexPath.section];
//     BUGoods *g = [BUGoods new];
//     od.goodsList = g;
     UITableViewCell *cell;
     if (indexPath.row == 0) {
          cell = [TitleDetailTableViewCell dequeueReusableCell:tableView];
//          BUGetOrder *o = tableView.dataArr[indexPath.section];
//          o.indexPath = indexPath;
          NSDictionary *dic;// = [o getDicA];//@{@"title":@"订单编号：012345668",@"detail":@"交易关闭"};//[o getDicA];
          [(JYAbstractTableViewCell *)cell setCellData:dic];
          [(TitleDetailTableViewCell *)cell fitMyOrderMode];
          [(TitleDetailTableViewCell *)cell setHandleAction:^(NSDictionary *dic) {
//               NSIndexPath *path = dic[@"indexPath"];
//               BUGetOrder *od = tableView.dataArr[path.section];;
//               ShopInfoViewController *vc = [ShopInfoViewController new];

//               vc.shopId = od.shopId;
//               [self.navigationController pushViewController:vc animated:YES];
          }];
          [(JYAbstractTableViewCell*)cell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(31, 0, 0, 0)];
          
     }
     else if(indexPath.row == 1)
     {
          cell = [ImgAndThreeTitleTableViewCell dequeueReusableCell:tableView];
//          BUGetOrder *o = tableView.dataArr[indexPath.section];
          NSDictionary *dic ;//= [o getDicB:0];//@{@"title":@"iPhoneX",@"source":[NSString stringWithFormat:@"全网通/黑色/64G/12月"],@"time":[NSString stringWithFormat:@"租金：￥188.00"],@"default":@"default",@"num":@"预授押金：￥6499.00"};;//[o getDicB];
          [(JYAbstractTableViewCell *)cell setCellData:dic];
          [(ImgAndThreeTitleTableViewCell *)cell fitMyOrderMode];
          [(JYAbstractTableViewCell*)cell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(136, 0, 0, 0)];
          
     }
     else
     {
          cell = [OnlyBottomBtnTableViewCell dequeueReusableCell:tableView];
//          BUGetOrder *o = _tableView.dataArr[indexPath.section];
          NSDictionary *dic;// = [o getDicC];
          [(JYAbstractTableViewCell *)cell setCellData:dic];
//          BUGetOrder *o = [BUGetOrder new];
//          o.orderType = 0;

          [(OnlyBottomBtnTableViewCell *)cell fitMyOrderMode];
//            [self toFitOption:o withCell:(OnlyBottomBtnTableViewCell *)cell withTableView:tableView];
//           [(JYAbstractTableViewCell*)cell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(44, 0, 0, 0)];
     }
      cell.selectionStyle = UITableViewCellSelectionStyleNone;
     return  cell;
}

-(UITableViewCell *)createTwoOrderCell:(NSIndexPath *)indexPath withTableView:(MyTableView *)tableView
{
//      BUGetOrder *o = tableView.dataArr[indexPath.section];
     UITableViewCell *cell;
     if (indexPath.row == 0) {
          cell = [TitleDetailTableViewCell dequeueReusableCell:tableView];
          //          BUGetOrder *o = _tableView.dataArr[indexPath.section];
          NSDictionary *dic;// = [o getDicA];//@{@"title":@"订单编号：012345668",@"detail":@"交易关闭"};//[o getDicA];
          [(JYAbstractTableViewCell *)cell setCellData:dic];
          [(TitleDetailTableViewCell *)cell fitMyOrderMode];
          [(TitleDetailTableViewCell *)cell setHandleAction:^(NSDictionary *dic) {
//               NSIndexPath *path = dic[@"indexPath"];
//               BUGetOrder *od = tableView.dataArr[path.section];;
//               ShopInfoViewController *vc = [ShopInfoViewController new];

//               vc.shopId = od.shopId;
//               [self.navigationController pushViewController:vc animated:YES];
          }];
          [(JYAbstractTableViewCell*)cell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(31, 0, 0, 0)];
          
     }
     else if(indexPath.row == 1)
     {
          cell = [ImgAndThreeTitleTableViewCell dequeueReusableCell:tableView];
          //          BUGetOrder *o = _tableView.dataArr[indexPath.section];
          NSDictionary *dic;// = [o getDicB:0];//@{@"title":@"iPhoneX",@"source":[NSString stringWithFormat:@"全网通/黑色/64G/12月"],@"time":[NSString stringWithFormat:@"租金：￥188.00"],@"default":@"default",@"num":@"预授押金：￥6499.00"};;//[o getDicB];
          [(JYAbstractTableViewCell *)cell setCellData:dic];
          [(ImgAndThreeTitleTableViewCell *)cell fitMyOrderMode];
          [(JYAbstractTableViewCell*)cell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(136, 0, 0, 0)];
          
     }
     else
     {
          cell = [OnlyBottomBtnTableViewCell dequeueReusableCell:tableView];
          //          BUGetOrder *o = _tableView.dataArr[indexPath.section];
          NSDictionary *dic;// = [o getDicC];
          [(JYAbstractTableViewCell *)cell setCellData:dic];
            [(OnlyBottomBtnTableViewCell *)cell fitMyOrderMode];
//          BUGetOrder *o = [BUGetOrder new];
//          o.orderType = 1;
//          [self toFitOption:o withCell:(OnlyBottomBtnTableViewCell *)cell withTableView:tableView];

//          [(JYAbstractTableViewCell*)cell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(44, 0, 0, 0)];
     }
     cell.selectionStyle = UITableViewCellSelectionStyleNone;
     return  cell;
}


-(UITableViewCell *)createThreeOrderCell:(NSIndexPath *)indexPath withTableView:(MyTableView *)tableView
{
//       BUGetOrder *o = tableView.dataArr[indexPath.section];
     UITableViewCell *cell;
     if (indexPath.row == 0) {
          cell = [TitleDetailTableViewCell dequeueReusableCell:tableView];
          //          BUGetOrder *o = _tableView.dataArr[indexPath.section];
          NSDictionary *dic;// = [o getDicA];//@{@"title":@"订单编号：012345668",@"detail":@"交易关闭"};//[o getDicA];
          [(JYAbstractTableViewCell *)cell setCellData:dic];
          [(TitleDetailTableViewCell *)cell fitMyOrderMode];
          [(TitleDetailTableViewCell *)cell setHandleAction:^(NSDictionary *dic) {
               NSIndexPath *path = dic[@"indexPath"];
//               BUGetOrder *od = tableView.dataArr[path.section];;
//               ShopInfoViewController *vc = [ShopInfoViewController new];

//               vc.shopId = od.shopId;
//               [self.navigationController pushViewController:vc animated:YES];
          }];
          [(JYAbstractTableViewCell*)cell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(31, 0, 0, 0)];
          
     }
     else if(indexPath.row == 1)
     {
          cell = [ImgAndThreeTitleTableViewCell dequeueReusableCell:tableView];
          //          BUGetOrder *o = _tableView.dataArr[indexPath.section];
          NSDictionary *dic;// = [o getDicB:0];//@{@"title":@"iPhoneX",@"source":[NSString stringWithFormat:@"全网通/黑色/64G/12月"],@"time":[NSString stringWithFormat:@"租金：￥188.00"],@"default":@"default",@"num":@"预授押金：￥6499.00"};;//[o getDicB:0];
          [(JYAbstractTableViewCell *)cell setCellData:dic];
          [(ImgAndThreeTitleTableViewCell *)cell fitMyOrderMode];
          [(JYAbstractTableViewCell*)cell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(136, 0, 0, 0)];
          
     }
     else
     {
          cell = [OnlyBottomBtnTableViewCell dequeueReusableCell:tableView];
          //          BUGetOrder *o = _tableView.dataArr[indexPath.section];
          NSDictionary *dic;// = [o getDicC];
          [(JYAbstractTableViewCell *)cell setCellData:dic];
//          BUGetOrder *o = [BUGetOrder new];
//          o.orderType = 2;
           [(OnlyBottomBtnTableViewCell *)cell fitMyOrderMode];
//          [self toFitOption:o withCell:(OnlyBottomBtnTableViewCell *)cell withTableView:tableView];

//          [(JYAbstractTableViewCell*)cell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(44, 0, 0, 0)];
     }
     cell.selectionStyle = UITableViewCellSelectionStyleNone;
     return  cell;
}



-(UITableViewCell *)createFourOrderCell:(NSIndexPath *)indexPath withTableView:(MyTableView *)tableView
{
//       BUGetOrder *o = tableView.dataArr[indexPath.section];
     UITableViewCell *cell;
     if (indexPath.row == 0) {
          cell = [TitleDetailTableViewCell dequeueReusableCell:tableView];
          //          BUGetOrder *o = _tableView.dataArr[indexPath.section];
          NSDictionary *dic;// = [o getDicA];//@{@"title":@"订单编号：012345668",@"detail":@"交易关闭"};//[o getDicA];
          [(JYAbstractTableViewCell *)cell setCellData:dic];
          [(TitleDetailTableViewCell *)cell fitMyOrderMode];
          [(TitleDetailTableViewCell *)cell setHandleAction:^(NSDictionary *dic) {
//               NSIndexPath *path = dic[@"indexPath"];
//               BUGetOrder *od = tableView.dataArr[path.section];;
//               ShopInfoViewController *vc = [ShopInfoViewController new];

//               vc.shopId = od.shopId;
//               [self.navigationController pushViewController:vc animated:YES];
          }];
          [(JYAbstractTableViewCell*)cell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(31, 0, 0, 0)];
          
     }
     else if(indexPath.row == 1)
     {
          cell = [ImgAndThreeTitleTableViewCell dequeueReusableCell:tableView];
          //          BUGetOrder *o = _tableView.dataArr[indexPath.section];
          NSDictionary *dic;// = [o getDicB:0];//@{@"title":@"iPhoneX",@"source":[NSString stringWithFormat:@"全网通/黑色/64G/12月"],@"time":[NSString stringWithFormat:@"租金：￥188.00"],@"default":@"default",@"num":@"预授押金：￥6499.00"};;//[o getDicB];
          [(JYAbstractTableViewCell *)cell setCellData:dic];
          [(ImgAndThreeTitleTableViewCell *)cell fitMyOrderMode];
          [(JYAbstractTableViewCell*)cell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(136, 0, 0, 0)];
          
     }
     else
     {
          cell = [OnlyBottomBtnTableViewCell dequeueReusableCell:tableView];
          //          BUGetOrder *o = _tableView.dataArr[indexPath.section];
          NSDictionary *dic;// = [o getDicC];
          [(JYAbstractTableViewCell *)cell setCellData:dic];
            [(OnlyBottomBtnTableViewCell *)cell fitMyOrderMode];
//          BUGetOrder *o = [BUGetOrder new];
//          o.orderType = 3;
//          [self toFitOption:o withCell:(OnlyBottomBtnTableViewCell *)cell withTableView:tableView];

//          [(JYAbstractTableViewCell*)cell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(44, 0, 0, 0)];
     }
     cell.selectionStyle = UITableViewCellSelectionStyleNone;
     return  cell;
}



-(UITableViewCell *)createFiveOrderCell:(NSIndexPath *)indexPath withTableView:(MyTableView *)tableView
{
//       BUGetOrder *o = tableView.dataArr[indexPath.section];
     UITableViewCell *cell;
     if (indexPath.row == 0) {
          cell = [TitleDetailTableViewCell dequeueReusableCell:tableView];
          //          BUGetOrder *o = _tableView.dataArr[indexPath.section];
          NSDictionary *dic ;//= [o getDicA];//@{@"title":@"订单编号：012345668",@"detail":@"交易关闭"};//[o getDicA];
          [(JYAbstractTableViewCell *)cell setCellData:dic];
          [(TitleDetailTableViewCell *)cell fitMyOrderMode];
          [(JYAbstractTableViewCell*)cell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(31, 0, 0, 0)];

     }
     else if(indexPath.row == 1)
     {
          cell = [ImgAndThreeTitleTableViewCell dequeueReusableCell:tableView];
          //          BUGetOrder *o = _tableView.dataArr[indexPath.section];
          NSDictionary *dic;// = [o getDicB:0];//@{@"title":@"iPhoneX",@"source":[NSString stringWithFormat:@"全网通/黑色/64G/12月"],@"time":[NSString stringWithFormat:@"租金：￥188.00"],@"default":@"default",@"num":@"预授押金：￥6499.00"};;//[o getDicB];
          [(JYAbstractTableViewCell *)cell setCellData:dic];
          [(ImgAndThreeTitleTableViewCell *)cell fitMyOrderMode];
          [(JYAbstractTableViewCell*)cell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(136, 0, 0, 0)];

     }
     else
     {
          cell = [OnlyBottomBtnTableViewCell dequeueReusableCell:tableView];
          //          BUGetOrder *o = _tableView.dataArr[indexPath.section];
          NSDictionary *dic;// = [o getDicC];//@{@"title":@"删除订单",@"bTitle":@"重新购买",@"detail":@"应付金额:￥122"};//[o getDicC];
          [(JYAbstractTableViewCell *)cell setCellData:dic];
//          BUGetOrder *o = [BUGetOrder new];
//          o.orderType = 4;
//          [self toFitOption:o withCell:(OnlyBottomBtnTableViewCell *)cell withTableView:tableView];
          [(OnlyBottomBtnTableViewCell *)cell fitMyOrderMode];
//          [(JYAbstractTableViewCell*)cell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(44, 0, 0, 0)];
     }
     cell.selectionStyle = UITableViewCellSelectionStyleNone;
     return  cell;
}

-(void)toFitOption:(NSString*)order withCell:(OnlyBottomBtnTableViewCell*)cell withTableView:(MyTableView *)tableView
{
     //      0 待付款 1 待发货 2 已发货 3 租赁中 34租赁中续费 5 到期归还 6 已完成 7 关闭
//0 待付款 1 待发货 2 已发货 3 租赁中 4租赁中续费 5 到期退还审核 6 已完成 7 关闭 8-评论完成 9-付款超时 10-到期退还
     if (7 ) {//删除
          [cell setHandleAction:^(id o){
               [[CommonAPI managerWithVC:self] showAlertView:@"删除订单" withMsg:@"是否确认删除该订单" withBtnTitle:@"确认"   withSel:@selector(toDelProcessResult:) withUserInfo:@{@"order":order}];
          }];
          [cell setExtrHandleAction:^(id o){

          }];
          [cell setExtrHandleAction2:^(id o){

          }];
     }
    else
     if ( 0) {//取消 付款
          [cell setHandleAction:^(id o){
               [self orderPay:order];
          }];
          [cell setExtrHandleAction:^(id o){
//               [CancelOrderViewController toVC:nil];
//               [self orderCancel:order];
                  [[CommonAPI managerWithVC:self] showAlertView:@"取消订单" withMsg:@"是否确认取消订单?" withBtnTitle:@"确认"   withSel:@selector(toCancelProcessResult:) withUserInfo:@{@"order":order}];
          }];
          [cell setExtrHandleAction2:^(id o){

          }];
     }
     else if ( 2) {
          [cell setHandleAction:^(id o){
               NSString *title = @"确认收货后开始计算租赁时间？";

               [[CommonAPI managerWithVC:self] showAlertView:@"确认收货" withMsg:title withBtnTitle:@"确认"   withSel:@selector(toProcessResult:) withUserInfo:@{@"order":order}];
          }];
          [cell setExtrHandleAction:^(id o){

          }];
          [cell setExtrHandleAction2:^(id o){

          }];
     }
     else if (6) {//删除 评论

          [cell setHandleAction:^(id o){

               [self toPublishEvaVC:order];
          }];
          [cell setExtrHandleAction:^(id o){
 [[CommonAPI managerWithVC:self] showAlertView:@"删除订单" withMsg:@"是否确认删除该订单" withBtnTitle:@"确认"   withSel:@selector(toDelProcessResult:) withUserInfo:@{@"order":order}];
          }];
     }

     else  if (3){
          NSInteger d =0;// -[BSUtility numberOfDaysFromTodayByTime:order.expireTime timeStringFormat:@"yyyy-MM-dd HH:mm:ss"];
          NSInteger m = 0;
          if (d <= 2 ) {
               m = 1;
          }
          [cell setHandleAction:^(id o){
//               SecondCallViewController *vc = [SecondCallViewController new];
//               vc.mode = m;
//               vc.orderId = order.orderID;
//               [self.navigationController pushViewController:vc animated:YES];
          }];

     }
     else  if(10){
          if ( 0) {

          [cell setHandleAction:^(id o){
//               SendBackGoodsViewController *vc = [SendBackGoodsViewController new];
////               vc.orderDetail = 
//               [self.navigationController pushViewController:vc animated:YES];
                   [[CommonAPI managerWithVC:self] showAlertView:@"提示" withMsg:@"请缴纳剩余租金后退还商品?" withBtnTitle:@"确认"   withSel:@selector(toXuZuProcessResult:) withUserInfo:@{}];
          }];
          [cell setExtrHandleAction:^(id o){
//               SecondCallViewController *vc = [SecondCallViewController new];
//               vc.mode = 1;
//               vc.orderId = order.orderID;
//               [self.navigationController pushViewController:vc animated:YES];
          }];
          }else
          {
               [cell setHandleAction:^(id o){
//                    SendBackGoodsViewController *vc = [SendBackGoodsViewController new];
//                  BUOrderDetail *oo = [BUOrderDetail new];
//                    oo.orderID = order.orderID;
//                    vc.orderDetail = oo;
//                    [self.navigationController pushViewController:vc animated:YES];
               }];
          }
     }
     
}
-(void)toXuZuProcessResult:(NSDictionary *)dic{
//     __weak TimeBackOrderInfoViewController *weakSelf = self;
     if ([dic[@"code"] integerValue] == 0) {

     }
}

-(void)toCancelProcessResult:(NSDictionary *)dic
{
//     NSInteger tag = [dic[@"tag"] integerValue];
//     if (tag == 100) {
//          NSDictionary *userInfo = dic[@"userInfo"];
//          BUGetOrder *od = userInfo[@"order"];
//          [self orderCancel:od];
//     }
}
-(void)toProcessResult:(NSDictionary *)dic
{
//     NSInteger tag = [dic[@"tag"] integerValue];
//     if (tag == 100) {
//          NSDictionary *userInfo = dic[@"userInfo"];
//          BUGetOrder *od = userInfo[@"order"];
//          [self orderFinish:od];
//     }
}

-(void)toDelProcessResult:(NSDictionary *)dic
{
//     NSInteger tag = [dic[@"tag"] integerValue];
//     if (tag == 100) {
//          NSDictionary *userInfo = dic[@"userInfo"];
//          BUGetOrder *od = userInfo[@"order"];
//          [self delOrder:od];
//     }
}

#pragma mark --UITableViewDelegate

//设置section头的高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.001;
}

- (CGFloat)tableView:(MyTableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//       BUGetOrder *o = tableView.dataArr[indexPath.section];
     CGFloat height = 44;
//     NSInteger lastIndex = o.goodsList.count + 1;
     if(indexPath.row == 0)
     {
          height = 31;
     }

     else if(indexPath.row == 1)
     {
          height = 136;
     }
     else
     {
          height = 44;
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
-(void)tableView:(MyTableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
     //      0 待付款 1 待发货 2 已发货 3 租赁中 34租赁中续费 5 到期归还 6 已完成 7 关闭
//0 待付款 1 待发货 2 已发货 3 租赁中 4租赁中续费 5 到期退还审核 6 已完成 7 关闭 8-评论完成 9-付款超时 10-到期退还
//     BUGetOrder *o = tableView.dataArr[indexPath.section];
////     o.state = 6;
////     o.orderType = 0;
//     if (o.state == 7 || o.state == 9 ) {
//
//          CancelOrderInfoViewController *vc = [CancelOrderInfoViewController new];
//          vc.order = o;
//          [self.navigationController pushViewController:vc animated:YES];
//
//     }
//     else if(o.state == 0)
//     {
//
//          WaitPayOrderInfoViewController *vc = [WaitPayOrderInfoViewController new];
//          vc.order = o;
//          [self.navigationController pushViewController:vc animated:YES];
//
//     }
//     else if (o.state == 2 ||o.state == 1)
//     {
//
//          WatiRecOrderInfoViewController *vc = [WatiRecOrderInfoViewController new];
//          vc.order = o;
//          [self.navigationController pushViewController:vc animated:YES];
//
//     }
//
//     else if (o.state == 6 ||o.state == 8)
//     {
//
//          DoneOrderInfoViewController *vc = [DoneOrderInfoViewController new];
//          vc.order = o;
//       [self.navigationController pushViewController:vc animated:YES];
//
//     }
//     else if(o.state == 3 || o.state == 4)
//     {
//          RentingOrderInfoViewController *vc = [RentingOrderInfoViewController new];
//          vc.order = o;
////            vc.lookMode = [self isKindOfClass:[MyRunViewController class]]?1:0;
//          [self.navigationController pushViewController:vc animated:YES];
//     }
//      else if(o.state == 10 || o.state == 5)
//     {
//
//          TimeBackOrderInfoViewController *vc = [TimeBackOrderInfoViewController new];
//          vc.order = o;
//          //            vc.lookMode = [self isKindOfClass:[MyRunViewController class]]?1:0;
//          [self.navigationController pushViewController:vc animated:YES];
//     }

}
 

#pragma mark --handle

-(void) handleChangeOrderType:(id) sender
{
    XHMenu *menu = (XHMenu *) sender;
    NSInteger index = menu.index;
    _currentOrderStatue = index ;
     [self menuSelectedIndex:_currentOrderStatue];
//     HUDSHOW(@"加载中");
     [self getData];
 }




#pragma mark --notification



//-(void) getMyOrderListOutput:(BSNotification *) noti
//{
//    if (noti.error.code != -1) {
//        MyTableView *tv = (MyTableView *)self.scrollViewList[_currentOrderStatue];
//        [tv.refreshFooterView resetState:YES];
//    }
//
//}




#pragma mark --page
-(void)refreshCurentPage
{
 
}

-(void) getMyOrderList2Output:(BSNotification *) noti
{
 
}

-(void) loadNextPage
{
//     MyTableView *curTableView = _tableViewA;
// if(_currentOrderStatue == 0)
// {
//
// }
//     else if (_currentOrderStatue == 1)
//     {
//
//     }
//     [busiSystem.getOrderListManager getOrderListNextPage:self callback:@selector(getOrderListNotification:)    extraInfo:@{@"type":@(_currentOrderStatue )}];
}

-(void)toPublishEvaVC:(NSString*)o
{
//     PublishEvaViewController *vc = [PublishEvaViewController new];
//     vc.order = o;
//     [vc setHandleGoBack:^(id userData) {
//          HUDSHOW(@"加载中");
//          [self getData];
//          busiSystem.agent.isNeedRefreshTabD = YES;
//     }];
//     [self.navigationController pushViewController:vc animated:YES];
}

-(void)toApplySalesReturnVC:(NSString*)o
{
//     ApplySalesReturnViewController *vc = [ApplySalesReturnViewController new];
////     vc.orderId = o.orderId;
//     [vc setHandleGoBack:^(id userData) {
//          [self getData];
//          busiSystem.agent.isNeedRefreshTabD = YES;
//     }];
//     [self.navigationController pushViewController:vc animated:YES];

}
-(void)orderCancel:(NSString *)o
{
//     HUDSHOW(@"加载中");
//          [busiSystem.orderManager operOrder:busiSystem.agent.userId?:@"" orderId:o.orderID?:@"" type:@"1" observer:self callback:@selector(orderCancelNotification:)];
}

-(void)orderCancelNotification:(BSNotification*)noti
{
     if (noti.error.code == 0) {

          [self getData];
           busiSystem.agent.isNeedRefreshTabD = YES;
     }
     else
     {

//          HUDCRY(noti.error.domain, 1);
     }
}

-(void)orderPay:(NSString *)o
{
//     BUSubmitOrder *od = [BUSubmitOrder new];
//     od.orderId = o.orderID;
//     od.payMoney = o.payMoney ;
//     PayOrderViewController *vc = [PayOrderViewController new];
//     vc.order = od;
//     vc.mode = 1;
//
//     NSInteger tt = -[BSUtility numberOfSecsFromTodayByTime:o.payEndTime timeStringFormat:@"yyyy-MM-dd HH:mm:ss"];
//     NSInteger minute = tt/60 - 1;
//     NSInteger sec = 60 - tt%60;
//     vc.sec = sec;
//     vc.min = minute;
//     vc.orderType = @"1";
//     vc.typeId = od.orderId;
//     [vc setHandleGoBack:^(id userData) {
//          busiSystem.agent.isNeedRefreshTabD = YES;
//     }];
//     [self.navigationController pushViewController:vc animated:YES];
//     PayOrderViewController *vc = [PayOrderViewController new];
//     vc.order = o;
////     NSInteger lmt = 30;//busiSystem.agent.config.payLimit;
////

//     vc.mode = 1;
//     vc.min = minute;
//     vc.sec = 59;
//     vc.orderType = @"1";
//     vc.typeId = o.orderID;
//     [self.navigationController pushViewController:vc animated:YES];
//  HUDSHOW(@"加载中");
//     NSString *payType = @"0";
//          [busiSystem.getOrderListManager orderPay:payType withOrderid:o.orderId withUserid:busiSystem.agent.userId?:@"" observer:self callback:@selector(orderPayNotification:)];
}

-(void)orderPayNotification:(BSNotification *)noti
{
     if (noti.error.code == 0) {
          [self getData];
           busiSystem.agent.isNeedRefreshTabD = YES;

     }
     else
     {

//          HUDCRY(noti.error.domain, 1);
     }
}

-(void)orderFinish:(NSString *)o
{
//       HUDSHOW(@"加载中");
//       [busiSystem.orderManager operOrder:busiSystem.agent.userId?:@"" orderId:o.orderID?:@"" type:@"3" observer:self callback:@selector(orderCancelNotification:)];
}

-(void)orderFinishNotification:(BSNotification*)noti
{
     if (noti.error.code == 0) {
//          HUDDISMISS;
          [self getData];
           busiSystem.agent.isNeedRefreshTabD = YES;
//          BUGetOrder *o = noti.extraInfo[@"order"];
//          if (o.orderType == 3) {
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"refresSecHandData" object:nil];
//          }
     }
     else
     {

//          HUDCRY(noti.error.domain, 1);
     }
}

-(void)delOrder:(NSString *)o
{
//       [busiSystem.orderManager operOrder:busiSystem.agent.userId?:@"" orderId:o.orderID?:@"" type:@"2" observer:self callback:@selector(orderCancelNotification:)];
}
-(void)orderDelNotification:(BSNotification*)noti
{
     if (noti.error.code == 0) {
          [self getData];
           busiSystem.agent.isNeedRefreshTabD = YES;
//          [self.navigationController popViewControllerAnimated:YES];
     }
     else
     {

//          HUDCRY(noti.error.domain, 1);
     }
}
-(void)confirmOrder:(NSString *)o
{
//     HUDSHOW(@"加载中");
//    [busiSystem.orderManager operOrder:busiSystem.agent.userId?:@"" orderId:o.orderID?:@"" type:@"3" observer:self callback:@selector(orderCancelNotification:)];
}

-(void)orderConfirmNotification:(BSNotification*)noti
{
     if (noti.error.code == 0) {
          [self getData];
           busiSystem.agent.isNeedRefreshTabD = YES;
     }
     else
     {

//          HUDCRY(noti.error.domain, 1);
     }
}
@end
