//
//  CustomViewController.h
//  taihe
//
//  Created by LinFeng on 2016/11/29.
//  Copyright © 2016年 ORANLLC_IOS1. All rights reserved.
//

#import <UniversalFramework/UniversalFramework.h>

@interface CustomViewController : BaseTableViewController
@property (weak, nonatomic) IBOutlet MyTableView *tableView;
@property (nonatomic,strong) NSString *scpid;
@end
