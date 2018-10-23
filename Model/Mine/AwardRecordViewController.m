//
//  AwardRecordViewController.m
//  oranllcshoping
//
//  Created by air on 2017/8/3.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import "AwardRecordViewController.h"
#import "TitleDetailTableViewCell.h"
@interface AwardRecordViewController ()
{
     TitleDetailTableViewCell *_tipCell;
}
@property (strong, nonatomic) IBOutlet MyTableView *tableView;

@end

@implementation AwardRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
     self.title = @"中奖记录";
     [self initTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)initTableView
{
    self.tableView.refreshHeaderView = nil;
     _tipCell = [TitleDetailTableViewCell createTableViewCell];
     [_tipCell setCellData:@{@"title":@"日期",@"detail":@"中奖内容"}];
     [_tipCell fitAwardRecordModeB];
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
    CGFloat height = 40;
     if (indexPath.row == 0) {
          height = 30;
     }
    return height;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger row = 1;
    switch (section) {
        case 0:
            row = 8;
            break;
        case 1:
            row = 7;
            break;
        default:
            break;
    }
    return row;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
     if(indexPath.row == 0)
     {
          cell = _tipCell;
          [_tipCell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(30, 0, 0, 0)];
     }
     else
     {
     cell = [TitleDetailTableViewCell dequeueReusableCell:_tableView];
     [(TitleDetailTableViewCell *)cell setCellData:@{@"title":@"2017-05-01 15:00",@"detail":@"100优惠券"}];
     [(TitleDetailTableViewCell *)cell fitAwardRecordMode];
              [(TitleDetailTableViewCell *)cell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(40, 0, 0, 0)];
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
