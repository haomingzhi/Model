//
//  HelpInfoTableViewController.m
//  compassionpark
//
//  Created by Steve on 2017/4/24.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import "HelpInfoTableViewController.h"
#import "TitleDetailTableViewCell.h"
#import "BUSystem.h"
#import "JYContentViewController.h"

@interface HelpInfoTableViewController ()
@property (weak, nonatomic) IBOutlet MyTableView *tableView;

@end

@implementation HelpInfoTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initTableView];
//    HUDSHOW(@"加载中");
//    [self getData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)getData
{
    //    [busiSystem.agent getHelpList:self callback:@selector(getHelpListNotification:)];
//    [busiSystem.agent getHelpList:_typeId observer:self callback:@selector(getHelpListNotification:)];
}
-(void)getHelpListNotification:(BSNotification*)noti
{
    if (noti.error.code == 0) {
//        HUDDISMISS;
//        _tableView.dataArr = [NSMutableArray arrayWithArray:busiSystem.agent.helpList];
        [_tableView reloadData];
    }
    else
    {
//        HUDCRY(noti.error.domain, 2);
    }
}
-(void)initTableView
{
    _tableView.backgroundColor = kUIColorFromRGB(color_9);
    
    [TitleDetailTableViewCell registerTableViewCell:_tableView];
    _tableView.refreshHeaderView = nil;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger row = _tableView.dataArr.count;
    return row;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    
    return 0.001;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.001;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger height = 44;
//    TitleDetailTableViewCell *cell = [TitleDetailTableViewCell dequeueReusableCell:tableView];
//    BUHelp *help = [_tableView.dataArr objectAtIndex:indexPath.row];
//    [cell setCellData:[help getDic]];
//    [cell fitQuestionMode];
//    height = cell.height;
    return height;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TitleDetailTableViewCell *cell = [TitleDetailTableViewCell dequeueReusableCell:tableView];
    BUHelp *help = [_tableView.dataArr objectAtIndex:indexPath.row];
    [cell setCellData:[help getDic]];
    [cell fitQuestionMode];
    [cell showSeparatorView:kUIColorFromRGB(color_mainTheme) withInsets:UIEdgeInsetsMake(cell.height, 0, 0, 0)];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     BUHelp *help = [_tableView.dataArr objectAtIndex:indexPath.row];
    JYContentViewController *vc = [JYContentViewController new];
    vc.userInfo = @{@"id":help.hid?:@""};
    [self.navigationController pushViewController:vc animated:YES];
}

@end
