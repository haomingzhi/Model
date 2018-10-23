//
//  JYTableVIewDelegate.h
//  lovecommunity
//
//  Created by air on 16/6/23.
//  Copyright © 2016年 ORANLLC_IOS1. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol JYTableViewDelegate<NSObject>
@optional
-(void)initTableView:(UITableView *)tableView;
-(void)getData:(UITableView *)tableView;
-(void)refreshData:(UITableView *)tableView;
@end
