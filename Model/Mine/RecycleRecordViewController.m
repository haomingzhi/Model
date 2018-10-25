//
//  RecycleRecordViewController.m
//  intelligentgarbagecollection
//
//  Created by air on 2017/12/5.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import "RecycleRecordViewController.h"
#import "ImgAndThreeTitleTableViewCell.h"
#import "OnlyTitleTableViewCell.h"
#import "ThreeBtnTableViewCell.h"
#import "BUSystem.h"
@interface RecycleRecordViewController ()
@property (strong, nonatomic) IBOutlet MyTableView *tableView;

@end

@implementation RecycleRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
     self.title = @"回收记录";
     [self initTableView];
     HUDSHOW(@"加载中");
     [self getData];
}

-(void)getData
{
//     [busiSystem.getRecyclingOrderListManager getList:busiSystem.agent.userId observer:self callback:@selector(getListNotification:)];

}

-(void)getListNotification:(BSNotification*)noti
{
     if (noti.error.code == 0) {
          HUDDISMISS;
//          _tableView.dataArr = [NSMutableArray arrayWithArray:busiSystem.getRecyclingOrderListManager.dataArr];
//          _tableView.hasMore = busiSystem.getRecyclingOrderListManager.pageInfo.hasMore;
            [_tableView reloadData];
          [[JYNoDataManager manager] addNodataView:_tableView withTip:@"暂无信息" withImg:@"nodata" withCount:_tableView.dataArr.count withTag:@"serShop"];
          [[JYNoDataManager manager] fitModeY:150];

     }
     else
     {

          HUDCRY(noti.error.domain, 1);
     }
}

-(void)viewWillAppear:(BOOL)animated
{
     self.navigationController.navigationBar.shadowImage = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)initTableView
{
     self.tableView.refreshHeaderView = nil;
     [OnlyTitleTableViewCell registerTableViewCell:_tableView];
     [ImgAndThreeTitleTableViewCell registerTableViewCell:_tableView];
     [ThreeBtnTableViewCell registerTableViewCell:_tableView];
     _tableView.backgroundColor = kUIColorFromRGB(color_0xf5f5f5);
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
     if (indexPath.section == 0) {
           if (indexPath.row == 0)
          {
               height = 45;
          }
          else
          {
               height = 100;
          }
     }
     else
     {
          if (indexPath.row == 0) {
               height = 25;
          }
          else if (indexPath.row == 1)
          {
               height = 45;
          }
          else
          {
               height = 100;
          }
     }
     return height;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
     NSInteger row = 3;
     switch (section) {
          case 0:
               row = 2;
               break;
          case 1:
               row = 3;
               break;
          default:
               break;
     }
     return row;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
     UITableViewCell *cell;
//   BUGetRecyclingOrder *od = _tableView.dataArr[indexPath.section];
     if (indexPath.section == 0)
     {
          if (indexPath.row == 0)
          {
               cell = [ThreeBtnTableViewCell dequeueReusableCell:_tableView];
//               [(ThreeBtnTableViewCell*)cell setCellData:[od getDic:indexPath.row + 1]];
               [(ThreeBtnTableViewCell*)cell fitRecycleRecMode];
               [(JYAbstractTableViewCell *)cell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(45, 0, 0, 0)];
          }
          else
          {
               cell = [ImgAndThreeTitleTableViewCell dequeueReusableCell:_tableView];
//               [(ImgAndThreeTitleTableViewCell*)cell setCellData:[od getDic:indexPath.row + 1]];
               [(ImgAndThreeTitleTableViewCell*)cell fitRecycleRecMode];
          }
     }
     else
     {
          if (indexPath.row == 0)
          { cell = [OnlyTitleTableViewCell dequeueReusableCell:_tableView];
//               [(OnlyTitleTableViewCell*)cell setCellData:[od getDic:indexPath.row]];
               [(OnlyTitleTableViewCell*)cell fitRecycleRecMode];

          }
          else if (indexPath.row == 1)
          {cell = [ThreeBtnTableViewCell dequeueReusableCell:_tableView];
//               [(ThreeBtnTableViewCell*)cell setCellData:[od getDic:indexPath.row]];
               [(ThreeBtnTableViewCell*)cell fitRecycleRecMode];
               [(JYAbstractTableViewCell *)cell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(45, 0, 0, 0)];

          }
          else
          {
               cell = [ImgAndThreeTitleTableViewCell dequeueReusableCell:_tableView];
//               [(ImgAndThreeTitleTableViewCell*)cell setCellData:[od getDic:indexPath.row]];
               [(ImgAndThreeTitleTableViewCell*)cell fitRecycleRecMode];
          }
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
