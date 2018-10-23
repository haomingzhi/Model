//
//  BUIndexManager.m
//  supermarket
//
//  Created by Steve on 2017/11/6.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import "BUIndexManager.h"
#import "BUSystem.h"
@implementation BUReason
-(id)init
{
     self = [super init];
     if(self){
          self.deserializationMap = @{@"BUImageRes":@"BUImageRes",@"id":@"NSString,sid"};

     }
     return self;
}
@end

@implementation BUCarouse
-(id)init
{
     self = [super init];
     if(self){
          self.deserializationMap = @{@"BUImageRes":@"BUImageRes",@"productList":@"BUProduct,productList"};

     }
     return self;
}

+(NSDictionary *)getArrDicWithThisArr:(NSArray*)arr
{
     NSMutableArray *tarr = [NSMutableArray new];
     [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
          BUCarouse *cc = obj;
          [tarr addObject:@{@"img":cc.imagePath?:@"banner"}];
     }];
     return @{@"arr":tarr};
}
@end

@implementation BUOpenCity
@end


@implementation BURecommendType
+(NSDictionary*)getArrDic:(NSArray *)arr
{
     NSMutableArray *ma = [NSMutableArray new];
     [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
          BURecommendType *p = obj;
          [ma addObject:@{@"img":p.pClassImg?:@"default",@"title":p.pClassName?:@"",@"default":@"default"}];
     }];
//     NSArray *aa = [ma subarrayWithRange:NSMakeRange(0, MIN(ma.count, 4))];
     return @{@"arr":ma};
}
@end

//@implementation BUActionAdvert
//-(id)init
//{
//     self = [super init];
//     if(self){
//          self.deserializationMap = @{@"BUImageRes":@"BUImageRes",@"productList":@"BUProduct,productList"};
//
//     }
//     return self;
//}
//+(NSDictionary *)getArrDic:(NSArray *)arr
//{
//     NSMutableArray *ma = [NSMutableArray new];
//     [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//          BUActionAdvert *p = obj;
//          [ma addObject:@{@"img":p.saImg?:@"default",@"title":p.saTitle?:@"",@"detail":p.subtopics?:@"",@"default":@"default"}];
//     }];
//     NSArray *aa = [ma subarrayWithRange:NSMakeRange(0, MIN(ma.count, 4))];
//     return @{@"arr":aa};
//}
//@end

@implementation BUStroe
+(NSArray *)getNameArr:(NSArray *)arr
{
     NSMutableArray *marr = [NSMutableArray new];
     [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
          BUStroe *s = obj;
          [marr addObject:s.sName?:@""];
     }];
     return marr;
}
@end

@implementation BUProduct
-(NSDictionary*)getDic
{
     return @{@"title":_proName?:@"",@"source":_proTitle?:@"",@"time":[NSString stringWithFormat:@"￥%.1f",_marketPrice],@"img":_proImagePic?:@"secKillA",@"btnImg":@"cart_blue",@"nPrice":@"",@"nwPrice":[NSString stringWithFormat:@"￥%.1f",_proPrice],@"default":@"secKillA"};
}

+(NSDictionary *)getArrDic:(NSArray *)arr
{
     NSMutableArray *ma = [NSMutableArray new];
     [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
          BUProduct *p = obj;
          [ma addObject:[p getDic]];
     }];
     return @{@"arr":ma};
}
@end

@implementation BUHotSearchKeyWord
@end

@implementation BUAdImage
-(id)init
{
     self = [super init];
     if(self){
          self.deserializationMap = @{@"BUImageRes":@"BUImageRes"};
        
     }
     return self;
}
@end



@implementation BUIndexManager

-(id)init
{
     self = [super init];
     if(self){
          self.deserializationMap = @{@"BUImageRes":@"BUImageRes"};
          self.getSysMessageListManager = [BUGetSysMessageListManager new];
     }
     return self;
}
-(BOOL)getOpenCityList:(id)observer callback:(SEL)callback
{
     return [self getOpenCityList:observer callback:callback extraInfo:nil];
}



-(BOOL)getOpenCityList:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo
{
 
     NSInvocation *input = BSGetInvocationFromSel(self, @selector(getOpenCityListInput));
     [input retainArguments];
     return [self sendRequest:[NSString stringWithFormat:@"%@%@",BU_BUSINESS_DOMAIN_INDEX,BU_BUSINESS_GetOpenCityList]
                         head:nil
                       method:@"POST"
                        async:YES
              inputInvocation:input
             outputInvocation:BSGetInvocationFromSel(self, @selector(getOpenCityListOutput:ok:input:))
                     observer:observer
                       action:callback
                    extraInfo:extraInfo];
     
}


-(NSData *)getOpenCityListInput
{
     NSString *request = [NSString stringWithFormat:@"%@",[self getBaseUrlParem]];
     return [request dataUsingEncoding:NSUTF8StringEncoding];
     
}

-(NSError *)getOpenCityListOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input

{
     UNPACKETOUTPUTHEAD(recvData, ok);
     _cityList = nil;
     [(BSJSON *)jsonObj deserializationSpecifityMap:self map:@{@"data":@"BUOpenCity,cityList"}];
     return SuccessedError;
}


-(BOOL)getCarouselList:(NSInteger) cityId postion:(NSString *)postion observer:(id)observer callback:(SEL)callback
{
     //postion 1-积分商城，2-服务
     return [self getCarouselList: cityId postion:postion observer:observer callback:callback extraInfo:nil];
}

-(BOOL)getCarouselList:(NSInteger) cityId postion:(NSString *)postion observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo
{
     NSString *cityStr = [NSString stringWithFormat:@"%ld",(long)cityId];
     NSInvocation *input = BSGetInvocationFromSel(self, @selector(ggetCarouselListInput:postion:));
     [input setArgument:&cityStr atIndex:2];
     [input setArgument:&postion atIndex:3];
     [input retainArguments];
     return [self sendRequest:[NSString stringWithFormat:@"%@%@",BU_BUSINESS_DOMAIN_INDEX,BU_BUSINESS_GetCarouselList]
                         head:nil
                       method:@"POST"
                        async:YES
              inputInvocation:input
             outputInvocation:BSGetInvocationFromSel(self, @selector(getCarouselListOutput:ok:input:))
                     observer:observer
                       action:callback
                    extraInfo:extraInfo];

}


-(NSData *)ggetCarouselListInput:(NSString*) cityId postion:(NSString *)postion
{
     NSString *request = [NSString stringWithFormat:@"cityId=%@&postion=%@&%@",cityId,postion,[self getBaseUrlParem]];
     return [request dataUsingEncoding:NSUTF8StringEncoding];

}

-(NSError *)getCarouselListOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input

{
     UNPACKETOUTPUTHEAD(recvData, ok);
     _carouseList = nil;
      [(BSJSON *)jsonObj deserializationSpecifityMap:self map:@{@"data":@"BUCarouse,carouseList"}];
     return SuccessedError;

}





-(BOOL)getReasonList:(id)observer callback:(SEL)callback
{
     return [self getReasonList:observer callback:callback extraInfo:nil];
}

-(BOOL)getReasonList:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo
{
     NSInvocation *input = BSGetInvocationFromSel(self, @selector(getReasonListInput));

     [input retainArguments];
     return [self sendRequest:[NSString stringWithFormat:@"%@%@",BU_BUSINESS_DOMAIN_INDEX,BU_BUSINESS_GetReasonList]
                         head:nil
                       method:@"POST"
                        async:YES
              inputInvocation:input
             outputInvocation:BSGetInvocationFromSel(self, @selector(getReasonListOutput:ok:input:))
                     observer:observer
                       action:callback
                    extraInfo:extraInfo];

}


-(NSData *)getReasonListInput
{
     NSString *request = [NSString stringWithFormat:@"%@",[self getBaseUrlParem]];
     return [request dataUsingEncoding:NSUTF8StringEncoding];

}

-(NSError *)getReasonListOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input

{
     UNPACKETOUTPUTHEAD(recvData, ok);
     _reasonList = nil;
[(BSJSON *)jsonObj deserializationSpecifityMap:self map:@{@"data":@"BUReason,reasonList"}];
     return SuccessedError;

}
@end
