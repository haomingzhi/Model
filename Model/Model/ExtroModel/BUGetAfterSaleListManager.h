//
//  BUGetAfterSaleListManager.h
//  intelligentgarbagecollection
//
//  Created by air on 2017/12/13.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import "BUBasePageDataManager.h"
@interface BUCheckList : BUBase
@property(strong,nonatomic) NSString *adminName;
@property(strong,nonatomic) NSString *createTime;
@property(nonatomic) NSInteger state;
@property(strong,nonatomic) NSString *waterId;
@property(strong,nonatomic) NSString *stateName;
@property(strong,nonatomic) NSString *remark;
-(NSDictionary *)getDic:(NSInteger)index;
@end


@interface BUAfterSaleDetail : BUBase
@property(strong,nonatomic) NSString *result;
@property(strong,nonatomic) NSString *content;
@property(strong,nonatomic) NSString *orderId;
@property(strong,nonatomic) NSArray *checkList;
@property(nonatomic) NSInteger state;
@property(strong,nonatomic) NSString *recordId;
@property(strong,nonatomic) NSString *stateName;
@property(strong,nonatomic) NSString *serviceNo;
@property(strong,nonatomic) NSString *createTime;
@property(strong,nonatomic) NSArray *goodsList;
@property(strong,nonatomic) NSString *finishTime;
-(NSDictionary *)getDic:(NSInteger)index;
@end


@interface BUGetAfterSaleListManager : BUBasePageDataManager
@property(strong,nonatomic)BUAfterSaleDetail *afterSaleDetail;
-(BOOL)getAfterSaleDetail:(NSString*) sid observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo;
-(BOOL)getAfterSaleDetail:(NSString*) sid observer:(id)observer callback:(SEL)callback;
-(BOOL)getListNextPage:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo;
-(BOOL)getListNextPage:(id)observer callback:(SEL)callback;
-(BOOL)getList:(NSString*)userId  observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo;
-(BOOL)getList:(NSString*)userId  observer:(id)observer callback:(SEL)callback;

-(BOOL)orderBack:(NSString*) userId withOrderid:(NSString*) orderId withContent:(NSString*) content withGoodsid:(NSString*) goodsId withContacts:(NSString*) contacts withImagelist:(NSArray*) imageList withTelephone:(NSString*) telephone withReasonid:(NSString*) reasonId observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo;
-(BOOL)orderBack:(NSString*) userId withOrderid:(NSString*) orderId withContent:(NSString*) content withGoodsid:(NSString*) goodsId withContacts:(NSString*) contacts withImagelist:(NSArray*) imageList withTelephone:(NSString*) telephone withReasonid:(NSString*) reasonId observer:(id)observer callback:(SEL)callback;
@end
