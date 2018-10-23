//
//  JYUPPay.m
//  TestPayApp
//
//  Created by air on 15/6/5.
//  Copyright (c) 2015年 air. All rights reserved.
//

#import "JYUPPay.h"
//#import "UPPayPlugin.h"
#import "UPPaymentControl.h"
//#import "UPPaymentControl.h"
@interface JYUPPay()
{
    void (^_completionBlock)(NSDictionary *);
    
}
@end
@implementation JYUPPay
- (void)payOrder:(NSDictionary *)payInfo
        callback:(void(^)(NSDictionary *resultDic))completionBlock
{
   NSString *rt = payInfo[@"rt"];
    UIViewController *vc = payInfo[@"viewcontroller"];
    NSString *mode = payInfo[@"mode"];
    if (!rt||!vc||!mode) {
        return;
    }
       _completionBlock = completionBlock;
//    [UPPayPlugin startPay:rt mode:mode viewController:vc delegate:self];
    [[UPPaymentControl defaultControl] startPay:rt fromScheme:@"UPPayDemo" mode:mode viewController:vc];
}

-(BOOL)payResult:(NSDictionary *)dataDic;
{
    NSDictionary *dic = dataDic;
    NSURL *url = dic[@"url"];
    [[UPPaymentControl defaultControl] handlePaymentResult:url completeBlock:^(NSString *code, NSDictionary *data) {
        
        if([code isEqualToString:@"success"]) {
            
            //如果想对结果数据验签，可使用下面这段代码，但建议不验签，直接去商户后台查询交易结果
            if(data != nil){
//                //数据从NSDictionary转换为NSString
//                NSData *signData = [NSJSONSerialization dataWithJSONObject:data
//                                                                   options:0
//                                                                     error:nil];
//                NSString *sign = [[NSString alloc] initWithData:signData encoding:NSUTF8StringEncoding];
//                
//                //此处的verify建议送去商户后台做验签，如要放在手机端验，则代码必须支持更新证书
//                if([self verify:sign]) {
//                    //验签成功
//                }
//                else {
//                    //验签失败
//                }
            }
            
            //结果code为成功时，去商户后台查询一下确保交易是成功的再展示成功
        }
        else if([code isEqualToString:@"fail"]) {
            //交易失败
        }
        else if([code isEqualToString:@"cancel"]) {
            //交易取消
        }

    }];
    return YES;
}

#pragma mark UPPayPluginResult
- (void)UPPayPluginResult:(NSString *)result
{
    NSLog(@"%@",result);
    _completionBlock(@{@"result":result});
//    NSString* msg = [NSString stringWithFormat:kResult, result];
//    [self showAlertMessage:result];
}

+ (instancetype )manager
{
    static dispatch_once_t  onceToken;
    static JYUPPay * sSharedInstance;
    
    dispatch_once(&onceToken, ^{
        sSharedInstance = [[JYUPPay alloc] init];
//        sSharedInstance->_dataDic = [NSMutableDictionary dictionary];
    });
    return sSharedInstance;
}

@end
