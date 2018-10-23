//
//  BUAbout.m
//  JiXie
//
//  Created by ORANLLC_IOS1 on 15/6/30.
//  Copyright (c) 2015年 ORANLLC_IOS1. All rights reserved.
//

#import "BUAbout.h"
#import "BUSystem.h"

@implementation BUAbout

-(id) init
{
    self = [super init];
    if (self) {
        self.deserializationMap = @{@"BUImageRes":@"BUImageRes"};
    }
    return self;
}

//-(BOOL) getAboutInfo:(id)observer callback:(SEL)callback
//{
//    return [self sendRequest:[NSString stringWithFormat:@"%@%@",busiSystem.apiHost,BU_BUSINESS_siteInfo]
//                        head:nil
//                      method:@"GET"
//                       async:YES
//             inputInvocation:nil
//            outputInvocation:BSGetInvocationFromSel(self, @selector(getAboutInfoOutput:ok:input:))
//                    observer:observer
//                      action:callback
//                   extraInfo:nil];
//
//}
//
//-(NSError *)getAboutInfoOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input
//{
//    UNPACKETOUTPUTHEAD(recvData, ok);
//    [((BSJSON *)[((BSJSON *)[jsonObj objectForKey:@"data"]) objectForKey:@"info" ]) deserialization:self];
//    return SuccessedError;
//}

@end
