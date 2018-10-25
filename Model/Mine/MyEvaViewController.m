//
//  MyEvaViewController.m
//  oranllcshoping
//
//  Created by air on 2017/7/26.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import "MyEvaViewController.h"
#import "ImgAndThreeTitleTableViewCell.h"
#import "PublishEvaViewController.h"
//#import "EvaRuleViewController.h"
//#import "GoodsInfoViewController.h"
#import "ImgAndThreeTitleTableViewCell.h"
#import "ImgsTableViewCell.h"
#import "OnlyTitleTableViewCell.h"
#import "ThreeTitleAndImgTableViewCell.h"
//#import "EvaluateInfoViewController.h"
#import "BUSystem.h"
@interface MyEvaViewController ()
//@property (strong, nonatomic) IBOutlet MyTableView *tableView;

@end

@implementation MyEvaViewController
{
     XHScrollMenuHelper *scrollMenuHelper;
     NSInteger currentOrderStatue;
     NSMutableArray *headViews;
     BOOL isFirstAppear;
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
//     [self initTableView:_tableViewC];
//     [self initTableView:_tableViewD];
     //     [self initTableView:_tableViewE];
     [super myViewDidLoad];
     
}

-(void)getData
{
     if (currentOrderStatue == 0) {
//           [busiSystem.myPathManager orderMsgList:@"0" withUserid:busiSystem.agent.userId observer:self callback:@selector(orderMsgListNotification:)  extraInfo:@{@"tabv":_tableViewA}];
     }else
     {
//[busiSystem.myPathManager orderMsgList:@"1" withUserid:busiSystem.agent.userId observer:self callback:@selector(orderMsgListNotification:)  extraInfo:@{@"tabv":_tableViewB}];
     }

}

-(void)orderMsgListNotification:(BSNotification *)noti
{
     if (noti.error.code == 0) {
//          HUDDISMISS;
          MyTableView *tableView = noti.extraInfo[@"tabv"];
          NSString *tag = @"xxcc1";
          if (tableView == _tableViewA) {
//               tableView.dataArr = [NSMutableArray arrayWithArray:busiSystem.myPathManager.orderMsgList];
//               tableView.hasMore = busiSystem.getOrderListManager.pageInfo.hasMore;
          }
          else
          {
               tag = @"xxcc2";
//               tableView.dataArr = [NSMutableArray arrayWithArray:busiSystem.myPathManager.orderMsgList];
//               tableView.hasMore = busiSystem.getAfterSaleListManager.pageInfo.hasMore;
          }
          [tableView reloadData];
[self fitMenuData:self.tableViewA.dataArr.count withB:self.tableViewB.dataArr.count];
          [[JYNoDataManager manager] addNodataView:tableView withTip:@"暂无信息" withImg:@"nodata" withCount:tableView.dataArr.count withTag:tag];
          [[JYNoDataManager manager] fitModeY:150];
     }
     else
     {

//          HUDCRY(noti.error.domain, 1);
     }
}
-(void)initTableView:(MyTableView *)tb
{
     tb.refreshHeaderView = nil;
     
     [ImgAndThreeTitleTableViewCell registerTableViewCell:tb];
     [ImgsTableViewCell registerTableViewCell:tb];
     [OnlyTitleTableViewCell registerTableViewCell:tb];
     [ThreeTitleAndImgTableViewCell registerTableViewCell:tb];
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
     self.title = @"我的评价";
//     HUDSHOW(@"加载中");
     [self getData];
//     [busiSystem.myPathManager orderMsgList:@"1" withUserid:busiSystem.agent.userId observer:self callback:@selector(orderMsgListNotification:)  extraInfo:@{@"tabv":_tableViewB}];
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshMyEvaData) name:@"refreshMyEvaData" object:nil];
//     [self setNavigateRightButton:@"nav_que"];
     //    self.dataModel.currentMyOrder = NULL;
}
-(void)dealloc
{
     [[NSNotificationCenter defaultCenter] removeObserver:self];
}
-(void)refreshMyEvaData
{
//      HUDSHOW(@"加载中");
     [self getData];
}

-(void)handleDidRightButton:(id)sender
{
//     EvaRuleViewController *vc = [EvaRuleViewController new];
//     [self.navigationController pushViewController:vc animated:YES];
}

-(NSArray *) getScrollMenuTitles
{
     return @[@"待评价 ",@"已评价 "];
}
-(void) viewWillAppear:(BOOL)animated
{
     [super viewWillAppear:animated];
     //       [self scrollMenu].selectedIndex = 1;
     [self setTableView];
     if (isFirstAppear) {
          //        [self reloadData];
            [[self scrollMenu] setSelectedIndex:0 animated:NO calledDelegate:YES];
     }
     isFirstAppear = NO;
}

//-(void) viewDidAppear:(BOOL)animated
//{
//     //    if (self.dataModel.currentMyOrder != NULL) {
//     //        if (currentOrderStatue != [self.dataModel.currentMyOrder.status integerValue]) {
//     //            currentOrderStatue = [self.dataModel.currentMyOrder.status integerValue];
//   
//     //        }
//     //
//     //    }
//}

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


-(void)fitMenuData:(NSInteger)a withB:(NSInteger)b
{
     UIButton *btn = [self.scrollMenu viewWithTag:100+ 0];
     [btn setTitle:[NSString stringWithFormat:@"待评价 %ld",a] forState:UIControlStateNormal];

     UIButton *btn2 = [self.scrollMenu viewWithTag:100+ 1];
     [btn2 setTitle:[NSString stringWithFormat:@"已评价 %ld",b] forState:UIControlStateNormal];
}


#pragma mark --UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(MyTableView *)tableView
{
     NSInteger count = tableView.dataArr.count;
//     if(tableView == self.tableViewB)
//     {
//          count = 4;
//     }
     return count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
     NSInteger count = 4;
     if(tableView == self.tableViewB)
     {
          count = 4;
     }
     else
     {
          count = 1;
     }
     return count;
}

- (UITableViewCell *)tableView:(MyTableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
     UITableViewCell *cell;
     if (self.tableViewA == tableView) {
           cell = [self createOrderCell: indexPath withTableView:tableView];
     }
    else
    {
      cell = [self createEvaCell: indexPath withTableView:tableView];
    }
     return cell;
}

-(UITableViewCell *)createOrderCell:(NSIndexPath *)indexPath withTableView:(MyTableView *)tableView
{
     UITableViewCell *cell;
//     BUOrderMsg *om = tableView.dataArr[indexPath.section];
     cell = [ImgAndThreeTitleTableViewCell dequeueReusableCell:tableView];
     //          BUGetOrder *o = _tableView.dataArr[indexPath.section];
//     NSDictionary *dic = [om getDic];//@{@"title":@"日式色织水洗棉床笠",@"source":[NSString stringWithFormat:@"128G/黑红色"],@"time":[NSString stringWithFormat:@"500.00元/月"],@"default":@"default"};;//[o getDicB];
//     [(JYAbstractTableViewCell *)cell setCellData:dic];
     [(ImgAndThreeTitleTableViewCell *)cell fitMyEvaMode];
     [(ImgAndThreeTitleTableViewCell*)cell setHandleAction:^(id o){
          PublishEvaViewController *vc= [PublishEvaViewController new];
//          BUGetOrder *ow = [BUGetOrder new];
//          ow.orderID = om.orderId;
//          vc.order = ow;
//          [vc setHandleGoBack:^(id userData) {
//               [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshMyEvaData" object:nil];
//          }];
          [self.navigationController pushViewController:vc animated:YES];
     }];
//     [(JYAbstractTableViewCell*)cell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(135, 0, 0, 0)];
          cell.selectionStyle = UITableViewCellSelectionStyleNone;
     return  cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
     if (_tableViewA == tableView) {
          if (_tableViewA.dataArr.count - 1 == section) {
               return 0.001;
          }
          return 10;
     }
     return 15;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{if (_tableViewA == tableView) {
     if (_tableViewA.dataArr.count - 1 == section) {
          return nil;
     }
     return [self createSectionFootView:section withTableView:tableView];
}
return nil;
}

-(UIView *)createSectionFootView:(NSInteger)section withTableView:(UITableView *)tableView
{
     UIView *v = [tableView viewWithTag:9887 + section];
     if (!v) {
          v = [UIView new];
          v.tag = 9887 + section;
     }
     v.height = 10;
     UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 9.5, __SCREEN_SIZE.width, 0.5)];
     line.backgroundColor = kUIColorFromRGB(color_lineColor);
     v.backgroundColor = kUIColorFromRGB(color_f8f8f8);

//     [v addSubview:line];

     return v;
}
-(UITableViewCell *)createEvaCell:(NSIndexPath *)indexPath withTableView:(MyTableView *)tableView
{
//       BUOrderMsg *om = tableView.dataArr[indexPath.section];
     UITableViewCell *cell;
     if (indexPath.row == 0) {
          cell =[ImgAndThreeTitleTableViewCell dequeueReusableCell:tableView];
//          NSDictionary *dic = [om getDic:indexPath.row];//@{@"title":@"winder",@"source":@"学生/深圳",@"img":@"icon_header_eva"}
//          [(ImgAndThreeTitleTableViewCell *)cell setCellData:dic];
         [(ImgAndThreeTitleTableViewCell *)cell   fitMyEvaModeC];
     }
     else if (indexPath.row == 2)
     {
//           NSDictionary *dic = [om getDic:indexPath.row];//@{@"arr":@[@"dog",@"dog",@"dog"]}
          cell = [ImgsTableViewCell dequeueReusableCell:tableView];
//          [(ImgsTableViewCell *)cell setCellData:dic];
          [(ImgsTableViewCell *)cell fitTopicMode];
        
     }
     else if(indexPath.row == 3)
     {
//         NSDictionary *dic = [om getDic:indexPath.row];// @{@"title":@"拿来看也没看就洗了，发现有些不对劲，吊牌都没有，洗的时 候还有泡沫，细看领口有一处缝补的痕迹，虽然是特价买的……"}
          cell = [OnlyTitleTableViewCell dequeueReusableCell:tableView];
//          [(OnlyTitleTableViewCell *)cell setCellData:dic];
          [(OnlyTitleTableViewCell *)cell fitEvaModeD];
//            [(JYAbstractTableViewCell*)cell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(52, 0, 0, 0)];
     }
     else if(indexPath.row == 1)
     {
//          NSDictionary *dic = [om getDic:indexPath.row];// @{@"title":@"银色银色进行奖学金",@"source":@"肤色/M",@"time":@"已好评，供货50优币",@"img":@"dog"}
          cell = [ImgAndThreeTitleTableViewCell dequeueReusableCell:tableView];
//          [(ImgAndThreeTitleTableViewCell*)cell setCellData:dic ];
             [(ImgAndThreeTitleTableViewCell*)cell fitMyEvaModeB];
//           [(JYAbstractTableViewCell*)cell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(101, 0, 0, 0)];
     }
     else
     {
          cell = [ThreeTitleAndImgTableViewCell dequeueReusableCell:tableView];
          [(ThreeTitleAndImgTableViewCell *)cell setCellData:@{@"titleA":@"1000",@"titleB":@"一周前",@"titleC":@"1000"}];
          [(ThreeTitleAndImgTableViewCell *)cell fitTopicMode];
          [(JYAbstractTableViewCell *)cell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(31, 0, 0, 0)];
          [(ThreeTitleAndImgTableViewCell*)cell setHandleAction:^(NSDictionary *dic){
               UIButton *btn = dic[@"obj"];
               NSInteger index =  btn.tag - 3000;
               switch (index) {
                    case 0:
                    {
                         
                    }
                         break;
                    case 1:
                    {
//                         EvaluateInfoViewController *vc = [EvaluateInfoViewController new];
//                         [self.navigationController pushViewController:vc animated:YES];
                    }
                         break;
                    default:
                         break;
               }
          }];
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
     CGFloat height = 135;
     if(tableView == self.tableViewB)
     {
          if (indexPath.row == 0) {
               height = 52;
          }
          else if (indexPath.row == 2)
          {
//               BUOrderMsg *om = tableView.dataArr[indexPath.section];
//                CGFloat cheight = 100;
//               NSInteger count = om.imgList.count;
//               height = ((cheight + 10) * ((count + 2)/3));
          }
          else if(indexPath.row == 3)
          {
               height = 52;
          }
          else if(indexPath.row == 1)
          {
               height = 101;
          }
          else
          {
               height = 31;
          }
               
     }
     return height;
}
//-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
//{
//     if (tableView == self.tableViewA) {
//          return 0.001;
//     }
//     return 15;
//}
//
//-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
//{
////     if(tableView == self.tableViewB)
//          return [self createSectionFootView:section withTableView:tableView];
////     return nil;
//}
//-(UIView *)createSectionFootView
//{
//     UIView *v = [UIView new];
//     v.height = 10;
//     UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 9.5, __SCREEN_SIZE.width, 0.5)];
//     line.backgroundColor = kUIColorFromRGB(color_lineColor);
//     v.backgroundColor = kUIColorFromRGB(color_0xf0f0f0);
//     line.tag = 9887;
//     [v addSubview:line];
//     return v;
//}
//行的选择
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
     [tableView deselectRowAtIndexPath:indexPath animated:NO];
//     GoodsInfoViewController *vc = [GoodsInfoViewController new];
//     [self.navigationController pushViewController:vc animated:YES];

}
#pragma mark --handle

-(void) handleChangeOrderType:(id) sender
{
     XHMenu *menu = (XHMenu *) sender;
     NSInteger index = menu.index;
     currentOrderStatue = index ;
     [self menuSelectedIndex:currentOrderStatue];
//     HUDSHOW(@"加载中");
     [self getData];
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
@end
