//
//  AddManagerDelegateObj.m
//  yihui
//
//  Created by wujiayuan on 15/9/27.
//  Copyright (c) 2015年 ORANLLC_IOS1. All rights reserved.
//

#import "AddManagerDelegateObj.h"
#import "JYTableViewCellManager.h"
#import "BUSystem.h"
#import "JYCommonTool.h"
@implementation AddManagerDelegateObj
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
    return @"添加管理员";
}

-(void)getData
{

        busiSystem.circleAdminManager.adminList = nil;
    [busiSystem.circleAdminManager getCanSetAdmin:busiSystem.homePageManager.cid observer:self callback:@selector(getCanSetAdminNotification:)];;
}

-(void)getCanSetAdminNotification:(BSNotification *)noti
{
    BASENOTIFICATION(noti);
    [_dataArr addObjectsFromArray:busiSystem.circleAdminManager.adminList];
    _sectionArr = [self getSectionData:_dataArr];
    [self initData:_tempArr];//异步初始化，异步调用
}

-(void)initCellsWithData:(NSMutableArray *)cellArr
{
    _selectedDataArr = [NSMutableArray array];
    [_sectionArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [self addSectionWithDataObj:_tableView widthCellArr:obj[@"value"] withSectionName:obj[@"key"] withHandleAction:^{
            
        } ];
    }];
    
    [cellArr addObjectsFromArray:[_cellManager getSectionArr]];
    [_tableView reloadData];
    _tableView.height = __SCREEN_SIZE.height - 80 - 64;
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *v = [[UIView alloc] init];
    v.backgroundColor = [UIColor whiteColor];
    v.height = 22;
    UILabel *lb = [[UILabel alloc] initWithFrame:CGRectMake(15, 2, 90, 20)];
    NSDictionary *dic = _sectionArr[section];
    lb.font = [UIFont systemFontOfSize:12];
       lb.textColor = kUIColorFromRGB(mainColor);
    lb.text =  dic[@"key"];
    [v addSubview:lb];
//    UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, 21.5, __SCREEN_SIZE.width, 0.5)];
//    line.backgroundColor = [UIColor lightGrayColor];
//    [v addSubview:line];
    return v;
    
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

-(id)addManager:(id)hadAdminCount
{
 
    if (_selectedDataArr.count == 0) {
        
        return @"请选择人员";
    }
    if ([hadAdminCount integerValue] + _selectedDataArr.count > 4) {
        return @"超出人员限制个数";
    }
//    if (_callBack) {
//        _callBack(@(_selectedDataArr.count + ));
//    }
    HUDSHOW(@"正在设置");
    BURole *role = busiSystem.circleAdminManager.adminRoleManager.roleList[0];

    [busiSystem.circleAdminManager addAdmin:busiSystem.homePageManager.cid roleId:role.roleId?:@"0" adminList:_selectedDataArr observer:self callback:@selector(addManagerNotification:)];
    return @"";
}

-(void)addManagerNotification:(BSNotification*)noti
{
    BASENOTIFICATION(noti);
        if (_callBack) {
            [_selectedDataArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                [_sectionArr enumerateObjectsUsingBlock:^(id obc, NSUInteger idx, BOOL *stop) {
                    NSDictionary *dic = obc;
                   NSMutableArray *arr = dic[@"value"];
                    if ([arr containsObject:obj]) {
                        [arr removeObject:obj];
                    }
                    if (arr.count == 0) {
                        [_sectionArr removeObject:obc];
                    }
                }];
     
            }];
            
            [_selectedDataArr removeAllObjects];
            [_selectedArr removeAllObjects];
            [_cellManager remvoAllSections];
            [_sectionArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                [self addSectionWithDataObj:_tableView widthCellArr:obj[@"value"] withSectionName:obj[@"key"] withHandleAction:^{
                    
                } ];
            }];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshManagerSeting" object:nil];
            _callBack([NSMutableArray arrayWithArray:[_cellManager getSectionArr]]);
        }
}


-(void)addSectionWithDataObj:(UITableView *)tableView widthCellArr:(NSArray *)arr withSectionName:(NSString *)sectionName withHandleAction:(void (^)()) handleBlock
{
    void (^handleAction)(NSDictionary *) = ^(NSDictionary *dic){
        UIButton *btn = dic[@"obj"];
        btn.selected = !btn.selected;
        NSIndexPath *indexPath = dic[@"indexPath"];
        JYBaseTableViewCell *cell = [_cellManager getRowCell:indexPath];
        NSDictionary *dsDic = _sectionArr[indexPath.section];
        NSArray *dsArr = dsDic[@"value"];
        BUAdmin *cUsr = dsArr[indexPath.row];
        if (btn.selected) {
            if(![_selectedArr containsObject:cell])
            {
                [_selectedArr addObject:cell];
                [_selectedDataArr addObject:cUsr];
            }
        }
        else
        {
            [_selectedArr removeObject:cell];
            [_selectedDataArr removeObject:cUsr];
        }
        cell.dataDic = [NSMutableDictionary dictionaryWithDictionary:cell.dataDic];
        cell.dataDic[@"dataDic"] = [NSMutableDictionary dictionaryWithDictionary:cell.dataDic[@"dataDic"]];
        NSMutableDictionary *ddic = cell.dataDic[@"dataDic"];
        ddic[@"isChecked"] = @(btn.selected);
        
    };
    
    
    [_cellManager addSection];
    [arr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop)  {
        //        NSNumber *n = @(idx);
        
        NSDictionary *dic = [(JYBaseData *)obj getDataDic:0];//模型类要实现getDataDic接口协议
        [_cellManager addTableViewCell:_tableView cellClass:dic[@"className"] cellDataDic:dic handleAction:handleAction];
    }];
    
}


-(NSMutableArray *)getSectionData:(NSArray *)nArr
{
    NSMutableArray *tArr = [NSMutableArray array];
//    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    //    dic[@"key"] = @"管理者";
    //    dic[@"value"] = [NSMutableArray array];
    //    [tArr addObject:dic];
    [nArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        BUAdmin *user = obj;
        //        if ([frd.role integerValue] != 3) {
        //            NSMutableDictionary *di1 = tArr[0];
        //            NSMutableArray *sArr = di1[@"value"];
        //            [sArr addObject:frd];
        //        }
        //        else
        //        {
        NSString *pname = [JYCommonTool toPingYin:user.name];
        
        
        //
        BOOL has = NO;
        NSMutableDictionary *selDic;
        for (NSMutableDictionary *obj2 in tArr) {
            NSString *frd2 = obj2[@"key"];
            if ([[[pname substringToIndex:1] uppercaseString] isEqualToString:frd2]) {
                has = YES;
                selDic = obj2;
            }
            else
            {
                if([JYCommonTool hasNumberString:[pname substringToIndex:1]])
                {
                    if ([frd2 isEqualToString:@"#"]) {
                        has = YES;
                        selDic = obj2;
                    }
                    
                }
            }
        }
        
        
        if (!has) {
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            if ([JYCommonTool hasNumberString:[pname substringToIndex:1]]) {
                dic[@"key"] = @"#";
            }
            else
            {
                dic[@"key"] = [[pname substringToIndex:1] uppercaseString];
            }
            dic[@"value"] = [NSMutableArray arrayWithObjects:user, nil];
            [tArr addObject:dic];
        }
        else
        {
            NSMutableArray *sArr = selDic[@"value"];
            [sArr addObject:user];
        }
        //        }
    }];
    
    return tArr;
}

@end
