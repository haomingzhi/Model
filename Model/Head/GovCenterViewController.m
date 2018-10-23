//
//  GovCenterViewController.m
//  taihe
//
//  Created by air on 2016/11/15.
//  Copyright © 2016年 ORANLLC_IOS1. All rights reserved.
//

#import "GovCenterViewController.h"
#import "GovCenterInfoViewController.h"
#import "BUSystem.h"
@interface GovCenterViewController ()

@end

@implementation GovCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"政务中心";
    self.navigationController.navigationBar.translucent = NO;
     self.navigationController.navigationBar.shadowImage = nil;
//    HUDSHOW(@"加载中");
//    [self getData];
}

-(void)getData
{
    [busiSystem.getExecutiveCenterManager getExecutiveCenter:busiSystem.agent.sapid observer:self callback:@selector(getExecutiveCenterNotification:)];
}

-(void)getExecutiveCenterNotification:(BSNotification *)noti
{
    if (self.tableView.isRefreshing) {
        //  [_curTableView.refreshHeaderView setState:EGOPullRefreshNormal];
        [self refreshTableHeaderNotification:noti myTableView:self.tableView];
        [self.tableView setContentOffset:CGPointMake(0, 0) animated:YES];
        self.tableView.isRefreshing = NO;
    }
    BASENOTIFICATION(noti);
    self.tableView.dataArr = [NSMutableArray arrayWithArray:busiSystem.getExecutiveCenterManager.pageData];
    self.tableView.hasMore = busiSystem.getExecutiveCenterManager.pageInfo.hasMore;
    [self.tableView reloadData];
    if (self.tableView.dataArr.count == 0) {
        [[JYNoDataManager manager] addNodataView:self.tableView withTip:@"暂无信息" withImg:@"nodata" withCount:self.tableView.dataArr.count withTag:[NSString stringWithFormat:@"gov%d",0]];
        [[JYNoDataManager manager] fitModeY:200];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BUGetExecutiveCenter *c = self.tableView.dataArr[indexPath.row];
    UITableViewCell *cell;
    cell = [ImgAndThreeTitleTableViewCell dequeueReusableCell:tableView];
    [(JYAbstractTableViewCell*)cell setCellData:[c getDic]];
    [(ImgAndThreeTitleTableViewCell*)cell fitGovCenterMode];
     [(JYAbstractTableViewCell *)cell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(90, 0, 0, 0)];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
      BUGetExecutiveCenter *c = self.tableView.dataArr[indexPath.row];
    GovCenterInfoViewController *vc = [[GovCenterInfoViewController alloc] initWithNibName:@"NoticeInfoViewController" bundle:nil];
    vc.userInfo = c;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)loadNextPage
{
    [busiSystem.getExecutiveCenterManager getExecutiveCenterNextPage:self callback:@selector(getExecutiveCenterNotification:)];
}

-(void)refreshCurentPage
{
    self.tableView.isRefreshing = YES;
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
