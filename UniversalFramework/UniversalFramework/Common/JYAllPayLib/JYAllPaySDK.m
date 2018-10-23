//
//  JYAllPaySDK.m
//  UniversalFramework
//
//  Created by air on 2018/1/25.
//  Copyright © 2018年 ORANLLC_IOS1. All rights reserved.
//

#import "JYAllPaySDK.h"

@implementation JYAllPaySDK
{
#if TARGET_IPHONE_SIMULATOR
    //#define NSLog(format, ...)
#elif TARGET_OS_IPHONE
    JYCommonPay *_jyp;
#endif
}
- (void)payOrder:(NSDictionary *)payInfo
        callback:(void(^)(NSDictionary *resultDic))completionBlock
{
#if TARGET_IPHONE_SIMULATOR
    //#define NSLog(format, ...)
#elif TARGET_OS_IPHONE
    [_jyp payOrder:payInfo callback:completionBlock];
    #endif
}
-(BOOL)payResult:(NSDictionary *)dataDic
{
#if TARGET_IPHONE_SIMULATOR
    //#define NSLog(format, ...)
#elif TARGET_OS_IPHONE
 return    [_jyp payResult:dataDic];
    #endif
    return NO;
}
static JYAllPaySDK *sdk;
+(instancetype)manager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
   sdk = [JYAllPaySDK new];

#if TARGET_IPHONE_SIMULATOR
    //#define NSLog(format, ...)
#elif TARGET_OS_IPHONE
     sdk->_jyp = [JYCommonPay manager];
#endif
    });
    return sdk;
}
-(void)setPayWay:(NSString *)payWay
{
#if TARGET_IPHONE_SIMULATOR
    //#define NSLog(format, ...)
#elif TARGET_OS_IPHONE
    _payWay = payWay;
    [_jyp setPayWay:payWay];
    #endif
}
-(void)initPay:(NSDictionary *)dataDic
  {
#if TARGET_IPHONE_SIMULATOR
      //#define NSLog(format, ...)
#elif TARGET_OS_IPHONE
      [_jyp initPay:dataDic];
      #endif
  }
-(void)registerNewPayWay:(NSString *)key value:(NSString*)theValue
  {
#if TARGET_IPHONE_SIMULATOR
      //#define NSLog(format, ...)
#elif TARGET_OS_IPHONE
      [_jyp registerNewPayWay:key value:theValue];
      #endif
  }


@end
