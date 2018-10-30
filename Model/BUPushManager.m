//
//  BUPushManager.m
//  chenxiaoer
//
//  Created by air on 16/4/21.
//  Copyright © 2016年 ORANLLC_IOS1. All rights reserved.
//

#import "BUPushManager.h"
#import "BUSystem.h"

#import "LoginViewController.h"

#import "MineViewController.h"
#import <UserNotifications/UserNotifications.h>
#import "MsgViewController.h"
//#import "AppDelegate.h"
#import "MyOrderViewController.h"
//#import "BuyOutServerViewController.h"
//#import "ReletServerViewController.h"
//#import "SelledSeverViewController.h"
//#import "MyCouponViewController.h"
@implementation BUPushManager
-(void)pushToWhich:(NSDictionary *)Data
{
     if (!busiSystem.agent.isLogin) {
          return;
     }


     busiSystem.agent.isNeedRefreshTabD = YES;
     //[UIApplication sharedApplication].applicationIconBadgeNumber = 0;
     UITabBarController *tabVC = (UITabBarController *)[UIApplication sharedApplication].delegate.window.rootViewController;
     tabVC.selectedIndex = 3;
     UINavigationController *cnav = tabVC.selectedViewController;
     MsgViewController *vc = [MsgViewController new];
     vc.hidesBottomBarWhenPushed = YES;
     [cnav pushViewController:vc animated:YES];
     NSInteger  noticeType = [Data[@"type"] integerValue];//1订单2续租3买断4售后5认证6优惠劵
     if (noticeType == 2)
     {
//          ReletServerViewController *vc = [ReletServerViewController new];
//          //        vc.userInfo = Data[@"entityId"];
//          vc.hidesBottomBarWhenPushed = YES;
//          [cnav pushViewController:vc animated:YES];
     }
     else if (noticeType == 1)
     {
          MyOrderViewController *vc = [MyOrderViewController new];
          //        vc.userInfo = Data[@"entityId"];
          vc.hidesBottomBarWhenPushed = YES;
          [cnav pushViewController:vc animated:YES];
     }
     else if (noticeType == 3)
     {
//          BuyOutServerViewController *vc = [BuyOutServerViewController new];
//          //        vc.userInfo = Data[@"entityId"];
//          vc.hidesBottomBarWhenPushed = YES;
//          [cnav pushViewController:vc animated:YES];
     }
     else if (noticeType == 4)
     {
//          SelledSeverViewController *vc = [SelledSeverViewController new];
//          //        vc.userInfo = Data[@"entityId"];
//          vc.hidesBottomBarWhenPushed = YES;
//          [cnav pushViewController:vc animated:YES];
     }
     else if(noticeType == 6)
     {
//          MyCouponViewController *vc = [MyCouponViewController new];
          //        vc.userInfo = Data[@"entityId"];
//          vc.hidesBottomBarWhenPushed = YES;
//          [cnav pushViewController:vc animated:YES];
     }
     //    NSString *msgId = Data[@"msgId"];
     //    switch (noticeType) {


     //        case 1:  case 3://系统通知页面
     //        {
     //            UINavigationController *cnav = tabVC.selectedViewController;
     //            SysMsgViewController *vc = [SysMsgViewController new];
     //            vc.hidesBottomBarWhenPushed = YES;
     //            [cnav pushViewController:vc animated:YES];
     //            busiSystem.agent.isNeedRefreshTabD = YES;
     //
     //        }
     //            break;
     //        case 2://
     //        {
     //             busiSystem.agent.isNeedRefreshTabD = YES;
     //         NSInteger  auditType = [Data[@"openType"] integerValue];
     //            if(auditType == 2)
     //            {
     //                UINavigationController *cnav = tabVC.selectedViewController;
     //                  FirmViewController *vc = [FirmViewController new];
     //                vc.hidesBottomBarWhenPushed = YES;
     //                [cnav pushViewController:vc animated:YES];
     //            }
     //            else if(auditType == 4)
     //            {
     //                UINavigationController *cnav = tabVC.selectedViewController;
     //                SimulationViewController *vc = [[SimulationViewController alloc] initWithNibName:@"FirmViewController" bundle:nil];
     //                vc.hidesBottomBarWhenPushed = YES;
     //                [cnav pushViewController:vc animated:YES];
     //            }
     //            else
     //            {
     //                UINavigationController *cnav = tabVC.selectedViewController;
     //                SysMsgViewController *vc = [SysMsgViewController new];
     //                vc.hidesBottomBarWhenPushed = YES;
     //                [cnav pushViewController:vc animated:YES];
     //
     //            }
     //
     //        }
     //            break;
     ////        case 3:
     ////        {
     ////               UINavigationController *nav = tabVC.viewControllers[2];
     ////            MineQuestionViewController *vc = [MineQuestionViewController new];
     ////            [nav pushViewController:vc animated:YES];
     ////        }
     ////            break;
     //        default:
     //            //            [self pushToWhich];
     //            break;
     //    }
     //
}




-(void)tiRen:(NSString *)str
{
//     HUDDISMISS;
     LoginViewController *loginVC =[LoginViewController new];
     busiSystem.agent.isLogin =NO;
     busiSystem.agent.isCancel =YES;
     //    loginVC.type=4;
     UINavigationController *navSvc = [[UINavigationController alloc] initWithRootViewController:loginVC];
     [UIApplication sharedApplication].delegate.window.rootViewController =navSvc;
     [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"password"];
     [[NSUserDefaults standardUserDefaults]  synchronize];
     [loginVC showYouGetOut:str];
}

-(void)initAPService:(NSDictionary *)launchOptions
{
#if TARGET_IPHONE_SIMULATOR

#elif TARGET_OS_IPHONE
     // 3.0.0及以后版本注册可以这样写，也可以继续用旧的注册方式
     JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
     entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
     if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
          //可以添加自定义categories
          //    if ([[UIDevice currentDevice].systemVersion floatValue] >= 10.0) {
          //      NSSet<UNNotificationCategory *> *categories;
          //      entity.categories = categories;
          //    }
          //    else {
          //      NSSet<UIUserNotificationCategory *> *categories;
          //      entity.categories = categories;
          //    }
     }
     [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
     BOOL isProduction = NO;
#if DEBUG == 1
     isProduction = NO;
     NSLog(@"debugxxx");
#else
     isProduction = YES;
     NSLog(@"releasexxyyy");
#endif



     [JPUSHService setupWithOption:launchOptions appKey:@"eff700b98a3739fea54e2956"
                           channel:@"wb"
                  apsForProduction:isProduction];
     NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
     [defaultCenter addObserver:self selector:@selector(networkDidReceiveMessage:) name:kJPFNetworkDidReceiveMessageNotification object:nil];
#endif
}

- (void)networkDidReceiveMessage:(NSNotification *)notification {
     NSDictionary * userInfo = [notification userInfo];
#if TARGET_IPHONE_SIMULATOR

#elif TARGET_OS_IPHONE
     //        NSString *content = [userInfo valueForKey:@"content"];
     //    NSDictionary *extras = [[userInfo valueForKey:@"extras"] objectForKey:@"cxedata"];
     //    NSString *customizeField1 = [extras valueForKey:@"customizeField1"]; //自定义参数，key是自己定义的
     NSLog(@"xxpush:%@",userInfo);
     if(busiSystem.agent.isLogin)
     {
          busiSystem.agent.isNeedRefreshTabD = YES;
          NSDictionary *data = userInfo[@"data"];
          [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshUserInfo" object:nil];
          //        if([data[@"type"] integerValue] == 3)
          //        {
          //           NSArray  *arr = busiSystem.agent.pushInfo[@"arr"];
          //            NSMutableArray *marr = [NSMutableArray arrayWithArray:arr];
          //            [marr addObject:data[@"title"]];
          //         [JPUSHService setTags:[NSSet setWithArray:marr] alias:busiSystem.agent.tel callbackSelector:@selector(AliasCallback:tags:alias:) object:self];
          //        }
     }
#endif
}

- (void)AliasCallback:(int)iResCode tags:(NSSet*)tags alias:(NSString*)alias {
     NSLog(@"mmmmrescode: %d, \ntags: %@, \nalias: %@\n", iResCode, tags , alias);
}

#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#pragma mark- JPUSHRegisterDelegate
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
#if TARGET_IPHONE_SIMULATOR

#elif TARGET_OS_IPHONE
     NSDictionary * userInfo = notification.request.content.userInfo;

     UNNotificationRequest *request = notification.request; // 收到推送的请求
     UNNotificationContent *content = request.content; // 收到推送的消息内容

     NSNumber *badge = content.badge;  // 推送消息的角标
     NSString *body = content.body;    // 推送消息体
     UNNotificationSound *sound = content.sound;  // 推送消息的声音
     NSString *subtitle = content.subtitle;  // 推送消息的副标题
     NSString *title = content.title;  // 推送消息的标题

     if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
          [JPUSHService handleRemoteNotification:userInfo];
          NSLog(@"iOS10 前台收到远程通知:%@", [self logDic:userInfo]);

          // [rootViewController addNotificationCount];
          if (busiSystem.agent.isLogin) {
               //              [busiSystem.agent getUserIndex:busiSystem.agent.userId observer:nil callback:nil ];
               [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshUserInfo" object:nil];
          }
     }
     else {
          // 判断为本地通知
          NSLog(@"iOS10 前台收到本地通知:{\nbody:%@，\ntitle:%@,\nsubtitle:%@,\nbadge：%@，\nsound：%@，\nuserInfo：%@\n}",body,title,subtitle,badge,sound,userInfo);
     }
     completionHandler(UNNotificationPresentationOptionBadge|UNNotificationPresentationOptionSound|UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以设置
#endif
}

- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
#if TARGET_IPHONE_SIMULATOR

#elif TARGET_OS_IPHONE
     NSDictionary * userInfo = response.notification.request.content.userInfo;
     UNNotificationRequest *request = response.notification.request; // 收到推送的请求
     UNNotificationContent *content = request.content; // 收到推送的消息内容

     NSNumber *badge = content.badge;  // 推送消息的角标
     NSString *body = content.body;    // 推送消息体
     UNNotificationSound *sound = content.sound;  // 推送消息的声音
     NSString *subtitle = content.subtitle;  // 推送消息的副标题
     NSString *title = content.title;  // 推送消息的标题

     if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
          [JPUSHService handleRemoteNotification:userInfo];
          [self pushToWhich:userInfo[@"data"]];
          NSLog(@"iOS10 收到远程通知:%@", [self logDic:userInfo]);
          NSInteger v = [UIApplication sharedApplication].applicationIconBadgeNumber - 1;
          if (v < 0) {
               v = 0;
          }
          [UIApplication sharedApplication].applicationIconBadgeNumber = v;
          //   [rootViewController addNotificationCount];

     }
     else {
          // 判断为本地通知
          NSLog(@"iOS10 收到本地通知:{\nbody:%@，\ntitle:%@,\nsubtitle:%@,\nbadge：%@，\nsound：%@，\nuserInfo：%@\n}",body,title,subtitle,badge,sound,userInfo);
     }

     completionHandler();  // 系统要求执行这个方法
#endif
}
#endif
- (NSString *)logDic:(NSDictionary *)dic {
     if (![dic count]) {
          return nil;
     }
     NSString *tempStr1 =
     [[dic description] stringByReplacingOccurrencesOfString:@"\\u"
                                                  withString:@"\\U"];
     NSString *tempStr2 =
     [tempStr1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
     NSString *tempStr3 =
     [[@"\"" stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
     NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
     NSString *str =
     [NSPropertyListSerialization propertyListFromData:tempData
                                      mutabilityOption:NSPropertyListImmutable
                                                format:NULL
                                      errorDescription:NULL];
     return str;
}

+(void)registerDeviceToken:(NSData *)token
{
#if TARGET_IPHONE_SIMULATOR

#elif TARGET_OS_IPHONE
     [JPUSHService registerDeviceToken:token];
#endif
}

+ (void)handleRemoteNotification:(NSDictionary *)remoteInfo
{
#if TARGET_IPHONE_SIMULATOR

#elif TARGET_OS_IPHONE
     [JPUSHService handleRemoteNotification:remoteInfo];
#endif
}

+ (void) setTags:(NSSet *)tags
           alias:(NSString *)alias
callbackSelector:(SEL)cbSelector
          object:(id)theTarget
{
#if TARGET_IPHONE_SIMULATOR

#elif TARGET_OS_IPHONE
     [JPUSHService setTags:tags alias:alias callbackSelector:cbSelector object:theTarget];
#endif
}

+ (void)setAlias:(NSString *)alias
callbackSelector:(SEL)cbSelector
          object:(id)theTarget
{
#if TARGET_IPHONE_SIMULATOR

#elif TARGET_OS_IPHONE
     [JPUSHService setAlias:alias callbackSelector:cbSelector object:theTarget];
#endif
}

+(void)resetBadge
{
#if TARGET_IPHONE_SIMULATOR

#elif TARGET_OS_IPHONE
     [JPUSHService resetBadge];
#endif
}


+ (BOOL)setBadge:(NSInteger)value
{
#if TARGET_IPHONE_SIMULATOR
     return NO;
#elif TARGET_OS_IPHONE
     [UIApplication sharedApplication].applicationIconBadgeNumber = value;
     return  [JPUSHService setBadge:value];
#endif
}

+(void)reduceBadge
{
     NSInteger num = [UIApplication sharedApplication].applicationIconBadgeNumber;
     [BUPushManager setBadge:num - 1];
}
@end
