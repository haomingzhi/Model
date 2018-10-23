//
//  SearchViewController.h
//  taihe
//
//  Created by air on 2016/11/23.
//  Copyright © 2016年 ORANLLC_IOS1. All rights reserved.
//

#import <UniversalFramework/UniversalFramework.h>

@interface SearchViewController : BaseTableViewController
@property (strong, nonatomic) IBOutlet UIView *searchView;
@property (strong, nonatomic) IBOutlet UITextField *textTf;
@property (strong, nonatomic) IBOutlet MyTableView *tableView;

@end
