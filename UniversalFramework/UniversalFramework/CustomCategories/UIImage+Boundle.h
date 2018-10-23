//
//  UIImage+Boundle.h
//  UniversalFramework
//
//  Created by ORANLLC_IOS1 on 15/8/1.
//  Copyright (c) 2015年 ORANLLC_IOS1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Boundle)
+ (UIImage *)readImageFromBundle:(NSString *)imageName bundleName:(NSString *) bundleName;
@end
