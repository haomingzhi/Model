//
//  TabViewControllerManager.h
//  B2C
//
//  Created by air on 15/7/14.
//  Copyright (c) 2015年 ORANLLC_IOS1. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TabViewControllerManager : NSObject
+(  UITabBarController * )mainUI;
//+(  UITabBarController * )mainUI:(id)delegate;
+(void)setTabvBgColor:(UIColor *)color;
+(void)setTabvTextColor:(UIColor *)color withUnselectColor:(UIColor *)unScolor;
+(void)setTabvImg:(NSString *)img withUnSecImg:(NSString *)uimg;
+(void)setTabvBottomImgV:(NSString *)img;
@end
