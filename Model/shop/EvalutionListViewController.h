//
//  EvalutionListViewController.h
//  intelligentgarbagecollection
//
//  Created by Steve on 2017/12/6.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import <UniversalFramework/UniversalFramework.h>

@interface EvalutionListViewController : BaseTableViewController
@property (weak, nonatomic) IBOutlet MyTableView *tableView;
@property (nonatomic,strong) NSString *goodsId;
//@property (nonatomic,strong) NSString *serviceId;
@end
