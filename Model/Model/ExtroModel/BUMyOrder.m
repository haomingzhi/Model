//
//  BUMyOrder.m
//  JiXie
//
//  Created by ORANLLC_IOS1 on 15/6/25.
//  Copyright (c) 2015年 ORANLLC_IOS1. All rights reserved.
//

#import "BUMyOrder.h"
#import "BUSystem.h"

@implementation BUMyOrder
{

}
//-(id) init
//{
//    self = [super init];
//    if (self) {
//        self.deserializationMap = @{@"BUImageRes":@"BUImageRes",@"img":@"BUImageRes",@"id":@"orderId",@"sn":@"orderSn"};
//         
//    }
//    return self;
//}
//
//-(BUImageRes *) image
//{
//    if (self.img.count >0) {
//        return (BUImageRes *)self.img[0];
//    }
//    else return  NULL;
//}
//
-(NSString *) orderStatusDescript
{

    NSArray *sdList = @[@"待付款",@"已付款",@"已发货",@"交易成功",@"交易关闭"];
    if ([self.status integerValue] < sdList.count) {
        return sdList[[self.status integerValue]];
    }
    return NULL;
    
}




//请求支付
-(BOOL) requestPay:(NSString *)num withPayWay:(NSString *)payway withType:(NSString *)theType withArea:(NSString *)areaId observer:(id)observer callback:(SEL) callback
{
    NSInvocation *input = BSGetInvocationFromSel(self, @selector(updateReceiveInput:PayMethod:Type:AreaId:));
    [input setArgument:&num atIndex:2];
    [input setArgument:&payway atIndex:3];
    [input setArgument:&theType atIndex:4];
  
        [input setArgument:&areaId atIndex:5];
    
    
    [input retainArguments];
    return [self sendRequest:[NSString stringWithFormat:@"%@%@",busiSystem.apiHost,BU_BUSINESS_OrderPay]
                        head:nil
                      method:@"POST"
                       async:YES
             inputInvocation:input
            outputInvocation:BSGetInvocationFromSel(self, @selector(requestPayOutput:ok:input:))
                    observer:observer
                      action:callback
                   extraInfo:nil];
}



//取消订单
-(BOOL) cancelOrder:(id)observer callback:(SEL) callback
{
    return [self sendRequest:[NSString stringWithFormat:@"%@%@&id=%@",busiSystem.apiHost,@"",self.orderId]
                        head:nil
                      method:@"GET"
                       async:YES
             inputInvocation:nil
            outputInvocation:BSGetInvocationFromSel(self, @selector(noDataOutput:ok:input:))
                    observer:observer
                      action:callback
                   extraInfo:nil];
}
//提醒卖家
-(BOOL) noticeficationSeller :(id)observer callback:(SEL) callback
{
    return [self sendRequest:[NSString stringWithFormat:@"%@%@&id=%@",busiSystem.apiHost,@"",self.orderId]
                        head:nil
                      method:@"GET"
                       async:YES
             inputInvocation:nil
            outputInvocation:BSGetInvocationFromSel(self, @selector(noDataOutput:ok:input:))
                    observer:observer
                      action:callback
                   extraInfo:nil];
}

//确认收货
-(BOOL) confirmOrder:(id)observer callback:(SEL) callback
{
    return [self sendRequest:[NSString stringWithFormat:@"%@%@&id=%@",busiSystem.apiHost,@"",self.orderId]
                        head:nil
                      method:@"GET"
                       async:YES
             inputInvocation:nil
            outputInvocation:BSGetInvocationFromSel(self, @selector(noDataOutput:ok:input:))
                    observer:observer
                      action:callback
                   extraInfo:nil];
}
//删除订单
-(BOOL) deleteOrder:(id)observer callback:(SEL) callback
{
    return [self sendRequest:[NSString stringWithFormat:@"%@%@&id=%@",busiSystem.apiHost,@"",self.orderId]
                        head:nil
                      method:@"GET"
                       async:YES
             inputInvocation:nil
            outputInvocation:BSGetInvocationFromSel(self, @selector(noDataOutput:ok:input:))
                    observer:observer
                      action:callback
                   extraInfo:nil];
}


#pragma mark --IO



-(NSError *)noDataOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input
{
    UNPACKETOUTPUTHEAD(recvData, ok);
     [RequestStatus setRequestResultStatus:jsonObj];
    return SuccessedError;
}


-(NSError *)requestPayOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input
{
    //NSLog(@"%@",[[NSString alloc] initWithData:recvData encoding:NSUTF8StringEncoding]);
    UNPACKETOUTPUTHEAD(recvData, ok);
    BSJSON *jsonData = (BSJSON *)[jsonObj objectForKey:@"Data"];
     [RequestStatus setRequestResultStatus:jsonObj];
    self.payMethod =  [[jsonData objectForKey:@"payMethod"] integerValue];
    self.payInfo = [jsonData objectForKey:@"Info"];
    return SuccessedError;
}
#pragma mark --private

-(NSData *) updateReceiveInput:(NSString *)Num PayMethod:(NSString *) PayMethod Type:(NSString *) Type AreaId:(NSString *) AreaId
{
    NSMutableDictionary *dataJson = [NSMutableDictionary dictionary];
    [dataJson setObject:PayMethod forKey:@"PayMethod"];
//    if (UserId) {
        [dataJson setObject:Num forKey:@"Num"];
//    }
    
    [dataJson setObject:Type forKey:@"Type"];
    [dataJson setObject:AreaId  forKey:@"AreaId"];
    [dataJson setObject:busiSystem.agent.userId forKey:@"Uid"];
    
    
    NSString *result =  [dataJson toContentString];
    return [ result dataUsingEncoding:NSUTF8StringEncoding];
}

@end
