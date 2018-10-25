//
//  MsgViewController.m
//  deliciousfood
//
//  Created by air on 2017/2/18.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import "MsgViewController.h"
//#import "IconAndTitleTableViewCell.h"
//#import "SysMsgViewController.h"
//#import "SeverMsgViewController.h"
//#import "SysMsgViewController.h"
//#import "ActMsgViewController.h"
#import "TitleDetailTableViewCell.h"
#import "BUSystem.h"
#import "BUPushManager.h"
@interface MsgViewController ()
{

}
@property (strong, nonatomic) IBOutlet MyTableView *tableView;

@end

@implementation MsgViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"我的消息";
    [self initTableView];
//    HUDSHOW(@"加载中");
    [self getData];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(postRefreshMsgList) name:@"PostRefreshMsgList" object:nil];
     [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
     [BUPushManager resetBadge];
}

-(void)postRefreshMsgList
{
    [self getData];
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
-(void)getData
{
//     [busiSystem.indexManager.getSysMessageListManager getList:[NSString stringWithFormat:@"%@",busiSystem.agent.userId] observer:self callback:@selector(getDataNotification:)];
}

-(void)getDataNotification:(BSNotification*)noti
{
  if(noti.error.code == 0)
  {
//      HUDDISMISS;
//       _tableView.dataArr = [NSMutableArray arrayWithArray:busiSystem.indexManager.getSysMessageListManager.dataArr];
//       _tableView.hasMore = busiSystem.indexManager.getSysMessageListManager.pageInfo.hasMore;
       [_tableView reloadData];
       [[JYNoDataManager manager] addNodataView:_tableView withTip:@"暂无信息" withImg:@"nodata" withCount:_tableView.dataArr.count withTag:@"serShop"];
       [[JYNoDataManager manager] fitModeY:150];

  }
     else
     {
//          HUDCRY(noti.error.domain, 1);
     }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)initTableView
{
    _tableView.refreshHeaderView = nil;
//    _kehuMsgCell = [IconAndTitleTableViewCell createTableViewCell];
//    [_kehuMsgCell setCellData:@{@"title":@"在线客户",@"img":@"kehuMsg",@"detail":@"查看与客服的沟通记录"}];
//    [_kehuMsgCell fitMsgMode];
//    
//     _actMsgCell = [IconAndTitleTableViewCell createTableViewCell];
//     [_actMsgCell setCellData:@{@"title":@"活动消息",@"img":@"actMsg",@"detail":@"你的地球日优惠福利来啦"}];
//     [_actMsgCell fitMsgMode];
     
//     _severMsgCell = [IconAndTitleTableViewCell createTableViewCell];
//     [_severMsgCell setCellData:@{@"title":@"服务消息",@"img":@"severMsg",@"detail":@"您有1张优惠券到账了"}];
//     [_severMsgCell fitMsgMode];
//
//
//    _sysMsgCell = [IconAndTitleTableViewCell createTableViewCell];
//    [_sysMsgCell setCellData:@{@"title":@"系统消息",@"img":@"sysMsg",@"detail":@"秒杀专区暂时下线公告"}];
//    [_sysMsgCell fitMsgMode];
     [TitleDetailTableViewCell registerTableViewCell:_tableView];
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _tableView.dataArr.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger row = 1;
    
    return row;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    
    return 0.001;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
     return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}
-(UIView *)createSectionHeadView
{
     UIView *v = [UIView new];
     v.height = 10;
     UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 9.5, __SCREEN_SIZE.width, 0.5)];
     line.backgroundColor = kUIColorFromRGB(color_lineColor);
     v.backgroundColor = kUIColorFromRGB(color_0xf0f0f0);
     line.tag = 9887;
     [v addSubview:line];
     return v;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 100;
    
    return height;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//     BUGetSysMessage *sys = _tableView.dataArr[indexPath.section];
    UITableViewCell *cell;
     cell = [TitleDetailTableViewCell dequeueReusableCell:_tableView];
//     [(TitleDetailTableViewCell*)cell setCellData:[sys getDic]];
     [(TitleDetailTableViewCell*)cell fitMsgMode];
//    [(JYAbstractTableViewCell *)cell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(50, 0, 0, 0)];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//     if (indexPath.section == 0) {
//
//     }
//     else if (indexPath.section == 1) {
//          ActMsgViewController *vc = [ActMsgViewController new];
//          [self.navigationController pushViewController:vc animated:YES];
//          }
//     else
//     if(indexPath.section == 0)
//     {
//          SeverMsgViewController *vc = [SeverMsgViewController new];
//          [self.navigationController pushViewController:vc animated:YES];
//     }
//     else
//     {
//          SysMsgViewController *vc = [SysMsgViewController new];
//              [self.navigationController pushViewController:vc animated:YES];
//     }
}

-(void)loadNextPage
{
//     [busiSystem.indexManager.getSysMessageListManager getListNextPage:self callback:@selector(getDataNotification:)];
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
