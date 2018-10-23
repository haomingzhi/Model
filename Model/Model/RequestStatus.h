//
//  RequestStatus.h
//  ulife
//
//  Created by air on 16/2/19.
//  Copyright © 2016年 ORANLLC_IOS1. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RequestStatus : NSObject
@property(nonatomic,strong)NSString *RetCode;
@property(nonatomic,strong)NSString *RetMsg;
+(void)setRequestResultStatus:(BSJSON *)json;
+(BOOL)giveRightResponse;
@end
