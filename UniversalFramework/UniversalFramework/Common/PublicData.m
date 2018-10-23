//
//  PublicData.m
//  pinjiang.caddie
//
//  Created by Air on 15-1-22.
//  Copyright (c) 2015年 com.YiGuang. All rights reserved.
//

#import "PublicData.h"

@interface PublicData ()
{

    NSMutableDictionary *_dataDic;
}
@end

@implementation PublicData

+ (instancetype )manager
{
    static dispatch_once_t  onceToken;
    static PublicData * sSharedInstance;
    
    dispatch_once(&onceToken, ^{
        sSharedInstance = [[PublicData alloc] init];
        sSharedInstance->_dataDic = [NSMutableDictionary dictionary];
    });
    return sSharedInstance;
}

+(void)setAccount:(NSString*)str
{
// _dataDic[@"account"] = str;
     [[NSUserDefaults standardUserDefaults] setObject:str forKey:@"account"];
     [[NSUserDefaults standardUserDefaults] synchronize];
}

+(NSString *)getAccount
{
//   return  _dataDic[@"account"];
     return  [[NSUserDefaults standardUserDefaults] objectForKey:@"account"];
}

+(NSString *)getUserName
{
  return  [[NSUserDefaults standardUserDefaults] objectForKey:@"userName"];
}

+(NSString *)getUserPwd
{
  return  [[NSUserDefaults standardUserDefaults] objectForKey:@"pwd"];
}

+(void)setUserName:(NSString *)userName
{
    [[NSUserDefaults standardUserDefaults] setObject:userName forKey:@"userName"];
     [[NSUserDefaults standardUserDefaults] synchronize];
}

+(void)setUserPwd:(NSString *)pwd
{
    [[NSUserDefaults standardUserDefaults] setObject:pwd forKey:@"pwd"];
     [[NSUserDefaults standardUserDefaults] synchronize];
}

-(void)setCookie:(NSString *)ck
{
    _dataDic[@"cookie"] = ck;
}

-(NSString *)getCookie
{
    return _dataDic[@"cookie"];
}

-(void)setIsLogined:(BOOL)value
{
//    [[NSUserDefaults standardUserDefaults] setObject:value forKey:@"login"];
    _dataDic[@"login"] = @(value);
}

-(BOOL) getIsLogined
{
    return [_dataDic[@"login"] boolValue];
}

+(NSString *)versionCode
{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];

    return [infoDictionary objectForKey:@"CFBundleVersion"];

}

+(NSString *)getUserID
{
     return [[NSUserDefaults standardUserDefaults] objectForKey:@"userID"];
}

+(void)setUserID:(NSString *)ID
{
    [[NSUserDefaults standardUserDefaults] setObject:ID forKey:@"userID"];
     [[NSUserDefaults standardUserDefaults] synchronize];
}

-(void)removeObj:(NSString *)key
{
    [_dataDic removeObjectForKey:key];
}


@end
