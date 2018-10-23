//
//  BUVersion.h
//  MiniClient
//
//  Created by apple on 14-7-30.
//  Copyright (c) 2014年 SunnadaSoft. All rights reserved.
//

/*
   版本管理类。用于版本的更新和设置提醒日期。
 */
@interface BUVersion : BUBase

@property(nonatomic) NSString *version_code;
@property(nonatomic) NSString *version_name;
@property(nonatomic) NSString *desc;
@property(nonatomic) BOOL isForce;
@property(nonatomic) NSString *url;

@property(nonatomic) BOOL isTip;   //是否需要提示升级信息

//版本比较，与服务器版本比较
//1--服务器版本大于本地版本
//0--服务器版本与本地版本相同
//-1--服务器版本小于本地版本
-(int)versionCompare:(NSString *)servicesVertion;

//每次启动时调用版本更新检查。然后通过isTip标志来表示是否需要出现提醒信息。
-(BOOL)updateCheck:(BOOL)isManual  observer:(id)observer callback:(SEL)callback;

//下次提醒的日期，指定提醒的日期，如果是distantFuture则表示本版本不提醒。
-(void)nextRemindDate:(NSDate*)date;


@end
