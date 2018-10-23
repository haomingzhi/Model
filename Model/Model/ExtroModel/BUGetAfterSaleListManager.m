//
//  BUGetAfterSaleListManager.m
//  intelligentgarbagecollection
//
//  Created by air on 2017/12/13.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import "BUGetAfterSaleListManager.h"

@implementation BUCheckList
-(NSDictionary *)getDic:(NSInteger)index{
     if (index == 0) {
          return @{@"title":_remark?:@"",@"detail":_createTime?:@""};
     }
     else if(index == 2){
          return @{@"title":_remark?:@"",@"detail2":_createTime?:@"",@"detail":[NSString stringWithFormat:@"经办人:%@",_adminName?:@""],@"isCheck":@YES};
     }
     else if(index == 3){
          return @{@"title":_remark?:@"",@"detail2":_createTime?:@"",@"detail":[NSString stringWithFormat:@"经办人:%@",_adminName?:@""],@"isCheck":@NO};
     }
     return @{};
}
@end

@implementation BUAfterSaleDetail
-(id)init
{
     self = [super init];
     if(self){
          self.deserializationMap = @{@"BUImageRes":@"BUImageRes",@"goodsList":@"BUGoods,goodsList",@"checkList":@"BUCheckList,checkList"};
     }
     return self;
}

-(NSDictionary *)getDic:(NSInteger)index{
     NSArray *titleArr = @[@"aTitle",@"bTitle",@"cTitle",@"dTitle",@"eTitle"];
     NSArray *imgArr = @[@"aimg",@"bimg",@"cimg",@"dimg",@"eimg"];
     NSArray *detailArr = @[@"aDetail",@"bDetail",@"cDetail",@"dDetail",@"eDetail"];
     NSArray *stateArr = @[@"提交申请",@"申请审核",@"售后收货",@"进行退款",@"处理完成"];
     NSMutableArray *rightList = [NSMutableArray arrayWithArray:[[_checkList reverseObjectEnumerator] allObjects]];
//    rightList = [rightList reverseObjectEnumerator];
     if (index == 0) {


//          BUCheckList *t2  = [BUCheckList new];
//          t2.state = 1;
//          t2.createTime = @"2017 1-1 23:22";
//          [rightList addObject:t2];
//          BUCheckList *t22  = [BUCheckList new];
//          t22.state = 1;
//          t22.createTime = @"2017 1-1 23:22";
//          [rightList addObject:t22];
//           BUCheckList *t23  = [BUCheckList new];
//          t23.state = 1;
//          t23.createTime = @"2017 1-1 23:22";
//          [rightList addObject:t23];
//           BUCheckList *t24  = [BUCheckList new];
//          t24.state = 1;
//          t24.createTime = @"2017 1-1 23:22";
//          [rightList addObject:t24];
//          _checkList = rightList;
          NSMutableDictionary *dic = [NSMutableDictionary new];
          [rightList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
BUCheckList *t1 =  obj;
               NSString *tt = titleArr[idx];
               NSString *dd = detailArr[idx];
               NSString *ii = imgArr[idx];
//               dic[tt] = t1.stateName;
                   dic[tt] = stateArr[idx];
                dic[ii] = @"done";
               if (t1.state == 5) {
                    dic[tt] = @"审核失败";
                     dic[ii] = @"wrong";
               }
               dic[dd] = t1.createTime;

          }];
          dic[@"check"] = @(_checkList.count - 1);
          dic[@"hMark"] = @"trace";
          for (NSInteger i = 0; i < 5 - [dic[@"check"] integerValue] - 1; i ++) {
               NSInteger idx = [dic[@"check"] integerValue] + 1 + i;
//               BUCheckList *t1 =  _checkList[idx];
               NSString *tt = titleArr[idx];
               NSString *dd = detailArr[idx];
               NSString *ii = imgArr[idx];
               dic[tt] = stateArr[idx];
               dic[dd] = @"";
               dic[ii] = @"unDone";
          }
//          BUCheckList *t1 =  _checkList.lastObject;
////          t1.state = 5;
//          if (t1.state == 5) {
//               NSInteger idx = _checkList.count - 1;
//               //               BUCheckList *t1 =  _checkList[idx];
//               NSString *tt = titleArr[idx];
//               NSString *dd = detailArr[idx];
//               NSString *ii = imgArr[idx];
//               dic[tt] = t1.stateName;
//               dic[dd] = t1.createTime;
//               dic[ii] = @"wrong";
//          }
          return  dic;

     }
     else if (index == 1){
          NSString *title = [NSString stringWithFormat:@"服务单号：%@",_serviceNo];
          NSString *detail = [NSString stringWithFormat:@"申请时间：%@",_createTime];
          return  @{@"title":title,@"detail":detail};
     }
     else if (index == 2){
          BUCheckList *t = rightList.firstObject;
          return @{@"img":@"check",@"title":t.remark?:@""};
     }

     return @{};
}
@end

@implementation BUGetAfterSaleListManager
-(BOOL)getListNextPage:(id)observer callback:(SEL)callback
{
     return [self getListNextPage:observer callback:callback extraInfo:nil];
}


-(BOOL)getListNextPage:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo
{
     BUPageInfo *pageinfo = [[BUPageInfo alloc] init];
     self.pageInfo.page ++;
     pageinfo.page = self.pageInfo.page;
     pageinfo.type = self.pageInfo.type?:@"";
     pageinfo.uid = self.pageInfo.uid?:@"";
//     pageinfo.keywords = self.pageInfo.keywords?:@"";
     //    pageinfo.startDate = self.pageInfo.startDate?:@"";
     //    pageinfo.endDate = self.pageInfo.endDate?:@"";
     //    pageinfo.orderType = self.pageInfo.orderType?:@"";
     pageinfo.state = self.pageInfo.state?:@"";
     //    pageinfo.userInfo = _pageInfo.userInfo;
     return [self getDataList:pageinfo observer:observer callback:callback extraInfo:extraInfo];
}
-(BOOL)getList:(NSString*)userId  observer:(id)observer callback:(SEL)callback
{
     return   [self getList:userId observer:observer callback:callback extraInfo:nil ];
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
//     pageinfo.state = dic[@"orderStatus"];
//     pageinfo.keywords =  dic[@"courierId"];
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
//     NSString *courierId = pageinfo.keywords;
//     NSString *orderStatus = pageinfo.state?:@"";
     NSInvocation *input = BSGetInvocationFromSel(self, @selector(getDataListInput:withPagesize:withPageindex:));
     [input setArgument:&userId atIndex:2];
     [input setArgument:&pageSize atIndex:3];
     [input setArgument:&pageIndex atIndex:4];
//     [input setArgument:&orderStatus atIndex:5];
//     [input setArgument:&courierId atIndex:6];
     [input retainArguments];
     return [self sendRequest:[NSString stringWithFormat:@"%@%@%@",BU_BUSINESS_DOMAIN_ORDER,BU_BUSINESS_GetAfterSaleList,@""]
                         head:nil
                       method:@"POST"
                        async:YES
              inputInvocation:input
             outputInvocation:BSGetInvocationFromSel(self, @selector(getDataListOutput:ok:input:))
                     observer:observer
                       action:callback
                    extraInfo:extraInfo];
}

-(NSData *)getDataListInput:(NSString*) userId withPagesize:(NSString*) pageSize withPageindex:(NSString*) pageIndex
{
     NSString *request = [NSString stringWithFormat:@"userId=%@&pageSize=%@&pageIndex=%@&%@",userId,pageSize,pageIndex,[self getBaseUrlParem]];
     return [request dataUsingEncoding:NSUTF8StringEncoding];

}

-(NSError *)getDataListOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input
{
     UNPACKETOUTPUTHEAD(recvData, ok);
     BUGetAfterSaleListManager *msgManager = [[BUGetAfterSaleListManager alloc] init];
     msgManager.pageInfo = [[BUPageInfo alloc] init];
     [(BSJSON *)jsonObj deserializationSpecifityMap:msgManager map:@{@"data":@"BUGetOrder,dataArr"}];
     //    [RequestStatus setRequestResultStatus:jsonObj];

     if (self.pageInfo == nil||self.pageInfo.page == 1 || msgManager.pageInfo.page == 1) {
          self.dataArr = msgManager.dataArr;
          //        msgManager.pageInfo.type = self.pageInfo.type;
//          msgManager.pageInfo.keywords = self.pageInfo.keywords?:@"";
//          msgManager.pageInfo.startDate = self.pageInfo.startDate?:@"";
//          msgManager.pageInfo.endDate = self.pageInfo.endDate?:@"";
//          msgManager.pageInfo.orderType = self.pageInfo.orderType?:@"";
//          msgManager.pageInfo.state = self.pageInfo.state?:@"";
          msgManager.pageInfo.uid = self.pageInfo.uid?:@"";
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

-(BOOL)getAfterSaleDetail:(NSString*) sid observer:(id)observer callback:(SEL)callback
{
     return [self getAfterSaleDetail: sid observer:observer callback:callback extraInfo:nil];
}

-(BOOL)getAfterSaleDetail:(NSString*) sid observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo
{
     NSInvocation *input = BSGetInvocationFromSel(self, @selector(getAfterSaleDetailInput:));
     [input setArgument:&sid atIndex:2];
     [input retainArguments];
     return [self sendRequest:[NSString stringWithFormat:@"%@%@",BU_BUSINESS_DOMAIN_ORDER,BU_BUSINESS_GetAfterSaleDetail]
                         head:nil
                       method:@"POST"
                        async:YES
              inputInvocation:input
             outputInvocation:BSGetInvocationFromSel(self, @selector(getAfterSaleDetailOutput:ok:input:))
                     observer:observer
                       action:callback
                    extraInfo:extraInfo];

}


-(NSData *)getAfterSaleDetailInput:(NSString*) sid
{
     NSString *request = [NSString stringWithFormat:@"id=%@&%@",sid,[self getBaseUrlParem]];
     return [request dataUsingEncoding:NSUTF8StringEncoding];

}

-(NSError *)getAfterSaleDetailOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input

{
     UNPACKETOUTPUTHEAD(recvData, ok);
     _afterSaleDetail = nil;
      [(BSJSON *)jsonObj deserializationSpecifityMap:self map:@{@"data":@"BUAfterSaleDetail,afterSaleDetail"}];
     return SuccessedError;

}

-(BOOL)orderBack:(NSString*) userId withOrderid:(NSString*) orderId withContent:(NSString*) content withGoodsid:(NSString*) goodsId withContacts:(NSString*) contacts withImagelist:(NSArray*) imageList withTelephone:(NSString*) telephone withReasonid:(NSString*) reasonId observer:(id)observer callback:(SEL)callback
{
     return [self orderBack: userId withOrderid: orderId withContent: content withGoodsid: goodsId withContacts: contacts withImagelist: imageList withTelephone: telephone withReasonid: reasonId observer:observer callback:callback extraInfo:nil];
}

-(BOOL)orderBack:(NSString*) userId withOrderid:(NSString*) orderId withContent:(NSString*) content withGoodsid:(NSString*) goodsId withContacts:(NSString*) contacts withImagelist:(NSArray*) imageList withTelephone:(NSString*) telephone withReasonid:(NSString*) reasonId observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo
{
     NSInvocation *input = BSGetInvocationFromSel(self, @selector(orderBackInput: withOrderid: withContent: withGoodsid: withContacts: withImagelist: withTelephone: withReasonid:));
     [input setArgument:&userId atIndex:2];
     [input setArgument:&orderId atIndex:3];
     [input setArgument:&content atIndex:4];
     [input setArgument:&goodsId atIndex:5];
     [input setArgument:&contacts atIndex:6];
     [input setArgument:&imageList atIndex:7];
     [input setArgument:&telephone atIndex:8];
     [input setArgument:&reasonId atIndex:9];
     [input retainArguments];
     return [self sendRequest:[NSString stringWithFormat:@"%@%@",BU_BUSINESS_DOMAIN_ORDER,BU_BUSINESS_OrderBack]
                         head:@{@"Content-Type":@"application/json;charset=UTF-8"}
                       method:@"POST"
                        async:YES
              inputInvocation:input
             outputInvocation:BSGetInvocationFromSel(self, @selector(orderBackOutput:ok:input:))
                     observer:observer
                       action:callback
                    extraInfo:extraInfo];

}


-(NSData *)orderBackInput:(NSString*) userId withOrderid:(NSString*) orderId withContent:(NSString*) content withGoodsid:(NSString*) goodsId withContacts:(NSString*) contacts withImagelist:(NSArray*) imageList withTelephone:(NSString*) telephone withReasonid:(NSString*) reasonId
{

//     NSString *request = [NSString stringWithFormat:@"timeStamp=%@&content=%@&nonce=%@&appId=%@&reasonId=%@&imageList=%@&userId=%@&orderId=%@&contacts=%@&telephone=%@&goodsId=%@&sign=%@",timeStamp,content,nonce,appId,reasonId,imageList,userId,orderId,contacts,telephone,goodsId,sign];
//     return [request dataUsingEncoding:NSUTF8StringEncoding];
     BSJSON *dataJson = [BSJSON new];
     [dataJson setObject:userId  forKey:@"userId"];
     [dataJson setObject:content  forKey:@"content"];
     [dataJson setObject:orderId  forKey:@"orderId"];
     [dataJson setObject:goodsId  forKey:@"goodsId"];
     [dataJson setObject:reasonId  forKey:@"reasonId"];
     [dataJson setObject:contacts  forKey:@"contacts"];
     [dataJson setObject:telephone  forKey:@"telephone"];
//     [dataJson setObject:name  forKey:@"name"];
//     [dataJson setObject:cityName  forKey:@"cityName"];
     NSMutableArray *arr = [NSMutableArray new];
     [imageList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
          BUImageRes *i = obj;
          //          BSJSON *k = [BSJSON new];
          //          [k setObject:i.imgId forKey:@"imgId"];
          //          [k setObject:i.tgId forKey:@"tgId"];
          //          [k setObject:i.Image forKey:@"imgPath"];
          //          [k setObject:@(i.imgType) forKey:@"imgType"];
          [arr addObject:i.Image];
     }];
     [dataJson setObject:arr forKey:@"imageList"];
     [dataJson setObject:self.appId  forKey:@"appId"];
     [dataJson setObject:[self timeStamp] forKey:@"timeStamp"];
     [dataJson setObject:[self nonce] forKey:@"nonce"];
     [dataJson setObject:[self sign] forKey:@"sign"];
     NSData *result =  [[dataJson serializationHelper] dataUsingEncoding:NSUTF8StringEncoding];
     return result;
}

-(NSError *)orderBackOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input

{
     UNPACKETOUTPUTHEAD(recvData, ok);
     _afterSaleDetail = nil;
     [(BSJSON *)jsonObj deserializationSpecifityMap:self map:@{@"data":@"BUAfterSaleDetail,afterSaleDetail"}];
     return SuccessedError;

}

@end
