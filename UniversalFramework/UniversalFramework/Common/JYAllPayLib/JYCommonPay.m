//
//  JYCommonPay.m
//  TestPayApp
//
//  Created by air on 15/6/5.
//  Copyright (c) 2015年 air. All rights reserved.
//

#import "JYCommonPay.h"
#import "JYAliPay.h"
#import "JYUPPay.h"
#import "JYWxPay.h"
#import "JYUPAPay.h"
@interface JYCommonPay()
{
    NSMutableDictionary *_payWayDic;
}
@end
@implementation JYCommonPay
- (void)payOrder:(NSDictionary *)payInfo
        callback:(void(^)(NSDictionary *resultDic))completionBlock;
{
    if (_delegate) {
        [_delegate payOrder:payInfo callback:completionBlock];
    }
    else
    {
        NSLog(@"delegate 还未实现");
    }
}
-(BOOL)payResult:(NSDictionary *)dataDic;
{
    if (_delegate) {
       return  [_delegate payResult:dataDic];
    }
    else
    {
        NSLog(@"delegate 还未实现");
    }
    return YES;
}

+ (instancetype )manager
{
    static dispatch_once_t  onceToken;
    static JYCommonPay * sSharedInstance;
    
    dispatch_once(&onceToken, ^{
        sSharedInstance = [[JYCommonPay alloc] init];
        //        sSharedInstance->_dataDic = [NSMutableDictionary dictionary];
        sSharedInstance->_payWayDic = [NSMutableDictionary dictionaryWithDictionary:@{kAlipayWay:[JYAliPay manager],kUPPayWay:[JYUPPay manager],kWxPayWay:[JYWxPay manager],kUPAPayWay:[JYUPAPay manager]}];
        sSharedInstance->_delegate = sSharedInstance->_payWayDic[kAlipayWay];
    });
    return sSharedInstance;
}
-(void)setPayWay:(NSString *)payWay 
{
    if ( _payWayDic[payWay]) {
       _delegate =  _payWayDic[payWay];
    }
   else
   {
       NSLog(@"不存在这种付款方式");
   }
//    _ = payWay;
}
-(void)initPay:(NSDictionary *)dataDic
{
    if(dataDic[kWxPayWay])
    {
        [[JYWxPay manager] registerAppId:dataDic[@"appId"] withDescription:dataDic[@"des"]];
    }
        if(dataDic[kUPPayWay])
        {
        
        }

}
//-(NSString *)payWay
//{
//    return _payWay;
//}

-(void)registerNewPayWay:(NSString *)key value:(NSString*)theValue
{
    //检查thevalue对象是否实现jycommondelegate协议
    _payWayDic[key] = theValue;
}
@end
