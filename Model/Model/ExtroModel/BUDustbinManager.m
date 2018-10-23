//
//  BUDustbinManager.m
//  intelligentgarbagecollection
//
//  Created by air on 2017/12/12.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import "BUDustbinManager.h"

@implementation BURecycleOrder
-(id)init
{
     self = [super init];
     if(self){
          self.deserializationMap = @{@"BUImageRes":@"BUImageRes"};
          
     }
     return self;
}
@end

@implementation BURecyclingStat
-(id)init
{
     self = [super init];
     if(self){
          self.deserializationMap = @{@"day1_List":@"BUDustbinType,day1_List",@"day3_List":@"BUDustbinType,day3_List",@"day7_List":@"BUDustbinType,day7_List"};
          
     }
     return self;
}
@end

@implementation BUDustbinType
-(id)init
{
     self = [super init];
     if(self){
          self.deserializationMap = @{@"BUImageRes":@"BUImageRes"};
          
     }
     return self;
}
@end


@implementation BUIntegral
-(NSDictionary*)getDic
{
     return @{@"title":_typeName?:@"",@"detail":[NSString stringWithFormat:@"%ld积分/kg",_integral] ,@"img":_imagePath?:@""};
}
@end

@implementation BUCan

@end

@implementation BUDustbin
-(id)init
{
     self = [super init];
     if(self){
          self.deserializationMap = @{@"BUImageRes":@"BUImageRes",@"canList":@"BUCan,canList"};

     }
     return self;
}
@end

@implementation BUGetStationInfo
-(id)init
{
     self = [super init];
     if(self){
          self.deserializationMap = @{@"BUImageRes":@"BUImageRes",@"canList":@"BUCan,canList",@"integralList":@"BUIntegral,integralList"};

     }
     return self;
}
-(NSDictionary*)getDic
{
     NSMutableArray *arr = [NSMutableArray array];
//     [_canList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//          BUCan *cv = obj;
//          [arr addObject:@{@"title":@"累计回收",@"count":[NSString stringWithFormat:@"%ldKG",cv.currentVolume],@"detail1":[NSString stringWithFormat:@"当前仓位：%ld%",cv.proportion],@"detail2":[NSString stringWithFormat:@"满仓%ldkg",cv.volume],@"value":@(cv.proportion)}];
//     }];
//     return @{@"bgImg":@"recycleBg",@"img":cv.imagePath?:@"metal2",@"titleA":@"金属回收箱",@"leftImg":@"leftBtn",@"rightImg":@"rightBtn",@"img":_imagePath?:@"",@"title":_name?:@"",@"recycleInfo":arr,@"aTitle":[NSString stringWithFormat:@"%ld次",cv.fullCount ],@"aDetail":@"满仓次数",@"bTitle":[NSString stringWithFormat:@"%.1fkg",cv.restValume],@"bDetail":@"剩余可回收"};

     [_canList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
          BUCan *cv = obj;
          [arr addObject:@{@"title":@"当前仓位",@"img":cv.imagePath?:@"",@"titleA":cv.name?:@"",@"count":[NSString stringWithFormat:@"%.1f%%",cv.proportion],@"detail1":[NSString stringWithFormat:@"满仓%.2fkg",cv.currentVolume],@"detail2":@"",@"value":@(cv.proportion),@"aTitle":[NSString stringWithFormat:@"%ld次",cv.fullCount ],@"aDetail":@"满仓次数",@"bTitle":[NSString stringWithFormat:@"%ldkg",cv.totalWeight],@"bDetail":@"累计回收"}];
     }];
     return @{@"bgImg":@"recycleBg",@"leftImg":@"leftBtn",@"rightImg":@"rightBtn",@"recycleInfo":arr};
}
@end


@implementation BUDustbinManager
-(id)init
{
     self = [super init];
     if(self){
          self.deserializationMap = @{@"BUImageRes":@"BUImageRes"};
          
     }
     return self;
}



-(BOOL)getStationInfo:(NSString*) sid observer:(id)observer callback:(SEL)callback
{
     return [self getStationInfo: sid observer:observer callback:callback extraInfo:nil];
}

-(BOOL)getStationInfo:(NSString*) sid observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo
{
     NSInvocation *input = BSGetInvocationFromSel(self, @selector(getStationInfoInput:));
     [input setArgument:&sid atIndex:2];
     [input retainArguments];
     return [self sendRequest:[NSString stringWithFormat:@"%@%@",BU_BUSINESS_DOMAIN_DUSTBIN,BU_BUSINESS_GetStationInfo]
                         head:nil
                       method:@"POST"
                        async:YES
              inputInvocation:input
             outputInvocation:BSGetInvocationFromSel(self, @selector(getStationInfoOutput:ok:input:))
                     observer:observer
                       action:callback
                    extraInfo:extraInfo];

}


-(NSData *)getStationInfoInput:(NSString*) sid
{
     NSString *request = [NSString stringWithFormat:@"id=%@&%@",sid,[self getBaseUrlParem]];
     return [request dataUsingEncoding:NSUTF8StringEncoding];

}

-(NSError *)getStationInfoOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input

{
     UNPACKETOUTPUTHEAD(recvData, ok);
     _stationInfo = nil;
        [(BSJSON *)jsonObj deserializationSpecifityMap:self map:@{@"data":@"BUGetStationInfo,stationInfo"}];
     return SuccessedError;

}

-(BOOL)getDustbinTypeList:(id)observer callback:(SEL)callback
{
     return [self getDustbinTypeList:observer callback:callback extraInfo:nil];
}

-(BOOL)getDustbinTypeList:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo
{
     NSString *dd;
     NSInvocation *input = BSGetInvocationFromSel(self, @selector(getDustbinTypeListInput:));
     [input setArgument:&dd atIndex:2];
     [input retainArguments];
     return [self sendRequest:[NSString stringWithFormat:@"%@%@",BU_BUSINESS_DOMAIN_DUSTBIN,BU_BUSINESS_GetDustbinTypeList]
                         head:nil
                       method:@"POST"
                        async:YES
              inputInvocation:input
             outputInvocation:BSGetInvocationFromSel(self, @selector(getDustbinTypeListOutput:ok:input:))
                     observer:observer
                       action:callback
                    extraInfo:extraInfo];

}


-(NSData *)getDustbinTypeListInput:(NSString*) userId
{
     NSString *request = [NSString stringWithFormat:@"%@",[self getBaseUrlParem]];
     return [request dataUsingEncoding:NSUTF8StringEncoding];

}

-(NSError *)getDustbinTypeListOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input

{
     UNPACKETOUTPUTHEAD(recvData, ok);
     _dustbinType = nil;
     [(BSJSON *)jsonObj deserializationSpecifityMap:self map:@{@"data":@"BUDustbinType,dustbinType"}];
     return SuccessedError;

}


-(BOOL)getStationList:(NSString*) key cityId:(NSString *)cityId observer:(id)observer callback:(SEL)callback
{
     return [self getStationList: key cityId:(NSString *)cityId  observer:observer callback:callback extraInfo:nil];
}

-(BOOL)getStationList:(NSString*)key cityId:(NSString *)cityId  observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo
{
     NSInvocation *input = BSGetInvocationFromSel(self, @selector(getStationListInput:cityId:));
     [input setArgument:&key atIndex:2];
     [input setArgument:&cityId atIndex:3];
     [input retainArguments];
     return [self sendRequest:[NSString stringWithFormat:@"%@%@",BU_BUSINESS_DOMAIN_DUSTBIN,BU_BUSINESS_GetStationList]
                         head:nil
                       method:@"POST"
                        async:YES
              inputInvocation:input
             outputInvocation:BSGetInvocationFromSel(self, @selector(getStationListOutput:ok:input:))
                     observer:observer
                       action:callback
                    extraInfo:extraInfo];
     
}


-(NSData *)getStationListInput:(NSString*) key cityId:(NSString *)cityId
{
     NSString *request = [NSString stringWithFormat:@"key=%@&cityId=%@&%@",key,cityId,[self getBaseUrlParem]];
     return [request dataUsingEncoding:NSUTF8StringEncoding];
     
}

-(NSError *)getStationListOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input

{
     UNPACKETOUTPUTHEAD(recvData, ok);
     _stationList = nil;
     [(BSJSON *)jsonObj deserializationSpecifityMap:self map:@{@"data":@"BUGetStationInfo,stationList"}];
     return SuccessedError;
     
}




-(BOOL)getRecyclingStat:(NSString*)userId observer:(id)observer callback:(SEL)callback
{
     return [self getRecyclingStat: userId  observer:observer callback:callback extraInfo:nil];
}

-(BOOL)getRecyclingStat:(NSString*)userId  observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo
{
     NSInvocation *input = BSGetInvocationFromSel(self, @selector(getRecyclingStatInput:));
     [input setArgument:&userId atIndex:2];
     [input retainArguments];
     return [self sendRequest:[NSString stringWithFormat:@"%@%@",BU_BUSINESS_DOMAIN_DUSTBIN,BU_BUSINESS_GetRecyclingStat]
                         head:nil
                       method:@"POST"
                        async:YES
              inputInvocation:input
             outputInvocation:BSGetInvocationFromSel(self, @selector(getRecyclingStatOutput:ok:input:))
                     observer:observer
                       action:callback
                    extraInfo:extraInfo];
     
}


-(NSData *)getRecyclingStatInput:(NSString*)userId
{
     NSString *request = [NSString stringWithFormat:@"userId=%@&%@",userId,[self getBaseUrlParem]];
     return [request dataUsingEncoding:NSUTF8StringEncoding];
     
}

-(NSError *)getRecyclingStatOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input

{
     UNPACKETOUTPUTHEAD(recvData, ok);
     _recyclingStat = nil;
     [(BSJSON *)jsonObj deserializationSpecifityMap:self map:@{@"data":@"BURecyclingStat,recyclingStat"}];
     return SuccessedError;
     
}


-(BOOL)getQrCode:(NSString*)userId observer:(id)observer callback:(SEL)callback
{
     return [self getQrCode:userId  observer:observer callback:callback extraInfo:nil];
}

-(BOOL)getQrCode:(NSString*)userId  observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo
{
     NSInvocation *input = BSGetInvocationFromSel(self, @selector(getQrCodeInput:));
     [input setArgument:&userId atIndex:2];
     [input retainArguments];
     return [self sendRequest:[NSString stringWithFormat:@"%@%@",BU_BUSINESS_DOMAIN_DUSTBIN,BU_BUSINESS_GetQrCode]
                         head:nil
                       method:@"POST"
                        async:YES
              inputInvocation:input
             outputInvocation:BSGetInvocationFromSel(self, @selector(getQrCodeOutput:ok:input:))
                     observer:observer
                       action:callback
                    extraInfo:extraInfo];
     
}


-(NSData *)getQrCodeInput:(NSString*)userId
{
     NSString *request = [NSString stringWithFormat:@"userId=%@&%@",userId,[self getBaseUrlParem]];
     return [request dataUsingEncoding:NSUTF8StringEncoding];
     
}

-(NSError *)getQrCodeOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input

{
     UNPACKETOUTPUTHEAD(recvData, ok);
     _qrCode = nil;
     [(BSJSON *)jsonObj deserializationSpecifityMap:self map:@{@"BUImageRes":@"BUImageRes",@"data":@"BUImageRes,qrCode"}];
     return SuccessedError;
     
}


-(BOOL)getRecyclingOrder:(NSString*)userId startTime:(NSString *)startTime observer:(id)observer callback:(SEL)callback
{
     return [self getRecyclingOrder:userId startTime:startTime observer:observer callback:callback extraInfo:nil];
}

-(BOOL)getRecyclingOrder:(NSString*)userId  startTime:(NSString *)startTime  observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo
{
     NSInvocation *input = BSGetInvocationFromSel(self, @selector(getRecyclingOrderInput:startTime:));
     [input setArgument:&userId atIndex:2];
     [input setArgument:&startTime atIndex:3];
     [input retainArguments];
     return [self sendRequest:[NSString stringWithFormat:@"%@%@",BU_BUSINESS_DOMAIN_DUSTBIN,BU_BUSINESS_GetRecyclingOrder]
                         head:nil
                       method:@"POST"
                        async:YES
              inputInvocation:input
             outputInvocation:BSGetInvocationFromSel(self, @selector(getRecyclingOrderOutput:ok:input:))
                     observer:observer
                       action:callback
                    extraInfo:extraInfo];
     
}


-(NSData *)getRecyclingOrderInput:(NSString*)userId startTime:(NSString *)startTime
{
     NSString *request = [NSString stringWithFormat:@"userId=%@&startTime=%@&%@",userId,startTime,[self getBaseUrlParem]];
     return [request dataUsingEncoding:NSUTF8StringEncoding];
     
}

-(NSError *)getRecyclingOrderOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input

{
     UNPACKETOUTPUTHEAD(recvData, ok);
     _recycleOrder = nil;
     [(BSJSON *)jsonObj deserializationSpecifityMap:self map:@{@"data":@"BURecycleOrder,recycleOrder"}];
     return SuccessedError;
     
}


@end
