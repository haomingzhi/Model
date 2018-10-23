//
//  BUUserManager.m
//  intelligentgarbagecollection
//
//  Created by Steve on 2017/12/12.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import "BUUserManager.h"
#import "BUSystem.h"


@implementation BUCartShopGoods

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
          NSString *price = [NSString stringWithFormat:@"¥%.2f",_salePrice];
          NSString *quantity = [NSString stringWithFormat:@"%ld",(long)_count];
          return @{@"title":_name?:@"",@"type":@"",@"price":price,@"num":quantity,@"img":_imagePath?:@"",@"default":@"default"};
     }else if(index == 1){
          NSString *quantity = [NSString stringWithFormat:@"x%ld",(long)_count];
          return @{@"title":_name?:@"",@"source":quantity,@"img":_imagePath?:@"",@"default":@"default"};
     }
     else if (index == 2){
          NSString *quantity = [NSString stringWithFormat:@"x%ld",(long)_count];
          NSString *price = [NSString stringWithFormat:@"¥%.2f",_salePrice];
          return  @{@"title":_name?:@"",@"source":_goodsSpec?:@"",@"time":price,@"img":_imagePath?:@"",@"default":@"default",@"num":quantity};
     }
     return @{};
}


-(void)setData:(BUGoodsDetail *)goodsInfo{
     _imagePath = goodsInfo.imagePath;
     _count = 1;;
     _waterId = @"";
     _stock = goodsInfo.stock;
//     _goodsState= goodsInfo.;
     _salePrice = goodsInfo.salePrice;
//     _shopState = goodsInfo.;
//     @property(strong,nonatomic) NSString *shopId;
     _goodsSpec = goodsInfo.goodsSpec;
     _goodsId = goodsInfo.goodsId;
     _name = goodsInfo.name;
     _imagePath = goodsInfo.imagePath;
//     @property(strong,nonatomic) NSString *goodsId;
//     @property(strong,nonatomic) NSString *name;
}

@end


@implementation BUCartShopInfo

-(id)init
{
     self = [super init];
     if(self){
          self.deserializationMap = @{@"BUImageRes":@"BUImageRes",@"goodsList":@"BUCartShopGoods,goodsList"};
     }
     return self;
}

-(NSDictionary *)getDic:(NSInteger)index{
     if (index ==0 ) {
        
          return @{@"title":_shopName?:@"",@"detail":@""};
     }
     else if (index == 1){
          NSString *price = [NSString stringWithFormat:@"¥%.2f",_sumPrice];
          NSString *str = @"";
          if (_expressFee !=0.0) {
               str = [NSString stringWithFormat:@"另需配送费¥%.2f",_expressFee];
          }else{
               str = @"免配送费";
          }
          return @{@"title":@"合计:",@"source":price,@"time":str};
     }
     return @{};
}

-(void)setAllSel{
     _isAllSelected = !_isAllSelected;
     _sumPrice = 0.0;
     [_goodsList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
          BUCartShopGoods *g = obj;
          g.isSelected = _isAllSelected;
          if (g.isSelected) {
               _sumPrice += g.salePrice;
          }
     }];
}

@end


@implementation BUCart

-(id)init
{
     self = [super init];
     if(self){
          self.deserializationMap = @{@"BUImageRes":@"BUImageRes",@"invalidGoodsList":@"BUCartShopGoods,invalidGoodsList",@"shopList":@"BUCartShopInfo,shopList"};
     }
     return self;
}

@end

@implementation BUUserManager
-(BOOL)addUserCart:(NSString *)goodsId count:(NSInteger)count   observer:(id)observer callback:(SEL)callback
{
     return [self addUserCart:goodsId count:count   observer:observer callback:callback extraInfo:nil];
}

-(BOOL)addUserCart:(NSString *)goodsId count:(NSInteger)count    observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo
{
     NSString *countStr = [NSString stringWithFormat:@"%ld",(long)count];
     NSInvocation *input = BSGetInvocationFromSel(self, @selector(addUserCartInput:count:));
     [input setArgument:&goodsId atIndex:2];
     [input setArgument:&countStr atIndex:3];
     [input retainArguments];
     return [self sendRequest:[NSString stringWithFormat:@"%@%@%@",BU_BUSINESS_DOMAIN_USER,BU_BUSINESS_AddUserCart,@""]
                         head:nil
                       method:@"POST"
                        async:YES
              inputInvocation:input
             outputInvocation:BSGetInvocationFromSel(self, @selector(addUserCartOutput:ok:input:))
                     observer:observer
                       action:callback
                    extraInfo:extraInfo];
     
}


-(NSData *)addUserCartInput:(NSString*)goodsId count:(NSString *)count
{
     NSString *request = [NSString stringWithFormat:@"userId=%@&goodsId=%@&count=%@&%@",busiSystem.agent.userId,goodsId,count,[self getBaseUrlParem]];
     return [request dataUsingEncoding:NSUTF8StringEncoding];
     
}

-(NSError *)addUserCartOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input

{
     UNPACKETOUTPUTHEAD(recvData, ok);
//     _serviceInfo = nil;
//     [(BSJSON *)jsonObj deserializationSpecifityMap:self map:@{@"data":@"BUServiceInfo,serviceInfo"}];
     return SuccessedError;
     
}


-(BOOL)addGoodsCollect:(NSString *)goodsId productType:(NSString *)productType   observer:(id)observer callback:(SEL)callback
{
     return [self addGoodsCollect:goodsId productType:productType   observer:observer callback:callback extraInfo:nil];
}

-(BOOL)addGoodsCollect:(NSString *)goodsId productType:(NSString *)productType    observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo
{
     NSInvocation *input = BSGetInvocationFromSel(self, @selector(addGoodsCollectInput:productType:));
     [input setArgument:&goodsId atIndex:2];
     [input setArgument:&productType atIndex:3];
     [input retainArguments];
     return [self sendRequest:[NSString stringWithFormat:@"%@%@%@",BU_BUSINESS_DOMAIN_USER,BU_BUSINESS_AddGoodsCollect,@""]
                         head:nil
                       method:@"POST"
                        async:YES
              inputInvocation:input
             outputInvocation:BSGetInvocationFromSel(self, @selector(addGoodsCollectOutput:ok:input:))
                     observer:observer
                       action:callback
                    extraInfo:extraInfo];
     
}


-(NSData *)addGoodsCollectInput:(NSString*)goodsId productType:(NSString *)productType
{
     NSString *request = [NSString stringWithFormat:@"userId=%@&goodsId=%@&productType=%@&%@",busiSystem.agent.userId,goodsId,productType ,[self getBaseUrlParem]];
     return [request dataUsingEncoding:NSUTF8StringEncoding];
     
}

-(NSError *)addGoodsCollectOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input

{
     UNPACKETOUTPUTHEAD(recvData, ok);
     //     _serviceInfo = nil;
     //     [(BSJSON *)jsonObj deserializationSpecifityMap:self map:@{@"data":@"BUServiceInfo,serviceInfo"}];
     return SuccessedError;
     
}



-(BOOL)getCourierInfo:(NSString *)ID  observer:(id)observer callback:(SEL)callback
{
     return [self getCourierInfo:ID  observer:observer callback:callback extraInfo:nil];
}

-(BOOL)getCourierInfo:(NSString *)ID  observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo
{
     NSInvocation *input = BSGetInvocationFromSel(self, @selector(getCourierInfonput:));
     [input setArgument:&ID atIndex:2];
     [input retainArguments];
     return [self sendRequest:[NSString stringWithFormat:@"%@%@%@",BU_BUSINESS_DOMAIN_USER,BU_BUSINESS_GetCourierInfo,@""]
                         head:nil
                       method:@"POST"
                        async:YES
              inputInvocation:input
             outputInvocation:BSGetInvocationFromSel(self, @selector(getCourierInfoOutput:ok:input:))
                     observer:observer
                       action:callback
                    extraInfo:extraInfo];
     
}


-(NSData *)getCourierInfonput:(NSString*)ID
{
     NSString *request = [NSString stringWithFormat:@"id=%@&%@",ID,[self getBaseUrlParem]];
     return [request dataUsingEncoding:NSUTF8StringEncoding];
     
}

-(NSError *)getCourierInfoOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input

{
     UNPACKETOUTPUTHEAD(recvData, ok);
     _courier = nil;
     [(BSJSON *)jsonObj deserializationSpecifityMap:self map:@{@"data":@"BUCourier,courier"}];
     return SuccessedError;
     
}



-(BOOL)getShoppingCartList:(NSString *)userId   observer:(id)observer callback:(SEL)callback
{
     return [self getShoppingCartList:userId  observer:observer callback:callback extraInfo:nil];
}



-(BOOL)getShoppingCartList:(NSString *)userId  observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo
{
     
     NSInvocation *input = BSGetInvocationFromSel(self, @selector(getShoppingCartListInput:));
     [input setArgument:&userId atIndex:2];
     [input retainArguments];
     return [self sendRequest:[NSString stringWithFormat:@"%@%@",BU_BUSINESS_DOMAIN_USER,BU_BUSINESS_GetUserCart]
                         head:nil
                       method:@"POST"
                        async:YES
              inputInvocation:input
             outputInvocation:BSGetInvocationFromSel(self, @selector(getShoppingCartListOutput:ok:input:))
                     observer:observer
                       action:callback
                    extraInfo:extraInfo];
     
}


-(NSData *)getShoppingCartListInput:(NSString *)userId
{
     NSString *request = [NSString stringWithFormat:@"userId=%@&%@",userId,[self getBaseUrlParem]];
     return [request dataUsingEncoding:NSUTF8StringEncoding];
     
}

-(NSError *)getShoppingCartListOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input

{
     UNPACKETOUTPUTHEAD(recvData, ok);
     _cartInfo = nil;
     [(BSJSON *)jsonObj deserializationSpecifityMap:self map:@{@"data":@"BUCart,cartInfo"}];
     return SuccessedError;
     
}


-(BOOL)getUserCartCount:(NSString *)userId   observer:(id)observer callback:(SEL)callback
{
     return [self getUserCartCount:userId  observer:observer callback:callback extraInfo:nil];
}



-(BOOL)getUserCartCount:(NSString *)userId  observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo
{
     
     NSInvocation *input = BSGetInvocationFromSel(self, @selector(getUsergCartCountInput:));
     [input setArgument:&userId atIndex:2];
     [input retainArguments];
     return [self sendRequest:[NSString stringWithFormat:@"%@%@",BU_BUSINESS_DOMAIN_USER,BU_BUSINESS_GetUserCartCount]
                         head:nil
                       method:@"POST"
                        async:YES
              inputInvocation:input
             outputInvocation:BSGetInvocationFromSel(self, @selector(getUsergCartCountOutput:ok:input:))
                     observer:observer
                       action:callback
                    extraInfo:extraInfo];
     
}


-(NSData *)getUsergCartCountInput:(NSString *)userId
{
     NSString *request = [NSString stringWithFormat:@"userId=%@&%@",userId,[self getBaseUrlParem]];
     return [request dataUsingEncoding:NSUTF8StringEncoding];
     
}

-(NSError *)getUsergCartCountOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input

{
     UNPACKETOUTPUTHEAD(recvData, ok);

     _cartCount = [[jsonObj objectForKey:@"data"] integerValue];
     return SuccessedError;
     
}


@end
