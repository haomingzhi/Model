//
//  NoticeListViewController.m
//  taihe
//
//  Created by air on 2016/11/15.
//  Copyright © 2016年 ORANLLC_IOS1. All rights reserved.
//

#import "NoticeListViewController.h"
#import "NoticeInfoViewController.h"
#import "BUSystem.h"
@interface NoticeListViewController ()


@end

@implementation NoticeListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"公告";
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.shadowImage = nil;
    [self initTableView];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    HUDSHOW(@"加载中");
    [self getData];
}

-(void)getData
{
    [busiSystem.getNoticeManager getNotice:busiSystem.agent.sapid observer:self callback:@selector(getNoticeNotification:)];
}

-(void)getNoticeNotification:(BSNotification *)noti
{
    if (_tableView.isRefreshing) {
        //  [_curTableView.refreshHeaderView setState:EGOPullRefreshNormal];
        [self refreshTableHeaderNotification:noti myTableView:_tableView];
        [_tableView setContentOffset:CGPointMake(0, 0) animated:YES];
        _tableView.isRefreshing = NO;
    }
    BASENOTIFICATION(noti);
    _tableView.dataArr = [NSMutableArray arrayWithArray:busiSystem.getNoticeManager.pageData];
    _tableView.hasMore = busiSystem.getNoticeManager.pageInfo.hasMore;
    [_tableView reloadData];
    if (self.tableView.dataArr.count == 0) {
        [[JYNoDataManager manager] addNodataView:_tableView withTip:@"暂无信息" withImg:@"nodata" withCount:_tableView.dataArr.count withTag:[NSString stringWithFormat:@"notice%d",0]];
        [[JYNoDataManager manager] fitModeY:200];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initTableView
{
    
    [ImgAndThreeTitleTableViewCell registerTableViewCell:_tableView];
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger row = _tableView.dataArr.count;
    
    return row;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    
    return 0.001;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.001;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 90;
    
    return height;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    BUGetNotice *n = _tableView.dataArr[indexPath.row];
    UITableViewCell *cell;
    cell = [ImgAndThreeTitleTableViewCell dequeueReusableCell:tableView];
    [(JYAbstractTableViewCell *)cell setCellData:[n getDic]];
    [(ImgAndThreeTitleTableViewCell*)cell fitNoticeMode];
    [(JYAbstractTableViewCell *)cell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(90, 0, 0, 0)];
         cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     BUGetNotice *n = _tableView.dataArr[indexPath.row];
    NoticeInfoViewController *vc = [NoticeInfoViewController new];
    vc.userInfo = n;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)loadNextPage
{
    [busiSystem.getNoticeManager getNoticeNextPage:self callback:@selector(getNoticeNotification:)];
}
-(void)refreshCurentPage
{
    _tableView.isRefreshing = YES;
    [self getData];
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
