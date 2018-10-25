//
//  AuditProgressViewController.m
//  oranllcshoping
//
//  Created by air on 2017/7/26.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import "AuditProgressViewController.h"
#import "TitleDetailTableViewCell.h"
#import "TitleAndImageTableViewCell.h"
#import "OnlyTitleTableViewCell.h"
@interface AuditProgressViewController ()
{
     TitleDetailTableViewCell *_stateCell;
     TitleAndImageTableViewCell *_alertCell;
     OnlyTitleTableViewCell *_tipCell;
}
@property (strong, nonatomic) IBOutlet MyTableView *tableView;

@end

@implementation AuditProgressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"审核进度";
//     [self testData];
    [self initTableView];
}

//-(void)testData
//{
//     _backInfo = [BUAfterSaleDetail new];
//     _backInfo.result = @"就撒发生的觉得";
//     _backInfo.content = @"龙山街道快乐发送到";
//     NSMutableArray *arr = [NSMutableArray new];
//     for (NSInteger i = 0; i< 4; i ++) {
//          BUCheckList *cc = [BUCheckList new];
//          cc.adminName = @"ddf";
//          cc.createTime = @"2012-2-2";
//          cc.stateName = @"ddffgg";
//          cc.remark = @"么么么么";
//          [arr addObject:cc];
//     }
//     _backInfo.afterNO = @"2222222";
//     _backInfo.timeList = arr;
//     _backInfo.orderId = @"111111";
//     _backInfo.stateName = @"借记卡";
//     _backInfo.createTime = @"2013-3-3";
//     _backInfo.finishTime = @"2014-4-4";
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initTableView
{
     _tableView.refreshHeaderView = nil;
     _stateCell = [TitleDetailTableViewCell createTableViewCell];
//     [_stateCell setCellData:[_backInfo getDic:1]];
     [_stateCell fitAuditProgressModeC];
     
     _alertCell = [TitleAndImageTableViewCell createTableViewCell];
//     [_alertCell setCellData:[_backInfo getDic:2]];
     [_alertCell fitAuditProgressMode];
     
     _tipCell = [OnlyTitleTableViewCell createTableViewCell];
     [_tipCell setCellData:@{@"title":@"进度跟踪"}];
     [_tipCell fitAuditProgressMode];
     
     [TitleDetailTableViewCell registerTableViewCell:_tableView];
     _tableView.backgroundColor = kUIColorFromRGB(color_2);
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
    return 10;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
     if (section == 2) {
          return nil;
     }
    return [self createSectionFootView:section];
}
-(UIView *)createSectionFootView:(NSInteger)section
{
     UIView *v = [self.tableView viewWithTag:9887 + section];
     if (!v) {
          v = [UIView new];
          v.tag = 9887 + section;
     }
     v.height = 10;
     UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 9.5, __SCREEN_SIZE.width, 0.5)];
     line.backgroundColor = kUIColorFromRGB(color_lineColor);
     v.backgroundColor = kUIColorFromRGB(color_f8f8f8);

     [v addSubview:line];

     return v;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 44;
     if (indexPath.section == 0) {
          height = 59;
     }
     else if (indexPath.section == 1)
     {
          height = 36;
     }
     else
     {
          if (indexPath.row == 0) {
               height = 36;
          }
          else if (indexPath.row == 1)
          {
               height = 84;
          }
          else
          {
               height = 67;
          }

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
//              row = _backInfo.timeList.count+1;
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
    
               cell = _stateCell;
               [_stateCell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(59, 0, 0, 0)];
                }
     else if (indexPath.section == 1)
     {
          cell = _alertCell;
          
     }
     else
     {
          if (indexPath.row == 0) {
               cell = _tipCell;
               [_tipCell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(36, 0, 0, 0)];
          }
          else if (indexPath.row == 1)
          {
//               BUTimeList *t = _backInfo.timeList[indexPath.row -1];
               cell = [TitleDetailTableViewCell dequeueReusableCell:_tableView];
//               [(TitleDetailTableViewCell *)cell setCellData:[t getDic:2]];
               [(TitleDetailTableViewCell *)cell  fitAuditProgressModeA];
            
          }
          else
          {
//               BUTimeList *t = _backInfo.timeList[indexPath.row -1];
//               cell = [TitleDetailTableViewCell dequeueReusableCell:_tableView];
//               [(TitleDetailTableViewCell *)cell setCellData:[t getDic:3]];
               [(TitleDetailTableViewCell *)cell  fitAuditProgressModeB];
            
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
