//
//  ManagerSettingDelegateObj.h
//  yihui
//
//  Created by air on 15/9/14.
//  Copyright (c) 2015年 ORANLLC_IOS1. All rights reserved.
//

#import "BaseTableViewDelegateObj.h"

@interface ManagerSettingDelegateObj : BaseTableViewDelegateObj
@property(nonatomic,strong) void (^callBack)(id obj);
@property(nonatomic,strong) void (^refreshCallBack)(id obj);
@property(nonatomic,strong) void (^refreshNotificationCallBack)();
@end
