//
//  BUGetToDoorRecyclingOrderListManager.h
//  intelligentgarbagecollection
//
//  Created by air on 2017/12/19.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import "BUBasePageDataManager.h"
@interface BUGetToDoorRecyclingOrder : BUBase
@property(nonatomic) NSInteger state;
@property(strong,nonatomic) NSString *finishTime;
@property(strong,nonatomic) NSString *orderTime;
@property(strong,nonatomic) NSString *presetTime;
@property(strong,nonatomic) NSString *addrId;
@property(strong,nonatomic) NSString *recyclingType;
@property(nonatomic) CGFloat weight;
@property(strong,nonatomic) NSString *stateName;
@property(strong,nonatomic) NSString *orderNo;
@property(strong,nonatomic) NSString *userId;
@property(strong,nonatomic) NSString *address;
@property(strong,nonatomic) NSString *orderId;
@property(strong,nonatomic) NSString *contacts;
@property(strong,nonatomic) NSString *remark;
@property(strong,nonatomic) NSString *telephone;
@property(strong,nonatomic) NSString *typeName;
-(NSDictionary*)getDic:(NSInteger)row;
@end
@interface BUGetToDoorRecyclingOrderListManager : BUBasePageDataManager
-(BOOL)getListNextPage:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo;
-(BOOL)getListNextPage:(id)observer callback:(SEL)callback;

-(BOOL)getList:(NSString*)userId  observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo;
-(BOOL)getList:(NSString*)userId  observer:(id)observer callback:(SEL)callback;
@end
