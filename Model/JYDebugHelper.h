//
//  JYDebugHelper.h
//  ulife
//
//  Created by air on 16/1/21.
//  Copyright © 2016年 ORANLLC_IOS1. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JYDebugHelper : NSObject
+ (void)setDebug:(BOOL)debug;
+ (BOOL)isDebug;
+ (void)addDebugOptionToViewController:(UIViewController *)vc;
@end
