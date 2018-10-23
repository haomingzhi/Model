//
//  MyCouponViewController.m
//  oranllcshoping
//
//  Created by air on 2017/7/26.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import "MyCouponViewController.h"
#import "CouponTableViewCell.h"
#import "CouponInfoViewController.h"
#import "CouponRuleViewController.h"
#import "GetCouponCenterViewController.h"
#import "BUSystem.h"
@interface MyCouponViewController ()
//@property (strong, nonatomic) IBOutlet MyTableView *tableView;

@end

@implementation MyCouponViewController
{
     XHScrollMenuHelper *scrollMenuHelper;
     NSInteger currentOrderStatue;
     NSMutableArray *headViews;
     BOOL isFirstAppear;
     NSInteger _requestCount;
}

-(void) myViewDidLoad
{
     [self setMainVc:self];
     currentOrderStatue = 0;
      self.tabView.width = __SCREEN_SIZE.width;
     scrollMenuHelper = [[XHScrollMenuHelper alloc] init];
     [self.tabView addSubview: [scrollMenuHelper scrollMenuWithTitleAndFrame:CGRectMake(0, 0, self.tabView.frame.size.width, self.tabView.frame.size.height) titles:[self getScrollMenuTitles] target:self action:@selector(handleChangeOrderType:)]];
     [self scrollMenu].selectedIndex = 0;
     [self.tabView layoutIfNeeded];
     UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 39.5, __SCREEN_SIZE.width, 0.5)];
     line.backgroundColor = kUIColorFromRGB(color_lineColor);
     [self.view addSubview:line];
     [self initTableView:_tableViewA];
     [self initTableView:_tableViewB];
     [self initTableView:_tableViewC];
//     [self initTableView:_tableViewD];
     //     [self initTableView:_tableViewE];
     [super myViewDidLoad];
     
}

-(void)getData{

     _requestCount++;
     [busiSystem.myPathManager.getMyCouponUnUseManager getMyCoupon:self callback:@selector(getCouponListANotification:)];

     _requestCount++;
  [busiSystem.myPathManager.getMyCouponUsedManager getMyCoupon:self callback:@selector(getCouponListNotification:)];
   _requestCount++;
  [busiSystem.myPathManager.getMyCouponPassedManager getMyCoupon:self callback:@selector(getCouponListANotificationC:)];

}



-(void)getCouponListNotification:(BSNotification *)noti{
     _requestCount --;
     if (_requestCount == 0) {
          HUDDISMISS;
     }

     if (noti.error.code == 0) {
          _tableViewB.dataArr = [NSMutableArray arrayWithArray:busiSystem.myPathManager.getMyCouponUsedManager.getMyCouponArr];
            _tableViewB.hasMore = busiSystem.myPathManager.getMyCouponUsedManager.pageInfo.hasMore;
          [_tableViewB reloadData];
          [[JYNoDataManager manager] addNodataView:_tableViewB withTip:@"暂无信息" withImg:@"nodata" withCount:_tableViewB.dataArr.count withTag:[NSString stringWithFormat:@"favc%d",_tableViewB.tag]];
          [[JYNoDataManager manager] fitModeY:130 ];
     }else{
          HUDCRY(noti.error.domain, 2);
     }

}

-(void)getCouponListANotificationC:(BSNotification *)noti{
     _requestCount --;
     if (_requestCount == 0) {
          HUDDISMISS;
     }

     if (noti.error.code == 0) {
          _tableViewC.dataArr = [NSMutableArray arrayWithArray:busiSystem.myPathManager.getMyCouponPassedManager.getMyCouponArr];
            _tableViewC.hasMore = busiSystem.myPathManager.getMyCouponPassedManager.pageInfo.hasMore;
          [_tableViewC reloadData];
          [[JYNoDataManager manager] addNodataView:_tableViewC withTip:@"暂无信息" withImg:@"nodata" withCount:_tableViewC.dataArr.count withTag:[NSString stringWithFormat:@"favc%d",_tableViewC.tag]];
          [[JYNoDataManager manager] fitModeY:130 ];
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
          _tableViewA.dataArr = [NSMutableArray arrayWithArray:busiSystem.myPathManager.getMyCouponUnUseManager.getMyCouponArr];
            _tableViewA.hasMore = busiSystem.myPathManager.getMyCouponUnUseManager.pageInfo.hasMore;
          [_tableViewA reloadData];
          [[JYNoDataManager manager] addNodataView:_tableViewA withTip:@"暂无信息" withImg:@"nodata" withCount:_tableViewA.dataArr.count withTag:[NSString stringWithFormat:@"favc%d",_tableViewA.tag]];
          [[JYNoDataManager manager] fitModeY:130 ];
     }else{
          HUDCRY(noti.error.domain, 2);
     }

}

-(void)initTableView:(MyTableView *)tb
{
     tb.refreshHeaderView = nil;
     
     [CouponTableViewCell registerTableViewCell:tb];
     //     [TitleDetailTableViewCell registerTableViewCell:tb];
}

-(void)handleReturnBack:(id)sender
{
     [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
     self.scrollViewList = @[self.tableViewA,self.tableViewB,self.tableViewC];
     for (int i = 0; i < self.scrollViewList.count; i ++) {
          UITableView *tb = (UITableView *)self.scrollViewList[i];
          tb.backgroundColor = kUIColorFromRGB(color_0xf0f0f0);
          [self.scrollView addSubview:tb];
     }
     [super viewDidLoad];
     isFirstAppear = YES;
     self.title = @"我的优惠券";
     [self setNavigateRightButton:@"去领券" font:[UIFont systemFontOfSize:13] color:kUIColorFromRGB(color_0xb0b0b0)];
     //    self.dataModel.currentMyOrder = NULL;
     HUDSHOW(@"加载中");
     [self getData];
}

-(void)handleDidRightButton:(id)sender
{
     GetCouponCenterViewController *vc = [GetCouponCenterViewController new];
     [self.navigationController pushViewController:vc animated:YES];
     [vc setHandleGoBack:^(id userData) {
          [self getData];
     }];
}

-(NSArray *) getScrollMenuTitles
{
     return @[@"未使用",@"已使用",@"已过期"];
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
     [[self scrollMenu] setSelectedIndex:0 animated:NO calledDelegate:YES];
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
     NSInteger count = 1;
     return count;
}

- (NSInteger)tableView:(MyTableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
     NSInteger count = tableView.dataArr.count;
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
               BUGetMyCoupon *o = _tableView.dataArr[indexPath.row];
     if (_tableView == self.tableViewA) {

//          BUMyCoupon *p = _tableViewA.dataArr[indexPath.row];
//           p.mode = 0;
//     NSDictionary *dic = @{@"aTitle":@"¥60",@"bTitle":[NSString stringWithFormat:@"满100元可用"],@"cTitle":[NSString stringWithFormat:@"全品类通用券"],@"dTitle":@"适用平台：全平台",@"eTitle":@"有效期至：2017-08-01",@"bgImg":@"coupon_bg"};//[o getDicB];
          NSDictionary *dic = [o getDic:0];
     [(JYAbstractTableViewCell *)cell setCellData:dic];
     [(CouponTableViewCell *)cell fitMode];
     }
     else if(_tableView == _tableViewB)
     {
//           BUMyCoupon *p = _tableViewB.dataArr[indexPath.row];
//           p.mode = 1;
//          NSDictionary *dic = @{@"aTitle":@"¥60",@"bTitle":[NSString stringWithFormat:@"满100元可用"],@"cTitle":[NSString stringWithFormat:@"全品类通用券"],@"dTitle":@"适用平台：全平台",@"eTitle":@"有效期至：2017-08-01",@"bgImg":@"coupon_bg2",@"markImg":@"couponUsed"};;//[o getDicB];
          NSDictionary *dic = [o getDic:1];
          [(JYAbstractTableViewCell *)cell setCellData:dic];
          [(CouponTableViewCell *)cell fitModeB];
     }
     else
     {
//           BUMyCoupon *p = _tableViewC.dataArr[indexPath.row];
//          p.mode = 2;
//          NSDictionary *dic = @{@"aTitle":@"¥60",@"bTitle":[NSString stringWithFormat:@"满100元可用"],@"cTitle":[NSString stringWithFormat:@"全品类通用券"],@"dTitle":@"适用平台：全平台",@"eTitle":@"有效期至：2017-08-01",@"bgImg":@"coupon_bg2",@"markImg":@"couponPassed"};;//[o getDicB];
          NSDictionary *dic = [o getDic:2];
          [(JYAbstractTableViewCell *)cell setCellData:dic];
          [(CouponTableViewCell *)cell fitModeC];
     }
     cell.selectionStyle = UITableViewCellSelectionStyleNone;
     return  cell;
}


#pragma mark --UITableViewDelegate

//设置section头的高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
     return 6;
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
//     CouponInfoViewController *vc = [CouponInfoViewController new];
//     [self.navigationController pushViewController:vc animated:YES];
//     self.tabBarController.selectedIndex = 0;
//     [self.navigationController popToRootViewControllerAnimated:YES];
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

-(void) reloadData
{
    MyTableView *tv = (MyTableView *)self.scrollViewList[currentOrderStatue];
//    tv.hasMore = self.dataModel.pageinfo.hasMore;
    if (self.dataSource == NULL || self.dataSource.count ==0) {
        tv.tableHeaderView = headViews[currentOrderStatue];
    }
    else {
        tv.tableHeaderView = NULL;
    }
    [self menuSelectedIndex:currentOrderStatue];
    [((UITableView *)self.scrollViewList[currentOrderStatue]) reloadData];
}

-(BUGetMyCouponManager *) dataModel
{
     if(currentOrderStatue == 0)
    return busiSystem.myPathManager.getMyCouponUnUseManager;
     else if (currentOrderStatue == 1)
     {
          return busiSystem.myPathManager.getMyCouponUsedManager;
     }
     else
     {
          return busiSystem.myPathManager.getMyCouponPassedManager;
     }
}

-(BUGetMyCouponManager *) dataModel:(MyTableView *)tv
{
     if(tv == _tableViewA)
          return busiSystem.myPathManager.getMyCouponUnUseManager;
     else if (tv == _tableViewB)
     {
          return busiSystem.myPathManager.getMyCouponUsedManager;
     }
     else
     {
          return busiSystem.myPathManager.getMyCouponPassedManager;
     }
}

#pragma mark --handle

//-(void) handleGoShopping:(id) sender
//{
//    self.tabBarController.selectedViewController = self.tabBarController.viewControllers[2];
//}

#pragma mark --page
-(void)refreshCurentPage
{

      MyTableView *tv = (MyTableView *)self.scrollViewList[currentOrderStatue];
        tv.isRefreshing = YES;
        [self.dataModel getMyCoupon:self callback:@selector(getMyOrderList2Output:) extraInfo:@{@"view":tv}];
}

-(void) getMyOrderList2Output:(BSNotification *) noti
{
     MyTableView *tv = noti.extraInfo[@"view"];
         [self refreshTableHeaderNotification:noti myTableView:tv];
         BASENOTIFICATION(noti);
         [self reloadData];
 tv.isRefreshing = NO;
}

-(void) loadNextPage
{
      MyTableView *tv = (MyTableView *)self.scrollViewList[currentOrderStatue];
     [self.dataModel getDataNextPage:self callback:@selector(getDataNextPageNotification:) extraInfo:@{@"view":tv}];
}

-(void)getDataNextPageNotification:(BSNotification *)noti
{
     if (noti.error.code == 0) {
          MyTableView *tv = noti.extraInfo[@"view"];
          tv.dataArr = [NSMutableArray arrayWithArray:[self dataModel:tv].getMyCouponArr];
          tv.hasMore = [self dataModel:tv].pageInfo.hasMore;
          [tv reloadData];
          [[JYNoDataManager manager] addNodataView:tv withTip:@"暂无信息" withImg:@"nodata" withCount:tv.dataArr.count withTag:[NSString stringWithFormat:@"favc%d",tv.tag]];
          [[JYNoDataManager manager] fitModeY:130 ];
     }else{
          HUDCRY(noti.error.domain, 2);
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
