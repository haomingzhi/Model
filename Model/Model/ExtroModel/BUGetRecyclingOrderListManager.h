//
//  BUGetRecyclingOrderListManager.h
//  intelligentgarbagecollection
//
//  Created by air on 2017/12/11.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import "BUBasePageDataManager.h"
@interface BUGetRecyclingOrder : BUBase
@property(nonatomic) NSInteger state;
@property(strong,nonatomic) NSString *stationName;
@property(nonatomic) NSInteger weight;
@property(strong,nonatomic) NSString *stateName;
@property(strong,nonatomic) NSString *orderNo;
@property(strong,nonatomic) NSString *userId;
@property(strong,nonatomic) NSString *stationAddress;
@property(strong,nonatomic) NSString *createTime;
@property(strong,nonatomic) NSString *recordId;
@property(strong,nonatomic) NSString *dustbinType;
@property(strong,nonatomic) NSString *deviceNo;
@property(nonatomic) NSInteger balance;
@property(nonatomic) NSInteger integral;
@property(strong,nonatomic) BUImageRes *stationImage;
-(NSDictionary*)getDic:(NSInteger)row;
@end

@interface BUGetRecyclingOrderListManager : BUBasePageDataManager
-(BOOL)getList:(NSString*)userId  observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo;
-(BOOL)getList:(NSString*)userId  observer:(id)observer callback:(SEL)callback;
-(BOOL)getListNextPage:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo;
-(BOOL)getListNextPage:(id)observer callback:(SEL)callback;
@end
