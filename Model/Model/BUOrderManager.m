//
//  BUOrderManager.m
//  supermarket
//
//  Created by Steve on 2017/11/10.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import "BUOrderManager.h"
#import "BUSystem.h"
@implementation BUProInfo
-(id)init
{
     self = [super init];
     if(self){
          self.deserializationMap = @{@"BUImageRes":@"BUImageRes",@"proSubList":@"NSString,proSubList"};
     }
     return self;
}
-(NSDictionary *)getDic:(NSInteger)leaseType withQishu:(NSInteger)s
{
//
     NSString *qishu = @"天";

     if (leaseType == 0) {

          qishu = @"月";
     }
     NSMutableArray *arr = [NSMutableArray arrayWithArray:_proSubList];
 NSString *su = [NSString stringWithFormat:@"%ld%@",s,qishu];
     [arr addObject:su];
     return @{@"title":_productName?:@"",@"img":_img?:@"default",@"source":[NSString stringWithFormat:@""],@"time":[NSString stringWithFormat:@"商品价值：%@元",_productCostMoney],@"default":@"default",@"markArr":arr?:@[]};
}
@end

@implementation BUOthInfo
-(id)init
{
     self = [super init];
     if(self){
          self.deserializationMap = @{@"BUImageRes":@"BUImageRes"};
     }
     return self;
}
//-(NSDictionary *)getDic:(NSInteger)row{
//
//
//}
@end

@implementation BULeaseinfo
-(id)init
{
     self = [super init];
     if(self){
          self.deserializationMap = @{@"BUImageRes":@"BUImageRes"};
     }
     return self;
}
@end

@implementation BUBackType

@end


@implementation BUBackInfo
-(id)init
{
     self = [super init];
     if(self){
          self.deserializationMap = @{@"BUImageRes":@"BUImageRes",@"outOrderTrackItemModelList":@"BUTrackInfo,outOrderTrackItemModelList"};
     }
     return self;
}

-(NSDictionary *)getDic:(NSInteger)index{
     if (index == 0) {
          if (_outOrderTrackItemModelList.count == 1) {
               BUTrackInfo *t1 = _outOrderTrackItemModelList.firstObject;
               
               return @{@"aTitle":@"提交申请",@"bTitle":@"等待处理",@"aDetail":t1.createTime?:@"",@"bDetail":@"",@"aimg":@"done",@"bimg":@"unDone",@"check":@4,@"hMark":@"trace"};
          }else  if (_outOrderTrackItemModelList.count == 2) {
               BUTrackInfo *t2 = _outOrderTrackItemModelList.firstObject;
               BUTrackInfo *t1 = _outOrderTrackItemModelList.lastObject;
               NSString *title = @"处理完成";
               NSString *img = @"done";
               if (t2.orderTrackStatus == 2) {
                    title = @"拒绝退货";
                    img = @"unDone";
               }
               return @{@"aTitle":@"提交申请",@"bTitle":title,@"aDetail":t1.createTime?:@"",@"bDetail":t2.createTime?:@"",@"aimg":@"done",@"bimg":img,@"check":@4,@"hMark":@"trace"};
          }
          
     }
     else if (index == 1){
          NSString *title = [NSString stringWithFormat:@"服务单号：%@",_orderBackNO];
          NSString *detail = [NSString stringWithFormat:@"申请时间：%@",_createTime];
          return  @{@"title":title,@"detail":detail};
     }
     else if (index == 2){
          BUTrackInfo *t = _outOrderTrackItemModelList.firstObject;
          return @{@"img":@"check",@"title":t.name?:@""};
     }
    
     return @{};
}
@end

@implementation BUTrackInfo
-(NSDictionary *)getDic:(NSInteger)index{
     if (index == 0) {
          return @{@"title":_name?:@"",@"detail":_createTime?:@""};
     }
     else if(index == 2){
          return @{@"title":_name?:@"",@"detail":_createTime?:@"",@"detail2":@"",@"isCheck":@YES};
     }
     else if(index == 3){
          return @{@"title":_name?:@"",@"detail":_createTime?:@"",@"detail2":@"",@"isCheck":@NO};
     }
     return @{};
}
@end

@implementation BUTrack
-(id)init
{
     self = [super init];
     if(self){
          self.deserializationMap = @{@"BUImageRes":@"BUImageRes",@"outOrderTrackItemModelList":@"BUTrackInfo,outOrderTrackItemModelList"};
     }
     return self;
}

-(NSDictionary *)getDic:(NSInteger)index{
     if (index == 0) {
          NSString *title = [NSString stringWithFormat:@"配送员：%@",_deliveryUserName];
          NSString *source = [NSString stringWithFormat:@"订单号：%@",_orderNO];
          NSString *time = [NSString stringWithFormat:@"联系电话：%@",_deliveryTel];
          NSString *cout = [NSString stringWithFormat:@"%ld件商品",(long)_quantity];
          return @{@"title":title,@"source":source,@"time":time,@"count":cout,@"default":@"default"};
     }
     else if (index == 1){
          NSInteger state = _orderDeliveryStatus-1;
          return @{@"oneTitle":@"已接单",@"twoTitle":@"待配送",@"threeTitle":@"配送中",@"fourTitle":@"已签收",@"img":@"",@"himg":@"trace",@"mark":@"traceB",@"hMark":@"traceA",@"title":@"",@"detail":@"",@"check":@(state)};
     }
     return @{};
}
@end

@implementation BUOrderDetail
-(id)init
{
     self = [super init];
     if(self){
          self.deserializationMap = @{@"BUImageRes":@"BUImageRes",@"subStr":@"NSString,subStr",@"leaseinfo":@"BULeaseinfo,leaseinfo",@"othInfo":@"BUOthInfo,othInfo",@"proInfo":@"BUProInfo,proInfo"};
     }
     return self;
}
@end

@implementation BUSubmitCart

@end

@implementation BUAddress
-(NSDictionary *)getDic:(NSInteger)index{
     if (index==0) {
          NSString *tell = @"";
          if (_mobile.length == 11) {
               tell = [_mobile stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
          }
          NSString *title = [NSString stringWithFormat:@"%@ %@",_delName,tell];
          NSString *address = [NSString stringWithFormat:@"%@%@",_delAddress,_delBuildingNo];
          return @{@"title":title,@"time":address};
     }
     else  if (index==1) {
          NSString *tell = @"";
          if (_mobile.length == 11) {
               tell = [_mobile stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
          }
          NSString *title = [NSString stringWithFormat:@"%@ %@",_delName,tell];
          NSString *address = [NSString stringWithFormat:@"%@%@",_delAddress,_delBuildingNo];
          return @{@"title":address,@"source":title};
     }
     return @{};
}
-(NSDictionary *)getDic
{
     NSString *tell = @"";
     if (_mobile.length == 11) {
          tell = [_mobile stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
     }
     return   @{@"name":[NSString stringWithFormat:@"%@",_delName],@"phone":tell,@"address":_delAddress?:@""};
}
@end


@implementation BUCartInfo
-(id)init
{
     self = [super init];
     if(self){
          self.deserializationMap = @{@"usableShoppingCartList":@"BUCartSumPrice,usableShoppingCartList",@"notInShoppingCartList":@"BUCartSumPrice,notInShoppingCartList",@"failureGoodsList":@"BUCartGoods,failureGoodsList"};
     }
     return self;
}
@end

@implementation BUCoupon
//-(id)init
//{
//     self = [super init];
//     if(self){
//          self.deserializationMap = @{@"BUImageRes":@"BUImageRes",@"outShoppingCartProductList":@"BUCartGoods:outShoppingCartProductList"};
//     }
//     return self;
//}
-(NSDictionary *)getDic:(NSInteger)index{
     if (index == 0) {
          NSString *price = [NSString stringWithFormat:@"¥%.2f",_cPrice];
          if (_cPrice == (int)_cPrice) {
               price = [NSString stringWithFormat:@"¥%d",(int)_cPrice];
          }else if((int)(_cPrice*100)%10 ==0){
               price = [NSString stringWithFormat:@"¥%.1f",_cPrice];
          }
          NSString *bTitle;
          if (_cThreshold <= 0) {
               bTitle = @"无限制";
          }else{
               bTitle = [NSString stringWithFormat:@"满%d元可用",(int)_cThreshold];
          }
          NSString *dTitle = [NSString stringWithFormat:@"适用平台：%@",_cScope==0?@"全平台":_cScope==1?@"指定商品":@"指定分类"];
          NSString *eTitle = [NSString stringWithFormat:@"有效期至：%@",_validTime];
          return  @{@"aTitle":price,@"bTitle":bTitle,@"cTitle":_cTitle?:@"",@"dTitle":dTitle,@"eTitle":eTitle,@"bgImg":@"couponBg"};
     }else if(index == 1){
          NSString *price = [NSString stringWithFormat:@"¥%.2f",_cPrice];
          if (_cPrice == (int)_cPrice) {
               price = [NSString stringWithFormat:@"¥%d",(int)_cPrice];
          }else if((int)(_cPrice*100)%10 ==0){
               price = [NSString stringWithFormat:@"¥%.1f",_cPrice];
          }
          NSString *bTitle;
          if (_cThreshold <= 0) {
               bTitle = @"无限制";
          }else{
               bTitle = [NSString stringWithFormat:@"满%d元可用",(int)_cThreshold];
          }
          NSString *dTitle = [NSString stringWithFormat:@"适用平台：%@",_cScope==0?@"全平台":_cScope==1?@"指定商品":@"指定分类"];
          NSString *eTitle = [NSString stringWithFormat:@"有效期至：%@",_validTime];
          NSString *markImg = @"couponPassed";
//          if (<#condition#>) {
//               markImg = @"couponUsed";
//          }
          return  @{@"aTitle":price,@"bTitle":bTitle,@"cTitle":_cTitle?:@"",@"dTitle":dTitle,@"eTitle":eTitle,@"bgImg":@"couponBg"};
     }
     return @{};
}
@end

@implementation BUCartItem
-(id)init
{
     self = [super init];
     if(self){
          self.deserializationMap = @{@"BUImageRes":@"BUImageRes",@"outShoppingCartProductList":@"BUCartGoods,outShoppingCartProductList"};
     }
     return self;
}
@end


@implementation BUCartSumPrice
-(id)init
{
     self = [super init];
     if(self){
          self.deserializationMap = @{@"BUImageRes":@"BUImageRes",@"usableShoppingCartItemList":@"BUCartGoods,dataArr",@"notInShoppingCartItemList":@"BUCartGoods,dataArr"};
     }
     return self;
}
-(NSDictionary *)getDic:(NSInteger)index{
     if (index ==0 ) {
          NSString *str = @"";
          if (_distriMoney == 0) {
               str = @"免配送费";
          }else{
               str = [NSString stringWithFormat:@"满%.2f元免配送费",_distriMoney];
          }
          return @{@"title":_sName?:@"",@"detail":str};
     }
     else if (index == 1){
          NSString *price = [NSString stringWithFormat:@"¥%.2f",_sumPrice];
          NSString *str = @"";
//          if (_sumPrice < _distriMoney) {
//               str = [NSString stringWithFormat:@"另需配送费¥%.2f",_shippingMoney];
//          }
          return @{@"title":@"合计:",@"source":price,@"time":str};
     }
     return @{};
}

-(void)setAllSel{
     _isAllSelected = !_isAllSelected;
     _sumPrice = 0.0;
     [_dataArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
          BUCartGoods *g = obj;
          g.isSelected = _isAllSelected;
          if (g.isSelected) {
               _sumPrice += g.proPrice;
          }
     }];
}
@end

@implementation BUCartGoods
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
          NSString *price = [NSString stringWithFormat:@"¥%.2f",_proPrice];
          NSString *quantity = [NSString stringWithFormat:@"%ld",(long)_quantity];
          return @{@"title":_proName?:@"",@"type":@"",@"price":price,@"num":quantity,@"img":_pDefImg?:@"",@"default":@"default"};
     }else if(index == 1){
          NSString *quantity = [NSString stringWithFormat:@"x%ld",(long)_quantity];
          return @{@"title":_proName?:@"",@"source":quantity,@"img":_pDefImg?:@"",@"default":@"default"};
     }
     else if (index == 2){
          NSString *quantity = [NSString stringWithFormat:@"x%ld",(long)_quantity];
          NSString *price = [NSString stringWithFormat:@"¥%.2f",_proPrice];
          return  @{@"title":_proName?:@"",@"source":_attr?:@"",@"time":price,@"img":_pDefImg?:@"",@"default":@"default",@"num":quantity};
     }
     return @{};
}
@end

@implementation BUOrderManager
-(BOOL)addShoppingCart:(NSString *)productId storeId:(NSString *)storeId withProCount:(NSInteger)proCount userId:(NSString *)userId  observer:(id)observer callback:(SEL)callback
{
     return [self addShoppingCart:productId storeId:storeId  userId:userId  withProCount:(NSInteger)proCount  observer:observer callback:callback extraInfo:nil];
}



-(BOOL)addShoppingCart:(NSString *)productId storeId:(NSString *)storeId  userId:(NSString *)userId withProCount:(NSInteger)proCount  observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo
{
     NSString *proCountStr = [NSString stringWithFormat:@"%ld",(long)proCount];
     NSInvocation *input = BSGetInvocationFromSel(self, @selector(addShoppingCartInput:storeId:userId:withProCount:));
     [input setArgument:&productId atIndex:2];
     [input setArgument:&storeId atIndex:3];
     [input setArgument:&userId atIndex:4];
     [input setArgument:&proCountStr atIndex:5];
     [input retainArguments];
     return [self sendRequest:[NSString stringWithFormat:@"%@%@",BU_BUSINESS_DOMAIN_ORDER,BU_BUSINESS_AddShoppingCart]
                         head:nil
                       method:@"POST"
                        async:YES
              inputInvocation:input
             outputInvocation:BSGetInvocationFromSel(self, @selector(addShoppingCartOutput:ok:input:))
                     observer:observer
                       action:callback
                    extraInfo:extraInfo];
     
}


-(NSData *)addShoppingCartInput:(NSString *)productId storeId:(NSString *)storeId  userId:(NSString *)userId withProCount:(NSString *)proCount
{
     NSString *request = [NSString stringWithFormat:@"proId=%@&storeId=%@&userId=%@&%@&proCount=%@",productId,storeId,userId,[self getBaseUrlParem],proCount];
     return [request dataUsingEncoding:NSUTF8StringEncoding];
     
}

-(NSError *)addShoppingCartOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input

{
     UNPACKETOUTPUTHEAD(recvData, ok);
     //     _productDetail = nil;
     //     [(BSJSON *)jsonObj deserializationSpecifityMap:self map:@{@"data":@"BUProductDetail,productDetail"}];
     return SuccessedError;
     
}



-(BOOL)getShoppingCartList:(NSString *)userId log:(NSString *)log lat:(NSString *)lat   observer:(id)observer callback:(SEL)callback
{
     return [self getShoppingCartList:userId log:log lat:lat  observer:observer callback:callback extraInfo:nil];
}



-(BOOL)getShoppingCartList:(NSString *)userId log:(NSString *)log lat:(NSString *)lat  observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo
{
    
     NSInvocation *input = BSGetInvocationFromSel(self, @selector(getShoppingCartListInput:log:lat:));
     [input setArgument:&userId atIndex:2];
     [input setArgument:&log atIndex:3];
     [input setArgument:&lat atIndex:4];
     [input retainArguments];
     return [self sendRequest:[NSString stringWithFormat:@"%@%@",BU_BUSINESS_DOMAIN_ORDER,BU_BUSINESS_GetShoppingCartList]
                         head:nil
                       method:@"POST"
                        async:YES
              inputInvocation:input
             outputInvocation:BSGetInvocationFromSel(self, @selector(getShoppingCartListOutput:ok:input:))
                     observer:observer
                       action:callback
                    extraInfo:extraInfo];
     
}


-(NSData *)getShoppingCartListInput:(NSString *)userId log:(NSString *)log lat:(NSString *)lat
{
     NSString *request = [NSString stringWithFormat:@"userId=%@&log=%@&lat=%@&%@",userId,log,lat,[self getBaseUrlParem]];
     return [request dataUsingEncoding:NSUTF8StringEncoding];
     
}

-(NSError *)getShoppingCartListOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input

{
     UNPACKETOUTPUTHEAD(recvData, ok);
     _cartInfo = nil;
     [(BSJSON *)jsonObj deserializationSpecifityMap:self map:@{@"data":@"BUCartInfo,cartInfo"}];
     return SuccessedError;
     
}


-(BOOL)getShoppingCartCount:(NSString *)userId log:(NSString *)log lat:(NSString *)lat   observer:(id)observer callback:(SEL)callback
{
     return [self getShoppingCartCount:userId log:log lat:lat  observer:observer callback:callback extraInfo:nil];
}



-(BOOL)getShoppingCartCount:(NSString *)userId log:(NSString *)log lat:(NSString *)lat  observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo
{
     
     NSInvocation *input = BSGetInvocationFromSel(self, @selector(getShoppingCartCountInput:log:lat:));
     [input setArgument:&userId atIndex:2];
     [input setArgument:&log atIndex:3];
     [input setArgument:&lat atIndex:4];
     [input retainArguments];
     return [self sendRequest:[NSString stringWithFormat:@"%@%@",BU_BUSINESS_DOMAIN_ORDER,BU_BUSINESS_GetShoppingCartCount]
                         head:nil
                       method:@"POST"
                        async:YES
              inputInvocation:input
             outputInvocation:BSGetInvocationFromSel(self, @selector(getShoppingCartCountOutput:ok:input:))
                     observer:observer
                       action:callback
                    extraInfo:extraInfo];
     
}


-(NSData *)getShoppingCartCountInput:(NSString *)userId log:(NSString *)log lat:(NSString *)lat
{
     NSString *request = [NSString stringWithFormat:@"userId=%@&log=%@&lat=%@&%@",userId,log,lat,[self getBaseUrlParem]];
     return [request dataUsingEncoding:NSUTF8StringEncoding];
     
}

-(NSError *)getShoppingCartCountOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input

{
     UNPACKETOUTPUTHEAD(recvData, ok);
     _cartCount = [[jsonObj objectForKey:@"data"] integerValue];
     return SuccessedError;
     
}



-(BOOL)shoppingCartDelBatch:(NSMutableArray *)arr  observer:(id)observer callback:(SEL)callback
{
     return [self shoppingCartDelBatch:arr  observer:observer callback:callback extraInfo:nil];
}



-(BOOL)shoppingCartDelBatch:(NSMutableArray *)arr  observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo
{
     
     NSInvocation *input = BSGetInvocationFromSel(self, @selector(shoppingCartDelBatchInput:));
     [input setArgument:&arr atIndex:2];
     [input retainArguments];
//     NSDictionary *head = @{@"Content-Type":@"application/json"};
     return [self sendRequest:[NSString stringWithFormat:@"%@%@",BU_BUSINESS_DOMAIN_USER,BU_BUSINESS_DelUserCart]
                         head:nil
                       method:@"POST"
                        async:YES
              inputInvocation:input
             outputInvocation:BSGetInvocationFromSel(self, @selector(shoppingCartDelBatchOutput:ok:input:))
                     observer:observer
                       action:callback
                    extraInfo:extraInfo];
     
}


-(NSData *)shoppingCartDelBatchInput:(NSMutableArray *)arr
{
     __block NSString *ID = @"";
     [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
          if (idx == 0) {
               ID = obj;
          }else{
               ID = [NSString stringWithFormat:@"%@,%@",ID,obj];
          }
     }];
     NSString *request = [NSString stringWithFormat:@"id=%@&userId=%@&%@",ID,busiSystem.agent.userId,[self getBaseUrlParem]];
     return [request dataUsingEncoding:NSUTF8StringEncoding];
     
}

-(NSError *)shoppingCartDelBatchOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input

{
     UNPACKETOUTPUTHEAD(recvData, ok);
//     _cartInfo = nil;
//     [(BSJSON *)jsonObj deserializationSpecifityMap:self map:@{@"data":@"BUCartInfo,cartInfo"}];
     return SuccessedError;
     
}




-(BOOL)getShoppingCartItem:(NSString *)userId productIdQuantityList:(NSArray *)productIdQuantityList storeId:(NSString *)storeId   observer:(id)observer callback:(SEL)callback
{
     return [self getShoppingCartItem:userId productIdQuantityList:productIdQuantityList storeId:storeId observer:observer callback:callback extraInfo:nil];
}



-(BOOL)getShoppingCartItem:(NSString *)userId productIdQuantityList:(NSArray *)productIdQuantityList storeId:(NSString *)storeId observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo
{
     
     NSInvocation *input = BSGetInvocationFromSel(self, @selector(getShoppingCartItemInput:productIdQuantityList:storeId:));
     [input setArgument:&userId atIndex:2];
     [input setArgument:&productIdQuantityList atIndex:3];
     [input setArgument:&storeId atIndex:4];
     [input retainArguments];
      NSDictionary *head = @{@"Content-Type":@"application/json"};
     return [self sendRequest:[NSString stringWithFormat:@"%@%@",BU_BUSINESS_DOMAIN_ORDER,BU_BUSINESS_GetShoppingCartItem]
                         head:head
                       method:@"POST"
                        async:YES
              inputInvocation:input
             outputInvocation:BSGetInvocationFromSel(self, @selector(getShoppingCartItemOutput:ok:input:))
                     observer:observer
                       action:callback
                    extraInfo:extraInfo];
     
}


-(NSData *)getShoppingCartItemInput:(NSString *)userId productIdQuantityList:(NSArray *)productIdQuantityList storeId:(NSString *)storeId
{
     /*
      productIdQuantityList  BSJson
      InProductIdQuantityModel {
      productId (string): 购物车明细编号 stringMin. Length:32Max. Length:32,
      quantity (integer, optional): 商品数量
      }
      */
     BSJSON *json = [BSJSON new];
     [json setObject:productIdQuantityList forKey:@"productIdQuantityList"];
      [json setObject:userId forKey:@"userId"];
      [json setObject:storeId forKey:@"storeId"];
     NSDictionary *dic = [self getBaseUrlParemDic];
     [json setObject:dic[@"appId"] forKey:@"appId"];
     [json setObject:dic[@"timeStamp"] forKey:@"timeStamp"];
     [json setObject:dic[@"nonce"] forKey:@"nonce"];
     [json setObject:dic[@"sign"] forKey:@"sign"];
     NSString *request = [json serializationHelper];
     return [request dataUsingEncoding:NSUTF8StringEncoding];
     
}

-(NSError *)getShoppingCartItemOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input

{
     UNPACKETOUTPUTHEAD(recvData, ok);
     _cartItem = nil;
     [(BSJSON *)jsonObj deserializationSpecifityMap:self map:@{@"data":@"BUCartItem,cartItem"}];
     return SuccessedError;
     
}


-(BOOL)getCouponList:(NSString *)userId productIdQuantityList:(NSArray *)productIdQuantityList storeId:(NSString *)storeId type:(NSString *)type  observer:(id)observer callback:(SEL)callback
{
     return [self getCouponList:userId productIdQuantityList:productIdQuantityList storeId:storeId type:type observer:observer callback:callback extraInfo:nil];
}



-(BOOL)getCouponList:(NSString *)userId productIdQuantityList:(NSArray *)productIdQuantityList storeId:(NSString *)storeId type:(NSString *)type observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo
{
     
     NSInvocation *input = BSGetInvocationFromSel(self, @selector(getCouponListInput:productIdQuantityList:storeId:type:));
     [input setArgument:&userId atIndex:2];
     [input setArgument:&productIdQuantityList atIndex:3];
     [input setArgument:&storeId atIndex:4];
     [input setArgument:&type atIndex:5];
     [input retainArguments];
     NSDictionary *head = @{@"Content-Type":@"application/json"};
     if ([type integerValue] == 1) {
          return [self sendRequest:[NSString stringWithFormat:@"%@%@",BU_BUSINESS_DOMAIN_ORDER,BU_BUSINESS_GetCouponList]
                              head:head
                            method:@"POST"
                             async:YES
                   inputInvocation:input
                  outputInvocation:BSGetInvocationFromSel(self, @selector(getCouponListAOutput:ok:input:))
                          observer:observer
                            action:callback
                         extraInfo:extraInfo];
     }else{
          return [self sendRequest:[NSString stringWithFormat:@"%@%@",BU_BUSINESS_DOMAIN_ORDER,BU_BUSINESS_GetCouponList]
                              head:head
                            method:@"POST"
                             async:YES
                   inputInvocation:input
                  outputInvocation:BSGetInvocationFromSel(self, @selector(getCouponListOutput:ok:input:))
                          observer:observer
                            action:callback
                         extraInfo:extraInfo];
     }
    
     
}


-(NSData *)getCouponListInput:(NSString *)userId productIdQuantityList:(NSArray *)productIdQuantityList storeId:(NSString *)storeId type:(NSString *)type
{
     /*
      productIdQuantityList  BSJson
      InProductIdQuantityModel {
      productId (string): 购物车明细编号 stringMin. Length:32Max. Length:32,
      quantity (integer, optional): 商品数量
      }
      */
     BSJSON *json = [BSJSON new];
     [json setObject:productIdQuantityList forKey:@"productIdQuantityList"];
     [json setObject:userId forKey:@"userId"];
     [json setObject:storeId forKey:@"storeId"];
      [json setObject:@([type intValue]) forKey:@"type"];
     NSDictionary *dic = [self getBaseUrlParemDic];
     [json setObject:dic[@"appId"] forKey:@"appId"];
     [json setObject:dic[@"timeStamp"] forKey:@"timeStamp"];
     [json setObject:dic[@"nonce"] forKey:@"nonce"];
     [json setObject:dic[@"sign"] forKey:@"sign"];
     NSString *request = [json serializationHelper];
     return [request dataUsingEncoding:NSUTF8StringEncoding];
     
}

-(NSError *)getCouponListOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input

{
     UNPACKETOUTPUTHEAD(recvData, ok);
     _couponList = nil;
     [(BSJSON *)jsonObj deserializationSpecifityMap:self map:@{@"data":@"BUCoupon,couponList"}];
     return SuccessedError;
     
}

-(NSError *)getCouponListAOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input

{
     UNPACKETOUTPUTHEAD(recvData, ok);
     _couponUnUseList = nil;
     [(BSJSON *)jsonObj deserializationSpecifityMap:self map:@{@"data":@"BUCoupon,couponUnUseList"}];
     return SuccessedError;
     
}


//-(BOOL)getDeliveryAddress:(NSString *)userId observer:(id)observer callback:(SEL)callback
//{
//     return [self getDeliveryAddress:userId  observer:observer callback:callback extraInfo:nil];
//}
//
//
//
//-(BOOL)getDeliveryAddress:(NSString *)userId  observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo
//{
//     
//     NSInvocation *input = BSGetInvocationFromSel(self, @selector(getDeliveryAddressInput:));
//     [input setArgument:&userId atIndex:2];
//     [input retainArguments];
//     return [self sendRequest:[NSString stringWithFormat:@"%@%@",BU_BUSINESS_DOMAIN_USER,BU_BUSINESS_GetDeliveryAddress]
//                         head:nil
//                       method:@"POST"
//                        async:YES
//              inputInvocation:input
//             outputInvocation:BSGetInvocationFromSel(self, @selector(getDeliveryAddressOutput:ok:input:))
//                     observer:observer
//                       action:callback
//                    extraInfo:extraInfo];
//     
//}
//
//
//-(NSData *)getDeliveryAddressInput:(NSString *)userId
//{
//     NSString *request = [NSString stringWithFormat:@"userId=%@&%@",userId,[self getBaseUrlParem]];
//     return [request dataUsingEncoding:NSUTF8StringEncoding];
//     
//}
//
//-(NSError *)getDeliveryAddressOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input
//
//{
//     UNPACKETOUTPUTHEAD(recvData, ok);
//     _addressList = nil;
//     [(BSJSON *)jsonObj deserializationSpecifityMap:self map:@{@"data":@"BUAddress,addressList"}];
//     return SuccessedError;
//     
//}


-(BOOL)submitShoppingCart:(NSString *)userId deliveryAddressId:(NSString *)deliveryAddressId payPrice:(NSString *)payPrice couponLogId:(NSString *)couponLogId isInvoice:(NSString*)isInvoice invoiceModel:(BSJSON *)invoiceModel storeId:(NSString *)storeId  productIdQuantityList:(NSArray *)productIdQuantityList observer:(id)observer callback:(SEL)callback
{
     return [self submitShoppingCart:userId deliveryAddressId:deliveryAddressId payPrice:payPrice couponLogId:(NSString *)couponLogId isInvoice:isInvoice invoiceModel:invoiceModel storeId:storeId productIdQuantityList:productIdQuantityList observer:observer callback:callback extraInfo:nil];
}



-(BOOL)submitShoppingCart:(NSString *)userId  deliveryAddressId:(NSString *)deliveryAddressId payPrice:(NSString *)payPrice couponLogId:(NSString *)couponLogId isInvoice:(NSString*)isInvoice invoiceModel:(BSJSON *)invoiceModel storeId:(NSString *)storeId productIdQuantityList:(NSArray *)productIdQuantityList observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo
{
     
     NSInvocation *input = BSGetInvocationFromSel(self, @selector(gsubmitShoppingCartInput:deliveryAddressId:payPrice:couponLogId:isInvoice:invoiceModel:storeId:productIdQuantityList:));
     [input setArgument:&userId atIndex:2];
     [input setArgument:&deliveryAddressId atIndex:3];
     [input setArgument:&payPrice atIndex:4];
     [input setArgument:&couponLogId atIndex:5];
     [input setArgument:&isInvoice atIndex:6];
     [input setArgument:&invoiceModel atIndex:7];
     [input setArgument:&storeId atIndex:8];
     [input setArgument:&productIdQuantityList atIndex:9];
     [input retainArguments];
     NSDictionary *head = @{@"Content-Type":@"application/json"};
     return [self sendRequest:[NSString stringWithFormat:@"%@%@",BU_BUSINESS_DOMAIN_ORDER,BU_BUSINESS_SubmitShoppingCart]
                         head:head
                       method:@"POST"
                        async:YES
              inputInvocation:input
             outputInvocation:BSGetInvocationFromSel(self, @selector(submitShoppingCartOutput:ok:input:))
                     observer:observer
                       action:callback
                    extraInfo:extraInfo];
     
}


-(NSData *)gsubmitShoppingCartInput:(NSString *)userId  deliveryAddressId:(NSString *)deliveryAddressId payPrice:(NSString *)payPrice couponLogId:(NSString *)couponLogId isInvoice:(NSString*)isInvoice invoiceModel:(BSJSON *)invoiceModel storeId:(NSString *)storeId productIdQuantityList:(NSArray *)productIdQuantityList
{
     /*
      deliveryAddressId (string): 商品编号 stringMin. Length:32Max. Length:32,
      payPrice (number, optional): 应付金额 ,
      couponLogId (string, optional): 优惠券编号 ,
      userId (string): 用户编号 stringMin. Length:32Max. Length:32,
      productIdQuantityList (Array[InProductIdQuantityModel]): 商品编号 ,
      isInvoice (boolean, optional): 是否开票 ,
      invoiceModel (InInvoiceModel, optional): 开票明细 ,
      storeId (string): 编号 stringMin. Length:32Max. Length:32,
      appId (string, optional): AppId ,
      timeStamp (string, optional): 时间戳 ,
      nonce (string, optional): 六位随机数 ,
      sign (string, optional): 签名 将AppId、TimeStamp、Nonce的值进行升序排序后组成字符串，加上AppSecret的值后进行MD5加密
      }
      */
     
     BSJSON *json = [BSJSON new];
      [json setObject:userId forKey:@"userId"];
     [json setObject:deliveryAddressId forKey:@"deliveryAddressId"];
     [json setObject:@([payPrice floatValue]) forKey:@"payPrice"];
     [json setObject:couponLogId forKey:@"couponLogId"];
     [json setObject:@([isInvoice boolValue]) forKey:@"isInvoice"];
     [json setObject:productIdQuantityList forKey:@"productIdQuantityList"];
     [json setObject:invoiceModel forKey:@"invoiceModel"];
     [json setObject:storeId forKey:@"storeId"];
     NSDictionary *dic = [self getBaseUrlParemDic];
     [json setObject:dic[@"appId"] forKey:@"appId"];
     [json setObject:dic[@"timeStamp"] forKey:@"timeStamp"];
     [json setObject:dic[@"nonce"] forKey:@"nonce"];
     [json setObject:dic[@"sign"] forKey:@"sign"];
     NSString *request = [json serializationHelper];
     return [request dataUsingEncoding:NSUTF8StringEncoding];
     
}

-(NSError *)submitShoppingCartOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input

{
     UNPACKETOUTPUTHEAD(recvData, ok);
     _submitCart = nil;
     [(BSJSON *)jsonObj deserializationSpecifityMap:self map:@{@"data":@"BUSubmitCart,submitCart"}];
     return SuccessedError;
     
}



-(BOOL)getMyOrderItemInfo:(NSString *)userId orderId:(NSString *)orderId observer:(id)observer callback:(SEL)callback
{
     return [self getMyOrderItemInfo:userId  orderId:orderId  observer:observer callback:callback extraInfo:nil];
}



-(BOOL)getMyOrderItemInfo:(NSString *)userId orderId:(NSString *)orderId   observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo
{
     
     NSInvocation *input = BSGetInvocationFromSel(self, @selector(getMyOrderItemInfoInput:orderId:));
     [input setArgument:&userId atIndex:2];
     [input setArgument:&orderId atIndex:3];
     [input retainArguments];
     return [self sendRequest:[NSString stringWithFormat:@"%@%@",BU_BUSINESS_DOMAIN_ORDER,BU_BUSINESS_GetMyOrderItemInfo]
                         head:nil
                       method:@"POST"
                        async:YES
              inputInvocation:input
             outputInvocation:BSGetInvocationFromSel(self, @selector(getMyOrderItemInfoOutput:ok:input:))
                     observer:observer
                       action:callback
                    extraInfo:extraInfo];
     
}


-(NSData *)getMyOrderItemInfoInput:(NSString *)userId orderId:(NSString *)orderId
{
     NSString *request = [NSString stringWithFormat:@"userId=%@&orderId=%@&%@",userId,orderId,[self getBaseUrlParem]];
     return [request dataUsingEncoding:NSUTF8StringEncoding];
     
}

-(NSError *)getMyOrderItemInfoOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input

{
     UNPACKETOUTPUTHEAD(recvData, ok);
     _orderDetail = nil;
     [(BSJSON *)jsonObj deserializationSpecifityMap:self map:@{@"data":@"BUOrderDetail,orderDetail"}];
     return SuccessedError;
     
}



-(BOOL)operOrder:(NSString *)userId orderId:(NSString *)orderId type:(NSString *)type observer:(id)observer callback:(SEL)callback
{
     return [self operOrder:userId  orderId:orderId type:type observer:observer callback:callback extraInfo:nil];
}



-(BOOL)operOrder:(NSString *)userId orderId:(NSString *)orderId  type:(NSString *)type  observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo
{
     
     NSInvocation *input = BSGetInvocationFromSel(self, @selector(operOrderInput:orderId:type:));
     [input setArgument:&userId atIndex:2];
     [input setArgument:&orderId atIndex:3];
     [input setArgument:&type atIndex:4];
     [input retainArguments];
     return [self sendRequest:[NSString stringWithFormat:@"%@%@",BU_BUSINESS_DOMAIN_MYPATH,BU_BUSINESS_OperOrder]
                         head:nil
                       method:@"POST"
                        async:YES
              inputInvocation:input
             outputInvocation:BSGetInvocationFromSel(self, @selector(operOrderOutput:ok:input:))
                     observer:observer
                       action:callback
                    extraInfo:extraInfo];
     
}


-(NSData *)operOrderInput:(NSString *)userId orderId:(NSString *)orderId type:(NSString *)type
{
     NSString *request = [NSString stringWithFormat:@"userId=%@&orderID=%@&typeMsg=%@&%@",userId,orderId,type,[self getBaseUrlParem]];
     return [request dataUsingEncoding:NSUTF8StringEncoding];
     
}

-(NSError *)operOrderOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input

{
     UNPACKETOUTPUTHEAD(recvData, ok);
//     _orderDetail = nil;
//     [(BSJSON *)jsonObj deserializationSpecifityMap:self map:@{@"data":@"BUOrderDetail,orderDetail"}];
     return SuccessedError;
     
}



-(BOOL)getTrackOrder:(NSString *)userId orderId:(NSString *)orderId observer:(id)observer callback:(SEL)callback
{
     return [self getTrackOrder:userId  orderId:orderId  observer:observer callback:callback extraInfo:nil];
}



-(BOOL)getTrackOrder:(NSString *)userId orderId:(NSString *)orderId   observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo
{
     
     NSInvocation *input = BSGetInvocationFromSel(self, @selector(getTrackOrderInput:orderId:));
     [input setArgument:&userId atIndex:2];
     [input setArgument:&orderId atIndex:3];
     [input retainArguments];
     return [self sendRequest:[NSString stringWithFormat:@"%@%@",BU_BUSINESS_DOMAIN_ORDER,BU_BUSINESS_GetTrackOrder]
                         head:nil
                       method:@"POST"
                        async:YES
              inputInvocation:input
             outputInvocation:BSGetInvocationFromSel(self, @selector(getTrackOrderOutput:ok:input:))
                     observer:observer
                       action:callback
                    extraInfo:extraInfo];
     
}


-(NSData *)getTrackOrderInput:(NSString *)userId orderId:(NSString *)orderId
{
     NSString *request = [NSString stringWithFormat:@"userId=%@&orderId=%@&%@",userId,orderId,[self getBaseUrlParem]];
     return [request dataUsingEncoding:NSUTF8StringEncoding];
     
}

-(NSError *)getTrackOrderOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input

{
     UNPACKETOUTPUTHEAD(recvData, ok);
     _track = nil;
     [(BSJSON *)jsonObj deserializationSpecifityMap:self map:@{@"data":@"BUTrack,track"}];
     return SuccessedError;
     
}



-(BOOL)evaluate:(NSString *)userId orderId:(NSString *)orderId orderScore:(NSString *)orderScore deliveryScore:(NSString *)deliveryScore deliveryRemark:(NSString *)deliveryRemark orderRemark:(NSString *)orderRemark eAnonymous:(NSString *)eAnonymous  observer:(id)observer callback:(SEL)callback
{
     return [self evaluate:userId  orderId:orderId orderScore:orderScore deliveryScore:deliveryScore deliveryRemark:deliveryRemark orderRemark:orderRemark eAnonymous:eAnonymous  observer:observer callback:callback extraInfo:nil];
}



-(BOOL)evaluate:(NSString *)userId orderId:(NSString *)orderId orderScore:(NSString *)orderScore deliveryScore:(NSString *)deliveryScore deliveryRemark:(NSString *)deliveryRemark orderRemark:(NSString *)orderRemark eAnonymous:(NSString *)eAnonymous    observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo
{
     
     NSInvocation *input = BSGetInvocationFromSel(self, @selector(evaluateInput:orderId:orderScore:deliveryScore:deliveryRemark:orderRemark:eAnonymous:));
     [input setArgument:&userId atIndex:2];
     [input setArgument:&orderId atIndex:3];
     [input setArgument:&orderScore atIndex:4];
     [input setArgument:&deliveryScore atIndex:5];
     [input setArgument:&deliveryRemark atIndex:6];
     [input setArgument:&orderRemark atIndex:7];
     [input setArgument:&eAnonymous atIndex:8];
     [input retainArguments];
     return [self sendRequest:[NSString stringWithFormat:@"%@%@",BU_BUSINESS_DOMAIN_ORDER,BU_BUSINESS_Evaluate]
                         head:nil
                       method:@"POST"
                        async:YES
              inputInvocation:input
             outputInvocation:BSGetInvocationFromSel(self, @selector(evaluateOutput:ok:input:))
                     observer:observer
                       action:callback
                    extraInfo:extraInfo];
     
}


-(NSData *)evaluateInput:(NSString *)userId orderId:(NSString *)orderId orderScore:(NSString *)orderScore deliveryScore:(NSString *)deliveryScore deliveryRemark:(NSString *)deliveryRemark orderRemark:(NSString *)orderRemark eAnonymous:(NSString *)eAnonymous
{
     NSString *request = [NSString stringWithFormat:@"userId=%@&orderId=%@&orderScore=%@&deliveryScore=%@&deliveryRemark=%@&orderRemark=%@&eAnonymous=%@&%@",userId,orderId,orderScore,deliveryScore,deliveryRemark,orderRemark,eAnonymous,[self getBaseUrlParem]];
     return [request dataUsingEncoding:NSUTF8StringEncoding];
     
}

-(NSError *)evaluateOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input

{
     UNPACKETOUTPUTHEAD(recvData, ok);
//     _trackList = nil;
//     [(BSJSON *)jsonObj deserializationSpecifityMap:self map:@{@"data":@"BUTrack,trackList"}];
     return SuccessedError;
     
}



-(BOOL)getBackOrderItem:(NSString *)orderBackID observer:(id)observer callback:(SEL)callback
{
     return [self getBackOrderItem:orderBackID    observer:observer callback:callback extraInfo:nil];
}



-(BOOL)getBackOrderItem:(NSString *)orderBackID    observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo
{
     
     NSInvocation *input = BSGetInvocationFromSel(self, @selector(getBackOrderItemInput:));
     [input setArgument:&orderBackID atIndex:2];

     [input retainArguments];
     return [self sendRequest:[NSString stringWithFormat:@"%@%@",BU_BUSINESS_DOMAIN_ORDER,BU_BUSINESS_GetBackOrderItem]
                         head:nil
                       method:@"POST"
                        async:YES
              inputInvocation:input
             outputInvocation:BSGetInvocationFromSel(self, @selector(getBackOrderItemOutput:ok:input:))
                     observer:observer
                       action:callback
                    extraInfo:extraInfo];
     
}


-(NSData *)getBackOrderItemInput:(NSString *)orderBackID
{
     NSString *request = [NSString stringWithFormat:@"orderBackID=%@&%@",orderBackID,[self getBaseUrlParem]];
     return [request dataUsingEncoding:NSUTF8StringEncoding];
     
}

-(NSError *)getBackOrderItemOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input

{
     UNPACKETOUTPUTHEAD(recvData, ok);
     _backInfo = nil;
     [(BSJSON *)jsonObj deserializationSpecifityMap:self map:@{@"data":@"BUBackInfo,backInfo"}];
     return SuccessedError;
     
}



-(BOOL)toBackOrder:(NSString *)userId orderId:(NSString *)orderId rsId:(NSString *)rsId rsTitle:(NSString *)rsTitle backContent:(NSString *)backContent userName:(NSString *)userName userTel:(NSString *)userTel  uploadPic:(NSString *)uploadPic   observer:(id)observer callback:(SEL)callback
{
     return [self toBackOrder:userId orderId:orderId rsId:rsId rsTitle:rsTitle backContent:backContent userName:userName userTel:userTel  uploadPic:uploadPic  observer:observer callback:callback extraInfo:nil];
}



-(BOOL)toBackOrder:(NSString *)userId orderId:(NSString *)orderId rsId:(NSString *)rsId rsTitle:(NSString *)rsTitle backContent:(NSString *)backContent userName:(NSString *)userName userTel:(NSString *)userTel  uploadPic:(NSString *)uploadPic     observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo
{

     NSInvocation *input = BSGetInvocationFromSel(self, @selector(toBackOrderInput:orderId:rsId:rsTitle:backContent:userName:userTel:uploadPic:));
     [input setArgument:&userId atIndex:2];
     [input setArgument:&orderId atIndex:3];
     [input setArgument:&rsId atIndex:4];
     [input setArgument:&rsTitle atIndex:5];
     [input setArgument:&backContent atIndex:6];
     [input setArgument:&userName atIndex:7];
     [input setArgument:&userTel atIndex:8];
     [input setArgument:&uploadPic atIndex:9];
     [input retainArguments];
     return [self sendRequest:[NSString stringWithFormat:@"%@%@",BU_BUSINESS_DOMAIN_ORDER,BU_BUSINESS_ToBackOrder]
                         head:nil
                       method:@"POST"
                        async:YES
              inputInvocation:input
             outputInvocation:BSGetInvocationFromSel(self, @selector(toBackOrderOutput:ok:input:))
                     observer:observer
                       action:callback
                    extraInfo:extraInfo];

}


-(NSData *)toBackOrderInput:(NSString *)userId orderId:(NSString *)orderId rsId:(NSString *)rsId rsTitle:(NSString *)rsTitle backContent:(NSString *)backContent userName:(NSString *)userName userTel:(NSString *)userTel  uploadPic:(NSString *)uploadPic
{
     NSString *request = [NSString stringWithFormat:@"userId=%@&orderId=%@&rsId=%@&rsTitle=%@&backContent=%@&userName=%@&userTel=%@&uploadPic=%@&%@",userId,orderId,rsId,rsTitle,backContent,userName,userTel,uploadPic,[self getBaseUrlParem]];
     return [request dataUsingEncoding:NSUTF8StringEncoding];

}

-(NSError *)toBackOrderOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input

{
     UNPACKETOUTPUTHEAD(recvData, ok);
     //     _trackList = nil;
     //     [(BSJSON *)jsonObj deserializationSpecifityMap:self map:@{@"data":@"BUTrack,trackList"}];
     _orderBackID = [[jsonObj objectForKey:@"data"] objectForKey:@"orderBackID"];
     return SuccessedError;

}


-(BOOL) changeHeadImage:(NSString *)tel withImage:(UIImage *)img observer:(id)observer callback:(SEL)callback
{
     NSData *imgdata = UIImageJPEGRepresentation([img imageToSize:CGSizeMake(160, 160)], 1);//(logoImg, 0.1);
     NSMutableDictionary *dic = [NSMutableDictionary new];
     //    dic[@"f1"] = @"f1";
     dic[@"tel"] = tel;
     [dic addEntriesFromDictionary:[self getBaseUrlParemDic]];
     return [self sendUploadRequest:[NSString stringWithFormat:@"%@%@",@"",@""]
                               data:imgdata
                           fileName:@"f1=f1.png"//[NSString stringWithFormat:@"file=%@accountId=%@&token=%@&%@",@"f1",_accountId,_token,[self getBaseUrlParem]]
                   outputInvocation:BSGetInvocationFromSel(self, @selector(changeHeadImageOutput:ok:input:))
                           observer:observer
                             action:callback
                          extraInfo:dic];
}

-(NSError *)changeHeadImageOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input
{
     UNPACKETOUTPUTHEAD(recvData, ok);
     //    _guidePageArr = [NSMutableArray array];
     //    [(BSJSON *)jsonObj deserializationSpecifityMap:self map:@{@"data":@"BUUserInfo,userInfo"}];
     return SuccessedError;
}


-(BOOL)getBackTypeList:(id)observer callback:(SEL)callback
{
     return [self getBackTypeList:observer callback:callback extraInfo:nil];
}



-(BOOL)getBackTypeList:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo
{
     
     NSInvocation *input = BSGetInvocationFromSel(self, @selector(getBackTypeListInput));
     [input retainArguments];
     return [self sendRequest:[NSString stringWithFormat:@"%@%@",BU_BUSINESS_DOMAIN_SYS,BU_BUSINESS_GetBackTypeList]
                         head:nil
                       method:@"POST"
                        async:YES
              inputInvocation:input
             outputInvocation:BSGetInvocationFromSel(self, @selector(getBackTypeListOutput:ok:input:))
                     observer:observer
                       action:callback
                    extraInfo:extraInfo];
     
}


-(NSData *)getBackTypeListInput
{
     NSString *request = [NSString stringWithFormat:@"%@",[self getBaseUrlParem]];
     return [request dataUsingEncoding:NSUTF8StringEncoding];
     
}

-(NSError *)getBackTypeListOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input

{
     UNPACKETOUTPUTHEAD(recvData, ok);
     _backTypeList = nil;
     [(BSJSON *)jsonObj deserializationSpecifityMap:self map:@{@"data":@"BUBackType,backTypeList"}];
     return SuccessedError;
     
}


-(BOOL)recyclingOrderAdd:(NSString*) userId withAddrid:(NSString*) addrId withRemark:(NSString*) remark withRecyclingtype:(NSString*) recyclingType withWeight:(NSString*) weight withType:(NSString*) type withPresettime:(NSString*) presetTime observer:(id)observer callback:(SEL)callback
{
     return [self recyclingOrderAdd: userId withAddrid: addrId withRemark: remark withRecyclingtype: recyclingType withWeight: weight withType: type withPresettime: presetTime observer:observer callback:callback extraInfo:nil];
}

-(BOOL)recyclingOrderAdd:(NSString*) userId withAddrid:(NSString*) addrId withRemark:(NSString*) remark withRecyclingtype:(NSString*) recyclingType withWeight:(NSString*) weight withType:(NSString*) type withPresettime:(NSString*) presetTime observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo
{
     NSInvocation *input = BSGetInvocationFromSel(self, @selector(recyclingOrderAddInput: withAddrid: withRemark: withRecyclingtype: withWeight: withType: withPresettime:));
     [input setArgument:&userId atIndex:2];
     [input setArgument:&addrId atIndex:3];
     [input setArgument:&remark atIndex:4];
     [input setArgument:&recyclingType atIndex:5];
     [input setArgument:&weight atIndex:6];
     [input setArgument:&type atIndex:7];
     [input setArgument:&presetTime atIndex:8];
     [input retainArguments];
     return [self sendRequest:[NSString stringWithFormat:@"%@%@",BU_BUSINESS_DOMAIN_ORDER,BU_BUSINESS_RecyclingOrderAdd]
                         head:nil
                       method:@"POST"
                        async:YES
              inputInvocation:input
             outputInvocation:BSGetInvocationFromSel(self, @selector(recyclingOrderAddOutput:ok:input:))
                     observer:observer
                       action:callback
                    extraInfo:extraInfo];

}


-(NSData *)recyclingOrderAddInput:(NSString*) userId withAddrid:(NSString*) addrId withRemark:(NSString*) remark withRecyclingtype:(NSString*) recyclingType withWeight:(NSString*) weight withType:(NSString*) type withPresettime:(NSString*) presetTime
{
     NSString *request = [NSString stringWithFormat:@"userId=%@&addrId=%@&remark=%@&recyclingType=%@&weight=%@&type=%@&presetTime=%@&%@",userId,addrId,remark,recyclingType,weight,type,presetTime,[self getBaseUrlParem]];
     return [request dataUsingEncoding:NSUTF8StringEncoding];

}

-(NSError *)recyclingOrderAddOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input

{
     UNPACKETOUTPUTHEAD(recvData, ok);

     return SuccessedError;

}



@end
