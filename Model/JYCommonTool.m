//
//  JYCommonTool.m
//  yihui
//
//  Created by air on 15/9/23.
//  Copyright (c) 2015年 ORANLLC_IOS1. All rights reserved.
//

#import "JYCommonTool.h"

@implementation JYCommonTool

+(BOOL)isAlphaOrNum:(NSString *)str
{
    NSString *f = @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789➋➌➍➎➏➐➑➒";
    return [f containsString:str];
}
+(BOOL)isBiaoDianFuHao:(NSString *)str
{
     NSString *f = @".,。，“”：:""';‘；《》<>！!*￥%";
     return [f containsString:str];
}
+ (BOOL) validateEmail:(NSString *)email
{
    NSString *emailRegex =@"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}


+(NSString *)stringForDate:(NSDate *)date withDateFormat:(NSString*)format{
     //@"yyyy-MM-dd HH:mm:ss"
     
     if (date == nil) {
          return @"";
     }
     
     NSDateFormatter *df = [[NSDateFormatter alloc] init];
     [df setDateFormat:format];
     
     NSString *str = [df stringFromDate:date];
     
     return str;
}


+(NSDate *)stringToDate:(NSString *)date withDateFormat:(NSString*)format{
     //@"yyyy-MM-dd HH:mm:ss"
     
     if (date.length == 0) {
          return nil;
     }
     
     NSDateFormatter *df = [[NSDateFormatter alloc] init];
     [df setDateFormat:format];
     
     NSDate *d = [df dateFromString:date];
     
     return d;
}

+(BOOL)hasNumberString:(NSString *)str
{
    NSString *f = @"1,2,3,4,5,6,7,8,9,0";
    return [f containsString:str];
    
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


+(BOOL)isFloatValue:(NSString *)str
{
    NSTextCheckingResult *tr = [JYCommonTool parseString:str withPattern:@"[^0-9.]"];
    if(tr)
    {
        return NO;
    }
   NSTextCheckingResult *r = [JYCommonTool parseString:str withPattern:@"^([1-9]\\d*.\\d*|0.\\d*[1-9]\\d*|[1-9]\\d*)$"];
    if (!r) {
        return NO;
    }
    else
    {
       NSRange rr = [r range];
        if (rr.length == 0) {
            return NO;
        }
        return YES;
    }
    return YES;
}

+(NSArray *)getLinkValue:(NSString*)str
{
    NSMutableArray *arr = [NSMutableArray array];
  NSRegularExpression *regex = [JYCommonTool getRegEx:str withPattern:@"[0-9]{7,23}"];
   [regex enumerateMatchesInString:str options:0 range:NSMakeRange(0, str.length) usingBlock:^(NSTextCheckingResult * _Nullable result, NSMatchingFlags flags, BOOL * _Nonnull stop) {
       if (result) {
           
           NSRange resultRange = [result rangeAtIndex:0]; //等同于 firstMatch.range --- 相匹配的范围
           
           //从urlString当中截取数据
           NSValue *v = [NSValue value:&resultRange withObjCType:@encode(NSRange)];
//           NSString *result = [str substringWithRange:resultRange];
           if (resultRange.location + resultRange.length <= str.length &&(resultRange.location + resultRange.length + 1 > str.length||![JYCommonTool isIntegerValue:[str substringWithRange:NSMakeRange(resultRange.location + resultRange.length + 1, 1)]])&&(resultRange.location == 0||![JYCommonTool isIntegerValue:[str substringWithRange:NSMakeRange(resultRange.location - 1, 1)]])) {
               [arr addObject:v];
           }
           
           
           //输出结果
           
//           NSLog(@"%@",result);
           
       }
   }];
    
//  arr = [regex  matchesInString:str options:0 range:NSMakeRange(0, str.length)];
    return arr;
}

+(BOOL)isIntegerValue:(NSString *)str
{
    NSTextCheckingResult *r = [JYCommonTool parseString:str withPattern:@"-?[1-9]\\d*"];
    if (!r) {
        return NO;
    }
    return YES;

}

//-(void)hasZhongwen
//{
//    NSRegularExpression *regularExpression = [NSRegularExpression regularExpressionWithPattern:@"[\u4e00-\u9fa5]" options:0 error:nil];
//    
//    NSUInteger numberOfMatches = [regularExpression numberOfMatchesInString:string options:0 range:NSMakeRange(0, [string length])];
//}

+(NSTextCheckingResult *)parseString:(NSString*)str withPattern:(NSString *)pattern

{
    
    //组装一个字符串，需要把里面的网址解析出来
    
    NSString *urlString = str;
    
    
    
    //NSRegularExpression类里面调用表达的方法需要传递一个NSError的参数。下面定义一个
    
    NSError *error;
    
//    /tp+:[^\\s]* 这个表达式是检测一个网址的。
    
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:0 error:&error];
    
    if (regex != nil) {
        
        NSTextCheckingResult *firstMatch=[regex firstMatchInString:urlString options:0 range:NSMakeRange(0, [urlString length])];
        
        if (firstMatch) {
            
            NSRange resultRange = [firstMatch rangeAtIndex:0]; //等同于 firstMatch.range --- 相匹配的范围
            
            //从urlString当中截取数据
            
            NSString *result = [urlString substringWithRange:resultRange];
            
            //输出结果
            
            NSLog(@"%@",result);
           
        }
        return firstMatch;
    }
    return nil;
}

+( NSRegularExpression *)getRegEx:(NSString*)str withPattern:(NSString *)pattern
{
    //组装一个字符串，需要把里面的网址解析出来
    
//    NSString *urlString = str;
    
    
    
    //NSRegularExpression类里面调用表达的方法需要传递一个NSError的参数。下面定义一个
    
    NSError *error;
    
    //    /tp+:[^\\s]* 这个表达式是检测一个网址的。
    
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:0 error:&error];
    return regex;
}
+(void)xxxxx:(NSString*)str withPattern:(NSString *)pattern
{
    //组装一个字符串，需要把里面的网址解析出来
    
    NSString *urlString = str;
    
    
    
    //NSRegularExpression类里面调用表达的方法需要传递一个NSError的参数。下面定义一个
    
    NSError *error;
    
    //    /tp+:[^\\s]* 这个表达式是检测一个网址的。
    
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:0 error:&error];
    
}

+ (BOOL)isNumberAndPoint:(NSString *)number{
    NSString *str = @"^[0-9]+([.]{0}|[.]{1}[0-9]+)$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", str];
    
    return [regextestmobile evaluateWithObject:number];
}

+ (BOOL) isMobileNum:(NSString *)mobNum {
    //    电信号段:133/149/153/173/177/180/181/189
    //    联通号段:130/131/132/145/155/156/171/175/176/185/186
    //    移动号段:134/135/136/137/138/139/147/150/151/152/157/158/159/178/182/183/184/187/188
    //    虚拟运营商:170
    
   NSString *MOBILE = @"^1(3[0-9]|4[1456789]|5[0-35-9]|7[01345-8]|8[0-9]|9[8-9]|66)\\d{8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    
    return [regextestmobile evaluateWithObject:mobNum];
}


+ (BOOL) isNumberAndLetters:(NSString *)str {

     
     NSString *regex = @"[a-z][A-Z][0-9]";
     
     NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
     
     return [predicate evaluateWithObject:str];
}





+(int)compareDate:(NSString*)date01 withDate:(NSString*)date02{
    int ci;
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *dt1 = [[NSDate alloc] init];
    NSDate *dt2 = [[NSDate alloc] init];
    dt1 = [df dateFromString:date01];
    dt2 = [df dateFromString:date02];
    NSComparisonResult result = [dt1 compare:dt2];
    switch (result)
    {
            //date02比date01大
        case NSOrderedAscending: ci=1; break;
            //date02比date01小
        case NSOrderedDescending: ci=-1; break;
            //date02=date01
        case NSOrderedSame: ci=0; break;
        default: NSLog(@"erorr dates %@, %@", dt2, dt1); break;
    }
    return ci;
}


+(int)compareNowDate:(NSString*)date{
     int ci;
     NSDateFormatter *df = [[NSDateFormatter alloc] init];
     [df setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
     NSDate *dt1 = [[NSDate alloc] init];
     NSDate *dt2 = [NSDate date];
     dt1 = [df dateFromString:date];
     NSComparisonResult result = [dt1 compare:dt2];
     switch (result)
     {
               //当前时间大
          case NSOrderedAscending: ci=-1; break;
               //当前时间小
          case NSOrderedDescending: ci=1; break;
               //相等
          case NSOrderedSame: ci=0; break;
          default: NSLog(@"erorr dates %@, %@", dt2, dt1); break;
     }
     return ci;
}


+(void)checkVersion:(UIViewController*)vc
{
  
    NSDictionary * infoc=[[NSBundle mainBundle] infoDictionary];
    NSString *currentVersion=[infoc objectForKey:@"CFBundleShortVersionString"];
      NSString *url=@"http://itunes.apple.com/lookup?id=1185351002";//id=835387569";
   // NSString *url = HTTPS_URL;
    
    NSMutableURLRequest *request=[[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:url]];
    [request setHTTPMethod:@"POST"];

    NSURLSession *session = [NSURLSession sharedSession];
  NSURLSessionDataTask *task =  [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable recervedData, NSURLResponse * _Nullable response, NSError * _Nullable error) {
      NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:recervedData options:NSJSONReadingAllowFragments error:nil];
      NSArray *infoarr=  [dic objectForKey:@"results"];
      if ([infoarr count]) {
          //[data addObject:infoarr];
          NSDictionary *releaseInfo=[infoarr objectAtIndex:0];
          NSString *lastVersion=[releaseInfo objectForKey:@"version"];
          if( [currentVersion compare:lastVersion] == NSOrderedAscending)
          {
              NSLog(@"快更新");
               [[CommonAPI managerWithVC:vc] showAlert:@selector(updateTipHandle:) withTitle:nil withMessage:@"发现新版本，立即更新" withObj:@{}];
          }
          else
          {
                NSLog(@"已更新");
          }
      }

  }];
    [task resume];
   
    
    
}
+(NSString*)getNetInfo
{
     UIApplication *app = [UIApplication sharedApplication];
     id statusBar = [app valueForKeyPath:@"statusBar"];
     NSString *network = @"";

     if (__IPHONEX) {
          //        iPhone X
          id statusBarView = [statusBar valueForKeyPath:@"statusBar"];
          UIView *foregroundView = [statusBarView valueForKeyPath:@"foregroundView"];

          NSArray *subviews = [[foregroundView subviews][2] subviews];

          for (id subview in subviews) {
               if ([subview isKindOfClass:NSClassFromString(@"_UIStatusBarWifiSignalView")]) {
                    network = @"WIFI";
               }else if ([subview isKindOfClass:NSClassFromString(@"_UIStatusBarStringView")]) {
                    network = [subview valueForKeyPath:@"originalText"];
               }
          }
     }else {
          //        非 iPhone X
          UIView *foregroundView = [statusBar valueForKeyPath:@"foregroundView"];
          NSArray *subviews = [foregroundView subviews];

          for (id subview in subviews) {
               if ([subview isKindOfClass:NSClassFromString(@"UIStatusBarDataNetworkItemView")]) {
                    int networkType = [[subview valueForKeyPath:@"dataNetworkType"] intValue];
                    switch (networkType) {
                         case 0:
                              network = @"NONE";
                              break;
                         case 1:
                              network = @"2G";
                              break;
                         case 2:
                              network = @"3G";
                              break;
                         case 3:
                              network = @"4G";
                              break;
                         case 5:
                              network = @"WIFI";
                              break;
                         default:
                              break;
                    }
               }
          }
     }
     if ([network isEqualToString:@""]) {
          network = @"NO DISPLAY";
     }
     return network;
}
//1、判断输入的字符串是否全是中文
+(BOOL)isAllChinese:(NSString *)str
{
    NSInteger count = str.length;
    NSInteger result = 0;
    for(int i=0; i< [str length];i++)
    {
        int a = [str characterAtIndex:i];
        if( a > 0x4e00 && a < 0x9fff)//判断输入的是否是中文
        {
            result++;
        }
        else if(a < 127)
        {
             result ++;
        }
    }
    if (count == result) {//当字符长度和中文字符长度相等的时候
        return YES;
    }
    return NO;
}
//+(BOOL)isChinese:(NSString *)str
//{
//     NSInteger count = str.length;
//     NSInteger result = 0;
//     for(int i=0; i< [str length];i++)
//     {
//          int a = [str characterAtIndex:i];
//          if( a > 0x4e00 && a < 0x9fff)//判断输入的是否是中文
//          {
//               result++;
//          }
//          else if([JYCommonTool isAlphaOrNum:[str substringWithRange:NSMakeRange(i, 1)]])
//          {
//               result ++;
//          }
//     }
//}
//1、判断输入的字符串是否有中文

+(BOOL)hasChinese:(NSString *)str
{
    for(int i=0; i< [str length];i++)
    {
        int a = [str characterAtIndex:i];
        if( a > 0x4e00 && a < 0x9fff)//判断输入的是否是中文
        {
            return YES;
        }
    }
    return NO;
}


+(UIImage*)getSubImage:(UIImage *)image mCGRect:(CGRect)mCGRect
             centerBool:(BOOL)centerBool{
    /*如若centerBool为Yes则是由中心点取mCGRect范围的图片*/
    float imgWidth = image.size.width;
    float imgHeight = image.size.height;
    float viewWidth = mCGRect.size.width;
    float viewHidth = mCGRect.size.height;
    CGRect rect;
    if(centerBool){
        float width = imgWidth>imgHeight?imgHeight:imgWidth;
        rect = CGRectMake((imgWidth-width)/2,(imgHeight-width)/2,width,width);
    }else{
        if(viewHidth < viewWidth){
            if(imgWidth <= imgHeight){
                rect = CGRectMake(0, 0, imgWidth, imgWidth*imgHeight/viewWidth);
            }else{
                float width = viewWidth*imgHeight/viewHidth;
                float x = (imgWidth - width)/2;
                if(x > 0){
                    rect = CGRectMake(x, 0, width, imgHeight);
                }else{
                    rect = CGRectMake(0, 0, imgWidth, imgWidth*viewHidth/viewWidth);
                }
            }
        }else{
            if(imgWidth <= imgHeight){
                float height = viewHidth*imgWidth/viewWidth;
                if(height < imgHeight){
                    rect = CGRectMake(0,0, imgWidth, height);
                }else{
                    rect = CGRectMake(0,0, viewWidth*imgHeight/viewHidth,imgHeight);
                }
            }else{
                float width = viewWidth * imgHeight / viewHidth;
                if(width < imgWidth){
                    float x = (imgWidth - width)/2;
                    rect = CGRectMake(x,0,width, imgHeight);
                }else{
                    rect = CGRectMake(0,0,imgWidth, imgHeight);
                }
            }
        }
    }
    
    CGImageRef subImageRef = CGImageCreateWithImageInRect(image.CGImage, rect);
    CGRect smallBounds = CGRectMake(0,0,CGImageGetWidth(subImageRef),CGImageGetHeight(subImageRef));
    
    UIGraphicsBeginImageContext(smallBounds.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextDrawImage(context, smallBounds, subImageRef);
    UIImage *smallImage = [UIImage imageWithCGImage:subImageRef];
    UIGraphicsEndImageContext();
    
    return smallImage;
}

+(NSString *)unescape:(NSString *)str{
    NSString *unescapeStr = unesp(str);
    return unescapeStr;
}

NSString* unesp(NSString* src){
    int lastPos = 0;
    int pos=0;
    unichar ch;
    NSString * tmp = @"";
    while(lastPos<src.length){
        NSRange range;
        
        range = [src rangeOfString:@"%" options:NSLiteralSearch range:NSMakeRange(lastPos, src.length-lastPos)];
        if (range.location != NSNotFound) {
            pos = (int)range.location;
        }else{
            pos = -1;
        }
        
        if(pos == lastPos){
            
            if([src characterAtIndex:(NSUInteger)(pos+1)]=='u'){
                NSString* ts = [src substringWithRange:NSMakeRange(pos+2,4)];
                
                int d = getIntStr(ts,4);
                ch = (unichar)d;
                NSLog(@"%@%C",tohex(d),ch);
                tmp = [tmp stringByAppendingString:[NSString stringWithFormat:@"%C",ch]];
                
                lastPos = pos+6;
                
            }else{
                NSString* ts = [src substringWithRange:NSMakeRange(pos+1,2)];
                int d = getIntStr(ts,2);
                ch = (unichar)d;
                tmp = [tmp stringByAppendingString:[NSString stringWithFormat:@"%C",ch]];
                lastPos = pos+3;
            }
            
        }else{
            if(pos ==-1){
                NSString* ts = [src substringWithRange:NSMakeRange(lastPos,src.length-lastPos)];
                
                tmp = [tmp stringByAppendingString:[NSString stringWithFormat:@"%@",ts]];
                lastPos = (int)src.length;
            }else{
                NSString* ts = [src substringWithRange:NSMakeRange(lastPos,pos-lastPos)];
                
                tmp = [tmp stringByAppendingString:[NSString stringWithFormat:@"%@",ts]];
                lastPos  = pos;
            }
        }
    }
    
    return tmp;
}

NSString * tohex(int tmpid)
{
    NSString *nLetterValue;
    NSString *str =@"";
    long long int ttmpig;
    for (int i = 0; i<9; i++) {
        ttmpig=tmpid%16;
        tmpid=tmpid/16;
        switch (ttmpig)
        {
            case 10:
                nLetterValue =@"A";break;
            case 11:
                nLetterValue =@"B";break;
            case 12:
                nLetterValue =@"C";break;
            case 13:
                nLetterValue =@"D";break;
            case 14:
                nLetterValue =@"E";break;
            case 15:
                nLetterValue =@"F";break;
            default:nLetterValue=[[NSString alloc]initWithFormat:@"%lli",ttmpig];
                
        }
        str = [nLetterValue stringByAppendingString:str];
        if (tmpid == 0) {
            break;
        }
        
    }
    return str;
}

Byte getInt(char c){
    if(c>='0'&&c<='9'){
        return c-'0';
    }else if((c>='a'&&c<='f')){
        return 10+(c-'a');
    }else if((c>='A'&&c<='F')){
        return 10+(c-'A');
    }
    return c;
}

int  getIntStr(NSString *src,int len){
    if(len==2){
        Byte c1 = getInt([src characterAtIndex:(NSUInteger)0]);
        Byte c2 = getInt([src characterAtIndex:(NSUInteger)1]);
        return ((c1&0x0f)<<4)|(c2&0x0f);
    }else{
        
        Byte c1 = getInt([src characterAtIndex:(NSUInteger)0]);
        
        Byte c2 = getInt([src characterAtIndex:(NSUInteger)1]);
        Byte c3 = getInt([src characterAtIndex:(NSUInteger)2]);
        Byte c4 = getInt([src characterAtIndex:(NSUInteger)3]);
        return( ((c1&0x0f)<<12)
               |((c2&0x0f)<<8)
               |((c3&0x0f)<<4)
               |(c4&0x0f));
    }
    
}

@end
