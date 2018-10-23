//
//  BUGetServiceListManager.m
//  intelligentgarbagecollection
//
//  Created by Steve on 2017/12/8.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import "BUGetServiceListManager.h"
#import "BUSystem.h"

@implementation BUGetServiceListManager
-(BOOL)getListNextPage:(id)observer callback:(SEL)callback
{
     return [self getListNextPage:observer callback:callback extraInfo:nil];
}


-(BOOL)getListNextPage:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo
{
     BUPageInfo *pageinfo = [[BUPageInfo alloc] init];
     self.pageInfo.page ++;
     pageinfo.page = self.pageInfo.page;
     pageinfo.key = self.pageInfo.key?:@"";
     pageinfo.typeId = self.pageInfo.typeId?:@"";
//     pageinfo.orderBy = self.pageInfo.orderBy?:@"";
//     pageinfo.lng = self.pageInfo.lng?:@"";
//     pageinfo.lat = self.pageInfo.lat?:@"";
     pageinfo.cityId = self.pageInfo.cityId?:@"";
     return [self getDataList:pageinfo observer:observer callback:callback extraInfo:extraInfo];
}
-(BOOL)getList:(NSString*)key typeId:(NSString *)typeId  cityId:(NSString *)cityId  observer:(id)observer callback:(SEL)callback
{
     return   [self getList:key typeId:typeId cityId:cityId observer:observer  callback:callback extraInfo:nil ];
}

-(BOOL)getList:(NSString*)key typeId:(NSString *)typeId cityId:(NSString *)cityId  observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo
{
     return [self getData:@{@"key":key?:@"",@"typeId":typeId?:@"",@"cityId":cityId?:@""} observer:observer callback:callback extraInfo:extraInfo];
}

-(BOOL)getData:(NSDictionary *)dic  observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo
{
     
     self.pageInfo = nil;
     BUPageInfo *pageinfo = [[BUPageInfo alloc] init];
     pageinfo.key = dic[@"key"];
     pageinfo.typeId = dic[@"typeId"];
//     pageinfo.orderBy = dic[@"orderBy"];
//     pageinfo.lng = dic[@"longitude"];
//     pageinfo.lat = dic[@"latitude"];
     pageinfo.cityId = dic[@"cityId"];
     
     pageinfo.page = 1;
     //     pageinfo.keywords = dic[@"actionId"];
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
     NSString *key = pageinfo.key;
     NSString *typeId = pageinfo.typeId;
//     NSString *orderBy = pageinfo.orderBy;
//     NSString *longitude = pageinfo.lng;
//     NSString *latitude = pageinfo.lat;
     NSString *cityId = pageinfo.cityId;
     NSInvocation *input = BSGetInvocationFromSel(self, @selector(getDataListInput:typeId:cityId:pageIndex:pageSize:));
     [input setArgument:&key atIndex:2];
     [input setArgument:&typeId atIndex:3];
//     [input setArgument:&orderBy atIndex:4];
//     [input setArgument:&longitude atIndex:5];
//     [input setArgument:&latitude atIndex:6];
     [input setArgument:&cityId atIndex:4];
     [input setArgument:&pageIndex atIndex:5];
     [input setArgument:&pageSize atIndex:6];
     [input retainArguments];
     return [self sendRequest:[NSString stringWithFormat:@"%@%@%@",BU_BUSINESS_DOMAIN_SERVICE,BU_BUSINESS_GetServiceList,@""]
                         head:nil
                       method:@"POST"
                        async:YES
              inputInvocation:input
             outputInvocation:BSGetInvocationFromSel(self, @selector(getDataListOutput:ok:input:))
                     observer:observer
                       action:callback
                    extraInfo:extraInfo];
}

-(NSData *)getDataListInput:(NSString*)key typeId:(NSString *)typeId cityId:(NSString *)cityId pageIndex:(NSString *)pageIndex pageSize:(NSString *)pageSize
{
     NSString *request = [NSString stringWithFormat:@"pageIndex=%@&pageSize=%@&key=%@&typeId=%@&cityId=%@&%@",pageIndex,pageSize,key,typeId,cityId,[self getBaseUrlParem]];
     return [request dataUsingEncoding:NSUTF8StringEncoding];
     
}

-(NSError *)getDataListOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input
{
     UNPACKETOUTPUTHEAD(recvData, ok);
     BUGetServiceListManager *msgManager = [[BUGetServiceListManager alloc] init];
     msgManager.pageInfo = [[BUPageInfo alloc] init];
     [(BSJSON *)jsonObj deserializationSpecifityMap:msgManager map:@{@"data":@"BUServiceInfo,dataArr"}];
     //    [RequestStatus setRequestResultStatus:jsonObj];
     
     if (self.pageInfo == nil||self.pageInfo.page == 1 || msgManager.pageInfo.page == 1) {
          self.dataArr = msgManager.dataArr;
          //        msgManager.pageInfo.type = self.pageInfo.type;
          msgManager.pageInfo.key = self.pageInfo.key?:@"";
          msgManager.pageInfo.typeId = self.pageInfo.typeId?:@"";
          msgManager.pageInfo.orderBy = self.pageInfo.orderBy?:@"";
          msgManager.pageInfo.lat = self.pageInfo.lat?:@"";
          msgManager.pageInfo.lng = self.pageInfo.lng?:@"";
          msgManager.pageInfo.cityId = self.pageInfo.cityId?:@"";
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
