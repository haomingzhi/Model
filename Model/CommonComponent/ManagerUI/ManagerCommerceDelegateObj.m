//
//  ManagerCommerceDelegateObj.m
//  yihui
//
//  Created by air on 15/9/14.
//  Copyright (c) 2015年 ORANLLC_IOS1. All rights reserved.
//

#import "ManagerCommerceDelegateObj.h"
#import "JYTableViewCellManager.h"
#import "JYBaseTableViewCell.h"
@implementation ManagerCommerceDelegateObj
{
    JYTableViewCellManager *_cellManager;
    UITableView *_tableView;
    NSMutableArray *_dataArr;
}

-(NSString *)getTitle
{
    return @"管理商会";
}

-(void)initCellsWithData:(NSMutableArray *)cellArr
{
    CGSize s = CGSizeMake(22, 22);
    NSValue *v = [NSValue valueWithCGSize:s];
    UIEdgeInsets c =  UIEdgeInsetsMake(0, 40, 0, 0);
    NSValue *m = [NSValue value:&c withObjCType:@encode(UIEdgeInsets)];
    [_cellManager addSection];
    [_cellManager addTableViewCell:_tableView cellClass:@"ImgTitleAndDetailTableViewCell" cellDataDic:@{@"title":@"成员审核",@"imgSize":v,@"img":@"icon_Members-of-the-audit",@"separatorInset":m} handleAction:nil].accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [_cellManager addTableViewCell:_tableView cellClass:@"ImgTitleAndDetailTableViewCell" cellDataDic:@{@"title":@"邀请成员",@"imgSize":v,@"img":@"icon_invited_to_join",@"separatorInset":m} handleAction:nil].accessoryType = UITableViewCellAccessoryDisclosureIndicator;
     [_cellManager addTableViewCell:_tableView cellClass:@"ImgTitleAndDetailTableViewCell" cellDataDic:@{@"title":@"管理成员",@"imgSize":v,@"img":@"icon_administrator"} handleAction:nil].accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [_cellManager addSection];
    
    [_cellManager addTableViewCell:_tableView cellClass:@"ImgTitleAndDetailTableViewCell" cellDataDic:@{@"title":@"通讯录分类管理",@"imgSize":v,@"img":@"icon_tongxunshezhi",@"separatorInset":m} handleAction:nil].accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    [_cellManager addTableViewCell:_tableView cellClass:@"ImgTitleAndDetailTableViewCell" cellDataDic:@{@"title":@"管理员设置",@"imgSize":v,@"img":@"icon_configuration",@"separatorInset":m} handleAction:nil].accessoryType = UITableViewCellAccessoryDisclosureIndicator;
   JYBaseTableViewCell *cell = [_cellManager addTableViewCell:_tableView cellClass:@"ImgTitleAndDetailTableViewCell" cellDataDic:@{@"title":@"权限设置",@"imgSize":v,@"img":@"icon_permissions"} handleAction:nil];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
     [_cellManager addSection];
     [_cellManager addTableViewCell:_tableView cellClass:@"ImgTitleAndDetailTableViewCell" cellDataDic:@{@"title":@"设置问题",@"imgSize":v,@"img":@"icon_permissions"} handleAction:nil].accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    [cellArr addObjectsFromArray:[_cellManager getSectionArr]];
    [_tableView reloadData];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_callBack) {
        _callBack(indexPath);
    }
}



-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
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
