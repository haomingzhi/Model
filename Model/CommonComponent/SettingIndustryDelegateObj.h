//
//  SettingIndustryDelegateObj.h
//  yihui
//
//  Created by air on 15/9/22.
//  Copyright (c) 2015年 ORANLLC_IOS1. All rights reserved.
//

#import "BaseTableViewDelegateObj.h"

@interface SettingIndustryDelegateObj : BaseTableViewDelegateObj
@property(nonatomic,weak)UIViewController *parentViewController;
@property(nonatomic,strong)void (^callBack)(id obj);
@property(nonatomic)NSInteger selectedIndustry;
@end
