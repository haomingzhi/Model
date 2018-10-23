//
//  BUGetSecondhandGoodsListManager.m
//  intelligentgarbagecollection
//
//  Created by air on 2017/12/7.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import "BUGetSecondhandGoodsListManager.h"
@implementation BUGetSecondhandGoods
-(id)init
{
     self = [super init];
     if(self){
          self.deserializationMap = @{@"BUImageRes":@"BUImageRes",@"imageList":@"BUImageRes,imageList"};

     }
     return self;
}

-(NSDictionary*)getDic:(NSInteger)row
{
     if (row == 0) {
          BUImageRes *imgPath = _imageList.firstObject;
          return @{@"title":_name?:@"",@"img":imgPath?:@"default",@"default":@"default",@"source":[NSString stringWithFormat:@"%ld积分",_integral],@"time":_address?:@"",@"distance":[NSString stringWithFormat:@"%@",_distance?:@"0"],@"state":_stateName?:@""};
     }
     else
     {
          if (_state == 1) {
                return  @{@"tab1":@"编辑",@"tab2":@"删除",@"row":_indexPath?:@""};
          }
          return @{@"tab1":@"",@"tab2":@""};
     }
}
@end


@implementation BUGetSecondhandGoodsListManager
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
     pageinfo.keywords = self.pageInfo.keywords?:@"";
     pageinfo.lng = self.pageInfo.lng;
     pageinfo.lat = self.pageInfo.lat;
     return [self getDataList:pageinfo observer:observer callback:callback extraInfo:extraInfo];
}
-(BOOL)getList:(NSString*)userId withCityId:(NSString*)cityId withLon:(NSString*)lon withLat:(NSString*)lat observer:(id)observer callback:(SEL)callback
{
     return   [self getList:userId withCityId:cityId withLon:lon withLat:lat observer:observer  callback:callback extraInfo:nil ];
}

-(BOOL)getList:(NSString*)userId withCityId:(NSString*)cityId withLon:(NSString*)lon withLat:(NSString*)lat observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo
{
     return [self getData:@{@"userId":userId?:@"",@"cityId":cityId?:@"",@"longitude":lon?:@"",@"latitude":lat?:@""} observer:observer callback:callback extraInfo:extraInfo];
}

-(BOOL)getData:(NSDictionary *)dic  observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo
{

     self.pageInfo = nil;
     BUPageInfo *pageinfo = [[BUPageInfo alloc] init];
     pageinfo.uid = dic[@"userId"];
     pageinfo.lat = dic[@"latitude"];
     pageinfo.lng = dic[@"longitude"];
     pageinfo.keywords = dic[@"cityId"];
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
     NSString *cityId = pageinfo.keywords;
     NSString *lon = pageinfo.lng;
     NSString *lat = pageinfo.lat;
     NSInvocation *input = BSGetInvocationFromSel(self, @selector(getDataListInput:withPagesize:withPageIndex:withCityId:withLon:withLat:));
     [input setArgument:&uid atIndex:2];
     [input setArgument:&pageSize atIndex:3];
     [input setArgument:&pageIndex atIndex:4];
     [input setArgument:&cityId atIndex:5];
       [input setArgument:&lon atIndex:6];
       [input setArgument:&lat atIndex:7];
     [input retainArguments];
     return [self sendRequest:[NSString stringWithFormat:@"%@%@%@",BU_BUSINESS_DOMAIN_SECONDHAND,BU_BUSINESS_GetSecondhandGoodsList,@""]
                         head:nil
                       method:@"POST"
                        async:YES
              inputInvocation:input
             outputInvocation:BSGetInvocationFromSel(self, @selector(getDataListOutput:ok:input:))
                     observer:observer
                       action:callback
                    extraInfo:extraInfo];
}

-(NSData *)getDataListInput:(NSString*) userId withPagesize:(NSString*) pageSize withPageIndex:(NSString *)pageIndex withCityId:(NSString*)cityId withLon:(NSString*)lon withLat:(NSString*)lat
{
     NSString *request = [NSString stringWithFormat:@"userId=%@&pageSize=%@&pageIndex=%@&cityId=%@&longitude=%@&latitude=%@&%@",userId,pageSize,pageIndex,cityId,lon,lat,[self getBaseUrlParem]];
     return [request dataUsingEncoding:NSUTF8StringEncoding];

}

-(NSError *)getDataListOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input
{
     UNPACKETOUTPUTHEAD(recvData, ok);
     BUGetSecondhandGoodsListManager *msgManager = [[BUGetSecondhandGoodsListManager alloc] init];
     msgManager.pageInfo = [[BUPageInfo alloc] init];
     [(BSJSON *)jsonObj deserializationSpecifityMap:msgManager map:@{@"data":@"BUGetSecondhandGoods,dataArr"}];
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
