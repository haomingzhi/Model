//
//  BUPushManager.h
//  chenxiaoer
//
//  Created by air on 16/4/21.
//  Copyright © 2016年 ORANLLC_IOS1. All rights reserved.
//

#import <UniversalFramework/UniversalFramework.h>
#if TARGET_IPHONE_SIMULATOR

#elif TARGET_OS_IPHONE
#import "JPUSHService.h"
#endif
@interface BUPushManager : BUBase
#if TARGET_IPHONE_SIMULATOR

#elif TARGET_OS_IPHONE
<JPUSHRegisterDelegate>
#endif
@property(nonatomic)NSInteger pushToWhich;//启动后由主页跳去哪
@property(nonatomic,strong)NSDictionary *pushInfo;
-(void)pushToWhich:(NSDictionary *)Data;
-(void)initAPService:(NSDictionary *)launchOptions;
+(void)registerDeviceToken:(NSData *)token;
+ (void)handleRemoteNotification:(NSDictionary *)remoteInfo;
+ (void) setTags:(NSSet *)tags
           alias:(NSString *)alias
callbackSelector:(SEL)cbSelector
          object:(id)theTarget;
+ (void)setAlias:(NSString *)alias
callbackSelector:(SEL)cbSelector
          object:(id)theTarget;
+(void)resetBadge;
+(void)reduceBadge;
+ (BOOL)setBadge:(NSInteger)value;
@end
