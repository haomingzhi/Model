//
//  RequestStatus.m
//  ulife
//
//  Created by air on 16/2/19.
//  Copyright © 2016年 ORANLLC_IOS1. All rights reserved.
//

#import "RequestStatus.h"

@implementation RequestStatus

static RequestStatus *a;

+(id)manager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        a = [[RequestStatus alloc] init];
        a->_RetCode = @"0";
        a->_RetMsg = @"";
    });
   
    return a;
}

+(void)setRequestResultStatus:(BSJSON *)jsonObj
{
    id n = [jsonObj objectForKey:@"RetCode"];
     [[RequestStatus manager] setRetCode:[NSString stringWithFormat:@"%@",n]];
    NSString *t = [(RequestStatus *)[RequestStatus manager] RetCode];
    NSString *msg;
    if ([t isEqualToString:@"3"]) {
        msg = @"账号已被冻结了";
    }
    else if([t isEqualToString:@"4"])
    {
      msg = @"账号不存在";
    }
    [[RequestStatus manager] setRetMsg:msg];
}

+(BOOL)giveRightResponse
{
     NSString *t = [(RequestStatus *)[RequestStatus manager] RetCode];
    if ([[(RequestStatus *)[RequestStatus manager] RetCode] isEqualToString:@"3"] ||[[(RequestStatus *)[RequestStatus manager] RetCode] isEqualToString:@"4"]) {
        [CommonAPI tiRenToLogin:[(RequestStatus *)[RequestStatus manager] RetMsg]];
        [[RequestStatus manager] setRetCode:@"0"];
         [[RequestStatus manager] setRetMsg:@""];
        return NO;
    }
    return YES;
}
@end
