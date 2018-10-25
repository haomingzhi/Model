//
//  RecordInfoViewController.h
//  oranllcshoping
//
//  Created by air on 2017/7/26.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import <UniversalFramework/UniversalFramework.h>
#import "BUSystem.h"
#import "AuditProgressViewController.h"
#import "TitleDetailTableViewCell.h"
#import "OnlyTitleTableViewCell.h"
#import "FiveBtnTableViewCell.h"
@interface RecordInfoViewController : BaseTableViewController
@property (nonatomic,strong) NSString *orderBackID;
@property (nonatomic,strong) TitleDetailTableViewCell *stateCell;
@property (nonatomic,strong) OnlyTitleTableViewCell *auditTipCell;
@property (nonatomic,strong) FiveBtnTableViewCell *auditCell;
@property (nonatomic,strong) OnlyTitleTableViewCell *queTipCell;
@property (nonatomic,strong) OnlyTitleTableViewCell *queCell;
@property (nonatomic,strong) OnlyTitleTableViewCell *auditNoteCell;
@property (nonatomic,strong) OnlyTitleTableViewCell *auditNoteTipCell;
@property (strong, nonatomic) IBOutlet MyTableView *tableView;
//@property (nonatomic,strong) BUSaleInfo *backInfo;
@end
