//
//  BUGetCourierOrderListManager.h
//  intelligentgarbagecollection
//
//  Created by air on 2017/12/14.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import "BUBasePageDataManager.h"

@interface BUGetCourierOrderListManager : BUBasePageDataManager

-(BOOL)getListNextPage:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo;

-(BOOL)getListNextPage:(id)observer callback:(SEL)callback;
-(BOOL)getList:(NSString*)courierId withType:(NSString *)type withStationId:(NSString*)stationId observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo;
-(BOOL)getList:(NSString*)courierId withType:(NSString *)type withStationId:(NSString*)stationId observer:(id)observer callback:(SEL)callback;
@end
