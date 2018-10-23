//
//  BUPageInfo.m
//  B2C
//
//  Created by air on 15/7/16.
//  Copyright (c) 2015年 ORANLLC_IOS1. All rights reserved.
//

#import "BUPageInfo.h"

@implementation BUPageInfo

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.deserializationMap = @{@"status":@"keywords",@"pid":@"keywords",@"AllPage":@"pageall",@"Page":@"page"};
    }
    return self;
}

-(BOOL) hasMore
{
    return self.pageall > self.page*20;
}

@end
