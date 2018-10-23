//
//  ChoseAddressViewController.h
//  compassionpark
//
//  Created by Steve on 2017/2/14.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import <UniversalFramework/UniversalFramework.h>
#import "BUSystem.h"

@interface ChoseAddressViewController : JYBaseViewController<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet MyTableView *tableView;
@property (nonatomic,assign) NSInteger state;//0:收货地址(商品) 1:自提地址(商品) 2:考试地址
@property (nonatomic,strong) void (^callBack)(id o);
@property (nonatomic,strong) BUUserAddress *address;
@end
