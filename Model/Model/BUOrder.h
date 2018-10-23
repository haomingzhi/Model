//
//  BUMyOrder.h
//  JiXie
//  用户提交的订单
//  Created by ORANLLC_IOS1 on 15/6/1.
//  Copyright (c) 2015年 ORANLLC_IOS1. All rights reserved.
//


#import "BUImageRes.h"


@interface BUOrder : BUBase


//订单提交
-(BOOL) submit:(id)observer callback:(SEL) callback;


@end
