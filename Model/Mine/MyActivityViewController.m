//
//  MyActivityViewController.m
//  taihe
//
//  Created by air on 2016/11/7.
//  Copyright © 2016年 ORANLLC_IOS1. All rights reserved.
//

#import "MyActivityViewController.h"
#import "TwoTabsTableViewCell.h"
#import "MyActivityVCDelegate.h"
#import "ScrollTwoTableViewController.h"
#import "PublishActivityViewController.h"
#import "BUSystem.h"
#import "LoginViewController.h"
#import "UpPersonInfoViewController.h"
@interface MyActivityViewController ()
//@property (strong, nonatomic) IBOutlet MyTableView *tableView;
@property(nonatomic,strong)TwoTabsTableViewCell *tabsView;
@property(nonatomic,strong) ScrollTwoTableViewController *contentVC;
@end

@implementation MyActivityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"我的活动";
         self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.shadowImage = nil;
    [self initTabsView];
    [self setNavRightBtn];
//    HUDSHOW(@"加载中");
    [self initContentVC];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshTabA) name:@"RefreshMyActivity" object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)setNavRightBtn
{
    [self setNavigateRightButton:@"nav_publish"];
}

-(void)handleDidRightButton:(id)sender
{
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
-(void)initContentVC
{
    __weak MyActivityViewController *weakSelf = self;
    _contentVC = [ScrollTwoTableViewController new];
    MyActivityVCDelegate *obj = [MyActivityVCDelegate new];
    obj.parentVC = self;
    _contentVC.tDelegate = obj;
    _contentVC.view.height = __SCREEN_SIZE.height - 64 - 44;
    _contentVC.view.width = __SCREEN_SIZE.width;
    _contentVC.scrollHandle = ^(NSInteger index){
        if (index == weakSelf.tabsView.curIndex) {
            return ;
        }
        [weakSelf.tabsView setCurBtnIndex:index];
    };
    [_contentVC setTableViewsScrollEnabled:YES];
    [_contentVC viewWillAppear:NO];
    [self.view addSubview:_contentVC.view];
}

-(void)refreshTabA
{
    
    [_contentVC refreshData:0];
}


-(void)initTabsView
{
    __weak MyActivityViewController *weakSelf = self;
    _tabsView = [[NSBundle mainBundle] loadNibNamed:@"TwoTabsTableViewCell" owner:nil options:nil].lastObject;
    _tabsView.height = 44;
    _tabsView.width = __SCREEN_SIZE.width;
    _tabsView.selectBgColor = kUIColorFromRGB(color_2);
    _tabsView.unSelectBgColor = kUIColorFromRGB(color_2);
//    [_tabsView setSelectLineHidden:YES];
    [weakSelf.tabsView setCellData:@{@"tab1":@"我发布的活动",@"tab2":@"我参与的活动",@"select":@(0)}];
    
    _tabsView.tabOneCallBack = ^(id o){
        //        weakSelf.curTab = 0;
        [weakSelf.tabsView setCellData:@{@"tab1":@"我发布的活动",@"tab2":@"我参与的活动",@"select":@(0)}];
        [weakSelf.contentVC selectCurIndex:0];
        
    };
    _tabsView.tabTwoCallBack = ^(id o){
        //        weakSelf.curTab = 1;
        [weakSelf.tabsView setCellData:@{@"tab1":@"我发布的活动",@"tab2":@"我参与的活动",@"select":@(1)}];
        [weakSelf.contentVC selectCurIndex:1];
    };
    
    [_tabsView fitMyActivityMode];
    [self.view addSubview:_tabsView];
}

-(void)viewWillAppear:(BOOL)animated
{
    [_contentVC viewWillAppear:NO];
}

-(void)viewDidLayoutSubviews
{
    _contentVC.view.y = 44;
    _contentVC.view.height = __SCREEN_SIZE.height - 64 - 44;
    _contentVC.view.width = __SCREEN_SIZE.width;
}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

//-(void)viewDidDisappear:(BOOL)animated
//{
//
//    [_contentVC viewDidDisappear:animated];
//}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
