//
//  BUShopManager.h
//  intelligentgarbagecollection
//
//  Created by Steve on 2017/12/7.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import "BULCManager.h"
#import "BUImageRes.h"



@interface BUServiceInfo : BUBase
@property(strong,nonatomic) NSString *typeId;
@property(nonatomic) NSInteger saleCount;
@property(nonatomic) CGFloat price;
@property(strong,nonatomic) NSArray *promiseList;
@property(strong,nonatomic) NSString *serviceId;
@property(strong,nonatomic) NSArray *imageList;
@property(strong,nonatomic) NSString *intro;
@property(strong,nonatomic) NSString *typeName;
@property(strong,nonatomic) BUImageRes *imagePath;
@property(strong,nonatomic) NSString *name;
@property(strong,nonatomic) NSString *serviceSpec;
@property(strong,nonatomic) NSArray *commentList;
-(NSDictionary *)getDic:(NSInteger)index;
@end


@interface BUGoodsDetail : BUBase
@property(strong,nonatomic) NSString *name;
@property(strong,nonatomic) NSString *typeName;
@property(strong,nonatomic) BUImageRes *imagePath;
@property(nonatomic) NSInteger saleCount;
@property(strong,nonatomic) NSString *typeId;
@property(strong,nonatomic) NSArray *imageList;
@property(nonatomic) NSInteger stock;
@property(strong,nonatomic) NSArray *goodsList;
@property(strong,nonatomic) NSString *shopSN;
@property(nonatomic) CGFloat price;
@property(nonatomic) CGFloat salePrice;
@property(strong,nonatomic) NSString *shopId;
@property(strong,nonatomic) NSArray *commentList;
@property(strong,nonatomic) NSString *goodsNo;
@property(strong,nonatomic) NSString *goodsSpec;
@property(strong,nonatomic) NSString *shopName;
@property(strong,nonatomic) NSString *goodsId;
@property(strong,nonatomic) NSString *content;
//@property(strong,nonatomic) NSString *goodsSpec;
-(NSDictionary *)getDic:(NSInteger)index;
@end


@interface BUGoodsInfo : BUBase
@property(nonatomic,strong) BUImageRes *img;
@property(nonatomic) CGFloat leaseMoney;
@property(nonatomic) CGFloat totalMoney;
@property(nonatomic) CGFloat costMoney;
@property(strong,nonatomic) NSArray *productParamterList;
@property(strong,nonatomic) NSArray *pictureList;
@property(strong,nonatomic) NSArray *productAttributeList;
@property(strong,nonatomic) NSString *productId;
@property(strong,nonatomic) NSString *name;
@property(strong,nonatomic) NSArray *productPromiseList;
@property(nonatomic) NSInteger colorType;//0 全新 1 二手 ,
@property(nonatomic) CGFloat insuranceMoney;
@property(nonatomic) BOOL isCredit;
@property(nonatomic) NSInteger tradeCount;
@property(strong,nonatomic) NSString *note;
@property(nonatomic) CGFloat credit;
@property(nonatomic) BOOL isCollection;
@property(nonatomic) NSInteger leaseType;// 0 长租 1 短租 ,
@property(nonatomic) NSInteger priceType;// 0 选项 1 自定义 ,
@property(strong,nonatomic) NSString *attributes;
@property(strong,nonatomic) NSArray *leaseList;
-(NSDictionary *)getDic:(NSInteger)index;
@end


@interface BUProductPromise :BUBase
@property(strong,nonatomic) NSString *name;
@property(strong,nonatomic) NSString *note;
-(NSDictionary *)getDic;
@end

@interface BUProductParamter :BUBase
@property(strong,nonatomic) NSString *ID;
@property(strong,nonatomic) NSString *title;
@property(strong,nonatomic) NSString *value;
-(NSDictionary *)getDic;
@end


@interface BUProductAttribute :BUBase
@property(strong,nonatomic) NSString *ID;
@property(strong,nonatomic) NSString *title;
@property(strong,nonatomic) NSArray *value;
@end


@interface BUProductLease :BUBase
@property(nonatomic) BOOL isDefault;
@property(assign,nonatomic) NSInteger value;
@property(nonatomic) BOOL isEnabled;
@end


@interface BUProductAttributeValue :BUBase
@property(nonatomic) BOOL isDefault;
@property(strong,nonatomic) NSString *value;
@property(nonatomic) BOOL isEnabled;
@end


@interface BUProductPrice : BUBase
@property(strong,nonatomic) NSArray *leaseList;
@property(nonatomic) CGFloat leaseMoney;
@property(strong,nonatomic) NSString *productId;
@property(nonatomic) CGFloat totalMoney;
@property(nonatomic) NSInteger stock;
@property(nonatomic) CGFloat insuranceMoney;
@property(nonatomic) CGFloat costMoney;
@property(strong,nonatomic) NSArray *productAttributeList;
@property(strong,nonatomic) NSString *productItemId;
@property(strong,nonatomic) NSString *productItemPriceId;
@end


@interface BUGetPayMoney : BUBase
@property(nonatomic) CGFloat depositMoney;
@property(nonatomic) CGFloat payMoney;
@end



@interface BUSubmitOrder : BUBase
@property(strong,nonatomic) NSString *orderId;
@property(nonatomic) CGFloat payMoney;
@property(strong,nonatomic) NSString *endPayTime;
@end

@interface BUShopInfo : BUBase
@property(nonatomic) NSInteger state;
@property(strong,nonatomic) NSString *linkman;
@property(nonatomic) NSInteger goodsCount;
@property(strong,nonatomic) BUImageRes *logoUrl;
@property(nonatomic) NSInteger shopSN;
@property(strong,nonatomic) NSString *address;
@property(strong,nonatomic) NSString *endTime;
@property(strong,nonatomic) NSString *shopId;
@property(nonatomic) NSInteger saleCount;
@property(strong,nonatomic) NSString *telephone;
@property(strong,nonatomic) NSString *startTime;
@property(strong,nonatomic) NSString *name;
-(NSDictionary *)getDic:(NSInteger)index;
@end


@interface BUShopType : BUBase
@property(strong,nonatomic) NSString *typeId;
@property(strong,nonatomic) NSString *typeName;
@property(strong,nonatomic) NSString *shopId;
@property(strong,nonatomic) BUImageRes *imagePath;
-(NSDictionary *)getDic:(NSInteger)index;
@end


@interface BUOrderCoupon :BUBase
@property(strong,nonatomic) NSString *effectime;
@property(nonatomic) NSInteger totalCount;
@property(nonatomic) NSInteger status;
@property(strong,nonatomic) NSString *title;
@property(strong,nonatomic) NSString *code;
@property(strong,nonatomic) NSString *couponId;
@property(nonatomic) NSInteger limitget;
@property(nonatomic) NSInteger exceedType;
@property(strong,nonatomic) NSString *exceedTime;
@property(strong,nonatomic) NSString *operTime;
@property(nonatomic) NSInteger day;
@property(nonatomic) NSInteger isReceive;
@property(nonatomic) NSInteger type;
@property(nonatomic) NSInteger exceedDay;
@property(strong,nonatomic) NSString *scopeName;
@property(nonatomic) NSInteger getThreshold;
@property(nonatomic) NSInteger scope;
@property(strong,nonatomic) NSString *adminId;
@property(strong,nonatomic) NSString *starTime;
@property(nonatomic) CGFloat price;
@property(strong,nonatomic) NSString *remark;
@property(nonatomic) CGFloat threshold;
@property(strong,nonatomic) NSString *createTime;

@property(strong,nonatomic) NSString *couLogId;
-(NSDictionary*)getDic;
@end


@interface BUShopManager : BULCManager
@property (nonatomic,strong) BUShopInfo *shopInfo;
-(BOOL)getShopInfo:(NSString *)ID  observer:(id)observer callback:(SEL)callback;
-(BOOL)getShopInfo:(NSString *)ID  observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo;

@property (nonatomic,strong) NSArray *shopTypeList;
-(BOOL)getShopTypeList:(id)observer callback:(SEL)callback;
-(BOOL)getShopTypeList:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo;



@property (nonatomic,strong) BUServiceInfo *serviceInfo;
-(BOOL)getServiceInfo:(NSString *)ID  observer:(id)observer callback:(SEL)callback;
-(BOOL)getServiceInfo:(NSString *)ID  observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo;

@property (nonatomic,strong) NSArray *serviceTypeList;
-(BOOL)getServiceTypeList:(id)observer callback:(SEL)callback;
-(BOOL)getServiceTypeList:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo;

@property (nonatomic,strong) NSArray *goodsTypeList;
-(BOOL)getGoodsTypeList:(NSString *)ID  observer:(id)observer callback:(SEL)callback;
-(BOOL)getGoodsTypeList:(NSString *)ID  observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo;

//new
//商品详情
@property (nonatomic,strong) BUGoodsInfo *goodsInfo;
-(BOOL)getGoodsInfo:(NSString *)ID  observer:(id)observer callback:(SEL)callback;
-(BOOL)getGoodsInfo:(NSString *)ID  observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo;

//租赁规则
@property (nonatomic,strong) NSString *leaseRule;
-(BOOL)getLeaseRule:(id)observer callback:(SEL)callback;
-(BOOL)getLeaseRule:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo;

//添加收藏
-(BOOL)addGoodsCollect:(NSString *)productId userId:(NSString *)userId   observer:(id)observer callback:(SEL)callback;
-(BOOL)addGoodsCollect:(NSString *)productId userId:(NSString *)userId    observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo;

//根据商品属性获取价格
@property (nonatomic,strong) BUProductPrice *productPrice;
-(BOOL)getProductPrice:(NSString *)productId lease:(NSString *)lease productAttributeList:(NSMutableArray *)arr   observer:(id)observer callback:(SEL)callback;
-(BOOL)getProductPrice:(NSString *)productId lease:(NSString *)lease productAttributeList:(NSMutableArray *)arr   observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo;

//获取首期付款金额
@property (nonatomic,strong) BUGetPayMoney *getPayMoney;
-(BOOL)getPayMoney:(NSString *)productId couponId:(NSString *)couponId  lease:(NSString *)lease  costMoney:(NSString *)costMoney  price:(NSString *)price   observer:(id)observer callback:(SEL)callback;
-(BOOL)getPayMoney:(NSString *)productId couponId:(NSString *)couponId  lease:(NSString *)lease  costMoney:(NSString *)costMoney  price:(NSString *)price   observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo;

//下单
@property (nonatomic,strong) BUSubmitOrder *submitOrder;
-(BOOL)submitOrder:(NSString *)productId receiveAddressId:(NSString *)receiveAddressId  productItemId:(NSString *)productItemId  productItemPriceId:(NSString *)productItemPriceId  couponLogId:(NSString *)couponLogId  note:(NSString *)note  defineStartTime:(NSString *)defineStartTime  defineEndTime:(NSString *)defineEndTime   observer:(id)observer callback:(SEL)callback;
-(BOOL)submitOrder:(NSString *)productId receiveAddressId:(NSString *)receiveAddressId  productItemId:(NSString *)productItemId  productItemPriceId:(NSString *)productItemPriceId  couponLogId:(NSString *)couponLogId  note:(NSString *)note  defineStartTime:(NSString *)defineStartTime  defineEndTime:(NSString *)defineEndTime   observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo;

//获取优惠券列表 下单
@property (nonatomic,strong) NSArray  *couponList;
-(BOOL)OrderCoupon:(NSString *)productId observer:(id)observer callback:(SEL)callback;
-(BOOL)OrderCoupon:(NSString *)productId observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo;
@end
