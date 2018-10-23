//
//  SysMsgViewController.m
//  oranllcshoping
//
//  Created by air on 2017/8/1.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import "SysMsgViewController.h"
#import "OnlyTitleTableViewCell.h"
#import "TitleDetailTableViewCell.h"
#import "SysMsgInfoViewController.h"
#import "BUSystem.h"
@interface SysMsgViewController ()
@property (strong, nonatomic) IBOutlet MyTableView *tableView;

@end

@implementation SysMsgViewController

- (void)viewDidLoad {
     [super viewDidLoad];
     // Do any additional setup after loading the view from its nib.
     self.title = @"消息中心";
     [self initTableView];
     HUDSHOW(@"加载中");
     [self getData];
}

-(void)getData
{
     [busiSystem.myPathManager.getUserMsgManager getUserMsg:self callback:@selector(getUserMsgNotification:)];
}

-(void)getUserMsgNotification:(BSNotification *)noti
{
     if (noti.error.code == 0) {
          HUDDISMISS;
          _tableView.dataArr = [NSMutableArray arrayWithArray:busiSystem.myPathManager.getUserMsgManager.getUserMsgArr];
                    _tableView.hasMore = busiSystem.myPathManager.getUserMsgManager.pageInfo.hasMore;
          [_tableView reloadData];
          [[JYNoDataManager manager] addNodataView:_tableView withTip:@"暂无信息" withImg:@"nodata" withCount:_tableView.dataArr.count withTag:@"serShop"];
          [[JYNoDataManager manager] fitModeY:150];
     }
     else
     {

          HUDCRY(noti.error.domain, 1);
     }
}

- (void)didReceiveMemoryWarning {
     [super didReceiveMemoryWarning];
     // Dispose of any resources that can be recreated.
}

-(void)initTableView
{
     _tableView.refreshHeaderView = nil;
     [OnlyTitleTableViewCell registerTableViewCell:_tableView];
     [OnlyTitleTableViewCell registerTableViewCell:_tableView withTag:@"ff"];
     [TitleDetailTableViewCell registerTableViewCell:_tableView];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
     return  _tableView.dataArr.count;
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
     return 0.01;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
     return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
     CGFloat height = 44;
     if (indexPath.row == 0) {
          height = 30;
     }
     else if (indexPath.row == 1)
     {
          height = 80;
     }
     else
     {
          height = 30;
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
     BUGetUserMsg *m = _tableView.dataArr[indexPath.section];
     NSDictionary *dic = [m getDic:indexPath.row];
     if (indexPath.row == 0) {
          cell = [OnlyTitleTableViewCell dequeueReusableCell:_tableView];
          [(OnlyTitleTableViewCell*)cell setCellData:dic];
          [(OnlyTitleTableViewCell*)cell  fitSysMsgModeA];
          [(JYAbstractTableViewCell *)cell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(30, 0, 0, 0)];
     }
     else
          if (indexPath.row == 1) {
               cell = [TitleDetailTableViewCell dequeueReusableCell:_tableView];
               [(TitleDetailTableViewCell*)cell setCellData:dic];
               [(TitleDetailTableViewCell*)cell  fitSysMsgMode];
               [(JYAbstractTableViewCell *)cell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(80, 0, 0, 0)];
          }
          else
          {
               cell = [OnlyTitleTableViewCell dequeueReusableCell:_tableView withTag:@"ff"];
               [(OnlyTitleTableViewCell*)cell setCellData:dic];
               [(OnlyTitleTableViewCell*)cell  fitSysMsgModeB];
               [(JYAbstractTableViewCell *)cell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(30, 0, 0, 0)];
          }
     cell.selectionStyle = UITableViewCellSelectionStyleNone;
     return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     BUGetUserMsg *m = _tableView.dataArr[indexPath.section];
     m.isRead = 1;
     [self toRead:m.informationId?:@""];
     SysMsgInfoViewController *vc = [SysMsgInfoViewController new];
     vc.msg = m;
     [self.navigationController pushViewController:vc animated:YES];
     [self.tableView reloadData];
}

-(void)toRead:(NSString *)mid
{
     [busiSystem.agent upMsgState:@"1" withInformationid:mid withUserid:busiSystem.agent.userId?:@"" observer:nil callback:nil];
}

-(void)loadNextPage
{
     [busiSystem.myPathManager.getUserMsgManager getUserMsg:self callback:@selector(getUserMsgNotification:)];
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

