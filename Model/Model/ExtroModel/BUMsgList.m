//
//  BUMsgList.m
//  ulife
//
//  Created by sunmax on 16/1/6.
//  Copyright © 2016年 ORANLLC_IOS1. All rights reserved.
//

#import "BUMsgList.h"

@implementation BUMsgList
- (id)init
{
    self = [super init];
    if (self) {
        self.deserializationMap = @{@"BUImageRes":@"BUImageRes",@"Images":@"BUImageRes,Images"};
    }
    return self;
}

@end
