//
//  InvoiceViewController.h
//  oranllcshoping
//
//  Created by Steve on 2017/7/26.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import <UniversalFramework/UniversalFramework.h>

@interface InvoiceViewController : BaseTableViewController
@property (weak, nonatomic) IBOutlet MyTableView *tableView;
@property (nonatomic,strong) BSJSON *json;
@end
