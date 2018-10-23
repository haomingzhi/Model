//
//  TargetWeakProxy.h
//  WaveViewDemo
//
//  Created by Darwin on 2017/4/7.
//  Copyright © 2017年 Darwin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TargetWeakProxy : NSProxy

@property (nullable, nonatomic, weak, readonly) id target;

- (instancetype)initWithTarget:(id)target;

+ (instancetype)proxyWithTarget:(id)target;

NS_ASSUME_NONNULL_END

@end
