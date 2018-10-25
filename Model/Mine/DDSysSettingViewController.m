//
//  DDSysSettingViewController.m
//  DDZX_js
//
//  Created by apple on 2018/8/23.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import "DDSysSettingViewController.h"
#import "UIView+NTES.h"
#import "DDSettingTableViewCell.h"
//#import "aboutViewController.h"
//#import "DDEditPhoneNumViewController.h"
//#import "DDEditPasswordViewController.h"
//#import "DDFeedbackViewController.h"
//#import "TestLoginViewController.h"
//#import "MainViewController.h"
//#import "UserInfoModel.h"
//#import "XFullScreenPopGestureNavigationController.h"
//#import <JYLibrary.h>
//#import "UIView+Toast.h"
@interface DDSysSettingViewController ()
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)UIView *bottomView;
@end
static NSString *kHarpyAppID = @"1437361691";
@implementation DDSysSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"设置";
    [self.view setBackgroundColor:UIColorFromRGB(0xffffff)];
    [self.tableView registerClass:[DDSettingTableViewCell class] forCellReuseIdentifier:@"DDSettingTableViewCell"];
    [self.view addSubview:self.tableView];
    [self.tableView setTableFooterView:self.bottomView];
//    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithImage:[UIImage changeImageSize:[UIImage imageNamed:@"返回"] size:CGSizeMake(20, 20)] style:UIBarButtonItemStylePlain target:self action:@selector(popViewController)];
//    self.navigationItem.leftBarButtonItem = backItem;
}

-(void)popViewController{
    [self.navigationController popViewControllerAnimated:true];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}
#pragma mark - Get

-(UIView *)bottomView
{
    if (!_bottomView) {
        _bottomView = [UIView new];
        _bottomView.height = 100;
        _bottomView.width = UIScreenWidth;
        UIButton *btn = [UIButton new];
        btn.width = 80;
        btn.height = 20;
        btn.centerX = self.view.width/2.0;
        btn.top = 78;
        [btn setTitle:@"退出登录" forState:UIControlStateNormal];
        [btn setTitleColor:UIColorFromRGB(0xFA8E31) forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        [btn addTarget:self action:@selector(logOut:) forControlEvents:UIControlEventTouchUpInside];
        [_bottomView addSubview:btn];
    }
    return _bottomView;
}


-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height) style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        CGFloat contentInsetTop = 10.f;
        _tableView.contentInset = UIEdgeInsetsMake(contentInsetTop, 0, 0, 0);
        _tableView.backgroundColor  = [UIColor clearColor];
        _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _tableView.dataSource = self;
        _tableView.delegate   = self;
        _tableView.tableFooterView = [[UIView alloc] init];
        
    }
    return _tableView;
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
}


#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if(indexPath.row == 0)
    {
//                DDEditPhoneNumViewController *vc = [DDEditPhoneNumViewController new];
//                [self.navigationController pushViewController:vc animated:YES];
    }
    else
    if(indexPath.row == 1)
    {
//        DDEditPasswordViewController *vc = [DDEditPasswordViewController new];
//        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (indexPath.row == 2)
    {
//        DDFeedbackViewController *vc = [DDFeedbackViewController new];
//        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (indexPath.row == 3)
    {
//        aboutViewController *vc = [aboutViewController new];
//        [self.navigationController pushViewController:vc animated:YES];
    }
    else
    {
        [self checkVersion];
    }
        
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}




#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DDSettingTableViewCell"];
    NSDictionary *member;
    if (indexPath.row == 0) {
     member = @{@"title":@"修改手机号"};
    }
    else if(indexPath.row == 1)
    {
       member = @{@"title":@"修改密码"};
    }
    else if(indexPath.row == 2)
    {
        member = @{@"title":@"问题反馈"};
    }
    else if(indexPath.row == 3)
    {
        member = @{@"title":@"关于我们"};
    }
    else
    {
        member = @{@"title":@"版本更新",@"detail":[NSString stringWithFormat:@"当前版本V%@",@"11"]};
    }

    [(DDSettingTableViewCell*)cell refresh:member];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)logOut:(UIButton *)btn
{
//    __weak typeof(self) weak_self = self;
     UserDefaultSetBOOLForKey(NO, @"isAutoLogin");
//    [[UserInfoModel sharedUserInfoModel] cleanUp];
//    [[[NIMSDK sharedSDK] loginManager] logout:^(NSError *error) {
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"MessageListRefreshData" object:nil];
//    }];
    if (self.loginoutBlock) {
        self.loginoutBlock();
    }
    
//    [UserInfoManager userLogout];
//    TestLoginViewController *vc = [TestLoginViewController new];
//    __weak typeof(vc) weak_vc = vc;
//    UINavigationController *nav= [[UINavigationController alloc] initWithRootViewController:vc];
//    self.view.window.rootViewController = nav;
//    [vc setDidLoginedBlock:^{
//        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isAutoLogin"];
//        MainViewController *mainVC = [MainViewController manager];
//        [mainVC loginoutBlock:^{
//            [weak_self.view.window setRootViewController:weak_vc];
//        }];
//        //            [DDZXSDKInitManager getIMTokenLoginIM];
//        XFullScreenPopGestureNavigationController *fullScreenPopGestureNav = [[XFullScreenPopGestureNavigationController alloc]initWithRootViewController:mainVC];
//
//        [weak_self.view.window setRootViewController:fullScreenPopGestureNav];
//    }];
}

-(void)checkVersion
{
    // Asynchronously query iTunes AppStore for publically available version
    NSString *storeString = [NSString stringWithFormat:@"http://itunes.apple.com/cn/lookup?id=%@", kHarpyAppID];
    NSURL *storeURL = [NSURL URLWithString:storeString];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:storeURL];
    [request setHTTPMethod:@"GET"];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        if ( [data length] > 0 && !error ) { // Success
            
            NSDictionary *appData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                // All versions that have been uploaded to the AppStore
                NSArray *versionsInAppStore = [[appData valueForKey:@"results"] valueForKey:@"version"];
                
                if ( ![versionsInAppStore count] ) { // No versions of app in AppStore
//                    [self.view makeToast:@"已经是最新版本了"
//                                duration:1
//                                position:CSToastPositionCenter];
                    return;
                    
                } else {
                    
                    NSString *currentAppStoreVersion = [versionsInAppStore objectAtIndex:0];
                    
//                                        NSString *mAppVersion = kHarpyCurrentVersion;
                    if ([kHarpyCurrentVersion compare:currentAppStoreVersion options:NSNumericSearch] == NSOrderedAscending) {

                        NSString *iTunesString = [NSString stringWithFormat:@"https://itunes.apple.com/cn/app/id%@", kHarpyAppID];
                        NSURL *iTunesURL = [NSURL URLWithString:iTunesString];
                        [[UIApplication sharedApplication] openURL:iTunesURL];

                    }else{
//                        self.tip.title = @"已经是最新版本了";
//                        [self.view makeToast:@"已经是最新版本了"
//                                    duration:1
//                                    position:CSToastPositionCenter];
                    }
                }
                
            });
        }
        
    }];
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
