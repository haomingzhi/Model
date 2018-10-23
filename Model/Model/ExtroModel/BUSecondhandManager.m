//
//  BUSecondhandManager.m
//  intelligentgarbagecollection
//
//  Created by air on 2017/12/7.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import "BUSecondhandManager.h"

@implementation BUSecondhandManager
-(id)init
{
     self = [super init];
     if(self){
          self.deserializationMap = @{@"BUImageRes":@"BUImageRes"};
          _getSecondhandGoodsListManager = [BUGetSecondhandGoodsListManager new];
     }
     return self;
}

-(BOOL)getSecondhandGoods:(NSString*) sid observer:(id)observer callback:(SEL)callback
{
     return [self getSecondhandGoods: sid observer:observer callback:callback extraInfo:nil];
}

-(BOOL)getSecondhandGoods:(NSString*) sid observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo
{
     NSInvocation *input = BSGetInvocationFromSel(self, @selector(getSecondhandGoodsInput:));
     [input setArgument:&sid atIndex:2];
     [input retainArguments];
     return [self sendRequest:[NSString stringWithFormat:@"%@%@",BU_BUSINESS_DOMAIN_SECONDHAND,BU_BUSINESS_GetSecondhandGoods]
                         head:nil
                       method:@"POST"
                        async:YES
              inputInvocation:input
             outputInvocation:BSGetInvocationFromSel(self, @selector(getSecondhandGoodsOutput:ok:input:))
                     observer:observer
                       action:callback
                    extraInfo:extraInfo];

}


-(NSData *)getSecondhandGoodsInput:(NSString*) sid
{
     NSString *request = [NSString stringWithFormat:@"id=%@&%@",sid,[self getBaseUrlParem]];
     return [request dataUsingEncoding:NSUTF8StringEncoding];

}

-(NSError *)getSecondhandGoodsOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input

{
     UNPACKETOUTPUTHEAD(recvData, ok);
     _secGoods = nil;
      [(BSJSON *)jsonObj deserializationSpecifityMap:self map:@{@"data":@"BUGetSecondhandGoods,secGoods"}];
     return SuccessedError;

}

-(BOOL)saveSecondhandGoods:(NSString*) userId withContent:(NSString*) content withAddress:(NSString*) address withLongitude:(NSString*) longitude withGoodsid:(NSString*) goodsId withPrice:(NSString*) price withLatitude:(NSString*) latitude withImagelist:(NSArray*) imageList withName:(NSString*) name withCityname:(NSString*) cityName observer:(id)observer callback:(SEL)callback
{
     return [self saveSecondhandGoods: userId withContent: content withAddress: address withLongitude: longitude withGoodsid: goodsId withPrice: price withLatitude: latitude withImagelist: imageList withName: name withCityname: cityName observer:observer callback:callback extraInfo:nil];
}

-(BOOL)saveSecondhandGoods:(NSString*) userId withContent:(NSString*) content withAddress:(NSString*) address withLongitude:(NSString*) longitude withGoodsid:(NSString*) goodsId withPrice:(NSString*) price withLatitude:(NSString*) latitude withImagelist:(NSArray*) imageList withName:(NSString*) name withCityname:(NSString*) cityName observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo
{
     NSInvocation *input = BSGetInvocationFromSel(self, @selector(saveSecondhandGoodsInput: withContent: withAddress: withLongitude: withGoodsid: withPrice: withLatitude: withImagelist: withName: withCityname:));
     [input setArgument:&userId atIndex:2];
     [input setArgument:&content atIndex:3];
     [input setArgument:&address atIndex:4];
     [input setArgument:&longitude atIndex:5];
     [input setArgument:&goodsId atIndex:6];
     [input setArgument:&price atIndex:7];
     [input setArgument:&latitude atIndex:8];
     [input setArgument:&imageList atIndex:9];
     [input setArgument:&name atIndex:10];
     [input setArgument:&cityName atIndex:11];
     [input retainArguments];
     return [self sendRequest:[NSString stringWithFormat:@"%@%@",BU_BUSINESS_DOMAIN_SECONDHAND,BU_BUSINESS_SaveSecondhandGoods]
                         head:@{@"Content-Type":@"application/json;charset=UTF-8"}
                       method:@"POST"
                        async:YES
              inputInvocation:input
             outputInvocation:BSGetInvocationFromSel(self, @selector(saveSecondhandGoodsOutput:ok:input:))
                     observer:observer
                       action:callback
                    extraInfo:extraInfo];

}


-(NSData *)saveSecondhandGoodsInput:(NSString*) userId withContent:(NSString*) content withAddress:(NSString*) address withLongitude:(NSString*) longitude withGoodsid:(NSString*) goodsId withPrice:(NSString*) price withLatitude:(NSString*) latitude withImagelist:(NSArray*) imageList withName:(NSString*) name withCityname:(NSString*) cityName
{
//     NSString *request = [NSString stringWithFormat:@"userId=%@&content=%@&address=%@&longitude=%@&goodsId=%@&price=%@&latitude=%@&imageList=%@&name=%@&cityName=%@",userId,content,address,longitude,goodsId,price,latitude,imageList,name,cityName];
//     return [request dataUsingEncoding:NSUTF8StringEncoding];
     BSJSON *dataJson = [BSJSON new];
     [dataJson setObject:userId  forKey:@"userId"];
     [dataJson setObject:content  forKey:@"content"];
     [dataJson setObject:address  forKey:@"address"];
     [dataJson setObject:longitude  forKey:@"longitude"];
     [dataJson setObject:goodsId  forKey:@"goodsId"];
     [dataJson setObject:price  forKey:@"price"];
     [dataJson setObject:latitude  forKey:@"latitude"];
     [dataJson setObject:name  forKey:@"name"];
      [dataJson setObject:cityName  forKey:@"cityName"];
     NSMutableArray *arr = [NSMutableArray new];
     [imageList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
          BUImageRes *i = obj;
//          BSJSON *k = [BSJSON new];
//          [k setObject:i.imgId forKey:@"imgId"];
//          [k setObject:i.tgId forKey:@"tgId"];
//          [k setObject:i.Image forKey:@"imgPath"];
//          [k setObject:@(i.imgType) forKey:@"imgType"];
          [arr addObject:i.Image];
     }];
     [dataJson setObject:arr forKey:@"imageList"];
     [dataJson setObject:self.appId  forKey:@"appId"];
     [dataJson setObject:[self timeStamp] forKey:@"timeStamp"];
     [dataJson setObject:[self nonce] forKey:@"nonce"];
     [dataJson setObject:[self sign] forKey:@"sign"];
     NSData *result =  [[dataJson serializationHelper] dataUsingEncoding:NSUTF8StringEncoding];
     return result;
}

-(NSError *)saveSecondhandGoodsOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input

{
     UNPACKETOUTPUTHEAD(recvData, ok);

     return SuccessedError;

}

-(BOOL)delSecondhandGoods:(NSString*) id withUserid:(NSString*) userId observer:(id)observer callback:(SEL)callback
{
     return [self delSecondhandGoods: id withUserid: userId observer:observer callback:callback extraInfo:nil];
}

-(BOOL)delSecondhandGoods:(NSString*) sid withUserid:(NSString*) userId observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo
{
     NSInvocation *input = BSGetInvocationFromSel(self, @selector(delSecondhandGoodsInput: withUserid:));
     [input setArgument:&sid atIndex:2];
     [input setArgument:&userId atIndex:3];
     [input retainArguments];
     return [self sendRequest:[NSString stringWithFormat:@"%@%@",BU_BUSINESS_DOMAIN_SECONDHAND,BU_BUSINESS_DelSecondhandGoods]
                         head:nil
                       method:@"POST"
                        async:YES
              inputInvocation:input
             outputInvocation:BSGetInvocationFromSel(self, @selector(delSecondhandGoodsOutput:ok:input:))
                     observer:observer
                       action:callback
                    extraInfo:extraInfo];

}


-(NSData *)delSecondhandGoodsInput:(NSString*) sid withUserid:(NSString*) userId
{
     NSString *request = [NSString stringWithFormat:@"id=%@&userId=%@",sid,userId];
     return [request dataUsingEncoding:NSUTF8StringEncoding];

}

-(NSError *)delSecondhandGoodsOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input

{
     UNPACKETOUTPUTHEAD(recvData, ok);

     return SuccessedError;

}
@end
