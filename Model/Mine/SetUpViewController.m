//
//  SetUpViewController.m
//  ulife
//
//  Created by sunmax on 15/12/10.
//  Copyright © 2015年 ORANLLC_IOS1. All rights reserved.
//

#import "SetUpViewController.h"
#import "SetUpTableViewCell.h"
#import "FeedbackViewController.h"
#import "AboutUsViewController.h"
#import "ModifyPawViewController.h"
#import "ModifiersPwdViewController.h"
#import "LoginViewController.h"
#import "PushSetingInfoViewController.h"
#import "HelpViewController.h"
@interface SetUpViewController ()<UITableViewDataSource,UITableViewDelegate>
{
     NSArray * _cellName;
     __weak IBOutlet MyTableView *_myTableView;
     __weak IBOutlet UIButton *_actionButton;
}
@end

@implementation SetUpViewController

- (void)viewDidLoad {
     [super viewDidLoad];
     self.title =@"系统设置";
     self.navigationController.navigationBar.translucent = NO;
     self.navigationController.navigationBar.shadowImage = nil;
     self.view.backgroundColor =kUIColorFromRGB(color_F3F3F3);
     _cellName =@[@"清除缓存",@"意见反馈",@"关于我们",@"版本信息",@"好评鼓励"];
     [self addTableView];
     _actionButton.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin;
     _actionButton.y =_myTableView.height;
     _actionButton.x = 15;
     _actionButton.width = __SCREEN_SIZE.width - 30;
     _actionButton.backgroundColor = kUIColorFromRGB(color_0xf74056);
     _actionButton.layer.cornerRadius = _actionButton.height/2.0;
     _actionButton.layer.shadowRadius = 8.0;
     _actionButton.layer.shadowOpacity = 0.43;
     _actionButton.layer.shadowOffset = CGSizeMake(0,0);
     _actionButton.layer.shadowColor = kUIColorFromRGB(color_0xf82D45).CGColor;
     [_actionButton setTitleColor:kUIColorFromRGB(color_2) forState:UIControlStateNormal];
     // Do any additional setup after loading the view from its nib.
     _actionButton.hidden =  !busiSystem.agent.isLogin;
     //    HUDSHOW(@"加载中");
     //    [self getData];
     //    self.view.backgroundColor = kUIColorFromRGB(color_9);
}

//-(void)getData
//{
//    [busiSystem.agent getTell:busiSystem.agent.sapid observer:self callback:@selector(getTellNotification:)];
//}

//-(void)getTellNotification:(BSNotification *)noti
//{
//    if (noti.error.code == 0) {
//        HUDDISMISS;
//    }
//    else
//    {
//        HUDCRY( noti.error.domain , 1);
//    }
//}

#pragma mark --- View
- (void)addTableView
{
     [_myTableView registerNib:[UINib nibWithNibName:@"SetUpTableViewCell" bundle:nil] forCellReuseIdentifier:@"SetUpTableViewCell"];
     _myTableView.delegate =self;
     _myTableView.dataSource =self;
     _myTableView.showsVerticalScrollIndicator =NO;
     //设置tableView不能滚动
     [_myTableView setScrollEnabled:NO];
     [self setExtraCellLineHidden:_myTableView];
     //    _myTableView.backgroundColor = kUIColorFromRGB(color_9);
}

//创建组头View
- (UIView *)addHeaderView
{
     UIView *view =[[UIView alloc] initWithFrame:CGRectMake(0, 0, __SCREEN_SIZE.width, 35)];
     view.backgroundColor =kUIColorFromRGB(color_F3F3F3);
     return view;
}

#pragma mark --- Action
//退出事件
- (IBAction)ExitSignAction:(id)sender {
     [[CommonAPI managerWithVC:self] showAlert:@selector(logOut:) withTitle:nil withMessage:@"确定退出当前登录?" withObj:@{}];
     //     [[CommonAPI managerWithVC:self] showSheetOption:@[@"确定要退出当前登录?",@"确定"] withSel:@selector(logOut:) withTitle:@"确定退出登录?"];
}


-(void)logOut:(NSDictionary *)dic
{
     if ([dic[@"code"] integerValue] == 0) {
          //        [LoginViewController toLogin:self];

          busiSystem.agent.isLogin =NO;

          //        busiSystem.agent.header = nil;
          busiSystem.agent.isCancel =YES;
          //        busiSystem.agent.token = nil;
          busiSystem.agent.isNeedRefreshTabD = YES;
          busiSystem.agent.isNeedRefreshTabC = YES;
          busiSystem.agent.isNeedRefreshTabB = YES;
          busiSystem.agent.isNeedRefreshTabA = YES;
          [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"token"];
          [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"kuserId"];
          [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"type"];
          [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"tel"];
          [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"cardNo"];
          [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"password"];
          [[NSUserDefaults standardUserDefaults]  synchronize];
          [LoginViewController toLogin:self];
          _actionButton.hidden =  YES;
          [BUPushManager setTags:nil alias:@"" callbackSelector:@selector(tagsAliasCallback:tags:alias:) object:self];
          [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
          [self.navigationController popToRootViewControllerAnimated:NO];
          //        [busiSystem.agent checkAuth:nil callback:nil];
     }
}

- (void)logoutNotification:(BSNotification*)noti
{
//     BASENOTIFICATION(noti);
     //    busiSystem.agent.Phone=@"";
     busiSystem.agent.password =@"";
     //    [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"cityName"];
     [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"password"];
     //    busiSystem.agent.LocationCityName =@"";
     busiSystem.agent.isLogin =NO;
     LoginViewController *loginVC =[LoginViewController new];
     loginVC.userPwdTextField.text=@"";
     //    loginVC.type =0;
     //     loginVC.type =4;
     busiSystem.agent.isCancel =YES;

     UINavigationController *navSvc = [[UINavigationController alloc] initWithRootViewController:loginVC];
     self.view.window.rootViewController =navSvc;
}
- (void)tagsAliasCallback:(int)iResCode tags:(NSSet*)tags alias:(NSString*)alias {
     NSLog(@"rescode1: %d, \ntags: %@, \nalias: %@\n", iResCode, tags , alias);
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
     if (buttonIndex ==0)
     {
          return;
     }
     else
     {

          NSString * token = [busiSystem.agent.token mutableCopy];//[[NSUserDefaults standardUserDefaults]objectForKey:@"token"];
          NSString *userId = [[NSUserDefaults standardUserDefaults]objectForKey:@"kuserId"];
          NSString *cardNo = [[NSUserDefaults standardUserDefaults]objectForKey:@"cardNo"];
          //创建一个消息对象
          NSNotification * notice = [NSNotification notificationWithName:@"reloadDatas" object:nil userInfo:nil];
          //发送消息
          [[NSNotificationCenter defaultCenter]postNotification:notice];
          BUCache *cache =[BUCache new];
          [cache cleanCache];
          NSString * appId = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"ClientAppId"];
          //初始化业务系统
          BUAgent *agent = busiSystem.agent;
          //        agent.Image.isCached = NO;
          busiSystem = nil;
          initBusiSystem(appId);
          busiSystem.agent = agent;
          busiSystem.agent.token = token;
          busiSystem.agent.userId = userId;
          busiSystem.agent.cardNo = cardNo;
          busiSystem.agent.isNeedRefreshTabC = YES;
          busiSystem.agent.isNeedRefreshTabB = YES;
          busiSystem.agent.isNeedRefreshTabA = YES;
          //        [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"cityName"];
          //        [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"password"];
          //        //    busiSystem.agent.LocationCityName =@"";
          //        busiSystem.agent.isLogin =NO;
          //        UINavigationController *navSvc = [[UINavigationController alloc] initWithRootViewController:[[LoginViewController alloc] init]];
          //        self.view.window.rootViewController =navSvc;
          //        HUDSMILE(@"请重启应用", 1);
          ////        [self clearCache];
          SetUpTableViewCell *setUpCell =[self.view viewWithTag:100];
          //        CGFloat flo =[busiSystem.cache sizeOfCache];
          setUpCell.cache.text =[NSString stringWithFormat:@"0.00M"];
     }
}

- (void)viewDidLayoutSubviews
{
     _myTableView.height =7*45;
     _actionButton.y =_myTableView.height;
}

#pragma mark --- TableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
     return 4;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
     return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
     CGFloat height = 44;
     //    if (!busiSystem.agent.isLogin && indexPath.row == 2) {
     //        height = 0;
     //    }
     return height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
     return section ==1?35:0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
     return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
     SetUpTableViewCell *setUpCell =[tableView dequeueReusableCellWithIdentifier:@"SetUpTableViewCell"];
     setUpCell.separatorInset =UIEdgeInsetsMake(0, 13, 0, 13);
     if (indexPath.section ==0)
     {
          switch (indexPath.row) {
               case 0:
               {


                    [setUpCell setCacheCell:_cellName[indexPath.row]];
                    setUpCell.tag =100;
               }
                    break;
               case 1:
               {
                    [setUpCell setCell:_cellName[indexPath.row]];
               }
                    break;
               case 2:
               {
                    [setUpCell setCell:_cellName[indexPath.row]];
                    //                if (!busiSystem.agent.isLogin && indexPath.row == 2) {
                    //                    setUpCell.hidden = YES;
                    //                }
               }
                    break;
               case 3:
               {
                    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
                    // 当前应用软件版本  比如：1.0.1
                    NSString *appCurVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
                    [setUpCell setVersionCell:_cellName[indexPath.row] withVersion:appCurVersion];
               }
                    break;
               case 4:
               {
                    [setUpCell setCell:_cellName[indexPath.row]];
               }
                    break;
               case 5:
               {
                    [setUpCell setCell:_cellName[indexPath.row]];
               }
                    break;
               default:
                    break;
          }
     }
     [(JYAbstractTableViewCell *)setUpCell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(44, 0, 0, 0)];
     setUpCell.cellName.font =[UIFont systemFontOfSize:14];
     //    setUpCell.backgroundColor = kUIColorFromRGB(color_4);
     return setUpCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     [tableView deselectRowAtIndexPath:indexPath animated:NO];
     if (indexPath.section ==0)
     {
          switch (indexPath.row) {

               case 0:
               {
                    UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:@"" message:@"是否清除缓存？" delegate:self cancelButtonTitle:@"否" otherButtonTitles:@"是", nil];
                    [alertview show];
               }
                    break;

               case 1:
               {
                    FeedbackViewController * fVC =[[FeedbackViewController alloc] init];
                    [self.navigationController pushViewController:fVC animated:YES];
               }
                    break;

               case 2:
               {

                    AboutUsViewController * aVC =[[AboutUsViewController alloc] init];
                    [self.navigationController pushViewController:aVC animated:YES];
               }
                    break;

               default:
                    break;
          }
     }
     else
     {
          //        if (indexPath.row==1) {
          //            ModifyPawViewController * mVC =[[ModifyPawViewController alloc] init];
          //            [self.navigationController pushViewController:mVC animated:YES];
          //        }
     }
}

- (void)clearCache
{
     NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);

     NSString *path = [paths lastObject];

     //                NSString *str = [NSString stringWithFormat:@"缓存已清除%.1fM", [self folderSizeAtPath:path]];
     //
     //                NSLog(@"%@",str);

     NSArray *files = [[NSFileManager defaultManager] subpathsAtPath:path];

     for (NSString *p in files) {

          NSError *error;

          NSString *Path = [path stringByAppendingPathComponent:p];

          if ([[NSFileManager defaultManager] fileExistsAtPath:Path]) {

               [[NSFileManager defaultManager] removeItemAtPath:Path error:&error];

          }
     }
}



- (void)didReceiveMemoryWarning {
     [super didReceiveMemoryWarning];
     // Dispose of any resources that can be recreated.
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

