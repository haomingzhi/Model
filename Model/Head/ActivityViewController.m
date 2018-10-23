//
//  ActivityViewController.m
//  taihe
//
//  Created by air on 2016/11/8.
//  Copyright © 2016年 ORANLLC_IOS1. All rights reserved.
//

#import "ActivityViewController.h"
#import "ImgTableViewCell.h"
#import "TitleDetailTableViewCell.h"
#import "OnlyTitleTableViewCell.h"
#import "ActivityInfoViewController.h"
#import "SearchViewController.h"
#import "PublishActivityViewController.h"
#import "LoginViewController.h"
#import "UpPersonInfoViewController.h"
#import "BUSystem.h"
@interface ActivityViewController ()
@property (strong, nonatomic) IBOutlet MyTableView *tableView;

@end

@implementation ActivityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"活动";
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.shadowImage = nil;
    [self initTableView];
    [self addNavigateRightButton];
    HUDSHOW(@"加载中");
    [self getData];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getData) name:@"refreshActivityList" object:nil];;
}



-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

//-(void)viewWillAppear:(BOOL)animated
//{
//    
//}

- (void)addNavigateRightButton
{
    UIButton * map = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    map.tag = 100;
    map.frame =CGRectMake(0, 0, 30, 30);
    [map setImage:[[UIImage imageContentWithFileName:@"nav_publish"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [map addTarget:self action:@selector(rightButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    UIButton * search = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    search.frame =CGRectMake(0, 0, 30, 30);
    search.tag = 101;
    [search setImage:[[UIImage imageContentWithFileName:@"nav_search"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [search addTarget:self action:@selector(rightButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    //    notice.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    UIBarButtonItem *rightNavButtonMap = [[UIBarButtonItem alloc] initWithCustomView:map];
    UIBarButtonItem *rightNavButtonSearch = [[UIBarButtonItem alloc] initWithCustomView:search];
    self.navigationItem.rightBarButtonItems = @[rightNavButtonSearch,rightNavButtonMap];
}

-(void)rightButtonAction:(id)sender{
    
    UIButton *btn = (UIButton *)sender;
    if ([btn viewWithTag:100]) {
        if(!busiSystem.agent.isLogin)
        {
            [LoginViewController toLogin:self];
            return;
        }
       [self toPublishVC];
    }else if ([btn viewWithTag:101] ){
        SearchViewController *vc = [SearchViewController new];
         [self.navigationController pushViewController:vc animated:YES];
        
    }
    
    
}

-(void)toPublishVC
{
    HUDSHOW(@"加载中");
    [busiSystem.isAuthBySapIDManager isFirstAuth:busiSystem.agent.tel observer:self callback:@selector(isFirstAuthNotification:)];
}

-(void)isFirstAuthNotification:(BSNotification *)noti
{
    if (noti.error.code == 0) {
        HUDDISMISS;
        if([busiSystem.isAuthBySapIDManager.isFirstAuth integerValue] == 0)
        {
            [[CommonAPI managerWithVC:self] showAlertView:@"您暂无权限执行此操作，请先对该园区进行认证。" withMsg:nil withBtnTitle:@"去认证"  withSel:@selector(toCerVC:) withUserInfo:@{}];
        }
        else
        {
            PublishActivityViewController *vc = [PublishActivityViewController new];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
    else
    {
        HUDCRY(noti.error.domain, 1);
    }
}

-(void)toCerVC:(NSDictionary *)dic
{
    if ([dic[@"code"] integerValue] == 0) {
        [UpPersonInfoViewController toFitVC:self];
    }
}
-(void)getData
{
    [busiSystem.getActivityManager getActivity:busiSystem.agent.sapid observer:self callback:@selector(getActivityNotification:)];
}

-(void)getActivityNotification:(BSNotification *)noti
{
    if (_tableView.isRefreshing) {
        //  [_curTableView.refreshHeaderView setState:EGOPullRefreshNormal];
        [self refreshTableHeaderNotification:noti myTableView:_tableView];
        [_tableView setContentOffset:CGPointMake(0, 0) animated:YES];
        _tableView.isRefreshing = NO;
    }
    
    BASENOTIFICATION(noti);
    _tableView.dataArr = [NSMutableArray arrayWithArray:busiSystem.getActivityManager.pageData];
    _tableView.hasMore = busiSystem.getActivityManager.pageInfo.hasMore;
    [_tableView reloadData];
    if (self.tableView.dataArr.count == 0) {
        [[JYNoDataManager manager] addNodataView:_tableView withTip:@"暂无信息" withImg:@"nodata" withCount:_tableView.dataArr.count withTag:[NSString stringWithFormat:@"actv%d",0]];
        [[JYNoDataManager manager] fitModeY:200];
    }
}

-(void)initTableView
{
    [ImgTableViewCell registerTableViewCell:_tableView];
    [OnlyTitleTableViewCell registerTableViewCell:_tableView];
    [TitleDetailTableViewCell registerTableViewCell:_tableView];
    _tableView.backgroundColor = kUIColorFromRGB(color_4);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _tableView.dataArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.001;
}

-(CGFloat)tableView:(MyTableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 44;
  
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
    
    return height;
}

-(NSInteger)tableView:(MyTableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger row = 4;
    
    return row;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == _tableView.dataArr.count - 1) {
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
    
        cell = [self createTabSecondCell:indexPath withTableView:tableView];
    
    return cell;
}

-(UITableViewCell *)createTabSecondCell:(NSIndexPath *)indexPath withTableView:(MyTableView *)tableView
{
    BUGetActivity *a = _tableView.dataArr[indexPath.section];
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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     BUGetActivity *a = _tableView.dataArr[indexPath.section];
    ActivityInfoViewController *vc = [ActivityInfoViewController new];
    vc.userInfo = a;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)loadNextPage
{
    [busiSystem.getActivityManager getActivityNextPage:self callback:@selector(getActivityNotification:)];
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
