//
//  WaterInfoViewController.h
//  taihe
//
//  Created by air on 2016/11/10.
//  Copyright © 2016年 ORANLLC_IOS1. All rights reserved.
//

#import <UniversalFramework/UniversalFramework.h>
#import "TitleDetailTableViewCell.h"
#import "OnlyBottomBtnTableViewCell.h"
#import "OnlyTitleTableViewCell.h"
@interface WaterInfoViewController : BaseTableViewController
@property (strong, nonatomic) IBOutlet MyTableView *tableView;
@property(nonatomic)NSInteger mode;
@property(nonatomic,strong)id userInfo;
@property (strong, nonatomic) OnlyTitleTableViewCell *tipCell;
@property(strong,nonatomic)OnlyTitleTableViewCell *stateTipCell;
@property(strong,nonatomic)OnlyBottomBtnTableViewCell *submitCell;
@property (strong, nonatomic)TitleDetailTableViewCell *stateCell;
@property (strong, nonatomic)TitleDetailTableViewCell *infoCell;
@property (strong, nonatomic)TitleDetailTableViewCell *typeCell;
@property (strong, nonatomic)TitleDetailTableViewCell *priceCell;
@property (strong, nonatomic) TitleDetailTableViewCell *countCell;
@property (strong, nonatomic)TitleDetailTableViewCell *sendTimeCell;
@property (strong, nonatomic) TitleDetailTableViewCell *areaCell;
-(void)addBottomMenuView;
@end
