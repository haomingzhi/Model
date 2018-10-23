//
//  PublicData.h
//  pinjiang.caddie
//
//  Created by Air on 15-1-22.
//  Copyright (c) 2015年 com.YiGuang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PublicData : NSObject
+ (instancetype)manager;
+(NSString *)getUserName;
+(NSString *)getUserPwd;
+(void)setUserName:(NSString *)userName;
+(NSString *)getUserID;
+(void)setUserID:(NSString *)ID;
+(void)setUserPwd:(NSString *)pwd;
-(void)setIsLogined:(BOOL)value;
-(BOOL) getIsLogined;
+(NSString *)versionCode;
-(void)setCookie:(NSString *)ck;
-(NSString *)getCookie;
-(void)removeObj:(NSString *)key;
+(void)setAccount:(NSString*)str;
+(NSString *)getAccount;
@end
