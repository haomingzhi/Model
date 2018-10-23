//
//  BUSecondhandManager.h
//  intelligentgarbagecollection
//
//  Created by air on 2017/12/7.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import "BULCManager.h"
#import "BUGetSecondhandGoodsListManager.h"

@interface BUSecondhandManager : BULCManager
@property(nonatomic,strong)BUGetSecondhandGoods *secGoods;
@property(nonatomic,readonly)BUGetSecondhandGoodsListManager *getSecondhandGoodsListManager;
-(BOOL)getSecondhandGoods:(NSString*) sid observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo;
-(BOOL)getSecondhandGoods:(NSString*) sid observer:(id)observer callback:(SEL)callback;
-(BOOL)saveSecondhandGoods:(NSString*) userId withContent:(NSString*) content withAddress:(NSString*) address withLongitude:(NSString*) longitude withGoodsid:(NSString*) goodsId withPrice:(NSString*) price withLatitude:(NSString*) latitude withImagelist:(NSArray*) imageList withName:(NSString*) name withCityname:(NSString*) cityName observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo;
-(BOOL)saveSecondhandGoods:(NSString*) userId withContent:(NSString*) content withAddress:(NSString*) address withLongitude:(NSString*) longitude withGoodsid:(NSString*) goodsId withPrice:(NSString*) price withLatitude:(NSString*) latitude withImagelist:(NSArray*) imageList withName:(NSString*) name withCityname:(NSString*) cityName observer:(id)observer callback:(SEL)callback;

-(BOOL)delSecondhandGoods:(NSString*) sid withUserid:(NSString*) userId observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo;
-(BOOL)delSecondhandGoods:(NSString*) sid withUserid:(NSString*) userId observer:(id)observer callback:(SEL)callback;
@end
