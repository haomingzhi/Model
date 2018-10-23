//
//  JYAliPay.h
//  TestPayApp
//
//  Created by air on 15/6/5.
//  Copyright (c) 2015年 air. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JYCommonPayDelegate.h"
@interface JYAliPay : NSObject<JYCommonPayDelegate>
+ (instancetype )manager;
@end
