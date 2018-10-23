//
//  JYTableViewCellManager.h
//  TestTableView
//
//  Created by wujiayuan on 15/8/13.
//  Copyright (c) 2015年 wujyapp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JYBaseTableViewCell.h"
@interface JYTableViewCellManager : NSObject
-(NSIndexPath *)addRow:(JYBaseTableViewCell *)cell;//高度初始化为－1
-(NSInteger)addSection;
-(NSArray *)getSectionArr;
-(NSArray *)getSection:(NSInteger)section;
-(JYBaseTableViewCell *)getRowCell:(NSInteger)row withSection:(NSInteger)section;
-(void)setRow:(NSInteger)row withSection:(NSInteger)section withDataDic:(NSDictionary *)dataDic;
-(void)setSection:(NSInteger)section withDataArr:(NSArray *)arr;
-(void)remvoAllSections;
-(JYBaseTableViewCell *)addTableViewCell:(UITableView *)tableView cellClass:(NSString *)clsName cellDataDic:(NSDictionary *)dataDic handleAction:(void (^)(id sender)) handleAction;
-(JYBaseTableViewCell *)getRowCell:(NSIndexPath *)indexPath;
-(void)setTableViewCell:(JYBaseTableViewCell *)obj withCellData:(NSDictionary *)dataDic;
-(NSMutableArray *)getSectionData:(NSArray *)dataList  hasManager:(BOOL) hasManager withObjType:(Class)clsType withCompareWay:(BOOL (^)(id )) compareWay ;
+(instancetype)manager;
@property(nonatomic,readonly) NSInteger curRow;
@property(nonatomic,readonly) NSInteger curSection;
@end
