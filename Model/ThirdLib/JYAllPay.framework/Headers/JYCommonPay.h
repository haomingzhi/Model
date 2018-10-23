//
//  JYCommonPay.h
//  TestPayApp
//
//  Created by air on 15/6/5.
//  Copyright (c) 2015年 air. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JYCommonPayDelegate.h"
#define kAlipayWay @"alipayWay"//支付宝支付
#define kUPPayWay @"UPPayWay"//银联支付
#define kUPAPayWay @"UPAPayWay"//苹果银联支付
#define kWxPayWay @"WxPayWay"//微信支付
#define kWxAppId @"appId"
#define kWxAppDes @"des"
//typedef void(^CompletionBlock)(NSDictionary *resultDic);
@interface JYCommonPay : NSObject
@property(nonatomic,strong)id<JYCommonPayDelegate>delegate;
@property(nonatomic,strong)NSString * payWay;
- (void)payOrder:(NSDictionary *)payInfo
        callback:(void(^)(NSDictionary *resultDic))completionBlock;
-(BOOL)payResult:(NSDictionary *)dataDic;
+(instancetype)manager;

-(void)initPay:(NSDictionary *)dataDic;
-(void)registerNewPayWay:(NSString *)key value:(NSString*)theValue;
@end
