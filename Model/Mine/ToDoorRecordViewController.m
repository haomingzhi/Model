//
//  ToDoorRecordViewController.m
//  intelligentgarbagecollection
//
//  Created by air on 2017/12/19.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import "ToDoorRecordViewController.h"
#import "OnlyTitleTableViewCell.h"
#import "TitleDetailTableViewCell.h"
#import "BUSystem.h"
@interface ToDoorRecordViewController ()
@property (strong, nonatomic) IBOutlet MyTableView *tableView;

@end

@implementation ToDoorRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initTableView];
     self.title = @"上门回收申请";
     HUDSHOW(@"加载中");
     [self getData];
}

-(void)getData
{
     [busiSystem.getToDoorRecyclingOrderListManager getList:busiSystem.agent.userId?:@"" observer:self callback:@selector(getDataNotification:)];
}

-(void)getDataNotification:(BSNotification*)noti
{
     if (noti.error.code == 0) {
          HUDDISMISS;
          _tableView.dataArr = [NSMutableArray arrayWithArray:busiSystem.getToDoorRecyclingOrderListManager.dataArr];
          _tableView.hasMore = busiSystem.getToDoorRecyclingOrderListManager.pageInfo.hasMore;
          [_tableView reloadData];
          [[JYNoDataManager manager] addNodataView:_tableView withTip:@"暂无信息" withImg:@"nodata" withCount:_tableView.dataArr.count withTag:[NSString stringWithFormat:@"sxxp%ld",0]];
          [[JYNoDataManager manager] fitModeY:150];
     }
     else
     {

          HUDCRY(noti.error.domain, 1);
     }
}

-(void)loadNextPage
{
     [busiSystem.getToDoorRecyclingOrderListManager getListNextPage:self callback:@selector(getDataNotification:)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)initTableView
{
     self.tableView.refreshHeaderView = nil;
     [TitleDetailTableViewCell registerTableViewCell:_tableView];
     [OnlyTitleTableViewCell registerTableViewCell:_tableView];
[OnlyTitleTableViewCell registerTableViewCell:_tableView withTag:@"pos"];
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
     return 10;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
     return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
     CGFloat height = 44;
     if (indexPath.row == 0) {
          height = 45;
     }
     else if (indexPath.row == 1)
     {
          height = 27;
     }
     else if (indexPath.row == 2)
     {
           BUGetToDoorRecyclingOrder *o = _tableView.dataArr[indexPath.section];
          height = o.height;
     }
     else if (indexPath.row == 3)
     {
   height = 27;
     }
     else if (indexPath.row == 4)
     {
 height = 27;
     }
     else if (indexPath.row == 5)
     {
 height = 27;
     }
     else
     {
          height = 39;;
     }
     return height;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
     NSInteger row = 7;

     return row;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
     BUGetToDoorRecyclingOrder *o = _tableView.dataArr[indexPath.section];
     UITableViewCell *cell;
     if (indexPath.row == 0) {
          cell = [TitleDetailTableViewCell dequeueReusableCell:_tableView ];
          NSDictionary *dic = [o getDic:indexPath.row];
          [(TitleDetailTableViewCell*)cell setCellData:dic];
          [(TitleDetailTableViewCell*)cell fitToDoorRecMode];
                [(JYAbstractTableViewCell*)cell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(45, 0, 0, 0 )];
     }
     else if (indexPath.row == 1)
     {
          cell = [OnlyTitleTableViewCell dequeueReusableCell:tableView];
          NSDictionary *dic = [o getDic:indexPath.row];
          [(OnlyTitleTableViewCell*)cell setCellData:dic];
          [(OnlyTitleTableViewCell*)cell fitToDoorRecMode];
     }
     else if (indexPath.row == 2)
     {
  cell = [OnlyTitleTableViewCell dequeueReusableCell:tableView withTag:@"pos"];
          NSDictionary *dic = [o getDic:indexPath.row];
          [(OnlyTitleTableViewCell*)cell setCellData:dic];
          [(OnlyTitleTableViewCell*)cell fitToDoorRecModeC];
          o.height = cell.height;
     }
     else if (indexPath.row == 3)
     {
  cell = [OnlyTitleTableViewCell dequeueReusableCell:tableView];
          NSDictionary *dic = [o getDic:indexPath.row];
          [(OnlyTitleTableViewCell*)cell setCellData:dic];
          [(OnlyTitleTableViewCell*)cell fitToDoorRecModeB];
     }
     else if (indexPath.row == 4)
     {
  cell = [OnlyTitleTableViewCell dequeueReusableCell:tableView];
          NSDictionary *dic = [o getDic:indexPath.row];
          [(OnlyTitleTableViewCell*)cell setCellData:dic];
          [(OnlyTitleTableViewCell*)cell fitToDoorRecModeB];
     }
     else if (indexPath.row == 5)
     {
  cell = [OnlyTitleTableViewCell dequeueReusableCell:tableView];
          NSDictionary *dic = [o getDic:indexPath.row];
          [(OnlyTitleTableViewCell*)cell setCellData:dic];
          [(OnlyTitleTableViewCell*)cell fitToDoorRecModeB];
     }
     else
     {
  cell = [OnlyTitleTableViewCell dequeueReusableCell:tableView];
          NSDictionary *dic = [o getDic:indexPath.row];
          [(OnlyTitleTableViewCell*)cell setCellData:dic];
          [(OnlyTitleTableViewCell*)cell fitToDoorRecModeB];
          [(JYAbstractTableViewCell*)cell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(39, 0, 0, 0 )];
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
