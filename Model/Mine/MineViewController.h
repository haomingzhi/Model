//
//  MineViewController.h
//  B2C
//
//  Created by air on 15/7/14.
//  Copyright (c) 2015年 ORANLLC_IOS1. All rights reserved.
//

#import <UniversalFramework/UniversalFramework.h>

@interface MineViewController : BaseTableViewController

@property (strong, nonatomic) IBOutlet UITableViewCell *tableCellUser;

@property (weak, nonatomic) IBOutlet UIImageView *imageViewUserLogo;

@property (weak, nonatomic) IBOutlet UILabel *labelUserName;

@property (weak, nonatomic) IBOutlet MyTableView *tableViewMine;

//-(void)toWitchView:(id)data type:(NSInteger)type;
@end
