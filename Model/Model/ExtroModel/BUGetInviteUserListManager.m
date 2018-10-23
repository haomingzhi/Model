//
//  BUGetInviteUserListManager.m
//  compassionpark
//
//  Created by air on 2017/4/13.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import "BUGetInviteUserListManager.h"
#import "BUSystem.h"
@implementation BUGetInviteUser

-(NSDictionary *)getDic
{
    return @{@"title":_tel?:@"",@"detail":_stateName?:@"",@"detail2":_operTime?:@""};
}
@end
@implementation BUGetInviteUserListManager

-(BOOL)getInviteUserListNextPage:(id)observer callback:(SEL)callback
{
    return [self getInviteUserListNextPage:observer callback:callback extraInfo:nil];
}


-(BOOL)getInviteUserListNextPage:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo
{
    BUPageInfo *pageinfo = [[BUPageInfo alloc] init];
    self.pageInfo.page ++;
    pageinfo.page = self.pageInfo.page;
    pageinfo.type = self.pageInfo.type;
    pageinfo.keywords = self.pageInfo.keywords;
    
    //    pageinfo.userInfo = _pageInfo.userInfo;
    return [self getDataList:pageinfo observer:observer callback:callback extraInfo:extraInfo];
}
-(BOOL)getInviteUserList:(id)observer callback:(SEL)callback
{
    return   [self getInviteUserList:observer callback:callback extraInfo:nil];
}

-(BOOL)getInviteUserList:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo
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
    return [self sendRequest:[NSString stringWithFormat:@"%@%@%@",BU_BUSINESS_DOMAIN_USER,BU_BUSINESS_GetInviteUserList,@""]
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
    BUGetInviteUserListManager *msgManager = [[BUGetInviteUserListManager alloc] init];
    msgManager.pageInfo = [[BUPageInfo alloc] init];
    [(BSJSON *)jsonObj deserializationSpecifityMap:msgManager map:@{@"data":@"BUGetInviteUser,getInviteUserArr"}];
    //    [RequestStatus setRequestResultStatus:jsonObj];
    
    if (self.pageInfo == nil||self.pageInfo.page == 1 || msgManager.pageInfo.page == 1) {
        self.getInviteUserArr = msgManager.getInviteUserArr;
        //        msgManager.pageInfo.type = self.pageInfo.type;
        msgManager.pageInfo.keywords = self.pageInfo.keywords;
        //        msgManager.pageInfo.lat = self.pageInfo.lat;
        //        msgManager.pageInfo.lng = self.pageInfo.lng;
        self.pageInfo = msgManager.pageInfo;
        self.pageInfo.page = 1;
         self.pageInfo.pageall = [[jsonObj objectForKey:@"total"] integerValue];
    }
    else
    {
        NSMutableArray * plist = [[NSMutableArray alloc] init];
        if (self.pageInfo.page != msgManager.pageInfo.page) {
            [plist addObjectsFromArray:self.getInviteUserArr];
            self.pageInfo.pageall  = [[jsonObj objectForKey:@"total"] integerValue];
        }
        [plist addObjectsFromArray:msgManager.getInviteUserArr];
        self.getInviteUserArr = plist;
    }
    
    //    [self setRequestStatus:jsonObj];
    
    //    _shopInfos = nil;
    
    
    return SuccessedError;
}
@end
