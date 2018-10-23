//
//  BUHeadManager.m
//  taihe
//
//  Created by air on 2016/11/16.
//  Copyright © 2016年 ORANLLC_IOS1. All rights reserved.
//

#import "BUHeadManager.h"
#import "BUSystem.h"


@implementation BUClassifyInfo
-(id)init
{
     self = [super init];
     if(self){
          self.deserializationMap = @{@"BUImageRes":@"BUImageRes"};
     }
     return self;
}
-(NSDictionary *)getDic
{
     return @{@"title":_name?:@"",@"img":_img?:@"",@"default":@""};
}
@end

@implementation BUClassify
-(id)init
{
     self = [super init];
     if(self){
          self.deserializationMap = @{@"BUImageRes":@"BUImageRes",@"secList":@"BUClassifyInfo,secList"};
     }
     return self;
}


-(NSDictionary *)getDic
{
     return @{@"title":_name?:@""};
}
@end

@implementation BUHeadGoods
-(id)init
{
     self = [super init];
     if(self){
          self.deserializationMap = @{@"BUImageRes":@"BUImageRes"};
     }
     return self;
}
-(NSDictionary *)getDicA
{
     NSString *str = [NSString stringWithFormat:@"¥%.2f/%@起",_leaseMoney,_leaseType==0?@"月":@"天"];
     return @{@"aHot":@(_isHot),@"aTitle":_name?:@"",@"aDetail":str,@"aimg":_img?:@"default",@"default":@"default"};
}

-(NSDictionary *)getDicB
{
     NSString *str = [NSString stringWithFormat:@"¥%.2f/%@起",_leaseMoney,_leaseType==0?@"月":@"天"];
     return @{@"bHot":@(_isHot),@"bTitle":_name?:@"",@"bDetail":str,@"bimg":_img?:@"default"};
}

-(NSDictionary *)getDic{
     return @{@"title":_name?:@"",@"source":[NSString stringWithFormat:@"%.2f",_leaseMoney],@"time":[NSString stringWithFormat:@"元/%@",_leaseType==0?@"月":@"天"],@"default":@"default",@"img":_img?:@"default",@"isPost":@(YES),@"isSecondHand":@(_colorType==1)};
}

@end

@implementation BUOptimization
-(id)init
{
     self = [super init];
     if(self){
          self.deserializationMap = @{@"BUImageRes":@"BUImageRes",@"proList":@"BUHeadGoods,proList"};
     }
     return self;
}
-(NSDictionary *)getDic:(NSInteger)index
{
     if (index == 0) {
          return  @{@"img":@"arrow_right_gray",@"title":_title?:@"",@"source":_subtitle?:@""};
     }
     else if (index == 1){
          return @{@"img":_img?:@"",@"default":@"defaultBanner"};
     }
     return @{};
}


@end

@implementation BUIndexActivity
-(id)init
{
     self = [super init];
     if(self){
          self.deserializationMap = @{@"BUImageRes":@"BUImageRes"};
     }
     return self;
}


-(NSDictionary *)getDic
{
//     NSMutableArray *arr = [NSMutableArray new];
     
//     @{@"arr":@[@{@"img":@"说走就走",@"title":@"白领首选",@"detail":@"上班族第一选择",@"default":@"default",@"index":@(0)},@{@"img":@"说走就走",@"title":@"说走就走",@"detail":@"旅途从此开始",@"default":@"default",@"index":@(1)},@{@"img":@"潮人单品",@"title":@"潮人单品",@"detail":@"再不疯狂我们就老了",@"default":@"default",@"index":@(2)},@{@"img":@"潮人单品",@"title":@"家居数码",@"detail":@"家务通通交给它",@"default":@"default",@"index":@(3)}]
       return @{@"img":_img?:@"",@"title":_title?:@"",@"detail":_note?:@"",@"default":@"default"};
}


@end

@implementation BUQuickMenu
-(id)init
{
     self = [super init];
     if(self){
          self.deserializationMap = @{@"BUImageRes":@"BUImageRes"};
     }
     return self;
}
//-(NSDictionary *)getDic
//{
//
//     return @{@"img":_aImg?:@"defaultServer2",@"title":@"",@"detail":_aaTitle?:@"",@"default":@"defaultServer2"};
//}


@end

@implementation BUBannerAndQuickMenu
-(id)init
{
     self = [super init];
     if(self){
          self.deserializationMap = @{@"slideshow":@"BUQuickMenu,slideshow",@"nvaig":@"BUQuickMenu,nvaig"};
     }
     return self;
}
-(NSDictionary *)getDic:(NSInteger)index
{
     if (index == 0) {
          NSMutableArray *arr = [NSMutableArray new];
          [_slideshow enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
               BUQuickMenu *q = obj;
               [arr addObject:@{@"img":q.img?:@"defaultBanner",@"default":@"defaultBanner"}];
          }];
           return @{@"arr":arr};
     }else if(index == 1){
          NSMutableArray *arr = [NSMutableArray new];
          [_nvaig enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
               if (idx<10) {
                    BUQuickMenu *q = obj;
                    [arr addObject:@{@"img":q.img?:@"defaultBanner",@"title":q.name?:@""}];
               }
               
          }];
          return @{@"arr":arr};
     }
     return @{};
    
}


@end




@implementation BUBanners
-(id)init
{
    self = [super init];
    if(self){
        self.deserializationMap = @{@"BUImageRes":@"BUImageRes"};
    }
    return self;
}
-(NSDictionary *)getDic
{
    
    return @{@"img":_aImg?:@"",@"title":@"",@"detail":_aaTitle?:@"",@"default":@"defaultBanner"};
}

+(NSDictionary *)getDicArrWith:(NSArray *)arr
{
    NSMutableDictionary *mdic = [NSMutableDictionary new];
    NSMutableArray *marr = [NSMutableArray new];
    [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        BUBanners *s = obj;
        [marr addObject:[s getDic]];
    }];
    mdic[@"arr"] = marr;
    return mdic;
}
@end

@implementation BUServices
-(id)init
{
    self = [super init];
    if(self){
        self.deserializationMap =  @{@"BUImageRes":@"BUImageRes"};
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.sstId?:@"" forKey:@"sstId"];
    [aCoder encodeObject:self.susId?:@"" forKey:@"susId"];
    [aCoder encodeObject:self.imagePath.Image?:@"" forKey:@"imagePath"];
    [aCoder encodeObject:self.sapId?:@"" forKey:@"sapId"];
        [aCoder encodeObject:@(self.no) forKey:@"no"];
        [aCoder encodeObject:self.name?:@"" forKey:@"name"];
          [aCoder encodeObject:@(self.state) forKey:@"state"];
    
}
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        _sstId = [aDecoder decodeObjectForKey:@"sstId"];
        _susId = [aDecoder decodeObjectForKey:@"susId"];
        _sapId = [aDecoder decodeObjectForKey:@"sapId"];
        _no = [[aDecoder decodeObjectForKey:@"no"] integerValue];
           _state = [[aDecoder decodeObjectForKey:@"state"] integerValue];
           _name = [aDecoder decodeObjectForKey:@"name"];
        _imagePath = [BUImageRes new];
        _imagePath.Image = [aDecoder decodeObjectForKey:@"imagePath"];
    }
    return self;
}
-(NSDictionary *)getDic
{

return @{@"title":_name?:@"",@"img":_imagePath?:[NSNull new]};
}
-(NSDictionary *)getDicWithDel
{
    
    return @{@"title":_name?:@"",@"img":_imagePath?:[NSNull new],@"showDel":_state == 1? @(YES):@NO};
}
@end


@implementation BUHeadManager

-(id)init
{
    self = [super init];
    if(self){
        self.deserializationMap = @{@"banners":@"BUBanners,banners",@"services":@"BUServices,services",@"notices":@"NSString,notices"};
         self.getSearchListManager = [BUGetSearchListManager new];

    }
    return self;
}


-(BOOL)getInitialization:(NSString *)sapid  observer:(id)observer callback:(SEL)callback
{
    return [self getInitialization:sapid observer:observer callback:callback extraInfo:nil];
}

-(BOOL)getInitialization:(NSString *)sapid  observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo
{

    
    NSString *requestStr = [NSString stringWithFormat:@"?sapid=%@&%@",sapid,[self getBaseUrlParem]];
    return [self sendRequest:[NSString stringWithFormat:@"%@%@%@",BU_BUSINESS_DOMAIN_HOME,@"",requestStr]
                        head:nil
                      method:@"GET"
                       async:YES
             inputInvocation:nil
            outputInvocation:BSGetInvocationFromSel(self, @selector(getInitializationDataOutput:ok:input:))
                    observer:observer
                      action:callback
                   extraInfo:extraInfo];
}

-(NSError *)getInitializationDataOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input
{
    UNPACKETOUTPUTHEAD(recvData, ok);
    //    [RequestStatus setRequestResultStatus:jsonObj];
    _notices = nil;
    _services = nil;
    _banners = nil;
    [(BSJSON *)[jsonObj objectForKey:@"data"] deserialization:self];
    
    return SuccessedError;
}

-(BOOL)getServicesType:(NSString *)sapid  observer:(id)observer callback:(SEL)callback
{
    return [self getServicesType:sapid observer:observer callback:callback extraInfo: nil];
}

-(BOOL)getServicesType:(NSString *)sapid  observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo
{
    NSString *requestStr = [NSString stringWithFormat:@"?sapid=%@&tel=%@&%@",sapid,busiSystem.agent.tel?:@"0",[self getBaseUrlParem]];
    return [self sendRequest:[NSString stringWithFormat:@"%@%@%@",BU_BUSINESS_DOMAIN_HOME,@"",requestStr]
                        head:nil
                      method:@"GET"
                       async:YES
             inputInvocation:nil
            outputInvocation:BSGetInvocationFromSel(self, @selector(getServicesTypeDataOutput:ok:input:))
                    observer:observer
                      action:callback
                   extraInfo:extraInfo];
}

-(NSError *)getServicesTypeDataOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input
{
    UNPACKETOUTPUTHEAD(recvData, ok);
    //    [RequestStatus setRequestResultStatus:jsonObj];

    _serviceTypes = nil;

    [(BSJSON *)jsonObj deserializationSpecifityMap:self map:@{@"data":@"BUServices,serviceTypes"}];
    
    return SuccessedError;
}

-(BOOL)submitUsService:(NSArray *)service observer:(id)observer callback:(SEL)callback
{
    return [self submitUsService:service observer:observer callback:callback extraInfo:nil];
}

-(BOOL)submitUsService:(NSArray *)service observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo
{

    NSInvocation *input = BSGetInvocationFromSel(self, @selector(submitUsServiceInput:));
    [input setArgument:&service atIndex:2];
//    [input setr];
  
    return [self sendRequest:[NSString stringWithFormat:@"%@%@",BU_BUSINESS_DOMAIN_HOME,@""]
                        head:nil
                      method:@"POST"
                       async:YES
             inputInvocation:input
            outputInvocation:BSGetInvocationFromSel(self, @selector(submitUsServiceOutput:ok:input:))
                    observer:observer
                      action:callback
                   extraInfo:extraInfo];
}

-(NSData *) submitUsServiceInput:(NSArray *)services
{
    NSMutableArray *arr = [NSMutableArray array];
    [services enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        BSJSON *st = [BSJSON new];
        BUServices *ss = obj;
        [st setObject:ss.sstId?:@"" forKey:@"sstId"];
        [st setObject:ss.susId?:@"" forKey:@"susId"];
        [st setObject:ss.imagePath.Image?:@"" forKey:@"imagePath"];
        [st setObject:ss.sapId?:@"" forKey:@"sapId"];
        [st setInt:ss.no forKey:@"no"];
        [st setObject:ss.name?:@"" forKey:@"name"];
        [st setInt:ss.state forKey:@"state"];
        [arr addObject:st];
    }];
//    NSData *data=[NSJSONSerialization dataWithJSONObject:arr options:0 error:nil];//[NSKeyedArchiver archivedDataWithRootObject:arr];[NSJSONSerialization ]
    BSJSON *dataJson = [BSJSON new];//[[BSJSON alloc] initWithData:data encoding:NSUTF8StringEncoding];
   
    [dataJson setObject:arr  forKey:@"data"];
//    BSJSON *js = [dataJson objectForKey:@"value"];
    
    NSString *result =  [dataJson serializationHelper];
//    result = [result stringByReplacingOccurrencesOfString:@"{\"value:\"" withString:@""];
//   result = [result substringToIndex:result.length - 2];
    result = [NSString stringWithFormat:@"%@&value=%@",[self getBaseUrlParem],result];
    //    result = [result substringFromIndex:1];
    //    result  = [result substringToIndex:result.length - 1];
    //    result = [result stringByAppendingString:@","];
    //    NSMutableString *str = [NSMutableString stringWithString:[[self getBaseUrlParemDic] dataTOjsonString]];
    //    [str insertString:result atIndex:1];
    return [ result dataUsingEncoding:NSUTF8StringEncoding];
}



-(NSError *)submitUsServiceOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input
{
    UNPACKETOUTPUTHEAD(recvData, ok);
    //    [self setRequestStatus:jsonObj];
//    _imagetid = nil;
//    [(BSJSON *)[jsonObj objectForKey:@"data" ] deserialization:self];
    return SuccessedError;
}
-(BOOL)carousel:(id)observer callback:(SEL)callback
{
    return [self carousel:observer callback:callback extraInfo:nil];
}

-(BOOL)carousel:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo
{
     NSString* token = busiSystem.agent.token?:@"";
     NSString*  sourceType = @"2";
     NSInvocation *input = BSGetInvocationFromSel(self, @selector(carouselInput: withSourcetype:));
     [input setArgument:&token atIndex:2];
     [input setArgument:&sourceType atIndex:3];
     [input retainArguments];
     return [self sendRequest:[NSString stringWithFormat:@"%@%@",BU_BUSINESS_DOMAIN_INDEX,BU_BUSINESS_Carousel]
                         head:nil
                       method:@"POST"
                        async:YES
              inputInvocation:input
             outputInvocation:BSGetInvocationFromSel(self, @selector(carouselOutput:ok:input:))
                     observer:observer
                       action:callback
                    extraInfo:extraInfo];
     
}

-(NSData *)carouselInput:(NSString*) token withSourcetype:(NSString*) sourceType
{
     NSString *request = [NSString stringWithFormat:@"%@&sourceType=%@",[self getBaseUrlParem],sourceType];
     return [request dataUsingEncoding:NSUTF8StringEncoding];
     
}

-(NSError *)carouselOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input

{
     UNPACKETOUTPUTHEAD(recvData, ok);
     _banners = nil;
     [(BSJSON *)jsonObj deserializationSpecifityMap:self map:@{@"data":@"BUBanners,banners"}];
     return SuccessedError;
     
}


-(BOOL)getIndex:(id)observer callback:(SEL)callback
{
     return [self getIndex:observer callback:callback extraInfo:nil];
}

-(BOOL)getIndex:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo
{

     NSInvocation *input = BSGetInvocationFromSel(self, @selector(getIndexInput));
//     [input setArgument:&token atIndex:2];
//     [input setArgument:&sourceType atIndex:3];
     [input retainArguments];
     return [self sendRequest:[NSString stringWithFormat:@"%@%@",BU_BUSINESS_DOMAIN_HOMEINDEX,BU_BUSINESS_GetIndex]
                         head:nil
                       method:@"POST"
                        async:YES
              inputInvocation:input
             outputInvocation:BSGetInvocationFromSel(self, @selector(getIndexOutput:ok:input:))
                     observer:observer
                       action:callback
                    extraInfo:extraInfo];
     
}




-(NSData *)getIndexInput
{
     NSString *request = [NSString stringWithFormat:@"%@&userId=%@",[self getBaseUrlParem],busiSystem.agent.userId?:@""];
     return [request dataUsingEncoding:NSUTF8StringEncoding];
     
}

-(NSError *)getIndexOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input

{
     UNPACKETOUTPUTHEAD(recvData, ok);
     _bannerAndQuickMenu = nil;
     [(BSJSON *)jsonObj deserializationSpecifityMap:self map:@{@"data":@"BUBannerAndQuickMenu,bannerAndQuickMenu"}];
//     busiSystem.agent.isDaySigin = _bannerAndQuickMenu.isDaySigin;
     return SuccessedError;
     
}


-(BOOL)getIndexActivity:(id)observer callback:(SEL)callback
{
     return [self getIndexActivity:observer callback:callback extraInfo:nil];
}

-(BOOL)getIndexActivity:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo
{
     
     NSInvocation *input = BSGetInvocationFromSel(self, @selector(getIndexActivityInput));
     //     [input setArgument:&token atIndex:2];
     //     [input setArgument:&sourceType atIndex:3];
     [input retainArguments];
     return [self sendRequest:[NSString stringWithFormat:@"%@%@",BU_BUSINESS_DOMAIN_HOMEINDEX,BU_BUSINESS_GetIndexActivity]
                         head:nil
                       method:@"POST"
                        async:YES
              inputInvocation:input
             outputInvocation:BSGetInvocationFromSel(self, @selector(getIndexActivityOutput:ok:input:))
                     observer:observer
                       action:callback
                    extraInfo:extraInfo];
     
}



-(NSData *)getIndexActivityInput
{
     NSString *request = [NSString stringWithFormat:@"%@",[self getBaseUrlParem]];
     return [request dataUsingEncoding:NSUTF8StringEncoding];
     
}


-(NSError *)getIndexActivityOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input

{
     UNPACKETOUTPUTHEAD(recvData, ok);
     _indexActivityList = nil;
     [(BSJSON *)jsonObj deserializationSpecifityMap:self map:@{@"data":@"BUIndexActivity,indexActivityList"}];
     return SuccessedError;
     
}



-(BOOL)getIndexOptimi:(id)observer callback:(SEL)callback
{
     return [self getIndexOptimi:observer callback:callback extraInfo:nil];
}

-(BOOL)getIndexOptimi:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo
{
     
     NSInvocation *input = BSGetInvocationFromSel(self, @selector(getIndexOptimiInput));
     //     [input setArgument:&token atIndex:2];
     //     [input setArgument:&sourceType atIndex:3];
     [input retainArguments];
     return [self sendRequest:[NSString stringWithFormat:@"%@%@",BU_BUSINESS_DOMAIN_HOMEINDEX,BU_BUSINESS_GetIndexOptimi]
                         head:nil
                       method:@"POST"
                        async:YES
              inputInvocation:input
             outputInvocation:BSGetInvocationFromSel(self, @selector(getIndexOptimiOutput:ok:input:))
                     observer:observer
                       action:callback
                    extraInfo:extraInfo];
     
}


-(NSData *)getIndexOptimiInput
{
     NSString *request = [NSString stringWithFormat:@"%@",[self getBaseUrlParem]];
     return [request dataUsingEncoding:NSUTF8StringEncoding];
     
}



-(NSError *)getIndexOptimiOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input

{
     UNPACKETOUTPUTHEAD(recvData, ok);
     _optimizationList = nil;
     [(BSJSON *)jsonObj deserializationSpecifityMap:self map:@{@"data":@"BUOptimization,optimizationList"}];
     return SuccessedError;
     
}


-(BOOL)getProType:(NSString *)search  observer:(id)observer callback:(SEL)callback
{
     return [self getProType:search  observer:observer callback:callback extraInfo:nil];
}

-(BOOL)getProType:(NSString *)search  observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo
{
     
     NSInvocation *input = BSGetInvocationFromSel(self, @selector(getProTypeInput:));
     [input setArgument:&search atIndex:2];
     //     [input setArgument:&sourceType atIndex:3];
     [input retainArguments];
     return [self sendRequest:[NSString stringWithFormat:@"%@%@",BU_BUSINESS_DOMAIN_TYPEMSG,BU_BUSINESS_GetProType]
                         head:nil
                       method:@"POST"
                        async:YES
              inputInvocation:input
             outputInvocation:BSGetInvocationFromSel(self, @selector(getProTypeOutput:ok:input:))
                     observer:observer
                       action:callback
                    extraInfo:extraInfo];
     
}


-(NSData *)getProTypeInput:(NSString *)search
{
     NSString *request = [NSString stringWithFormat:@"search=%@&%@",search,[self getBaseUrlParem]];
     return [request dataUsingEncoding:NSUTF8StringEncoding];
     
}



-(NSError *)getProTypeOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input

{
     UNPACKETOUTPUTHEAD(recvData, ok);
     _getProTypeList = nil;
     [(BSJSON *)jsonObj deserializationSpecifityMap:self map:@{@"data":@"BUClassify,getProTypeList"}];
     return SuccessedError;
     
}



-(BOOL)getTypeInfo:(NSString *)typetId withParentId:(NSString *)parentId  observer:(id)observer callback:(SEL)callback
{
     return [self getTypeInfo:typetId withParentId:parentId  observer:observer callback:callback extraInfo:nil];
}

-(BOOL)getTypeInfo:(NSString *)typetId withParentId:(NSString *)parentId observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo
{
     
     NSInvocation *input = BSGetInvocationFromSel(self, @selector(getTypeInfoInput:withParentId:));
     [input setArgument:&typetId atIndex:2];
     [input setArgument:&parentId atIndex:3];
     [input retainArguments];
     return [self sendRequest:[NSString stringWithFormat:@"%@%@",BU_BUSINESS_DOMAIN_TYPEMSG,BU_BUSINESS_GetTypeInfo]
                         head:nil
                       method:@"POST"
                        async:YES
              inputInvocation:input
             outputInvocation:BSGetInvocationFromSel(self, @selector(getTypeInfoOutput:ok:input:))
                     observer:observer
                       action:callback
                    extraInfo:extraInfo];
     
}


-(NSData *)getTypeInfoInput:(NSString *)typetId withParentId:(NSString *)parentId
{
     NSString *request = [NSString stringWithFormat:@"typetId=%@&parentId=%@&%@",typetId,parentId,[self getBaseUrlParem]];
     return [request dataUsingEncoding:NSUTF8StringEncoding];
     
}



-(NSError *)getTypeInfoOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input

{
     UNPACKETOUTPUTHEAD(recvData, ok);
     _getTypeInfoList = nil;
     [(BSJSON *)jsonObj deserializationSpecifityMap:self map:@{@"data":@"BUHeadGoods,getTypeInfoList"}];
     return SuccessedError;
     
}

-(BOOL)getOptimiInfo:(NSString *)optimizationId  observer:(id)observer callback:(SEL)callback
{
     return [self getOptimiInfo:optimizationId  observer:observer callback:callback extraInfo:nil];
}

-(BOOL)getOptimiInfo:(NSString *)optimizationId  observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo
{
     
     NSInvocation *input = BSGetInvocationFromSel(self, @selector(getOptimiInfoInput:));
     [input setArgument:&optimizationId atIndex:2];
     //     [input setArgument:&sourceType atIndex:3];
     [input retainArguments];
     return [self sendRequest:[NSString stringWithFormat:@"%@%@",BU_BUSINESS_DOMAIN_HOMEINDEX,BU_BUSINESS_OptimiInfo]
                         head:nil
                       method:@"POST"
                        async:YES
              inputInvocation:input
             outputInvocation:BSGetInvocationFromSel(self, @selector(getOptimiInfoOutput:ok:input:))
                     observer:observer
                       action:callback
                    extraInfo:extraInfo];
     
}


-(NSData *)getOptimiInfoInput:(NSString *)optimizationId
{
     NSString *request = [NSString stringWithFormat:@"optimizationId=%@&%@",optimizationId,[self getBaseUrlParem]];
     return [request dataUsingEncoding:NSUTF8StringEncoding];
     
}



-(NSError *)getOptimiInfoOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input

{
     UNPACKETOUTPUTHEAD(recvData, ok);
     _optimization = nil;
     [(BSJSON *)jsonObj deserializationSpecifityMap:self map:@{@"data":@"BUOptimization,optimization"}];
     return SuccessedError;
     
}



@end
