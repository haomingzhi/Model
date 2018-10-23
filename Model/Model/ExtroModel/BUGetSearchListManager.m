//
//  BUGetGoodsListManager.m
//  intelligentgarbagecollection
//
//  Created by Steve on 2017/12/7.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import "BUGetSearchListManager.h"
#import "BUSystem.h"
#import "BUHeadManager.h"

@implementation BUGetSearchListManager


-(BOOL)getListNextPage:(id)observer callback:(SEL)callback
{
     return [self getListNextPage:observer callback:callback extraInfo:nil];
}


-(BOOL)getListNextPage:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo
{
     BUPageInfo *pageinfo = [[BUPageInfo alloc] init];
     self.pageInfo.page ++;
     pageinfo.page = self.pageInfo.page;
     pageinfo.keywords = self.pageInfo.keywords?:@"";
//     pageinfo.typeId = self.pageInfo.typeId?:@"";
//     pageinfo.orderBy = self.pageInfo.orderBy?:@"";
//     pageinfo.lng = self.pageInfo.lng?:@"";
//     pageinfo.lat = self.pageInfo.lat?:@"";
//     pageinfo.cityId = self.pageInfo.cityId?:@"";
     return [self getDataList:pageinfo observer:observer callback:callback extraInfo:extraInfo];
}
-(BOOL)getList:(NSString*)search  observer:(id)observer callback:(SEL)callback
{
     return   [self getList:search  observer:observer  callback:callback extraInfo:nil ];
}

-(BOOL)getList:(NSString*)search  observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo
{
     return [self getData:@{@"search":search?:@"",} observer:observer callback:callback extraInfo:extraInfo];
}

-(BOOL)getData:(NSDictionary *)dic  observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo
{
     
     self.pageInfo = nil;
     BUPageInfo *pageinfo = [[BUPageInfo alloc] init];
     pageinfo.keywords = dic[@"search"];
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
//     NSString *pageSize = @"20";
     NSString *search = pageinfo.keywords;
     NSInvocation *input = BSGetInvocationFromSel(self, @selector(getDataListInput:pageIndex:));
     [input setArgument:&search atIndex:2];
     [input setArgument:&pageIndex atIndex:3];
     [input retainArguments];
     return [self sendRequest:[NSString stringWithFormat:@"%@%@%@",BU_BUSINESS_DOMAIN_HOMEINDEX,BU_BUSINESS_Search,@""]
                         head:nil
                       method:@"POST"
                        async:YES
              inputInvocation:input
             outputInvocation:BSGetInvocationFromSel(self, @selector(getDataListOutput:ok:input:))
                     observer:observer
                       action:callback
                    extraInfo:extraInfo];
}

-(NSData *)getDataListInput:(NSString*)search  pageIndex:(NSString *)pageIndex
{
     NSString *request = [NSString stringWithFormat:@"pageIndex=%@&search=%@&%@",pageIndex,search,[self getBaseUrlParem]];
     return [request dataUsingEncoding:NSUTF8StringEncoding];
     
}

-(NSError *)getDataListOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input
{
     UNPACKETOUTPUTHEAD(recvData, ok);
     BUGetGoodsListManager *msgManager = [[BUGetGoodsListManager alloc] init];
     msgManager.pageInfo = [[BUPageInfo alloc] init];
     [(BSJSON *)jsonObj deserializationSpecifityMap:msgManager map:@{@"data":@"BUHeadGoods,dataArr"}];
     //    [RequestStatus setRequestResultStatus:jsonObj];
     
     if (self.pageInfo == nil||self.pageInfo.page == 1 || msgManager.pageInfo.page == 1) {
          self.dataArr = msgManager.dataArr;
          //        msgManager.pageInfo.type = self.pageInfo.type;
          msgManager.pageInfo.keywords = self.pageInfo.keywords?:@"";

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
