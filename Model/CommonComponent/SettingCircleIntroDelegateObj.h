//
//  SettingCircleIntroDelegateObj.h
//  yihui
//
//  Created by air on 15/9/21.
//  Copyright (c) 2015年 ORANLLC_IOS1. All rights reserved.
//

#import "BaseTableViewDelegateObj.h"

@interface SettingCircleIntroDelegateObj : BaseTableViewDelegateObj
@property(nonatomic,strong) void (^callBack)(id obj);
@property(nonatomic,strong) NSString *circleIntro;
@end
