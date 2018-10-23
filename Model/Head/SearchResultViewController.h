//
//  SearchResultViewController.h
//  oranllcshoping
//
//  Created by air on 2017/8/2.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import <UniversalFramework/UniversalFramework.h>

@interface SearchResultViewController : BaseTableViewController
@property (strong, nonatomic) IBOutlet UIView *searchView;
@property (strong, nonatomic) IBOutlet UITextField *textTf;

@property (strong, nonatomic) NSString *searchText;
@property (strong, nonatomic) IBOutlet MyTableView *tableView;

@end
