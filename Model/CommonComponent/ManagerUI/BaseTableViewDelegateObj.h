//
//  TestBaseTableViewDelegateObj.h
//  TestTableView
//
//  Created by wujiayuan on 15/8/13.
//  Copyright (c) 2015年 wujyapp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JYBaseTableViewController.h"
@interface BaseTableViewDelegateObj : NSObject<JYBaseTableViewDelegate>
//-(void)registerTableViewCell:(NSString *)tableViewCellName withTableView:(UITableView *)tableView;
//-(void)addTableViewCell:(UITableView *)tableView cellClass:(NSString *)clsName cellDataDic:(NSDictionary *)dataDic;
//@property(nonatomic,strong)  UITableView *tableView;
-(void)initData:(NSMutableArray *)cellArr;
@property(nonatomic,weak) UIViewController *parentViewController;
@end
