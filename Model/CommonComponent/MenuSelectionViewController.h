//
//  MenuSelectionViewController.h
//  deliciousfood
//
//  Created by Steve on 2017/2/17.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import <UniversalFramework/UniversalFramework.h>

@interface MenuSelectionViewController : JYBaseViewController<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet MyTableView *tableView;
@property (nonatomic,strong) void (^callBack) (id o);
@property (nonatomic,strong) NSIndexPath *curIndexPath;
+(MenuSelectionViewController *)toMenuSelectionVC:(NSArray*)dataArr withIndex:(NSInteger)index;
@end
