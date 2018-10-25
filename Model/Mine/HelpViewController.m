//
//  HelpViewController.m
//  compassionpark
//
//  Created by air on 2017/2/10.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import "HelpViewController.h"
#import "OnlyTitleTableViewCell.h"
#import "HelpInfoViewController.h"
#import "BUSystem.h"
#import "HelpInfoTableViewController.h"

@interface HelpViewController ()
{
    OnlyTitleTableViewCell *_aCell;
    OnlyTitleTableViewCell *_bCell;
    OnlyTitleTableViewCell *_cCell;
    OnlyTitleTableViewCell *_dCell;
    OnlyTitleTableViewCell *_eCell;
    
    IBOutlet MyTableView *_tableView;
}
@end

@implementation HelpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"帮助";
    [self initTableView];
//    HUDSHOW(@"加载中");
    [self getData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)getData
{
//    [busiSystem.agent getHelpList:self callback:@selector(getHelpListNotification:)];
//    [busiSystem.agent getHelpTypeList:self callback:@selector(getHelpTypeListNotification:)];
}
-(void)getHelpTypeListNotification:(BSNotification*)noti
{
    if (noti.error.code == 0) {
//        HUDDISMISS;
//        _tableView.dataArr = [NSMutableArray arrayWithArray:busiSystem.agent.helpTypeList];
        [_tableView reloadData];
    }
    else
    {
//        HUDCRY(noti.error.domain, 2);
    }
}
-(void)initTableView
{
//     _aCell = [OnlyTitleTableViewCell createTableViewCell];
//    [_aCell setCellData:@{@"title":@"账户问题"}];
//    
//     _bCell = [OnlyTitleTableViewCell createTableViewCell];
//    [_bCell setCellData:@{@"title":@"订单问题"}];
//    
//     _cCell = [OnlyTitleTableViewCell createTableViewCell];
//    [_cCell setCellData:@{@"title":@"支付问题"}];
//    
//     _dCell = [OnlyTitleTableViewCell createTableViewCell];
//    [_dCell setCellData:@{@"title":@"活动相关"}];
//    
//     _eCell = [OnlyTitleTableViewCell createTableViewCell];
//    [_eCell setCellData:@{@"title":@"其他问题"}];
    _tableView.backgroundColor = kUIColorFromRGB(color_9);
    
    [OnlyTitleTableViewCell registerTableViewCell:_tableView];
    _tableView.delegate = self;
    _tableView.dataSource = self;
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
    
    return height;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    UITableViewCell *cell;
//    if(indexPath.row == 0)
//    {
//        cell = _aCell;
//        [_aCell showSeparatorView:kUIColorFromRGB(color_mainTheme) withInsets:UIEdgeInsetsMake(44, 0, 0, 0)];
//    }
//    else if(indexPath.row == 1)
//    {
//        cell = _bCell;
//         [_bCell showSeparatorView:kUIColorFromRGB(color_mainTheme) withInsets:UIEdgeInsetsMake(44, 0, 0, 0)];
//    }
//    else if(indexPath.row == 2)
//    {
//      cell = _cCell;
//         [_cCell showSeparatorView:kUIColorFromRGB(color_mainTheme) withInsets:UIEdgeInsetsMake(44, 0, 0, 0)];
//    }
//    else if(indexPath.row == 3)
//    {
//        cell = _dCell;
//         [_dCell showSeparatorView:kUIColorFromRGB(color_mainTheme) withInsets:UIEdgeInsetsMake(44, 0, 0, 0)];
//    } else
//    {
//       cell = _eCell;
//         [_eCell showSeparatorView:kUIColorFromRGB(color_mainTheme) withInsets:UIEdgeInsetsMake(44, 0, 0, 0)];
//    }
    OnlyTitleTableViewCell *cell = [OnlyTitleTableViewCell dequeueReusableCell:tableView];
    BUHelp *help = [_tableView.dataArr objectAtIndex:indexPath.row];
    [cell setCellData:@{@"title":help.title?:@""}];
    [cell fitPersonMode];
    [cell showSeparatorView:kUIColorFromRGB(color_mainTheme) withInsets:UIEdgeInsetsMake(44, 0, 0, 0)];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if (indexPath.row == 0) {
//        HelpInfoViewController *vc = [HelpInfoViewController new];//[[HelpInfoViewController alloc] initWithNibName:@"UserAgreementViewController" bundle:nil];
//        vc.title = @"账户问题";
//        [self.navigationController pushViewController: vc animated:YES];
//    }
    HelpInfoTableViewController *vc = [HelpInfoTableViewController new];
    BUHelp *help = [_tableView.dataArr objectAtIndex:indexPath.row];
    vc.typeId = help.hid;
    vc.title = help.title?:@"";
    [self.navigationController pushViewController:vc animated:YES];
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
