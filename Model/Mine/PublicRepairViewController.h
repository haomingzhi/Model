//
//  PublicRepairViewController.h
//  taihe
//
//  Created by air on 2016/11/10.
//  Copyright © 2016年 ORANLLC_IOS1. All rights reserved.
//

#import <UniversalFramework/UniversalFramework.h>
#import "TitleDetailTableViewCell.h"
#import "OnlyTitleTableViewCell.h"
#import "OnlyBottomBtnTableViewCell.h"
#import "AddImgTableViewCell.h"
#import "TextConfirmViewController.h"
#import "SheetOptionViewController.h"
@interface PublicRepairViewController : BaseTableViewController
@property(nonatomic)NSInteger mode;
@property(nonatomic)NSInteger type;
@property(nonatomic,strong)id userInfo;
@property (strong, nonatomic) IBOutlet MyTableView *tableView;
@property(strong,nonatomic)OnlyTitleTableViewCell *tipCell;
@property(strong,nonatomic)TitleDetailTableViewCell *infoCell;
@property(strong,nonatomic)TitleDetailTableViewCell *repairTypeCell;
@property(strong,nonatomic)TitleDetailTableViewCell *secondRepairStartTimeCell;
@property(strong,nonatomic)TitleDetailTableViewCell *secondRepairEndTimeCell;
@property(strong,nonatomic)TitleDetailTableViewCell *backStartTimeCell;
@property(strong,nonatomic)TitleDetailTableViewCell *backEndTimeCell;
@property(strong,nonatomic)TitleDetailTableViewCell *repairTimeCell;
@property(strong,nonatomic)TitleDetailTableViewCell *finishTimeCell;
@property(strong,nonatomic)TitleDetailTableViewCell *areaCell;
@property(strong,nonatomic)OnlyTitleTableViewCell *imgTipCell;
@property(strong,nonatomic)AddImgTableViewCell *imgsCell;

@property(strong,nonatomic)OnlyTitleTableViewCell *contentTipCell;
@property(strong,nonatomic)OnlyTitleTableViewCell *contentCell;

@property(strong,nonatomic)OnlyTitleTableViewCell *statetipCell;
@property(strong,nonatomic)TitleDetailTableViewCell *stateCell;

@property(strong,nonatomic) OnlyBottomBtnTableViewCell *submitCell;
-(void)addBottomMenuView;
@end
