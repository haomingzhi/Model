//
//  MineInfoViewController.h
//  JiXie
//
//  Created by ORANLLC_IOS1 on 15/5/25.
//  Copyright (c) 2015年 ORANLLC_IOS1. All rights reserved.
//



@interface MineInfoViewController : BaseTableViewController

@property (weak, nonatomic) IBOutlet UITableView *tableViewMine;


@property (strong, nonatomic) IBOutlet UITableViewCell *cellUserLogo;


@property (weak, nonatomic) IBOutlet UIImageView *imageUserLogo;

- (void)setHeadImage:(NSArray*)imageArr;

@end
