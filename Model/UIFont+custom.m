//
//  UIFont+custom.m
//  Model
//
//  Created by air on 2018/1/5.
//  Copyright © 2018年 ORANLLC_IOS1. All rights reserved.
//

#import "UIFont+custom.h"
#import "BUSystem.h"
#import <objc/runtime.h>
@implementation UIFont (custom)
//+ (UIFont *)systemFontOfSize:(CGFloat)fontSize
//
//{
//     if (busiSystem.agent.canPush) {
//          return [UIFont fontWithName:@"今昔豪龙"size:fontSize];
//     }
//     return[UIFont fontWithName:@"FZQTJW--GB1-0"size:fontSize];// X-OTFHaolong
//
//}
//- (UIFont *)fontWithSize:(CGFloat)fontSize
//{
//     if (busiSystem.agent.canPush) {
//          return [UIFont fontWithName:@"今昔豪龙"size:fontSize];
//     }
//  return[UIFont fontWithName:@"FZQTJW--GB1-0"size:fontSize];// X-OTFHaolong
//}

//+ (void)load{
//
//     [super load];
//
//      static dispatch_once_t onceToken;
//
//      dispatch_once(&onceToken, ^{ Method oldMethod = class_getClassMethod([self class], @selector(systemFontOfSize:));
//          Method newMethod = class_getClassMethod([self class], @selector(__nickyfontchanger_YaheiFontOfSize:));
//          method_exchangeImplementations(oldMethod, newMethod); });
//
//}
//
//+ (UIFont *)__nickyfontchanger_YaheiFontOfSize:(CGFloat)fontSize{ UIFont *font = [UIFont fontWithName:@"MicrosoftYaHei" size:fontSize];
//
//     if (!font)return [self __nickyfontchanger_YaheiFontOfSize:fontSize]; return font;
//
//}


@end
