//
//  MyRunViewController.m
//  intelligentgarbagecollection
//
//  Created by air on 2017/12/6.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import "MyRunViewController.h"
#import "OnlyBottomBtnTableViewCell.h"
#import "TitleDetailTableViewCell.h"
#import "ImgAndThreeTitleTableViewCell.h"
#import "OnlyTitleTableViewCell.h"
#import "BUSystem.h"
@interface MyRunViewController ()
{
     UILabel *_myInComeLb;
}
@end

@implementation MyRunViewController
-(id)init
{
     self = [super initWithNibName:@"MyOrderViewController" bundle:nil];
     return self;
}
- (void)viewDidLoad {
      [super viewDidLoad];
     self.scrollViewList = @[self.tableViewA,self.tableViewB,self.tableViewC];
     for (int i = 0; i < self.scrollViewList.count; i ++) {
          UITableView *tb = (UITableView *)self.scrollViewList[i];
          tb.backgroundColor = kUIColorFromRGB(color_0xf5f5f5);
          [self.scrollView addSubview:tb];
     }


     self.title = @"我的跑腿";
     [self fitMode];
}

-(void)getData
{
     [busiSystem.getCourierOrderListManager getList:busiSystem.agent.getUserIndex.courier.courierId?:@"" withType:[NSString stringWithFormat:@"%ld",self.currentOrderStatue  + 1] withStationId:busiSystem.agent.getUserIndex.courier.stationId?:@""  observer:self callback:@selector(getOrderListNotification:) extraInfo:@{@"type":@(self.currentOrderStatue)}];
//     [busiSystem.getOrderListManager getOrderList:busiSystem.agent.userId withOrderStatus:[NSString stringWithFormat:@"%ld",self.currentOrderStatue] withCourierId:busiSystem.agent.getUserIndex.courier.courierId?:@"" observer:self callback:@selector(getOrderListNotification:) extraInfo:@{@"type":@(self.currentOrderStatue)}];
}

-(void)getOrderListNotification:(BSNotification *)noti
{
     if (noti.error.code == 0) {
          HUDDISMISS;
          MyTableView *_curTableView;
          NSInteger type = [noti.extraInfo[@"type"] integerValue];
          if (type == 0) {
               _curTableView = self.tableViewA;

          }
          else if(type == 1)
          {
               _curTableView = self.tableViewB;
          }
          else if (type == 2)
          {
               _curTableView = self.tableViewC;
          }
          else
          {
               _curTableView = self.tableViewD;
          }
          _curTableView.dataArr = [NSMutableArray arrayWithArray:busiSystem.getCourierOrderListManager.dataArr];
          _curTableView.hasMore = busiSystem.getCourierOrderListManager.pageInfo.hasMore;
          [_curTableView reloadData];
          [[JYNoDataManager manager] addNodataView:_curTableView withTip:@"暂无信息" withImg:@"nodata" withCount:_curTableView.dataArr.count withTag:[NSString stringWithFormat:@"serShop%ld",type]];
          [[JYNoDataManager manager] fitModeY:150];
     }
     else
     {

          HUDCRY(noti.error.domain, 1);
     }
}
-(void)initTableView:(MyTableView *)tb
{
     tb.refreshHeaderView = nil;
     [OnlyBottomBtnTableViewCell registerTableViewCell:tb];
     [OnlyTitleTableViewCell registerTableViewCell:tb];
      [OnlyTitleTableViewCell registerTableViewCell:tb withTag:@"xxx"];
     [TitleDetailTableViewCell registerTableViewCell:tb];
}
-(void)viewWillAppear:(BOOL)animated
{
     [super viewWillAppear:animated];
     self.navigationController.navigationBar.shadowImage = nil;
}

-(void)viewWillDisappear:(BOOL)animated
{
     [super viewWillDisappear:animated];
     self.navigationController.navigationBar.shadowImage = [UIImage new];
}
-(void)fitMode
{

     UIView *hv = [UIView new];
     hv.height = 40;
     hv.width = __SCREEN_SIZE.width;
     hv.backgroundColor = kUIColorFromRGB(color_0xf5f5f5);
     UILabel *txtLb = [UILabel new];
     txtLb.textColor = kUIColorFromRGB(color_0xfd7400);
     txtLb.font = [UIFont systemFontOfSize:15];
     txtLb.text = [NSString stringWithFormat:@"我的收入:%.2f元",busiSystem.agent.getUserIndex.courier.income];
     _myInComeLb = txtLb;
     txtLb.attributedText = [txtLb richText:[UIFont systemFontOfSize:15] text:@"我的收入:" color:kUIColorFromRGB(color_1)];
     txtLb.height = 15;
     txtLb.width = __SCREEN_SIZE.width - 30;
     txtLb.y = 14;
     txtLb.x = 15;
     [hv addSubview:txtLb];
     hv.y = 35;
     [self.view addSubview:hv];
     UIView *hv2 = [UIView new];
     hv2.height = 40;
     hv2.width = __SCREEN_SIZE.width;
     self.tableViewA.tableHeaderView = hv2;

     UIView *hv3 = [UIView new];
     hv3.height = 40;
     hv3.width = __SCREEN_SIZE.width;
        self.tableViewB.tableHeaderView = hv3;

     UIView *hv4 = [UIView new];
     hv4.height = 40;
     hv4.width = __SCREEN_SIZE.width;
        self.tableViewC.tableHeaderView = hv4;
}
-(NSArray *) getScrollMenuTitles
{
     return @[@"待接单",@"待配送",@"已完成"];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)numberOfSectionsInTableView:(MyTableView *)tableView
{
     NSInteger count = tableView.dataArr.count;
     return count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
     NSInteger count = 6;
     if(self.tableViewC == tableView)
     {
          return 5;
     }
     return count;
}
- (CGFloat)tableView:(MyTableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
     CGFloat height = 44;

     if(indexPath.row == 0)
     {
          height = 40;
     }
     else  if(indexPath.row == 1)
     {
          height = 27;
     }
     else  if(indexPath.row == 2)
     {
//          UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
BUGetOrder *o = tableView.dataArr[indexPath.section];
          height = o.height;
     }
     else  if(indexPath.row == 3)
     {
          height = 19;
     }
     else  if(indexPath.row == 4)
     {
          height = 27;
     }
     else
     {
          height = 71;
     }
     return height;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
     if(tableView == self.tableViewC)
          return 10;
     return 0.0001;
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
     else
     {
          cell = [self createThreeOrderCell: indexPath withTableView:tableView];
     }

     return cell;
}

-(UITableViewCell *)createOneOrderCell:(NSIndexPath *)indexPath withTableView:(MyTableView *)tableView
{
       BUGetOrder *o = tableView.dataArr[indexPath.section];
     UITableViewCell *cell;
     if (indexPath.row == 0) {
          cell = [TitleDetailTableViewCell dequeueReusableCell:tableView];
          //          BUGetOrder *o = _tableView.dataArr[indexPath.section];
          NSDictionary *dic =  [o getRunDic:indexPath.row];//@{@"title":@"订单编号：012345668",@"detail":@"查看订单详情"};//[o getDicA];
          [(JYAbstractTableViewCell *)cell setCellData:dic];
          [(TitleDetailTableViewCell *)cell fitMyRunMode];
          [(JYAbstractTableViewCell*)cell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(40, 0, 0, 0)];
     }
     else if (indexPath.row == 1)
     {
          cell = [OnlyTitleTableViewCell dequeueReusableCell:tableView];
           NSDictionary *dic = [o getRunDic:indexPath.row];
          [(OnlyTitleTableViewCell*)cell setCellData:dic];
     [(OnlyTitleTableViewCell*)cell fitMyRunMode];
     }
     else if (indexPath.row == 2)
     {
          cell = [OnlyTitleTableViewCell dequeueReusableCell:tableView];
          NSDictionary *dic = [o getRunDic:indexPath.row];//@{@"title":@"收货地址：福州市台江区曙光支路世纪百联7楼桔 子科技"};
          [(OnlyTitleTableViewCell*)cell setCellData:dic];

               [(OnlyTitleTableViewCell*)cell fitMyRunModeB];
             o.height = cell.height;
     }
     else if (indexPath.row == 3)
     {
          cell = [OnlyTitleTableViewCell dequeueReusableCell:tableView];
          NSDictionary *dic = [o getRunDic:indexPath.row];// @{@"title":@"联系电话：13712345678"};
          [(OnlyTitleTableViewCell*)cell setCellData:dic];
          [(OnlyTitleTableViewCell*)cell fitMyRunModeD];
          [(OnlyTitleTableViewCell*)cell setHandleAction:^(id sender) {
               [BSUtility callPhone:o.telephone view:nil];
          }];
     }
     else if (indexPath.row == 4)
     {
          cell = [OnlyTitleTableViewCell dequeueReusableCell:tableView];
          NSDictionary *dic = [o getRunDic:indexPath.row];//@{@"title":@"下单时间：2016-09-28 18:23"};
          [(OnlyTitleTableViewCell*)cell setCellData:dic];
               [(OnlyTitleTableViewCell*)cell fitMyRunModeC];
     }
     else
     {
           o.hasRecv = NO;
          cell = [OnlyBottomBtnTableViewCell dequeueReusableCell:tableView];
          //          BUGetOrder *o = _tableView.dataArr[indexPath.section];
          NSDictionary *dic = [o getRunDic:indexPath.row];//@{@"title":@"马上接单"};//[o getDicC];
          [(JYAbstractTableViewCell *)cell setCellData:dic];
//          BUGetOrder *o = [BUGetOrder new];
//          o.orderType = 0;
//          [self toFitOption:o withCell:(OnlyBottomBtnTableViewCell *)cell withTableView:tableView];
          [(OnlyBottomBtnTableViewCell *)cell fitMyRunMode];
           [self setCellToFitHandle:(OnlyBottomBtnTableViewCell *)cell withOrder:o];
//          [(JYAbstractTableViewCell*)cell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(44, 0, 0, 0)];
     }
     cell.selectionStyle = UITableViewCellSelectionStyleNone;
     return  cell;
}

-(UITableViewCell *)createTwoOrderCell:(NSIndexPath *)indexPath withTableView:(MyTableView *)tableView
{
     BUGetOrder *o = tableView.dataArr[indexPath.section];
     UITableViewCell *cell;
     if (indexPath.row == 0) {
          cell = [TitleDetailTableViewCell dequeueReusableCell:tableView];
          //          BUGetOrder *o = _tableView.dataArr[indexPath.section];
          NSDictionary *dic = [o getRunDic:indexPath.row];//@{@"title":@"订单编号：012345668",@"detail":@"查看订单详情"};//[o getDicA];
          [(JYAbstractTableViewCell *)cell setCellData:dic];
          [(TitleDetailTableViewCell *)cell fitMyRunMode];
          [(JYAbstractTableViewCell*)cell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(40, 0, 0, 0)];
     }
     else if (indexPath.row == 1)
     {
          cell = [OnlyTitleTableViewCell dequeueReusableCell:tableView];
          NSDictionary *dic = [o getRunDic:indexPath.row];//@{@"title":@"收货人：张三"};
          [(OnlyTitleTableViewCell*)cell setCellData:dic];
          [(OnlyTitleTableViewCell*)cell fitMyRunMode];
     }
     else if (indexPath.row == 2)
     {
          cell = [OnlyTitleTableViewCell dequeueReusableCell:tableView];
          NSDictionary *dic = [o getRunDic:indexPath.row];//@{@"title":@"收货地址：福州市台江区曙光支路世纪百联7楼桔 子科技"};
          [(OnlyTitleTableViewCell*)cell setCellData:dic];
          [(OnlyTitleTableViewCell*)cell fitMyRunModeB];
             o.height = cell.height;
     }
     else if (indexPath.row == 3)
     {
          cell = [OnlyTitleTableViewCell dequeueReusableCell:tableView];
          NSDictionary *dic = [o getRunDic:indexPath.row];//@{@"title":@"联系电话：13712345678"};
          [(OnlyTitleTableViewCell*)cell setCellData:dic];
          [(OnlyTitleTableViewCell*)cell fitMyRunModeD];
          [(OnlyTitleTableViewCell*)cell setHandleAction:^(id sender) {
               [BSUtility callPhone:o.telephone?:@"" view:nil];
          }];
     }
     else if (indexPath.row == 4)
     {
          cell = [OnlyTitleTableViewCell dequeueReusableCell:tableView];
          NSDictionary *dic = [o getRunDic:indexPath.row];//@{@"title":@"下单时间：2016-09-28 18:23"};
          [(OnlyTitleTableViewCell*)cell setCellData:dic];
          [(OnlyTitleTableViewCell*)cell fitMyRunModeC];
     }
     else
     {
          cell = [OnlyBottomBtnTableViewCell dequeueReusableCell:tableView];
          //          BUGetOrder *o = _tableView.dataArr[indexPath.section];
          o.hasRecv = YES;
          NSDictionary *dic = [o getRunDic:indexPath.row];//@{@"title":@"确认送达"};//[o getDicC];
          [(JYAbstractTableViewCell *)cell setCellData:dic];
//          BUGetOrder *o = [BUGetOrder new];
//          o.orderType = 0;
          //          [self toFitOption:o withCell:(OnlyBottomBtnTableViewCell *)cell withTableView:tableView];
          [(OnlyBottomBtnTableViewCell *)cell fitMyRunMode];
          [self setCellToFitHandle:cell withOrder:o];
          //          [(JYAbstractTableViewCell*)cell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(44, 0, 0, 0)];
     }
     cell.selectionStyle = UITableViewCellSelectionStyleNone;
     return  cell;
}

-(void) setCellToFitHandle:(OnlyTitleTableViewCell *)cell withOrder:(BUGetOrder*)o
{
     [cell setHandleAction:^(id sender) {
          [self confirm:o];
     }];
}

-(UITableViewCell *)createThreeOrderCell:(NSIndexPath *)indexPath withTableView:(MyTableView *)tableView
{
     BUGetOrder *o = tableView.dataArr[indexPath.section];
     UITableViewCell *cell;
     if (indexPath.row == 0) {
          cell = [TitleDetailTableViewCell dequeueReusableCell:tableView];
          //          BUGetOrder *o = _tableView.dataArr[indexPath.section];
          NSDictionary *dic = [o getRunDic:indexPath.row];//@{@"title":@"订单编号：012345668",@"detail":@"查看订单详情"};//[o getDicA];
          [(JYAbstractTableViewCell *)cell setCellData:dic];
          [(TitleDetailTableViewCell *)cell fitMyRunMode];
          [(JYAbstractTableViewCell*)cell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(40, 0, 0, 0)];
     }
     else if (indexPath.row == 1)
     {
          cell = [OnlyTitleTableViewCell dequeueReusableCell:tableView];
          NSDictionary *dic = [o getRunDic:indexPath.row];//@{@"title":@"收货人：张三"};
          [(OnlyTitleTableViewCell*)cell setCellData:dic];
          [(OnlyTitleTableViewCell*)cell fitMyRunMode];
     }
     else if (indexPath.row == 2)
     {
          cell = [OnlyTitleTableViewCell dequeueReusableCell:tableView];
          NSDictionary *dic = [o getRunDic:indexPath.row];//@{@"title":@"收货地址：福州市台江区曙光支路世纪百联7楼桔 子科技"};
          [(OnlyTitleTableViewCell*)cell setCellData:dic];
          [(OnlyTitleTableViewCell*)cell fitMyRunModeB];
             o.height = cell.height;
     }
     else if (indexPath.row == 3)
     {
          cell = [OnlyTitleTableViewCell dequeueReusableCell:tableView];
          NSDictionary *dic = [o getRunDic:indexPath.row];//@{@"title":@"联系电话：13712345678"};
          [(OnlyTitleTableViewCell*)cell setCellData:dic];
          [(OnlyTitleTableViewCell*)cell fitMyRunModeD];
          [(OnlyTitleTableViewCell*)cell setHandleAction:^(id sender) {
               [BSUtility callPhone:o.telephone?:@"" view:nil];
          }];
     }
     else if (indexPath.row == 4)
     {
          cell = [OnlyTitleTableViewCell dequeueReusableCell:tableView withTag:@"xxx"];
          NSDictionary *dic = [o getRunDic:indexPath.row];//@{@"title":@"下单时间：2016-09-28 18:23"};
          [(OnlyTitleTableViewCell*)cell setCellData:dic];
          [(OnlyTitleTableViewCell*)cell fitMyRunModeC];
             [(JYAbstractTableViewCell*)cell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(27, 0, 0, 0)];
     }
     else
     {
          cell = [OnlyBottomBtnTableViewCell dequeueReusableCell:tableView];
          //          BUGetOrder *o = _tableView.dataArr[indexPath.section];
          NSDictionary *dic = [o getRunDic:indexPath.row];//@{@"title":@"确认送达"};//[o getDicC];
          [(JYAbstractTableViewCell *)cell setCellData:dic];
//          BUGetOrder *o = [BUGetOrder new];
//          o.orderType = 0;
          //          [self toFitOption:o withCell:(OnlyBottomBtnTableViewCell *)cell withTableView:tableView];
          [(OnlyBottomBtnTableViewCell *)cell fitMyRunMode];

          //          [(JYAbstractTableViewCell*)cell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(44, 0, 0, 0)];
     }
     cell.selectionStyle = UITableViewCellSelectionStyleNone;
     return  cell;
}


-(void)loadNextPage
{
     [busiSystem.getCourierOrderListManager getListNextPage:self callback:@selector(getOrderListNotification:) extraInfo:@{@"type":@(self.currentOrderStatue)}];
}

-(void)confirm:(BUGetOrder*)order
{
     NSString *title = @"马上接单";
     if(order.hasRecv)
     {
          title = @"确认送达";
     }
       [[CommonAPI managerWithVC:self] showAlertView:nil withMsg:title withBtnTitle:@"确定"   withSel:@selector(toProcessResult:) withUserInfo:@{@"order":order}];
}
-(void)toProcessResult:(NSDictionary *)dic
{
     NSInteger tag = [dic[@"tag"] integerValue];
     if (tag == 100) {
          NSDictionary *userInfo = dic[@"userInfo"];
          BUGetOrder *od = userInfo[@"order"];
          [self orderConfirmbyCourier:od];
     }
}
-(void)orderConfirmbyCourier:(BUGetOrder*)o
{
     HUDSHOW(@"加载中");
     [busiSystem.getOrderListManager orderConfirmbyCourier:o.orderId withCourierid:busiSystem.agent.getUserIndex.courier.courierId?:@"" observer:self callback:@selector(orderConfirmbyCourierNotification:)];
}

-(void)orderConfirmbyCourierNotification:(BSNotification*)noti
{
     if (noti.error.code == 0) {
          [self getData];
          busiSystem.agent.isNeedRefreshTabD = YES;
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
