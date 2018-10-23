//
//  ShopInfoViewController.h
//  intelligentgarbagecollection
//
//  Created by Steve on 2017/12/5.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import <UniversalFramework/UniversalFramework.h>
#import "BUSystem.h"

@interface ShopInfoViewController : BaseTableViewController
@property (weak, nonatomic) IBOutlet MyTableView *tableView;
@property (nonatomic,strong) BUShopInfo *shopInfo;
@property (nonatomic,strong) NSString *shopId;
@end
