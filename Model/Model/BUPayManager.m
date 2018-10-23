//
//  BUPayManager.m
//  taihe
//
//  Created by air on 2016/12/15.
//  Copyright © 2016年 ORANLLC_IOS1. All rights reserved.
//

#import "BUPayManager.h"
#import "BUSystem.h"

@implementation BUOrderPay
-(id)init
{
    self = [super init];
    if(self){
        self.deserializationMap = @{@"message":@"NSString,msg",@"cardList":@"BUGetUserGiftCard,cardList"};
    }
    return self;
}
@end


@implementation BUPayManager

-(BOOL)orderPay:(NSString *)payType withOrderid:(NSString *)orderId sourceType:(NSString *)sourceType orderType:(NSString *)orderType typeId:(NSString *)typeId observer:(id)observer callback:(SEL)callback
{
    return [self orderPay:payType withOrderid:orderId sourceType: sourceType orderType:(NSString *)orderType typeId:(NSString *)typeId observer:observer callback:callback extraInfo:nil];
}

-(BOOL)orderPay:(NSString*) payType withOrderid:(NSString*) orderId sourceType:(NSString*) sourceType orderType:(NSString *)orderType typeId:(NSString *)typeId observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo
{
    NSString *userId = busiSystem.agent.userId?:@"";
    NSInvocation *input = BSGetInvocationFromSel(self, @selector(orderPayInput:withOrderid:sourceType:userId:orderType:typeId:));
    [input setArgument:&payType atIndex:2];
    [input setArgument:&orderId atIndex:3];
    [input setArgument:&sourceType atIndex:4];
    [input setArgument:&userId atIndex:5];
     [input setArgument:&orderType atIndex:6];
     [input setArgument:&typeId atIndex:7];
    [input retainArguments];
    return [self sendRequest:[NSString stringWithFormat:@"%@%@",BU_BUSINESS_DOMAIN_MYPATH,BU_BUSINESS_PayOrder]
                        head:nil
                      method:@"POST"
                       async:YES
             inputInvocation:input
            outputInvocation:BSGetInvocationFromSel(self, @selector(orderPayOutput:ok:input:))
                    observer:observer
                      action:callback
                   extraInfo:extraInfo];
    
}


-(NSData *)orderPayInput:(NSString*) payType withOrderid:(NSString*) orderId sourceType:(NSString*) sourceType userId:(NSString*) userId orderType:(NSString *)orderType typeId:(NSString *)typeId
{
    NSString *request = [NSString stringWithFormat:@"payType=%@&orderId=%@&userId=%@&sourceType=%@&orderType=%@&typeId=%@&%@",payType,orderId,userId,sourceType,orderType,typeId,[self getBaseUrlParem]];
    return [request dataUsingEncoding:NSUTF8StringEncoding];
    
}

-(NSError *)orderPayOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input

{
    UNPACKETOUTPUTHEAD(recvData, ok);
    _payBody = nil;
     [(BSJSON *)[jsonObj objectForKey:@"data"] deserializationSpecifityMap:self map:@{@"payBody":@"NSString,payBody"}];
    return SuccessedError;
    
}


-(BOOL)upOrder:(NSString *)orderId observer:(id)observer callback:(SEL)callback
{
     return [self upOrder:orderId observer:observer callback:callback extraInfo:nil];
}

-(BOOL)upOrder:(NSString*)orderId observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo
{
//     NSString *userId = busiSystem.agent.userId?:@"";
     NSInvocation *input = BSGetInvocationFromSel(self, @selector(upOrderInput:));
     [input setArgument:&orderId atIndex:2];

     [input retainArguments];
//     NSDictionary *head = @{@"Content-Type":@"application/json"};
     return [self sendRequest:[NSString stringWithFormat:@"%@%@",BU_BUSINESS_DOMAIN_MYPATH,BU_BUSINESS_UpOrder]
                         head:nil
                       method:@"POST"
                        async:YES
              inputInvocation:input
             outputInvocation:BSGetInvocationFromSel(self, @selector(upOrderOutput:ok:input:))
                     observer:observer
                       action:callback
                    extraInfo:extraInfo];
     
}


-(NSData *)upOrderInput:(NSString*)orderId
{
     NSString *request = [NSString stringWithFormat:@"Orderid=%@",orderId];
     return [request dataUsingEncoding:NSUTF8StringEncoding];
     
}

-(NSError *)upOrderOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input

{
     UNPACKETOUTPUTHEAD(recvData, ok);
     _payBody = nil;
     [(BSJSON *)[jsonObj objectForKey:@"data"] deserializationSpecifityMap:self map:@{@"payBody":@"NSString,payBody"}];
     return SuccessedError;
     
}

-(BOOL)getPublicAppAuthorize:(NSString*) userId withUserTrueName:(NSString*)UserTrueName withIDCard:(NSString *)IDCard observer:(id)observer callback:(SEL)callback
{
     return [self getPublicAppAuthorize: userId withUserTrueName:(NSString*)UserTrueName withIDCard:(NSString *)IDCard observer:observer callback:callback extraInfo:nil];
}

-(BOOL)getPublicAppAuthorize:(NSString*) userId withUserTrueName:(NSString*)UserTrueName withIDCard:(NSString *)IDCard observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo
{
     NSInvocation *input = BSGetInvocationFromSel(self, @selector(getPublicAppAuthorizeInput: withUserTrueName: withIDCard:));
     [input setArgument:&userId atIndex:2];
     [input setArgument:&UserTrueName atIndex:3];
     [input setArgument:&IDCard atIndex:4];
     [input retainArguments];
     return [self sendRequest:[NSString stringWithFormat:@"%@%@",BU_BUSINESS_DOMAIN_PAY,BU_BUSINESS_GetPublicAppAuthorize]
                         head:nil
                       method:@"POST"
                        async:YES
              inputInvocation:input
             outputInvocation:BSGetInvocationFromSel(self, @selector(getPublicAppAuthorizeOutput:ok:input:))
                     observer:observer
                       action:callback
                    extraInfo:extraInfo];

}


-(NSData *)getPublicAppAuthorizeInput:(NSString*) userId withUserTrueName:(NSString*)UserTrueName withIDCard:(NSString *)IDCard
{
     NSString *request = [NSString stringWithFormat:@"userId=%@&UserTrueName=%@&IDCard=%@",userId,UserTrueName,IDCard];
     return [request dataUsingEncoding:NSUTF8StringEncoding];

}

-(NSError *)getPublicAppAuthorizeOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input

{
     UNPACKETOUTPUTHEAD(recvData, ok);
     _zmUrl = nil;
     [(BSJSON *)jsonObj  deserializationSpecifityMap:self map:@{@"data":@"NSString,zmUrl"}];
     return SuccessedError;

}


-(BOOL)getZhimaCreditScore:(NSString*) userId observer:(id)observer callback:(SEL)callback
{
     return [self getZhimaCreditScore: userId observer:observer callback:callback extraInfo:nil];
}

-(BOOL)getZhimaCreditScore:(NSString*) userId observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo
{
     NSInvocation *input = BSGetInvocationFromSel(self, @selector(getZhimaCreditScoreInput:));
     [input setArgument:&userId atIndex:2];
     [input retainArguments];
     return [self sendRequest:[NSString stringWithFormat:@"%@%@",BU_BUSINESS_DOMAIN_PAY,BU_BUSINESS_GetZhimaCreditScore]
                         head:nil
                       method:@"POST"
                        async:YES
              inputInvocation:input
             outputInvocation:BSGetInvocationFromSel(self, @selector(getZhimaCreditScoreOutput:ok:input:))
                     observer:observer
                       action:callback
                    extraInfo:extraInfo];

}


-(NSData *)getZhimaCreditScoreInput:(NSString*) userId
{
     NSString *request = [NSString stringWithFormat:@"UserId=%@",userId];
     return [request dataUsingEncoding:NSUTF8StringEncoding];

}

-(NSError *)getZhimaCreditScoreOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input

{
     UNPACKETOUTPUTHEAD(recvData, ok);

     return SuccessedError;

}

@end
