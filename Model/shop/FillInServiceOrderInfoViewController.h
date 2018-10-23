//
//  FillInOrderInfoViewController.h
//  oranllcshoping
//
//  Created by Steve on 2017/7/24.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import <UniversalFramework/UniversalFramework.h>
#import "BUSystem.h"

@interface FillInServiceOrderInfoViewController : BaseTableViewController
@property (weak, nonatomic) IBOutlet MyTableView *tableView;
@property (nonatomic,strong) BUServiceInfo *serviceInfo;
@property (nonatomic,assign) CGFloat sumPrice;
//@property (nonatomic,strong) NSString *shopId;
//@property (nonatomic,strong) NSString *shopName;
@end
