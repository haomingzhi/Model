//
//  SecHandDealViewController.m
//  intelligentgarbagecollection
//
//  Created by air on 2017/12/5.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import "SecHandDealViewController.h"
#import "ImgAndThreeTitleTableViewCell.h"
//#import "ReplacementViewController.h"
#import "BUSystem.h"
@interface SecHandDealViewController ()
@property (strong, nonatomic) IBOutlet MyTableView *tableView;

@end

@implementation SecHandDealViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
     self.title = @"二手交易";
     [self initTableView];
     HUDSHOW(@"加载中");
     [self getData];
}
-(void)getData
{
     [busiSystem.secondhandManager.getSecondhandGoodsListManager getList:@"" withCityId:[NSString stringWithFormat:@"%ld",(long)busiSystem.agent.cityId] withLon:busiSystem.agent.log withLat:busiSystem.agent.lat observer:self callback:@selector(getListNotification:)];
}

-(void)getListNotification:(BSNotification*)noti
{
     if (noti.error.code == 0) {
          HUDDISMISS;
          _tableView.dataArr = [NSMutableArray arrayWithArray:busiSystem.secondhandManager.getSecondhandGoodsListManager.dataArr];
          _tableView.hasMore = busiSystem.secondhandManager.getSecondhandGoodsListManager.pageInfo.hasMore;
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
     [ImgAndThreeTitleTableViewCell registerTableViewCell:_tableView];
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
     CGFloat height = 109;
     return height;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
     NSInteger row = _tableView.dataArr.count;

     return row;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
      BUGetSecondhandGoods *gd = _tableView.dataArr[indexPath.row];
     UITableViewCell *cell;
     cell = [ImgAndThreeTitleTableViewCell dequeueReusableCell:_tableView];
     [(ImgAndThreeTitleTableViewCell *)cell setCellData:[gd getDic:0]];
     [(ImgAndThreeTitleTableViewCell*)cell fitMySecHandDealMode];
     [(ImgAndThreeTitleTableViewCell *)cell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(109, 15, 0, 15)];
     cell.selectionStyle = UITableViewCellSelectionStyleNone;
     return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
       BUGetSecondhandGoods *gd = _tableView.dataArr[indexPath.row];
//     ReplacementViewController *vc = [ReplacementViewController new];
//     vc.secondHandGoods = gd;
//     [self.navigationController pushViewController:vc animated:YES];
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
