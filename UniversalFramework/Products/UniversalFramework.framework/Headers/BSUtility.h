//
//  Utility.h
//  MiniU12Protocol
//
//  Created by Apple on 14-6-26.
//  Copyright (c) 2014年 sunnada. All rights reserved.
//

#import <Foundation/Foundation.h>


//http://blog.csdn.net/cyg_apple/article/details/11722379
#define DEBAULTDATEFORMAT @"yyyy-MM-dd HH:mm:ss"
#define NUMBERS @"0123456789\n"
#define ALPHA @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz\n"
#define ALPHANUM @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789@.\n"
#define REG_MONEY @"^(([1-9]\d{0,9})|0)(\.\d{0,2})?$"

#define SHOWALTERDIALOG(text) [BSUtility showDialog:text]

extern void MyWriteLog(NSString*fmt, ...);

@interface BSUtility : NSObject


//======设备功能============//

+(void)callPhone:(NSString *)telnum view :(UIView *)parentView;
//=======提示框=============//
+(void) showDialog:(NSString *)hintText;
+(void) showDialog:(NSString *)title Context:(NSString *)hintText;
+(void)showDialogOkCancel:(NSString *)title Context:(NSString *)hintText completion:(void (^)(NSInteger index))completion;
+(void)showDialog:(NSString *)title Context:(NSString *)hintText completion:(void (^)(NSInteger index))completion;
//========日志===============//
+(void) AddHexLog:(NSString *)head RawBuffer:(unsigned char *) rawBuffer RawBufferLength:(int) rawBufferLength;
+(void) AddTextLog:(NSString *)head LogText:(NSString *)logText;
+(void) AddTextLog:(NSString *)logText;
+(void) writeLog:(NSString *)logText;
//========日期字符串互转=======//
+(NSDate *)StrToDate:(NSString *)dataFormat DateStr:(NSString *)dateStr;
+(NSString*)getSystemTime;
+(NSString *)getSystemDate;
+(NSString*)getSystemTimeWithFormat:(NSString *)dateTimeFormat;
+(NSString*)getDateTimeWithFormat:(NSDate *)datetime Format:(NSString *)dateTimeFormat;
+(NSString *)transTimeIntervalToDateStr:(NSString *)dateTimeInterval dateTimeFormat:(NSString *)format;
+(NSString *)transTimeIntervalToDateStrDefault:(NSString *)dateTimeInterval;

//====输入域限制======//
+(BOOL)contextLengthLimit:(NSRange)range replacementString:(NSString*)string MaxLength:(int)maxLength;
+(BOOL)contextDomainLimit:(NSString *)replacementString ValidDomain:(NSString *)validDomain;

//====字符串==========//
+(NSString *) RawBufferToHexString:(unsigned char *) rawBuffer RawBufferLength:(int) rawBufferLength;
+(NSString*)nullToEmpty:(id)str;
+(NSString*)nulltoSpecifity:(NSString *)str Specifity:(NSString*)specifity;
+(NSString *)trimodoa:(NSString *)string;
+(NSString *)trimEmpty:(NSString *)string;
+(NSString *)trimSpecifity:(NSString *)string specifity:(NSString *)specifity;
+(NSString *)getWebViewSource:(UIWebView *)webView;
+(NSString *) getUUIDString;
//====其他==========//
+(BOOL)isNullId:(id)obj;
+(BOOL)checkIdentityCardNo:(NSString*)cardNo;//身份证校验
+(BOOL)idCardVertity:(NSString *)idcard view:(UIView *)currentView;
//判断字符串中是否包含行字
+(BOOL) containsChinese:(NSString *)str;
//判断字符串中汉字长度
+(NSInteger) chineseLength:(NSString *)str;
//正则表达式匹配
+(BOOL)regMatch:(NSString *)regPattern CheckValue:(NSString*)inputValue;
+(BOOL)saveDefault:(NSString *)key AndValue:(NSString *)value;
+(NSString *)getDefault:(NSString*)key;
+(NSString *)getHost:(NSString*)key;
//=========cookie===========//
+(void) displayCookies;
+(void) clearCookies;
+(NSHTTPCookieStorage *) getCookies;
+(void)AddCookie:(NSString *)cookieName CookieValue:(NSString *)cookieValue;
+(void) AddCookie:(NSString *)domain OriginUrl:(NSString *)originUrl CookieName:(NSString *)cookieName CookieValue:(NSString *)cookieValue;

//=======NSArray=========//
+(NSArray *) getArrayByCondition:(NSArray *)array condition:(BOOL (^)(id))condition ;

//========UIView==========//

+(UIView *) loopView:(UIView *)view  condition:(BOOL (^)(UIView *))condition  finded:(BOOL (^)(UIView * findedView))finded;

+(void)displayViewDescription:(UIView *)view;

+(UIView *)FindViewByClass:(UIView *)supperView  ViewClassName:(NSString *)viewName;

+ (UIViewController*)viewController:(UIView *)currentView;


+(NSString*)rectToString:(CGRect)rect;
+(NSString*)indexPathToString:(NSIndexPath *) index;
+(NSString*)pointToString:(CGPoint)point;
+(NSString*)sizeToString:(CGSize) size;
//=========ViewController======//
+(UIViewController *)FindViewControllerByClass:(UIViewController *)vc className:(NSString *)className;

//==========textView=========//
-(void)htmlDisplay:(NSString *)htmlText textView:(UITextView *) textView;

+(CGSize)matchMaxSize:(CGSize )maxSize sourceSize:(CGSize) sourceSize;
@end
