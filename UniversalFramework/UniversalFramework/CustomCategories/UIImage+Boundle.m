//
//  UIImage+Boundle.m
//  UniversalFramework
//
//  Created by ORANLLC_IOS1 on 15/8/1.
//  Copyright (c) 2015年 ORANLLC_IOS1. All rights reserved.
//

#import "UIImage+Boundle.h"

@implementation UIImage (Boundle)

+ (UIImage *)readImageFromBundle:(NSString *)imageName bundleName:(NSString *) bundleName{
    NSString *bundlePath = [[NSBundle mainBundle].resourcePath stringByAppendingPathComponent: [NSString stringWithFormat:@"Frameworks/%@/%@.png",bundleName,imageName]];
    //NSBundle *bundle = [NSBundle bundleWithPath:bundlePath];
    //NSString *contentPath = [bundle pathForResource:imageName ofType:@"png"];
    return [UIImage imageWithContentsOfFile:bundlePath];
}

@end
