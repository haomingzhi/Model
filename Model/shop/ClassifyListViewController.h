//
//  ClassifyListViewController.h
//  intelligentgarbagecollection
//
//  Created by Steve on 2017/12/7.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import <UniversalFramework/UniversalFramework.h>
#import "MyCollectionView.h"
#import "BUSystem.h"

@interface ClassifyListViewController : BaseTableViewController
@property (strong,nonatomic) NSString *typetId;
@property (strong,nonatomic) NSString *parentId;
//@property (nonatomic,strong) BUClassify *classify;
@property (weak, nonatomic) IBOutlet MyTableView *tableView;

@end
