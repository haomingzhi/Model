//
//  BUShopManager.m
//  intelligentgarbagecollection
//
//  Created by Steve on 2017/12/7.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import "BUShopManager.h"
#import "BUSystem.h"

@implementation BUServiceInfo

-(id)init
{
     self = [super init];
     if(self){
          self.deserializationMap = @{@"BUImageRes":@"BUImageRes",@"imageList":@"BUImageRes,imageList",@"promiseList":@"NSString,promiseList",@"commentList":@"BUGetComment,commentList"};
     }
     return self;
}

-(NSDictionary *)getDic:(NSInteger)index{
     if (index == 0) {
          NSString *price = [NSString stringWithFormat:@"¥%.2f元/%@",_price,_serviceSpec];
          NSString *saleCount = [NSString stringWithFormat:@"服务%ld次",(long)_saleCount];
          return  @{@"img":_imagePath?:@"default",@"default":@"default",@"title":_name?:@"",@"source":price,@"time":saleCount};
     }
     else if (index == 1 ){
          NSMutableArray *arr = [NSMutableArray new];
          [_imageList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
               BUImageRes *img = obj;
               [arr addObject:@{@"img":img?:[BUImageRes new]}];
          }];
          return @{@"arr":arr};
     }
     else if (index == 2){
          NSString *price = [NSString stringWithFormat:@"￥%.2f/%@",_price,_serviceSpec];
          NSString *saleCount = [NSString stringWithFormat:@"服务%ld次",(long)_saleCount];
          return @{@"title":_name?:@"",@"source":price,@"time":saleCount};
     }
     else if (index == 3){
          NSMutableArray *arr = [NSMutableArray new];
          [_promiseList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
               [arr addObject:obj];
          }];
          return @{@"title":@"服务承诺",@"arr":arr};
     }
     else  if (index == 4) {
          NSString *price = [NSString stringWithFormat:@"¥%.2f元/%@",_price,_serviceSpec];
//          NSString *saleCount = [NSString stringWithFormat:@"服务%ld件",(long)_saleCount];
          return  @{@"img":_imagePath?:@"default",@"default":@"default",@"title":_name?:@"",@"source":price,@"time":@"x1"};
     }
     return @{};
}

@end

@implementation BUGoodsDetail

-(id)init
{
     self = [super init];
     if(self){
          self.deserializationMap = @{@"BUImageRes":@"BUImageRes",@"imageList":@"BUImageRes,imageList",@"commentList":@"BUGetComment,commentList",@"goodsList":@"BUGoodsInfo,goodsList"};
     }
     return self;
}

-(NSDictionary *)getDic:(NSInteger)index{
     if (index == 0) {
          NSString *price = [NSString stringWithFormat:@"¥%.2f元/箱",_salePrice];
          NSString *sale = [NSString stringWithFormat:@"已售%ld件",(long)_saleCount];
          return @{@"img":_imagePath?:@"default",@"default":@"default",@"title":_name?:@"",@"source":price,@"time":sale};
     }
     else if(index == 1){
          NSMutableArray *arr = [NSMutableArray new];
          [_imageList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
               BUImageRes *img = obj;
               [arr addObject:@{@"img":img}];
          }];
          return @{@"arr":arr};
     }
     
     else if(index == 2){
          NSString *str = [NSString stringWithFormat:@"￥%.2f/%@起",_salePrice,_goodsSpec];
          NSString *str1 = [NSString stringWithFormat:@"已售%ld件",(long)_saleCount];
          return @{@"title":_name?:@"",@"source":str,@"time":str1};
     }
     else if (index == 3){
          NSString *str = [NSString stringWithFormat:@"店铺编号：%@",_shopSN];
          return @{@"img":@"icon_shop",@"title":_shopName?:@"",@"source":str,@"time":@""};
     }
     return @{};
}
@end


@implementation BUProductPromise

-(NSDictionary *)getDic{
     return @{@"title":_name?:@"",@"detail":_note?:@"",@"img":@"check_goods"};
}
@end

@implementation BUProductParamter
-(id)init
{
     self = [super init];
     if(self){
          self.deserializationMap = @{@"id":@"NSString,ID"};
     }
     return self;
}
-(NSDictionary *)getDic{
     return @{@"title":_title?:@"",@"detail":_value?:@""};
}
@end

@implementation BUProductAttribute

-(id)init
{
     self = [super init];
     if(self){
          self.deserializationMap = @{@"value":@"BUProductAttributeValue,value",@"id":@"NSString,ID"};
     }
     return self;
}

@end

@implementation BUProductAttributeValue

@end


@implementation BUProductLease

@end

@implementation BUGetPayMoney

@end

@implementation BUSubmitOrder

@end

@implementation BUProductPrice

-(id)init
{
     self = [super init];
     if(self){
          self.deserializationMap = @{@"BUImageRes":@"BUImageRes",@"productAttributeList":@"BUProductAttribute,productAttributeList",@"leaseList":@"BUProductLease,leaseList"};
     }
     return self;
}

@end

@implementation BUGoodsInfo

-(id)init
{
     self = [super init];
     if(self){
          self.deserializationMap = @{@"BUImageRes":@"BUImageRes",@"pictureList":@"BUImageRes,pictureList",@"productPromiseList":@"BUProductPromise,productPromiseList",@"productParamterList":@"BUProductParamter,productParamterList",@"productAttributeList":@"BUProductAttribute,productAttributeList",@"leaseList":@"BUProductLease,leaseList"};
     }
     return self;
}

-(NSDictionary *)getDic:(NSInteger)index{
     if (index == 0) {
          NSMutableArray *arr = [NSMutableArray array];
          [_pictureList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
               BUImageRes *i = obj;
               [arr addObject:@{@"img":i?:@""}];
          }];
          return @{@"arr":arr};
     }
     
     else if(index ==1){
          NSString *source = [NSString stringWithFormat:@"%ld笔",(long)_tradeCount];
          NSString *price = [NSString stringWithFormat:@"%.2f",_leaseMoney];
          NSString *cost = [NSString stringWithFormat:@"商品价值¥%.2f",_costMoney];
          return @{@"title":_name?:@"",@"source":source,@"time":price,@"mark":_colorType==0?@"[全新]":@"[二手]",@"standards":_leaseType==0?@"元/月":@"元/天",@"price":cost};
     }
     else if(index == 2){
          NSMutableArray *arr = [NSMutableArray array];
          [_productPromiseList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
               BUProductPromise *p = obj;
               [arr addObject:p.name?:@""];
          }];
          return  @{@"arr":arr,@"hasMore":@(_productPromiseList.count>4)};
     }
     else if(index == 3){
          return  @{@"title":_note?:@""};
     }
     else if(index == 4){
          NSMutableArray *arr = [NSMutableArray new];
          [_productPromiseList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
               BUProductPromise *p = obj;
               [arr addObject:[p getDic]];
          }];
          return  @{@"title":@"服务说明",@"arr":arr};
     }
     else if (index == 5){
          return @{@"title":@"请选择:",@"source":_attributes?:@"",@"time":@""};
     }
     return @{};
}

@end

@implementation BUOrderCoupon
-(NSDictionary *)getDic{
     NSString *aTitle = [NSString stringWithFormat:@"¥%.2f",_price];
     NSString *p = [NSString stringWithFormat:@"%.2f",[[NSString stringWithFormat:@"%d",(int)_price] floatValue]];
     NSString *p1 = [NSString stringWithFormat:@"%.2f",_price];
     if ([p1 isEqualToString:p]) {
          aTitle = [NSString stringWithFormat:@"¥%d",(int)_price];
     }else{
          p = [NSString stringWithFormat:@"%.2f",[[NSString stringWithFormat:@"%.1f",_price] floatValue]];
          if ([p1 isEqualToString:p]) {
               aTitle = [NSString stringWithFormat:@"¥%.1f",_price];
          }
     }
     
     NSString *bTitle = _threshold == 0?@"无限制":[NSString stringWithFormat:@"满%d元可用",(int)_threshold];
     NSString *dTitle = _scope == 0? @"适用平台：全场通用":_scope ==1?@"适用平台：指定商品":@"适用平台：指定分类";
     NSString *time = _effectime;
     if (time.length>= 10) {
          time = [time substringToIndex:10];
     }
    NSString *eTitle = [NSString stringWithFormat:@"有效期至：%@",time];
    return @{@"aTitle":aTitle,@"bTitle":bTitle,@"cTitle":_title?:@"",@"dTitle":dTitle,@"eTitle":eTitle,@"bgImg":@"couponBg"};
}
@end


@implementation BUShopType

-(id)init
{
     self = [super init];
     if(self){
          self.deserializationMap = @{@"BUImageRes":@"BUImageRes"};
     }
     return self;
}

-(NSDictionary *)getDic:(NSInteger)index{
     if (index == 0) {
          return @{@"img":_imagePath?:@"default",@"title":_typeName?:@"",@"hidden":@(NO),@"default":@"default"};
     }
     return @{};
}

@end

@implementation BUShopInfo

-(id)init
{
     self = [super init];
     if(self){
          self.deserializationMap = @{@"BUImageRes":@"BUImageRes"};
     }
     return self;
}

-(NSDictionary *)getDic:(NSInteger)index{
     if (index == 0) {
          NSString *sale = [NSString stringWithFormat:@"在售产品%ld份 / 已售出%ld份",(long)_goodsCount,(long)_saleCount];
          return @{@"img":_logoUrl?:@"default",@"default":@"default",@"title":_name?:@"",@"source":_address?:@"",@"time":sale,@"isOpen":@(_state == 1?YES:NO)};
     }
     else if(index == 1){
          NSString *str = [NSString stringWithFormat:@"营业时间：%@-%@",_startTime,_endTime];
          return @{@"title":@"在售商品",@"detail":str};
     }
     return @{};
}

@end

@implementation BUShopManager


-(BOOL)getShopInfo:(NSString *)ID  observer:(id)observer callback:(SEL)callback
{
     return [self getShopInfo:ID  observer:observer callback:callback extraInfo:nil];
}

-(BOOL)getShopInfo:(NSString *)ID  observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo
{
     NSInvocation *input = BSGetInvocationFromSel(self, @selector(getShopInfoInput:));
     [input setArgument:&ID atIndex:2];
     [input retainArguments];
     return [self sendRequest:[NSString stringWithFormat:@"%@%@%@",BU_BUSINESS_DOMAIN_SHOP,BU_BUSINESS_GetShopInfo,@""]
                         head:nil
                       method:@"POST"
                        async:YES
              inputInvocation:input
             outputInvocation:BSGetInvocationFromSel(self, @selector(getShopInfoOutput:ok:input:))
                     observer:observer
                       action:callback
                    extraInfo:extraInfo];
     
}


-(NSData *)getShopInfoInput:(NSString*)ID
{
     NSString *request = [NSString stringWithFormat:@"id=%@&%@",ID,[self getBaseUrlParem]];
      return [request dataUsingEncoding:NSUTF8StringEncoding];
     
}

-(NSError *)getShopInfoOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input

{
     UNPACKETOUTPUTHEAD(recvData, ok);
     _shopInfo = nil;
     [(BSJSON *)jsonObj deserializationSpecifityMap:self map:@{@"data":@"BUShopInfo,shopInfo"}];
     return SuccessedError;
     
}



-(BOOL)getShopTypeList:(id)observer callback:(SEL)callback
{
     return [self getShopTypeList:observer callback:callback extraInfo:nil];
}

-(BOOL)getShopTypeList:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo
{
     NSInvocation *input = BSGetInvocationFromSel(self, @selector(getShopTypeListInput));
     [input retainArguments];
     return [self sendRequest:[NSString stringWithFormat:@"%@%@",BU_BUSINESS_DOMAIN_SHOP,BU_BUSINESS_GetShopTypeList]
                         head:nil
                       method:@"POST"
                        async:YES
              inputInvocation:input
             outputInvocation:BSGetInvocationFromSel(self, @selector(getShopTypeListOutput:ok:input:))
                     observer:observer
                       action:callback
                    extraInfo:extraInfo];
     
}


-(NSData *)getShopTypeListInput
{
     NSString *request = [NSString stringWithFormat:@"%@",[self getBaseUrlParem]];
     return [request dataUsingEncoding:NSUTF8StringEncoding];
     
}

-(NSError *)getShopTypeListOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input

{
     UNPACKETOUTPUTHEAD(recvData, ok);
     _shopTypeList = nil;
     [(BSJSON *)jsonObj deserializationSpecifityMap:self map:@{@"data":@"BUShopType,shopTypeList"}];
     return SuccessedError;
     
}



-(BOOL)getGoodsInfo:(NSString *)ID  observer:(id)observer callback:(SEL)callback
{
     return [self getGoodsInfo:ID  observer:observer callback:callback extraInfo:nil];
}

-(BOOL)getGoodsInfo:(NSString *)ID  observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo
{
     NSInvocation *input = BSGetInvocationFromSel(self, @selector(getGoodsInfoInput:));
     [input setArgument:&ID atIndex:2];
     [input retainArguments];
     return [self sendRequest:[NSString stringWithFormat:@"%@%@%@",BU_BUSINESS_DOMAIN_PRODUCT,BU_BUSINESS_GetProductItem,@""]
                         head:nil
                       method:@"POST"
                        async:YES
              inputInvocation:input
             outputInvocation:BSGetInvocationFromSel(self, @selector(getGoodsInfoOutput:ok:input:))
                     observer:observer
                       action:callback
                    extraInfo:extraInfo];
     
}


-(NSData *)getGoodsInfoInput:(NSString*)ID
{
     NSString *request = [NSString stringWithFormat:@"productId=%@&userId=%@&%@",ID,busiSystem.agent.userId?:@"",[self getBaseUrlParem]];
     return [request dataUsingEncoding:NSUTF8StringEncoding];
     
}

-(NSError *)getGoodsInfoOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input

{
     UNPACKETOUTPUTHEAD(recvData, ok);
     _goodsInfo = nil;
     [(BSJSON *)jsonObj deserializationSpecifityMap:self map:@{@"data":@"BUGoodsInfo,goodsInfo"}];
     return SuccessedError;
     
}


-(BOOL)getLeaseRule:(id)observer callback:(SEL)callback
{
     return [self getLeaseRule:observer callback:callback extraInfo:nil];
}

-(BOOL)getLeaseRule:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo
{
     NSInvocation *input = BSGetInvocationFromSel(self, @selector(getLeaseRuleInput));
     [input retainArguments];
     return [self sendRequest:[NSString stringWithFormat:@"%@%@%@",BU_BUSINESS_DOMAIN_PRODUCT,BU_BUSINESS_GetLeaseRule,@""]
                         head:nil
                       method:@"POST"
                        async:YES
              inputInvocation:input
             outputInvocation:BSGetInvocationFromSel(self, @selector(getLeaseRuleOutput:ok:input:))
                     observer:observer
                       action:callback
                    extraInfo:extraInfo];
     
}


-(NSData *)getLeaseRuleInput
{
     NSString *request = [NSString stringWithFormat:@"%@",[self getBaseUrlParem]];
     return [request dataUsingEncoding:NSUTF8StringEncoding];
     
}

-(NSError *)getLeaseRuleOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input

{
     UNPACKETOUTPUTHEAD(recvData, ok);
     _leaseRule = nil;
     [(BSJSON *)jsonObj deserializationSpecifityMap:self map:@{@"data":@"NSString,leaseRule"}];
     return SuccessedError;
     
}



-(BOOL)getGoodsTypeList:(NSString *)ID  observer:(id)observer callback:(SEL)callback
{
     return [self getGoodsTypeList:ID  observer:observer callback:callback extraInfo:nil];
}

-(BOOL)getGoodsTypeList:(NSString *)ID  observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo
{
     NSInvocation *input = BSGetInvocationFromSel(self, @selector(getGoodsTypeListInput:));
     [input setArgument:&ID atIndex:2];
     [input retainArguments];
     return [self sendRequest:[NSString stringWithFormat:@"%@%@%@",BU_BUSINESS_DOMAIN_SHOP,BU_BUSINESS_GetGoodsTypeList,@""]
                         head:nil
                       method:@"POST"
                        async:YES
              inputInvocation:input
             outputInvocation:BSGetInvocationFromSel(self, @selector(getGoodsTypeListOutput:ok:input:))
                     observer:observer
                       action:callback
                    extraInfo:extraInfo];
     
}


-(NSData *)getGoodsTypeListInput:(NSString*)ID
{
     NSString *request = [NSString stringWithFormat:@"id=%@&%@",ID,[self getBaseUrlParem]];
     return [request dataUsingEncoding:NSUTF8StringEncoding];
     
}

-(NSError *)getGoodsTypeListOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input

{
     UNPACKETOUTPUTHEAD(recvData, ok);
     _goodsTypeList = nil;
     [(BSJSON *)jsonObj deserializationSpecifityMap:self map:@{@"data":@"BUShopType,goodsTypeList"}];
     return SuccessedError;
     
}



-(BOOL)getServiceTypeList:(id)observer callback:(SEL)callback
{
     return [self getServiceTypeList:observer callback:callback extraInfo:nil];
}

-(BOOL)getServiceTypeList:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo
{
     NSInvocation *input = BSGetInvocationFromSel(self, @selector(getServiceTypeListInput));
     [input retainArguments];
     return [self sendRequest:[NSString stringWithFormat:@"%@%@%@",BU_BUSINESS_DOMAIN_SERVICE,BU_BUSINESS_GetServiceTypeList,@""]
                         head:nil
                       method:@"POST"
                        async:YES
              inputInvocation:input
             outputInvocation:BSGetInvocationFromSel(self, @selector(getServiceTypeListOutput:ok:input:))
                     observer:observer
                       action:callback
                    extraInfo:extraInfo];
     
}


-(NSData *)getServiceTypeListInput
{
     NSString *request = [NSString stringWithFormat:@"%@",[self getBaseUrlParem]];
     return [request dataUsingEncoding:NSUTF8StringEncoding];
     
}

-(NSError *)getServiceTypeListOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input

{
     UNPACKETOUTPUTHEAD(recvData, ok);
     _serviceTypeList = nil;
     [(BSJSON *)jsonObj deserializationSpecifityMap:self map:@{@"data":@"BUShopType,serviceTypeList"}];
     return SuccessedError;
     
}



-(BOOL)getServiceInfo:(NSString *)ID  observer:(id)observer callback:(SEL)callback
{
     return [self getServiceInfo:ID  observer:observer callback:callback extraInfo:nil];
}

-(BOOL)getServiceInfo:(NSString *)ID  observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo
{
     NSInvocation *input = BSGetInvocationFromSel(self, @selector(getServiceInfoInput:));
     [input setArgument:&ID atIndex:2];
     [input retainArguments];
     return [self sendRequest:[NSString stringWithFormat:@"%@%@%@",BU_BUSINESS_DOMAIN_SERVICE,BU_BUSINESS_GetServiceInfo,@""]
                         head:nil
                       method:@"POST"
                        async:YES
              inputInvocation:input
             outputInvocation:BSGetInvocationFromSel(self, @selector(getServiceInfoOutput:ok:input:))
                     observer:observer
                       action:callback
                    extraInfo:extraInfo];
     
}


-(NSData *)getServiceInfoInput:(NSString*)ID
{
     NSString *request = [NSString stringWithFormat:@"id=%@&%@",ID,[self getBaseUrlParem]];
     return [request dataUsingEncoding:NSUTF8StringEncoding];
     
}

-(NSError *)getServiceInfoOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input

{
     UNPACKETOUTPUTHEAD(recvData, ok);
     _serviceInfo = nil;
     [(BSJSON *)jsonObj deserializationSpecifityMap:self map:@{@"data":@"BUServiceInfo,serviceInfo"}];
     return SuccessedError;
     
}



-(BOOL)addGoodsCollect:(NSString *)productId userId:(NSString *)userId   observer:(id)observer callback:(SEL)callback
{
     return [self addGoodsCollect:productId userId:userId   observer:observer callback:callback extraInfo:nil];
}

-(BOOL)addGoodsCollect:(NSString *)productId userId:(NSString *)userId    observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo
{
     NSInvocation *input = BSGetInvocationFromSel(self, @selector(addGoodsCollectInput:userId:));
     [input setArgument:&productId atIndex:2];
     [input setArgument:&userId atIndex:3];
     [input retainArguments];
     return [self sendRequest:[NSString stringWithFormat:@"%@%@%@",BU_BUSINESS_DOMAIN_PRODUCT,BU_BUSINESS_Collection,@""]
                         head:nil
                       method:@"POST"
                        async:YES
              inputInvocation:input
             outputInvocation:BSGetInvocationFromSel(self, @selector(addGoodsCollectOutput:ok:input:))
                     observer:observer
                       action:callback
                    extraInfo:extraInfo];
     
}


-(NSData *)addGoodsCollectInput:(NSString*)productId userId:(NSString *)userId
{
     NSString *request = [NSString stringWithFormat:@"userId=%@&productId=%@&%@",userId,productId ,[self getBaseUrlParem]];
     return [request dataUsingEncoding:NSUTF8StringEncoding];
     
}

-(NSError *)addGoodsCollectOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input

{
     UNPACKETOUTPUTHEAD(recvData, ok);
     //     _serviceInfo = nil;
     //     [(BSJSON *)jsonObj deserializationSpecifityMap:self map:@{@"data":@"BUServiceInfo,serviceInfo"}];
     return SuccessedError;
     
}



-(BOOL)getProductPrice:(NSString *)productId lease:(NSString *)lease productAttributeList:(NSMutableArray *)arr   observer:(id)observer callback:(SEL)callback
{
     return [self getProductPrice:productId lease:lease productAttributeList:(NSMutableArray *)arr  observer:observer callback:callback extraInfo:nil];
}

-(BOOL)getProductPrice:(NSString *)productId lease:(NSString *)lease productAttributeList:(NSMutableArray *)arr   observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo
{
     NSInvocation *input = BSGetInvocationFromSel(self, @selector(getProductPriceinput:lease:productAttributeList:));
     [input setArgument:&productId atIndex:2];
     [input setArgument:&lease atIndex:3];
     [input setArgument:&arr atIndex:4];
     [input retainArguments];
     NSDictionary *head = @{@"Content-Type":@"application/json"};
     return [self sendRequest:[NSString stringWithFormat:@"%@%@",BU_BUSINESS_DOMAIN_PRODUCT,BU_BUSINESS_GetProductPrice]
                         head:head
                       method:@"POST"
                        async:YES
              inputInvocation:input
             outputInvocation:BSGetInvocationFromSel(self, @selector(getProductPriceOutput:ok:input:))
                     observer:observer
                       action:callback
                    extraInfo:extraInfo];
     
}


-(NSData *)getProductPriceinput:(NSString*)productId lease:(NSString *)lease productAttributeList:(NSMutableArray *)arr
{
     BSJSON *j = [BSJSON new];
     [j setObject:productId forKey:@"productId"];
     [j setObject:arr forKey:@"productAttributeList"];
     [j setObject:@([lease integerValue]) forKey:@"lease"];
     NSDictionary *dic = [self getBaseUrlParemDic];
     [j setObject:dic[@"appId"] forKey:@"appId"];
     [j setObject:dic[@"timeStamp"] forKey:@"timeStamp"];
     [j setObject:dic[@"nonce"] forKey:@"nonce"];
     [j setObject:dic[@"sign"] forKey:@"sign"];
     NSString *request = [j serializationHelper];
//     request = [NSString stringWithFormat:@"value=%@",request];
     return [request dataUsingEncoding:NSUTF8StringEncoding];
     
}

-(NSError *)getProductPriceOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input

{
     UNPACKETOUTPUTHEAD(recvData, ok);
     _productPrice = nil;
     [(BSJSON *)jsonObj deserializationSpecifityMap:self map:@{@"data":@"BUProductPrice,productPrice"}];
     return SuccessedError;
     
}



-(BOOL)getPayMoney:(NSString *)productId couponId:(NSString *)couponId  lease:(NSString *)lease  costMoney:(NSString *)costMoney  price:(NSString *)price   observer:(id)observer callback:(SEL)callback
{
     return [self getPayMoney:productId couponId:couponId  lease:lease  costMoney:costMoney  price:price  observer:observer callback:callback extraInfo:nil];
}

-(BOOL)getPayMoney:(NSString *)productId couponId:(NSString *)couponId  lease:(NSString *)lease  costMoney:(NSString *)costMoney  price:(NSString *)price   observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo
{
     NSInvocation *input = BSGetInvocationFromSel(self, @selector(getPayMoneyInput:couponId:lease:costMoney:price:));
     [input setArgument:&productId atIndex:2];
     [input setArgument:&couponId atIndex:3];
     [input setArgument:&lease atIndex:4];
     [input setArgument:&costMoney atIndex:5];
     [input setArgument:&price atIndex:6];
     [input retainArguments];
     return [self sendRequest:[NSString stringWithFormat:@"%@%@%@",BU_BUSINESS_DOMAIN_PRODUCT,BU_BUSINESS_GetPayMoney,@""]
                         head:nil
                       method:@"POST"
                        async:YES
              inputInvocation:input
             outputInvocation:BSGetInvocationFromSel(self, @selector(getPayMoneyOutput:ok:input:))
                     observer:observer
                       action:callback
                    extraInfo:extraInfo];
     
}


-(NSData *)getPayMoneyInput:(NSString*)productId couponId:(NSString *)couponId  lease:(NSString *)lease  costMoney:(NSString *)costMoney  price:(NSString *)price
{
     NSString *request = [NSString stringWithFormat:@"userId=%@&productId=%@&couponId=%@&lease=%@&costMoney=%@&price=%@&%@",busiSystem.agent.userId?:@"",productId ,couponId,lease,costMoney,price,[self getBaseUrlParem]];
     return [request dataUsingEncoding:NSUTF8StringEncoding];
     
}

-(NSError *)getPayMoneyOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input

{
     UNPACKETOUTPUTHEAD(recvData, ok);
     _getPayMoney = nil;
     [(BSJSON *)jsonObj deserializationSpecifityMap:self map:@{@"data":@"BUGetPayMoney,getPayMoney"}];
     return SuccessedError;
     
}



-(BOOL)submitOrder:(NSString *)productId receiveAddressId:(NSString *)receiveAddressId  productItemId:(NSString *)productItemId  productItemPriceId:(NSString *)productItemPriceId  couponLogId:(NSString *)couponLogId  note:(NSString *)note  defineStartTime:(NSString *)defineStartTime  defineEndTime:(NSString *)defineEndTime   observer:(id)observer callback:(SEL)callback
{
     return [self submitOrder:productId receiveAddressId:receiveAddressId  productItemId:productItemId  productItemPriceId:productItemPriceId  couponLogId:couponLogId  note:note  defineStartTime:defineStartTime  defineEndTime:defineEndTime  observer:observer callback:callback extraInfo:nil];
}

-(BOOL)submitOrder:(NSString *)productId receiveAddressId:(NSString *)receiveAddressId  productItemId:(NSString *)productItemId  productItemPriceId:(NSString *)productItemPriceId  couponLogId:(NSString *)couponLogId  note:(NSString *)note  defineStartTime:(NSString *)defineStartTime  defineEndTime:(NSString *)defineEndTime   observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo
{
     NSInvocation *input = BSGetInvocationFromSel(self, @selector(submitOrderInput:receiveAddressId:productItemId:productItemPriceId:couponLogId:note:defineStartTime:defineEndTime:));
     [input setArgument:&productId atIndex:2];
     [input setArgument:&receiveAddressId atIndex:3];
     [input setArgument:&productItemId atIndex:4];
     [input setArgument:&productItemPriceId atIndex:5];
     [input setArgument:&couponLogId atIndex:6];
     [input setArgument:&note atIndex:7];
     [input setArgument:&defineStartTime atIndex:8];
     [input setArgument:&defineEndTime atIndex:9];
     [input retainArguments];
     return [self sendRequest:[NSString stringWithFormat:@"%@%@%@",BU_BUSINESS_DOMAIN_PRODUCT,BU_BUSINESS_SubmitOrder,@""]
                         head:nil
                       method:@"POST"
                        async:YES
              inputInvocation:input
             outputInvocation:BSGetInvocationFromSel(self, @selector(submitOrderOutput:ok:input:))
                     observer:observer
                       action:callback
                    extraInfo:extraInfo];
     
}


-(NSData *)submitOrderInput:(NSString*)productId receiveAddressId:(NSString *)receiveAddressId  productItemId:(NSString *)productItemId  productItemPriceId:(NSString *)productItemPriceId  couponLogId:(NSString *)couponLogId  note:(NSString *)note  defineStartTime:(NSString *)defineStartTime  defineEndTime:(NSString *)defineEndTime
{
     NSString *request = [NSString stringWithFormat:@"userId=%@&productId=%@&receiveAddressId=%@&productItemId=%@&productItemPriceId=%@&couponLogId=%@&note=%@&defineStartTime=%@&defineEndTime=%@&%@",busiSystem.agent.userId?:@"",productId ,receiveAddressId,productItemId,productItemPriceId,couponLogId,note,defineStartTime,defineEndTime,[self getBaseUrlParem]];
     return [request dataUsingEncoding:NSUTF8StringEncoding];
     
}

-(NSError *)submitOrderOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input

{
     UNPACKETOUTPUTHEAD(recvData, ok);
     _submitOrder = nil;
     [(BSJSON *)jsonObj deserializationSpecifityMap:self map:@{@"data":@"BUSubmitOrder,submitOrder"}];
     return SuccessedError;
     
}


-(BOOL)OrderCoupon:(NSString *)productId observer:(id)observer callback:(SEL)callback
{
     return [self OrderCoupon:productId observer:observer callback:callback extraInfo:nil];
}

-(BOOL)OrderCoupon:(NSString *)productId observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo
{
     NSInvocation *input = BSGetInvocationFromSel(self, @selector(OrderCouponInput:));
     [input setArgument:&productId atIndex:2];
//     [input setArgument:&couponId atIndex:3];
//     [input setArgument:&lease atIndex:4];
//     [input setArgument:&costMoney atIndex:5];
//     [input setArgument:&price atIndex:6];
     [input retainArguments];
     return [self sendRequest:[NSString stringWithFormat:@"%@%@%@",BU_BUSINESS_DOMAIN_PRODUCT,BU_BUSINESS_OrderCoupon,@""]
                         head:nil
                       method:@"POST"
                        async:YES
              inputInvocation:input
             outputInvocation:BSGetInvocationFromSel(self, @selector(OrderCouponOutput:ok:input:))
                     observer:observer
                       action:callback
                    extraInfo:extraInfo];
     
}


-(NSData *)OrderCouponInput:(NSString*)productId
{
     NSString *request = [NSString stringWithFormat:@"userId=%@&proId=%@&%@",busiSystem.agent.userId?:@"",productId,[self getBaseUrlParem]];
     return [request dataUsingEncoding:NSUTF8StringEncoding];
     
}

-(NSError *)OrderCouponOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input

{
     UNPACKETOUTPUTHEAD(recvData, ok);
     _couponList = nil;
     [(BSJSON *)jsonObj deserializationSpecifityMap:self map:@{@"data":@"BUOrderCoupon,couponList"}];
     return SuccessedError;
     
}

@end
