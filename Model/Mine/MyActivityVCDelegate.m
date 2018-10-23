//
//  MyActivityVCDelegate.m
//  taihe
//
//  Created by air on 2016/11/8.
//  Copyright © 2016年 ORANLLC_IOS1. All rights reserved.
//

#import "MyActivityVCDelegate.h"
#import "ImgTableViewCell.h"
#import "TitleDetailTableViewCell.h"
#import "OnlyTitleTableViewCell.h"
#import "BUSystem.h"
#import "ActivityInfoViewController.h"
@implementation MyActivityVCDelegate
{
    NSArray *_tipArr;
    NSInteger _requestCount;
}

-(id)init
{
    self = [super init];
    if (self) {
        self->_tipArr = @[@"暂无信息",@"暂无信息"];
    }
    return self;
}

-(void)initTableView:(MyTableView *)_tableView
{
    if (_tableView.tag == 100) {
        _tableView.refreshHeaderView =  [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0, 0, 1, 40)];
        _tableView.refreshHeaderView.delegate = self;
        _tableView.headHasMore = YES;
        _tableView.refreshFooterView = [[EGORefreshTableFooterView alloc] initWithFrame:CGRectMake(0, 0, 1, 40)];
        _tableView.refreshFooterView.showLoading = YES;
        _tableView.refreshFooterView.delegate = self;
        [ImgTableViewCell registerTableViewCell:_tableView];
        [OnlyTitleTableViewCell registerTableViewCell:_tableView];
        [TitleDetailTableViewCell registerTableViewCell:_tableView];

        _tableView.backgroundColor = kUIColorFromRGB(color_4);
    }
    else
    {
        _tableView.refreshHeaderView =  [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0, 0, 1, 40)];
        _tableView.refreshHeaderView.delegate = self;
        _tableView.headHasMore = YES;
        _tableView.refreshFooterView = [[EGORefreshTableFooterView alloc] initWithFrame:CGRectMake(0, 0, 1, 40)];
        _tableView.refreshFooterView.showLoading = YES;
        _tableView.refreshFooterView.delegate = self;
          [ImgTableViewCell registerTableViewCell:_tableView];
        [OnlyTitleTableViewCell registerTableViewCell:_tableView];
        [TitleDetailTableViewCell registerTableViewCell:_tableView];

        _tableView.backgroundColor = kUIColorFromRGB(color_4);
    }
}

-(void)getData:(MyTableView *)tableView
{
    
    if (tableView.tag == 100) {
        
        [self getMyActivityData:tableView];
    }
    else
    {
        [self getJoinActivity:tableView];
        
    }
}

-(void)getMyActivityData:(UITableView *)tableView
{
    _requestCount++;
    [busiSystem.getActivityManager getMyActivity:busiSystem.agent.sapid withTel:busiSystem.agent.tel observer:self callback:@selector(getMyActivityNotification:) extraInfo:@{@"tableView":tableView}];
}

-(void)getMyActivityNotification:(BSNotification *)noti
{
    _requestCount --;
    MyTableView *tableView = noti.extraInfo[@"tableView"];
    if (tableView.isRefreshing) {
        //  [_curTableView.refreshHeaderView setState:EGOPullRefreshNormal];
        [tableView.refreshHeaderView resetState:YES];
        [tableView.refreshFooterView setStatusText:@""];
        [tableView.refreshFooterView resetState:YES];
        [tableView setContentOffset:CGPointMake(0, 0) animated:YES];
        tableView.isRefreshing = NO;
    }
    if (_requestCount == 0) {
        BASENOTIFICATION(noti);
    }
    else
    {
    BASENOTIFICATIONWITHCANMISS(noti, NO);
    }
    //    NSArray *a = busiSystem.myTalkManager.pageData;
    if(tableView.dataSource)
    {
    tableView.dataArr = [NSMutableArray arrayWithArray:busiSystem.getActivityManager.activityData];
    
//    tableView.hasMore = busiSystem.myTalkManager.pageInfo.hasMore;
    [[JYNoDataManager manager] addNodataView:tableView withTip:_tipArr[0] withImg:@"nodata" withCount:tableView.dataArr.count withTag:[NSString stringWithFormat:@"myac%d",0]];
    [[JYNoDataManager manager] fitModeY:200];
    [tableView reloadData];
    }

}

-(void)getJoinActivity:(UITableView *)tableView
{
    _requestCount++;
    [busiSystem.getActivityManager getJoinActivity:busiSystem.agent.sapid withTel:busiSystem.agent.tel observer:self callback:@selector(getJoinActivityNotification:) extraInfo:@{@"tableView":tableView}];
}

-(void)getJoinActivityNotification:(BSNotification *)noti
{
    _requestCount--;
    MyTableView *tableView = noti.extraInfo[@"tableView"];
    if (tableView.isRefreshing) {
        //  [_curTableView.refreshHeaderView setState:EGOPullRefreshNormal];
        [tableView.refreshHeaderView resetState:YES];
        [tableView.refreshFooterView setStatusText:@""];
        [tableView.refreshFooterView resetState:YES];
        [tableView setContentOffset:CGPointMake(0, 0) animated:YES];
        tableView.isRefreshing = NO;
    }
    if (_requestCount == 0) {
        BASENOTIFICATION(noti);
    }
    else
    {
        BASENOTIFICATIONWITHCANMISS(noti, NO);
    }
    //    NSArray *a = busiSystem.myTalkManager.pageData;
    if(tableView.dataSource)
    {
    tableView.dataArr = [NSMutableArray arrayWithArray:busiSystem.getActivityManager.joinActivityData];
    
//    tableView.hasMore = busiSystem.myTalkManager.pageInfo.hasMore;
    [[JYNoDataManager manager] addNodataView:tableView withTip:_tipArr[0] withImg:@"nodata" withCount:tableView.dataArr.count withTag:[NSString stringWithFormat:@"Myjoinac%d",0]];
    [[JYNoDataManager manager] fitModeY:200];
    [tableView reloadData];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.001;
}
-(NSInteger)numberOfSectionsInTableView:(MyTableView *)tableView
{
     NSInteger row = 1;
    if (tableView.tag == 100) {
        row = tableView.dataArr.count;
    }
    else
    {
        row = tableView.dataArr.count;//12;
    }
    return row;
}

-(CGFloat)tableView:(MyTableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 44;
    if (tableView.tag == 100) {
        if(indexPath.row == 0)
        {
            height = 400/720.0 * __SCREEN_SIZE.width;
        }
        else if(indexPath.row == 1)
        {
            height = 35;
        }
        else if(indexPath.row == 2)
        {
            height = 18;
        }
        else
        {
            height = 26;
        }
    }
    else
    {
        if(indexPath.row == 0)
        {
            height = 400/720.0 * __SCREEN_SIZE.width;
        }
        else if(indexPath.row == 1)
        {
            height = 35;
        }
        else if(indexPath.row == 2)
        {
            height = 18;
        }
        else
        {
            height = 26;
        }
    }
    return height;
}

-(NSInteger)tableView:(MyTableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger row = 1;
    if (tableView.tag == 100) {
        row = 4;
    }
    else
    {
        row = 4;//12;
    }
    return row;
}

- (nullable UIView *)tableView:(MyTableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == tableView.dataArr.count - 1) {
        return nil;
    }
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, __SCREEN_SIZE.width, 10)];
    v.backgroundColor = kUIColorFromRGB(color_4);
    UIView *vl = [[UIView alloc] initWithFrame:CGRectMake(0, 0, __SCREEN_SIZE.width, 0.5)];
    vl.backgroundColor = kUIColorFromRGB(color_lineColor);
    UIView *vl2 = [[UIView alloc] initWithFrame:CGRectMake(0, 9.5, __SCREEN_SIZE.width, 0.5)];
    vl2.backgroundColor = kUIColorFromRGB(color_lineColor);
    [v addSubview:vl2];
    [v addSubview:vl];
    return v;
}

-(UITableViewCell *)tableView:(MyTableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    if (tableView.tag == 100) {
        cell = [self createTabFirstCell:indexPath withTableView:tableView];
    }
    else
    {
        cell = [self createTabSecondCell:indexPath withTableView:tableView];
    }
    return cell;
}

-(UITableViewCell *)createTabFirstCell:(NSIndexPath *)indexPath withTableView:(MyTableView *)tableView
{
    __weak MyActivityVCDelegate *weakSelf = self;
  BUGetActivity *a =  tableView.dataArr[indexPath.section];
    UITableViewCell *cell;
    if (indexPath.row == 0) {
       cell = [ImgTableViewCell dequeueReusableCell:tableView];
             [(ImgTableViewCell*)cell setCellData:[a getDic:0]];
        [(ImgTableViewCell*)cell fitMyActivityMode:[a getAuditState]];
    }
    else if (indexPath.row == 1)
    {
        cell = [OnlyTitleTableViewCell dequeueReusableCell:tableView];
           [(OnlyTitleTableViewCell*)cell setCellData:[a getDic:1]];
        [(OnlyTitleTableViewCell*)cell fitMyActivityMode];
    }
    else if(indexPath.row == 2)
    {
        cell = [OnlyTitleTableViewCell dequeueReusableCell:tableView];
          [(OnlyTitleTableViewCell*)cell setCellData:[a getDic:2]];
        [(OnlyTitleTableViewCell*)cell fitMyActivityModeB];
    }
    else
    {
        cell = [TitleDetailTableViewCell dequeueReusableCell:tableView];
          [(TitleDetailTableViewCell*)cell setCellData:[a getDic:3]];
        if(a.acState == 1|| a.acState == 3)
        {
            [(TitleDetailTableViewCell *)cell fitMyActivityMode:kUIColorFromRGB(color_3)];
        }
        else
        {
            [(TitleDetailTableViewCell *)cell fitMyActivityMode:kUIColorFromRGB(color_6)];
        }
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(UITableViewCell *)createTabSecondCell:(NSIndexPath *)indexPath withTableView:(MyTableView *)tableView
{
    __weak MyActivityVCDelegate *weakSelf = self;
      BUGetActivity *a =  tableView.dataArr[indexPath.section];
//    BUMyComment *myComment = _tableView.dataArr[indexPath.row/4];
//    myComment.indexPath = [NSIndexPath indexPathForRow:indexPath.row/4 inSection:indexPath.section];
    UITableViewCell *cell;
    if (indexPath.row == 0) {
        cell = [ImgTableViewCell dequeueReusableCell:tableView];
          [(ImgTableViewCell*)cell setCellData:[a getDic:0]];
        [(ImgTableViewCell*)cell fitActivityListMode];
    }
    else if (indexPath.row == 1)
    {
        cell = [OnlyTitleTableViewCell dequeueReusableCell:tableView];
            [(OnlyTitleTableViewCell*)cell setCellData:[a getDic:1]];
        [(OnlyTitleTableViewCell*)cell fitMyActivityMode];
    }
    else if(indexPath.row == 2)
    {
        cell = [OnlyTitleTableViewCell dequeueReusableCell:tableView];
     [(OnlyTitleTableViewCell*)cell setCellData:[a getDic:2]];
        [(OnlyTitleTableViewCell*)cell fitMyActivityModeB];
    }
    else
    {
        cell = [TitleDetailTableViewCell dequeueReusableCell:tableView];
          [(TitleDetailTableViewCell*)cell setCellData:[a getDic:3]];
        if(a.acState == 1|| a.acState == 3)
        {
            [(TitleDetailTableViewCell *)cell fitMyActivityMode:kUIColorFromRGB(color_3)];
        }
        else
        {
            [(TitleDetailTableViewCell *)cell fitMyActivityMode:kUIColorFromRGB(color_6)];
        }
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    return cell;
}


-(void)tableView:(MyTableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  BUGetActivity *a =  tableView.dataArr[indexPath.section];
    if (tableView.tag == 100) {
        ActivityInfoViewController *vc = [ActivityInfoViewController new];
        vc.userInfo = a;
        vc.mode = 1;
        [self.parentVC.navigationController pushViewController:vc animated:YES];
        
    }
    else
    {
        ActivityInfoViewController *vc = [ActivityInfoViewController new];
//        vc.mode = 1;
          vc.userInfo = a;
        [self.parentVC.navigationController pushViewController:vc animated:YES];
 
    }
}

#pragma mark -- EGORefreshTableFooterDelegate

- (void)egoRefreshTableFooterDidTriggerRefresh:(EGORefreshTableFooterView*)view
{
    MyTableView *tableView = (MyTableView*) view.superview;
    //这里控制显示loading和控制显示的文字。。。并且进行网络调用
    view.showLoading = YES;
    if (tableView.hasMore) {
        [view setStatusText:@"加载更多..."];
        [self loadNextPage:tableView];
    }
    else{
        [view setStatusText:@"没有更多数据了"];
        [view resetState:false];
    }
    
}

-(void)loadNextPage:(MyTableView *)tableView
{
    //    NSLog(@"xx next");
    if (tableView.tag == 100) {
        
    }
    else
    {
    
    }
}

-(void) refreshCurentPage:(MyTableView *)tableView
{
    //    NSLog(@"%@",@"没实现");
    tableView.isRefreshing = YES;
    [self getData:tableView];
}

-(void)refreshData:(MyTableView *)tableView
{
    tableView.isRefreshing = YES;
    [self getData:tableView];
}

#pragma mark -- EGORefreshTableHeaderDelegate
//todo 调用网络层，然后在回调中执行[self.tableView.refreshHeaderView resetState:YES];
- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view
{
    MyTableView *tableView = (MyTableView*) view.superview;
    [self refreshCurentPage:tableView];
}
@end
