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
@property(nonatomic, strong) NSMutableArray *dataArr;
@property(nonatomic, strong) NSMutableArray *cellArr;
@property(nonatomic, strong) NSMutableArray *extroDataArr;
@property(nonatomic, strong) UIView*  unfoundDataView;
@property(nonatomic, strong)BOOL (^touchesShouldBegin )(NSSet<UITouch *> *touches, UIEvent *event,UIView *view);
@property(nonatomic, assign) BOOL hasInit;
@property(nonatomic, assign) BOOL canGetData;//是否可以请求新数据
@property(nonatomic, assign) BOOL isRefreshing;
@property(nonatomic, assign) BOOL canInnerScroll;//是否子视图可以滚动
@property(nonatomic, assign) BOOL isLoadingNext;
@property(nonatomic, assign) BOOL hasMore; //设置是否有更多的数据。默认为NO 如果有则会出现refreshFooter，否则不会！！
//@property()
//添加下拉加载视图。
@property(nonatomic, assign) BOOL headHasMore;//判断头部的更多数据
-(void)isShowHeaderView:(BOOL)b;

@end
