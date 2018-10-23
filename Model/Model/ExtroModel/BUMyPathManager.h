//
//  BUMyPathManager.h
//  rentingshop
//
//  Created by air on 2018/3/30.
//  Copyright © 2018年 ORANLLC_IOS1. All rights reserved.
//

#import "BULCManager.h"
#import "BUGetUserMsgManager.h"
#import "BUGetMyCouponManager.h"
#import "BUGetOrderListManager.h"

@interface BUUserCertification : BUBase
@property(strong,nonatomic) NSString *creditMoney;
@property(nonatomic) NSInteger isCredit;
@property(strong,nonatomic) NSString *trueName;
@property(strong,nonatomic) NSString *idCard;
@property(strong,nonatomic) NSString *credit;
@property(strong,nonatomic) NSString *remMoney;
@end

@interface BUTimeList : BUBase
@property(nonatomic) NSInteger state;
@property(strong,nonatomic) NSString *time;
-(NSDictionary *)getDic:(NSInteger)index;
@end


@interface BUSaleInfo : BUBase
@property(nonatomic) NSInteger state;
@property(strong,nonatomic) NSString *orderId;
@property(strong,nonatomic) NSString *afterId;
@property(strong,nonatomic) NSString *content;
@property(strong,nonatomic) NSArray *timeList;
@property(strong,nonatomic) NSString *note;
@property(strong,nonatomic) NSString *createTime;
@property(strong,nonatomic) NSString *afterNO;
@property(nonatomic) CGFloat reletMoney;
@property(strong,nonatomic) NSString *buyoutMoney;
@property(strong,nonatomic) NSString *reletTime;
@property(strong,nonatomic) NSString *stateName;
-(NSDictionary *)getDic:(NSInteger)index;
-(NSDictionary *)getDic2:(NSInteger)index;
-(NSDictionary *)getDic3:(NSInteger)index;
@end

@interface BURefund : BUBase
@property(strong,nonatomic) NSString *orderId;
@property(strong,nonatomic) BUGetOrder *leasInfo;
@property(strong,nonatomic) NSString *depositMoney;
@end


@interface BUSaleType : BUBase
@property(strong,nonatomic) NSString *afterTypeId;
@property(strong,nonatomic) NSString *name;
@end
@interface BUSaleList : BUBase
@property(strong,nonatomic) NSString *saleTime;
@property(nonatomic) NSInteger state;
@property(strong,nonatomic) NSString *afterId;
@property(strong,nonatomic) BUGetOrder *orderInfo;
-(NSDictionary*)getDic;
-(NSDictionary *)getAfterSellDic;
@end
@interface BUReletList : BUBase
@property(nonatomic) CGFloat reletMoney;
//@property(nonatomic) CGFloat payMoney;
@property(strong,nonatomic) NSString *reletId;
@property(nonatomic) NSInteger state;
@property(strong,nonatomic) BUGetOrder *orderInfo;
@property(strong,nonatomic) NSString *time;
-(NSDictionary *)getDic;
-(NSDictionary *)getDicB;
-(NSDictionary *)getDicA;
@end

@interface BUBuyoutld : BUBase
@property(nonatomic) NSInteger buState;
//@property(nonatomic) CGFloat payMoney;
@property(nonatomic) CGFloat buyoutMoney;
@property(strong,nonatomic) NSString *time;
@property(strong,nonatomic) BUGetOrder *orderInfo;
@property(strong,nonatomic) NSString *buyoutId;
-(NSDictionary *)getDic;
-(NSDictionary *)getDicB;
-(NSDictionary *)getDicA;
@end


@interface BUSubList : BUBase
@property(strong,nonatomic) NSString *money;
@property(strong,nonatomic) NSString *createTime;
@property(strong,nonatomic) NSString *chaoMoney;
@property(nonatomic) NSInteger isPay;
@property(nonatomic) NSInteger isTime;
@property(nonatomic) NSInteger count;
-(NSDictionary *)getDic;
@end

@interface BUMainPath : BUBase
@property(strong,nonatomic) NSString *period;
@property(strong,nonatomic) NSString *leaseMoney;
@property(strong,nonatomic) NSArray *subList;
@property(strong,nonatomic) NSString *supMoney;
@property(strong,nonatomic) NSString *orderID;
@property(strong,nonatomic) NSString *expireTime;
@property(strong,nonatomic) NSString *money;
@property(strong,nonatomic)BUProInfo *proInfo;
@property(nonatomic) NSInteger leaseCount;
@end

@interface BUOrderMsg : BUBase
@property(strong,nonatomic) NSString *productId;
@property(nonatomic) NSInteger leaseType;
@property(strong,nonatomic) NSString *productName;
@property(strong,nonatomic) NSString *time;
@property(strong,nonatomic) NSString *productAttributes;
@property(strong,nonatomic) BUImageRes *img;
@property(strong,nonatomic) NSString *userName;
@property(strong,nonatomic) NSString *orderId;
@property(strong,nonatomic) NSString *leaseMoney;
@property(strong,nonatomic) BUImageRes *userImg;
@property(strong,nonatomic) NSArray *imgList;
@property(strong,nonatomic) NSString *msg;
@property(strong,nonatomic) NSArray *subStr;
-(NSDictionary*)getDic;
-(NSDictionary *)getDic:(NSInteger)row;
@end


@interface BUAreaList : BUBase
@property(strong,nonatomic) NSString *cityID;
@property(strong,nonatomic) NSString *areaName;
@property(strong,nonatomic) NSString *areaId;
@end
@interface BUCitylist : BUBase
@property(strong,nonatomic) NSString *cityID;
@property(strong,nonatomic) NSString *cityName;
@property(strong,nonatomic) NSString *provinceID;
@property(strong,nonatomic) NSArray *areaList;
@end

@interface BUGetProvinlist : BUBase
@property(strong,nonatomic) NSString *provinceID;
@property(strong,nonatomic) NSString *provinceName;
@property(strong,nonatomic) NSArray *citylist;
+(NSArray*)getFitSelectionArr:(NSArray *)arr;
@end

@interface BUGetColloc : BUBase
@property(nonatomic) NSInteger hotSort;
@property(strong,nonatomic) NSString *operTime;
@property(nonatomic) NSInteger state;
@property(strong,nonatomic) NSString *attributes;
@property(strong,nonatomic) NSString *subtitle;
@property(nonatomic) CGFloat costMoney;
@property(strong,nonatomic) NSString *productInnerTextId;
@property(nonatomic) CGFloat leaseMoney;
@property(nonatomic) NSInteger recommendSort;
@property(nonatomic) NSInteger warningCount;
@property(strong,nonatomic) NSString *no;
@property(nonatomic) NSInteger tradeCount;
@property(strong,nonatomic) NSString *leases;
@property(strong,nonatomic) NSString *name;
@property(nonatomic) NSInteger priceType;
@property(nonatomic) NSInteger status;
@property(nonatomic) NSInteger insuranceMoney;
@property(nonatomic) BOOL isHot;
@property(strong,nonatomic) NSString *twoProductTypeId;
@property(nonatomic) NSInteger leaseType;
@property(nonatomic) NSInteger fourteenDayPrice;
@property(strong,nonatomic) NSString *oneProductTypeId;
@property(nonatomic) NSInteger thirtyDayPrice;
@property(strong,nonatomic) NSString *adminId;
@property(strong,nonatomic) NSString *createTime;
@property(strong,nonatomic) BUImageRes *img;
@property(nonatomic) NSInteger trueTradeCount;
@property(nonatomic) NSInteger colorType;
@property(nonatomic) NSInteger sevenDayPrice;
@property(strong,nonatomic) NSString *productLeaseId;
@property(strong,nonatomic) NSString *productPromises;
@property(strong,nonatomic) NSString *productId;
@property(strong,nonatomic) NSString *note;
@property(strong,nonatomic)NSIndexPath *indexPath;
@property(nonatomic) BOOL isRecommend;
-(NSDictionary *)getDic;
@end

@interface BUServiceList : BUBase
@property(strong,nonatomic) NSString *helpId;
@property(strong,nonatomic) NSString *title;
@property(strong,nonatomic) BUImageRes *img;
@property(strong,nonatomic) NSString *content;
-(NSDictionary*)getDic;
@end


@interface BUMyPathManager : BULCManager
@property(strong,nonatomic)NSArray *getProvinlist;
@property(strong,nonatomic)NSArray *serviceList;
@property(strong,nonatomic)NSArray *getMyCouponArr;
@property(strong,nonatomic)NSArray *getCollocArr;
@property(strong,nonatomic)NSArray *orderMsgList;
@property(strong,nonatomic)BUMainPath *mainPath;
@property(strong,nonatomic)NSArray *buyoutldArr;
@property(strong,nonatomic)NSArray *reletList;
@property(strong,nonatomic)NSArray *saleList;
@property(strong,nonatomic)NSArray *saleTypeArr;
@property(strong,nonatomic)NSString *addSaleId;
@property(strong,nonatomic)BURefund *refund;
@property(strong,nonatomic)BUSaleInfo *saleInfo;
@property(strong,nonatomic)BUSaleInfo *buyoutInfo;
@property(strong,nonatomic)BUSaleInfo *releteInfo;
@property(strong,nonatomic)BUUserCertification *userCertification;
@property(nonatomic,strong) BUGetMyCouponManager *getMyCouponUnUseManager;
@property(nonatomic,strong) BUGetMyCouponManager *getMyCouponUsedManager;
@property(nonatomic,strong) BUGetMyCouponManager *getMyCouponPassedManager;
@property(nonatomic,strong) BUGetUserMsgManager *getUserMsgManager;
-(BOOL)getServiceList:(NSString*) msg withUserid:(NSString*) userId observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo;
-(BOOL)getServiceList:(NSString*) msg withUserid:(NSString*) userId observer:(id)observer callback:(SEL)callback;

-(BOOL)bringStock:(NSString*) userId observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo;
-(BOOL)bringStock:(NSString*) userId observer:(id)observer callback:(SEL)callback;

-(BOOL)addCoupon:(NSString*) userId withCouponid:(NSString*) couponId observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo;
-(BOOL)addCoupon:(NSString*) userId withCouponid:(NSString*) couponId observer:(id)observer callback:(SEL)callback;
-(BOOL)addandUpAddress:(NSString*) userId withCityid:(NSString*) cityId withUsername:(NSString*) userName withAddressid:(NSString*) addressId withProvinceid:(NSString*) provinceId withAreaid:(NSString*) areaId withAddress:(NSString*) address withFloor:(NSString*) floor withIsdefault:(NSString*) isDefault withTel:(NSString*) tel observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo;
-(BOOL)addandUpAddress:(NSString*) userId withCityid:(NSString*) cityId withUsername:(NSString*) userName withAddressid:(NSString*) addressId withProvinceid:(NSString*) provinceId withAreaid:(NSString*) areaId withAddress:(NSString*) address withFloor:(NSString*) floor withIsdefault:(NSString*) isDefault withTel:(NSString*) tel observer:(id)observer callback:(SEL)callback;

-(BOOL)getColloc:(NSString*) userId observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo;

-(BOOL)getColloc:(NSString*) userId observer:(id)observer callback:(SEL)callback;
-(BOOL)addandUpCon:(NSString*) userId withProductid:(NSString*) productId observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo;
-(BOOL)addandUpCon:(NSString*) userId withProductid:(NSString*) productId observer:(id)observer callback:(SEL)callback;
-(BOOL)getProvinlist:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo;
-(BOOL)getProvinlist:(id)observer callback:(SEL)callback;

-(BOOL)addOrderMsg:(NSString*) msg withOrderid:(NSString*) orderID withUserid:(NSString*) userId observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo;
-(BOOL)addOrderMsg:(NSString*) msg withOrderid:(NSString*) orderID withUserid:(NSString*) userId observer:(id)observer callback:(SEL)callback;
-(BOOL)saleType:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo;
-(BOOL)saleType:(id)observer callback:(SEL)callback;
-(BOOL)buyoutld:(NSString*) state withUserid:(NSString*) userId observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo;
-(BOOL)buyoutld:(NSString*) state withUserid:(NSString*) userId observer:(id)observer callback:(SEL)callback;

-(BOOL)orderMsgList:(NSString*) state withUserid:(NSString*) userId observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo;
-(BOOL)orderMsgList:(NSString*) state withUserid:(NSString*) userId observer:(id)observer callback:(SEL)callback;

-(BOOL)addBuyoutld:(NSString*) orderID withUserid:(NSString*) userId observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo;
-(BOOL)addBuyoutld:(NSString*) orderID withUserid:(NSString*) userId observer:(id)observer callback:(SEL)callback ;
-(BOOL)buyouInfo:(NSString*) userId withBuyoutid:(NSString*) buyoutId observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo;
-(BOOL)buyouInfo:(NSString*) userId withBuyoutid:(NSString*) buyoutId observer:(id)observer callback:(SEL)callback;
-(BOOL)reletList:(NSString*) state withUserid:(NSString*) userId observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo;
-(BOOL)reletList:(NSString*) state withUserid:(NSString*) userId observer:(id)observer callback:(SEL)callback;

-(BOOL)addRele:(NSString*) orderID withUserid:(NSString*) userId withDay:(NSString*) day observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo;
-(BOOL)addRele:(NSString*) orderID withUserid:(NSString*) userId withDay:(NSString*) day observer:(id)observer callback:(SEL)callback;
-(BOOL)reletInfo:(NSString*) reletId withUserid:(NSString*) userId observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo;
-(BOOL)reletInfo:(NSString*) reletId withUserid:(NSString*) userId observer:(id)observer callback:(SEL)callback ;
-(BOOL)saleList:(NSString*) state withUserid:(NSString*) userId observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo;
-(BOOL)saleList:(NSString*) state withUserid:(NSString*) userId observer:(id)observer callback:(SEL)callback;
-(BOOL)addSale:(NSString*) userId withUsername:(NSString*) userName withMsg:(NSString*) msg withOrderid:(NSString*) orderID withTel:(NSString*) tel withImgs:(NSArray *)imgs withAftertypeid:(NSString*) afterTypeId  observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo;
-(BOOL)addSale:(NSString*) userId withUsername:(NSString*) userName withMsg:(NSString*) msg withOrderid:(NSString*) orderID withTel:(NSString*) tel withImgs:(NSArray *)imgs withAftertypeid:(NSString*) afterTypeId observer:(id)observer callback:(SEL)callback;
-(BOOL)saleInfo:(NSString*) afterId withUserid:(NSString*) userId observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo;
-(BOOL)saleInfo:(NSString*) afterId withUserid:(NSString*) userId observer:(id)observer callback:(SEL)callback;
-(BOOL)addOrderMsg:(NSString*) msg withImg:(NSArray *)imgs withOrderid:(NSString*) orderID withUserid:(NSString*) userId observer:(id)observer callback:(SEL)callback;
-(BOOL)mainPath:(NSString*) orderID withUserid:(NSString*) userId observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo;
-(BOOL)mainPath:(NSString*) orderID withUserid:(NSString*) userId observer:(id)observer callback:(SEL)callback;
-(BOOL)rrfundPath:(NSString*) backLogisticsNO withUserid:(NSString*) userId withOrderid:(NSString*) orderID withBacklogisticscompany:(NSString*) backLogisticsCompany observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo;
-(BOOL)rrfundPath:(NSString*) backLogisticsNO withUserid:(NSString*) userId withOrderid:(NSString*) orderID withBacklogisticscompany:(NSString*) backLogisticsCompany observer:(id)observer callback:(SEL)callback;

-(BOOL)refund:(NSString*) orderID withUserid:(NSString*) userId observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo;

-(BOOL)refund:(NSString*) orderID withUserid:(NSString*) userId observer:(id)observer callback:(SEL)callback;

-(BOOL)deleAddress:(NSString*) userId withAddressid:(NSString*) addressId observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo;

-(BOOL)deleAddress:(NSString*) userId withAddressid:(NSString*) addressId observer:(id)observer callback:(SEL)callback;

-(BOOL)userCertification:(NSString*) userId observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo;
-(BOOL)userCertification:(NSString*) userId observer:(id)observer callback:(SEL)callback;
@end
