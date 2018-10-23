//
//  JYWxPay.h
//  TestPayApp
//
//  Created by air on 15/6/10.
//  Copyright (c) 2015年 air. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JYCommonPayDelegate.h"

@interface JYWxPay : NSObject<JYCommonPayDelegate>
+ (instancetype )manager;
//@property(nonatomic)(void)(^ss)();
-(void)registerAppId:(NSString*)appId withDescription:(NSString *)description;
@end
