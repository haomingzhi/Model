//
//  BUSearch.m
//  ulife
//
//  Created by sunmax on 16/1/12.
//  Copyright © 2016年 ORANLLC_IOS1. All rights reserved.
//

#import "BUSearch.h"
#import "BUSystem.h"

@implementation UserList
- (id)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

@end


@implementation BUSearch
- (id)init
{
    self = [super init];
    if (self) {
        self.deserializationMap = @{@"UserList":@"UserList,UserList"};
        _uList =[UserList new];
    }
    return self;
}

-(BOOL) searchUser:(NSString *)name Observer:(id) observer callback:(SEL) callback
{
    name = [name stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return [self sendRequest:[NSString stringWithFormat:@"%@%@&Uid=%@&Name=%@",busiSystem.apiHost,BU_BUSINESS_searchUser,busiSystem.agent.userId,name]
                        head:nil
                      method:@"GET"
                       async:YES
             inputInvocation:nil
            outputInvocation:BSGetInvocationFromSel(self, @selector(searchUserOutput:ok:input:))
                    observer:observer
                      action:callback
                   extraInfo:nil];
}

//我发布的资讯列表
-(NSError *)searchUserOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input
{
    UNPACKETOUTPUTHEAD(recvData, ok);
    [((BSJSON *)[jsonObj objectForKey:@"Data"])  deserialization:self];
     [RequestStatus setRequestResultStatus:jsonObj];
    return SuccessedError;
}

@end
