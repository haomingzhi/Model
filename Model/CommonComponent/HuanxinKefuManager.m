//
//  HuanxinKefuManager.m
//  compassionpark
//
//  Created by air on 2017/4/20.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import "HuanxinKefuManager.h"
//#import "RedPacketChatViewController.h"
//#import "SCLoginManager.h"
//#import "HDChatViewController.h"
//#import "MessageViewController.h"
//#import "HDMessageViewController.h"
#if TARGET_IPHONE_SIMULATOR

#elif TARGET_OS_IPHONE
#import <Hyphenate/Hyphenate.h>
#endif

#import "ChatViewController.h"
#import "BUSystem.h"
#define kpreSell @"preSell"
@implementation HuanxinKefuManager
#if TARGET_IPHONE_SIMULATOR
+(void)applicationWillEnterForeground:(UIApplication *)application{}
+(void)applicationDidEnterBackground:(UIApplication *)application{}
+(void)initKefu:(NSString*)key withCerName:(NSString *)name{}
+(void)kefuHandle:(UIViewController *)vc{}
+(void)contactHandle:(UIViewController *)vc withTel:(NSString *)tel{}
#elif TARGET_OS_IPHONE


+(void)initKefu:(NSString*)key withCerName:(NSString *)name
{
     
     EMOptions *options = [EMOptions optionsWithAppkey:key];
     options.apnsCertName = name;
     [[EMClient sharedClient] initializeSDKWithOptions:options];
}

+(void)applicationDidEnterBackground:(UIApplication *)application
{
   [[EMClient sharedClient] applicationDidEnterBackground:application];
}

+(void)applicationWillEnterForeground:(UIApplication *)application
{
  [[EMClient sharedClient] applicationWillEnterForeground:application];
}
+(void)kefuHandle:(UIViewController *)vc
{

    if ([HuanxinKefuManager loginHuanxin:busiSystem.agent.userInfo.tel withPwd:busiSystem.agent.tel?:@"qwe123"]) {
        UIViewController *chatController = nil;
        //#ifdef REDPACKET_AVALABLE
        //    chatController = [[RedPacketChatViewController alloc] initWithConversationChatter:conversation.conversationId conversationType:conversation.type];
        //#else
        chatController = [[ChatViewController alloc] initWithConversationChatter:kDefaultTenantId conversationType:0];
        //#endif
        chatController.title = @"客服";
        chatController.hidesBottomBarWhenPushed = YES;
        [vc.navigationController pushViewController:chatController animated:YES];

    }
  }

+(BOOL)loginHuanxin:(NSString *)username withPwd:(NSString*)password
{
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        EMError *error = [[EMClient sharedClient] loginWithUsername:username password:password];
        
//        dispatch_async(dispatch_get_main_queue(), ^{
  
            if (!error) {
                //设置是否自动登录
                [[EMClient sharedClient].options setIsAutoLogin:YES];
                
                //保存最近一次登录用户名
                [HuanxinKefuManager saveLastLoginUsername];
                //发送自动登陆状态通知
                [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_LOGINCHANGE object:[NSNumber numberWithBool:YES]];
                return YES;
                
            } else {
                NSLog(@"登录环信失败");
//                HUDCRY(@"登录环信失败", 2);
                return YES;
            }
//        });
//    });
    
}


+(void)contactHandle:(UIViewController *)vc withTel:(NSString *)tel
{
       if ([HuanxinKefuManager loginHuanxin:busiSystem.agent.tel withPwd:busiSystem.agent.tel?:@"qwe123"]) {
        UIViewController *chatController = nil;

        chatController = [[ChatViewController alloc] initWithConversationChatter:tel conversationType:0];
           ((ChatViewController*)chatController).type = 1;
        chatController.title = tel;
        chatController.hidesBottomBarWhenPushed = YES;
        [vc.navigationController pushViewController:chatController animated:YES];
        
    }
}


+ (void)saveLastLoginUsername
{
    NSString *username = [[EMClient sharedClient] currentUsername];
    if (username && username.length > 0) {
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        [ud setObject:username forKey:[NSString stringWithFormat:@"em_lastLogin_username"]];
        [ud synchronize];
    }
}

+ (NSString*)lastLoginUsername
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [[NSUserDefaults standardUserDefaults]  synchronize];
    NSString *username = [ud objectForKey:[NSString stringWithFormat:@"em_lastLogin_username"]];
    if (username && username.length > 0) {
        return username;
    }
    return nil;
}
#endif
@end
