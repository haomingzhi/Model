//
//  PublishCommentDelegateObj.m
//  yihui
//
//  Created by wujiayuan on 15/9/23.
//  Copyright (c) 2015年 ORANLLC_IOS1. All rights reserved.
//

#import "PublishCommentDelegateObj.h"
#import "JYTableViewCellManager.h"
@implementation PublishCommentDelegateObj
{
    JYTableViewCellManager *_cellManager;
    UITableView *_tableView;
    NSMutableArray *_dataArr;
    NSString *_titleStr;
    UIViewController *mycontext;
}
-(NSString *)getTitle
{
    return @"发布评论";
}

-(void)initCellsWithData:(NSMutableArray *)cellArr
{
    [_cellManager addSection];
    [_cellManager addTableViewCell:_tableView cellClass:@"TextViewCanChangeTableViewCell" cellDataDic:[NSMutableDictionary dictionaryWithDictionary:@{@"text":_titleStr?:@"",@"indexPath":[NSIndexPath indexPathForItem:0 inSection:0],@"placeholder":@"填写评论",@"minHeight":@(120)}] handleAction:^(id obj){
        _titleStr = obj[@"text"];
        
        UIColor *buttonTitleColor = _titleStr.length >0 ? kUIColorFromRGB(color_main_bottom_default) : [UIColor lightGrayColor];
        UIButton *btn = (UIButton *)mycontext.navigationItem.rightBarButtonItem.customView;
        [btn setTitleColor:buttonTitleColor forState:UIControlStateNormal];
        
        NSIndexPath *indexPath = obj[@"indexPath"];
        JYBaseTableViewCell *cell = [_cellManager getRowCell:indexPath];
        NSMutableDictionary *dic =  (NSMutableDictionary*)cell.dataDic[@"dataDic"];
        dic[@"text"] = _titleStr;
        if ([obj[@"refresh"] boolValue]) {
            id c = [_tableView cellForRowAtIndexPath:indexPath];
            UITextView *txtView = [c valueForKey:@"textView"];
            [txtView becomeFirstResponder];
        }
    }];
    
    [cellArr addObjectsFromArray:[_cellManager getSectionArr]];
    [_tableView reloadData];
}
-(void)initTableViewCells:(NSMutableArray *)cellArr withTableView:(UITableView *)tableView
{
    [self initTableViewCells:cellArr withTableView:tableView context:NULL];
    
}

-(void)initTableViewCells:(NSMutableArray *)cellArr withTableView:(UITableView *)tableView context:(UIViewController *)context
{
    mycontext = context;
    _cellManager = [JYTableViewCellManager manager];
    //注册cell
    _tableView = tableView;
    _dataArr = [NSMutableArray array];
    [self initData:cellArr];//异步初始化，异步调用
}

-(void)rightHandleActon:(UIButton *)btn
{
    if (!_titleStr ||[_titleStr isEqualToString:@""]) {
        TOASTSHOW(@"评论内容不能为空哦");
        return;
    }
    btn.enabled = NO;
    if (_callBack) {
        _callBack(_titleStr);
    }
}
@end
