//
//  BUGetCollectListManager.m
//  intelligentgarbagecollection
//
//  Created by air on 2017/12/7.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import "BUGetCollectListManager.h"
//@implementation BUGetCollect
//-(NSDictionary*)getDic
//{
//     NSString *ss = [NSString stringWithFormat:@"%.2f 元/%@",_salePrice,_goodsSpec];
//     if (_productType == 3) {
//          ss=  @"跑腿师傅";
//     }
//     NSString *str = [NSString stringWithFormat:@"服务%ld次",_buyCount];
//     if (_productType == 1) {
//          str = [NSString stringWithFormat:@"已售%ld件",_buyCount];
//     }
//     return @{@"title":_name?:@"",@"img":_imagePath?: @"default",@"default":@"default",@"source":ss,@"time":str};
//}
//@end


@implementation BUGetCollectListManager
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
     return   [self getList:userId  observer:observer  callback:callback extraInfo:nil ];
}

-(BOOL)getList:(NSString*)userId observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo
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
//     [input setArgument:&cityId atIndex:5];
//     [input setArgument:&lon atIndex:6];
//     [input setArgument:&lat atIndex:7];
     [input retainArguments];
     return [self sendRequest:[NSString stringWithFormat:@"%@%@%@",BU_BUSINESS_DOMAIN_USER,BU_BUSINESS_GetCollectList,@""]
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
     BUGetCollectListManager *msgManager = [[BUGetCollectListManager alloc] init];
     msgManager.pageInfo = [[BUPageInfo alloc] init];
     [(BSJSON *)jsonObj deserializationSpecifityMap:msgManager map:@{@"data":@"BUGetCollect,dataArr"}];
     //    [RequestStatus setRequestResultStatus:jsonObj];

     if (self.pageInfo == nil||self.pageInfo.page == 1 || msgManager.pageInfo.page == 1) {
          self.dataArr = msgManager.dataArr;
          //        msgManager.pageInfo.type = self.pageInfo.type;
          msgManager.pageInfo.uid = self.pageInfo.uid?:@"";
//          msgManager.pageInfo.keywords = self.pageInfo.keywords?:@"";
//          msgManager.pageInfo.lng = self.pageInfo.lng;
//          msgManager.pageInfo.lat = self.pageInfo.lat;
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


-(BOOL)delGoodsCollect:(NSString*) productType withGoodsid:(NSString*) goodsId withUserid:(NSString*) userId observer:(id)observer callback:(SEL)callback
{
     return [self delGoodsCollect: productType withGoodsid: goodsId withUserid: userId observer:observer callback:callback extraInfo:nil];
}

-(BOOL)delGoodsCollect:(NSString*) productType withGoodsid:(NSString*) goodsId withUserid:(NSString*) userId observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo
{
     NSInvocation *input = BSGetInvocationFromSel(self, @selector(delGoodsCollectInput: withGoodsid: withUserid:));
     [input setArgument:&productType atIndex:2];
     [input setArgument:&goodsId atIndex:3];
     [input setArgument:&userId atIndex:4];
     [input retainArguments];
     return [self sendRequest:[NSString stringWithFormat:@"%@%@",BU_BUSINESS_DOMAIN_USER,BU_BUSINESS_DelGoodsCollect]
                         head:nil
                       method:@"POST"
                        async:YES
              inputInvocation:input
             outputInvocation:BSGetInvocationFromSel(self, @selector(delGoodsCollectOutput:ok:input:))
                     observer:observer
                       action:callback
                    extraInfo:extraInfo];

}


-(NSData *)delGoodsCollectInput:(NSString*) productType withGoodsid:(NSString*) goodsId withUserid:(NSString*) userId
{
     NSString *request = [NSString stringWithFormat:@"productType=%@&goodsId=%@&userId=%@&%@",productType,goodsId,userId,[self getBaseUrlParem]];
     return [request dataUsingEncoding:NSUTF8StringEncoding];

}

-(NSError *)delGoodsCollectOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input

{
     UNPACKETOUTPUTHEAD(recvData, ok);

     return SuccessedError;

}
@end
