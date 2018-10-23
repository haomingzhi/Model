//
//  AddManagerDelegateObj.h
//  yihui
//
//  Created by wujiayuan on 15/9/27.
//  Copyright (c) 2015年 ORANLLC_IOS1. All rights reserved.
//

#import "BaseTableViewDelegateObj.h"

@interface AddManagerDelegateObj : BaseTableViewDelegateObj
@property(nonatomic,strong) NSMutableArray *selectedArr;

-(id)addManager:(id)d;
@property(nonatomic,strong) void (^callBack)(id obj);
@end
