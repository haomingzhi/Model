//
//  BUGetCommentListManager.m
//  compassionpark
//
//  Created by air on 2017/3/27.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import "BUGetCommentListManager.h"
#import "BUSystem.h"
#import "JYCommonTool.h"

@implementation BUGetComment

-(id)init
{
    self = [super init];
    if(self){
        self.deserializationMap = @{@"BUImageRes":@"BUImageRes",@"picList":@"BUImageRes,picList"};
    }
    return self;
}

-(NSDictionary *)getDic:(NSInteger)index{
     if (index == 0) {
          NSString *tell = _userName;
          if ([JYCommonTool isMobileNum:tell]) {
               tell = [tell stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
          }
          NSString *content = _context;
          if (content.length == 0) {
               content = @"该用户未评论";
          }
          return @{@"img":_userImg?:@"defaultHead",@"default":@"defaultHead",@"title":tell,@"source":content,@"time":_createTime?:@""};
     }
     else if (index == 1){
          return @{@"arr":_picList?:@[]};
     }
     return @{};
     
}

@end

@implementation BUGetCommentListManager

-(BOOL)getCommentListNextPage:(id)observer callback:(SEL)callback
{
    return [self getCommentListNextPage:observer callback:callback extraInfo:nil];
}


-(BOOL)getCommentListNextPage:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo
{
    BUPageInfo *pageInfo = [[BUPageInfo alloc] init];
    self.pageInfo.page ++;
    pageInfo.page = self.pageInfo.page;
//     pageInfo.orderType = self.pageInfo.orderType;
//     pageInfo.keywords = self.pageInfo.keywords;
//     pageInfo.subType = self.pageInfo.subType;
//     pageInfo.keywords = self.pageInfo.keywords;
     pageInfo.uid = self.pageInfo.uid;
     pageInfo.productId = self.pageInfo.productId;
    return [self getDataList:pageInfo observer:observer callback:callback extraInfo:extraInfo];
}

-(BOOL)getCommentList:(NSString*) userId productId:(NSString*) productId   observer:(id)observer callback:(SEL)callback
{
    return [self getCommentList: userId  productId:(NSString*) productId   observer:observer  callback:callback extraInfo:nil];
}

-(BOOL)getCommentList:(NSString*) userId productId:(NSString*) productId observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo
{
     return [self getData:@{@"productId":productId?:@"",@"userId":userId?:@""} observer:observer callback:callback extraInfo:extraInfo];
}
-(BOOL)getData:(NSDictionary *)dic  observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo
{
    
    self.pageInfo = nil;
    BUPageInfo *pageinfo = [[BUPageInfo alloc] init];
    pageinfo.uid = dic[@"userId"];
     pageinfo.productId = dic[@"productId"];
    pageinfo.page = 1;
    //    pageinfo.uid = stu;
    return [self getDataList:pageinfo observer:observer callback:callback extraInfo:extraInfo];
    
}


-(BOOL)getDataList:(BUPageInfo *)pageinfo  observer:(id) observer callback:(SEL) callback  extraInfo:(NSDictionary*)extraInfo
{
    
    //    NSMutableString *str = [NSMutableString string];
    if (!self.pageInfo) {
        self.pageInfo = pageinfo;
    }
   
//    NSString *goodsId = pageinfo.subType;
//    NSString *orderId = pageinfo.keywords;
//    NSString *type = pageinfo.orderType;
    NSString *userId = pageinfo.uid;
     NSString *productId = pageinfo.productId;
     
    NSString *page = [NSString stringWithFormat:@"%ld",pageinfo.page];
     NSString *pageSize = @"20";
    NSInvocation *input = BSGetInvocationFromSel(self, @selector(getDataListInput:pageSize:userId:productId:));
    [input setArgument:&page atIndex:2];
    [input setArgument:&pageSize atIndex:3];
    [input setArgument:&userId atIndex:4];
     [input setArgument:&productId atIndex:5];
    [input retainArguments];
    return [self sendRequest:[NSString stringWithFormat:@"%@%@%@",BU_BUSINESS_DOMAIN_PRODUCT,BU_BUSINESS_GetEvaluationPageList,@""]
                        head:nil
                      method:@"POST"
                       async:YES
             inputInvocation:input
            outputInvocation:BSGetInvocationFromSel(self, @selector(getDataListOutput:ok:input:))
                    observer:observer
                      action:callback
                   extraInfo:extraInfo];
}
-(NSData *) getDataListInput:(NSString *)page pageSize:(NSString *)pageSize userId:(NSString*) userId productId:(NSString*) productId
{
    
    return [[NSString stringWithFormat:@"pageIndex=%@&userId=%@&pageSize=%@&productId=%@&%@",page,userId,pageSize,productId,[self getBaseUrlParem]] dataUsingEncoding:NSUTF8StringEncoding] ;
}

-(NSError *)getDataListOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input
{
    UNPACKETOUTPUTHEAD(recvData, ok);
    BUGetCommentListManager *msgManager = [[BUGetCommentListManager alloc] init];
    msgManager.pageInfo = [[BUPageInfo alloc] init];
    [(BSJSON *)jsonObj deserializationSpecifityMap:msgManager map:@{@"data":@"BUGetComment,getCommentList"}];
    //    [RequestStatus setRequestResultStatus:jsonObj];
    
    if (self.pageInfo == nil||self.pageInfo.page == 1 || msgManager.pageInfo.page == 1) {
        self.getCommentList = msgManager.getCommentList;
//        msgManager.pageInfo.orderType = self.pageInfo.orderType;
//        msgManager.pageInfo.keywords = self.pageInfo.keywords;
//        msgManager.pageInfo.subType = self.pageInfo.subType;
//        msgManager.pageInfo.keywords = self.pageInfo.keywords;
        msgManager.pageInfo.uid = self.pageInfo.uid;
         msgManager.pageInfo.productId = self.pageInfo.productId;
        msgManager.pageInfo.pageall = [[jsonObj objectForKey:@"total"] integerValue];
        self.pageInfo = msgManager.pageInfo;
        self.pageInfo.page = 1;
    }
    else
    {
        NSMutableArray * plist = [[NSMutableArray alloc] init];
        if (self.pageInfo.page != msgManager.pageInfo.page) {
            [plist addObjectsFromArray:self.getCommentList];
            self.pageInfo.pageall  = [[jsonObj objectForKey:@"total"] integerValue];
        }
        [plist addObjectsFromArray:msgManager.getCommentList];
        self.getCommentList = plist;
    }
    
    return SuccessedError;
}

-(BOOL)addComment:(NSString*) type withOrderid:(NSString*) orderId  withCommentList:(NSArray *)commentList observer:(id)observer callback:(SEL)callback
{
    return [self addComment:type withOrderid:orderId  withCommentList:commentList   observer:observer callback:callback extraInfo:nil];
}

-(BOOL)addComment:(NSString*) type withOrderid:(NSString*) orderId  withCommentList:(NSArray *)commentList observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo
{
    NSString* userId = busiSystem.agent.userId?:@"";
//    NSString *token = busiSystem.agent.token?:@"";

    NSInvocation *input = BSGetInvocationFromSel(self, @selector(addCommentInput: withType: withCommentList: withOrderid:));
    [input setArgument:&userId atIndex:2];
    [input setArgument:&type atIndex:3];
    [input setArgument:&commentList atIndex:4];
    [input setArgument:&orderId atIndex:5];

    [input retainArguments];
    return [self sendRequest:[NSString stringWithFormat:@"%@%@",BU_BUSINESS_DOMAIN_ORDER,BU_BUSINESS_AddComment]
                        head:@{@"Content-Type":@"application/json;charset=UTF-8"}
                      method:@"POST"
                       async:YES
             inputInvocation:input
            outputInvocation:BSGetInvocationFromSel(self, @selector(addCommentOutput:ok:input:))
                    observer:observer
                      action:callback
                   extraInfo:extraInfo];
    
}


-(NSData *)addCommentInput:(NSString*) userId withType:(NSString*) type withCommentList:(NSArray *)commentList  withOrderid:(NSString*) orderId
{
//    NSString *request = [NSString stringWithFormat:@"userId=%@&content=%@&star=%@&orderId=%@&goodsId=%@&type=%@&token=%@&imageList=[\"%@\"]",userId,content,star,orderId,goodsId,type,token];
    BSJSON *json = [BSJSON new];
    [json setObject:userId forKey:@"userId"];
//    [json setObject:type forKey:@"type"];
    [json setObject:orderId forKey:@"orderId"];
     NSMutableArray *arr = [NSMutableArray new];
     [commentList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
          BUGetComment *cc = obj;
          BSJSON *nd = [BSJSON new];
//          [nd setObject:self.appId forKey:@"appId" ];
//          [nd setObject: [self timeStamp] forKey:@"timeStamp"];
//          [nd setObject:[self nonce] forKey:@"nonce"];
//          [nd setObject:[self sign] forKey:@"sign"];
//          [nd setObject:cc.goodsId ?:@"" forKey:@"goodsId"];
//          [nd setObject:@(cc.type) forKey:@"type"];
//          [nd setObject:cc.courierId?:@"" forKey:@"courierId" ];
//          [nd setObject:cc.content?:@"" forKey:@"content" ];
//          NSMutableArray *tarr = [NSMutableArray new];
//          [cc.imageList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//               BUImageRes *imgr = obj;
//               [tarr addObject:imgr.Image?:@""];
//          }];
//          [nd setObject:tarr forKey:@"imageList"];
//          [arr addObject:nd];
     }];
    [json setObject:arr forKey:@"commentList"];
     [json setObject:self.appId  forKey:@"appId"];
     [json setObject:[self timeStamp] forKey:@"timeStamp"];
     [json setObject:[self nonce] forKey:@"nonce"];
     [json setObject:[self sign] forKey:@"sign"];
//    NSDictionary *dic = @{@"userId":userId,@"content":content,@"star":star,@"orderId":orderId,@"goodsId":goodsId,@"type":type,@"token":token};
//    NSMutableDictionary *mdic = [NSMutableDictionary dictionaryWithDictionary:dic];
//    mdic[@"imageList"] = imgs;
    NSString *request = [json serializationHelper];//[mdic toQueryString];
    return [request dataUsingEncoding:NSUTF8StringEncoding];
    
}

-(NSError *)addCommentOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input

{
    UNPACKETOUTPUTHEAD(recvData, ok);
    
    return SuccessedError;
    
}

-(BOOL)getCommentbyOrderId:(NSString*) sid observer:(id)observer callback:(SEL)callback
{
     return [self getCommentbyOrderId: sid observer:observer callback:callback extraInfo:nil];
}

-(BOOL)getCommentbyOrderId:(NSString*) sid observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo
{
     NSInvocation *input = BSGetInvocationFromSel(self, @selector(getCommentbyOrderIdInput:));
     [input setArgument:&sid atIndex:2];
     [input retainArguments];
     return [self sendRequest:[NSString stringWithFormat:@"%@%@",BU_BUSINESS_DOMAIN_ORDER,BU_BUSINESS_GetCommentbyOrderId]
                         head:nil
                       method:@"POST"
                        async:YES
              inputInvocation:input
             outputInvocation:BSGetInvocationFromSel(self, @selector(getCommentbyOrderIdOutput:ok:input:))
                     observer:observer
                       action:callback
                    extraInfo:extraInfo];

}


-(NSData *)getCommentbyOrderIdInput:(NSString*) sid
{
     NSString *request = [NSString stringWithFormat:@"id=%@&%@",sid,[self getBaseUrlParem]];
     return [request dataUsingEncoding:NSUTF8StringEncoding];

}

-(NSError *)getCommentbyOrderIdOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input

{
     UNPACKETOUTPUTHEAD(recvData, ok);

     return SuccessedError;

}
-(BOOL)getComment:(NSString*) sid observer:(id)observer callback:(SEL)callback
{
     return [self getComment: sid observer:observer callback:callback extraInfo:nil];
}

-(BOOL)getComment:(NSString*) sid observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo
{
     NSInvocation *input = BSGetInvocationFromSel(self, @selector(getCommentInput:));
     [input setArgument:&sid atIndex:2];
     [input retainArguments];
     return [self sendRequest:[NSString stringWithFormat:@"%@%@",BU_BUSINESS_DOMAIN_ORDER,BU_BUSINESS_GetComment]
                         head:nil
                       method:@"POST"
                        async:YES
              inputInvocation:input
             outputInvocation:BSGetInvocationFromSel(self, @selector(getCommentOutput:ok:input:))
                     observer:observer
                       action:callback
                    extraInfo:extraInfo];

}


-(NSData *)getCommentInput:(NSString*) sid
{
     NSString *request = [NSString stringWithFormat:@"id=%@&%@",sid,[self getBaseUrlParem]];
     return [request dataUsingEncoding:NSUTF8StringEncoding];

}

-(NSError *)getCommentOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input

{
     UNPACKETOUTPUTHEAD(recvData, ok);

     return SuccessedError;

}
@end
