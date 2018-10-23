//
//  SettingIndustryDelegateObj.m
//  yihui
//
//  Created by air on 15/9/22.
//  Copyright (c) 2015年 ORANLLC_IOS1. All rights reserved.
//

#import "SettingIndustryDelegateObj.h"
#import "JYTableViewCellManager.h"
#import "BUSystem.h"
@implementation SettingIndustryDelegateObj
{
    JYTableViewCellManager *_cellManager;
    UITableView *_tableView;
    NSMutableArray *_dataArr;
    NSString *_titleStr;
    NSMutableArray *_cellArr;
}
-(NSString *)getTitle
{
    return @"圈子行业类别";
}



-(void)initCellsWithData:(NSMutableArray *)cellArr
{
    UIEdgeInsets v = UIEdgeInsetsMake(0, 15, 0, 0);
    NSValue *n = [NSValue value:&v withObjCType:@encode(UIEdgeInsets)];
    [_cellManager remvoAllSections];
    [_cellManager addSection];
    [busiSystem.agent.industryArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        BUIndustry *idy = obj;
        [_cellManager addTableViewCell:_tableView cellClass:@"TitleTableViewCell" cellDataDic:[NSMutableDictionary dictionaryWithDictionary:@{@"title":idy.title?:@"",@"separatorInset":n,@"indexPath":[NSIndexPath indexPathForItem:0 inSection:0],@"isChecked":@(_selectedIndustry == idx)}] handleAction:^(id obj){
        }];

    }];
    [cellArr removeAllObjects];
    [cellArr addObjectsFromArray:[_cellManager getSectionArr]];
    [_tableView reloadData];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_callBack) {
        _callBack(indexPath);
    }
    [self.parentViewController.navigationController popViewControllerAnimated:YES];
}


-(void)initTableViewCells:(NSMutableArray *)cellArr withTableView:(UITableView *)tableView
{
    _cellManager = [JYTableViewCellManager manager];
    //注册cell
    _cellArr = cellArr;
    _tableView = tableView;
    _dataArr = [NSMutableArray array];
    if(!busiSystem.agent.industryArr||busiSystem.agent.industryArr.count < 2)
    {
    [self getData];
   
    }
    else
    {
    [self initData:_cellArr];
    }
}

-(void)getData
{
    HUDSHOW(LoadingHintString);
   [busiSystem.agent IndustryObserver:self callback:@selector(IndustryNotification:)];
}

-(void)IndustryNotification:(BSNotification *)noti
{
    BASENOTIFICATION(noti);
//    [_cellArr addObjectsFromArray:busiSystem.agent.industryArr];
   [self initData:_cellArr];//异步初始化，异步调用
}

@end
