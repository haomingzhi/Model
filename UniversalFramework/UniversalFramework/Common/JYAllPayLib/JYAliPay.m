//
//  JYAliPay.m
//  TestPayApp
//
//  Created by air on 15/6/5.
//  Copyright (c) 2015年 air. All rights reserved.
//

#import "JYAliPay.h"
#import <AlipaySDK/AlipaySDK.h>
@interface JYAliPay()
{
    void (^_completionBlock)(NSDictionary *);
}
@end
@implementation JYAliPay
- (void)payOrder:(NSDictionary *)payInfo
        callback:(void(^)(NSDictionary *resultDic))completionBlock
{
    NSString *rt = payInfo[@"rt"];
    NSString *appScheme = payInfo[@"appScheme"];
//    id target = payInfo[@"target"];
//    NSString *action = payInfo[@"action"];
//   [AlixLibService payOrder:rt AndScheme:appScheme seletor:NSSelectorFromString(action) target:target];
       _completionBlock = completionBlock;
    [[AlipaySDK defaultService] payOrder:rt fromScheme:appScheme callback:^(NSDictionary *resultDic) {
        NSLog(@"reslut = %@",resultDic);
        _completionBlock(resultDic);
    }];
}

-(BOOL)payResult:(id)dataDic
{
    NSDictionary *dic = dataDic;
    NSURL *url = dic[@"url"];
    if ([url.host isEqualToString:@"safepay"]) {
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"uuuuuu result = %@",resultDic);
//                                                         NSString *resultStr = resultDic[@"result"];
                                                         _completionBlock(resultDic);
        }];
//        [[AlipaySDK defaultService] processAuth_V2Result:url
//                                         standbyCallback:^(NSDictionary *resultDic) {
//                                             NSLog(@"result = %@",resultDic);
//                                             NSString *resultStr = resultDic[@"result"];
//                                             _completionBlock(resultDic);
//                                         }];
        
    }
    return YES;
}

+ (instancetype )manager
{
    static dispatch_once_t  onceToken;
    static JYAliPay * sSharedInstance;
    
    dispatch_once(&onceToken, ^{
        sSharedInstance = [[JYAliPay alloc] init];
        //        sSharedInstance->_dataDic = [NSMutableDictionary dictionary];
    });
    return sSharedInstance;
}
@end
