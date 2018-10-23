//
//  GoodsInfoViewController.h
//  compassionpark
//
//  Created by Steve on 2017/1/22.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import <UniversalFramework/UniversalFramework.h>
#import "BUSystem.h"

@interface ErrandServerInfoViewController : BaseTableViewController
@property (weak, nonatomic) IBOutlet MyTableView *tableView;

@property (nonatomic,strong) NSString *ID;
@property (nonatomic,strong) BUCourier *courier;
@end
