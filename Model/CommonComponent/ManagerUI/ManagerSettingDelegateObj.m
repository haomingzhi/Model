//
//  ManagerSettingDelegateObj.m
//  yihui
//
//  Created by air on 15/9/14.
//  Copyright (c) 2015年 ORANLLC_IOS1. All rights reserved.
//

#import "ManagerSettingDelegateObj.h"
#import "JYTableViewCellManager.h"
#import "BUSystem.h"
@implementation ManagerSettingDelegateObj
{
    JYTableViewCellManager *_cellManager;
    UITableView *_tableView;
    NSMutableArray *_dataArr;
    NSMutableArray *_tempArr;
    NSIndexPath *_delIndexPath;
}

-(NSString *)getTitle
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshNotification) name:@"refreshManagerSeting" object:nil];
    return @"管理员设置";
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)getData
{
//    BUAdmin *ad = [[BUAdmin alloc] init];
//    ad.name = @"gggb";
//    ad.head = [[BUImageRes alloc] init];
//    ad.circle_uid = @"1";
//    ad.company = @"xxxx";
//    ad.position = @"sssss";
//    BUAdmin *ad2 = [[BUAdmin alloc] init];
//    ad2.name = @"zzzz";
//    ad2.head = [[BUImageRes alloc] init];
//    ad2.circle_uid = @"1";
//    ad2.company = @"aaa";
//    ad2.position = @"www";
//    [_dataArr addObjectsFromArray:@[ad,ad2]];
//    [self initData:_tempArr];//异步初始化，异步调用
    busiSystem.circleAdminManager.adminList = nil;
    [busiSystem.circleAdminManager getAdminList:busiSystem.homePageManager.cid observer:self callback:@selector(getAdminListNotification:)];
    [busiSystem.circleAdminManager getAdminRole:busiSystem.homePageManager.cid observer:self callback:@selector(getAdminRoleNotification:)];
}

-(void)getAdminRoleNotification:(BSNotification *)noti
{
BASENOTIFICATION(noti);
  }

-(void)getAdminListNotification:(BSNotification *)noti
{
    BASENOTIFICATION(noti);
    [_dataArr addObjectsFromArray:busiSystem.circleAdminManager.adminList];
    [self initData:_tempArr];//异步初始化，异步调用
}

-(void)initCellsWithData:(NSMutableArray *)cellArr
{
    [self.parentViewController performSelector:@selector(deleteAllCelllManager) withObject:nil];
    UIEdgeInsets c =  UIEdgeInsetsMake(0, 0, 0, 0);
    NSValue *m = [NSValue value:&c withObjCType:@encode(UIEdgeInsets)];
     [_cellManager addSection];
    [_cellManager addTableViewCell:_tableView cellClass:@"OnlyTitleTableViewCell" cellDataDic:@{@"title":@"管理者",@"textColor":kUIColorFromRGB(mainColor),@"separatorInset":m,@"textFont":[UIFont systemFontOfSize:12]} handleAction:nil];
    [_dataArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        BUAdmin *a = obj;
        [_cellManager addTableViewCell:_tableView cellClass:@"HeadImgAndInfoTableViewCell" cellDataDic:@{@"name":a.name,@"separatorInset":m,@"img":a.head} handleAction:nil];
    }];

    [_cellManager addTableViewCell:_tableView cellClass:@"BtnAndTitleTableViewCell" cellDataDic:@{} handleAction:^(id obj){
        if (_callBack) {
            _callBack(@(_dataArr.count));//将已有管理员个数返回
        }
    }];
    
    [cellArr addObjectsFromArray:[_cellManager getSectionArr]];
    [_tableView reloadData];
}
-(void)initTableViewCells:(NSMutableArray *)cellArr withTableView:(UITableView *)tableView
{
    _cellManager = [JYTableViewCellManager manager];
    //注册cell
    _tableView = tableView;
    _tempArr = cellArr;
    _dataArr = [NSMutableArray array];
    [self getData];
}


-(void)deleteCellHandleAction:(NSIndexPath *)indexPath//删除单元格
{
    _delIndexPath = indexPath;
 BUAdmin *admin = _dataArr[indexPath.row - 1];
    [busiSystem.circleAdminManager delAdmin:busiSystem.homePageManager.cid adminId:admin.circle_uid observer:self callback:@selector(delAdminNotification:)];
}

-(void)delAdminNotification:(BSNotification *)noti
{
    BASENOTIFICATION(noti);
   BUAdmin *ad = _dataArr[_delIndexPath.row - 1];
    [_dataArr removeObject:ad];
    if (_refreshCallBack) {
        [_cellManager remvoAllSections];
//       NSArray *arn = [NSMutableArray arrayWithArray:@[@{@"key":@"管理者",@"value":_dataArr}]];
        UIEdgeInsets c =  UIEdgeInsetsMake(0, 0, 0, 0);
        NSValue *m = [NSValue value:&c withObjCType:@encode(UIEdgeInsets)];
        [_cellManager addSection];
        [_cellManager addTableViewCell:_tableView cellClass:@"OnlyTitleTableViewCell" cellDataDic:@{@"title":@"管理者",@"textColor":kUIColorFromRGB(mainColor),@"separatorInset":m,@"textFont":[UIFont systemFontOfSize:12]} handleAction:nil];
        [_dataArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            BUAdmin *a = obj;
            [_cellManager addTableViewCell:_tableView cellClass:@"HeadImgAndInfoTableViewCell" cellDataDic:@{@"name":a.name,@"separatorInset":m,@"img":a.head} handleAction:nil];
        }];
        
        [_cellManager addTableViewCell:_tableView cellClass:@"BtnAndTitleTableViewCell" cellDataDic:@{} handleAction:^(id obj){
            if (_callBack) {
                _callBack(@(_dataArr.count));//将已有管理员个数返回
            }
        }];

        _refreshCallBack([_cellManager getSectionArr]);
    }
}

-(void)refreshNotification
{
    [_cellManager remvoAllSections];
    [_dataArr removeAllObjects];
    [self getData];
//    if (_refreshNotificationCallBack) {
//        _refreshNotificationCallBack();
//    }
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *arr = [_cellManager getSectionArr][0];
        if (indexPath.row ==  arr.count - 1) {
            NSLog(@"no no no ooo");
            return UITableViewCellEditingStyleNone;
        }
        return UITableViewCellEditingStyleDelete;
}


@end
