//
//  BUGetActivityManager.m
//  compassionpark
//
//  Created by Steve on 2017/4/11.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import "BUGetActivityManager.h"
#import "BUSystem.h"

@implementation BUActivity

-(id)init
{
    self = [super init];
    if(self){
        self.deserializationMap = @{@"BUImageRes":@"BUImageRes",@"imageList":@"BUImageRes,imageList"};
    }
    return self;
}

-(NSDictionary *)getDic{
    return @{@"img":_imagePath?:[NSNull null],@"title":_name?:@""};
}

@end



@implementation BUGetActivityManager
-(BOOL)getActivityNextPage:(id)observer callback:(SEL)callback
{
    return [self getActivityNextPage:observer callback:callback extraInfo:nil];
}


-(BOOL)getActivityNextPage:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo
{
    BUPageInfo *pageinfo = [[BUPageInfo alloc] init];
    self.pageInfo.page ++;
    pageinfo.page = self.pageInfo.page;
    pageinfo.cityId = self.pageInfo.cityId;
    pageinfo.isRecommend = self.pageInfo.isRecommend;
    
    //    pageinfo.userInfo = _pageInfo.userInfo;
    return [self getDataList:pageinfo observer:observer callback:callback extraInfo:extraInfo];
}
-(BOOL)getActivity:(NSString *)cityId  withIsHome:(NSString *)isHome observer:(id)observer callback:(SEL)callback
{
    return   [self getActivity:cityId withIsHome:isHome observer:observer callback:callback extraInfo:nil];
}

-(BOOL)getActivity:(NSString *)cityId withIsHome:(NSString *)isHome observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo
{
    return [self getData:@{@"cityId":cityId?:@"",@"isHome":isHome?:@""} observer:observer callback:callback extraInfo:extraInfo];
}




-(BOOL)getData:(NSDictionary *)dic  observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo
{
    
    self.pageInfo = nil;
    BUPageInfo *pageinfo = [[BUPageInfo alloc] init];
    pageinfo.cityId = dic[@"cityId"];
    pageinfo.isRecommend = dic[@"isHome"];
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
    NSString *cityId = pageinfo.cityId;
    NSString *isHome = pageinfo.isRecommend;
    NSInvocation *input = BSGetInvocationFromSel(self, @selector(getDataListInput:withName:withIsHome:));
    [input setArgument:&page atIndex:2];
    [input setArgument:&cityId atIndex:3];
    [input setArgument:&isHome atIndex:4];
    [input retainArguments];
    return [self sendRequest:[NSString stringWithFormat:@"%@%@%@",BU_BUSINESS_DOMAIN_INDEX,BU_BUSINESS_GetActivityList,@""]
                        head:nil
                      method:@"POST"
                       async:YES
             inputInvocation:input
            outputInvocation:BSGetInvocationFromSel(self, @selector(getDataListOutput:ok:input:))
                    observer:observer
                      action:callback
                   extraInfo:extraInfo];
}

-(NSData *) getDataListInput:(NSString *)page withName:(NSString*)cityId withIsHome:(NSString *)isHome
{
    
    return [[NSString stringWithFormat:@"pageIndex=%@&pageSize=%@&cityId=%@&isHome=%@&%@",page,@"20",cityId,isHome,[self getBaseUrlParem]] dataUsingEncoding:NSUTF8StringEncoding];
}

-(NSError *)getDataListOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input
{
    UNPACKETOUTPUTHEAD(recvData, ok);
    BUGetActivityManager *msgManager = [[BUGetActivityManager alloc] init];
    msgManager.pageInfo = [[BUPageInfo alloc] init];
    [(BSJSON *)jsonObj deserializationSpecifityMap:msgManager map:@{@"data":@"BUActivity,dataArr"}];
    //    [RequestStatus setRequestResultStatus:jsonObj];
    
    if (self.pageInfo == nil||self.pageInfo.page == 1 || msgManager.pageInfo.page == 1) {
        self.dataArr = msgManager.dataArr;
        msgManager.pageInfo.isRecommend = self.pageInfo.isRecommend;
        msgManager.pageInfo.cityId = self.pageInfo.cityId;
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

-(BOOL)getActivityGoodsList:(NSString *)aid observer:(id)observer callback:(SEL)callback{
    return [self getActivityGoodsList:aid observer:observer callback:callback extraInfo:nil];
}

-(BOOL)getActivityGoodsList:(NSString *)aid observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo
{
    NSString *token = busiSystem.agent.token?:@"";
    NSInvocation *input = BSGetInvocationFromSel(self, @selector(getActivityGoodsListInput:withId:));
    [input setArgument:&token atIndex:2];
    [input setArgument:&aid atIndex:3];
    [input retainArguments];
    return [self sendRequest:[NSString stringWithFormat:@"%@%@",BU_BUSINESS_DOMAIN_PRODUCT,BU_BUSINESS_GetActivityGoodsList]
                        head:nil
                      method:@"POST"
                       async:YES
             inputInvocation:input
            outputInvocation:BSGetInvocationFromSel(self, @selector(getActivityGoodsListOutput:ok:input:))
                    observer:observer
                      action:callback
                   extraInfo:extraInfo];
    
}


-(NSData *)getActivityGoodsListInput:(NSString*) token withId:(NSString *)goodId
{
    NSString *request = [NSString stringWithFormat:@"token=%@&id=%@",token,goodId];
    return [request dataUsingEncoding:NSUTF8StringEncoding];
    
}

-(NSError *)getActivityGoodsListOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input

{
    UNPACKETOUTPUTHEAD(recvData, ok);
    _goodsArr = nil;
    [(BSJSON *)jsonObj deserializationSpecifityMap:self map:@{@"data":@"BUGoodsDetail,goodsArr"}];
    return SuccessedError;
    
}



-(BOOL)getActivityDetail:(NSString *)aid observer:(id)observer callback:(SEL)callback{
    return [self getActivityDetail:aid observer:observer callback:callback extraInfo:nil];
}

-(BOOL)getActivityDetail:(NSString *)aid observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo
{
    NSString *token = busiSystem.agent.token?:@"";
    NSInvocation *input = BSGetInvocationFromSel(self, @selector(getActivityDetailInput:withId:));
    [input setArgument:&token atIndex:2];
    [input setArgument:&aid atIndex:3];
    [input retainArguments];
    return [self sendRequest:[NSString stringWithFormat:@"%@%@",BU_BUSINESS_DOMAIN_PRODUCT,BU_BUSINESS_GetActivityDetail]
                        head:nil
                      method:@"POST"
                       async:YES
             inputInvocation:input
            outputInvocation:BSGetInvocationFromSel(self, @selector(getActivityDetailOutput:ok:input:))
                    observer:observer
                      action:callback
                   extraInfo:extraInfo];
    
}


-(NSData *)getActivityDetailInput:(NSString*) token withId:(NSString *)aid
{
    NSString *request = [NSString stringWithFormat:@"token=%@&id=%@",token,aid];
    return [request dataUsingEncoding:NSUTF8StringEncoding];
    
}

-(NSError *)getActivityDetailOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input

{
    UNPACKETOUTPUTHEAD(recvData, ok);
    _activity = nil;
    [(BSJSON *)jsonObj deserializationSpecifityMap:self map:@{@"data":@"BUActivity,activity"}];
    return SuccessedError;
    
}


@end
