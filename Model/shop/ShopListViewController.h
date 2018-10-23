//
//  ShopListViewController.h
//  intelligentgarbagecollection
//
//  Created by Steve on 2017/12/5.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import <UniversalFramework/UniversalFramework.h>
#import "BUSystem.h"

@interface ShopListViewController : BaseTableViewController
@property (weak, nonatomic) IBOutlet MyTableView *tableView;
@property (nonatomic,strong) BUShopType *type;
@end
