//
//  JYAllPaySDK.h
//  UniversalFramework
//
//  Created by air on 2018/1/25.
//  Copyright © 2018年 ORANLLC_IOS1. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kAlipayWay @"alipayWay"//支付宝支付
#define kUPPayWay @"UPPayWay"//银联支付
#define kUPAPayWay @"UPAPayWay"//苹果银联支付
#define kWxPayWay @"WxPayWay"//微信支付
#define kWxAppId @"appId"
#define kWxAppDes @"des"

#if TARGET_IPHONE_SIMULATOR
//#define NSLog(format, ...)
#elif TARGET_OS_IPHONE
#import "JYAllPay.h"
#endif
@interface JYAllPaySDK : NSObject
#if TARGET_IPHONE_SIMULATOR
//#define NSLog(format, ...)
#elif TARGET_OS_IPHONE
@property(nonatomic,strong)id<JYCommonPayDelegate> delegate;
#endif
@property(nonatomic,strong)NSString * payWay;
- (void)payOrder:(NSDictionary *)payInfo
        callback:(void(^)(NSDictionary *resultDic))completionBlock;
-(BOOL)payResult:(NSDictionary *)dataDic;
+(instancetype)manager;

-(void)initPay:(NSDictionary *)dataDic;
-(void)registerNewPayWay:(NSString *)key value:(NSString*)theValue;
@end
