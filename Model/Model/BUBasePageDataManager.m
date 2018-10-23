//
//  BUBasePageDataManager.m
//  deliciousfood
//
//  Created by air on 2017/2/27.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import "BUBasePageDataManager.h"

@implementation BUBasePageDataManager

-(BOOL)getDataNextPage:(id)observer callback:(SEL)callback
{
    return [self getDataNextPage:observer callback:callback extraInfo:nil];
}


-(BOOL)getDataNextPage:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo
{
    BUPageInfo *pageinfo = [[BUPageInfo alloc] init];
    _pageInfo.page ++;
    pageinfo.page = _pageInfo.page;
    pageinfo.keywords = _pageInfo.keywords;
//    pageinfo.lng = _pageInfo.lng;
//    pageinfo.lat = _pageInfo.lat;
    pageinfo.sort = _pageInfo.sort;
//    pageinfo.subType = _pageInfo.subType;
    pageinfo.type = _pageInfo.type;
    pageinfo.uid = _pageInfo.uid;
    //    pageinfo.userInfo = _pageInfo.userInfo;
    return [self getDataList:pageinfo observer:observer callback:callback extraInfo:extraInfo];
}

-(BOOL)getData:(NSDictionary *)dic  observer:(id)observer callback:(SEL)callback
{
    return [self getData:dic observer:observer callback:callback extraInfo: nil];
}

-(BOOL)getData:(NSDictionary *)dic  observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo
{
    
    _pageInfo = nil;
    BUPageInfo *pageinfo = [[BUPageInfo alloc] init];
    //    pageinfo.type = [type integerValue];
//    pageinfo.lat = dic[@"lat"];
//    pageinfo.lng = lng;
    //    pageinfo.keywords = type;
    pageinfo.page = 1;
    //    pageinfo.uid = stu;
    return [self getDataList:pageinfo observer:observer callback:callback extraInfo:extraInfo];
    
}

-(BOOL)getDataList:(BUPageInfo *)pageinfo  observer:(id) observer callback:(SEL) callback  extraInfo:(NSDictionary*)extraInfo
{
    
    NSMutableString *str = [NSMutableString string];
    if (!_pageInfo) {
        _pageInfo = pageinfo;
    }
    //    if (pageinfo.uid.length > 0) {
    [str appendFormat:@"?type=%@",@"0"];
//    [str appendFormat:@"&lng=%@",pageinfo.lng];
//    [str appendFormat:@"&lat=%@",pageinfo.lat];
    //    }
    if (pageinfo.page >= 0) {
        [str appendFormat:@"&pageindex=%ld",pageinfo.page];
    }
    
    //    [str appendFormat:@"&token=%@",busiSystem.agent.token?:@""];
    NSString *requestStr = [NSString stringWithFormat:@"%@&%@",str,[self getBaseUrlParem]];;
    return [self sendRequest:[NSString stringWithFormat:@"%@%@%@",BU_BUSINESS_DOMAIN_HOME,@"",requestStr]
                        head:nil
                      method:@"GET"
                       async:YES
             inputInvocation:nil
            outputInvocation:BSGetInvocationFromSel(self, @selector(getDataListOutput:ok:input:))
                    observer:observer
                      action:callback
                   extraInfo:extraInfo];
}


-(NSError *)getDataListOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input
{
    UNPACKETOUTPUTHEAD(recvData, ok);
    BUBasePageDataManager *msgManager = [[BUBasePageDataManager alloc] init];
    msgManager.pageInfo = [[BUPageInfo alloc] init];
    [(BSJSON *)jsonObj deserializationSpecifityMap:msgManager map:@{@"data":@"BUShopInfo,dataArr"}];
    //    [RequestStatus setRequestResultStatus:jsonObj];
    
    if (_pageInfo == nil||_pageInfo.page == 1 || msgManager.pageInfo.page == 1) {
        self.dataArr = msgManager.dataArr;
        //        msgManager.pageInfo.type = self.pageInfo.type;
        msgManager.pageInfo.keywords = self.pageInfo.keywords;
//        msgManager.pageInfo.lat = self.pageInfo.lat;
//        msgManager.pageInfo.lng = self.pageInfo.lng;
        self.pageInfo = msgManager.pageInfo;
        self.pageInfo.page = 1;
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
