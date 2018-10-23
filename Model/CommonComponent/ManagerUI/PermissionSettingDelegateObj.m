//
//  PermissionSettingDelegateObj.m
//  yihui
//
//  Created by air on 15/9/14.
//  Copyright (c) 2015年 ORANLLC_IOS1. All rights reserved.
//

#import "PermissionSettingDelegateObj.h"
#import "JYTableViewCellManager.h"
#import "BUSystem.h"
@implementation PermissionSettingDelegateObj
{
    JYTableViewCellManager *_cellManager;
    UITableView *_tableView;
    NSMutableArray *_dataArr;
    NSString *_is_open;
    NSString *_is_verify;
}
-(NSString *)getTitle
{
    [self getPessision];
    return @"权限设置";
}

-(void)initCellsWithData:(NSMutableArray *)cellArr
{
    [_cellManager addSection];//@"obj":sender,@"indexPath":sender
    [_cellManager addTableViewCell:_tableView cellClass:@"TitleAndSwichTableViewCell" cellDataDic:@{@"title":@"加入圈子时需要验证",@"isOn":@(NO)} handleAction:^(id obj){
        UISwitch *sw = obj[@"obj"];
        _is_open = sw.on?@"1":@"0";

    }];
    
    [_cellManager addSection];
    [_cellManager addTableViewCell:_tableView cellClass:@"TitleAndSwichTableViewCell" cellDataDic:@{@"title":@"圈子公开",@"isOn":@(NO)} handleAction:^(id obj){
        UISwitch *sw = obj[@"obj"];
        _is_verify = sw.on?@"1":@"0";
        
    }];
    [cellArr addObjectsFromArray:[_cellManager getSectionArr]];
    [_tableView reloadData];
}

-(void)getPessision
{
    [busiSystem.circleGroupManager.current getCircleAuth:self callback:@selector(getCircleAuthNotification:)];
}


-(void)getCircleAuthNotification:(BSNotification *)noti
{
    BASENOTIFICATION(noti);
    _is_open = busiSystem.circleGroupManager.current.is_open;
    _is_verify = busiSystem.circleGroupManager.current.verify;
    [_cellManager setTableViewCell:[_cellManager getRowCell:[NSIndexPath indexPathForRow:0 inSection:0]] withCellData:@{@"isOn":[_is_open isEqualToString:@"1"]?@(YES):@(NO)}];
    [_cellManager setTableViewCell:[_cellManager getRowCell:[NSIndexPath indexPathForRow:0 inSection:1]] withCellData:@{@"isOn":[_is_verify isEqualToString:@"1"]?@(YES):@(NO)}];
    [_tableView reloadData];
}

-(void)setPessision
{
[busiSystem.circleGroupManager.current changeAuth:_is_open verify:_is_verify release_active:@"" observer:self callback:@selector(changeAuthNotification:)];
}

-(void)changeAuthNotification:(BSNotification *)noti
{
    BASENOTIFICATION(noti);
    if (_callBack) {
        _callBack(nil);
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        UILabel *v1 = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 320, 40)];
        v1.text = @"  开启后申请加入圈组需要通过验证";
         v1.font = [UIFont systemFontOfSize:12];
        v1.textColor = [UIColor lightGrayColor];
        return  v1;
    }
    else
    {
        UILabel *v2 = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 320, 40)];
        v2.text = @"  关闭后任何用户都不能发现本圈组";
        v2.textColor = [UIColor lightGrayColor];
        v2.font = [UIFont systemFontOfSize:12];
        return v2;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}
-(void)initTableViewCells:(NSMutableArray *)cellArr withTableView:(UITableView *)tableView
{
    _cellManager = [JYTableViewCellManager manager];
    //注册cell
    _tableView = tableView;
    _dataArr = [NSMutableArray array];
    [self initData:cellArr];//异步初始化，异步调用
    
}

-(void)rightHandleActon:(UIButton *)btn
{
    btn.enabled = NO;
    HUDSHOW(LoadingHintString);
    [self setPessision];
    
}

@end
