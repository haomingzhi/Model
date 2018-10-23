//
//  BaseTableViewController.m
//  JiXie
//
//  Created by ORANLLC_IOS1 on 15/6/30.
//  Copyright (c) 2015年 ORANLLC_IOS1. All rights reserved.
//

#import "BaseTableViewController.h"
#import "MyTableView.h"

@interface BaseTableViewController ()

@end

@implementation BaseTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTableViews];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.shadowImage = nil;

}

-(void) setTableViews
{
    [BSUtility loopView:self.view condition:^BOOL(UIView * tableView) {
        return [tableView isKindOfClass:[UITableView class]];
    } finded:^BOOL(UIView *findedView) {
        UITableView *tableView = (UITableView *) findedView;
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.backgroundColor = kUIColorFromRGB(0xf5f5f5);
        tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, 1)];
        if ([tableView isKindOfClass:[MyTableView class]]) {
            MyTableView *myTableView = (MyTableView *) findedView;
            myTableView.refreshHeaderView =  [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0, 0, 1, 1)];
            myTableView.refreshHeaderView.delegate = self;
            myTableView.refreshFooterView = [[EGORefreshTableFooterView alloc] initWithFrame:CGRectMake(0, 0, 1, 40)];
            myTableView.refreshFooterView.showLoading = YES;
            myTableView.refreshFooterView.delegate = self;
            myTableView.headHasMore = YES;
            //myTableView.backgroundColor = kUIColorFromRGB(color_backgroundView);
        }
        return NO;
    }];
  
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [tableView setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

-(void)viewDidLayoutSubviews
{
    [BSUtility loopView:self.view condition:^BOOL(UIView * tableView) {
        return [tableView isKindOfClass:[UITableView class]];
    } finded:^BOOL(UIView *findedView) {
        UITableView *tableView = (UITableView *) findedView;
        if ([tableView respondsToSelector:@selector(setSeparatorInset:)]) {
            [tableView setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
        }
        if ([tableView respondsToSelector:@selector(setLayoutMargins:)]) {
            [tableView setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
        }
        return NO;
    }]; 
}

-(void) refreshTableHeaderNotification:(BSNotification *) noti myTableView:(MyTableView*) tableView
{
    [tableView.refreshHeaderView resetState:YES];
    [tableView.refreshFooterView setStatusText:@""];
    [tableView.refreshFooterView resetState:YES];
}

#pragma mark -- EGORefreshTableHeaderDelegate
//todo 调用网络层，然后在回调中执行[self.tableView.refreshHeaderView resetState:YES];
- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view
{
    [self refreshCurentPage];
}

- (NSString*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view
{
//    return [BSUtility getSystemTime];
    return @"";
}

#pragma mark -- EGORefreshTableFooterDelegate

- (void)egoRefreshTableFooterDidTriggerRefresh:(EGORefreshTableFooterView*)view
{
    MyTableView *tableView = (MyTableView*) view.superview;
    //这里控制显示loading和控制显示的文字。。。并且进行网络调用
    view.showLoading = YES;
    if (tableView.hasMore) {
        [view setStatusText:@"加载更多..."];
        [self loadNextPage];
    }
    else{
        [view setStatusText:@"没有更多数据了"];
        [view resetState:false];
    }

}


-(void) refreshCurentPage
{
    NSLog(@"%@",@"没实现");
}

@end
