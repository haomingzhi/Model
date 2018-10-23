//
//  CheckVersion.m
//  cpvs
//
//  Created by 耶通 on 14-5-15.
//  Copyright (c) 2014年 com.nd. All rights reserved.
//

#import "Check.h"
#import <AddressBook/AddressBook.h>

@interface Check() <NSXMLParserDelegate> {
    NSString *curElement;
}

@end

@implementation Check

//+(BOOL)OnCheckNet:hostname
//{
//    BOOL isWiFi=YES;
//    Reachability *reach=[Reachability reachabilityWithHostname:hostname];
//  
//    switch ([reach currentReachabilityStatus]) {
//        case NotReachable:
//            isWiFi=NO;
//            break;
//        case ReachableViaWiFi:break;
//            case ReachableViaWWAN:
//            isWiFi=NO;
//            break;
//        default:
//            break;
//    }
//    NSLog(@"xxxwifino:xx");
//    return isWiFi;
//}

//+(BOOL)checkInhouseVersion:(NSMutableDictionary *)data
//{
//    BOOL isLastVersion=NO;
//    NSDictionary * infoc=[[NSBundle mainBundle] infoDictionary];
//    NSString *currentVersion=[infoc objectForKey:@"CFBundleVersion"];
//// NSString *urlStr=@"http://cpvs.doone.com.cn/lookup.jsp";
////    NSString *urlStr = [NSString stringWithFormat:@"%@versions.xml", SERVER_URL];
////    NSURL *url = [NSURL URLWithString:urlStr];
////    NSXMLParser *xmlParser = [[NSXMLParser alloc] initWithContentsOfURL:url];
////    xmlParser.delegate = self;
////    [xmlParser parse];
////    NSURL *url = [NSURL URLWithString:@"http://m.weather.com.cn/data/101010100.html"];
//    //定义一个NSError对象，用于捕获错误信息
////    NSError *error;
////    NSString *jsonString = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:&error];
////    NSLog(@"jsonString--->%@",jsonString);
////    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url
////                                                  cachePolicy:NSURLRequestUseProtocolCachePolicy
////                                              timeoutInterval:60.0f];
//////    NSError *error = [[NSError alloc] init];
////    NSURLResponse *response = [[NSURLResponse alloc] init];
////    
////    NSData *responeData = [NSURLConnection sendSynchronousRequest:request
////                                                returningResponse:&response
////                                                            error:&error];
////    
////    NSDictionary *jsonToDictionary = [NSJSONSerialization JSONObjectWithData:responeData
////                                                                     options:0
////                                                                       error:&error];
//////    NSString *str = [NSString stringWithContentsOfURL:url usedEncoding:NSUTF8StringEncoding error:nil];
////    NSData  *strData = [NSData dataWithContentsOfURL:url];//[str dataUsingEncoding:NSUTF8StringEncoding];
////   NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:strData options:NSJSONReadingAllowFragments error:nil];
//////    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfURL:url];
////    NSArray *infoarr=  [dic objectForKey:@"results"];
////    if ([infoarr count]) {
////        [data addObject:infoarr];
////        NSDictionary *releaseInfo=[infoarr objectAtIndex:0];
//        NSString *lastVersion = data [@"version"];
//        NSArray *curVersionArr = [currentVersion componentsSeparatedByString:@"."];
//        NSArray *lastVersionArr = [lastVersion componentsSeparatedByString:@"."];
//        BOOL result = NO;
//        for (int i = 0; i < curVersionArr.count; i++) {
//            NSInteger cur = [curVersionArr[i] integerValue];
//            NSInteger last = [lastVersionArr[i] integerValue];
//            if (cur<last) {
//                result = YES;
//                break;
//            }
//            else if(cur == last)
//            {
//                continue;
//            }
//            else
//            {
//                result = NO;
//                break;
//            }
//        }
//        if(result)
//        {
//            isLastVersion=YES;
//                   }else
//        {
//            
//        }
////    }
//    return isLastVersion;
//}

//+(BOOL)checkVersion:(NSMutableArray *)data
//{
//    BOOL isLastVersion=NO;
//    NSDictionary * infoc=[[NSBundle mainBundle] infoDictionary];
//    NSString *currentVersion=[infoc objectForKey:@"CFBundleVersion"];
////    NSString *url=@"http://itunes.apple.com/lookup?id=835387569";
//    NSString *url = HTTPS_URL;
//    
//    NSMutableURLRequest *request=[[NSMutableURLRequest alloc] init];
//    [request setURL:[NSURL URLWithString:url]];
//    [request setHTTPMethod:@"POST"];
//    NSHTTPURLResponse *urlresponse=nil;
//    NSError *error=nil;
//    NSData *recervedData=[NSURLConnection sendSynchronousRequest:request returningResponse:&urlresponse error:&error];
//    //  NSString *result=[[NSString alloc] initWithBytes:recervedData.bytes length:recervedData.length encoding:NSUTF8StringEncoding];
//    if (recervedData==nil) {
//        return isLastVersion;
//    }
//    NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:recervedData options:NSJSONReadingAllowFragments error:nil];
//    NSArray *infoarr=  [dic objectForKey:@"results"];
//    if ([infoarr count]) {
//        [data addObject:infoarr];
//        NSDictionary *releaseInfo=[infoarr objectAtIndex:0];
//        NSString *lastVersion=[releaseInfo objectForKey:@"version"];
//        NSArray *curVersionArr = [currentVersion componentsSeparatedByString:@"."];
//        NSArray *lastVersionArr = [lastVersion componentsSeparatedByString:@"."];
//        BOOL result = NO;
//        for (int i = 0; i < curVersionArr.count; i++) {
//            NSInteger cur = [curVersionArr[i] integerValue];
//            NSInteger last = [lastVersionArr[i] integerValue];
//            if (cur<last) {
//                result = YES;
//                break;
//            }
//            else if(cur == last)
//            {
//                continue;
//            }
//            else
//            {
//                result = NO;
//                break;
//            }
//        }
//        if(result)
//        {
//            isLastVersion=YES;
//            
//        }else
//        {
//            
//        }
//    }
//    return isLastVersion;
//
//}

//+(BOOL) OnCheckVersion:(NSMutableDictionary *)data
//{
//    NSDictionary * infodic=[[NSBundle mainBundle] infoDictionary];
//    NSString *bundleID = infodic[@"CFBundleIdentifier"];
//    if ([bundleID isEqualToString:@"com.doone.cpvs"]) {
//   return  [Check checkVersion:data];
//        }
//    else{
//        return [Check checkInhouseVersion:data];
//    }
//}

+(void) willPresentAlertView:(UIAlertView *)alertView
{
    for (UIView *view in  alertView.subviews) {
        if([view isKindOfClass:[UILabel class]])
        {
            UILabel *textlab=(UILabel *)view;
            textlab.textAlignment=NSTextAlignmentLeft;
            
        }
    }
}
+(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex==1)
    {
        NSDictionary * infodic=[[NSBundle mainBundle] infoDictionary];
        NSString *bundleID = infodic[@"CFBundleIdentifier"];
        NSURL *url;
        if ([bundleID isEqualToString:@"com.doone.cpvs"]) {
         url = [NSURL URLWithString:@"https://itunes.apple.com/us/app/cpvs/id835387569?l=zh&ls=1&mt=8"];
        }
        else
        {
          url = [NSURL URLWithString:@"itms-services://?action=download-manifest&url=https://cpvs.doone.com.cn:8443/cpvs.plist"];
        }
        [[UIApplication sharedApplication] openURL:url];
    }
    else
    {
        
    }
}
+(BOOL) isIphoneUserInterface
{
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone) {
        return YES;
    }
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"不支持通讯簿使用" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
    [alert show];
    return NO;
}
+ (BOOL)isInTelphoneBook:(NSString *) telStr
{
    ABAddressBookRef addressBook = nil;
    BOOL isInTelPhoneBook = NO;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 6.0)
    {
        addressBook = ABAddressBookCreateWithOptions(NULL, NULL);
        //等待同意后向下执行
        dispatch_semaphore_t sema = dispatch_semaphore_create(0);
        ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error)
                                                 {
                                                     dispatch_semaphore_signal(sema);
                                                 });
        
        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
        dispatch_release(sema);
    }
    //    else
    //    {
    //        addressBook = ABAddressBookCreate();
    //    }
    if (addressBook == NULL) {
        return NO;
    }
    CFArrayRef results = ABAddressBookCopyArrayOfAllPeople(addressBook);
    
    NSLog(@"%@" ,results);
    
    long peopleCount = CFArrayGetCount(results);
    
    for (int i=0; i<peopleCount; i++)
    {
        ABRecordRef record = CFArrayGetValueAtIndex(results, i);
        
        NSLog(@"%@" ,record);
        
        NSString *fn,*ln,*fullname;
        fn = ln = fullname = nil;
        
        CFTypeRef vtmp = NULL;
        
        vtmp = ABRecordCopyValue(record, kABPersonFirstNameProperty);
        if (vtmp)
        {
            fn = [NSString stringWithString:vtmp];
            
            CFRelease(vtmp);
            vtmp = NULL;
        }
        vtmp = ABRecordCopyValue(record, kABPersonLastNameProperty);
        if (vtmp)
        {
            ln = [NSString stringWithString:vtmp];
            
            CFRelease(vtmp);
            vtmp = NULL;
        }
        
        NSLog(@"%@ ,%@" ,fn ,ln);
        
        // 读取电话
        ABMultiValueRef phones = ABRecordCopyValue(record, kABPersonPhoneProperty);
        long phoneCount = ABMultiValueGetCount(phones);
        
        for (int j=0; j<phoneCount; j++)
        {
            // label
            CFStringRef lable = ABMultiValueCopyLabelAtIndex(phones, j);
            // phone number
            CFStringRef phonenumber = ABMultiValueCopyValueAtIndex(phones, j);
            //            [self.dd addObject:(NSString *)phonenumber];
            NSMutableString *str =[[NSMutableString alloc] initWithFormat:@"%@",(NSString *)phonenumber];
            NSRange r;
            r.length=str.length;
            r.location=0;
            [str replaceOccurrencesOfString:@"-" withString:@"" options:NSNumericSearch range:r];
            if ([telStr isEqualToString:str]) {
                isInTelPhoneBook = YES;
                break;
            }
            // localize label
            CFStringRef ll = ABAddressBookCopyLocalizedLabel(lable);
            
            NSLog(@"\t%@ ,%@,%@" ,(NSString *)lable ,(NSString *)ll,(NSString *)phonenumber);
            
            if (ll)
                CFRelease(ll);
            if (lable)
                CFRelease(lable);
            if (phonenumber)
                CFRelease(phonenumber);
        }
        
        if (phones)
            CFRelease(phones);
        
        record = NULL;
    }
    
    if (results)
        CFRelease(results);
    results = nil;
    
    if (addressBook)
        CFRelease(addressBook);
    addressBook = NULL;
    return isInTelPhoneBook;
}

@end
