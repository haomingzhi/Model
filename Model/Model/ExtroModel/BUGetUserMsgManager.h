//
//  BUGetUserMsgManager.h
//  rentingshop
//
//  Created by air on 2018/3/30.
//  Copyright © 2018年 ORANLLC_IOS1. All rights reserved.
//

#import "BUBasePageDataManager.h"
@interface BUGetUserMsg : BUBase
@property(nonatomic) NSInteger isRead;
@property(strong,nonatomic) NSString *informationId;
@property(strong,nonatomic) NSString *title;
@property(strong,nonatomic) NSString *content;
@property(strong,nonatomic) NSString *createTime;
-(NSDictionary*)getDic:(NSInteger)row;
@end
@interface BUGetUserMsgManager : BUBasePageDataManager
@property(strong,nonatomic)NSArray *getUserMsgArr;
-(BOOL)getUserMsg:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo;
-(BOOL)getUserMsg:(id)observer callback:(SEL)callback;
-(BOOL)getUserMsgNextPage:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo;
-(BOOL)getUserMsgNextPage:(id)observer callback:(SEL)callback;
@end
