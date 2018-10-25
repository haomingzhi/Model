//
//  SV_DDLoading.m
//  DDZX_xyzx
//
//  Created by 侯 on 2018/9/4.
//  Copyright © 2018年 ddzx. All rights reserved.
//

#import "SV_DDLoading.h"
#import <UIImage+YYAdd.h>

@implementation SV_DDLoading

+(void)show{
    NSMutableArray *imgArr = [NSMutableArray array];
    
    for (int i = 0; i < 26; i ++) {
        NSString *imageName;
        if (i < 10) {
            imageName = [NSString stringWithFormat:@"DDLoading0%d",i];
        }else{
            imageName = [NSString stringWithFormat:@"DDLoading%d",i];
        }
        
        [imgArr addObject:[UIImage imageNamed:imageName]];
    }
    
    [self setImageViewSize:CGSizeMake(100, 100)];
//    [self setForegroundColor:[UIColor clearColor]];
//    [self setBackgroundColor:[UIColor colorWithWhite:0 alpha:0]];
    [self setDefaultStyle:SVProgressHUDStyleCustom];
    [self setBackgroundColor:[UIColor clearColor]];
    
    [self showImage:[UIImage animatedImageWithImages:imgArr duration:2.0] status:@""];
    
}

+(void)dismiss{
    [super dismiss];
}

+ (void)showLoadingWithStatus:(NSString *)status {
    
    [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeNative];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeCustom]; //设置HUD背景图层的样式
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    [SVProgressHUD setBackgroundColor:[UIColor blackColor]];
    [SVProgressHUD setBackgroundLayerColor:[UIColor clearColor]];

    
    UIImage *image = nil;
    [self showImage:image status:status];
}
+(void)dismissLoadingWithDelay:(NSTimeInterval)delay {
    [super dismissWithDelay:delay];
}

+ (void)dismissLoadingWithDelay:(NSTimeInterval)delay completion:(SVProgressHUDDismissCompletion)completion {
    [super dismissWithDelay:delay completion:completion];
}

+ (void)showMessage:(NSString *)string{

    UIImage *image = nil;
    
    [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeNative];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeCustom]; //设置HUD背景图层的样式
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    [SVProgressHUD setBackgroundColor:[UIColor blackColor]];
    [SVProgressHUD setBackgroundLayerColor:[UIColor clearColor]];
    [SVProgressHUD dismissWithDelay:1];
    
    [self showImage:image status:string];
    
}

@end
