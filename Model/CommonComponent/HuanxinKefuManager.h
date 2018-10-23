//
//  HuanxinKefuManager.h
//  compassionpark
//
//  Created by air on 2017/4/20.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HuanxinKefuManager : NSObject
+(void)applicationWillEnterForeground:(UIApplication *)application;
+(void)applicationDidEnterBackground:(UIApplication *)application;
+(void)initKefu:(NSString*)key withCerName:(NSString *)name;
+(void)kefuHandle:(UIViewController *)vc;
+(void)contactHandle:(UIViewController *)vc withTel:(NSString *)tel;
@end
