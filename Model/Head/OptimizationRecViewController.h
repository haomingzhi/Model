//
//  OptimizationRecViewController.h
//  oranllcshoping
//
//  Created by air on 2017/8/2.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import <UniversalFramework/UniversalFramework.h>
#import "ImgTableViewCell.h"
#import "BUSystem.h"

@interface OptimizationRecViewController : BaseTableViewController
@property (strong, nonatomic) IBOutlet MyTableView *tableView;
@property (strong, nonatomic)NSString *ID;
@property (strong, nonatomic)BUOptimization  *optimization;
@property (strong, nonatomic)ImgTableViewCell *imgCell;
@end
