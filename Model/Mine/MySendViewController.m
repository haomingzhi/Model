//
//  MySendViewController.m
//  taihe
//
//  Created by air on 2016/11/8.
//  Copyright © 2016年 ORANLLC_IOS1. All rights reserved.
//

#import "MySendViewController.h"
#import "MySendTableViewCell.h"
#import "SendInfoViewController.h"
#import "BUSystem.h"
@interface MySendViewController ()
@property (strong, nonatomic) IBOutlet MyTableView *tableView;

@end

@implementation MySendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"我的随手发";
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.shadowImage = nil;
    [self initTableView];
    HUDSHOW(@"加载中");
    [self getData];
}

-(void)getData
{
    [busiSystem.shootManager getMyshoot:busiSystem.agent.tel withSapid:busiSystem.agent.sapid observer:self callback:@selector(getMyshootNotification:)];
}

-(void)getMyshootNotification:(BSNotification*)noti
{
    if (_tableView.isRefreshing) {
        //  [_curTableView.refreshHeaderView setState:EGOPullRefreshNormal];
        [self refreshTableHeaderNotification:noti myTableView:_tableView];
        [_tableView setContentOffset:CGPointMake(0, 0) animated:YES];
        _tableView.isRefreshing = NO;
    }
    BASENOTIFICATION(noti);
    _tableView.dataArr = [NSMutableArray arrayWithArray:busiSystem.shootManager.myshootArr];
    [[JYNoDataManager manager] addNodataView:_tableView withTip:@"暂无信息" withImg:@"nodata" withCount:_tableView.dataArr.count withTag:[NSString stringWithFormat:@"Mysend%d",0]];
    [[JYNoDataManager manager] fitModeY:200];
    [_tableView reloadData];
}

-(void)initTableView
{
    [MySendTableViewCell registerTableViewCell:_tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 90;
    
    return height;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger row = _tableView.dataArr.count;
    
    return row;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    UITableViewCell *cell;
    BUShoot *s = _tableView.dataArr[indexPath.row];
    MySendTableViewCell *cell = (MySendTableViewCell*)[MySendTableViewCell dequeueReusableCell:tableView];
    [cell setCellData:[s getDic]];
    [cell fitMySendMode:s.type];
         cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.001;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
      BUShoot *s = _tableView.dataArr[indexPath.row];
    SendInfoViewController *vc = [SendInfoViewController new];
    vc.userInfo = s;
    [self.navigationController pushViewController:vc animated:YES];
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
