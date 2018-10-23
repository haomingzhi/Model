//
//  QuestionViewController.h
//  oranllcshoping
//
//  Created by air on 2017/8/4.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import <UniversalFramework/UniversalFramework.h>
#import "OnlyTitleTableViewCell.h"
@interface QuestionViewController : BaseTableViewController
  @property (strong, nonatomic)  OnlyTitleTableViewCell *contentCell;
@property (strong, nonatomic)NSString *sId;
@property (strong, nonatomic)NSString *content;
@property (strong, nonatomic) IBOutlet MyTableView *tableView;
@end
