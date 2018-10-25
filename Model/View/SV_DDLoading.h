//
//  SV_DDLoading.h
//  DDZX_xyzx
//
//  Created by 侯 on 2018/9/4.
//  Copyright © 2018年 ddzx. All rights reserved.
//

#import "SVProgressHUD.h"

@interface SV_DDLoading : SVProgressHUD

+(void)show;//展示UI提供的加载

+(void)dismiss;//去除加载

+ (void)showLoadingWithStatus:(NSString *)status;

+(void)dismissLoadingWithDelay:(NSTimeInterval)delay completion:(void (^)(void))completion;

+(void)dismissLoadingWithDelay:(NSTimeInterval)delay;

+ (void)showMessage:(NSString *)string;

@end
