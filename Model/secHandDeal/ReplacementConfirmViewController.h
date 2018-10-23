//
//  ReplacementConfirmViewController.h
//  intelligentgarbagecollection
//
//  Created by air on 2017/12/6.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import <UniversalFramework/UniversalFramework.h>
#import "OnlyTitleTableViewCell.h"
#import "TitleDetailTableViewCell.h"
#import "ImgAndThreeTitleTableViewCell.h"
#import "TwoTabsTableViewCell.h"
#import "OnlyTitleTableViewCell.h"
#import "OnlyBottomBtnTableViewCell.h"
#import "IconAndTitleTableViewCell.h"
#import "BUSystem.h"
@interface ReplacementConfirmViewController : BaseTableViewController
@property (strong, nonatomic)TitleDetailTableViewCell *adrCell;
@property (strong, nonatomic)OnlyTitleTableViewCell *titleCell;
@property (strong, nonatomic)ImgAndThreeTitleTableViewCell *secHandCell;
@property (strong, nonatomic)TwoTabsTableViewCell *jfCell;
@property (strong, nonatomic)IconAndTitleTableViewCell *aliPayCell;
@property (strong, nonatomic)IconAndTitleTableViewCell *wxPayCell;
@property (strong, nonatomic)OnlyTitleTableViewCell *payWayCell;
@property (strong, nonatomic)OnlyBottomBtnTableViewCell * submitCell;
@property (strong, nonatomic)BUGetSecondhandGoods *secondHandGoods;
@property (strong, nonatomic) IBOutlet MyTableView *tableView;
-(void)initTableView;
@end
