//
//  PayOrderViewController.h
//  oranllcshoping
//
//  Created by Steve on 2017/7/27.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import <UniversalFramework/UniversalFramework.h>
#import "BUSystem.h"

@interface PayOrderViewController : BaseTableViewController
@property (weak, nonatomic) IBOutlet MyTableView *tableView;
//@property (nonatomic,strong) BUSubmitCart *submitCart;
@property (nonatomic,strong) BUSubmitOrder *order;
@property (nonatomic)NSInteger mode;
@property (nonatomic)NSInteger sec;
@property (nonatomic)NSInteger min;
@property (nonatomic) BOOL isSubmitOrder;
@property (nonatomic,strong) NSString *orderType; // 1-正常订单支付(第一次支付) 2-续租申请，3-买断支付 4-续租 ,
@property (nonatomic,strong) NSString *typeId; //  类型id（正常传订单id 续租申请/买断传记录表id）
@end
