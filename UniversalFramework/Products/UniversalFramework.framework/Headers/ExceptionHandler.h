//
//  ExceptionHandler.h
//  IDCard
//  抓取闪退日志
//  Created by Apple on 14-11-21.
//  Copyright (c) 2014年 jackie. All rights reserved.
//

#import <Foundation/Foundation.h>


extern NSString *const UncaughtExceptionHandlerSignalKey;
extern NSString *const SingalExceptionHandlerAddressesKey;
extern NSString *const ExceptionHandlerAddressesKey;

@interface ExceptionHandler : NSObject
+ (void)installExceptionHandler;
+ (NSArray *)backtrace;
@end
