//
//  MemberCheckDelegateObj.m
//  yihui
//
//  Created by air on 15/9/25.
//  Copyright (c) 2015年 ORANLLC_IOS1. All rights reserved.
//

#import "MemberCheckDelegateObj.h"
#import "JYTableViewCellManager.h"
#import "BUSystem.h"
#import "JYCommonTool.h"
@implementation MemberCheckDelegateObj
{
    JYTableViewCellManager *_cellManager;
    UITableView *_tableView;
    NSMutableArray *_dataArr;
    NSMutableArray *_tempArr;
    NSMutableArray *_sectionArr;
    NSMutableArray *_selectedDataArr;
}

-(NSString *)getTitle
{
    return @"成员审核";
}

-(void)getData
{
    if (_getDataCallBack) {
        _getDataCallBack(self,@selector(getCircleApplyNotification:));
    }
    else
    {
//    busiSystem.circleUserManager.userList = nil;
//    [busiSystem.circleUserManager getCircleApply:busiSystem.homePageManager.cid  observer:self callback:@selector(getCircleApplyNotification:)];
    }
}

-(void)getCircleApplyNotification:(BSNotification *)noti
{
    BASENOTIFICATION(noti);
//    [_dataArr addObjectsFromArray:busiSystem.circleUserManager.userList];
    _sectionArr = _dataArr;//[self getSectionData:_dataArr];
    [self initData:_tempArr];//异步初始化，异步调用
}

-(void)initCellsWithData:(NSMutableArray *)cellArr
{
    _selectedDataArr = [NSMutableArray array];
//    UIEdgeInsets v = UIEdgeInsetsMake(0, 0, 0, 0);
//    NSValue *n = [NSValue value:&v withObjCType:@encode(UIEdgeInsets)];
//    
//    
//    void (^handleAction)(NSDictionary *) = ^(NSDictionary *dic){
//        UIButton *btn = dic[@"obj"];
//        btn.selected = !btn.selected;
//        NSIndexPath *indexPath = dic[@"indexPath"];
//        JYBaseTableViewCell *cell = [_cellManager getRowCell:indexPath];
//        BUCircleUser *cUsr = _sectionArr[indexPath.row];
//        if (btn.selected) {
//            if(![_selectedArr containsObject:cell])
//            {
//                [_selectedArr addObject:cell];
//                [_selectedDataArr addObject:cUsr];
//            }
//        }
//        else
//        {
//            [_selectedArr removeObject:cell];
//            [_selectedDataArr removeObject:cUsr];
//        }
//        cell.dataDic = [NSMutableDictionary dictionaryWithDictionary:cell.dataDic];
//        cell.dataDic[@"dataDic"] = [NSMutableDictionary dictionaryWithDictionary:cell.dataDic[@"dataDic"]];
//        NSMutableDictionary *ddic = cell.dataDic[@"dataDic"];
//        ddic[@"isChecked"] = @(btn.selected);
//        
//    };

        [self addSectionWithDataObj:_tableView widthCellArr:_sectionArr withSectionName:nil withHandleAction:^{
            
        } ];

    [cellArr addObjectsFromArray:[_cellManager getSectionArr]];
    [_tableView reloadData];
    _allCount = _dataArr.count;
    _tableView.height = __SCREEN_SIZE.height - 80 - 64;
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"dataDic"]) {
        
        //        JYBaseTableViewCell *cell = (JYBaseTableViewCell *)object;
        //        if([cell.dataDic[@"dataDic"][@"isChecked"] boolValue])
        //        {
        //
        //        }
        //        else
        //        {
        self.changeMark = @"N";
        //        }
        NSLog(@"change what:%@",change);
    }
    //    else if ([keyPath isEqualToString:@"count"])
    //    {
    //     self.changeMark = @"N";
    //    }
    else
    {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}



-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 24;
}
-(void)initTableViewCells:(NSMutableArray *)cellArr withTableView:(UITableView *)tableView
{
    _cellManager = [JYTableViewCellManager manager];
    //注册cell
    _tableView = tableView;
    _dataArr = [NSMutableArray array];
    _selectedArr = [NSMutableArray array];
    _tempArr = cellArr;
    [self getData];
    //    [_selectedArr addObserver:self forKeyPath:@"count" options:NSKeyValueObservingOptionNew context:nil];
}

-(id)inviteJoinCircle
{
    if (_selectedDataArr.count == 0) {
        
        return @(NO);
    }
    HUDSHOW(@"正在确认");
    if (_checkCallBack) {
        _checkCallBack(_selectedDataArr,self,@selector(inviteJoinCircleNotification:));
    }
    else
    {
//        [busiSystem.circleUserManager checkCircleMem: busiSystem.homePageManager.cid userList:_selectedDataArr observer:self callback:@selector(inviteJoinCircleNotification:)];
    }
    return @(YES);
}

-(void)inviteJoinCircleNotification:(BSNotification*)noti
{
    BASENOTIFICATION(noti);
    
    if (_callBack) {
        _callBack(self,@selector(refreshPage:));
    }
}

//没有pop出去
-(void)refreshPage:(BSNotification*)noti
{
    BASENOTIFICATION(noti);
    [_cellManager remvoAllSections];
    [_sectionArr removeAllObjects];
    [_selectedArr removeAllObjects];
    [_selectedDataArr removeAllObjects];
//    [self addSectionWithDataObj:_tableView widthCellArr:busiSystem.circleUserManager.userList withSectionName:nil withHandleAction:nil];
//    [(JYBaseTableViewController *)self.parentViewController refreshCurentPage: busiSystem.circleUserManager.userList];
}

-(NSInteger)allSelected:(BOOL)isSelected
{
    NSArray *arrs = [_cellManager getSectionArr];
    [arrs enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSArray *arr = obj;
//        NSUInteger udd = idx;
        [arr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            JYBaseTableViewCell *cell = obj;
//           BUCircleUser *cUsr = _sectionArr[idx];
            if (isSelected) {
                if (![_selectedArr containsObject:cell]) {
                    [_selectedArr addObject:obj];
//                    [_selectedDataArr addObject:cUsr];
                }
            }
            else
            {
                [_selectedArr removeObject:cell];
//                [_selectedDataArr removeObject:cUsr];
            }
            
            cell.dataDic = [NSMutableDictionary dictionaryWithDictionary:cell.dataDic];
            cell.dataDic[@"dataDic"] = [NSMutableDictionary dictionaryWithDictionary:cell.dataDic[@"dataDic"]];
            NSMutableDictionary *dic = cell.dataDic[@"dataDic"];
            dic[@"isChecked"] = @(isSelected);
            [_tableView reloadData];
            
        }];
    }];
    return _allCount;
}
-(void)addSectionWithDataObj:(UITableView *)tableView widthCellArr:(NSArray *)arr withSectionName:(NSString *)sectionName withHandleAction:(void (^)()) handleBlock
{
    void (^handleAction)(NSDictionary *) = ^(NSDictionary *dic){
        UIButton *btn = dic[@"obj"];
        btn.selected = !btn.selected;
        NSIndexPath *indexPath = dic[@"indexPath"];
        JYBaseTableViewCell *cell = [_cellManager getRowCell:indexPath];
//        NSDictionary *dsDic = _sectionArr[indexPath.section];
//        NSArray *dsArr = dsDic[@"value"];
//        BUCircleUser *cUsr = _sectionArr[indexPath.row];
        if (btn.selected) {
            if(![_selectedArr containsObject:cell])
            {
                [_selectedArr addObject:cell];
//                [_selectedDataArr addObject:cUsr];
            }
        }
        else
        {
            [_selectedArr removeObject:cell];
//            [_selectedDataArr removeObject:cUsr];
        }
        cell.dataDic = [NSMutableDictionary dictionaryWithDictionary:cell.dataDic];
        cell.dataDic[@"dataDic"] = [NSMutableDictionary dictionaryWithDictionary:cell.dataDic[@"dataDic"]];
        NSMutableDictionary *ddic = cell.dataDic[@"dataDic"];
        ddic[@"isChecked"] = @(btn.selected);
        
    };
    
    
    [_cellManager addSection];
    [arr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop)  {
        //        NSNumber *n = @(idx);
//        BUCircleUser *u = obj;
        NSInteger index = 0;
//        if (u.ask1&&![u.ask1 isEqualToString:@""]) {
//            
//            if (u.ask2&&![u.ask2 isEqualToString:@""]) {
//                index = 2;
//            }
//            else
//            {
//               index = 1;
//            }
//        }
//        else
//        {
//            index = 0;
//        }
//        NSDictionary *dic = [(JYBaseData *)obj getDataDic:index];//模型类要实现getDataDic接口协议
//        [[_cellManager addTableViewCell:_tableView cellClass:dic[@"className"] cellDataDic:dic handleAction:handleAction]addObserver:self forKeyPath:@"dataDic" options:NSKeyValueObservingOptionOld context:nil];
    }];
    
}
-(void)dealloc
{
    [[_cellManager getSectionArr] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSArray *arr = obj;
        [arr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            JYBaseTableViewCell *cell = obj;
            [cell removeObserver:self forKeyPath:@"dataDic"];
        }];
    }];
}



@end
