//
//  BUGetCollectListManager.h
//  intelligentgarbagecollection
//
//  Created by air on 2017/12/7.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import "BUBasePageDataManager.h"
//@interface BUGetCollect : BUBase
//@property(nonatomic) NSInteger productType;
//@property(strong,nonatomic) NSString *goodsId;
//@property(strong,nonatomic) NSString *recordId;
//@property(nonatomic) CGFloat salePrice;
//@property(strong,nonatomic) BUImageRes *imagePath;
//@property(strong,nonatomic) NSString *goodsSpec;
//@property(nonatomic) NSInteger buyCount;
//@property(strong,nonatomic) NSString *name;
//-(NSDictionary *)getDic;
//@end

@interface BUGetCollectListManager : BUBasePageDataManager
-(BOOL)getListNextPage:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo;
-(BOOL)getListNextPage:(id)observer callback:(SEL)callback;

-(BOOL)getList:(NSString*)userId observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo;
-(BOOL)getList:(NSString*)userId observer:(id)observer callback:(SEL)callback;


-(BOOL)delGoodsCollect:(NSString*) productType withGoodsid:(NSString*) goodsId withUserid:(NSString*) userId observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo;
-(BOOL)delGoodsCollect:(NSString*) productType withGoodsid:(NSString*) goodsId withUserid:(NSString*) userId observer:(id)observer callback:(SEL)callback;
@end
