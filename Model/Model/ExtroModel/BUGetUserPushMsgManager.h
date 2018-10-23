//
//  BUGetUserPushMsgManager.h
//  compassionpark
//
//  Created by air on 2017/4/10.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import "BUBasePageDataManager.h"

@interface BUGetUserPushMsg : BUBase
@property(nonatomic) NSInteger msgType;
@property(strong,nonatomic) NSString *content;
@property(nonatomic) NSInteger isView;
@property(strong,nonatomic) NSString *viewTime;
@property(strong,nonatomic) NSString *title;
@property(strong,nonatomic) NSString *entityId;
@property(strong,nonatomic) NSString *pushTime;
@property(strong,nonatomic) NSString *spuId;
@property(strong,nonatomic) NSString *msgTypeName;
-(NSDictionary *)getDic;
@end


@interface BUGetUserPushMsgManager : BUBasePageDataManager
@property(strong,nonatomic)NSArray *getUserPushMsgArr;
-(BOOL)getUserPushMsg:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo;
-(BOOL)getUserPushMsg:(id)observer callback:(SEL)callback;
-(BOOL)getUserPushMsgNextPage:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo;
-(BOOL)getUserPushMsgNextPage:(id)observer callback:(SEL)callback;
-(BOOL)viewPushMsg:(NSString*) aid observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo;
-(BOOL)viewPushMsg:(NSString*) aid observer:(id)observer callback:(SEL)callback;
-(BOOL)delPushMsg:(NSString*) aid observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo;
-(BOOL)delPushMsg:(NSString*) aid observer:(id)observer callback:(SEL)callback;
@end
