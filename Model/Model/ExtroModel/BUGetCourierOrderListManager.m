//
//  BUGetCourierOrderListManager.m
//  intelligentgarbagecollection
//
//  Created by air on 2017/12/14.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import "BUGetCourierOrderListManager.h"

@implementation BUGetCourierOrderListManager
-(BOOL)getListNextPage:(id)observer callback:(SEL)callback
{
     return [self getListNextPage:observer callback:callback extraInfo:nil];
}


-(BOOL)getListNextPage:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo
{
     BUPageInfo *pageinfo = [[BUPageInfo alloc] init];
     self.pageInfo.page ++;
     pageinfo.page = self.pageInfo.page;
     //     pageinfo.type = self.pageInfo.type?:@"";
     pageinfo.uid = self.pageInfo.uid?:@"";
          pageinfo.keywords = self.pageInfo.keywords?:@"";
     //    pageinfo.startDate = self.pageInfo.startDate?:@"";
     //    pageinfo.endDate = self.pageInfo.endDate?:@"";
     //    pageinfo.orderType = self.pageInfo.orderType?:@"";
     pageinfo.state = self.pageInfo.state?:@"";
     //    pageinfo.userInfo = _pageInfo.userInfo;
     return [self getDataList:pageinfo observer:observer callback:callback extraInfo:extraInfo];
}
-(BOOL)getList:(NSString*)courierId withType:(NSString *)type withStationId:(NSString*)stationId observer:(id)observer callback:(SEL)callback
{
     return   [self getList:courierId withType:type withStationId:(NSString*)stationId observer:observer callback:callback extraInfo:nil ];
}

-(BOOL)getList:(NSString*)courierId withType:(NSString *)type withStationId:(NSString*)stationId  observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo
{
     return [self getData:@{@"courierId":courierId?:@"",@"type":type?:@"",@"stationId":stationId?:@""} observer:observer callback:callback extraInfo:extraInfo];
}

-(BOOL)getData:(NSDictionary *)dic  observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo
{

     self.pageInfo = nil;
     BUPageInfo *pageinfo = [[BUPageInfo alloc] init];
//     pageinfo.uid = dic[@"cityId"];
          pageinfo.state = dic[@"type"];
          pageinfo.keywords =  dic[@"courierId"];
     pageinfo.type = dic[@"stationId"];
     pageinfo.page = 1;
     //    pageinfo.uid = stu;
     return [self getDataList:pageinfo observer:observer callback:callback extraInfo:extraInfo];

}


-(BOOL)getDataList:(BUPageInfo *)pageinfo  observer:(id) observer callback:(SEL) callback  extraInfo:(NSDictionary*)extraInfo
{

     //    NSMutableString *str = [NSMutableString string];
     //    if (!self.pageInfo) {
     self.pageInfo = pageinfo;
     //    }

     NSString *pageIndex = [NSString stringWithFormat:@"%ld",pageinfo.page];
     NSString *pageSize = @"20";
     NSString *userId =pageinfo.uid;
          NSString *courierId = pageinfo.keywords;
          NSString *type = pageinfo.state?:@"";
     NSString *stationId = pageinfo.type;
     NSInvocation *input = BSGetInvocationFromSel(self, @selector(getDataListInput:withPagesize:withPageindex:withType:withCourierId:withStationId:));
     [input setArgument:&userId atIndex:2];
     [input setArgument:&pageSize atIndex:3];
     [input setArgument:&pageIndex atIndex:4];
          [input setArgument:&type atIndex:5];
          [input setArgument:&courierId atIndex:6];
       [input setArgument:&stationId atIndex:7];
     [input retainArguments];
     return [self sendRequest:[NSString stringWithFormat:@"%@%@%@",BU_BUSINESS_DOMAIN_ORDER,BU_BUSINESS_GetCourierOrderList,@""]
                         head:nil
                       method:@"POST"
                        async:YES
              inputInvocation:input
             outputInvocation:BSGetInvocationFromSel(self, @selector(getDataListOutput:ok:input:))
                     observer:observer
                       action:callback
                    extraInfo:extraInfo];
}

-(NSData *)getDataListInput:(NSString*) userId withPagesize:(NSString*) pageSize withPageindex:(NSString*) pageIndex withType:(NSString *)type withCourierId:(NSString *)courierId withStationId:(NSString*)stationId
{
     NSString *request = [NSString stringWithFormat:@"stationId=%@&type=%@&courierId=%@&pageSize=%@&pageIndex=%@&%@",stationId,type,courierId,pageSize,pageIndex,[self getBaseUrlParem]];
     return [request dataUsingEncoding:NSUTF8StringEncoding];

}

-(NSError *)getDataListOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input
{
     UNPACKETOUTPUTHEAD(recvData, ok);
     BUGetCourierOrderListManager *msgManager = [[BUGetCourierOrderListManager alloc] init];
     msgManager.pageInfo = [[BUPageInfo alloc] init];
     [(BSJSON *)jsonObj deserializationSpecifityMap:msgManager map:@{@"data":@"BUGetOrder,dataArr"}];
     //    [RequestStatus setRequestResultStatus:jsonObj];

     if (self.pageInfo == nil||self.pageInfo.page == 1 || msgManager.pageInfo.page == 1) {
          self.dataArr = msgManager.dataArr;
          //        msgManager.pageInfo.type = self.pageInfo.type;
                    msgManager.pageInfo.keywords = self.pageInfo.keywords?:@"";
          //          msgManager.pageInfo.startDate = self.pageInfo.startDate?:@"";
          //          msgManager.pageInfo.endDate = self.pageInfo.endDate?:@"";
          //          msgManager.pageInfo.orderType = self.pageInfo.orderType?:@"";
                    msgManager.pageInfo.state = self.pageInfo.state?:@"";
           msgManager.pageInfo.type = self.pageInfo.type?:@"";
//          msgManager.pageInfo.uid = self.pageInfo.uid?:@"";
          self.pageInfo = msgManager.pageInfo;
          self.pageInfo.page = 1;
          self.pageInfo.pageall = [[jsonObj objectForKey:@"total"] integerValue];
     }
     else
     {
          NSMutableArray * plist = [[NSMutableArray alloc] init];
          if (self.pageInfo.page != msgManager.pageInfo.page) {
               [plist addObjectsFromArray:self.dataArr];
               self.pageInfo.pageall  = [[jsonObj objectForKey:@"total"] integerValue];
          }
          [plist addObjectsFromArray:msgManager.dataArr];
          self.dataArr = plist;
     }

     //    [self setRequestStatus:jsonObj];

     //    _shopInfos = nil;


     return SuccessedError;
}


@end
