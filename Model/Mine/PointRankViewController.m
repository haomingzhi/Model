//
//  PointRankViewController.m
//  intelligentgarbagecollection
//
//  Created by air on 2017/12/4.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import "PointRankViewController.h"
#import "OnlyTitleTableViewCell.h"
#import "ImgAndThreeTitleTableViewCell.h"
#import "BUSystem.h"

@interface PointRankViewController ()
{
     ImgAndThreeTitleTableViewCell *_infoCell;
     OnlyTitleTableViewCell *_tipCell;

}
@property (strong, nonatomic) IBOutlet MyTableView *tableView;

@end

@implementation PointRankViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"积分排行榜";
    [self initTableView];
     HUDSHOW(@"加载中");
     [self getData];
}

-(void)getData
{
     [busiSystem.agent getIntegralRanking:busiSystem.agent.userId?:@"" observer:self callback:@selector(getIntegralRankingNotification:)];
}

-(void)getIntegralRankingNotification:(BSNotification*)noti
{
     if (noti.error.code == 0) {
          HUDDISMISS;
          _tableView.dataArr = [NSMutableArray arrayWithArray:busiSystem.agent.integralRanking.userList];
          _tableView.hasMore = NO;
          BUGetIntegralRanking *rk = busiSystem.agent.integralRanking;
          [_infoCell setCellData:[rk getDic]];
          [_infoCell fitPointRankModeB];
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
    self.tableView.refreshHeaderView = nil;
     _infoCell  = [ImgAndThreeTitleTableViewCell createTableViewCell];
     [_infoCell setCellData:@{@"title":@"",@"img":@"pointRkBg",@"source":@"0分",@"time":@"排名： 名"}];
     [_infoCell fitPointRankModeB];
     [ImgAndThreeTitleTableViewCell registerTableViewCell:_tableView];
    _tipCell = [OnlyTitleTableViewCell createTableViewCell];
     [_tipCell setCellData:@{@"title":@"排行榜"}];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return  3;
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
     if (indexPath.section == 0) {
          height = 229/360.0 *__SCREEN_SIZE.width;
     }
     else if (indexPath.section == 1)
     {
          height = 46;
     }
     else
     {
          height = 46;
     }
    return height;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger row = 1;
    switch (section) {
        case 0:
            row = 1;
            break;
        case 1:
            row = 1;
            break;
         case 2:
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
          cell = _infoCell;
     }
     else if (indexPath.section == 1)
     {
          cell = _tipCell;
          [(OnlyTitleTableViewCell*)cell fitPointRankMode];
          [(OnlyTitleTableViewCell*)cell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(46, 0, 0, 0)];
     }
     else
     {
          BUUserList *ul = _tableView.dataArr[indexPath.row];
          ul.indexPath = indexPath;
          cell = [ImgAndThreeTitleTableViewCell dequeueReusableCell:_tableView];
          [(ImgAndThreeTitleTableViewCell*)cell setCellData:[ul getDic]];
          [(ImgAndThreeTitleTableViewCell*)cell fitPointRankMode];
                [(ImgAndThreeTitleTableViewCell*)cell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(46, 0, 0, 0)];
     }
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
