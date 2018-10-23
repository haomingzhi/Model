//
//  SettingCircleIntroDelegateObj.m
//  yihui
//
//  Created by air on 15/9/21.
//  Copyright (c) 2015年 ORANLLC_IOS1. All rights reserved.
//

#import "SettingCircleIntroDelegateObj.h"
#import "JYTableViewCellManager.h"
@implementation SettingCircleIntroDelegateObj
{
    JYTableViewCellManager *_cellManager;
    UITableView *_tableView;
    NSMutableArray *_dataArr;
    NSString *_titleStr;
    UIViewController *mycontext;
}
-(NSString *)getTitle
{
    return @"圈子简介";
}

-(void)initCellsWithData:(NSMutableArray *)cellArr
{
    if (_circleIntro) {
        _titleStr = _circleIntro;
    }
    [_cellManager addSection];
    [_cellManager addTableViewCell:_tableView cellClass:@"TextViewCanChangeTableViewCell" cellDataDic:[NSMutableDictionary dictionaryWithDictionary:@{@"text":_titleStr?:@"",@"indexPath":[NSIndexPath indexPathForItem:0 inSection:0],@"placeholder":@"完善圈子简介",@"minHeight":@(100)}] handleAction:^(id obj){
        _titleStr = obj[@"text"];
        NSIndexPath *indexPath = obj[@"indexPath"];
        JYBaseTableViewCell *cell = [_cellManager getRowCell:indexPath];
        NSMutableDictionary *dic =  (NSMutableDictionary*)cell.dataDic[@"dataDic"];
        dic[@"text"] = _titleStr;
        if ([obj[@"refresh"] boolValue]) {
            id c = [_tableView cellForRowAtIndexPath:indexPath];
            UITextView *txtView = [c valueForKey:@"textView"];
            [txtView becomeFirstResponder];
        }
        UIColor *buttonTitleColor = _titleStr.length >0 ? kUIColorFromRGB(color_main_bottom_default) : [UIColor lightGrayColor];
        UIButton *btn = (UIButton *)mycontext.navigationItem.rightBarButtonItem.customView;
        [btn setTitleColor:buttonTitleColor forState:UIControlStateNormal];
    }];
    
    [cellArr addObjectsFromArray:[_cellManager getSectionArr]];
    [_tableView reloadData];
}

-(void) initTableViewCells:(NSMutableArray *)cellArr withTableView:(UITableView *)tableView context:(UIViewController *)context
{
    mycontext = context;
    _cellManager = [JYTableViewCellManager manager];
    //注册cell
    _tableView = tableView;
    _dataArr = [NSMutableArray array];
    [self initData:cellArr];//异步初始化，异步调用
}

-(void)initTableViewCells:(NSMutableArray *)cellArr withTableView:(UITableView *)tableView
{
    [self initTableViewCells:cellArr withTableView:tableView context:NULL];
    
}

-(void)rightHandleActon:(UIButton *)btn
{
    if (_callBack) {
        _callBack(_titleStr);
    }
}
@end
