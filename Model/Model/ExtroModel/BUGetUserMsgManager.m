//
//  BUGetUserMsgManager.m
//  rentingshop
//
//  Created by air on 2018/3/30.
//  Copyright © 2018年 ORANLLC_IOS1. All rights reserved.
//

#import "BUGetUserMsgManager.h"
#import "BUSystem.h"
@implementation BUGetUserMsg
-(NSDictionary*)getDic:(NSInteger)row
{
     if (row == 0) {
          return @{@"title":_createTime?:@""};
     }
     else if (row == 1)
     {
          return @{@"title":_title?: @"",@"detail":_content?:@"",@"isR":_isRead == 0?@(NO):@(YES)};
//          return @{@"title":@"秒杀专区暂时下线公告",@"detail":@"尊敬的用户，为了给您带来更好的体验，秒杀专区业务将于20 17年4月26日22：00-2017年4月27日09:00期间进行看看吧！"};
     }
     else
     {
          return @{@"title":@"查看详情"};
     }
}
@end

@implementation BUGetUserMsgManager
-(BOOL)getUserMsgNextPage:(id)observer callback:(SEL)callback
{
     return [self getUserMsgNextPage:observer callback:callback extraInfo:nil];
}


-(BOOL)getUserMsgNextPage:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo
{
     BUPageInfo *pageinfo = [[BUPageInfo alloc] init];
     self.pageInfo.page ++;
     pageinfo.page = self.pageInfo.page;
     pageinfo.type = self.pageInfo.type;
     pageinfo.keywords = self.pageInfo.keywords;

     //    pageinfo.userInfo = _pageInfo.userInfo;
     return [self getDataList:pageinfo observer:observer callback:callback extraInfo:extraInfo];
}
-(BOOL)getUserMsg:(id)observer callback:(SEL)callback
{
     return   [self getUserMsg:observer callback:callback extraInfo:nil];
}

-(BOOL)getUserMsg:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo
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
     return [self sendRequest:[NSString stringWithFormat:@"%@%@%@",BU_BUSINESS_DOMAIN_MYPATH,BU_BUSINESS_GetUserMsg,@""]
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
     BUGetUserMsgManager *msgManager = [[BUGetUserMsgManager alloc] init];
     msgManager.pageInfo = [[BUPageInfo alloc] init];
     [(BSJSON *)jsonObj deserializationSpecifityMap:msgManager map:@{@"data":@"BUGetUserMsg,getUserMsgArr"}];
     //    [RequestStatus setRequestResultStatus:jsonObj];

     if (self.pageInfo == nil||self.pageInfo.page == 1 || msgManager.pageInfo.page == 1) {
          self.getUserMsgArr = msgManager.getUserMsgArr;
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
               [plist addObjectsFromArray:self.getUserMsgArr];
               self.pageInfo.pageall  = [[jsonObj objectForKey:@"total"] integerValue];
          }
          [plist addObjectsFromArray:msgManager.getUserMsgArr];
          self.getUserMsgArr = plist;
     }

     //    [self setRequestStatus:jsonObj];

     //    _shopInfos = nil;


     return SuccessedError;
}
@end
