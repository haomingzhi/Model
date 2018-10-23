//
//  UIImageView+Cache.m
//  UniversalFramework
//
//  Created by ORANLLC_IOS1 on 15/9/16.
//  Copyright (c) 2015年 ORANLLC_IOS1. All rights reserved.
//

#import "UIImageView+Cache.h"

@implementation UIImageView (Cache)


- (void)sd_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder
{
    self.image = placeholder;
    BURes *res = [[BURes alloc] initWith:@"" relativeURL:url.absoluteString type:BURESTYPE_IMAGE];
    [res displayRemoteImage:self imageName:@""];
}

-(void)imageWithContent:(NSString *)fileName
{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"png"];
    if(!filePath)
    {
        filePath = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@",fileName] ofType:@"png"];
    }
    
    self.image = [UIImage imageWithContentsOfFile:filePath];
}

-(void)imageWithContent:(NSString *)fileName withUIEdgeInsets:(UIEdgeInsets)inset
{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"png"];
    if(!filePath)
    {
        filePath = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@",fileName] ofType:@"png"];
    }
    
    self.image =[[UIImage imageWithContentsOfFile:filePath] resizableImageWithCapInsets:inset resizingMode:UIImageResizingModeStretch]  ;
}
@end
