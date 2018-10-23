//
//  BUGetOrderListManager.h
//  compassionpark
//
//  Created by air on 2017/3/24.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import "BUBasePageDataManager.h"
#import "BUImageRes.h"

#import "BUOrderManager.h"



@interface BUOrderMsgList : BUBase
@property(strong,nonatomic) NSString *productId;
@property(nonatomic) NSInteger leaseType;
@property(strong,nonatomic) NSString *productName;
@property(strong,nonatomic) NSString *time;
@property(strong,nonatomic) NSString *productAttributes;
@property(strong,nonatomic) NSString *img;
@property(strong,nonatomic) NSString *userName;
@property(strong,nonatomic) NSString *orderId;
@property(strong,nonatomic) NSString *leaseMoney;
@property(strong,nonatomic) NSString *userImg;
@property(strong,nonatomic) NSString *imgList;
@property(strong,nonatomic) NSString *msg;
@property(strong,nonatomic) NSArray *subStr;
@end

@interface BUGoods : BUBase
@property(strong,nonatomic) BUImageRes *goodsImage;
@property(strong,nonatomic) NSString *ogId;
@property(strong,nonatomic) NSString *goodsName;
@property(nonatomic) NSInteger productType;
@property(strong,nonatomic) NSString *goodsId;
@property(nonatomic) CGFloat price;
@property(nonatomic) CGFloat salePrice;
@property(nonatomic) NSInteger count;
@property(strong,nonatomic) NSString *userId;
@property(strong,nonatomic) NSString *goodsNo;
@property(strong,nonatomic) NSString *goodsSpec;
-(NSDictionary *)getDic;
@end

@interface BUGetOrder : BUBase
@property(nonatomic) NSInteger creditMoney;
@property(strong,nonatomic) NSString *couponLogID;
@property(nonatomic) CGFloat leaseMoney;
@property(strong,nonatomic) NSString *receiveUser;
@property(nonatomic) CGFloat productInsuranceMoney;
@property(strong,nonatomic) NSString *adminId;
@property(strong,nonatomic) NSString *operTime;
@property(nonatomic) CGFloat exceedMoney;
@property(strong,nonatomic) NSString *backLogisticsCompany;
@property(nonatomic) NSInteger leaseType;
@property(nonatomic) NSInteger chaoday;
@property(strong,nonatomic) NSString *depositMoney;
@property(nonatomic)CGFloat chaoMoney;
@property(nonatomic) NSInteger state;//订单状态，(0 待付款 1 待发货 2 已发货 3 租赁中 4租赁中续费 5 到期归还 6 已完成 7 关闭) ,
@property(strong,nonatomic) NSString *defineEndTime;
@property(strong,nonatomic) NSString *sendLogisticsNO;
@property(strong,nonatomic) NSString *payTime;
@property(strong,nonatomic) NSString *defineStartTime;
@property(strong,nonatomic) BUImageRes *img;
@property(strong,nonatomic) NSString *note;
@property(strong,nonatomic) NSString *receiveAddress;
@property(strong,nonatomic) NSString *productItemPriceId;
@property(strong,nonatomic) NSString *orderID;
@property(nonatomic) NSInteger status;
@property(strong,nonatomic) NSString *exceedTime;
@property(strong,nonatomic) NSString *productAttributes;
@property(strong,nonatomic) NSString *productItemId;
@property(strong,nonatomic) NSString *payEndTime;
@property(strong,nonatomic) NSString *backLogisticsNO;
@property(nonatomic) NSInteger isEvaluation;
@property(nonatomic) NSInteger type;
@property(strong,nonatomic) NSString *userId;
@property(nonatomic) NSInteger isRelet;
@property(strong,nonatomic) NSString *leaseBeginTime;
@property(strong,nonatomic) NSArray *subStr;
@property(strong,nonatomic) NSString *expireTime;
@property(strong,nonatomic) NSString *productNO;
@property(nonatomic) NSInteger payType;
@property(nonatomic) NSInteger backMoney;
@property(strong,nonatomic) NSString *receiveTel;
@property(nonatomic) NSInteger couponMoney;
@property(strong,nonatomic) NSString *orderNO;
@property(nonatomic) NSInteger period;
@property(nonatomic) NSInteger isAfterSale;
@property(nonatomic) CGFloat payMoney;
@property(strong,nonatomic) NSString *productId;
@property(strong,nonatomic) NSString *receiveTime;
@property(strong,nonatomic) NSString *leaseEndTime;
@property(strong,nonatomic) NSString *backTime;
@property(strong,nonatomic) NSString *receiveAddressID;
@property(strong,nonatomic) NSString *createTime;
@property(nonatomic) NSInteger productCostMoney;
@property(strong,nonatomic) NSString *postalCode;
@property(strong,nonatomic) NSString *productName;
@property(strong,nonatomic) NSString *sendLogisticsCompany;
@property(nonatomic) NSInteger freightMoney;
@property(nonatomic) NSInteger isBuyout;
@property(strong,nonatomic)NSIndexPath *indexPath;
@property(strong,nonatomic) NSString *payBody;
//@property(nonatomic) NSInteger state;
//@property(strong,nonatomic) NSString *orderNO;
//@property(strong,nonatomic) NSString *productId;
//@property(nonatomic) NSInteger leaseType;
//@property(strong,nonatomic) NSString *orderID;
//@property(nonatomic) NSInteger period;
@property(nonatomic) NSInteger leaseCount;
//@property(nonatomic,strong) NSString *expireTime;
@property(nonatomic) CGFloat deposit;
//@property(nonatomic) NSInteger payMoney;
//@property(strong,nonatomic) NSString *productAttributes;
//@property(strong,nonatomic) NSString *img;
//@property(strong,nonatomic) NSString *payEndTime;
//@property(nonatomic) NSInteger productCostMoney;
@property(strong,nonatomic) NSString *proName;
//@property(nonatomic) NSInteger leaseMoney;
//@property(strong,nonatomic) NSString *subStr;

-(NSDictionary *)getDicA1;
//-(NSDictionary*)getDic;
-(NSDictionary *)getDicA;
-(NSDictionary *)getDicB:(NSInteger)row;
-(NSDictionary *)getDicC;
-(NSDictionary *)getRunDic:(NSInteger)row;
-(NSDictionary *)getAfterSellDic:(NSInteger)row;
@end

@interface BUGetOrderListManager : BUBasePageDataManager
//@property(strong,nonatomic)NSArray *getOrderList;
@property(strong,nonatomic)BUOrderDetail *orderDetail;
-(BOOL)getOrderList:(NSString*)userId withOrderStatus:(NSString*)state observer:(id)observer callback:(SEL)callback;
-(BOOL)getOrderList:(NSString*)userId withOrderStatus:(NSString*)state  observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo;

-(BOOL)getOrderListNextPage:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo;
-(BOOL)getOrderListNextPage:(id)observer callback:(SEL)callback;

//添加订单
-(BOOL)orderAdd:(NSString*) presetTime withAddrid:(NSString*) addrId withCourierid:(NSString*) courierId withRecyclingtype:(NSString*) recyclingType withWeight:(NSString*) weight withUserid:(NSString*) userId withGoodslist:(NSArray*) goodsList withPaytype:(NSString*) payType withOrdertype:(NSString*) orderType withShopid:(NSString*) shopId withIntegral:(NSString*) integral withExpresstype:(NSString*) expressType withLinkid:(NSString*) linkId withRemark:(NSString*) remark stationId:(NSString *)stationId expressFee:(NSString *)expressFee observer:(id)observer callback:(SEL)callback;
-(BOOL)orderAdd:(NSString*) presetTime withAddrid:(NSString*) addrId withCourierid:(NSString*) courierId withRecyclingtype:(NSString*) recyclingType withWeight:(NSString*) weight withUserid:(NSString*) userId withGoodslist:(NSArray*) goodsList withPaytype:(NSString*) payType withOrdertype:(NSString*) orderType withShopid:(NSString*) shopId withIntegral:(NSString*) integral withExpresstype:(NSString*) expressType withLinkid:(NSString*) linkId withRemark:(NSString*) remark stationId:(NSString *)stationId expressFee:(NSString *)expressFee observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo;

-(BOOL)getOrderDetail:(NSString*) aid observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo;
-(BOOL)getOrderDetail:(NSString*) aid observer:(id)observer callback:(SEL)callback;
-(BOOL)orderOper:(NSString*) message withOrderid:(NSString*) orderId withPrice:(NSString*) price withOperType:(NSString *)operType observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo
;
-(BOOL)orderOper:(NSString*) message withOrderid:(NSString*) orderId withPrice:(NSString*) price withOperType:(NSString *)operType observer:(id)observer callback:(SEL)callback;
-(BOOL)orderDel:(NSString*) sid withUserid:(NSString*) userId observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo;
-(BOOL)orderDel:(NSString*) sid withUserid:(NSString*) userId observer:(id)observer callback:(SEL)callback;
//@property (nonatomic,strong) BUOrderOper *orderAddResult;
@property (nonatomic,strong) BUGetOrder *getOrder;

-(BOOL)orderFinish:(NSString*) sid withUserid:(NSString*) userId observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo;
-(BOOL)orderFinish:(NSString*) sid withUserid:(NSString*) userId observer:(id)observer callback:(SEL)callback;

-(BOOL)orderCancel:(NSString*) sid withUserid:(NSString*) userId observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo;
-(BOOL)orderCancel:(NSString*) sid withUserid:(NSString*) userId observer:(id)observer callback:(SEL)callback;

-(BOOL)orderPay:(NSString*) payType withOrderid:(NSString*) orderId withUserid:(NSString*) userId observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo;
-(BOOL)orderPay:(NSString*) payType withOrderid:(NSString*) orderId withUserid:(NSString*) userId observer:(id)observer callback:(SEL)callback;

-(BOOL)orderConfirmbyCourier:(NSString*) orderId withCourierid:(NSString*) courierId observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo;
-(BOOL)orderConfirmbyCourier:(NSString*) orderId withCourierid:(NSString*) courierId observer:(id)observer callback:(SEL)callback;

-(BOOL)orderConfirm:(NSString*) sid withUserid:(NSString*) userId observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo;

-(BOOL)orderConfirm:(NSString*) sid withUserid:(NSString*) userId observer:(id)observer callback:(SEL)callback;

//获取配送方式 配送费
//@property (nonatomic,strong) BUExpressFee *expressFee;
//-(BOOL)getExpressInfo:(NSString*)cityId longitude:(NSString*) longitude latitude:(NSString*) latitude shopId:(NSString*) shopId   observer:(id)observer callback:(SEL)callback;
//-(BOOL)getExpressInfo:(NSString*)cityId longitude:(NSString*) longitude latitude:(NSString*) latitude shopId:(NSString*) shopId observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo;
@end
