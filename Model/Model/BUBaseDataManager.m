//
//  BUBaseDataManager.m
//  deliciousfood
//
//  Created by air on 2017/2/27.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import "BUBaseDataManager.h"

@implementation BUBaseDataManager
-(id)init
{
    self = [super init];
    if(self){
        self.deserializationMap = @{@"BUImageRes":@"BUImageRes",@"data":@"dataArr"};
    }
    return self;
}


-(BOOL)getData:(NSDictionary *)dic observer:(id)observer callback:(SEL)callback
{
    return [self getData:dic observer:observer callback:callback extraInfo:nil];
}

-(BOOL)getData:(NSDictionary *)dic observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo
{
    NSString *request = [NSString stringWithFormat:@"?myid=%@&%@",@"",[self getBaseUrlParem]];
    return [self sendRequest:[NSString stringWithFormat:@"%@%@%@",@"",@"",request]
                        head:nil
                      method:@"GET"
                       async:YES
             inputInvocation:nil
            outputInvocation:BSGetInvocationFromSel(self, @selector(getDataOutput:ok:input:))
                    observer:observer
                      action:callback
                   extraInfo:nil];
}

-(NSError *)getDataOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input
{
    UNPACKETOUTPUTHEAD(recvData, ok);
    //    _guidePageArr = [NSMutableArray array];
    //    _getTell = nil;
    //    [(BSJSON *)jsonObj deserializationSpecifityMap:self map:@{@"data":@"BUUserAlreadyAuthList,userAlreadyAuthList"}];
    return SuccessedError;
}

@end
