//
//  JYUPAPay.m
//  TestPayApp
//
//  Created by air on 2017/6/12.
//  Copyright © 2017年 air. All rights reserved.
//

#import "JYUPAPay.h"
#import "UPAPayPluginDelegate.h"
#import "UPAPayPlugin.h"
#include <sys/socket.h> // Per msqr
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>
 
#import <PassKit/PassKit.h>
@interface JYUPAPay()<UPAPayPluginDelegate>
{
    void (^_completionBlock)(NSDictionary *);
    
}
@end
@implementation JYUPAPay
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
    if (rt != nil && rt.length > 0)
    {
        if([PKPaymentAuthorizationViewController canMakePaymentsUsingNetworks:@[PKPaymentNetworkChinaUnionPay]])
        {
    [UPAPayPlugin startPay:rt mode:mode viewController:vc delegate:self andAPMechantID:payInfo[@"kAppleMerchantID"]];
        }
        else
        {
            NSLog(@"苹果支付中无银联卡");
        }
    }
}

-(BOOL)payResult:(NSDictionary *)dataDic;
{
    
    return YES;
}

#pragma mark UPPayPluginResult
-(void) UPAPayPluginResult:(UPPayResult *) result;
{
    NSLog(@"%@",result);
    _completionBlock(@{@"result":result});
    //    NSString* msg = [NSString stringWithFormat:kResult, result];
    //    [self showAlertMessage:result];
}

+ (instancetype )manager
{
    static dispatch_once_t  onceToken;
    static JYUPAPay * sSharedInstance;
    
    dispatch_once(&onceToken, ^{
        sSharedInstance = [[JYUPAPay alloc] init];
        //        sSharedInstance->_dataDic = [NSMutableDictionary dictionary];
    });
    return sSharedInstance;
}

@end
