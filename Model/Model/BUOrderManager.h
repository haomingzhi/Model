//
//  BUOrderManager.h
//  supermarket
//
//  Created by Steve on 2017/11/10.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import "BULCManager.h"
#import "BUImageRes.h"
@interface BUProInfo : BUBase
@property(strong,nonatomic) NSString *productName;
@property(strong,nonatomic) NSString *productCostMoney;
@property(strong,nonatomic) BUImageRes *img;
@property(strong,nonatomic) NSArray *proSubList;
@property(strong,nonatomic) NSString *productId;
-(NSDictionary *)getDic:(NSInteger)leaseType withQishu:(NSInteger)s;
@end

@interface BUOthInfo : BUBase
@property(strong,nonatomic) NSString *orderNO;
@property(strong,nonatomic) NSString *createTime;
@property(nonatomic) NSInteger payType;
@property(strong,nonatomic) NSString *payTime;
@property(strong,nonatomic) NSString *note;
@property(strong,nonatomic) NSString *payMoney;
@property(strong,nonatomic) NSString *chaoMoney;
@property(strong,nonatomic) NSString *chaoday;
@property(strong,nonatomic) NSString *leaseEndTime;
@property(strong,nonatomic) NSString *leaseBeginTime;
@property(strong,nonatomic) NSString *actualMoney;
@property(strong,nonatomic) NSString *compensationMoney;
@end

@interface BULeaseinfo : BUBase
@property(nonatomic) NSInteger period;
@property(strong,nonatomic) NSString *leaseMoney;
@property(strong,nonatomic) NSString *couponMoney;
@property(strong,nonatomic) NSString *creditMoney;
@property(strong,nonatomic) NSString *productInsuranceMoney;
@property(strong,nonatomic) NSString *productCostMoney;
@property(strong,nonatomic) NSString *depositMoney;
@property(strong,nonatomic) NSString *payMoney;
@end
@interface BUBackType : BUBase
@property(strong,nonatomic) NSString *rsTitle;@property(nonatomic) NSInteger rsSort;
@property(strong,nonatomic) NSString *rsId;
@end

@interface BUBackInfo : BUBase
@property(strong,nonatomic) NSString *adminContent;
@property(strong,nonatomic) NSString *createTime;
@property(strong,nonatomic) NSString *orderBackNO;
@property(strong,nonatomic) NSString *rsTitle;
@property(strong,nonatomic) NSArray *outOrderTrackItemModelList;
@property(strong,nonatomic) NSString *backContent;
-(NSDictionary *)getDic:(NSInteger)index;
@end

@interface BUTrack : BUBase
@property(nonatomic) NSInteger quantity;
@property(strong,nonatomic) NSString *deliveryUserName;
@property(strong,nonatomic) NSString *orderNO;
@property(strong,nonatomic) NSArray *outOrderTrackItemModelList;
@property(strong,nonatomic) NSString *deliveryTel;
@property(nonatomic) NSInteger orderDeliveryStatus;
-(NSDictionary *)getDic:(NSInteger)index;
@end


@interface BUTrackInfo : BUBase
@property(strong,nonatomic) NSString *name;
@property(strong,nonatomic) NSString *createTime;
@property(nonatomic) long orderTrackStatus;
-(NSDictionary *)getDic:(NSInteger)index;
@end

@interface BUOrderDetail : BUBase
//@property(strong,nonatomic) NSString *userId;
//@property(strong,nonatomic) NSString *orderTime;
//@property(strong,nonatomic) NSString *contacts;
//@property(strong,nonatomic) NSString *payTime;
//@property(nonatomic) CGFloat money;
//@property(strong,nonatomic) NSString *stateName;
//@property(strong,nonatomic) NSString *payTypeName;
//@property(nonatomic) NSInteger total;
//@property(nonatomic) NSInteger isComment;
//@property(strong,nonatomic) NSString *payType;
//@property(strong,nonatomic) NSString *telephone;
//@property(strong,nonatomic) NSString *shopId;
//@property(nonatomic) CGFloat goodsTotal;
//@property(strong,nonatomic) NSString *shopName;
//@property(nonatomic) NSInteger isPay;
//@property(nonatomic) NSInteger orderType;
//@property(strong,nonatomic) NSString *address;
//@property(strong,nonatomic) NSString *courierId;
//@property(strong,nonatomic) NSString *courierName;
//@property(strong,nonatomic) NSArray *goodsList;
//@property(nonatomic) NSInteger state;
////@property(strong,nonatomic) NSString *orderNo;
//@property(nonatomic) NSInteger afterSaleState;
//@property(strong,nonatomic) NSString *payBody;
//@property(strong,nonatomic) NSString *expressType;
//@property(nonatomic) CGFloat expressFee;
//@property(strong,nonatomic) NSString *expressTypeName;
//@property(strong,nonatomic) NSString *deliveryTime;
//@property(strong,nonatomic) NSString *finishTime;
////@property(strong,nonatomic) NSString *orderId;
//@property(nonatomic) NSInteger integral;
//
//
//@property(nonatomic) NSInteger creditMoney;
//@property(strong,nonatomic) NSString *couponLogID;
//@property(nonatomic) NSInteger leaseMoney;
//@property(strong,nonatomic) NSString *receiveUser;
//@property(nonatomic) NSInteger productInsuranceMoney;
//@property(strong,nonatomic) NSString *adminId;
//@property(strong,nonatomic) NSString *operTime;
//@property(nonatomic) NSInteger exceedMoney;
//@property(strong,nonatomic) NSString *backLogisticsCompany;
//@property(nonatomic) NSInteger leaseType;
////@property(nonatomic) NSInteger state;
//@property(strong,nonatomic) NSString *defineEndTime;
//@property(strong,nonatomic) NSString *sendLogisticsNO;
////@property(strong,nonatomic) NSString *payTime;
//@property(strong,nonatomic) NSString *defineStartTime;
//@property(strong,nonatomic) NSString *img;
//@property(strong,nonatomic) NSString *note;
//@property(strong,nonatomic) NSString *receiveAddress;
//@property(strong,nonatomic) NSString *productItemPriceId;
//@property(strong,nonatomic) NSString *orderID;
//@property(nonatomic) NSInteger status;
//@property(strong,nonatomic) NSString *exceedTime;
//@property(strong,nonatomic) NSString *productAttributes;
//@property(strong,nonatomic) NSString *productItemId;
//@property(strong,nonatomic) NSString *payEndTime;
//@property(strong,nonatomic) NSString *backLogisticsNO;
//@property(nonatomic) NSInteger isEvaluation;
//@property(nonatomic) NSInteger type;
////@property(strong,nonatomic) NSString *userId;
//@property(nonatomic) NSInteger isRelet;
//@property(strong,nonatomic) NSString *leaseBeginTime;
//@property(strong,nonatomic) NSArray *subStr;
//@property(strong,nonatomic) NSString *expireTime;
//@property(strong,nonatomic) NSString *productNO;
////@property(nonatomic) NSInteger payType;
//@property(nonatomic) NSInteger backMoney;
//@property(strong,nonatomic) NSString *receiveTel;
//@property(nonatomic) NSInteger couponMoney;
//@property(strong,nonatomic) NSString *orderNO;
//@property(nonatomic) NSInteger period;
//@property(nonatomic) NSInteger isAfterSale;
//@property(nonatomic) NSInteger payMoney;
//@property(strong,nonatomic) NSString *productId;
//@property(strong,nonatomic) NSString *receiveTime;
//@property(strong,nonatomic) NSString *leaseEndTime;
//@property(strong,nonatomic) NSString *backTime;
//@property(strong,nonatomic) NSString *receiveAddressID;
//@property(strong,nonatomic) NSString *createTime;
//@property(nonatomic) NSInteger productCostMoney;
//@property(strong,nonatomic) NSString *postalCode;
//@property(strong,nonatomic) NSString *productName;
//@property(strong,nonatomic) NSString *sendLogisticsCompany;
//@property(nonatomic) NSInteger freightMoney;
//@property(nonatomic) NSInteger isBuyout;
@property(nonatomic) NSInteger state;
@property(strong,nonatomic) NSString *expireTime;
@property(strong,nonatomic) NSString *receiveUser;
@property(strong,nonatomic) NSString *receiveAddress;
@property(strong,nonatomic) NSString *orderID;
@property(nonatomic) NSInteger isChao;
@property(strong,nonatomic) NSString *receiveTel;
@property(nonatomic) NSInteger leaseType;
@property(strong,nonatomic) BULeaseinfo *leaseinfo;
@property(strong,nonatomic) BUOthInfo *othInfo;

@property(strong,nonatomic) NSString *payEndTime;
@property(nonatomic) NSInteger leaseCount;
@property(strong,nonatomic) BUProInfo *proInfo;
@end

@interface BUSubmitCart : BUBase
@property(strong,nonatomic) NSString *orderId;
@property(strong,nonatomic) NSString *endPayTime;
@property(nonatomic) CGFloat payPrice;
@end

@interface BUAddress : BUBase
@property(strong,nonatomic) NSString *mobile;
@property(strong,nonatomic) NSString *delCity;
@property(nonatomic) CGFloat longitude;
@property(strong,nonatomic) NSString *delName;
@property(nonatomic) CGFloat latitude;
@property(strong,nonatomic) NSString *delBuildingNo;
@property(strong,nonatomic) NSString *delAddress;
@property(strong,nonatomic) NSString *delId;
@property (nonatomic,assign) BOOL isDefault;
@property (nonatomic,assign) BOOL isSend;
-(NSDictionary *)getDic:(NSInteger)index;
-(NSDictionary *)getDic;
@end

@interface BUCartInfo : BUBase
@property(strong,nonatomic) NSArray *usableShoppingCartList;
@property(strong,nonatomic) NSArray *notInShoppingCartList;
@property(strong,nonatomic) NSArray *failureGoodsList;
@end



@interface BUCoupon : BUBase
@property(nonatomic) NSInteger cScope;
@property(nonatomic) NSInteger cThreshold;
@property(strong,nonatomic) NSString *receiveTime;
@property(strong,nonatomic) NSString *clId;
@property(nonatomic) CGFloat cPrice;
@property(strong,nonatomic) NSString *cTitle;
@property(strong,nonatomic) NSString *validTime;
@property(strong,nonatomic) NSString *notUseState;
-(NSDictionary *)getDic:(NSInteger)index;
@end

@interface BUCartItem : BUBase
@property(nonatomic) NSInteger couponCount;
@property(nonatomic) CGFloat shippingPrice;
@property(nonatomic) CGFloat distriMoney;
@property(nonatomic) CGFloat proVIPPrice;
@property(nonatomic) CGFloat proPrice;
@property(nonatomic) CGFloat actionPrice;
@property(strong,nonatomic) NSArray *outShoppingCartProductList;
@end

@interface BUCartSumPrice : BUBase
@property (nonatomic,assign) BOOL isAllSelected;
@property (nonatomic,assign) CGFloat sumPrice;
@property (nonatomic,strong) NSMutableArray *dataArr;
@property(strong,nonatomic) NSString *storeId;
@property(strong,nonatomic) NSString *sName;
@property(nonatomic) CGFloat distriMoney;
@property(strong,nonatomic) NSString *shoppingCartId;
@property(nonatomic,assign) CGFloat shippingMoney;
-(NSDictionary *)getDic:(NSInteger )index;
-(void)setAllSel;
@end


@interface BUCartGoods : BUBase
@property(nonatomic) NSInteger quantity;
@property(nonatomic) CGFloat proPrice;
@property(strong,nonatomic) NSString *storeId;
@property(strong,nonatomic) NSString *shoppingCardItemId;
@property(strong,nonatomic) NSString *productId;
@property(nonatomic) NSInteger stocks;
@property(nonatomic) CGFloat shippingMoney;
@property(strong,nonatomic) NSString *sName;
@property(nonatomic) NSInteger type;
@property(strong,nonatomic) NSString *proName;
@property(strong,nonatomic) NSString *shoppingCartId;
@property(strong,nonatomic) BUImageRes *pDefImg;
@property(nonatomic) CGFloat distriMoney;
@property(nonatomic,assign) BOOL isSelected;
@property(strong,nonatomic) NSString *attr;

-(NSDictionary *)getDic:(NSInteger)index;
@end

@interface BUOrderManager : BULCManager
//添加购物车
-(BOOL)addShoppingCart:(NSString *)productId storeId:(NSString *)storeId withProCount:(NSInteger)proCount userId:(NSString *)userId  observer:(id)observer callback:(SEL)callback;
-(BOOL)addShoppingCart:(NSString *)productId storeId:(NSString *)storeId  userId:(NSString *)userId withProCount:(NSInteger)proCount  observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo;
//获取购物车列表
@property (nonatomic,strong) BUCartInfo *cartInfo;
-(BOOL)getShoppingCartList:(NSString *)userId log:(NSString *)log lat:(NSString *)lat   observer:(id)observer callback:(SEL)callback;
-(BOOL)getShoppingCartList:(NSString *)userId log:(NSString *)log lat:(NSString *)lat  observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo;
//获取购物车有效商品数量
@property (nonatomic,assign) NSInteger cartCount;
-(BOOL)getShoppingCartCount:(NSString *)userId log:(NSString *)log lat:(NSString *)lat   observer:(id)observer callback:(SEL)callback;
-(BOOL)getShoppingCartCount:(NSString *)userId log:(NSString *)log lat:(NSString *)lat  observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo;

//删除购物车商品
-(BOOL)shoppingCartDelBatch:(NSMutableArray *)arr  observer:(id)observer callback:(SEL)callback;
-(BOOL)shoppingCartDelBatch:(NSMutableArray *)arr  observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo;

//获取购物车明细
@property (nonatomic,strong) BUCartItem *cartItem;
-(BOOL)getShoppingCartItem:(NSString *)userId productIdQuantityList:(NSArray *)productIdQuantityList storeId:(NSString *)storeId   observer:(id)observer callback:(SEL)callback;
-(BOOL)getShoppingCartItem:(NSString *)userId productIdQuantityList:(NSArray *)productIdQuantityList storeId:(NSString *)storeId observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo;

//获取优惠券列表
@property (nonatomic,strong) NSArray *couponList;//可用
@property (nonatomic,strong) NSArray *couponUnUseList;//不可用
-(BOOL)getCouponList:(NSString *)userId productIdQuantityList:(NSArray *)productIdQuantityList storeId:(NSString *)storeId type:(NSString *)type  observer:(id)observer callback:(SEL)callback;
-(BOOL)getCouponList:(NSString *)userId productIdQuantityList:(NSArray *)productIdQuantityList storeId:(NSString *)storeId type:(NSString *)type observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo;
//获取地址
//@property (nonatomic,strong) NSArray *addressList;
//-(BOOL)getDeliveryAddress:(NSString *)userId observer:(id)observer callback:(SEL)callback;
//-(BOOL)getDeliveryAddress:(NSString *)userId  observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo;

//提交购物车
@property (nonatomic,strong) BUSubmitCart *submitCart;
-(BOOL)submitShoppingCart:(NSString *)userId deliveryAddressId:(NSString *)deliveryAddressId payPrice:(NSString *)payPrice couponLogId:(NSString *)couponLogId isInvoice:(NSString*)isInvoice invoiceModel:(BSJSON *)invoiceModel storeId:(NSString *)storeId  productIdQuantityList:(NSArray *)productIdQuantityList observer:(id)observer callback:(SEL)callback;
-(BOOL)submitShoppingCart:(NSString *)userId  deliveryAddressId:(NSString *)deliveryAddressId payPrice:(NSString *)payPrice couponLogId:(NSString *)couponLogId isInvoice:(NSString*)isInvoice invoiceModel:(BSJSON *)invoiceModel storeId:(NSString *)storeId productIdQuantityList:(NSArray *)productIdQuantityList observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo;

//订单详情
@property (nonatomic,strong) BUOrderDetail *orderDetail;
-(BOOL)getMyOrderItemInfo:(NSString *)userId orderId:(NSString *)orderId observer:(id)observer callback:(SEL)callback;
-(BOOL)getMyOrderItemInfo:(NSString *)userId orderId:(NSString *)orderId   observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo;

//订单操作
//type (integer, optional): 操作类型 1 取消订单，2 删除订单，3 确认收货 ,
-(BOOL)operOrder:(NSString *)userId orderId:(NSString *)orderId type:(NSString *)type observer:(id)observer callback:(SEL)callback;
-(BOOL)operOrder:(NSString *)userId orderId:(NSString *)orderId  type:(NSString *)type  observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo;

//订单跟踪
@property (nonatomic,strong) BUTrack *track;
-(BOOL)getTrackOrder:(NSString *)userId orderId:(NSString *)orderId observer:(id)observer callback:(SEL)callback;
-(BOOL)getTrackOrder:(NSString *)userId orderId:(NSString *)orderId   observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo;

//提交评价
-(BOOL)evaluate:(NSString *)userId orderId:(NSString *)orderId orderScore:(NSString *)orderScore deliveryScore:(NSString *)deliveryScore deliveryRemark:(NSString *)deliveryRemark orderRemark:(NSString *)orderRemark eAnonymous:(NSString *)eAnonymous  observer:(id)observer callback:(SEL)callback;
-(BOOL)evaluate:(NSString *)userId orderId:(NSString *)orderId orderScore:(NSString *)orderScore deliveryScore:(NSString *)deliveryScore deliveryRemark:(NSString *)deliveryRemark orderRemark:(NSString *)orderRemark eAnonymous:(NSString *)eAnonymous    observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo;
//获取退货订单明细
@property (nonatomic,strong) BUBackInfo *backInfo;
-(BOOL)getBackOrderItem:(NSString *)orderBackID observer:(id)observer callback:(SEL)callback;
-(BOOL)getBackOrderItem:(NSString *)orderBackID    observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo;

//退货
@property (nonatomic,strong) NSString *orderBackID;
-(BOOL)toBackOrder:(NSString *)userId orderId:(NSString *)orderId rsId:(NSString *)rsId rsTitle:(NSString *)rsTitle backContent:(NSString *)backContent userName:(NSString *)userName userTel:(NSString *)userTel  uploadPic:(NSString *)uploadPic   observer:(id)observer callback:(SEL)callback;
-(BOOL)toBackOrder:(NSString *)userId orderId:(NSString *)orderId rsId:(NSString *)rsId rsTitle:(NSString *)rsTitle backContent:(NSString *)backContent userName:(NSString *)userName userTel:(NSString *)userTel  uploadPic:(NSString *)uploadPic     observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo;
//退货分类
@property (nonatomic,strong) NSArray *backTypeList;
-(BOOL)getBackTypeList:(id)observer callback:(SEL)callback;
-(BOOL)getBackTypeList:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo;


-(BOOL)recyclingOrderAdd:(NSString*) userId withAddrid:(NSString*) addrId withRemark:(NSString*) remark withRecyclingtype:(NSString*) recyclingType withWeight:(NSString*) weight withType:(NSString*) type withPresettime:(NSString*) presetTime observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo;
-(BOOL)recyclingOrderAdd:(NSString*) userId withAddrid:(NSString*) addrId withRemark:(NSString*) remark withRecyclingtype:(NSString*) recyclingType withWeight:(NSString*) weight withType:(NSString*) type withPresettime:(NSString*) presetTime observer:(id)observer callback:(SEL)callback;
@end
