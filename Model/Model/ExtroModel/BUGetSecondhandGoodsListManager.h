//
//  BUGetSecondhandGoodsListManager.h
//  intelligentgarbagecollection
//
//  Created by air on 2017/12/7.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import "BUBasePageDataManager.h"
@interface BUGetSecondhandGoods : BUBase
@property(strong,nonatomic) NSString *userId;
@property(strong,nonatomic) NSString *content;
@property(strong,nonatomic) NSString *address;
@property(strong,nonatomic) NSString *longitude;
@property(strong,nonatomic) NSString *goodsId;
@property(strong,nonatomic) NSString *showTime;
@property(nonatomic) CGFloat price;
@property(strong,nonatomic) NSString *distance;
@property(strong,nonatomic) NSString *latitude;
@property(strong,nonatomic) NSArray *imageList;
@property(nonatomic) NSInteger integral;
@property(strong,nonatomic) NSString *name;
@property(strong,nonatomic) NSIndexPath *indexPath;
@property(strong,nonatomic) NSString *stateName;
@property(strong,nonatomic) NSString *orderId;
@property(nonatomic) NSInteger state;
@property(strong,nonatomic) NSString *ownerName;
@property(strong,nonatomic) NSString *ownerTelephone;
-(NSDictionary*)getDic:(NSInteger)row;
@end

@interface BUGetSecondhandGoodsListManager : BUBasePageDataManager
-(BOOL)getListNextPage:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo;
-(BOOL)getListNextPage:(id)observer callback:(SEL)callback;
-(BOOL)getList:(NSString*)userId withCityId:(NSString*)cityId withLon:(NSString*)lon withLat:(NSString*)lat observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo;
-(BOOL)getList:(NSString*)userId withCityId:(NSString*)cityId withLon:(NSString*)lon withLat:(NSString*)lat observer:(id)observer callback:(SEL)callback;
@end
