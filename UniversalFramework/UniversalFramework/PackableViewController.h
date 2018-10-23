//
//  PackableViewController.h
//  UniversalFramework
//
//  Created by ORANLLC_IOS1 on 15/10/16.
//  Copyright (c) 2015年 ORANLLC_IOS1. All rights reserved.
//

#import <UniversalFramework/UniversalFramework.h>

@interface groupView : UIView

@property(nonatomic, assign) NSInteger section;     //index

@property(nonatomic, assign) BOOL open;             //是否打开

@property(nonatomic, assign) BOOL is_search;        //是否搜索

@property (nonatomic, copy) void (^handleOpen) (id sender,NSInteger index);

@end


@interface PackableViewController : BaseTableViewController

@property (nonatomic) UITableView *tableView;

/**
 *  设置收缩表格数据源
 *
 *  @param dataSource 表格数据源，数组里面存字典
 */
@property (nonatomic,strong) NSArray *dataSource;

//返回分组视图，子类覆盖
-(groupView *) getGroupview:(id) groupData index:(NSInteger) sectionIndex;



@end
