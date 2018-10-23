//
//  FindInfoViewController.h
//  rentingshop
//
//  Created by air on 2018/4/2.
//  Copyright © 2018年 ORANLLC_IOS1. All rights reserved.
//

#import <UniversalFramework/UniversalFramework.h>
#import "OnlyTitleTableViewCell.h"
@interface FindInfoViewController : BaseTableViewController
@property (strong, nonatomic)  OnlyTitleTableViewCell *contentCell;
@property (strong, nonatomic)NSString *sId;
@property (strong, nonatomic)NSString *content;
@property (strong,nonatomic) NSString *name;
@property (strong, nonatomic) IBOutlet MyTableView *tableView;
@end
