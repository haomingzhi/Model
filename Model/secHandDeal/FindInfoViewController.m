//
//  FindInfoViewController.m
//  rentingshop
//
//  Created by air on 2018/4/2.
//  Copyright © 2018年 ORANLLC_IOS1. All rights reserved.
//

#import "FindInfoViewController.h"
#import "BUSystem.h"
@interface FindInfoViewController ()
 

@end

@implementation FindInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//     self.title = _name?:@"发现详情";
     [self setCenterTitleLb];
     [self initTableView];
//        HUDSHOW(@"加载中");
     //     [self getData];
}
-(void)setCenterTitleLb
{
     UILabel *lb = [UILabel new];
     lb.textColor = kUIColorFromRGB(color_5);
     lb.font = [UIFont boldSystemFontOfSize:18];
     lb.width = __SCREEN_SIZE.width - 80;
     lb.height = 30;
     lb.text = _name?:@"发现详情";
     lb.textAlignment = NSTextAlignmentCenter;
     self.navigationItem.titleView = lb;
     UIButton *btn = [UIButton new];
     btn.width = 30;
     btn.height = 30;
     self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
}
-(void)getData
{

}

-(void)viewWillDisappear:(BOOL)animated
{
//_contentCell.hidden = YES;
}
- (void)didReceiveMemoryWarning {
     [super didReceiveMemoryWarning];
     // Dispose of any resources that can be recreated.
}
-(void)initTableView
{
     self.tableView.refreshHeaderView = nil;
     _tableView.backgroundColor = kUIColorFromRGB(color_2);
     [OnlyTitleTableViewCell registerTableViewCell:_tableView];
     _contentCell = [OnlyTitleTableViewCell createTableViewCell];
     _contentCell.hidden = YES;
}

-(void)viewDidAppear:(BOOL)animated
{
     if (_contentCell.hidden) {

     [_contentCell setCellData:@{@"title":_content?:@"" }];
     [_contentCell fitHtmlMode];
     [_tableView reloadData];
     _contentCell.hidden = NO;
//     HUDDISMISS;

     }
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
