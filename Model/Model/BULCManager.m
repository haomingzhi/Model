//
//  BULCManager.m
//  lovecommunity
//
//  Created by air on 16/7/11.
//  Copyright © 2016年 ORANLLC_IOS1. All rights reserved.
//

#import "BULCManager.h"
#import "BUSystem.h"
@implementation BULCManager

-(id)init
{
    self = [super init];
    if(self){
       // self.head = @{@"Content-Type":@"application/json"};
    }
    return self;
}

-(NSString *)getBaseUrlParem
{
     NSString *sign = [busiSystem.agent getSign];
     NSMutableString *str = [NSMutableString string];
     [str appendFormat:@"timeStamp=%@&appId=%@&nonce=%@&sign=%@&token=%@",busiSystem.agent.timeStr,MyAppKey,busiSystem.agent.random,sign,busiSystem.agent.token?:@""];
     return str;
}
-(NSString *)appId
{
     return MyAppKey;
}

-(NSString *)nonce
{
     return busiSystem.agent.random;
}

-(NSString *)sign
{
     return [busiSystem.agent getSign];
}

-(NSString *)timeStamp
{
     return busiSystem.agent.timeStr;
}
-(NSDictionary *)getBaseUrlParemDic
{
     NSString *sign = [busiSystem.agent getSign];
     return @{@"sign":sign,@"appId":MyAppKey,@"timeStamp":busiSystem.agent.timeStr,@"nonce":busiSystem.agent.random,@"token":busiSystem.agent.token?:@""};
}

//-(NSString *)getCorners
//{
//   return  [busiSystem.agent.concerns componentsJoinedByString:@","];
// 
//}
@end
