//
//  NoticeInfoViewController.h
//  taihe
//
//  Created by air on 2016/11/16.
//  Copyright © 2016年 ORANLLC_IOS1. All rights reserved.
//

#import <UniversalFramework/UniversalFramework.h>
#import "FlashTableViewCell.h"
#import "OnlyTitleTableViewCell.h"
#import "TitleDetailTableViewCell.h"
@interface NoticeInfoViewController : BaseTableViewController
@property(nonatomic,strong)id userInfo;
@property (strong, nonatomic) IBOutlet MyTableView *tableView;
@property (strong, nonatomic)FlashTableViewCell *flashCell;
@property (strong, nonatomic)OnlyTitleTableViewCell *titleCell;
@property (strong, nonatomic) TitleDetailTableViewCell *infoCell;
@property (strong, nonatomic)OnlyTitleTableViewCell *contentCell;
@end
