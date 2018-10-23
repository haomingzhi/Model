//
//  ScrollTwoTableViewController.h
//  lovecommunity
//
//  Created by air on 16/6/23.
//  Copyright © 2016年 ORANLLC_IOS1. All rights reserved.
//

#import <UniversalFramework/UniversalFramework.h>
#import "JYTableViewDelegate.h"
@interface ScrollTwoTableViewController : JYBaseViewController
@property(nonatomic,strong) void (^scrollHandle)(NSInteger index);
@property(nonatomic,strong)id<UITableViewDelegate,UITableViewDataSource,JYTableViewDelegate> tDelegate;
-(void)selectCurIndex:(NSInteger)index;
-(MyTableView *)getTableView;
-(void)refreshData;
-(void)setTableViewsScrollEnabled:(BOOL)b;
-(void)tableViewToTop;
-(void)refreshData:(NSInteger )index;
//-(void)deallocDelegate;
@end
