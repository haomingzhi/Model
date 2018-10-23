//
//  ExceptionHandler.m
//  IDCard
//
//  Created by Apple on 14-11-21.
//  Copyright (c) 2014年 jackie. All rights reserved.
//

#import "ExceptionHandler.h"

#import "ExceptionHandler.h"
#include <libkern/OSAtomic.h>
#include <execinfo.h>

NSString *const UncaughtExceptionHandlerSignalKey = @"UncaughtExceptionHandlerSignalKey";
NSString *const SingalExceptionHandlerAddressesKey = @"SingalExceptionHandlerAddressesKey";
NSString *const ExceptionHandlerAddressesKey = @"ExceptionHandlerAddressesKey";

const int32_t _uncaughtExceptionMaximum = 20;

// 系统信号截获处理方法
void signalHandler(int signal);

// 异常截获处理方法
void exceptionHandler(NSException *exception);

void printDict(NSMutableDictionary *dict)
{
    NSArray *allKeys =dict.allKeys;
    for (int i=0; i < allKeys.count; i++) {
        NSLog(@"%@=%@",[allKeys objectAtIndex:i],[dict objectForKey:[allKeys objectAtIndex:i]]);
    }
}

void signalHandler(int signal)
{
    volatile int32_t _uncaughtExceptionCount = 0;
    int32_t exceptionCount = OSAtomicIncrement32(&_uncaughtExceptionCount);
    
    // 如果太多不用处理
    if (exceptionCount > _uncaughtExceptionMaximum) {
        return;
    }
    
    // 获取信息
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionaryWithObject:[NSNumber numberWithInt:signal] forKey:UncaughtExceptionHandlerSignalKey];
    NSArray *callStack = [ExceptionHandler backtrace];
    [userInfo  setObject:callStack  forKey:SingalExceptionHandlerAddressesKey];
    
    printDict(userInfo);
    
}


void exceptionHandler(NSException *exception)
{
    volatile int32_t _uncaughtExceptionCount = 0;
    int32_t exceptionCount = OSAtomicIncrement32(&_uncaughtExceptionCount);
    
    // 如果太多不用处理
    if (exceptionCount > _uncaughtExceptionMaximum) {
        return;
    }
    
    NSArray *callStack = [ExceptionHandler backtrace];
    NSMutableDictionary *userInfo =[NSMutableDictionary dictionaryWithDictionary:[exception userInfo]];
    [userInfo setObject:callStack forKey:ExceptionHandlerAddressesKey];
    [userInfo setObject:exception.name forKey:@"exception name"];
    [userInfo setObject:exception.reason forKey:@"exception reason"];
    printDict(userInfo);
}

@implementation ExceptionHandler

//获取调用堆栈
+ (NSArray *)backtrace
{
    void* callstack[128];
    int frames = backtrace(callstack, 128);
    char **strs = backtrace_symbols(callstack,frames);
    
    NSMutableArray *backtrace = [NSMutableArray arrayWithCapacity:frames];
    for (int i=0;i<frames;i++) {
        [backtrace addObject:[NSString stringWithUTF8String:strs[i]]];
    }
    free(strs);
    return backtrace;
}


// 注册崩溃拦截
+ (void)installExceptionHandler
{
    NSSetUncaughtExceptionHandler(&exceptionHandler);
    signal(SIGHUP, signalHandler);
    signal(SIGINT, signalHandler);
    signal(SIGQUIT, signalHandler);
    signal(SIGABRT, signalHandler);
    signal(SIGILL, signalHandler);
    signal(SIGSEGV, signalHandler);
    signal(SIGFPE, signalHandler);
    signal(SIGBUS, signalHandler);
    signal(SIGPIPE, signalHandler);
}

@end
