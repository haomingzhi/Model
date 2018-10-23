//
//  Utility.m
//  MiniU12Protocol
//
//  Created by Apple on 14-6-26.
//  Copyright (c) 2014年 sunnada. All rights reserved.
//

#import "BSUtility.h"
#import <UIKit/UIKit.h>
#import <AddressBook/AddressBook.h>
//#import <AddressBook.framework>
#import <AddressBookUI/AddressBookUI.h>
#import "JYNewPersonViewController.h"
extern void MyWriteLog(NSString*fmt, ...)
{
    va_list args;
    va_start(args, fmt);
    
    NSString *logstr = [[NSString alloc] initWithFormat:fmt arguments:args];
    va_end(args);
    
    [BSUtility AddTextLog:@"" LogText:logstr];
}


@implementation BSUtility

+(BOOL)isRightNameStyle:(NSString *)str withMax:(NSInteger)max withMin:(NSInteger)min
{
    int count = 0;
    for (int i = 0; i<str.length; i++) {
        NSRange range=NSMakeRange(i,1);
        
        NSString *subString=[str substringWithRange:range];
        
        const char *cString=[subString UTF8String];
        if (strlen(cString) != 3) {
            count += 1;
        }else{
            count += 2;
        }
    }
    if (count<min || count>max) {
                return NO;
    }
    return YES;
}

+(NSInteger)textCount:(NSString *)str
{
    int count = 0;
    for (int i = 0; i<str.length; i++) {
        NSRange range=NSMakeRange(i,1);
        
        NSString *subString=[str substringWithRange:range];
        
        const char *cString=[subString UTF8String];
        if (strlen(cString) != 3) {
            count += 1;
        }else{
            count += 2;
        }
    }
    return count;
}
/*
 Hex字符串转字符串如：0x303132=>012
 返回Hex字符串的压缩形式
 */
+ (NSString *)stringFromHexString:(NSString *)hexString {
    
    // The hex codes should all be two characters.
    if (([hexString length] % 2) != 0)
        return nil;
    
    NSMutableString *string = [NSMutableString string];
    
    for (NSInteger i = 0; i < [hexString length]; i += 2) {
        
        NSString *hex = [hexString substringWithRange:NSMakeRange(i, 2)];
        UInt32 decimalValue = 0;
        sscanf([hex UTF8String], "%x", &decimalValue);
        [string appendFormat:@"%c", decimalValue];
    }
    return string;
}


+(NSString *) RawBufferToHexString:(unsigned char *) rawBuffer RawBufferLength:(int) rawBufferLength
{
    NSMutableString *result = [[NSMutableString alloc]init];
    for(int i=0;i<rawBufferLength;i++)
    {
        [result appendString:[NSString stringWithFormat:@"%02x",rawBuffer[i]]];
    }
    return result;
}

+(void) AddHexLog:(NSString *)head RawBuffer:(unsigned char *) rawBuffer RawBufferLength:(int) rawBufferLength
{
    NSString * nowDateStr = [self getSystemTime ];
    NSString *log =[NSString stringWithFormat:@"%@ %@ length =%d  %@\r\n",nowDateStr,head,rawBufferLength,[self RawBufferToHexString:rawBuffer RawBufferLength:rawBufferLength]];
    [BSUtility writeLog:log];
}

+(void) AddTextLog:(NSString *)logText
{
    [BSUtility AddTextLog:@"" LogText:logText];
}
+(void) AddTextLog:(NSString *)head LogText:(NSString *)logText
{
    NSString * nowDateStr = [self getSystemTime ];
    NSString *log =[NSString stringWithFormat:@"%@ %@ %@\r\n",nowDateStr,head,logText];
    [BSUtility writeLog:log];
}

+(void) showDialog:(NSString *)hintText
{
    [BSUtility showDialog:@"" Context:hintText];
}
+(void) showDialog:(NSString *)title Context:(NSString *)hintText
{
    MyMessageBox* messageBox =[[MyMessageBox alloc]init];
    [messageBox show:title message:hintText cancelButtonTitle:@"确定" otherButtonTitles:nil completion:NULL];
}
+(void) showAuthDialog:(NSString *)title Context:(NSString *)hintText completion:(void (^)(NSInteger index))completion
{
    MyMessageBox* messageBox =[[MyMessageBox alloc]init];
    [messageBox show:title message:hintText cancelButtonTitle:@"我知道了" otherButtonTitles:nil completion:completion];
}
+(void)showDialogOkCancel:(NSString *)title Context:(NSString *)hintText completion:(void (^)(NSInteger index))completion
{
    MyMessageBox* messageBox =[[MyMessageBox alloc]init];
    [messageBox show:title message:hintText cancelButtonTitle:@"取消" otherButtonTitles:@"确定" completion:completion];
}
+(void)showDialogOkCancel:(NSString*)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles completion:(void (^)(NSInteger index))completion
{
    MyMessageBox* messageBox =[[MyMessageBox alloc]init];
    [messageBox show:title message:message cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtonTitles completion:completion];
}

+(void)showDialog:(NSString *)title Context:(NSString *)hintText completion:(void (^)(NSInteger index))completion
{
    MyMessageBox* messageBox =[[MyMessageBox alloc]init];
    [messageBox show:title message:hintText cancelButtonTitle:@"确定" otherButtonTitles:nil completion:completion];
}

+(void)showDialog:(UIView *) inValue title:(NSString *)title buttons:(NSArray*)buttons  completion:(void (^)(NSInteger index))completion
{
    MyMessageBox* messageBox =[[MyMessageBox alloc]init];
    [messageBox showInView:inValue withStyle:UIActionSheetStyleBlackOpaque title:title cancelButtonTitle:@"取消" destructiveButtonTitle:NULL buttons:buttons completion:completion];

}

//获取当前星期几 在这里需要注意的是：星期日是数字1，星期一时数字2，
+(NSInteger)getCurWeek
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
//    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
//    [calendar setTimeZone:timeZone];
    NSDate *now;
    NSDateComponents *comps = [[NSDateComponents alloc] init];
//    [comps setTimeZone:timeZone];
    NSInteger unitFlags =NSCalendarUnitYear | NSCalendarUnitMonth |NSCalendarUnitDay | NSCalendarUnitWeekday |
    NSCalendarUnitHour |NSCalendarUnitMinute | NSCalendarUnitSecond;
    now=[NSDate date];
    comps = [calendar components:unitFlags fromDate:now];
    return [comps weekday];
}

//获取当前月份
+(NSInteger)getCurMonth
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDate *now;
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags =NSCalendarUnitYear | NSCalendarUnitMonth |NSCalendarUnitDay | NSCalendarUnitWeekday |
    NSCalendarUnitHour |NSCalendarUnitMinute | NSCalendarUnitSecond;
    now=[NSDate date];
    comps = [calendar components:unitFlags fromDate:now];
    return [comps month];
}

+(NSInteger)getCurDay
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay;
    
    NSDateComponents *components = [calendar components:unitFlags fromDate:[NSDate date]];
    
    NSInteger iCurDay = [components day];
    return iCurDay;
}

+(NSInteger)getCurYear
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay;
    
    NSDateComponents *components = [calendar components:unitFlags fromDate:[NSDate date]];
    
    NSInteger iCurDay = [components year];
    return iCurDay;
}

//今年某个月份的天数
+(NSInteger)getDaysWithMonth:(NSInteger)month
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
      NSDate *now;
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags =NSCalendarUnitYear | NSCalendarUnitMonth |NSCalendarUnitDay | NSCalendarUnitWeekday |
    NSCalendarUnitHour |NSCalendarUnitMinute | NSCalendarUnitSecond;
    now = [NSDate date];
    comps = [calendar components:unitFlags fromDate:now];
   NSDate *dt = [BSUtility StrToDate:@"yyyy-MM-dd" DateStr:[NSString stringWithFormat:@"%ld-%ld-%d",[comps year],month,1]];
    NSRange range = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:dt];
    
    NSUInteger numberOfDaysInMonth = range.length;
    return numberOfDaysInMonth;
}

+(NSString *)geSystemTimeAddTime:(NSInteger)day withFormat:(NSString *)dateTimeFormat
{
NSTimeInterval a_day = 24*60*60;
//    NSDate * date = [NSDate date];
    NSDate *date = [[NSDate alloc] initWithTimeIntervalSinceNow:a_day *day];
    return [BSUtility getDateTimeWithFormat:date Format:dateTimeFormat];
}

+(NSString *)geSystemTimeReduceTime:(NSInteger)day withFormat:(NSString *)dateTimeFormat
{
    NSTimeInterval a_day = 24*60*60;
    //    NSDate * date = [NSDate date];
    NSDate *date = [[NSDate alloc] initWithTimeIntervalSinceNow:-a_day *day];
    return [BSUtility getDateTimeWithFormat:date Format:dateTimeFormat];
}

+(NSString*)getSystemTimeWithFormat:(NSString *)dateTimeFormat
{
    NSDate * date = [NSDate date];
    return [BSUtility getDateTimeWithFormat:date Format:dateTimeFormat];
}
+(NSString*)getDateTimeWithFormat:(NSDate *)datetime Format:(NSString *)dateTimeFormat
{
    NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
    [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    [formatter setDateFormat:dateTimeFormat];
    NSString * time = [formatter stringFromDate:datetime];
    return time;
}

+(NSString*)getSystemTime
{
    return [BSUtility getSystemTimeWithFormat:@"yyyy-MM-dd HH:mm:ss"];
}

+(NSString *)getSystemDate
{
    return [BSUtility getSystemTimeWithFormat:@"yyyy-MM-dd"];
}
+(NSString *)transTimeIntervalToDateStrDefault:(NSString *)dateTimeInterval
{
    return [BSUtility transTimeIntervalToDateStr:dateTimeInterval dateTimeFormat:@"yyyy-MM-dd"];
}
+(NSString *)transTimeIntervalToDateStr:(NSString *)dateTimeInterval dateTimeFormat:(NSString *)format
{
    CGFloat timeInterval =  [dateTimeInterval floatValue] ;
    return  [BSUtility getDateTimeWithFormat:[NSDate dateWithTimeIntervalSince1970:timeInterval] Format:format] ;
}
+(NSString *) getUUIDString
{
    CFUUIDRef uuid_ref = CFUUIDCreate(NULL);
    NSArray * tmp = [[NSString stringWithFormat:@"%@" ,uuid_ref ]componentsSeparatedByString:@" "];
    return tmp.count ==3 ? [tmp objectAtIndex:2] : @"" ;
}

//长度限制
+(BOOL)contextLengthLimit:(NSRange)range replacementString:(NSString*)string MaxLength:(int)maxLength
{
    return !(range.location == maxLength);
    
}

//值域限制 
+(BOOL)contextDomainLimit:(NSString *)replacementString ValidDomain:(NSString *)validDomain
{
    NSCharacterSet *cs;
    cs =[[NSCharacterSet characterSetWithCharactersInString:validDomain]invertedSet];
    NSString *filtered =[[replacementString componentsSeparatedByCharactersInSet:cs]componentsJoinedByString:@""];
    return [replacementString isEqual:filtered];
}

+(BOOL)hasNumberString:(NSString *)str
{
    NSString *f = @"1,2,3,4,5,6,7,8,9,0";
    return [f containsString:str];
    
}

+(void)copyStr:(NSString*)str
{
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = str;
}

+(NSString *)toPingYin:(NSString*)en
{
    NSString *hanziText = en;
    NSString *str = @"xx";
    if ([hanziText length]) {
        NSMutableString *ms = [[NSMutableString alloc] initWithString:hanziText];
        if (CFStringTransform((__bridge CFMutableStringRef)ms, 0, kCFStringTransformMandarinLatin, NO)) {
            NSLog(@"pinyin: %@", ms);
            str = ms;
        }
        if (CFStringTransform((__bridge CFMutableStringRef)ms, 0, kCFStringTransformStripDiacritics, NO)) {
            NSLog(@"pinyin: %@", ms);
            str = ms;
        }
    }
    return str;
}

/**
 *  删除日志文件
 *
 *  @param path 文件目录
 *  @param reserveDays 保留天数
 */
+(void)deleteLogFiles:(NSString*)path Reserve:(NSInteger)reserveDays
{
    if (reserveDays ==0) {
        return;
    }
    reserveDays --;//因为包含本日
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error = nil;
    NSArray *fileList = [[NSArray alloc] init];
    //fileList便是包含有该文件夹下所有文件的文件名及文件夹名的数组
    fileList = [fileManager contentsOfDirectoryAtPath:path error:&error];
    for (int i =0; i < fileList.count; i++) {
        NSString *fileName = [fileList objectAtIndex:i];
        if ([fileName hasSuffix:@".txt"]) {
            fileName = [[fileName componentsSeparatedByString:@"."] objectAtIndex:0];
            NSDate *fileDate = [BSUtility StrToDate:@"yyyy-MM-dd" DateStr:fileName];
            NSTimeInterval interval = [fileDate timeIntervalSinceNow];
            NSInteger intervalDays = abs((int)( interval / (24.0 * 60 * 60)));
            if (intervalDays >reserveDays) {
                NSError *error = nil;
                NSString * deleteFile = [path stringByAppendingPathComponent:[fileList objectAtIndex:i]];
                [fileManager removeItemAtPath:deleteFile error:&error];
            }
        }
    }
}

+(void) writeLog:(NSString *)logText
{
    NSString *fileName = [NSString stringWithFormat:@"%@.txt",[self getSystemDate]];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *filepath =[[paths objectAtIndex:0]stringByAppendingPathComponent:fileName];
    NSFileHandle *fileHandle = [NSFileHandle fileHandleForWritingAtPath:filepath];
    if (fileHandle == nil)
    {
        [BSUtility deleteLogFiles:[paths objectAtIndex:0] Reserve:7];
        NSError *error = nil;
        [logText writeToFile:filepath atomically:YES encoding:NSUTF8StringEncoding error:&error];
    }
    else {
        [fileHandle seekToEndOfFile];
        [fileHandle writeData:[logText dataUsingEncoding:NSUTF8StringEncoding]];
        [fileHandle closeFile];
    }
}

//拨打电话
+(void)callPhone:(NSString *)telnum view :(UIView *)parentView;
{
//    UIWebView *callWebview =[[UIWebView alloc] init];
//    NSURL *telURL =[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",telnum]];
//    [callWebview loadRequest:[NSURLRequest requestWithURL:telURL]];
//    [parentView addSubview:callWebview];

    if(__IOS11)
    {
        NSString *num = [[NSString alloc] initWithFormat:@"tel://%@",telnum]; //number为号码字符串
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:num]];
        return;
    }
    MyMessageBox* messageBox =[[MyMessageBox alloc]init];
    [messageBox show:telnum message:@"" cancelButtonTitle:@"取消" otherButtonTitles:@"拨打" completion: ^(NSInteger index){
//        NSLog(@"ssddd:%ld",index);
        if(index == 1)
        {
        NSString *num = [[NSString alloc] initWithFormat:@"tel://%@",telnum]; //number为号码字符串
               [[UIApplication sharedApplication] openURL:[NSURL URLWithString:num]];
        }
    }];
}

+(NSDate *)StrToDate:(NSString *)dataFormat DateStr:(NSString *)dateStr
{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
//     [dateFormat setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
//    [dateFormat setLocale:[NSLocale currentLocale]];
    [dateFormat setDateFormat:dataFormat];
    return [dateFormat dateFromString:dateStr];
}
/**
 *  空转为指定值
 *
 *  @param str
 *  @param specifity
 *  @return 判断str是否为空，如果为空返回 specifity
 */
+(NSString*)nulltoSpecifity:(NSString *)str Specifity:(NSString*)specifity
{
    return (str == NULL || str.length ==0) ? specifity : str;
}

+(NSString*)nullToEmpty:(id)str
{
    return [BSUtility isNullId:str] ? @"" : str;
}
+(BOOL)isNullId:(id)obj
{
    return obj == NULL || ([obj isKindOfClass:[NSString class]] && ([@"" isEqual:obj] || [@"null" isEqualToString:[((NSString *)obj) lowercaseString]] ||[@"(null)" isEqualToString:[((NSString *)obj) lowercaseString]]) );
}

+(NSString *)getWebViewSource:(UIWebView *)webView;
{
    NSString *jsToGetHTMLSource =
    @"document.getElementsByTagName(\"html\")[0].innerHTML";
    
    NSString *htmlSource =[ NSString stringWithFormat:@"<html>%@</html>" ,[webView
                            stringByEvaluatingJavaScriptFromString:jsToGetHTMLSource] ];
    
    return htmlSource;
}

+(BOOL)checkIdentityCardNo:(NSString*)cardNo
{
    if (cardNo.length != 18) {
        return  NO;
    }
    NSArray* codeArray = [NSArray arrayWithObjects:@"7",@"9",@"10",@"5",@"8",@"4",@"2",@"1",@"6",@"3",@"7",@"9",@"10",@"5",@"8",@"4",@"2", nil];
    NSDictionary* checkCodeDic = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"1",@"0",@"X",@"9",@"8",@"7",@"6",@"5",@"4",@"3",@"2", nil]  forKeys:[NSArray arrayWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10", nil]];
    
    NSScanner* scan = [NSScanner scannerWithString:[cardNo substringToIndex:17]];
    
    int val;
    BOOL isNum = [scan scanInt:&val] && [scan isAtEnd];
    if (!isNum) {
        return NO;
    }
    int sumValue = 0;
    
    for (int i =0; i<17; i++) {
        sumValue+=[[cardNo substringWithRange:NSMakeRange(i , 1) ] intValue]* [[codeArray objectAtIndex:i] intValue];
    }
    
    NSString* strlast = [checkCodeDic objectForKey:[NSString stringWithFormat:@"%d",sumValue%11]];
    
    if ([strlast isEqualToString: [[cardNo substringWithRange:NSMakeRange(17, 1)]uppercaseString]]) {
        return YES;
    }
    return  NO;
}
+(BOOL) containsChinese:(NSString *)str;
{
    return [BSUtility chineseLength:str] >0;
}
//判断字符串中汉字长度
+(NSInteger) chineseLength:(NSString *)str
{
    NSInteger result =0;
    for(int i = 0; i < [str length]; i++) {
        int a = [str characterAtIndex:i];
        if( a >= 0x4e00 && a < 0x9fff)
            result++;
    }
    return result;
}

/**
 *  使用正则表达式判断输入是否合法
 *
 *  @param regPattern 正则表达式
 *  @param inputValue 输入串
 *
 *  @return 是否匹配正则表达式
 */
+(BOOL)regMatch:(NSString *)regPattern CheckValue:(NSString*)inputValue
{
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regPattern];
    return [identityCardPredicate evaluateWithObject:inputValue];
}


/**
 *  把字符串中的\r\n删除掉
 *
 *  @param string 输入字符串
 *
 *  @return 删除后的字符串
 */
+(NSString *)trimodoa:(NSString *)string
{
    NSString* result = [string stringByReplacingOccurrencesOfString: @"\r" withString:@""];
    result =[result stringByReplacingOccurrencesOfString: @"\n" withString:@""];
    return result;
}
/**
 *  删除指定字符集
 *
 *  @param string    待过滤字符串
 *  @param specifity 要过滤的字符集
 *
 *  @return 过滤后字符串
 */
+(NSString *)trimSpecifity:(NSString *)string specifity:(NSString *)specifity
{
    NSCharacterSet *cs;
    cs =[NSCharacterSet characterSetWithCharactersInString:specifity];
    NSString *filtered =[[string componentsSeparatedByCharactersInSet:cs]componentsJoinedByString:@""];
    return filtered;
}
/**
 *  使用正则表达式清除不可见字符
 *
 *  @param string 输入字符串
 *
 *  @return 清除不可见后的字符串
 */
+(NSString *)trimEmpty:(NSString *)inputStr;
{
    NSError *error;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@".+" options:0 error:&error];
    if (regex != nil) {
        NSArray *matchs=[regex matchesInString:inputStr options:0 range:NSMakeRange(0, [inputStr length])];
        NSMutableString *result = [[NSMutableString alloc]init];
        for (int i =0; i < matchs.count; i++) {
            NSTextCheckingResult *match = (NSTextCheckingResult *) [matchs objectAtIndex:i];
            NSRange resultRange = [match rangeAtIndex:0];
            NSString *matchString=[inputStr substringWithRange:resultRange];
            //输出结果
            NSLog(@"%@",matchString);
            [result appendString:matchString];
        }
        return result;
    }
    return @"";
}

+(UIView *) loadViewFromXib:(NSString *) xib index:(NSInteger) index
{
    NSArray *views =[[NSBundle mainBundle]loadNibNamed:xib owner:nil options:nil];
    return  (views.count > index)? views[index]: NULL;
}

+(UIView *) loopView:(UIView *)view  condition:(BOOL (^)(UIView *))condition  finded:(BOOL (^)(UIView * findedView))finded
{
    if (condition != nil && condition(view))
    {
        if (finded != nil) {
            BOOL findResult = finded(view); //是否继续搜索
            if (findResult) {
                return view;
            }
        }
    }
    NSInteger viewCount = [view.subviews count];
    for (NSInteger i = 0; i < viewCount; i++)
    {
        UIView *subview = [view.subviews objectAtIndex:i];
        UIView* findedView = [BSUtility loopView:subview condition:condition finded:finded];
        if (findedView != NULL) {
            return findedView;
        }
    }
    return NULL;
}


+(void)displayViewDescription:(UIView *)view
{
#if DEBUG == 1
    
    [BSUtility loopView:view condition:^BOOL(UIView * condition) {
        return TRUE;
    } finded:^BOOL(UIView * findedView) {
        NSLog(@"%@",[findedView description] );
        return FALSE;
    }];
#endif
}

+(UIView *)FindViewByClass:(UIView *)supperView  ViewClassName:(NSString *)viewName;
{
    return [BSUtility loopView:supperView condition:^BOOL(UIView * condition) {
        return [NSStringFromClass([supperView class]) isEqualToString:viewName];
    } finded:^BOOL(UIView * findedView) {
        return TRUE;
    }];
    
//    
//    if ([NSStringFromClass([supperView class]) isEqualToString:viewName])
//    {
//        return supperView;
//    }
//    int viewCount = [supperView.subviews count];
//    for (int i = 0; i < viewCount; i++)
//    {
//        UIView *subview = [supperView.subviews objectAtIndex:i];
//        if ([NSStringFromClass([subview class]) isEqualToString:viewName])
//        {
//            return subview;
//        }
//        if(subview.subviews.count >0)
//        {
//            UIView * finded =[BSUtility FindViewByClass:subview ViewClassName:viewName];
//            if (finded != NULL) {
//                return finded;
//            }
//        }
//    }
//    return NULL;
}

+(UIViewController *)FindViewControllerByClass:(UIViewController *)vc className:(NSString *)className;
{
    UINavigationController *nvc = [vc isKindOfClass:[UINavigationController class]] ? (UINavigationController *)vc : vc.navigationController;
    for (int i =0; i < nvc.viewControllers.count; i++) {
        UIViewController *p = [nvc.viewControllers objectAtIndex:i];
        if ([p isKindOfClass:NSClassFromString(className)]) {
            return p;
        }
        //if ([NSStringFromClass([p class]) isEqualToString:className])
        //    return p;
    }
    
    return NULL;
    
}

+ (UIViewController*)viewController:(UIView *)currentView
{
    UIView* next = currentView;
    for (; next; next = next.superview) {
        
        UIResponder* nextResponder = [next nextResponder];
        
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return  [nextResponder isKindOfClass:[UINavigationController class]] ? (UIViewController *)((UINavigationController *)nextResponder).viewControllers.lastObject:   (UIViewController*)nextResponder;
            
        }
        next = [next superview];
        
    }
    
    return nil;
    
}

//获取当前屏幕显示的viewcontroller
+ (UIViewController *)getCurrentVC
{
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    
    return result;
}

+(BOOL)saveDefault:(NSDictionary *) values
{
    if (values != NULL) {
        
        for (NSString *key in values.allKeys) {
            NSString *value = values[key];
            [[NSUserDefaults standardUserDefaults]setObject:value
                                                     forKey:key];
        }
        return [[NSUserDefaults standardUserDefaults]synchronize];
    }
    return FALSE;
}

+(BOOL)saveDefault:(NSString *)key AndValue:(NSString *)value
{
    if (value != NULL) {
        [[NSUserDefaults standardUserDefaults]setObject:value
                                                 forKey:key];
        return [[NSUserDefaults standardUserDefaults]synchronize];
    }
    return FALSE;
}


//保存敏感数据
+(void) saveSecretData:(NSString *) key andValue:(NSString *) value
{
    [BSUtility saveSecretData:@{key:value}];
}
+(void) saveSecretData:(NSDictionary *) values
{
    NSString * bundleId= [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"];
    //构建wapper
    KeychainItemWrapper *wrapper = [[KeychainItemWrapper alloc] initWithIdentifier:bundleId accessGroup:nil];
    id currentObject = [wrapper objectForKey:(__bridge id)kSecValueData];
    if (!currentObject || [currentObject length] ==0) {
        currentObject = [[NSMutableDictionary alloc] init];
    }
    else {
        currentObject = [[NSMutableDictionary alloc] initWithDictionary:[NSJSONSerialization JSONObjectWithData:[currentObject dataUsingEncoding:NSUTF8StringEncoding] options:0 error:nil]];
    }
    for (NSString *key in values.allKeys) {
        [(NSMutableDictionary *)currentObject setObject:values[key] forKey:key];
    }
    [wrapper setObject:[[NSString alloc] initWithData: [NSJSONSerialization dataWithJSONObject:currentObject options:NSJSONWritingPrettyPrinted error:nil] encoding:NSUTF8StringEncoding] forKey:(__bridge id)kSecValueData];
}
//获取敏感数据
+(NSString *)getSecretData:(NSString*)key
{
    return [BSUtility getSecretDataBatch:@[key]][0];

}
+(NSArray *) getSecretDataBatch:(NSArray *)keys
{
    NSMutableArray *result = [[NSMutableArray alloc] init];
    NSString * bundleId= [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"];
    //构建wapper
    KeychainItemWrapper *wrapper = [[KeychainItemWrapper alloc] initWithIdentifier:bundleId accessGroup:nil];
    NSString * dataStr = [wrapper objectForKey:(__bridge id)kSecValueData];
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[dataStr dataUsingEncoding:NSUTF8StringEncoding] options:0 error:nil];
    if (dict) {
        for (NSString *key in keys) {
            [result addObject:[dict objectForKey:key]];
        }
        return result;
    }
    else return NULL;
}



///显示所有cookie值
+(void) displayCookies
{
    NSHTTPCookieStorage *cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (NSHTTPCookie *cookie in [cookieJar cookies]) {
        NSLog(@"%@", cookie);
    }
}

+(NSHTTPCookieStorage *) getCookies
{
    return [NSHTTPCookieStorage sharedHTTPCookieStorage];
}

+(void) clearCookies
{
    NSHTTPCookieStorage *cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    NSArray *_tmpArray = [NSArray arrayWithArray:[cookieJar cookies]];
    for (id obj in _tmpArray) {
        [cookieJar deleteCookie:obj];
    }
}

+(void)AddCookie:(NSString *)cookieName CookieValue:(NSString *)cookieValue
{
    NSMutableDictionary *cookieProperties = [NSMutableDictionary dictionary];
    [cookieProperties setObject:cookieName forKey:NSHTTPCookieName];
    [cookieProperties setObject:cookieValue forKey:NSHTTPCookieValue];
    NSHTTPCookie *cookie = [NSHTTPCookie cookieWithProperties:cookieProperties];
    [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie];
}

+(void) AddCookie:(NSString *)domain OriginUrl:(NSString *)originUrl CookieName:(NSString *)cookieName CookieValue:(NSString *)cookieValue
{
    NSMutableDictionary *cookieProperties = [NSMutableDictionary dictionary];
    [cookieProperties setObject:cookieName forKey:NSHTTPCookieName];
    [cookieProperties setObject:cookieValue forKey:NSHTTPCookieValue];
    [cookieProperties setObject:domain forKey:NSHTTPCookieDomain];
    [cookieProperties setObject:originUrl forKey:NSHTTPCookieOriginURL];
    [cookieProperties setObject:@"/" forKey:NSHTTPCookiePath];
    [cookieProperties setObject:@"0" forKey:NSHTTPCookieVersion];
    NSHTTPCookie *cookie = [NSHTTPCookie cookieWithProperties:cookieProperties];
    [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie];
}

+(NSString *)getHost:(NSString *)requestUrl
{
    requestUrl = [requestUrl lowercaseString];
    NSArray * subStrs = [requestUrl componentsSeparatedByString:@":"];
    NSString *host;
    if ([requestUrl hasPrefix:@"http"] || [requestUrl hasPrefix:@"https"]) {
        host = [subStrs objectAtIndex:1];
        host = [host substringFromIndex:2];
    }
    else host = [subStrs objectAtIndex:0];
    return [[host componentsSeparatedByString:@"/"] objectAtIndex:0];
}

+(NSArray *) getDefaultBatch:(NSArray *) keys
{
    NSMutableArray *result = [[NSMutableArray alloc] init];
    for (NSString *key in keys) {
        NSString *value = [BSUtility getDefault:key];
        [result addObject:[BSUtility nullToEmpty:value]];
    }
    return result;
}

+(NSString *)getDefault:(NSString*)key
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString * name =[defaults objectForKey:key];
    return name;
}

+(NSString*)pointToString:(CGPoint)point
{
    NSString *s = [NSString stringWithFormat:@"x=%f,y=%f",point.x,point.y];
    NSLog(@"point = %@",s);
    return s;
}

+(NSString*)sizeToString:(CGSize) size
{
    NSString *s =[NSString stringWithFormat:@"w=%f,h=%f",size.width,size.height];
    NSLog(@"size = %@",s);
    return s;
}
+(NSString*)rectToString:(CGRect)rect
{
    return [NSString stringWithFormat:@"x=%f,y=%f,w=%f,h=%f",rect.origin.x,rect.origin.y,rect.size.width,rect.size.height];
}

+(NSString *)indexPathToString:(NSIndexPath *) index
{
    return [NSString stringWithFormat:@"index.section=%ld,index.row=%ld",index.section,index.row];
}


//=======NSArray=========//
+(NSArray *) getArrayByCondition:(NSArray *)array condition:(BOOL (^)(id))condition
{
    NSMutableArray *result = [[NSMutableArray alloc]init];
    for (int i =0; i < array.count; i++) {
        id obj = [array objectAtIndex:i];
        if (condition != nil && condition(obj))
        {
            [result addObject:obj];
        }
    }
    return result;
}
//==========textView=========//
-(void)htmlDisplay:(NSString *)htmlText textView:(UITextView *) textView
{
      NSAttributedString *attributedString = [[NSAttributedString alloc] initWithData:[htmlText dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
      textView.attributedText = attributedString;
}

+(BOOL)idCardVertity:(NSString *)idcard view:(UIView *)currentView
{
    //验证身份证号是否合法
    if (idcard.length<18){
        if (idcard.length ==0) {
            TOASTSHOWUNDERVIEW(@"请输入证件号码", currentView, CGPointMake(0,10));
        }else{
            TOASTSHOWUNDERVIEW(@"请输入正确的身份证号", currentView, CGPointMake(0,10));
        }
        
        return FALSE;
    }
    if (idcard.length==18)
    {
        BOOL flag;
        NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
        NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
        flag =[identityCardPredicate evaluateWithObject:idcard];
        if (!flag) {
            TOASTSHOWUNDERVIEW(@"请输入正确的身份证号", currentView, CGPointMake(0,10));
            return flag;
        }
        if (![BSUtility checkIdentityCardNo:idcard]) {
            TOASTSHOWUNDERVIEW(@"请输入正确的身份证号", currentView, CGPointMake(0,10));
            return false;
        }
    }
    if (idcard == nil || idcard.length ==0) {
        TOASTSHOWUNDERVIEW(@"请输入证件号码", currentView, CGPointMake(0,10));
        return FALSE;
    }
    return TRUE;
}

+(CGSize)matchMaxSize:(CGSize)maxSize sourceSize:(CGSize)sourceSize
{
    CGFloat scaleFactor;
    CGFloat widthFactor = maxSize.width / sourceSize.width;
    CGFloat heightFactor = maxSize.height / sourceSize.height;
    if (widthFactor < heightFactor)
        scaleFactor = widthFactor;
    else
        scaleFactor = heightFactor;
    return CGSizeMake(sourceSize.width * scaleFactor, sourceSize.height * scaleFactor);
}



//获取手机通讯录
+ (NSDictionary *)getPhoneBook
{
    NSMutableDictionary *result = [[NSMutableDictionary alloc] init];
    //NSMutableString * result = [[NSMutableString alloc] initWithString:@"["];
    ABAddressBookRef addressBooks = nil;
    
    addressBooks = ABAddressBookCreateWithOptions(NULL, NULL);
    //获取通讯录权限
    dispatch_semaphore_t sema = dispatch_semaphore_create(0);
    ABAddressBookRequestAccessWithCompletion(addressBooks, ^(bool granted,CFErrorRef error){dispatch_semaphore_signal(sema);});
    dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
    
    //获取通讯录中的所有人
    CFArrayRef allPeople = ABAddressBookCopyArrayOfAllPeople(addressBooks);
    //通讯录中人数
    CFIndex nPeople = ABAddressBookGetPersonCount(addressBooks);
    for (NSInteger i = 0; i<nPeople; i++) {
        //        //创建一个addressBook shuxing类
        //        TKAddressBook *addressBook = [[TKAddressBook alloc] init];
        //获取个人
        ABRecordRef person = CFArrayGetValueAtIndex(allPeople,i);
        //获取个人名字
        CFTypeRef abName = ABRecordCopyValue(person, kABPersonAddressProperty);
        CFTypeRef abLastName = ABRecordCopyValue(person, kABPersonLastNameProperty);
        CFStringRef abFullName = ABRecordCopyCompositeName(person);
        NSString *nameString = (__bridge NSString *)abName;
        NSString *lastNameString = (__bridge NSString *)abLastName;
        if ((__bridge id)abFullName != nil) {
            nameString = (__bridge NSString *)abFullName;
        }else{
            if ((__bridge id)abLastName != nil)
            {
                nameString = [NSString stringWithFormat:@"%@ %@", nameString, lastNameString];
            }
        }

        ABPropertyID multiProperties[] = {
            kABPersonPhoneProperty
//            ,kABPersonEmailProperty
        };
        NSInteger multiPropertiesTotal = sizeof(multiProperties) / sizeof(ABPropertyID);
        for (NSInteger j = 0; j < multiPropertiesTotal; j++) {
            ABPropertyID property = multiProperties[j];
            ABMultiValueRef valuesRef = ABRecordCopyValue(person, property);
            NSInteger valuesCount = 0;
            if (valuesRef != nil) valuesCount = ABMultiValueGetCount(valuesRef);
            if (valuesCount == 0) {
                CFRelease(valuesRef);
                continue;
            }
            //获取电话号码和email
            for (NSInteger k = 0; k < valuesCount; k++) {
                CFTypeRef value = ABMultiValueCopyValueAtIndex(valuesRef, k);
                switch (j) {
                    case 0: {// Phone number
                        NSString *phoneNumber = (__bridge NSString*)value;
                        phoneNumber = [BSUtility trimSpecifity:phoneNumber specifity:@"- "];
                        phoneNumber = phoneNumber.trimString;
                        if (!nameString || ![nameString isKindOfClass:NSClassFromString(@"NSString")]) {
                            break;
                        }
                        [result setObject:nameString forKey:phoneNumber];
                        NSLog(@"name %@=%@",nameString,phoneNumber);
                        break;
                    }
                }
                CFRelease(value);
            }
            CFRelease(valuesRef);
        }
        //将个人信息添加到数组中，循环完成后addressBookTemp中包含所有联系人的信息
        
    }
    return result;
}


//创建联系人
+ (void) creatNewRecord:(NSString *)name phoneNumber:(NSString *)phoneNumber withParentVC:(UIViewController *)vc
{
//    // 初始化一个ABAddressBookRef对象，使用完之后需要进行释放，
//    // 这里使用CFRelease进行释放
//    // 相当于通讯录的一个引用
//    ABAddressBookRef addressBook = ABAddressBookCreate();
//    // 新建一个联系人
//    // ABRecordRef是一个属性的集合，相当于通讯录中联系人的对象
//    // 联系人对象的属性分为两种：
//    // 只拥有唯一值的属性和多值的属性。
//    // 唯一值的属性包括：姓氏、名字、生日等。
//    // 多值的属性包括:电话号码、邮箱等。
//    ABRecordRef person = ABPersonCreate();
//    NSString *firstName = @"四";
//    NSString *lastName = @"李";
//    NSDate *birthday = [NSDate date];
//    // 电话号码数组
//    NSArray *phones = [NSArray arrayWithObjects:@"123",@"456",nil];
//    // 电话号码对应的名称
//    NSArray *labels = [NSArray arrayWithObjects:@"iphone",@"home",nil];
//    // 保存到联系人对象中，每个属性都对应一个宏，例如：kABPersonFirstNameProperty
//    // 设置firstName属性
//    ABRecordSetValue(person, kABPersonFirstNameProperty,(CFStringRef)firstName, NULL);
//    // 设置lastName属性
//    ABRecordSetValue(person, kABPersonLastNameProperty, (CFStringRef)lastName, NULL);
//    // 设置birthday属性
//    ABRecordSetValue(person, kABPersonBirthdayProperty,(CFDateRef)birthday, NULL);
//    // ABMultiValueRef类似是Objective-C中的NSMutableDictionary
//    ABMultiValueRef mv =ABMultiValueCreateMutable(kABMultiStringPropertyType);
//    // 添加电话号码与其对应的名称内容
//    for (int i = 0; i < [phones count]; i ++) {
//        ABMultiValueIdentifier mi = ABMultiValueAddValueAndLabel(mv,(CFStringRef)[phones objectAtIndex:i], (CFStringRef)[labelsobjectAtIndex:i], &mi);
//    }
//    // 设置phone属性
//    ABRecordSetValue(person, kABPersonPhoneProperty, mv, NULL);
//    // 释放该数组
//    if (mv) {
//        CFRelease(mv);
//    }
//    // 将新建的联系人添加到通讯录中
//    ABAddressBookAddRecord(addressBook, person, NULL);
//    // 保存通讯录数据
//    ABAddressBookSave(addressBook, NULL);
//    // 释放通讯录对象的引用
//    if (addressBook) {
//        CFRelease(addressBook);
//    }
    
    
//    
//    CFErrorRef error = NULL;
//    
//    //创建一个通讯录操作对象
//    ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, &error);
//    
//    //创建一条新的联系人纪录
//    ABRecordRef newRecord = ABPersonCreate();
//    
//    //为新联系人记录添加属性值
//    ABRecordSetValue(newRecord, kABPersonFirstNameProperty, (__bridge CFTypeRef)name, &error);
//    
//    //创建一个多值属性
//    ABMutableMultiValueRef multi = ABMultiValueCreateMutable(kABMultiStringPropertyType);
//    ABMultiValueAddValueAndLabel(multi, (__bridge CFTypeRef)phoneNumber, kABPersonPhoneMobileLabel, NULL);
//    ABMultiValueAddValueAndLabel(multi, (__bridge CFTypeRef)phoneNumber, kABPersonPhoneIPhoneLabel, NULL);
//    
//    //将多值属性添加到记录
//    ABRecordSetValue(newRecord, kABPersonPhoneProperty, multi, &error);
//    CFRelease(multi);
//    
//    //添加记录到通讯录操作对象
//    ABAddressBookAddRecord(addressBook, newRecord, &error);
//    
//    //保存通讯录操作对象
//  BOOL b = ABAddressBookSave(addressBook, &error);
//    CFRelease(newRecord);
//    CFRelease(addressBook);
    [BSUtility accessTheAddress:name phoneNumber:phoneNumber withParentVC:vc]; //授权
    ABNewPersonViewController *newPersonViewController = [[ABNewPersonViewController alloc] init];
//    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//    btn.frame = CGRectMake(0, 0, 29, 29);
//    [[UINavigationBar appearance] setTitleTextAttributes:
//     [NSDictionary dictionaryWithObjectsAndKeys:
//      [UIColor whiteColor],
//      NSForegroundColorAttributeName,
//      [UIColor whiteColor],
//      NSForegroundColorAttributeName,
//      [NSValue valueWithUIOffset:UIOffsetMake(0, -1)],
//      NSForegroundColorAttributeName,
//      [UIFont fontWithName:@"Arial-Bold" size:0.0],
//      NSFontAttributeName,
//      nil]];
  
    vc.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [vc.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
//    [btn setImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateNormal];
//    [btn setImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateHighlighted];
//     vc.navigationItem.backBarButtonItem =  [[UIBarButtonItem alloc] initWithCustomView:btn];
//    [btn addTarget:vc action:@selector(handleReturnBack:) forControlEvents:UIControlEventTouchUpInside];
//    newPersonViewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    // Create a new contact
    //ABContact *contact = [ABContact contact];
    // Create the pre-filled properties
    ABRecordRef newPerson = ABPersonCreate();
    ABMutableMultiValueRef multiValue = ABMultiValueCreateMutable(kABMultiDictionaryPropertyType);
    CFErrorRef error = NULL;
    multiValue = ABMultiValueCreateMutable(kABMultiStringPropertyType);
    ABMultiValueAddValueAndLabel(multiValue, (__bridge CFTypeRef)phoneNumber, kABPersonPhoneMainLabel, NULL);
    ABRecordSetValue(newPerson, kABPersonPhoneProperty, multiValue , &error);
    NSAssert(!error, @"Something bad happened here.");
    newPersonViewController.displayedPerson = newPerson;
    // Set delegate
    newPersonViewController.newPersonViewDelegate = vc;
    [vc.navigationController pushViewController:newPersonViewController animated:YES];
}



//由于在ios6以后对用户信息提供了安全的保护，在获取前必须要通过用户的同意才行
+ (void)accessTheAddress:(NSString *)name phoneNumber:(NSString *)phoneNumber withParentVC:(UIViewController *)vc
{
    ABAddressBookRef addressBook = nil;
    
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 6.0) {
        addressBook = ABAddressBookCreateWithOptions(NULL, NULL);
        //等待同意后向下执行
        dispatch_semaphore_t sema = dispatch_semaphore_create(0);
        ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error) {
            dispatch_semaphore_signal(sema);
            NSLog(@"这里是用户选择是否允许后的执行代码");
            if (granted) {
           
                }
            else
            {
            
            }
        });
    }
    else{
        addressBook = ABAddressBookCreateWithOptions(NULL, NULL);
    }
    
}
+ (NSInteger)numberOfDaysFromTodayByTime:(NSString *)time timeStringFormat:(NSString *)format
{
    NSInteger nSecs = [BSUtility numberOfSecsFromTodayByTime:time timeStringFormat:format];
        NSInteger oneDaySecs = 24*3600;
    NSInteger day = nSecs/oneDaySecs;
    return day;
}
+ (NSInteger)numberOfSecsFromTodayByTime:(NSString *)time timeStringFormat:(NSString *)format
{
    // format可以形如： @"yyyy-MM-dd"
    
//    NSDate *today = [NSDate date];
//    
    NSTimeZone *localTimeZone = [NSTimeZone systemTimeZone];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setTimeZone:localTimeZone];
    [formatter setDateFormat:NSLocalizedString(format,nil)];
    NSDate *date = [NSDate date]; // 获得时间对象
    
//    NSTimeZone *zone = [NSTimeZone systemTimeZone]; // 获得系统的时区
    
    NSTimeInterval stime = [localTimeZone secondsFromGMTForDate:date];// 以秒为单位返回当前时间与系统格林尼治时间的差
    
    NSDate *today = [date dateByAddingTimeInterval:stime];// 然后把差的时间加上,就是当前系统准确的时间
    // 时分秒转为00:00:00
    NSDate *today2 = [formatter dateFromString:[formatter stringFromDate:today]];
    
    NSDate *newDate = [BSUtility StrToDate:format DateStr:time];//[formatter dateFromString:time];
    newDate =  [newDate dateByAddingTimeInterval:stime];
    // 时分秒转为00:00:00
    NSDate *newDate2 = [formatter dateFromString:[formatter stringFromDate:newDate]];
    double dToday =  today2.timeIntervalSince1970;
    double dNewDate = newDate2.timeIntervalSince1970;
    
    NSInteger nSecs = (NSInteger)(dToday -dNewDate);
//    NSInteger oneDaySecs = 24*3600;
    return nSecs;
}


@end
