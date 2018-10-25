//
//  QuestionViewController.m
//  oranllcshoping
//
//  Created by air on 2017/8/4.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import "QuestionViewController.h"
#import "BUSystem.h"
@interface QuestionViewController ()
{
 
}

@end

@implementation QuestionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
     self.title = @"常见问题";
     [self initTableView];
//     HUDSHOW(@"加载中");
//     [self getData];
}

-(void)getData
{
//     [busiSystem.sysManager.sysHelpTypeMsgListManager getList:_sId observer:self callback:@selector(getListNotificaiton:)];
}

-(void)getListNotificaiton:(BSNotification*)noti
{
     if (noti.error.code == 0) {
//          HUDDISMISS;
//          _tableView.dataArr = [NSMutableArray arrayWithArray:busiSystem.sysManager.sysHelpTypeMsgListManager.dataArr];
//          _tableView.hasMore = busiSystem.sysManager.sysHelpTypeMsgListManager.pageInfo.hasMore;
          [_tableView reloadData];
          [[JYNoDataManager manager] addNodataView:self.tableView withTip:@"暂无问题" withImg:@"nodata" withCount:self.tableView.dataArr.count withTag:[NSString stringWithFormat:@"favc%d",2]];
          [[JYNoDataManager manager] fitModeY:130 ];
     }
     else
     {

//          HUDCRY(noti.error.domain, 1);
     }
}

-(void)viewDidAppear:(BOOL)animated
{
     if(_contentCell.hidden)
     {
     [_contentCell setCellData:@{@"title":_content?:@"" }];
     [_contentCell fitHtmlMode];
     [_tableView reloadData];
     _contentCell.hidden = NO;
//     HUDDISMISS;
     }
}
-(void)viewWillDisappear:(BOOL)animated
{
//     _contentCell.hidden = YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)initTableView
{
     _tableView.backgroundColor = kUIColorFromRGB(color_2);
     self.tableView.refreshHeaderView = nil;
     [OnlyTitleTableViewCell registerTableViewCell:_tableView];
     _contentCell = [OnlyTitleTableViewCell createTableViewCell];
 _contentCell.hidden = YES;
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
     CGFloat height = _contentCell.height;
//     BUGetSysHelpTypeMsg *msg = _tableView.dataArr[indexPath.row/2];
//     if (indexPath.row%2 == 1) {
//          height = msg.height;
//     }
     return height;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
     NSInteger row = 1;
    
     return row;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
     UITableViewCell *cell;
     cell = _contentCell;
//      BUGetSysHelpTypeMsg *msg = _tableView.dataArr[indexPath.row/2];
//     if(indexPath.row %2 == 0)
//     {
//          cell =  [OnlyTitleTableViewCell dequeueReusableCell:_tableView];
//          [(OnlyTitleTableViewCell*)cell setCellData:@{@"title":msg.title?:@""}];
//          [(OnlyTitleTableViewCell*)cell fitQusetionMode];
//     }
//     else
//     {
//          cell =  [OnlyTitleTableViewCell dequeueReusableCell:_tableView];
//                   [(OnlyTitleTableViewCell*)cell setCellData:@{@"title":msg.ment?:@""}];
//          [(OnlyTitleTableViewCell*)cell fitHtmlMode];
//          msg.height = cell.height;
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
