//
//  BUGetRecyclingOrderListManager.m
//  intelligentgarbagecollection
//
//  Created by air on 2017/12/11.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import "BUGetRecyclingOrderListManager.h"
#import "BUSystem.h"
@implementation BUGetRecyclingOrder
-(NSDictionary*)getDic:(NSInteger)row
{
     if (row == 0) {
          return @{@"title":_createTime?:@""};
     }
     else
          if(row == 1)
          {
               return @{@"oneTitle":[NSString stringWithFormat:@"%@：%ldkg",_dustbinType,_weight],@"twoTitle":[NSString stringWithFormat:@"积分：%ld分",_integral],@"threeTitle":[NSString stringWithFormat:@"余额：%ld分",_balance]};
          }
     else
     {
          return @{@"title":_stationName?:@"",@"img":_stationImage?:@"default",@"default":@"default",@"source":_stationAddress?:@""};
     }
}
@end

@implementation BUGetRecyclingOrderListManager
-(BOOL)getListNextPage:(id)observer callback:(SEL)callback
{
     return [self getListNextPage:observer callback:callback extraInfo:nil];
}


-(BOOL)getListNextPage:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo
{
     BUPageInfo *pageinfo = [[BUPageInfo alloc] init];
     self.pageInfo.page ++;
     pageinfo.page = self.pageInfo.page;
     pageinfo.uid = self.pageInfo.uid?:@"";
//     pageinfo.keywords = self.pageInfo.keywords?:@"";
//     pageinfo.lng = self.pageInfo.lng;
//     pageinfo.lat = self.pageInfo.lat;
     return [self getDataList:pageinfo observer:observer callback:callback extraInfo:extraInfo];
}
-(BOOL)getList:(NSString*)userId observer:(id)observer callback:(SEL)callback
{
     return   [self getList:userId observer:observer  callback:callback extraInfo:nil ];
}

-(BOOL)getList:(NSString*)userId  observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo
{
     return [self getData:@{@"userId":userId?:@""} observer:observer callback:callback extraInfo:extraInfo];
}

-(BOOL)getData:(NSDictionary *)dic  observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo
{

     self.pageInfo = nil;
     BUPageInfo *pageinfo = [[BUPageInfo alloc] init];
     pageinfo.uid = dic[@"userId"];
//     pageinfo.lat = dic[@"lat"];
//     pageinfo.lng = dic[@"lon"];
//     pageinfo.keywords = dic[@"cityId"];
     pageinfo.page = 1;

     return [self getDataList:pageinfo observer:observer callback:callback extraInfo:extraInfo];

}


-(BOOL)getDataList:(BUPageInfo *)pageinfo  observer:(id) observer callback:(SEL) callback  extraInfo:(NSDictionary*)extraInfo
{

     //    NSMutableString *str = [NSMutableString string];
     //    if (!self.pageInfo) {
     self.pageInfo = pageinfo;
     //    }

     NSString *pageIndex = [NSString stringWithFormat:@"%ld",(long)pageinfo.page];
     NSString *pageSize = @"20";
     NSString *uid = pageinfo.uid;
//     NSString *cityId = pageinfo.keywords;
//     NSString *lon = pageinfo.lng;
//     NSString *lat = pageinfo.lat;
     NSInvocation *input = BSGetInvocationFromSel(self, @selector(getDataListInput:withPagesize:withPageIndex:));
     [input setArgument:&uid atIndex:2];
     [input setArgument:&pageSize atIndex:3];
     [input setArgument:&pageIndex atIndex:4];

     [input retainArguments];
     return [self sendRequest:[NSString stringWithFormat:@"%@%@%@",BU_BUSINESS_DOMAIN_DUSTBIN,BU_BUSINESS_GetRecyclingOrderList,@""]
                         head:nil
                       method:@"POST"
                        async:YES
              inputInvocation:input
             outputInvocation:BSGetInvocationFromSel(self, @selector(getDataListOutput:ok:input:))
                     observer:observer
                       action:callback
                    extraInfo:extraInfo];
}

-(NSData *)getDataListInput:(NSString*) userId withPagesize:(NSString*) pageSize withPageIndex:(NSString *)pageIndex
{
     NSString *request = [NSString stringWithFormat:@"userId=%@&pageSize=%@&pageIndex=%@&%@",userId,pageSize,pageIndex,[self getBaseUrlParem]];
     return [request dataUsingEncoding:NSUTF8StringEncoding];

}

-(NSError *)getDataListOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input
{
     UNPACKETOUTPUTHEAD(recvData, ok);
     BUGetRecyclingOrderListManager *msgManager = [[BUGetRecyclingOrderListManager alloc] init];
     msgManager.pageInfo = [[BUPageInfo alloc] init];
     [(BSJSON *)jsonObj deserializationSpecifityMap:msgManager map:@{@"data":@"BUGetRecyclingOrder,dataArr"}];
     //    [RequestStatus setRequestResultStatus:jsonObj];

     if (self.pageInfo == nil||self.pageInfo.page == 1 || msgManager.pageInfo.page == 1) {
          self.dataArr = msgManager.dataArr;
          //        msgManager.pageInfo.type = self.pageInfo.type;
          msgManager.pageInfo.uid = self.pageInfo.uid?:@"";
          msgManager.pageInfo.keywords = self.pageInfo.keywords?:@"";
          msgManager.pageInfo.lng = self.pageInfo.lng;
          msgManager.pageInfo.lat = self.pageInfo.lat;
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



     return SuccessedError;
}
@end
