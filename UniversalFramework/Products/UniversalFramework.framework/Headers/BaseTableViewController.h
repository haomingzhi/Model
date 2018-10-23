//
//  BaseTableViewController.h
//  JiXie
//
//  Created by ORANLLC_IOS1 on 15/6/30.
//  Copyright (c) 2015年 ORANLLC_IOS1. All rights reserved.
//

#import "BaseViewController.h"
#import "EGORefreshTableHeaderView.h"
#import "EGORefreshTableFooterView.h"

@interface BaseTableViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,EGORefreshTableHeaderDelegate,EGORefreshTableFooterDelegate>


-(void) setTableViews;
//如果不需要上拉，下拉功能，把对应的delegate置空
//todo 调用网络层，然后在回调中执行[self.tableView.refreshHeaderView resetState:YES];
- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view;
-(void) refreshTableHeaderNotification:(BSNotification *) noti myTableView:(MyTableView*) tableView;
-(void) refreshCurentPage;//刷新当前页面，头部下拉触发,网络层回调中调用、或者覆盖refreshTableHeaderNotification
-(void) loadNextPage;//加载下一页，尾部上拉触发,需要在网络层回调中，设置是否还有更多


@end
