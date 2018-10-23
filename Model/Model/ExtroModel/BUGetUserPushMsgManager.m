//
//  BUGetUserPushMsgManager.m
//  compassionpark
//
//  Created by air on 2017/4/10.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import "BUGetUserPushMsgManager.h"

#import "BUSystem.h"
@implementation BUGetUserPushMsg
-(NSDictionary *)getDic
{
    BOOL isShow = _isView == 1?NO:YES;
    NSString *img = @"orderTip";
    if (_msgType == 1) {
//        img = 
    }
    return @{@"title":_title?:@"",@"detail":_content?:@"",@"time":_pushTime?:@"",@"tipImg":img,@"isShowMark":@(isShow)};
}
@end




@implementation BUGetUserPushMsgManager

-(BOOL)getUserPushMsgNextPage:(id)observer callback:(SEL)callback
{
    return [self getUserPushMsgNextPage:observer callback:callback extraInfo:nil];
}


-(BOOL)getUserPushMsgNextPage:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo
{
    BUPageInfo *pageinfo = [[BUPageInfo alloc] init];
    self.pageInfo.page ++;
    pageinfo.page = self.pageInfo.page;
    pageinfo.type = self.pageInfo.type;
    pageinfo.keywords = self.pageInfo.keywords;
    
    //    pageinfo.userInfo = _pageInfo.userInfo;
    return [self getDataList:pageinfo observer:observer callback:callback extraInfo:extraInfo];
}
-(BOOL)getUserPushMsg:(id)observer callback:(SEL)callback
{
    return   [self getUserPushMsg:observer callback:callback extraInfo:nil];
}

-(BOOL)getUserPushMsg:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo
{
    return [self getData:@{} observer:observer callback:callback extraInfo:extraInfo];
}


-(BOOL)getData:(NSDictionary *)dic  observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo
{
    
    self.pageInfo = nil;
    BUPageInfo *pageinfo = [[BUPageInfo alloc] init];
    
    pageinfo.page = 1;
    //    pageinfo.uid = stu;
    return [self getDataList:pageinfo observer:observer callback:callback extraInfo:extraInfo];
    
}


-(BOOL)getDataList:(BUPageInfo *)pageinfo  observer:(id) observer callback:(SEL) callback  extraInfo:(NSDictionary*)extraInfo
{
    
    
    if (!self.pageInfo) {
        self.pageInfo = pageinfo;
    }
    NSString *page = [NSString stringWithFormat:@"%ld",pageinfo.page];
    
    NSInvocation *input = BSGetInvocationFromSel(self, @selector(getDataListInput:withType:withProductType:));
    [input setArgument:&page atIndex:2];
    
    [input retainArguments];
    return [self sendRequest:[NSString stringWithFormat:@"%@%@%@",BU_BUSINESS_DOMAIN_USER,BU_BUSINESS_GetUserPushMsg,@""]
                        head:nil
                      method:@"POST"
                       async:YES
             inputInvocation:input
            outputInvocation:BSGetInvocationFromSel(self, @selector(getDataListOutput:ok:input:))
                    observer:observer
                      action:callback
                   extraInfo:extraInfo];
}

-(NSData *) getDataListInput:(NSString *)page withType:(NSString*)type withProductType:(NSString*)productType
{
    
    return [[NSString stringWithFormat:@"token=%@&pageIndex=%@&userId=%@&pageSize=%@",busiSystem.agent.token?:@"",page,busiSystem.agent.userId,@"20"] dataUsingEncoding:NSUTF8StringEncoding];
}

-(NSError *)getDataListOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input
{
    UNPACKETOUTPUTHEAD(recvData, ok);
    BUGetUserPushMsgManager *msgManager = [[BUGetUserPushMsgManager alloc] init];
    msgManager.pageInfo = [[BUPageInfo alloc] init];
    [(BSJSON *)jsonObj deserializationSpecifityMap:msgManager map:@{@"data":@"BUGetUserPushMsg,getUserPushMsgArr"}];
    //    [RequestStatus setRequestResultStatus:jsonObj];
    
    if (self.pageInfo == nil||self.pageInfo.page == 1 || msgManager.pageInfo.page == 1) {
        self.getUserPushMsgArr = msgManager.getUserPushMsgArr;
        //        msgManager.pageInfo.type = self.pageInfo.type;
        msgManager.pageInfo.keywords = self.pageInfo.keywords;
        //        msgManager.pageInfo.lat = self.pageInfo.lat;
        //        msgManager.pageInfo.lng = self.pageInfo.lng;
        self.pageInfo = msgManager.pageInfo;
        self.pageInfo.page = 1;
           self.pageInfo.pageall  = [[jsonObj objectForKey:@"total"] integerValue];
    }
    else
    {
        NSMutableArray * plist = [[NSMutableArray alloc] init];
        if (self.pageInfo.page != msgManager.pageInfo.page) {
            [plist addObjectsFromArray:self.getUserPushMsgArr];
            self.pageInfo.pageall  = [[jsonObj objectForKey:@"total"] integerValue];
        }
        [plist addObjectsFromArray:msgManager.getUserPushMsgArr];
        self.getUserPushMsgArr = plist;
    }
    
    //    [self setRequestStatus:jsonObj];
    
    //    _shopInfos = nil;
    
    
    return SuccessedError;
}

-(BOOL)viewPushMsg:(NSString*) aid observer:(id)observer callback:(SEL)callback
{
    return [self viewPushMsg:aid observer:observer callback:callback extraInfo:nil];
}
-(BOOL)viewPushMsg:(NSString*) aid observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo
{
    NSString *token = busiSystem.agent.token?:@"";
    NSString *userId = busiSystem.agent.userId?:@"";
    NSInvocation *input = BSGetInvocationFromSel(self, @selector(viewPushMsgInput: withUserid: withToken:));
    [input setArgument:&aid atIndex:2];
    [input setArgument:&userId atIndex:3];
    [input setArgument:&token atIndex:4];
    [input retainArguments];
    return [self sendRequest:[NSString stringWithFormat:@"%@%@",BU_BUSINESS_DOMAIN_USER,BU_BUSINESS_ViewPushMsg]
                        head:nil
                      method:@"POST"
                       async:YES
             inputInvocation:input
            outputInvocation:BSGetInvocationFromSel(self, @selector(viewPushMsgOutput:ok:input:))
                    observer:observer
                      action:callback
                   extraInfo:extraInfo];
    
}


-(NSData *)viewPushMsgInput:(NSString*) aid withUserid:(NSString*) userId withToken:(NSString*) token
{
    NSString *request = [NSString stringWithFormat:@"id=%@&userId=%@&token=%@",aid,userId,token];
    return [request dataUsingEncoding:NSUTF8StringEncoding];
    
}

-(NSError *)viewPushMsgOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input

{
    UNPACKETOUTPUTHEAD(recvData, ok);
    
    return SuccessedError;
    
}

-(BOOL)delPushMsg:(NSString*) aid observer:(id)observer callback:(SEL)callback
{
    return [self delPushMsg:aid observer:observer callback:callback extraInfo:nil];
}

-(BOOL)delPushMsg:(NSString*) aid observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo
{
    NSString *token = busiSystem.agent.token?:@"";
    NSString *userId = busiSystem.agent.userId?:@"";

    NSInvocation *input = BSGetInvocationFromSel(self, @selector(delPushMsgInput: withUserid: withToken:));
    [input setArgument:&aid atIndex:2];
    [input setArgument:&userId atIndex:3];
    [input setArgument:&token atIndex:4];
    [input retainArguments];
    return [self sendRequest:[NSString stringWithFormat:@"%@%@",BU_BUSINESS_DOMAIN_USER,BU_BUSINESS_DelPushMsg]
                        head:nil
                      method:@"POST"
                       async:YES
             inputInvocation:input
            outputInvocation:BSGetInvocationFromSel(self, @selector(delPushMsgOutput:ok:input:))
                    observer:observer
                      action:callback
                   extraInfo:extraInfo];
    
}


-(NSData *)delPushMsgInput:(NSString*) aid withUserid:(NSString*) userId withToken:(NSString*) token
{
    NSString *request = [NSString stringWithFormat:@"id=%@&userId=%@&token=%@",aid,userId,token];
    return [request dataUsingEncoding:NSUTF8StringEncoding];
    
}

-(NSError *)delPushMsgOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input

{
    UNPACKETOUTPUTHEAD(recvData, ok);
    
    return SuccessedError;
    
}


@end
