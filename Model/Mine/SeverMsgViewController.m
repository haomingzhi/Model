//
//  SeverMsgViewController.m
//  oranllcshoping
//
//  Created by air on 2017/8/1.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import "SeverMsgViewController.h"
#import "OnlyTitleTableViewCell.h"
#import "TitleDetailTableViewCell.h"
#import "BUSystem.h"
@interface SeverMsgViewController ()
@property (strong, nonatomic) IBOutlet MyTableView *tableView;

@end

@implementation SeverMsgViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
     [self initTableView];
     [self setNavigateRightButton:@"清空"];
     self.title = @"服务消息";
     HUDSHOW(@"加载中");
     [self getData];
}

-(void)getData
{
//     [busiSystem.sysManager.messageListManager getList:@"1" observer:self callback:@selector(getListNotification:)];
}

-(void)getListNotification:(BSNotification*)noti
{
     if (noti.error.code == 0) {
          HUDDISMISS;
//          _tableView.dataArr = [NSMutableArray arrayWithArray:busiSystem.sysManager.messageListManager.dataArr];
//          _tableView.hasMore = busiSystem.sysManager.messageListManager.pageInfo.hasMore;
//          [_tableView reloadData];
          [[JYNoDataManager manager] addNodataView:self.tableView withTip:@"暂无消息" withImg:@"nodata" withCount:self.tableView.dataArr.count withTag:[NSString stringWithFormat:@"favc%d",2]];
          [[JYNoDataManager manager] fitModeY:130 ];
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
       height = 35;
     }
     else
     {
       height = 45;
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
//     BUGetMessage *mg = _tableView.dataArr [indexPath.section];
//     if (indexPath.row == 0) {
//          cell = [OnlyTitleTableViewCell dequeueReusableCell:_tableView];
//          [(OnlyTitleTableViewCell*)cell setCellData:[mg getDic:indexPath.row]];
//           [(OnlyTitleTableViewCell*)cell  fitSeverMsgModeA];
//          [(JYAbstractTableViewCell *)cell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(30, 0, 0, 0)];
//     }
//     else
//     if (indexPath.row == 1) {
//           cell = [OnlyTitleTableViewCell dequeueReusableCell:_tableView];
//            [(OnlyTitleTableViewCell*)cell setCellData:[mg getDic:indexPath.row]];
//             [(OnlyTitleTableViewCell*)cell  fitSeverMsgMode];
//           [(OnlyTitleTableViewCell *)cell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(35, 0, 0, 0)];
//     }
//     else
//     {
//       cell = [OnlyTitleTableViewCell dequeueReusableCell:_tableView];
//            [(OnlyTitleTableViewCell*)cell setCellData:[mg getDic:indexPath.row]];
//                  [(OnlyTitleTableViewCell*)cell  fitSeverMsgModeB];
//           [(JYAbstractTableViewCell *)cell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(45, 0, 0, 0)];
//     }
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
