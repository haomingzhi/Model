//
//  BUGetGoodsListManager.h
//  intelligentgarbagecollection
//
//  Created by Steve on 2017/12/7.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import "BUBasePageDataManager.h"

@interface BUGetSearchListManager : BUBasePageDataManager
-(BOOL)getListNextPage:(id)observer callback:(SEL)callback;
-(BOOL)getListNextPage:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo;
-(BOOL)getList:(NSString*)search  observer:(id)observer callback:(SEL)callback;
-(BOOL)getList:(NSString*)search  observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo;
@end
