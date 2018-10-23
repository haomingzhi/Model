//
//  SecondCallViewController.h
//  rentingshop
//
//  Created by air on 2018/3/27.
//  Copyright © 2018年 ORANLLC_IOS1. All rights reserved.
//

#import <UniversalFramework/UniversalFramework.h>
#import "BUSystem.h"
@interface SecondCallViewController : BaseTableViewController
@property(nonatomic)NSInteger mode;//0不能支付 1可以支付
@property(nonatomic,strong)NSString *orderId;
@end
