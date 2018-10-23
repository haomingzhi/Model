//
//  JYCommonTool.h
//  yihui
//
//  Created by air on 15/9/23.
//  Copyright (c) 2015年 ORANLLC_IOS1. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JYCommonTool : NSObject
+(BOOL)hasNumberString:(NSString *)str;
+(NSString *)toPingYin:(NSString*)en;
+(NSTextCheckingResult *)parseString:(NSString*)str withPattern:(NSString *)pattern;
+(BOOL)isFloatValue:(NSString *)str;
+(NSArray *)getLinkValue:(NSString*)str;
+ (BOOL)isNumberAndPoint:(NSString *)number;
+ (BOOL) isMobileNum:(NSString *)mobNum;
+ (BOOL) isNumberAndLetters:(NSString *)str ;//是否为数字和字母
+(int)compareDate:(NSString*)date01 withDate:(NSString*)date02;//两个时间比较 1:date02大 -1:date01 大 0:相等
+(int)compareNowDate:(NSString*)date;//与当前时间比较 1:当前时间小 -1:当前时间大 0:相等
+(void)checkVersion:(UIViewController*)vc;
+(BOOL)isAlphaOrNum:(NSString *)str;
+ (BOOL) validateEmail:(NSString *)email;
+(NSString*)getNetInfo;//获取网络信息
+(BOOL)isAllChinese:(NSString *)str;
+(BOOL)hasChinese:(NSString *)str;
+(UIImage*)getSubImage:(UIImage *)image mCGRect:(CGRect)mCGRect
            centerBool:(BOOL)centerBool;//裁剪图片
+(NSString *)unescape:(NSString *)str; // unescape解码
+(NSString *)stringForDate:(NSDate *)date withDateFormat:(NSString*)format;//date转string
+(NSDate *)stringToDate:(NSString *)date withDateFormat:(NSString*)format;//string转date
+(BOOL)isBiaoDianFuHao:(NSString *)str;
@end
