//
//  FillInOrderInfoViewController.h
//  oranllcshoping
//
//  Created by Steve on 2017/7/24.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import <UniversalFramework/UniversalFramework.h>
#import "BUSystem.h"

@interface FillInOrderInfoViewController : BaseTableViewController
@property (weak, nonatomic) IBOutlet MyTableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataArr;
@property (nonatomic,assign) CGFloat sumPrice;
@property (nonatomic,strong) BUGoodsInfo *goodsInfo;
@property (nonatomic,strong) BUProductPrice *productPrice;
@property (nonatomic,strong) NSDate *startDate;
@property (nonatomic,strong) NSDate *endDate;
@property (nonatomic,assign) NSInteger lease;
@end
