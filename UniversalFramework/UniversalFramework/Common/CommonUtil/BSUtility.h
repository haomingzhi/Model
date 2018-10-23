//
//  Utility.h
//  MiniU12Protocol
//
//  Created by Apple on 14-6-26.
//  Copyright (c) 2014年 sunnada. All rights reserved.
//

#import <Foundation/Foundation.h>


//http://blog.csdn.net/cyg_apple/article/details/11722379
#define DEFAULTDATEFORMAT @"yyyy-MM-dd HH:mm:ss"
#define NUMBERS @"0123456789\n"
#define JGGZW @"➎➐➑➏➋➍➌➒"
#define ALPHA @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz\n"
#define ALPHANUM @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789@.\n"
#define REG_MONEY @"^(([1-9]\d{0,9})|0)(\.\d{0,2})?$"

#define SHOWALTERDIALOG(text) [BSUtility showDialog:text]

extern void MyWriteLog(NSString*fmt, ...);

@interface BSUtility : NSObject
+(NSInteger)textCount:(NSString *)str;
+(BOOL)isRightNameStyle:(NSString *)str withMax:(NSInteger)max withMin:(NSInteger)min;
+ (void) creatNewRecord:(NSString *)name phoneNumber:(NSString *)phoneNumber withParentVC:(UIViewController *)vc;
+(void)copyStr:(NSString*)str;
/**
 *  判断str是否包含数字
 *
 *  @param str 被检测的字符串
 *
 *  @return 返回是否包含数字，YES 包含，NO 不包含
 */
+(BOOL)hasNumberString:(NSString *)str;
/**
 *  字符串转拼音
 *
 *  @param en 待转换的拼音
 *
 *  @return 返回字符串对应的全拼,拼音之间用空格分开
 */
+(NSString *)toPingYin:(NSString*)en;
//======设备功能============//
+ (NSDictionary *)getPhoneBook;
+(void)callPhone:(NSString *)telnum view :(UIView *)parentView;
//=======提示框=============//
+(void) showDialog:(NSString *)hintText;
+(void) showDialog:(NSString *)title Context:(NSString *)hintText;
+(void)showDialogOkCancel:(NSString *)title Context:(NSString *)hintText completion:(void (^)(NSInteger index))completion;
+(void)showDialogOkCancel:(NSString*)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles completion:(void (^)(NSInteger index))completion;

+(void)showDialog:(NSString *)title Context:(NSString *)hintText completion:(void (^)(NSInteger index))completion;
+(void) showAuthDialog:(NSString *)title Context:(NSString *)hintText completion:(void (^)(NSInteger index))completion;
+(void)showDialog:(UIView *) inValue title:(NSString *)title buttons:(NSArray*)buttons  completion:(void (^)(NSInteger index))completion;

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
+(NSString *)geSystemTimeAddTime:(NSInteger)day withFormat:(NSString *)dateTimeFormat;
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
+(BOOL)saveDefault:(NSDictionary *) values;
+(NSString *)getDefault:(NSString*)key;
+(NSArray *) getDefaultBatch:(NSArray *) keys;
+(NSString *)getHost:(NSString*)key;

//保存敏感数据
+(void) saveSecretData:(NSString *) key andValue:(NSString *) value;
+(void) saveSecretData:(NSDictionary *) values;
//获取敏感数据
+(NSString *)getSecretData:(NSString*)key;
+(NSArray *) getSecretDataBatch:(NSArray *)keys;


//=========cookie===========//
+(void) displayCookies;
+(void) clearCookies;
+(NSHTTPCookieStorage *) getCookies;
+(void)AddCookie:(NSString *)cookieName CookieValue:(NSString *)cookieValue;
+(void) AddCookie:(NSString *)domain OriginUrl:(NSString *)originUrl CookieName:(NSString *)cookieName CookieValue:(NSString *)cookieValue;

//=======NSArray=========//
+(NSArray *) getArrayByCondition:(NSArray *)array condition:(BOOL (^)(id))condition ;

//========UIView==========//

+(UIView *) loadViewFromXib:(NSString *) xib index:(NSInteger) index;
+(UIView *) loopView:(UIView *)view  condition:(BOOL (^)(UIView *))condition  finded:(BOOL (^)(UIView * findedView))finded;

+(void)displayViewDescription:(UIView *)view;

+(UIView *)FindViewByClass:(UIView *)supperView  ViewClassName:(NSString *)viewName;

+ (UIViewController*)viewController:(UIView *)currentView;
+ (UIViewController *)getCurrentVC;

+(NSString*)rectToString:(CGRect)rect;
+(NSString*)indexPathToString:(NSIndexPath *) index;
+(NSString*)pointToString:(CGPoint)point;
+(NSString*)sizeToString:(CGSize) size;
//=========ViewController======//
+(UIViewController *)FindViewControllerByClass:(UIViewController *)vc className:(NSString *)className;

//==========textView=========//
-(void)htmlDisplay:(NSString *)htmlText textView:(UITextView *) textView;

+(CGSize)matchMaxSize:(CGSize )maxSize sourceSize:(CGSize) sourceSize;

//获取当前星期几
+(NSInteger)getCurWeek;
//获取当前月份
+(NSInteger)getCurMonth;
//今年某个月份的天数
+(NSInteger)getDaysWithMonth:(NSInteger)month;
+(NSInteger)getCurDay;
+(NSInteger)getCurYear;
+(NSString *)geSystemTimeReduceTime:(NSInteger)day withFormat:(NSString *)dateTimeFormat;
+ (NSInteger)numberOfSecsFromTodayByTime:(NSString *)time timeStringFormat:(NSString *)format;//获取指定日期和当前日期所差的秒数
+ (NSInteger)numberOfDaysFromTodayByTime:(NSString *)time timeStringFormat:(NSString *)format;
@end
