//
//  MyTableView.h
//  MiniClient
//
//  Created by apple on 14-7-13.
//  Copyright (c) 2014年 SunnadaSoft. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "EGORefreshTableHeaderView.h"
#import "EGORefreshTableFooterView.h"




/*
 集合了下拉刷新和上推加载的表格控制器类
 */
@interface MyTableView : UITableView


//加载下拉刷新视图。
@property(nonatomic, strong) EGORefreshTableHeaderView *refreshHeaderView;
@property(nonatomic, strong) EGORefreshTableFooterView *refreshFooterView;

@property(nonatomic, assign) BOOL hasMore; //设置是否有更多的数据。默认为NO 如果有则会出现refreshFooter，否则不会！！


//添加下拉加载视图。


@end
