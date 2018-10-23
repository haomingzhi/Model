//
//  MyOrderViewController.h
//  JiXie
//
//  Created by ORANLLC_IOS1 on 15/5/21.
//  Copyright (c) 2015年 ORANLLC_IOS1. All rights reserved.
//

//#import "BUTradeOrderManager.h"

@interface MyOrderViewController : BaseScrollViewController

@property (weak, nonatomic) IBOutlet UIView *tabView;

@property (weak, nonatomic) IBOutlet UIScrollView *ScrollViewOrder;

@property (strong, nonatomic) IBOutlet MyTableView *tableViewA;

@property (strong, nonatomic) IBOutlet MyTableView *tableViewB;

@property (strong, nonatomic) IBOutlet MyTableView *tableViewC;

@property (strong, nonatomic) IBOutlet MyTableView *tableViewD;

@property (strong, nonatomic) IBOutlet MyTableView *tableViewE;
@property ( nonatomic)NSInteger currentOrderStatue;
@property(strong,nonatomic)id userInfo;
//@property(nonatomic,readonly) BUTradeOrderManager *dataModel;       //交易订单管理
@property(nonatomic,readonly) NSArray *dataSource;

-(UIView *) getUnfoundView;
//滚动菜单
-(NSArray *) getScrollMenuTitles;
-(void) handleChangeOrderType:(id) sender;

@end
