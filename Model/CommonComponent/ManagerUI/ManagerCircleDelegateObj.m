//
//  ManagerCircleDelegateObj.m
//  yihui
//
//  Created by air on 15/9/25.
//  Copyright (c) 2015年 ORANLLC_IOS1. All rights reserved.
//

#import "ManagerCircleDelegateObj.h"
#import "JYTableViewCellManager.h"

@implementation ManagerCircleDelegateObj
{
    JYTableViewCellManager *_cellManager;
    UITableView *_tableView;
    NSMutableArray *_dataArr;
}

-(NSString *)getTitle
{
    return @"管理圈组";
}

-(void)initCellsWithData:(NSMutableArray *)cellArr
{
    CGSize s = CGSizeMake(22, 22);
    NSValue *v = [NSValue valueWithCGSize:s];
    [_cellManager addSection];
    [_cellManager addTableViewCell:_tableView cellClass:@"ImgTitleAndDetailTableViewCell" cellDataDic:@{@"title":@"成员审核",@"imgSize":v,@"img":@"icon_Members-of-the-audit"} handleAction:nil].accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [_cellManager addTableViewCell:_tableView cellClass:@"ImgTitleAndDetailTableViewCell" cellDataDic:@{@"title":@"邀请成员",@"imgSize":v,@"img":@"icon_invited_to_join"} handleAction:nil].accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [_cellManager addSection];
    [_cellManager addTableViewCell:_tableView cellClass:@"ImgTitleAndDetailTableViewCell" cellDataDic:@{@"title":@"管理员设置",@"imgSize":v,@"img":@"icon_administrator"} handleAction:nil].accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    JYBaseTableViewCell *cell = [_cellManager addTableViewCell:_tableView cellClass:@"ImgTitleAndDetailTableViewCell" cellDataDic:@{@"title":@"权限设置",@"imgSize":v,@"img":@"icon_permissions"} handleAction:nil];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [cellArr addObjectsFromArray:[_cellManager getSectionArr]];
    [_tableView reloadData];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
        {
           
        }
            break;
        case 1:
        {
            
        }
            break;
        case 2:
        {
            
        }
            break;
        case 3:
        {
            
        }
            break;
        default:
            break;
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        UILabel *v1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
        v1.text = @"开启后申请加入圈组需要通过验证";
        v1.textColor = [UIColor lightGrayColor];
        return  v1;
    }
    else
    {
        UILabel *v2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
        v2.text = @"关闭后任何用户都不能发现本圈组";
        v2.textColor = [UIColor lightGrayColor];
        return v2;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}
-(void)initTableViewCells:(NSMutableArray *)cellArr withTableView:(UITableView *)tableView
{
    _cellManager = [JYTableViewCellManager manager];
    //注册cell
    _tableView = tableView;
    _dataArr = [NSMutableArray array];
    [self initData:cellArr];//异步初始化，异步调用
    
}
@end
