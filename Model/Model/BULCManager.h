//
//  BULCManager.h
//  lovecommunity
//
//  Created by air on 16/7/11.
//  Copyright © 2016年 ORANLLC_IOS1. All rights reserved.
//

#import <UniversalFramework/UniversalFramework.h>
#import "BUPageInfo.h"

@interface BULCManager : BUManager
@property(nonatomic,strong)NSString *appId;
@property(nonatomic,strong)NSString *timeStamp;
@property(nonatomic,strong)NSString *nonce;
@property(nonatomic,strong)NSString *sign;
-(NSString *)getBaseUrlParem;
-(NSDictionary *)getBaseUrlParemDic;

//-(NSString *)getCorners;
@end
