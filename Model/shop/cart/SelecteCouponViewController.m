//
//  MyCouponViewController.m
//  oranllcshoping
//
//  Created by air on 2017/7/26.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import "SelecteCouponViewController.h"
#import "CouponTableViewCell.h"
#import "CouponInfoViewController.h"
#import "CouponRuleViewController.h"
#import "BUSystem.h"

@interface SelecteCouponViewController ()
//@property (strong, nonatomic) IBOutlet MyTableView *tableView;
@property (nonatomic,strong) NSIndexPath *selectIndexPath;
@end

@implementation SelecteCouponViewController
{
     XHScrollMenuHelper *scrollMenuHelper;
     NSInteger currentOrderStatue;
     NSMutableArray *headViews;
     BOOL isFirstAppear;
     NSInteger _requestCount;
}


//-(void) myViewDidLoad
//{
//
//     [self setMainVc:self];
//     currentOrderStatue = 0;
//     scrollMenuHelper = [[XHScrollMenuHelper alloc] init];
//     [self.tabView addSubview: [scrollMenuHelper scrollMenuWithTitleAndFrame:CGRectMake(0, 0, __SCREEN_SIZE.width, self.tabView.frame.size.height) titles:[self getScrollMenuTitles] target:self action:@selector(handleChangeOrderType:)]];
//     [self scrollMenu].selectedIndex = 0;
//     [self.tabView layoutIfNeeded];
//     UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 29.5, __SCREEN_SIZE.width, 0.5)];
//     line.backgroundColor = kUIColorFromRGB(color_lineColor);
//     [self.view addSubview:line];
//     [self initTableView:_tableViewA];
//     [self initTableView:_tableViewB];
////     [self initTableView:_tableViewC];
////     [self initTableView:_tableViewD];
//     //     [self initTableView:_tableViewE];
//     [super myViewDidLoad];
//
//}




-(void)initTableView:(MyTableView *)tb
{
     tb.refreshHeaderView = nil;
//     tb.height = __SCREEN_SIZE.height - NAVBARHEIGHT- 30- 45;
     [CouponTableViewCell registerTableViewCell:tb];
     
     //     [TitleDetailTableViewCell registerTableViewCell:tb];
}

-(void)handleReturnBack:(id)sender
{
     [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
//     self.scrollViewList = @[self.tableViewA,self.tableViewB];
//     for (int i = 0; i < self.scrollViewList.count; i ++) {
//          UITableView *tb = (UITableView *)self.scrollViewList[i];
//          tb.backgroundColor = kUIColorFromRGB(color_0xf0f0f0);
//          [self.scrollView addSubview:tb];
//     }
     [super viewDidLoad];
     isFirstAppear = YES;
     self.title = @"选择优惠券";
//     [self setNavigateRightButton:@"nav_que"];
     //    self.dataModel.currentMyOrder = NULL;
      _tableViewA.dataArr = [NSMutableArray arrayWithArray:busiSystem.shopManager.couponList];
//     [_tableViewA.dataArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//          BUOrderCoupon *c  = obj;
//          if ([c.couponId isEqualToString:_coupon.couponId]) {
//               _selectIndexPath = [NSIndexPath indexPathForRow:idx inSection:0];
//               *stop = YES;
//          }
//     }];
     [self initTableView];
     
     [self addBottomBtn];
     
//     HUDSHOW(@"加载中");
//     [self getData];
}

-(void)initTableView
{
     _tableViewB.hidden = YES;
     
     [CouponTableViewCell registerTableViewCell:_tableViewA];
     _tableViewA.refreshHeaderView = nil;
     _tableViewA.x= 0;
     _tableViewA.y= 0;
     _tableViewA.width = __SCREEN_SIZE.width;
     _tableViewA.height = __SCREEN_SIZE.height - NAVBARHEIGHT - TABBARNONEHEIGHT-52;
     _tableViewA.delegate = self;
     _tableViewA.dataSource = self;
//     [self.view addSubview:_tableViewA];
     
     //     [TitleDetailTableViewCell registerTableViewCell:tb];
    
     
}



-(void)getData{
     NSMutableArray *arr = [NSMutableArray new];
     [_dataArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
          BUCartGoods *g = obj;
          BSJSON *j = [BSJSON new];
          [j setObject:g.productId?:@"" forKey:@"productId"];
          [ j setObject:@(g.quantity) forKey:@"quantity"];
          [arr addObject:j];
          
     }];
     _requestCount++;
     [busiSystem.orderManager getCouponList:busiSystem.agent.userId productIdQuantityList:arr storeId:busiSystem.agent.storeId type:@"1" observer:self callback:@selector(getCouponListNotification:)];
     
     _requestCount++;
     [busiSystem.orderManager getCouponList:busiSystem.agent.userId productIdQuantityList:arr storeId:busiSystem.agent.storeId type:@"0" observer:self callback:@selector(getCouponListANotification:)];
}



-(void)getCouponListNotification:(BSNotification *)noti{
     _requestCount --;
     if (_requestCount == 0) {
          HUDDISMISS;
     }
     
     if (noti.error.code == 0) {
          _tableViewB.dataArr = [NSMutableArray arrayWithArray:busiSystem.orderManager.couponList];
          [_tableViewB reloadData];
     }else{
          HUDCRY(noti.error.domain, 2);
     }
     
}

-(void)getCouponListANotification:(BSNotification *)noti{
     _requestCount --;
     if (_requestCount == 0) {
          HUDDISMISS;
     }
     
     if (noti.error.code == 0) {
          _tableViewA.dataArr = [NSMutableArray arrayWithArray:busiSystem.orderManager.couponUnUseList];
          [_tableViewA reloadData];
     }else{
          HUDCRY(noti.error.domain, 2);
     }
     
}


-(void)addBottomBtn{
     
     UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, __SCREEN_SIZE.height-NAVBARHEIGHT-TABBARNONEHEIGHT-53, __SCREEN_SIZE.width, 52)];
     view.backgroundColor = [UIColor whiteColor];
     [self.view addSubview:view];
     
     UIButton *btn =[[UIButton alloc]initWithFrame:CGRectMake(15, 9, __SCREEN_SIZE.width-30, 35)];
     btn.backgroundColor = kUIColorFromRGB(color_0xf74056);
     [btn setTitle:@"确定" forState:UIControlStateNormal];
     [btn setTitleColor:kUIColorFromRGB(color_2) forState:UIControlStateNormal];
     btn.layer.cornerRadius = btn.height/2.0;
     btn.layer.shadowColor = kUIColorFromRGB(color_0xf74056).CGColor;
     btn.layer.shadowOffset = CGSizeMake(0, 0);
     btn.layer.shadowRadius = 8;
     btn.layer.shadowOpacity = 0.43;
     
     [btn addTarget:self action:@selector(btnAtion) forControlEvents:UIControlEventTouchUpInside];
     [view addSubview:btn];
     
}

-(void)btnAtion{
     if (_coupon == nil) {
          HUDCRY(@"请选择优惠券", 2);
          return;
     }
     if (self.handleGoBack) {
          self.handleGoBack(@{@"obj":_coupon});
     }
     [self.navigationController popViewControllerAnimated:YES];
}

-(void)handleDidRightButton:(id)sender
{
     CouponRuleViewController *vc = [CouponRuleViewController new];
     [self.navigationController pushViewController:vc animated:YES];
}

-(NSArray *) getScrollMenuTitles
{
     return @[@"可用优惠券",@"不可用优惠券"];
}
-(void) viewWillAppear:(BOOL)animated
{
     [super viewWillAppear:animated];
     //       [self scrollMenu].selectedIndex = 1;
//     [self setTableView];
//     if (!isFirstAppear) {
//          //        [self reloadData];
//     }
//     isFirstAppear = NO;
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

//-(UIScrollView *)scrollView
//{
//     return self.ScrollViewOrder;
//}

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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
     NSInteger count = 1;
     return count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
     NSInteger count = 0;
     if (_tableViewA == tableView) {
          count = _tableViewA.dataArr.count;
     }else if(tableView == _tableViewB){
          count = _tableViewB.dataArr.count;
     }
     return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
     UITableViewCell *cell;
     cell = [self createOrderCell: indexPath withTableView:tableView];
     return cell;
}

-(UITableViewCell *)createOrderCell:(NSIndexPath *)indexPath withTableView:(MyTableView *)_tableView
{
     UITableViewCell *cell;
     cell = [CouponTableViewCell dequeueReusableCell:_tableView];
     BUOrderCoupon *c = _tableView.dataArr[indexPath.row];
     if (_tableView == self.tableViewA) {
          NSDictionary *dic = [c getDic];//@{@"aTitle":@"¥20",@"bTitle":@"满100元可用",@"cTitle":@"全品类通用券",@"dTitle":@"适用平台：全平台",@"eTitle":@"有效期至：2018-08-01",@"bgImg":@"couponBg"};
               [(JYAbstractTableViewCell *)cell setCellData:dic];
          if ([_coupon.couLogId isEqualToString:c.couLogId]) {
               [(CouponTableViewCell *)cell fitSelectCouponMode:YES];
          }else{
               [(CouponTableViewCell *)cell fitSelectCouponMode:NO];
          }
     }
     else if(_tableView == _tableViewB)
     {
          NSDictionary *dic = @{};
          [(JYAbstractTableViewCell *)cell setCellData:dic];
          [(CouponTableViewCell *)cell fitSelectCouponMode];
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
     CGFloat height = 85;
     return height;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
     return 0.001;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
     return nil;
}
//行的选择
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
     [tableView deselectRowAtIndexPath:indexPath animated:NO];
     if (tableView == _tableViewA) {

          BUOrderCoupon *c = _tableViewA.dataArr[indexPath.row];
          if (![c.couLogId isEqualToString:_coupon.couLogId]) {
               _coupon = c;
               [_tableViewA reloadData];
          }else{
               _coupon = [BUOrderCoupon new];
               [_tableViewA reloadData];
          }

     }
}
#pragma mark --handle

-(void) handleChangeOrderType:(id) sender
{
     XHMenu *menu = (XHMenu *) sender;
     NSInteger index = menu.index;
     currentOrderStatue = index ;
     [self menuSelectedIndex:currentOrderStatue];
     //    HUDSHOW(LoadingHintString);
     //    [self.dataModel getMyOrderList:currentOrderStatue  observer:self callback:@selector(getMyOrderListOutput:)];
}




#pragma mark --notification



-(void) getMyOrderListOutput:(BSNotification *) noti
{
     if (noti.error.code != -1) {
          MyTableView *tv = (MyTableView *)self.scrollViewList[currentOrderStatue];
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
