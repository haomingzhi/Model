//
//  MyRantInfoViewController.m
//  taihe
//
//  Created by air on 2016/11/8.
//  Copyright © 2016年 ORANLLC_IOS1. All rights reserved.
//

#import "MyRantInfoViewController.h"
#import "TitleDetailTableViewCell.h"
#import "OnlyTitleTableViewCell.h"
#import "LookOrEditRantInfoViewController.h"
#import "BUSystem.h"
#import "ApplyRentHouseViewController.h"
#import "LoginViewController.h"
#import "UpPersonInfoViewController.h"
@interface MyRantInfoViewController ()
@property (strong, nonatomic) IBOutlet MyTableView *tableView;

@end

@implementation MyRantInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"我的求租信息";
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.shadowImage = nil;
    [self setNavRightBtn];
    [self initTableView];
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getData) name:@"refreshMyRant" object:nil];
    HUDSHOW(@"加载中");
    [self getData];
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)showRefreshLoading
{
    HUDSHOW(@"加载中");
    [self getData];
}

-(void)getData
{
    [busiSystem.getMyRentManager getMyRent:busiSystem.agent.sapid withTel:busiSystem.agent.tel observer:self callback:@selector(getMyRentNotification:)];
}

-(void)getMyRentNotification:(BSNotification*)noti
{
    BASENOTIFICATION(noti);
    _tableView.dataArr = [NSMutableArray arrayWithArray:busiSystem.getMyRentManager.data];
    [[JYNoDataManager manager] addNodataView:_tableView withTip:@"暂无信息" withImg:@"nodata" withCount:_tableView.dataArr.count withTag:[NSString stringWithFormat:@"MyRent%d",0]];
    [[JYNoDataManager manager] fitModeY:200];
    [_tableView reloadData];
}

-(void)initTableView
{
    _tableView.refreshHeaderView = nil;
//    _tableView
    [OnlyTitleTableViewCell registerTableViewCell:_tableView];
     [TitleDetailTableViewCell registerTableViewCell:_tableView];
    _tableView.backgroundColor = kUIColorFromRGB(color_4);
}

-(void)setNavRightBtn
{
    [self setNavigateRightButton:@"nav_publish"];
}

-(void)handleDidRightButton:(id)sender{
    if(!busiSystem.agent.isLogin)
    {
        [LoginViewController toLogin:self];
        return;
    }
    [self toPublishVC];
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
            ApplyRentHouseViewController *vc = [ApplyRentHouseViewController new];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _tableView.dataArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 44;
    if (indexPath.row == 0) {
        height = 42;
    }
    else if (indexPath.row == 1) {
        height = 16;
    }else
    {
        height = 32;
    }
    return height;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger row = 3;

    return row;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    BUGetMyRent *r = _tableView.dataArr[indexPath.section];
    if (indexPath.row == 0) {
         cell = [OnlyTitleTableViewCell dequeueReusableCell:tableView];
        [(OnlyTitleTableViewCell*)cell setCellData:[r getDic:0]];
          [(OnlyTitleTableViewCell*)cell fitMyRantInfoMode];
    }
    else if (indexPath.row == 1) {
      cell = [TitleDetailTableViewCell dequeueReusableCell:tableView];
         [(TitleDetailTableViewCell*)cell setCellData:[r getDic:1]];
        [(TitleDetailTableViewCell *)cell fitMyRantInfoMode];
    }else
    {
        cell = [OnlyTitleTableViewCell dequeueReusableCell:tableView];
         [(OnlyTitleTableViewCell*)cell setCellData:[r getDic:2]];
        [(OnlyTitleTableViewCell*)cell fitMyRantInfoModeB];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.001;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     BUGetMyRent *r = _tableView.dataArr[indexPath.section];
    LookOrEditRantInfoViewController *vc = [LookOrEditRantInfoViewController new];
    vc.userInfo = r;
    [self.navigationController pushViewController:vc animated:YES];
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
