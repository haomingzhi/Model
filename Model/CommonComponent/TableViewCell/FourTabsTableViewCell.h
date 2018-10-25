//
//  FourTabsTableViewCell.h
//  rentingshop
//
//  Created by Steve on 2018/4/26.
//  Copyright © 2018年 ORANLLC_IOS1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZJMenuView.h"
#import "BUSystem.h"
#import "OnlyTitleTableViewCell.h"
#import "NoDataTableViewCell.h"
#import "JYAbstractTableViewCell.h"
//#import "EGORefreshTableHeaderView.h"
//#import "EGORefreshTableFooterView.h"

@interface FourTabsTableViewCell : JYAbstractTableViewCell<UITableViewDelegate,UITableViewDataSource,EGORefreshTableFooterDelegate>
@property (strong, nonatomic) ZJMenuView *menuView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet MyTableView *tableViewA;
@property (weak, nonatomic) IBOutlet MyTableView *tableViewB;
@property (weak, nonatomic) IBOutlet MyTableView *tableViewC;
@property (weak, nonatomic) IBOutlet MyTableView *tableViewD;
@property (nonatomic,assign) NSInteger state;
@property (nonatomic,assign) NSInteger intruduceCellHeight;
@property (nonatomic,assign) NSInteger rentRegularCellHeight;
//@property (nonatomic,strong) BUGoodsInfo *goodsInfo;
@property (nonatomic,strong) OnlyTitleTableViewCell *intruduceCell;//图文详情
@property (nonatomic,strong) OnlyTitleTableViewCell *rentRegularCell;//租赁规则
@property (nonatomic,strong) NoDataTableViewCell *noEvaCell;
-(void)setEvaData:(NSDictionary *)dataDic;
-(void)changeTableViewScroll:(BOOL)canScroll;
@end
