//
//  BUGetSysMessageListManager.h
//  intelligentgarbagecollection
//
//  Created by air on 2017/12/13.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import "BUBasePageDataManager.h"
@interface BUGetSysMessage : BUBase
@property(nonatomic) NSInteger cityId;
@property(strong,nonatomic) NSString *content;
@property(nonatomic) NSInteger status;
@property(strong,nonatomic) NSString *title;
@property(strong,nonatomic) NSString *msgId;
@property(nonatomic) NSInteger type;
@property(strong,nonatomic) NSString *createTime;
@property(strong,nonatomic) NSString *url;
-(NSDictionary*)getDic;
@end

@interface BUGetSysMessageListManager : BUBasePageDataManager
@property(strong,nonatomic)BUGetSysMessage *sysMessage;
-(BOOL)getSysMessage:(NSString*) msgId observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo;
-(BOOL)getSysMessage:(NSString*) msgId observer:(id)observer callback:(SEL)callback;
-(BOOL)getList:(NSString*)cityId  observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo;
-(BOOL)getList:(NSString*)cityId  observer:(id)observer callback:(SEL)callback;
-(BOOL)getListNextPage:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo;
-(BOOL)getListNextPage:(id)observer callback:(SEL)callback;
@end
