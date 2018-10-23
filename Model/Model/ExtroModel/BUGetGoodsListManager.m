//
//  BUGetGoodsListManager.m
//  intelligentgarbagecollection
//
//  Created by Steve on 2017/12/7.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import "BUGetGoodsListManager.h"
#import "BUSystem.h"

@implementation BUGetGoodsListManager

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
     pageinfo.typeId = self.pageInfo.typeId?:@"";
     pageinfo.orderBy = self.pageInfo.orderBy?:@"";
//     pageinfo.lng = self.pageInfo.lng?:@"";
//     pageinfo.lat = self.pageInfo.lat?:@"";
//     pageinfo.cityId = self.pageInfo.cityId?:@"";
     return [self getDataList:pageinfo observer:observer callback:callback extraInfo:extraInfo];
}
-(BOOL)getList:(NSString*)shopId typeId:(NSString *)typeId orderBy:(NSString *)orderBy  observer:(id)observer callback:(SEL)callback
{
     return   [self getList:shopId typeId:typeId orderBy:orderBy  observer:observer  callback:callback extraInfo:nil ];
}

-(BOOL)getList:(NSString*)shopId typeId:(NSString *)typeId orderBy:(NSString *)orderBy  observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo
{
     return [self getData:@{@"shopId":shopId?:@"",@"typeId":typeId?:@"",@"orderBy":orderBy?:@""} observer:observer callback:callback extraInfo:extraInfo];
}

-(BOOL)getData:(NSDictionary *)dic  observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo
{
     
     self.pageInfo = nil;
     BUPageInfo *pageinfo = [[BUPageInfo alloc] init];
     pageinfo.uid = dic[@"shopId"];
     pageinfo.typeId = dic[@"typeId"];
     pageinfo.orderBy = dic[@"orderBy"];
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
     NSString *shopId = pageinfo.uid;
     NSString *typeId = pageinfo.typeId;
     NSString *orderBy = pageinfo.orderBy;
     NSInvocation *input = BSGetInvocationFromSel(self, @selector(getDataListInput:typeId:orderBy:pageIndex:pageSize:));
     [input setArgument:&shopId atIndex:2];
     [input setArgument:&typeId atIndex:3];
     [input setArgument:&orderBy atIndex:4];
     [input setArgument:&pageIndex atIndex:5];
     [input setArgument:&pageSize atIndex:6];
     [input retainArguments];
     return [self sendRequest:[NSString stringWithFormat:@"%@%@%@",BU_BUSINESS_DOMAIN_SHOP,BU_BUSINESS_GetGoodsList,@""]
                         head:nil
                       method:@"POST"
                        async:YES
              inputInvocation:input
             outputInvocation:BSGetInvocationFromSel(self, @selector(getDataListOutput:ok:input:))
                     observer:observer
                       action:callback
                    extraInfo:extraInfo];
}

-(NSData *)getDataListInput:(NSString*)shopId typeId:(NSString *)typeId orderBy:(NSString *)orderBy  pageIndex:(NSString *)pageIndex pageSize:(NSString *)pageSize
{
     NSString *request = [NSString stringWithFormat:@"pageIndex=%@&pageSize=%@&key=%@&typeId=%@&orderBy=%@&shopId=%@&%@",pageIndex,pageSize,shopId,typeId,orderBy,shopId,[self getBaseUrlParem]];
     return [request dataUsingEncoding:NSUTF8StringEncoding];
     
}

-(NSError *)getDataListOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input
{
     UNPACKETOUTPUTHEAD(recvData, ok);
     BUGetGoodsListManager *msgManager = [[BUGetGoodsListManager alloc] init];
     msgManager.pageInfo = [[BUPageInfo alloc] init];
     [(BSJSON *)jsonObj deserializationSpecifityMap:msgManager map:@{@"data":@"BUGoodsInfo,dataArr"}];
     //    [RequestStatus setRequestResultStatus:jsonObj];
     
     if (self.pageInfo == nil||self.pageInfo.page == 1 || msgManager.pageInfo.page == 1) {
          self.dataArr = msgManager.dataArr;
          //        msgManager.pageInfo.type = self.pageInfo.type;
          msgManager.pageInfo.uid = self.pageInfo.uid?:@"";
          msgManager.pageInfo.typeId = self.pageInfo.typeId?:@"";
          msgManager.pageInfo.orderBy = self.pageInfo.orderBy?:@"";
//          msgManager.pageInfo.lat = self.pageInfo.lat?:@"";
//          msgManager.pageInfo.lng = self.pageInfo.lng?:@"";
//          msgManager.pageInfo.cityId = self.pageInfo.cityId?:@"";
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
