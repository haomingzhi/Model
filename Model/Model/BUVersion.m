//
//  BUVersion.m
//  MiniClient
//
//  Created by apple on 14-7-30.
//  Copyright (c) 2014年 SunnadaSoft. All rights reserved.
//

#import "BUVersion.h"
#import "BUSystem.h"

#ifndef BUVERSION_VERSION

#define BUVERSION_VERSION @"buversion_version"
#define BUVERSION_REMINDDATE @"buversion_reminddate"
#define BUVERSION_TITLE @"buversion_title"
#define BUVERSION_DESC @"buversion_desc"
#define BUVERSION_URL  @"buversion_url"


#endif

@implementation BUVersion
{
 BOOL isCheck;
}
-(id)init
{
    self = [super init];
    if (self != nil)
    {
        _isTip = NO;
        _isForce = NO;
        isCheck = NO;
    }
    
    return self;
}

static bool isManualCheck; //标记是否手动检查版本号
-(BOOL)updateCheck:(BOOL)isManual  observer:(id)observer callback:(SEL)callback;
{
    isManualCheck = isManual;
    
//    return [self sendRequest:[NSString stringWithFormat:@"%@%@",busiSystem.apiHost,BU_BUSINESS_VERSIONCHECK]
//                        head:nil
//                      method:@"POST"
//                       async:YES
//             inputInvocation:BSGetInvocationFromSel(self, @selector(updateCheckInput))
//            outputInvocation:BSGetInvocationFromSel(self, @selector(updateCheckOutput:ok:input:))
//                    observer:observer
//                      action:callback
//                   extraInfo:nil];
    return TRUE;
}
#pragma mark --io

-(NSData *) updateCheckInput
{
    return [[NSString stringWithFormat:@"platform=%@&version_code=%@&version_name=%@",@"ios",busiSystem.appVer,busiSystem.appVer] dataUsingEncoding:NSUTF8StringEncoding];
}

-(NSError *)updateCheckOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input
{
    UNPACKETOUTPUTHEAD(recvData,ok);
   
//    self.version_code = [jsonData objectForKey:@"version_code"];
//    self.version_name = [jsonData objectForKey:@"version_name"];
//    self.url = [jsonData objectForKey:@"download_url"];
 
    //如果新版本跟当前版本一样则不提示。
    if (![busiSystem.appVer isEqualToString:self.version_name])
    {
            //设置提醒标志。。
            //self.isForce = FALSE;
            //读取提醒策略。如果是版本跟上次提示的版本要高则必须提醒，
            NSString *tipVersion = [[NSUserDefaults standardUserDefaults] objectForKey:BUVERSION_VERSION];
            if (![tipVersion isEqualToString:self.version_name] )//忽略的版本与服务器版本不同
            {
                if ([self versionCompare:busiSystem.appVer] ==1) {
                    self.isTip = YES;
                }
            }
            else
            {
                //如果是版本一致。则如果今天大于指定的天数则。
                NSDate *tipDate = [[NSUserDefaults standardUserDefaults] objectForKey:BUVERSION_REMINDDATE];
                [[NSUserDefaults standardUserDefaults]  synchronize];
                self.isTip = isManualCheck || [[NSDate date] compare:tipDate] == NSOrderedDescending;
            }
    }
    
    
    return SuccessedError;
    
}

-(void)nextRemindDate:(NSDate*)date
{
    [[NSUserDefaults standardUserDefaults] setObject:date forKey:BUVERSION_REMINDDATE];
    [[NSUserDefaults standardUserDefaults]  synchronize];
    //读取如果不一致则重新写入
    NSString *tipVersion = [[NSUserDefaults standardUserDefaults] objectForKey:BUVERSION_VERSION];
    if (![self.version_name isEqualToString:tipVersion])
    {
        [[NSUserDefaults standardUserDefaults] setObject:self.version_name forKey:BUVERSION_VERSION];
        [[NSUserDefaults standardUserDefaults]  synchronize];
    }
    
}

//版本比较，与服务器版本比较
//版本格式:xx.xx.xx
//1--服务器版本大于本地版本
//0--服务器版本与本地版本相同
//-1--服务器版本小于本地版本
-(int)versionCompare:(NSString *)currentVertion
{
    NSArray * subCurrentVertions = [currentVertion componentsSeparatedByString:@"."];
    NSArray * subservicesVertions = [_version_name componentsSeparatedByString:@"."];
    NSInteger loopCount = subCurrentVertions.count > subservicesVertions.count ? subservicesVertions.count :subCurrentVertions.count;
    for (NSInteger i =0; i < loopCount; i++) {
        if ([[subservicesVertions objectAtIndex:i] intValue] > [[subCurrentVertions objectAtIndex:i]intValue]) {
            return 1;
        }
        if ([[subservicesVertions objectAtIndex:i]intValue]  < [[subCurrentVertions objectAtIndex:i]intValue]) {
            return -1;
        }
    }
    return subCurrentVertions.count == subservicesVertions.count  ? 0 : (subservicesVertions.count > subCurrentVertions.count ? 1 :-1);
}

@end
