//
//  RechargeRecordViewController.m
//  supermarket
//
//  Created by air on 2017/11/22.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import "RechargeRecordViewController.h"
#import "TitleDetailTableViewCell.h"
#import "BUSystem.h"
@interface RechargeRecordViewController ()


@end

@implementation RechargeRecordViewController

- (void)viewDidLoad {
     [super viewDidLoad];
     // Do any additional setup after loading the view from its nib.
     self.title = @"充值记录";
     [self setNavigateRightButton:@"nav_que"];
     [self initTableView];
     HUDSHOW(@"加载中");
     [self getData];
}

-(void)getData
{
//     [busiSystem.userSetManager.userPayManager getList:busiSystem.agent.userId observer:self callback:@selector(getDataNotification:)];
}

-(void)getDataNotification:(BSNotification*)noti
{
     if (noti.error.code == 0) {
          HUDDISMISS;
//          self.tableView.dataArr = [NSMutableArray arrayWithArray: busiSystem.userSetManager.userPayManager.dataArr];
//          self.tableView.hasMore = busiSystem.userSetManager.userPayManager.pageInfo.hasMore;
          [self.tableView reloadData];
          [[JYNoDataManager manager] addNodataView:_tableView withTip:@"暂无充值记录" withImg:@"nodata" withCount:_tableView.dataArr.count withTag:[NSString stringWithFormat:@"favc%d",2]];
          [[JYNoDataManager manager] fitModeY:130 ];
     }
     else
     {

          HUDCRY(noti.error.domain, 1);
     }
}

-(void)handleDidRightButton:(id)sender
{
//     VIPHelpViewController *vc = [VIPHelpViewController new];
//     [self.navigationController pushViewController:vc animated:YES];
}
- (void)didReceiveMemoryWarning {
     [super didReceiveMemoryWarning];
     // Dispose of any resources that can be recreated.
}
-(void)initTableView
{
     self.tableView.refreshHeaderView = nil;
     [TitleDetailTableViewCell registerTableViewCell:_tableView];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
     return  1;
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
     height = 56;

     return height;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
     NSInteger row = 1;
     switch (section) {
          case 0:
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
//  BUUserPay *p =  _tableView.dataArr[indexPath.row];
//     cell = [TitleDetailTableViewCell dequeueReusableCell:_tableView];
//     [(TitleDetailTableViewCell *)cell setCellData:[p getDic]];
//     [(TitleDetailTableViewCell *)cell fitGrowthValueRecordMode];
//     [(TitleDetailTableViewCell *)cell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(56, 0, 0, 0)];


     cell.selectionStyle = UITableViewCellSelectionStyleNone;
     return cell;
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
