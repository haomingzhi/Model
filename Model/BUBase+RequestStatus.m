//
//  BUBase+RequestStatus.m
//  chenxiaoer
//
//  Created by air on 16/3/18.
//  Copyright © 2016年 ORANLLC_IOS1. All rights reserved.
//

#import "BUBase+RequestStatus.h"

@implementation BUBase (RequestStatus)
-(void)setRequestStatus:(BSJSON *)json
{
    [RequestStatus setRequestResultStatus:json];
}
@end
