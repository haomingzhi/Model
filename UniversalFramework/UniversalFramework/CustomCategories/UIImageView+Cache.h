//
//  UIImageView+Cache.h
//  UniversalFramework
//
//  Created by ORANLLC_IOS1 on 15/9/16.
//  Copyright (c) 2015年 ORANLLC_IOS1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (Cache)
- (void)sd_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder;
-(void)imageWithContent:(NSString *)fileName;
-(void)imageWithContent:(NSString *)fileName withUIEdgeInsets:(UIEdgeInsets)inset;
@end
