//
//  JYTableViewCellManager.m
//  TestTableView
//
//  Created by wujiayuan on 15/8/13.
//  Copyright (c) 2015年 wujyapp. All rights reserved.
//

#import "JYTableViewCellManager.h"
#import "JYCommonTool.h"
@implementation JYTableViewCellManager
{
    NSMutableArray *_sectionArr;
    NSMutableArray *_curCellArr;
}

+(instancetype)manager
{
//    static dispatch_once_t onceToken;
//    dispatch_once (&onceToken, ^{
        JYTableViewCellManager *sharedInstance = [[self alloc] init];
       sharedInstance->_sectionArr = [NSMutableArray array];
//    });
    return sharedInstance;
}

-(void)setSection:(NSInteger)section withDataArr:(NSArray *)arr
{
   NSMutableArray *rowArr = (NSMutableArray *)[self getSection:section];
    [rowArr removeAllObjects];
    [rowArr addObjectsFromArray:arr];
}

-(void)setRow:(NSInteger)row withSection:(NSInteger)section withDataDic:(NSDictionary *)dataDic
{
    JYBaseTableViewCell *cell = [self getRowCell:row withSection:section];
    [cell.dataDic removeAllObjects];
    [cell.dataDic addEntriesFromDictionary:dataDic];
}

-(NSIndexPath *)addRow:(JYBaseTableViewCell *)cell
{
    [_curCellArr addObject:cell];
    NSInteger section = [_sectionArr indexOfObject:_curCellArr];
    NSInteger row = [_curCellArr indexOfObject:cell];
    return [NSIndexPath indexPathForRow:row inSection:section];
}

-(NSInteger)addSection
{
    _curCellArr = [NSMutableArray array];
    [_sectionArr addObject:_curCellArr];
    return [_sectionArr indexOfObject:_curCellArr];
}

-(NSArray *)getSectionArr
{
    return _sectionArr;
}

-(NSArray *)getSection:(NSInteger)section
{
    return _sectionArr[section];
}

-(JYBaseTableViewCell *)getRowCell:(NSIndexPath *)indexPath
{
    return [self getRowCell:indexPath.row withSection:indexPath.section];
}

-(JYBaseTableViewCell *)getRowCell:(NSInteger)row withSection:(NSInteger)section
{
    NSArray *arr = _sectionArr[section];
   return arr[row];
}

-(NSInteger)curRow
{
   return _curCellArr.count - 1;
}

-(NSInteger)curSection
{
    return [_sectionArr indexOfObject:_curCellArr];
}

-(void)remvoAllSections
{
    [_sectionArr removeAllObjects];
}

-(JYBaseTableViewCell *)addTableViewCell:(UITableView *)tableView cellClass:(NSString *)clsName cellDataDic:(NSDictionary *)dataDic handleAction:(void (^)(id sender)) handleAction
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:dataDic];
    [dic setObject:tableView forKey:@"tableView"];
    JYBaseTableViewCell *cell = [[JYBaseTableViewCell alloc] init];
    cell.dataDic = [NSMutableDictionary dictionaryWithDictionary:@{@"cellClass":clsName,@"tableView":tableView,@"dataDic":dic}];
    cell.handleAction = handleAction;
    [self addRow:cell];
    return cell;
}

-(void)setTableViewCell:(JYBaseTableViewCell *)obj withCellData:(NSDictionary *)dataDic
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:obj.dataDic[@"dataDic"]];
    
    [dic addEntriesFromDictionary:dataDic];
    obj.dataDic[@"dataDic"] = dic;
}

-(NSMutableArray *)getSectionData:(NSArray *)dataList  hasManager:(BOOL) hasManager withObjType:(Class)clsType withCompareWay:(BOOL (^)(id )) compareWay
{
    NSArray * nArr = dataList;
    NSMutableArray *tArr = [NSMutableArray array];
    if (hasManager) {
        
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        dic[@"key"] = @"管理者";
        dic[@"value"] = [NSMutableArray array];
        [tArr addObject:dic];
    }
    [nArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
//        clsType  *frd = obj;
        if (compareWay(obj) && hasManager) {
            NSMutableDictionary *di1 = tArr[0];
            NSMutableArray *sArr = di1[@"value"];
            [sArr addObject:obj];
        }
        else
        {
            NSString *pname ;//= frd.realNamePinYin;// [JYCommonTool toPingYin:frd.realname];
            
            
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
                dic[@"value"] = [NSMutableArray arrayWithObjects:obj, nil];
                [tArr addObject:dic];
            }
            else
            {
                NSMutableArray *sArr = selDic[@"value"];
                [sArr addObject:obj];
            }
        }
    }];
    
    if (tArr.count > 0) {
        NSMutableDictionary *di1 = tArr[0];
        NSMutableArray *sArr = di1[@"value"];
        if (sArr.count == 0 && [di1[@"key"] isEqualToString:@"管理者"]) {
            [tArr removeObject:di1];
        }
    }
    
    [tArr sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        NSString * v1 = ((NSDictionary *)obj1)[@"key"];
        NSString  *v2 = ((NSDictionary *)obj2)[@"key"];;
        NSComparisonResult sortResult =  [v1 isEqualToString:@"管理者"] ? NSOrderedAscending : [v1 compare:v2];
        return sortResult;
    }];
    
    return tArr;
}

@end
