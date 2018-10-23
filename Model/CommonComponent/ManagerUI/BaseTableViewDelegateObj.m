//
//  TestBaseTableViewDelegateObj.m
//  TestTableView
//
//  Created by wujiayuan on 15/8/13.
//  Copyright (c) 2015年 wujyapp. All rights reserved.
//

#import "BaseTableViewDelegateObj.h"
#import "JYTableViewCellManager.h"


@implementation BaseTableViewDelegateObj
{
    JYTableViewCellManager *_cellManager;
    UITableView *_tableView;
    NSMutableArray *_dataArr;
}

-(void)initData:(NSMutableArray *)cellArr
{
//    [self performSelectorInBackground:@selector(initCellsWithData:)  withObject:cellArr];
    [self initCellsWithData:cellArr];
}

-(void)initTableViewCells:(NSMutableArray *)cellArr
{

}

-(void)initTableViewCells:(NSMutableArray *)cellArr withData:(NSMutableArray*)dataArr
{

}

-(NSString *)getTitle
{
   return @"管理公司";
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
    [_cellManager addTableViewCell:_tableView cellClass:@"ImgTitleAndDetailTableViewCell" cellDataDic:@{@"title":@"权限设置",@"imgSize":v,@"img":@"icon_permissions"} handleAction:nil].accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [_cellManager addSection];
      [_cellManager addTableViewCell:_tableView cellClass:@"ImgTitleAndDetailTableViewCell" cellDataDic:@{@"title":@"设置问题",@"imgSize":v} handleAction:nil].accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [cellArr addObjectsFromArray:[_cellManager getSectionArr]];
    [_tableView reloadData];
}

-(void)registerTableViewCell:(NSString *)tableViewCellName withTableView:(UITableView *)tableView
{
    [tableView registerNib:[UINib nibWithNibName:tableViewCellName bundle:nil] forCellReuseIdentifier:tableViewCellName];
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
