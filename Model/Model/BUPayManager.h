//
//  BUPayManager.h
//  taihe
//
//  Created by air on 2016/12/15.
//  Copyright © 2016年 ORANLLC_IOS1. All rights reserved.
//

#import "BULCManager.h"
#import "BUGetOrderListManager.h"

@interface BUOrderPay : BUBase
@property(strong,nonatomic) NSString *pickupCode;
@property(strong,nonatomic) NSString *msg;
@property(strong,nonatomic) NSString *orderId;
@property(nonatomic) NSInteger orderType;
@property(nonatomic) NSInteger onlinePrice;
@property(nonatomic) NSInteger integral;
@property(strong,nonatomic) NSString *expressName;
@property(strong,nonatomic) NSString *visitTime;
@property(nonatomic) NSInteger state;
@property(strong,nonatomic) NSString *expressNo;
@property(strong,nonatomic) NSString *address;
@property(nonatomic) NSInteger num;
@property(strong,nonatomic) NSString *sinceContacts;
@property(nonatomic) NSInteger bespokeType;
@property(strong,nonatomic) NSString *tel;
@property(strong,nonatomic) NSString *payTypeName;
@property(strong,nonatomic) NSString *actId;
@property(strong,nonatomic) NSString *orderTypeName;
@property(strong,nonatomic) NSString *sinceTelephone;
@property(strong,nonatomic) NSString *shareUrl;
@property(strong,nonatomic) NSString *contacts;
@property(strong,nonatomic) NSString *name;
@property(strong,nonatomic) NSString *goodsId;
@property(nonatomic) NSInteger isComment;
@property(nonatomic) NSInteger price;
@property(strong,nonatomic) NSString *createDate;
@property(strong,nonatomic) NSString *imagePath;
@property(nonatomic) NSInteger cardMoney;
@property(strong,nonatomic) NSString *stateName;
@property(nonatomic) NSInteger buyType;
@property(nonatomic) NSInteger expressType;
@property(strong,nonatomic) NSArray *cardList;
@property(strong,nonatomic) NSString *priceUnitName;
@property(strong,nonatomic) NSString *expressTypeName;
@property(strong,nonatomic) NSString *userId;
@property(nonatomic) NSInteger totalPrice;
@property(strong,nonatomic) NSString *payBody;
@end


@interface BUPayManager : BULCManager
@property(strong,nonatomic) NSString *flag;
@property(nonatomic,strong) BUGetOrder *order;
@property (nonatomic,strong) NSString *payBody;
@property (nonatomic,strong) NSString *zmUrl;
-(BOOL)orderPay:(NSString *)payType withOrderid:(NSString *)orderId sourceType:(NSString *)sourceType orderType:(NSString *)orderType typeId:(NSString *)typeId observer:(id)observer callback:(SEL)callback;
-(BOOL)orderPay:(NSString*) payType withOrderid:(NSString*) orderId sourceType:(NSString*) sourceType orderType:(NSString *)orderType typeId:(NSString *)typeId observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo;

-(BOOL)upOrder:(NSString *)orderId observer:(id)observer callback:(SEL)callback;
-(BOOL)upOrder:(NSString*)orderId observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo;

-(BOOL)getPublicAppAuthorize:(NSString*) userId withUserTrueName:(NSString*)UserTrueName withIDCard:(NSString *)IDCard observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo;
-(BOOL)getPublicAppAuthorize:(NSString*) userId withUserTrueName:(NSString*)UserTrueName withIDCard:(NSString *)IDCard observer:(id)observer callback:(SEL)callback;

-(BOOL)getZhimaCreditScore:(NSString*) userId observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo;
-(BOOL)getZhimaCreditScore:(NSString*) userId observer:(id)observer callback:(SEL)callback;
@end
