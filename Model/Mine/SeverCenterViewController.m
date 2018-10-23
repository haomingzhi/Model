//
//  SeverCenterViewController.m
//  oranllcshoping
//
//  Created by air on 2017/7/26.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import "SeverCenterViewController.h"
#import "TwoTabsTableViewCell.h"
#import "OnlyTitleTableViewCell.h"
#import "TitleAndImageTableViewCell.h"
#import "QuestionViewController.h"
#import "IconTitleAndImgTableViewCell.h"
//#import "HuanxinKefuManager.h"
#import "TwoTabsTableViewCell.h"
#import "ImgTableViewCell.h"
#import "BUSystem.h"
//#import "MQChatViewManager.h"
#import "MQSdkManager.h"
@interface SeverCenterViewController ()
{
     ImgTableViewCell *_imgCell;
     TwoTabsTableViewCell *_tabsCell;
     OnlyTitleTableViewCell *_tipCell;
}

@property (strong, nonatomic) IBOutlet MyTableView *tableView;

@end

@implementation SeverCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
     self.title = @"我的客服";
     [self initTableView];
     HUDSHOW(@"加载中");
     [self getData];
}

-(void)getData
{
//     [busiSystem.sysManager.sysHelpTypeListManager getList:@"" observer:self callback:@selector(getListNotification:)];
     [busiSystem.myPathManager getServiceList:@"" withUserid:@"" observer:self callback:@selector(getListNotification:)];
}

-(void)getListNotification:(BSNotification*)noti
{
     if (noti.error.code == 0) {
          HUDDISMISS;
          _tableView.dataArr = [NSMutableArray arrayWithArray:busiSystem.myPathManager.serviceList];
//          _tableView.hasMore = busiSystem.sysManager.sysHelpTypeListManager.pageInfo.hasMore;
          [_tableView reloadData];
     }
     else
     {

          HUDCRY(noti.error.domain, 1);
     }
}
-(void)viewDidAppear:(BOOL)animated
{
      self.navigationController.navigationBar.shadowImage = nil;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)initTableView
{
     __weak SeverCenterViewController *weakSelf = self;
     _tableView .refreshHeaderView = nil;
     _tabsCell = [TwoTabsTableViewCell createTableViewCell];
     [_tabsCell setCellData:@{@"tab1":@"在线客服",@"tab2":@"客服热线",@"aimg":@"kefu",@"bimg":@"rexian"}];
     [_tabsCell fitSeverCenterMode];
     [_tabsCell setTabOneCallBack:^(id o){
          [[MQSdkManager manager] toMQChatVC:weakSelf];
//          MQChatViewManager *chatViewManager = [[MQChatViewManager alloc] init];
//          UIImage *img;
//          if (busiSystem.agent.img.isCached) {
//               img = [UIImage imageWithContentsOfFile:busiSystem.agent.img.Image];
//          }else
//               img = [UIImage imageNamed:@"defaultHead"];
//          [chatViewManager setoutgoingDefaultAvatarImage:img];
//          MQChatViewStyle *aStyle = [chatViewManager chatViewStyle];
//          //    [aStyle setNavBarTintColor:[UIColor redColor]];
//          [aStyle setNavBackButtonImage:[UIImage imageNamed:@"nav_back"]];
//          [chatViewManager pushMQChatViewControllerInViewController:weakSelf];
//            [HuanxinKefuManager kefuHandle:weakSelf];
     }];
     
     [_tabsCell setTabTwoCallBack:^(id o) {
          [BSUtility callPhone:busiSystem.agent.config.service view:weakSelf.view];
     }];
     
     
     
//     _tabsCell = [TwoTabsTableViewCell createTableViewCell];
//     [_tabsCell setCellData:@{@"title":@"服务中心",@"default":@"serveCenter",@"detail":@""}];
//     [_tabsCell fitMineMode];
//     [_tabsCell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(45, 0, 0, 0)];
     _tipCell = [OnlyTitleTableViewCell createTableViewCell];
     [_tipCell setCellData:@{@"title":@"常见问题"}];
     [_tipCell fitSeverCenterMode];
     [TitleAndImageTableViewCell registerTableViewCell:_tableView];
     _imgCell = [ImgTableViewCell createTableViewCell];
     [_imgCell setCellData:@{@"img":@"myServerTop"}];
     [_imgCell fitSeverCenterMode];
     _tableView.backgroundColor = kUIColorFromRGB(color_2);
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return  2;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section;
{
    
    return  nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 0.001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
     if (section == 0) {
          return 35;
     }
    return 0.01;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
     if (section == 0) {
          return _tipCell;
     }
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 44;
     if (indexPath.section == 0) {
          if (indexPath.row == 0) {
               height = 140 /360.0 *__SCREEN_SIZE.width;
          }
          else
          height = 60;
     }
     else
     {
          height = 45;
     }
    return height;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger row = 1;
    switch (section) {
        case 0:
            row = 2;
            break;
        case 1:
              row = _tableView.dataArr.count;
            break;
        default:
            break;
    }
    return row;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
     if (indexPath.section == 0) {
          if (indexPath.row == 0) {
               cell = _imgCell;
          }
          else
          cell = _tabsCell;
     }
     else
     {
          BUServiceList *t = _tableView.dataArr[indexPath.row];
          cell = [TitleAndImageTableViewCell dequeueReusableCell:_tableView];
          [(TitleAndImageTableViewCell*)cell setCellData:[t getDic]];
          [(TitleAndImageTableViewCell*)cell fitSeverCenterMode];
             [(TitleAndImageTableViewCell*)cell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(45, 0, 0, 0)];
     }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     if(indexPath.section == 0)
     {
//          [BSUtility callPhone:busiSystem.sysManager.getSysInfo.tell?:@"" view:self.view];
//          NSString *num = [[NSString alloc] initWithFormat:@"tel://%@",@"00000"]; //number为号码字符串
//          [[UIApplication sharedApplication] openURL:[NSURL URLWithString:num]]; //拨号
     }else
     if (indexPath.section == 1) {
  BUServiceList *t = _tableView.dataArr[indexPath.row];
          [self toRead:t.helpId?:@""];
          QuestionViewController *vc = [QuestionViewController new];
          vc.content = t.content;
          [self.navigationController pushViewController:vc animated:YES];
     }
}

-(void)toRead:(NSString*)sid
{
     [busiSystem.agent upCount:@"2" withDataId:sid observer:nil callback:nil];
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
