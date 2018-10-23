//
//  BUSysManager.m
//  supermarket
//
//  Created by air on 2017/11/30.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import "BUSysManager.h"

@implementation BUGetSysInfo
@end

@implementation BUInviteInfo
@end

@implementation BUSysManager
-(id)init
{
     self = [super init];
     if(self){
          self.deserializationMap = @{@"BUImageRes":@"BUImageRes"};
//          _sysHelpTypeListManager = [BUGetSysHelpTypeListManager new];
//          _sysHelpTypeMsgListManager = [BUGetSysHelpTypeMsgListManager new];
//          _messageListManager = [BUGetMessageListManager new];
     }
     return self;
}
-(BOOL)getSysInfo:(id)observer callback:(SEL)callback
{
     return [self getSysInfo:observer callback:callback extraInfo:nil];
}

-(BOOL)getSysInfo:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo
{
//     NSString *requestStr = [NSString stringWithFormat:@"?userId=%@&%@",userId,[self getBaseUrlParem]];
     return [self sendRequest:[NSString stringWithFormat:@"%@%@%@",BU_BUSINESS_DOMAIN_SYS,BU_BUSINESS_GetSysInfo,@""]
                         head:nil
                       method:@"GET"
                        async:YES
              inputInvocation:nil
             outputInvocation:BSGetInvocationFromSel(self, @selector(getSysInfoOutput:ok:input:))
                     observer:observer
                       action:callback
                    extraInfo:extraInfo];

}


-(NSError *)getSysInfoOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input

{
     UNPACKETOUTPUTHEAD(recvData, ok);
     _getSysInfo = nil;
        [(BSJSON *)jsonObj deserializationSpecifityMap:self map:@{@"data":@"BUGetSysInfo,getSysInfo"}];
     return SuccessedError;

}

-(BOOL)getInviteInfo:(NSString*) userId observer:(id)observer callback:(SEL)callback
{
     return [self getInviteInfo: userId observer:observer callback:callback extraInfo:nil];
}

-(BOOL)getInviteInfo:(NSString*) userId observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo
{
     NSString *requestStr = [NSString stringWithFormat:@"?userId=%@&%@",userId,[self getBaseUrlParem]];
     return [self sendRequest:[NSString stringWithFormat:@"%@%@%@",BU_BUSINESS_DOMAIN_SYS,BU_BUSINESS_GetInviteInfo,requestStr]
                         head:nil
                       method:@"GET"
                        async:YES
              inputInvocation:nil
             outputInvocation:BSGetInvocationFromSel(self, @selector(getInviteInfoOutput:ok:input:))
                     observer:observer
                       action:callback
                    extraInfo:extraInfo];

}


-(NSError *)getInviteInfoOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input

{
     UNPACKETOUTPUTHEAD(recvData, ok);
     _inviteInfo = nil;
        [(BSJSON *)jsonObj deserializationSpecifityMap:self map:@{@"data":@"BUInviteInfo,inviteInfo"}];
     return SuccessedError;

}

@end
