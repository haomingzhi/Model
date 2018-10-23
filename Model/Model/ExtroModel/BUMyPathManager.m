//
//  BUMyPathManager.m
//  rentingshop
//
//  Created by air on 2018/3/30.
//  Copyright © 2018年 ORANLLC_IOS1. All rights reserved.
//

#import "BUMyPathManager.h"
#import "BUSystem.h"

@implementation BUUserCertification
@end

@implementation BUTimeList
-(id)init
{
     self = [super init];
     if(self){
          self.deserializationMap = @{@"BUImageRes":@"BUImageRes",@"orderInfo":@"BUGetOrder,orderInfo",@"subStr":@"NSString,subStr"};

     }
     return self;
}
-(NSDictionary *)getDic:(NSInteger)index{
//     if (index == 0) {
//          return @{@"title":_remark?:@"",@"detail":_createTime?:@""};
//     }
//     else if(index == 2){
//          return @{@"title":_remark?:@"",@"detail2":_createTime?:@"",@"detail":[NSString stringWithFormat:@"经办人:%@",_adminName?:@""],@"isCheck":@YES};
//     }
//     else if(index == 3){
//          return @{@"title":_remark?:@"",@"detail2":_createTime?:@"",@"detail":[NSString stringWithFormat:@"经办人:%@",_adminName?:@""],@"isCheck":@NO};
//     }
     return @{};
}
@end

@implementation BUSaleInfo
-(id)init
{
     self = [super init];
     if(self){
          self.deserializationMap = @{@"BUImageRes":@"BUImageRes",@"reletId":@"NSString,afterId",@"timeList":@"BUTimeList,timeList",@"reletNO":@"NSString,afterNO",@"buyoutId":@"NSString,afterId",@"buyoutNO":@"NSString,afterNO"};

     }
     return self;
}

-(NSDictionary *)getDic3:(NSInteger)index{//续租用
     NSArray *titleArr = @[@"aTitle",@"bTitle",@"cTitle",@"dTitle",@"eTitle"];
     NSArray *imgArr = @[@"aimg",@"bimg",@"cimg",@"dimg",@"eimg"];
     NSArray *detailArr = @[@"aDetail",@"bDetail",@"cDetail",@"dDetail",@"eDetail"];
     NSArray *stateArr = @[@"提交申请",@"申请审核",@"续租支付",@"修改订单",@"续租成功"];
     NSArray *stateTipArr = @[@"已提交",@"审核成功",@"已完成",@"已完成",@"已完成"];
     NSArray *stateFailTipArr = @[@"已提交",@"审核失败",@"交易超时",@"已完成",@"已完成"];
     NSMutableArray *rightList = [NSMutableArray arrayWithArray:_timeList];;
     //    rightList = [rightList reverseObjectEnumerator];
     if (index == 0) {


          NSMutableDictionary *dic = [NSMutableDictionary new];
          [rightList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
               BUTimeList *t1 =  obj;
               NSString *tt = titleArr[idx];
               NSString *dd = detailArr[idx];
               NSString *ii = imgArr[idx];
               //               dic[tt] = t1.stateName;
               dic[tt] = stateArr[idx];
               dic[ii] = @"done";
               if (t1.state == 0) {
                    //                    dic[tt] = @"审核失败";
                    dic[ii] = @"wrong";
               }
               dic[dd] = t1.time;

          }];
          BUTimeList *ft = _timeList.lastObject;


          if (ft.state == 1) {
               dic[@"mark"] =   stateTipArr[_timeList.count - 1];
                 dic[@"hMark"] = @"trace";
          }
          else
          {
               dic[@"mark"] = stateFailTipArr[_timeList.count - 1];
                 dic[@"hMark"] = @"trace2";
          }
          for (NSInteger i = 0; i < 5 - rightList.count; i ++) {
               NSInteger idx = rightList.count + i;
               //               BUCheckList *t1 =  _checkList[idx];
               NSString *tt = titleArr[idx];
               NSString *dd = detailArr[idx];
               NSString *ii = imgArr[idx];
               dic[tt] = stateArr[idx];
               if (_timeList.count == 3 && ft.state == 1) {
                    dic[dd] = ft.time?:@"";
                    dic[ii] = @"done";
               }
               else
               {
                    dic[dd] = @"";
                    dic[ii] = @"unDone";
               }
          }
          if (_timeList.count == 3 && ft.state == 1) {
               dic[@"check"] = @(4);
          }
          else
          {
               dic[@"check"] = @(_timeList.count - 1);
          }
          return  dic;

     }
     else if (index == 1){
          NSString *title = [NSString stringWithFormat:@"服务单号：%@",_afterNO];
          NSString *detail = [NSString stringWithFormat:@"申请时间：%@",_createTime];
          return  @{@"title":title,@"detail":detail};
     }
     else if (index == 2){
          BUTimeList *t = rightList.firstObject;
          NSString *ss = @"";
          if (t.state == 0) {

          }
          return @{@"img":@"check",@"title":_stateName?:@""};
     }

     return @{};
}


-(NSDictionary *)getDic2:(NSInteger)index{//买断用
     NSArray *titleArr = @[@"aTitle",@"bTitle",@"cTitle",@"dTitle",@"eTitle"];
     NSArray *imgArr = @[@"aimg",@"bimg",@"cimg",@"dimg",@"eimg"];
     NSArray *detailArr = @[@"aDetail",@"bDetail",@"cDetail",@"dDetail",@"eDetail"];
     NSArray *stateArr = @[@"提交申请",@"申请审核",@"买断支付",@"完结订单",@"买断成功"];
      NSArray *stateTipArr = @[@"已提交",@"审核成功",@"已完成",@"已完成",@"已完成"];
      NSArray *stateFailTipArr = @[@"已提交",@"审核失败",@"交易超时",@"已完成",@"已完成"];
     NSMutableArray *rightList = [NSMutableArray arrayWithArray:_timeList];;
     //    rightList = [rightList reverseObjectEnumerator];
     if (index == 0) {


          NSMutableDictionary *dic = [NSMutableDictionary new];
          [rightList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
               BUTimeList *t1 =  obj;
               NSString *tt = titleArr[idx];
               NSString *dd = detailArr[idx];
               NSString *ii = imgArr[idx];
               //               dic[tt] = t1.stateName;
               dic[tt] = stateArr[idx];
               dic[ii] = @"done";
               if (t1.state == 0) {
//                    dic[tt] = @"审核失败";
                    dic[ii] = @"wrong";
               }
               dic[dd] = t1.time;

          }];
          BUTimeList *ft = _timeList.lastObject;


          if (ft.state == 1) {
               dic[@"mark"] =   stateTipArr[_timeList.count - 1];
                 dic[@"hMark"] = @"trace";
          }
          else
          {
          dic[@"mark"] = stateFailTipArr[_timeList.count - 1];
                 dic[@"hMark"] = @"trace2";
          }
          for (NSInteger i = 0; i < 5 - rightList.count; i ++) {
               NSInteger idx = rightList.count + i;
               //               BUCheckList *t1 =  _checkList[idx];
               NSString *tt = titleArr[idx];
               NSString *dd = detailArr[idx];
               NSString *ii = imgArr[idx];
               dic[tt] = stateArr[idx];
               if (_timeList.count == 3 && ft.state == 1) {
                    dic[dd] = ft.time?:@"";
                    dic[ii] = @"done";
               }
               else
               {
               dic[dd] = @"";
               dic[ii] = @"unDone";
               }
          }
          if (_timeList.count == 3 && ft.state == 1) {
               dic[@"check"] = @(4);
          }
          else
          {
               dic[@"check"] = @(_timeList.count - 1);
          }
          return  dic;

     }
     else if (index == 1){
          NSString *title = [NSString stringWithFormat:@"服务单号：%@",_afterNO];
          NSString *detail = [NSString stringWithFormat:@"申请时间：%@",_createTime];
          return  @{@"title":title,@"detail":detail};
     }
     else if (index == 2){
          BUTimeList *t = rightList.firstObject;
          NSString *ss = @"";
          if (t.state == 0) {

          }
          return @{@"img":@"check",@"title":_stateName?:@""};
     }

     return @{};
}
-(NSDictionary *)getDic:(NSInteger)index{//售后用
     NSArray *titleArr = @[@"aTitle",@"bTitle",@"cTitle",@"dTitle",@"eTitle"];
     NSArray *imgArr = @[@"aimg",@"bimg",@"cimg",@"dimg",@"eimg"];
     NSArray *detailArr = @[@"aDetail",@"bDetail",@"cDetail",@"dDetail",@"eDetail"];
     NSArray *stateArr = @[@"提交申请",@"申请审核",@"售后收货",@"进行退款",@"处理完成"];
     NSMutableArray *rightList = [NSMutableArray arrayWithArray:_timeList];
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
               if (idx > 4) {
                    return ;
               }
               BUTimeList *t1 =  obj;
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
               dic[dd] = t1.time;

          }];
          dic[@"check"] = @(MIN(_timeList.count - 1, 4));
          dic[@"hMark"] = @"trace";
          dic[@"mark"] = @"已完成";
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
          NSString *title = [NSString stringWithFormat:@"服务单号：%@",_afterNO];
          NSString *detail = [NSString stringWithFormat:@"申请时间：%@",_createTime];
          return  @{@"title":title,@"detail":detail};
     }
     else if (index == 2){
          BUTimeList *t = rightList.firstObject;
//          NSString *ss = @"";
          if (t.state == 0) {

          }
          return @{@"img":@"check",@"title":_stateName?:@""};
     }

     return @{};
}
@end

@implementation BURefund
-(id)init
{
     self = [super init];
     if(self){
          self.deserializationMap = @{@"BUImageRes":@"BUImageRes",@"leasInfo":@"BUGetOrder,leasInfo",@"subStr":@"NSString,subStr"};

     }
     return self;
}
@end

@implementation BUSaleType
@end

@implementation BUSaleList
-(id)init
{
     self = [super init];
     if(self){
          self.deserializationMap = @{@"BUImageRes":@"BUImageRes",@"orderInfo":@"BUGetOrder,orderInfo",@"subStr":@"NSString,subStr"};

     }
     return self;
}
-(NSDictionary*)getDic
{
     NSString *tt = _saleTime;
      NSString *nn = _orderInfo.orderNO;
     NSString *ts = @"申请时间：";
     if(__SCREEN_SIZE.width == 320)
     {
          ts = @"";
     }
     tt = [tt substringWithRange:NSMakeRange(0, MIN(10, tt.length))];
     return @{@"title":[NSString stringWithFormat:@"订单编号：%@",nn],@"detail":[NSString stringWithFormat:@"%@%@",ts,tt]};
}

-(NSDictionary *)getAfterSellDic
{

          NSString *st = @"已完成";
          NSString *tt = @"check";
          if (_state == 0) {
               st = @"待处理";
               tt = @"af_daichuli";
          }
          else
               if (_state == 1) {
                    st = @"退货中";
                    tt = @"af_tuihuo";
               }
               else if (_state == 2)
               {
                    st = @"退货中";
                    tt = @"af_tuihuo";
               }
               else if (_state == 3)
               {
                    st = @"退货中";
                    tt = @"af_tuihuo";
               }
               else if (_state == 4)
               {
                    st = @"已完成";
                    tt = @"af_done";
               }
               else
               {
                    st = @"已拒绝";
                    tt = @"af_jujue";
               }
          return @{@"title":st,@"img":tt?:@"check",@"btnImg":@"rightArrow2"};

}

@end
@implementation BUReletList
-(id)init
{
     self = [super init];
     if(self){
          self.deserializationMap = @{@"BUImageRes":@"BUImageRes",@"orderInfo":@"BUGetOrder,orderInfo",@"subStr":@"NSString,subStr"};

     }
     return self;
}
-(NSDictionary *)getDicA
{


     return @{@"title":[NSString stringWithFormat:@"订单编号：%@",_orderInfo.orderNO?: @""],@"detail":@"租赁中"};
}
-(NSDictionary *)getDic
{
     NSString *st = @"待审批";
     if (_state == 1) {
          st = @"待付款";
     }
     else if (_state == 2)
     {
          st = @"已续租";
     }
     else if (_state == 3)
     {
          st = @"未通过";
     }

     return @{@"title":[NSString stringWithFormat:@"订单编号：%@",_orderInfo.orderNO?: @""],@"detail":st};
}

-(NSDictionary *)getDicB
{
     NSString *st = @"";
     NSString *pp = @"";
     st = [NSString stringWithFormat:@"申请时间：%@",_time?:@""];
     if (_state == 1) {
pp = @"立即支付";
     }
     else if (_state == 2)
     {

     }
     else
     {

     }

        return @{@"title":pp,@"detail":st};;
}
@end

@implementation BUBuyoutld
-(id)init
{
     self = [super init];
     if(self){
          self.deserializationMap = @{@"BUImageRes":@"BUImageRes",@"orderInfo":@"BUGetOrder,orderInfo",@"subStr":@"NSString,subStr"};

     }
     return self;
}
-(NSDictionary *)getDicA
{


     return @{@"title":[NSString stringWithFormat:@"订单编号：%@",_orderInfo.orderNO?: @""],@"detail":@"租赁中"};
}

-(NSDictionary *)getDic
{
     NSString *st = @"待审批";
     if (_buState == 1) {
          st = @"待付款";
     }
     else if (_buState == 2)
     {
          st = @"已买断";
     }
     else if (_buState == 3)
     {
          st = @"未通过";
     }

     return @{@"title":[NSString stringWithFormat:@"订单编号：%@",_orderInfo.orderNO?: @""],@"detail":st};
}

-(NSDictionary *)getDicB
{
     NSString *st = @"";
     NSString *pp = @"";
     st = [NSString stringWithFormat:@"申请时间：%@",_time?:@""];
     if (_buState == 1) {
          pp = @"立即支付";
     }
     else if (_buState == 2)
     {

     }
     else
     {

     }

     return @{@"title":pp,@"detail":st};;
}
@end

@implementation BUSubList
-(NSDictionary *)getDic
{

     NSString *p = @"未到期";
     NSString *pp = @"";
     if (_isTime == 1) {
          if(_isPay == 0)
          {
               if([_chaoMoney integerValue] > 0)
               {
               p = @"已超期";
                    pp = [NSString stringWithFormat:@"+%@",_chaoMoney];
               }else
               {
             p = @"待支付";
               }
          }
          else
          {
               p = @"已付款";
          }
     }
     return @{@"title":[NSString stringWithFormat:@"¥%@",_money],@"detail":_createTime?:@"",@"detail2":p,@"detail3":pp};
}
@end


@implementation BUMainPath
-(id)init
{
     self = [super init];
     if(self){
          self.deserializationMap = @{@"BUImageRes":@"BUImageRes",@"subList":@"BUSubList,subList",@"proInfo":@"BUProInfo,proInfo"};

     }
     return self;
}
@end

@implementation BUOrderMsg
-(id)init
{
     self = [super init];
     if(self){
          self.deserializationMap = @{@"BUImageRes":@"BUImageRes",@"imgList":@"BUImageRes,imgList",@"subStr":@"NSString,subStr"};

     }
     return self;
}
-(NSDictionary*)getDic
{
     NSString *q = @"元/月";
     if (_leaseType == 1) {
          q = @"元/天";
     }
     NSString *su = [_subStr componentsJoinedByString:@"/"];
     return @{@"title":_productName?:@"",@"source":[NSString stringWithFormat:@"%@",su],@"time":[NSString stringWithFormat:@"￥%@%@",_leaseMoney,q],@"default":@"default",@"img":_img?:@"default"};
}

-(NSDictionary *)getDic:(NSInteger)row
{
     if (row == 0) {
          return @{@"title":_userName?:@"",@"source":_time?:@"",@"img":_userImg?:@"defaultHead",@"default":@"defaultHead"};
     }
     else if (row == 1)
     {
          NSString *su = [_subStr componentsJoinedByString:@"/"];
          NSString *q = @"元/月";
          if (_leaseType == 1) {
               q = @"元/天";
          }
          NSString *zj = [NSString stringWithFormat:@"¥%@%@",_leaseMoney,q];
          return @{@"title":_productName?:@"",@"source":su?:@"",@"time":zj,@"img":_img?:@"default",@"default":@"default"};
     }
     else if (row == 2)
     {
//          [_imgList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//
//          }];
          return @{@"arr":_imgList?:@[]};
     }
     else
     {
          return @{@"title":_msg?:@""};
     }
}

@end

@implementation BUAreaList
+(NSArray*)getFitSelectionArr:(NSArray *)arr
{
     NSMutableArray *marr = [NSMutableArray new];
     [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
          BUAreaList *c = obj;

          [marr addObject:@{@"title":c.areaName?:@"",@"id":c.areaId?:@""}];
     }];
     return marr;
}
@end

@implementation BUCitylist

-(id)init
{
     self = [super init];
     if(self){
          self.deserializationMap = @{@"BUImageRes":@"BUImageRes",@"areaList":@"BUAreaList,areaList"};

     }
     return self;
}

+(NSArray*)getFitSelectionArr:(NSArray *)arr
{
     NSMutableArray *marr = [NSMutableArray new];
     [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
          BUCitylist *c = obj;
          NSArray *a = [BUAreaList getFitSelectionArr:c.areaList];
          [marr addObject:@{@"title":c.cityName?:@"",@"arr":a,@"id":c.cityID?:@""}];
     }];
     return marr;
}
@end


@implementation BUGetProvinlist

-(id)init
{
     self = [super init];
     if(self){
          self.deserializationMap = @{@"BUImageRes":@"BUImageRes",@"citylist":@"BUCitylist,citylist"};

     }
     return self;
}

+(NSArray*)getFitSelectionArr:(NSArray *)arr
{
     NSMutableArray *marr = [NSMutableArray new];
     [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
          BUGetProvinlist *p = obj;
        NSArray *a = [BUCitylist getFitSelectionArr:p.citylist];
          [marr addObject:@{@"title":p.provinceName?:@"",@"arr":a,@"id":p.provinceID?:@""}];
     }];
     return marr;
}
@end


@implementation BUGetColloc
-(id)init
{
     self = [super init];
     if(self){
          self.deserializationMap = @{@"BUImageRes":@"BUImageRes"};

     }
     return self;
}
-(NSDictionary *)getDic
{
     NSString *zj = @"";
     if(_leaseType == 0)
     {
          zj = @"元/月";
     }
     else
     {
          zj = @"元/天";
     }
     return @{@"title":_name?:@"",@"source":[NSString stringWithFormat:@"¥%.2f%@",_leaseMoney,zj],@"time":[NSString stringWithFormat:@"商品价值：¥%.2f",_costMoney],@"img":_img?:@"",@"default":@"default",@"row":_indexPath?:[NSNull new]};
//     return @{@"title":@"DJI大疆 晓 Mavic Air 便携可折叠 4K无人机",@"source":[NSString stringWithFormat:@"¥99元/月"],@"time":[NSString stringWithFormat:@"商品价值：¥6499.00"],@"img":_img?:@"default",@"default":@"default",@"row":_indexPath?:[NSNull new]};
}
@end


@implementation BUServiceList
-(id)init
{
     self = [super init];
     if(self){
          self.deserializationMap = @{@"BUImageRes":@"BUImageRes"};

     }
     return self;
}

-(NSDictionary *)getDic
{
     return @{@"title":_title?:@"",@"img":@"rightArrow2"};
}
@end

@implementation BUMyPathManager

-(id)init
{
     self = [super init];
     if(self){
          self.deserializationMap = @{@"BUImageRes":@"BUImageRes",@"goodsImage":@"BUImageRes,goodsImage"};
          self.getUserMsgManager = [BUGetUserMsgManager new];
          self.getMyCouponUnUseManager = [BUGetMyCouponManager new];
          self.getMyCouponUnUseManager.typeCou = @"1";

          self.getMyCouponUsedManager = [BUGetMyCouponManager new];
          self.getMyCouponUsedManager.typeCou = @"2";

          self.getMyCouponPassedManager = [BUGetMyCouponManager new];
          self.getMyCouponPassedManager.typeCou = @"3";
     }
     return self;
}

-(BOOL)getServiceList:(NSString*) msg withUserid:(NSString*) userId observer:(id)observer callback:(SEL)callback
{
     return [self getServiceList: msg withUserid: userId observer:observer callback:callback extraInfo:nil];
}

-(BOOL)getServiceList:(NSString*) msg withUserid:(NSString*) userId observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo
{
     NSInvocation *input = BSGetInvocationFromSel(self, @selector(getServiceListInput: withUserid:));
     [input setArgument:&msg atIndex:2];
     [input setArgument:&userId atIndex:3];
     [input retainArguments];
     return [self sendRequest:[NSString stringWithFormat:@"%@%@",BU_BUSINESS_DOMAIN_MYPATH,BU_BUSINESS_GetServiceList]
                         head:nil
                       method:@"POST"
                        async:YES
              inputInvocation:input
             outputInvocation:BSGetInvocationFromSel(self, @selector(getServiceListOutput:ok:input:))
                     observer:observer
                       action:callback
                    extraInfo:extraInfo];

}


-(NSData *)getServiceListInput:(NSString*) msg withUserid:(NSString*) userId
{
     NSString *request = [NSString stringWithFormat:@"msg=%@&userId=%@",msg,userId];
     return [request dataUsingEncoding:NSUTF8StringEncoding];

}

-(NSError *)getServiceListOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input

{
     UNPACKETOUTPUTHEAD(recvData, ok);
     _serviceList = nil;
     [jsonObj  deserializationSpecifityMap:self map:@{@"data":@"BUServiceList,serviceList"}];
     return SuccessedError;

}

-(BOOL)bringStock:(NSString*) userId observer:(id)observer callback:(SEL)callback
{
     return [self bringStock: userId observer:observer callback:callback extraInfo:nil];
}

-(BOOL)bringStock:(NSString*) userId observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo
{
     NSInvocation *input = BSGetInvocationFromSel(self, @selector(bringStockInput:));
     [input setArgument:&userId atIndex:2];
     [input retainArguments];
     return [self sendRequest:[NSString stringWithFormat:@"%@%@",BU_BUSINESS_DOMAIN_MYPATH,BU_BUSINESS_BringStock]
                         head:nil
                       method:@"POST"
                        async:YES
              inputInvocation:input
             outputInvocation:BSGetInvocationFromSel(self, @selector(bringStockOutput:ok:input:))
                     observer:observer
                       action:callback
                    extraInfo:extraInfo];

}


-(NSData *)bringStockInput:(NSString*) userId
{
     NSString *request = [NSString stringWithFormat:@"userId=%@",userId];
     return [request dataUsingEncoding:NSUTF8StringEncoding];

}

-(NSError *)bringStockOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input

{
     UNPACKETOUTPUTHEAD(recvData, ok);
     _getMyCouponArr = nil;
       [jsonObj  deserializationSpecifityMap:self map:@{@"data":@"BUGetMyCoupon,getMyCouponArr"}];
     return SuccessedError;

}

-(BOOL)addCoupon:(NSString*) userId withCouponid:(NSString*) couponId observer:(id)observer callback:(SEL)callback
{
     return [self addCoupon: userId withCouponid: couponId observer:observer callback:callback extraInfo:nil];
}

-(BOOL)addCoupon:(NSString*) userId withCouponid:(NSString*) couponId observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo
{
     NSInvocation *input = BSGetInvocationFromSel(self, @selector(addCouponInput: withCouponid:));
     [input setArgument:&userId atIndex:2];
     [input setArgument:&couponId atIndex:3];
     [input retainArguments];
     return [self sendRequest:[NSString stringWithFormat:@"%@%@",BU_BUSINESS_DOMAIN_MYPATH,BU_BUSINESS_AddCoupon]
                         head:nil
                       method:@"POST"
                        async:YES
              inputInvocation:input
             outputInvocation:BSGetInvocationFromSel(self, @selector(addCouponOutput:ok:input:))
                     observer:observer
                       action:callback
                    extraInfo:extraInfo];

}


-(NSData *)addCouponInput:(NSString*) userId withCouponid:(NSString*) couponId
{
     NSString *request = [NSString stringWithFormat:@"userId=%@&couponId=%@",userId,couponId];
     return [request dataUsingEncoding:NSUTF8StringEncoding];

}

-(NSError *)addCouponOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input

{
     UNPACKETOUTPUTHEAD(recvData, ok);

     return SuccessedError;

}

-(BOOL)addandUpAddress:(NSString*) userId withCityid:(NSString*) cityId withUsername:(NSString*) userName withAddressid:(NSString*) addressId withProvinceid:(NSString*) provinceId withAreaid:(NSString*) areaId withAddress:(NSString*) address withFloor:(NSString*) floor withIsdefault:(NSString*) isDefault withTel:(NSString*) tel observer:(id)observer callback:(SEL)callback
{
     return [self addandUpAddress: userId withCityid: cityId withUsername: userName withAddressid: addressId withProvinceid: provinceId withAreaid: areaId withAddress: address withFloor: floor withIsdefault: isDefault withTel: tel observer:observer callback:callback extraInfo:nil];
}

-(BOOL)addandUpAddress:(NSString*) userId withCityid:(NSString*) cityId withUsername:(NSString*) userName withAddressid:(NSString*) addressId withProvinceid:(NSString*) provinceId withAreaid:(NSString*) areaId withAddress:(NSString*) address withFloor:(NSString*) floor withIsdefault:(NSString*) isDefault withTel:(NSString*) tel observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo
{
     NSInvocation *input = BSGetInvocationFromSel(self, @selector(addandUpAddressInput: withCityid: withUsername: withAddressid: withProvinceid: withAreaid: withAddress: withFloor: withIsdefault: withTel:));
     [input setArgument:&userId atIndex:2];
     [input setArgument:&cityId atIndex:3];
     [input setArgument:&userName atIndex:4];
     [input setArgument:&addressId atIndex:5];
     [input setArgument:&provinceId atIndex:6];
     [input setArgument:&areaId atIndex:7];
     [input setArgument:&address atIndex:8];
     [input setArgument:&floor atIndex:9];
     [input setArgument:&isDefault atIndex:10];
     [input setArgument:&tel atIndex:11];
     [input retainArguments];
     return [self sendRequest:[NSString stringWithFormat:@"%@%@",BU_BUSINESS_DOMAIN_MYPATH,BU_BUSINESS_AddandUpAddress]
                         head:nil
                       method:@"POST"
                        async:YES
              inputInvocation:input
             outputInvocation:BSGetInvocationFromSel(self, @selector(addandUpAddressOutput:ok:input:))
                     observer:observer
                       action:callback
                    extraInfo:extraInfo];

}


-(NSData *)addandUpAddressInput:(NSString*) userId withCityid:(NSString*) cityId withUsername:(NSString*) userName withAddressid:(NSString*) addressId withProvinceid:(NSString*) provinceId withAreaid:(NSString*) areaId withAddress:(NSString*) address withFloor:(NSString*) floor withIsdefault:(NSString*) isDefault withTel:(NSString*) tel
{
     NSString *request = [NSString stringWithFormat:@"userId=%@&cityId=%@&userName=%@&addressId=%@&provinceId=%@&areaId=%@&address=%@&floor=%@&isDefault=%@&tel=%@",userId,cityId,userName,addressId,provinceId,areaId,address,floor,isDefault,tel];
     return [request dataUsingEncoding:NSUTF8StringEncoding];

}

-(NSError *)addandUpAddressOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input

{
     UNPACKETOUTPUTHEAD(recvData, ok);

     return SuccessedError;

}

-(BOOL)getColloc:(NSString*) userId observer:(id)observer callback:(SEL)callback
{
     return [self getColloc: userId observer:observer callback:callback extraInfo:nil];
}

-(BOOL)getColloc:(NSString*) userId observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo
{
     NSInvocation *input = BSGetInvocationFromSel(self, @selector(getCollocInput:));
     [input setArgument:&userId atIndex:2];
     [input retainArguments];
     return [self sendRequest:[NSString stringWithFormat:@"%@%@",BU_BUSINESS_DOMAIN_MYPATH,BU_BUSINESS_GetColloc]
                         head:nil
                       method:@"POST"
                        async:YES
              inputInvocation:input
             outputInvocation:BSGetInvocationFromSel(self, @selector(getCollocOutput:ok:input:))
                     observer:observer
                       action:callback
                    extraInfo:extraInfo];

}


-(NSData *)getCollocInput:(NSString*) userId
{
     NSString *request = [NSString stringWithFormat:@"userId=%@",userId];
     return [request dataUsingEncoding:NSUTF8StringEncoding];

}

-(NSError *)getCollocOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input

{
     UNPACKETOUTPUTHEAD(recvData, ok);
     _getCollocArr = nil;
 [jsonObj  deserializationSpecifityMap:self map:@{@"data":@"BUGetColloc,getCollocArr"}];
     return SuccessedError;

}

-(BOOL)addandUpCon:(NSString*) userId withProductid:(NSString*) productId observer:(id)observer callback:(SEL)callback
{
     return [self addandUpCon: userId withProductid: productId observer:observer callback:callback extraInfo:nil];
}

-(BOOL)addandUpCon:(NSString*) userId withProductid:(NSString*) productId observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo
{
     NSInvocation *input = BSGetInvocationFromSel(self, @selector(addandUpConInput: withProductid:));
     [input setArgument:&userId atIndex:2];
     [input setArgument:&productId atIndex:3];
     [input retainArguments];
     return [self sendRequest:[NSString stringWithFormat:@"%@%@",BU_BUSINESS_DOMAIN_MYPATH,BU_BUSINESS_AddandUpCon]
                         head:nil
                       method:@"POST"
                        async:YES
              inputInvocation:input
             outputInvocation:BSGetInvocationFromSel(self, @selector(addandUpConOutput:ok:input:))
                     observer:observer
                       action:callback
                    extraInfo:extraInfo];

}


-(NSData *)addandUpConInput:(NSString*) userId withProductid:(NSString*) productId
{
     NSString *request = [NSString stringWithFormat:@"userId=%@&productId=%@",userId,productId];
     return [request dataUsingEncoding:NSUTF8StringEncoding];

}

-(NSError *)addandUpConOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input

{
     UNPACKETOUTPUTHEAD(recvData, ok);

     return SuccessedError;

}

-(BOOL)getProvinlist:(id)observer callback:(SEL)callback
{
     return [self getProvinlist:observer callback:callback extraInfo:nil];
}

-(BOOL)getProvinlist:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo
{
//     NSInvocation *input = BSGetInvocationFromSel(self, @selector(getProvinlistInput));
//
//     [input retainArguments];
     return [self sendRequest:[NSString stringWithFormat:@"%@%@",BU_BUSINESS_DOMAIN_MYPATH,BU_BUSINESS_GetProvinlist]
                         head:nil
                       method:@"POST"
                        async:YES
              inputInvocation:nil
             outputInvocation:BSGetInvocationFromSel(self, @selector(getProvinlistOutput:ok:input:))
                     observer:observer
                       action:callback
                    extraInfo:extraInfo];

}


//-(NSData *)getProvinlistInput
//{
//     NSString *request = [NSString stringWithFormat:@"",];
//     return [request dataUsingEncoding:NSUTF8StringEncoding];
//
//}

-(NSError *)getProvinlistOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input

{
     UNPACKETOUTPUTHEAD(recvData, ok);
     _getProvinlist = nil;
      [jsonObj  deserializationSpecifityMap:self map:@{@"data":@"BUGetProvinlist,getProvinlist"}];
     return SuccessedError;

}

-(BOOL)addOrderMsg:(NSString*) msg withOrderid:(NSString*) orderID withUserid:(NSString*) userId observer:(id)observer callback:(SEL)callback
{
     return [self addOrderMsg: msg withOrderid: orderID withUserid: userId observer:observer callback:callback extraInfo:nil];
}

-(BOOL)addOrderMsg:(NSString*) msg withOrderid:(NSString*) orderID withUserid:(NSString*) userId observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo
{
     NSInvocation *input = BSGetInvocationFromSel(self, @selector(addOrderMsgInput: withOrderid: withUserid:));
     [input setArgument:&msg atIndex:2];
     [input setArgument:&orderID atIndex:3];
     [input setArgument:&userId atIndex:4];
     [input retainArguments];
     return [self sendRequest:[NSString stringWithFormat:@"%@%@",BU_BUSINESS_DOMAIN_MYPATH,BU_BUSINESS_AddOrderMsg]
                         head:nil
                       method:@"POST"
                        async:YES
              inputInvocation:input
             outputInvocation:BSGetInvocationFromSel(self, @selector(addOrderMsgOutput:ok:input:))
                     observer:observer
                       action:callback
                    extraInfo:extraInfo];

}


-(NSData *)addOrderMsgInput:(NSString*) msg withOrderid:(NSString*) orderID withUserid:(NSString*) userId
{
     NSString *request = [NSString stringWithFormat:@"msg=%@&orderID=%@&userId=%@",msg,orderID,userId];
     return [request dataUsingEncoding:NSUTF8StringEncoding];

}

-(NSError *)addOrderMsgOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input

{
     UNPACKETOUTPUTHEAD(recvData, ok);

     return SuccessedError;

}

-(BOOL)saleType:(id)observer callback:(SEL)callback
{
     return [self saleType:observer callback:callback extraInfo:nil];
}

-(BOOL)saleType:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo
{
     NSInvocation *input = BSGetInvocationFromSel(self, @selector(saleTypeInput));

     [input retainArguments];
     return [self sendRequest:[NSString stringWithFormat:@"%@%@",BU_BUSINESS_DOMAIN_MYPATH,BU_BUSINESS_SaleType]
                         head:nil
                       method:@"POST"
                        async:YES
              inputInvocation:input
             outputInvocation:BSGetInvocationFromSel(self, @selector(saleTypeOutput:ok:input:))
                     observer:observer
                       action:callback
                    extraInfo:extraInfo];

}


-(NSData *)saleTypeInput
{
     NSString *request = [NSString stringWithFormat:@""];
     return [request dataUsingEncoding:NSUTF8StringEncoding];

}

-(NSError *)saleTypeOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input

{
     UNPACKETOUTPUTHEAD(recvData, ok);
     _saleTypeArr  = nil;
         [jsonObj  deserializationSpecifityMap:self map:@{@"data":@"BUSaleType,saleTypeArr"}];
     return SuccessedError;

}

-(BOOL)buyoutld:(NSString*) state withUserid:(NSString*) userId observer:(id)observer callback:(SEL)callback
{
     return [self buyoutld: state withUserid: userId observer:observer callback:callback extraInfo:nil];
}

-(BOOL)buyoutld:(NSString*) state withUserid:(NSString*) userId observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo
{
     NSInvocation *input = BSGetInvocationFromSel(self, @selector(buyoutldInput: withUserid:));
     [input setArgument:&state atIndex:2];
     [input setArgument:&userId atIndex:3];
     [input retainArguments];
     return [self sendRequest:[NSString stringWithFormat:@"%@%@",BU_BUSINESS_DOMAIN_MYPATH,BU_BUSINESS_Buyoutld]
                         head:nil
                       method:@"POST"
                        async:YES
              inputInvocation:input
             outputInvocation:BSGetInvocationFromSel(self, @selector(buyoutldOutput:ok:input:))
                     observer:observer
                       action:callback
                    extraInfo:extraInfo];

}


-(NSData *)buyoutldInput:(NSString*) state withUserid:(NSString*) userId
{
     NSString *request = [NSString stringWithFormat:@"state=%@&userId=%@",state,userId];
     return [request dataUsingEncoding:NSUTF8StringEncoding];

}

-(NSError *)buyoutldOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input

{
     UNPACKETOUTPUTHEAD(recvData, ok);
     _buyoutldArr = nil;
      [jsonObj  deserializationSpecifityMap:self map:@{@"data":@"BUBuyoutld,buyoutldArr"}];
     return SuccessedError;

}

-(BOOL)orderMsgList:(NSString*) state withUserid:(NSString*) userId observer:(id)observer callback:(SEL)callback
{
     return [self orderMsgList: state withUserid: userId observer:observer callback:callback extraInfo:nil];
}

-(BOOL)orderMsgList:(NSString*) state withUserid:(NSString*) userId observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo
{
     NSInvocation *input = BSGetInvocationFromSel(self, @selector(orderMsgListInput: withUserid:));
     [input setArgument:&state atIndex:2];
     [input setArgument:&userId atIndex:3];
     [input retainArguments];
     return [self sendRequest:[NSString stringWithFormat:@"%@%@",BU_BUSINESS_DOMAIN_MYPATH,BU_BUSINESS_OrderMsgList]
                         head:nil
                       method:@"POST"
                        async:YES
              inputInvocation:input
             outputInvocation:BSGetInvocationFromSel(self, @selector(orderMsgListOutput:ok:input:))
                     observer:observer
                       action:callback
                    extraInfo:extraInfo];

}


-(NSData *)orderMsgListInput:(NSString*) state withUserid:(NSString*) userId
{
     NSString *request = [NSString stringWithFormat:@"state=%@&userId=%@",state,userId];
     return [request dataUsingEncoding:NSUTF8StringEncoding];

}

-(NSError *)orderMsgListOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input

{
     UNPACKETOUTPUTHEAD(recvData, ok);
     _orderMsgList = nil;
     [jsonObj  deserializationSpecifityMap:self map:@{@"data":@"BUOrderMsg,orderMsgList"}];
     return SuccessedError;

}

-(BOOL)addBuyoutld:(NSString*) orderID withUserid:(NSString*) userId observer:(id)observer callback:(SEL)callback
{
     return [self addBuyoutld: orderID withUserid: userId observer:observer callback:callback extraInfo:nil];
}

-(BOOL)addBuyoutld:(NSString*) orderID withUserid:(NSString*) userId observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo
{
     NSInvocation *input = BSGetInvocationFromSel(self, @selector(addBuyoutldInput: withUserid:));
     [input setArgument:&orderID atIndex:2];
     [input setArgument:&userId atIndex:3];
     [input retainArguments];
     return [self sendRequest:[NSString stringWithFormat:@"%@%@",BU_BUSINESS_DOMAIN_MYPATH,BU_BUSINESS_AddBuyoutld]
                         head:nil
                       method:@"POST"
                        async:YES
              inputInvocation:input
             outputInvocation:BSGetInvocationFromSel(self, @selector(addBuyoutldOutput:ok:input:))
                     observer:observer
                       action:callback
                    extraInfo:extraInfo];

}


-(NSData *)addBuyoutldInput:(NSString*) orderID withUserid:(NSString*) userId
{
     NSString *request = [NSString stringWithFormat:@"orderID=%@&userId=%@",orderID,userId];
     return [request dataUsingEncoding:NSUTF8StringEncoding];

}

-(NSError *)addBuyoutldOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input

{
     UNPACKETOUTPUTHEAD(recvData, ok);

     return SuccessedError;

}

-(BOOL)buyouInfo:(NSString*) userId withBuyoutid:(NSString*) buyoutId observer:(id)observer callback:(SEL)callback
{
     return [self buyouInfo: userId withBuyoutid: buyoutId observer:observer callback:callback extraInfo:nil];
}

-(BOOL)buyouInfo:(NSString*) userId withBuyoutid:(NSString*) buyoutId observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo
{
     NSInvocation *input = BSGetInvocationFromSel(self, @selector(buyouInfoInput: withBuyoutid:));
     [input setArgument:&userId atIndex:2];
     [input setArgument:&buyoutId atIndex:3];
     [input retainArguments];
     return [self sendRequest:[NSString stringWithFormat:@"%@%@",BU_BUSINESS_DOMAIN_MYPATH,BU_BUSINESS_BuyouInfo]
                         head:nil
                       method:@"POST"
                        async:YES
              inputInvocation:input
             outputInvocation:BSGetInvocationFromSel(self, @selector(buyouInfoOutput:ok:input:))
                     observer:observer
                       action:callback
                    extraInfo:extraInfo];

}


-(NSData *)buyouInfoInput:(NSString*) userId withBuyoutid:(NSString*) buyoutId
{
     NSString *request = [NSString stringWithFormat:@"userId=%@&buyoutId=%@",userId,buyoutId];
     return [request dataUsingEncoding:NSUTF8StringEncoding];

}

-(NSError *)buyouInfoOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input

{
     UNPACKETOUTPUTHEAD(recvData, ok);
     _buyoutInfo = nil;
     [jsonObj  deserializationSpecifityMap:self map:@{@"data":@"BUSaleInfo,buyoutInfo"}];
     return SuccessedError;

}

-(BOOL)reletList:(NSString*) state withUserid:(NSString*) userId observer:(id)observer callback:(SEL)callback
{
     return [self reletList: state withUserid: userId observer:observer callback:callback extraInfo:nil];
}

-(BOOL)reletList:(NSString*) state withUserid:(NSString*) userId observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo
{
     NSInvocation *input = BSGetInvocationFromSel(self, @selector(reletListInput: withUserid:));
     [input setArgument:&state atIndex:2];
     [input setArgument:&userId atIndex:3];
     [input retainArguments];
     return [self sendRequest:[NSString stringWithFormat:@"%@%@",BU_BUSINESS_DOMAIN_MYPATH,BU_BUSINESS_ReletList]
                         head:nil
                       method:@"POST"
                        async:YES
              inputInvocation:input
             outputInvocation:BSGetInvocationFromSel(self, @selector(reletListOutput:ok:input:))
                     observer:observer
                       action:callback
                    extraInfo:extraInfo];

}


-(NSData *)reletListInput:(NSString*) state withUserid:(NSString*) userId
{
     NSString *request = [NSString stringWithFormat:@"state=%@&userId=%@",state,userId];
     return [request dataUsingEncoding:NSUTF8StringEncoding];

}

-(NSError *)reletListOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input

{
     UNPACKETOUTPUTHEAD(recvData, ok);
     _reletList = nil;
     [jsonObj  deserializationSpecifityMap:self map:@{@"data":@"BUReletList,reletList"}];
     return SuccessedError;

}
-(BOOL)addRele:(NSString*) orderID withUserid:(NSString*) userId withDay:(NSString*) day observer:(id)observer callback:(SEL)callback
{
     return [self addRele: orderID withUserid: userId withDay: day observer:observer callback:callback extraInfo:nil];
}

-(BOOL)addRele:(NSString*) orderID withUserid:(NSString*) userId withDay:(NSString*) day observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo
{
     NSInvocation *input = BSGetInvocationFromSel(self, @selector(addReleInput: withUserid: withDay:));
     [input setArgument:&orderID atIndex:2];
     [input setArgument:&userId atIndex:3];
     [input setArgument:&day atIndex:4];
     [input retainArguments];
     return [self sendRequest:[NSString stringWithFormat:@"%@%@",BU_BUSINESS_DOMAIN_MYPATH,BU_BUSINESS_AddRele]
                         head:nil
                       method:@"POST"
                        async:YES
              inputInvocation:input
             outputInvocation:BSGetInvocationFromSel(self, @selector(addReleOutput:ok:input:))
                     observer:observer
                       action:callback
                    extraInfo:extraInfo];

}


-(NSData *)addReleInput:(NSString*) orderID withUserid:(NSString*) userId withDay:(NSString*) day
{
     NSString *request = [NSString stringWithFormat:@"orderID=%@&userId=%@&day=%@",orderID,userId,day];
     return [request dataUsingEncoding:NSUTF8StringEncoding];

}

-(NSError *)addReleOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input

{
     UNPACKETOUTPUTHEAD(recvData, ok);

     return SuccessedError;

}

-(BOOL)reletInfo:(NSString*) reletId withUserid:(NSString*) userId observer:(id)observer callback:(SEL)callback
{
     return [self reletInfo: reletId withUserid: userId observer:observer callback:callback extraInfo:nil];
}

-(BOOL)reletInfo:(NSString*) reletId withUserid:(NSString*) userId observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo
{
     NSInvocation *input = BSGetInvocationFromSel(self, @selector(reletInfoInput: withUserid:));
     [input setArgument:&reletId atIndex:2];
     [input setArgument:&userId atIndex:3];
     [input retainArguments];
     return [self sendRequest:[NSString stringWithFormat:@"%@%@",BU_BUSINESS_DOMAIN_MYPATH,BU_BUSINESS_ReletInfo]
                         head:nil
                       method:@"POST"
                        async:YES
              inputInvocation:input
             outputInvocation:BSGetInvocationFromSel(self, @selector(reletInfoOutput:ok:input:))
                     observer:observer
                       action:callback
                    extraInfo:extraInfo];

}


-(NSData *)reletInfoInput:(NSString*) reletId withUserid:(NSString*) userId
{
     NSString *request = [NSString stringWithFormat:@"reletId=%@&userId=%@",reletId,userId];
     return [request dataUsingEncoding:NSUTF8StringEncoding];

}

-(NSError *)reletInfoOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input

{
     UNPACKETOUTPUTHEAD(recvData, ok);
     _releteInfo = nil;
     [jsonObj  deserializationSpecifityMap:self map:@{@"data":@"BUSaleInfo,releteInfo"}];
     return SuccessedError;

}
-(BOOL)saleList:(NSString*) state withUserid:(NSString*) userId observer:(id)observer callback:(SEL)callback
{
     return [self saleList: state withUserid: userId observer:observer callback:callback extraInfo:nil];
}

-(BOOL)saleList:(NSString*) state withUserid:(NSString*) userId observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo
{
     NSInvocation *input = BSGetInvocationFromSel(self, @selector(saleListInput: withUserid:));
     [input setArgument:&state atIndex:2];
     [input setArgument:&userId atIndex:3];
     [input retainArguments];
     return [self sendRequest:[NSString stringWithFormat:@"%@%@",BU_BUSINESS_DOMAIN_MYPATH,BU_BUSINESS_SaleList]
                         head:nil
                       method:@"POST"
                        async:YES
              inputInvocation:input
             outputInvocation:BSGetInvocationFromSel(self, @selector(saleListOutput:ok:input:))
                     observer:observer
                       action:callback
                    extraInfo:extraInfo];

}


-(NSData *)saleListInput:(NSString*) state withUserid:(NSString*) userId
{
     NSString *request = [NSString stringWithFormat:@"state=%@&userId=%@",state,userId];
     return [request dataUsingEncoding:NSUTF8StringEncoding];

}

-(NSError *)saleListOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input

{
     UNPACKETOUTPUTHEAD(recvData, ok);
     _saleList = nil;
      [jsonObj  deserializationSpecifityMap:self map:@{@"data":@"BUSaleList,saleList"}];
     return SuccessedError;

}

-(BOOL)addSale:(NSString*) userId withUsername:(NSString*) userName withMsg:(NSString*) msg withOrderid:(NSString*) orderID withTel:(NSString*) tel withImgs:(NSArray *)imgs withAftertypeid:(NSString*) afterTypeId observer:(id)observer callback:(SEL)callback
{
     return [self addSale: userId withUsername: userName withMsg: msg withOrderid: orderID withTel: tel withImgs:(NSArray *)imgs withAftertypeid: afterTypeId observer:observer callback:callback extraInfo:nil];
}

-(BOOL)addSale:(NSString*) userId withUsername:(NSString*) userName withMsg:(NSString*) msg withOrderid:(NSString*) orderID withTel:(NSString*) tel withImgs:(NSArray *)imgs withAftertypeid:(NSString*) afterTypeId observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo
{
     if(imgs.count == 0) {

     NSInvocation *input = BSGetInvocationFromSel(self, @selector(addSaleInput: withUsername: withMsg: withOrderid: withTel: withAftertypeid:));
     [input setArgument:&userId atIndex:2];
     [input setArgument:&userName atIndex:3];
     [input setArgument:&msg atIndex:4];
     [input setArgument:&orderID atIndex:5];
     [input setArgument:&tel atIndex:6];
     [input setArgument:&afterTypeId atIndex:7];
     [input retainArguments];
     return [self sendRequest:[NSString stringWithFormat:@"%@%@",BU_BUSINESS_DOMAIN_MYPATH,BU_BUSINESS_AddSale]
                         head:nil
                       method:@"POST"
                        async:YES
              inputInvocation:input
             outputInvocation:BSGetInvocationFromSel(self, @selector(addSaleOutput:ok:input:))
                     observer:observer
                       action:callback
                    extraInfo:extraInfo];
     }else
     {
     NSMutableDictionary *dic = [NSMutableDictionary new];

     //    [dic addEntriesFromDictionary:[self getBaseUrlParemDic]];
     NSData *imgdata1;
     NSString *dtStr1 = [NSString stringWithFormat:@"%@.png",[[[BSUtility getUUIDString] dataUsingEncoding:NSUTF8StringEncoding] md5Data].hexStr];
     for (NSInteger i = 0; i < imgs.count; i++) {
          if (![imgs[i] isKindOfClass:[UIImage class]]) {
               continue;
          }
          if (!imgdata1) {
               imgdata1  = UIImageJPEGRepresentation([(UIImage*)imgs[i] imageByScalingToSize:CGSizeMake(320, 320)], 1);
               continue;
          }

          NSData *imgdata2 = UIImageJPEGRepresentation([imgs[i] imageByScalingToSize:CGSizeMake(320, 320)], 1);



          NSString *dtStr2 = [NSString stringWithFormat:@"%@.png",[[[BSUtility getUUIDString] dataUsingEncoding:NSUTF8StringEncoding] md5Data].hexStr];


          dic[[NSString stringWithFormat:@"file%ld=%@",(long)i+1,dtStr2]] = imgdata2;

     };
     dic[@"userId"] = userId?:@"";
     dic[@"userName"] = userName?:@"";
     dic[@"orderID"] = orderID?:@"";
          dic[@"msg"] = msg?:@"";
          dic[@"tel"] = tel?:@"";
          dic[@"afterTypeId"] = afterTypeId?:@"";

     [dic addEntriesFromDictionary:[self getBaseUrlParemDic]];
     return [self sendUploadRequest:[NSString stringWithFormat:@"%@/%@",BU_BUSINESS_DOMAIN_MYPATH,BU_BUSINESS_AddSale]
                               data:imgdata1
                           fileName:[NSString stringWithFormat:@"file=%@",dtStr1]//[NSString stringWithFormat:@"File=%@Uid=%@",logoName,_userId]
                   outputInvocation:BSGetInvocationFromSel(self, @selector(addSaleOutput:ok:input:))
                           observer:observer
                             action:callback
                          extraInfo:dic];
     }

}


-(NSData *)addSaleInput:(NSString*) userId withUsername:(NSString*) userName withMsg:(NSString*) msg withOrderid:(NSString*) orderID withTel:(NSString*) tel withAftertypeid:(NSString*) afterTypeId
{
     NSString *request = [NSString stringWithFormat:@"userId=%@&userName=%@&msg=%@&orderID=%@&tel=%@&afterTypeId=%@",userId,userName,msg,orderID,tel,afterTypeId];
     return [request dataUsingEncoding:NSUTF8StringEncoding];

}

-(NSError *)addSaleOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input

{
     UNPACKETOUTPUTHEAD(recvData, ok);
      _addSaleId = [jsonObj  objectForKey:@"data"];
//      = nil;
     return SuccessedError;

}

-(BOOL)saleInfo:(NSString*) afterId withUserid:(NSString*) userId observer:(id)observer callback:(SEL)callback
{
     return [self saleInfo: afterId withUserid: userId observer:observer callback:callback extraInfo:nil];
}

-(BOOL)saleInfo:(NSString*) afterId withUserid:(NSString*) userId observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo
{
     NSInvocation *input = BSGetInvocationFromSel(self, @selector(saleInfoInput: withUserid:));
     [input setArgument:&afterId atIndex:2];
     [input setArgument:&userId atIndex:3];
     [input retainArguments];
     return [self sendRequest:[NSString stringWithFormat:@"%@%@",BU_BUSINESS_DOMAIN_MYPATH,BU_BUSINESS_SaleInfo]
                         head:nil
                       method:@"POST"
                        async:YES
              inputInvocation:input
             outputInvocation:BSGetInvocationFromSel(self, @selector(saleInfoOutput:ok:input:))
                     observer:observer
                       action:callback
                    extraInfo:extraInfo];

}


-(NSData *)saleInfoInput:(NSString*) afterId withUserid:(NSString*) userId
{
     NSString *request = [NSString stringWithFormat:@"afterId=%@&userId=%@",afterId,userId];
     return [request dataUsingEncoding:NSUTF8StringEncoding];

}

-(NSError *)saleInfoOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input

{
     UNPACKETOUTPUTHEAD(recvData, ok);
     _saleInfo = nil;
      [jsonObj  deserializationSpecifityMap:self map:@{@"data":@"BUSaleInfo,saleInfo"}];
     return SuccessedError;

}

-(BOOL)addOrderMsg:(NSString*) msg withImg:(NSArray *)imgs withOrderid:(NSString*) orderID withUserid:(NSString*) userId observer:(id)observer callback:(SEL)callback
{
     NSMutableDictionary *dic = [NSMutableDictionary new];

     //    [dic addEntriesFromDictionary:[self getBaseUrlParemDic]];
     NSData *imgdata1;
     NSString *dtStr1 = [NSString stringWithFormat:@"%@.png",[[[BSUtility getUUIDString] dataUsingEncoding:NSUTF8StringEncoding] md5Data].hexStr];
     for (NSInteger i = 0; i < imgs.count; i++) {
          if (![imgs[i] isKindOfClass:[UIImage class]]) {
               continue;
          }
          if (!imgdata1) {
               imgdata1  = UIImageJPEGRepresentation([(UIImage*)imgs[i] imageByScalingToSize:CGSizeMake(320, 320)], 1);
               continue;
          }

          NSData *imgdata2 = UIImageJPEGRepresentation([imgs[i] imageByScalingToSize:CGSizeMake(320, 320)], 1);



          NSString *dtStr2 = [NSString stringWithFormat:@"%@.png",[[[BSUtility getUUIDString] dataUsingEncoding:NSUTF8StringEncoding] md5Data].hexStr];


          dic[[NSString stringWithFormat:@"file%ld=%@",(long)i+1,dtStr2]] = imgdata2;

     };
     dic[@"userId"] = userId?:@"";
     dic[@"msg"] = msg?:@"";
     dic[@"orderID"] = orderID?:@"";
     [dic addEntriesFromDictionary:[self getBaseUrlParemDic]];
     return [self sendUploadRequest:[NSString stringWithFormat:@"%@%@",BU_BUSINESS_DOMAIN_MYPATH,BU_BUSINESS_AddOrderMsg]
                               data:imgdata1
                           fileName:[NSString stringWithFormat:@"file=%@",dtStr1]//[NSString stringWithFormat:@"File=%@Uid=%@",logoName,_userId]
                   outputInvocation:BSGetInvocationFromSel(self, @selector(uploadImgsOutput:ok:input:))
                           observer:observer
                             action:callback
                          extraInfo:dic];

}


-(NSError *)uploadImgsOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input
{
     UNPACKETOUTPUTHEAD(recvData, ok);

//     _imgsList = nil;

//     [jsonObj  deserializationSpecifityMap:self map:@{@"data":@"BUImageRes,imgsList"}];
     return SuccessedError;//CustomError(0, [jsonObj objectForKey:@"retmsg"]);
}
-(BOOL)mainPath:(NSString*) orderID withUserid:(NSString*) userId observer:(id)observer callback:(SEL)callback
{
     return [self mainPath: orderID withUserid: userId observer:observer callback:callback extraInfo:nil];
}

-(BOOL)mainPath:(NSString*) orderID withUserid:(NSString*) userId observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo
{
     NSInvocation *input = BSGetInvocationFromSel(self, @selector(mainPathInput: withUserid:));
     [input setArgument:&orderID atIndex:2];
     [input setArgument:&userId atIndex:3];
     [input retainArguments];
     return [self sendRequest:[NSString stringWithFormat:@"%@%@",BU_BUSINESS_DOMAIN_MYPATH,BU_BUSINESS_MainPath]
                         head:nil
                       method:@"POST"
                        async:YES
              inputInvocation:input
             outputInvocation:BSGetInvocationFromSel(self, @selector(mainPathOutput:ok:input:))
                     observer:observer
                       action:callback
                    extraInfo:extraInfo];

}


-(NSData *)mainPathInput:(NSString*) orderID withUserid:(NSString*) userId
{
     NSString *request = [NSString stringWithFormat:@"orderID=%@&userId=%@",orderID,userId];
     return [request dataUsingEncoding:NSUTF8StringEncoding];

}

-(NSError *)mainPathOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input

{
     UNPACKETOUTPUTHEAD(recvData, ok);
     _mainPath = nil;
       [jsonObj  deserializationSpecifityMap:self map:@{@"data":@"BUMainPath,mainPath"}];
     return SuccessedError;

}

-(BOOL)rrfundPath:(NSString*) backLogisticsNO withUserid:(NSString*) userId withOrderid:(NSString*) orderID withBacklogisticscompany:(NSString*) backLogisticsCompany observer:(id)observer callback:(SEL)callback
{
     return [self rrfundPath: backLogisticsNO withUserid: userId withOrderid: orderID withBacklogisticscompany: backLogisticsCompany observer:observer callback:callback extraInfo:nil];
}

-(BOOL)rrfundPath:(NSString*) backLogisticsNO withUserid:(NSString*) userId withOrderid:(NSString*) orderID withBacklogisticscompany:(NSString*) backLogisticsCompany observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo
{
     NSInvocation *input = BSGetInvocationFromSel(self, @selector(rrfundPathInput: withUserid: withOrderid: withBacklogisticscompany:));
     [input setArgument:&backLogisticsNO atIndex:2];
     [input setArgument:&userId atIndex:3];
     [input setArgument:&orderID atIndex:4];
     [input setArgument:&backLogisticsCompany atIndex:5];
     [input retainArguments];
     return [self sendRequest:[NSString stringWithFormat:@"%@%@",BU_BUSINESS_DOMAIN_MYPATH,BU_BUSINESS_RrfundPath]
                         head:nil
                       method:@"POST"
                        async:YES
              inputInvocation:input
             outputInvocation:BSGetInvocationFromSel(self, @selector(rrfundPathOutput:ok:input:))
                     observer:observer
                       action:callback
                    extraInfo:extraInfo];

}


-(NSData *)rrfundPathInput:(NSString*) backLogisticsNO withUserid:(NSString*) userId withOrderid:(NSString*) orderID withBacklogisticscompany:(NSString*) backLogisticsCompany
{
     NSString *request = [NSString stringWithFormat:@"backLogisticsNO=%@&userId=%@&orderID=%@&backLogisticsCompany=%@",backLogisticsNO,userId,orderID,backLogisticsCompany];
     return [request dataUsingEncoding:NSUTF8StringEncoding];

}

-(NSError *)rrfundPathOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input

{
     UNPACKETOUTPUTHEAD(recvData, ok);

     return SuccessedError;

}

-(BOOL)refund:(NSString*) orderID withUserid:(NSString*) userId observer:(id)observer callback:(SEL)callback
{
     return [self refund: orderID withUserid: userId observer:observer callback:callback extraInfo:nil];
}

-(BOOL)refund:(NSString*) orderID withUserid:(NSString*) userId observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo
{
     NSInvocation *input = BSGetInvocationFromSel(self, @selector(refundInput: withUserid:));
     [input setArgument:&orderID atIndex:2];
     [input setArgument:&userId atIndex:3];
     [input retainArguments];
     return [self sendRequest:[NSString stringWithFormat:@"%@%@",BU_BUSINESS_DOMAIN_MYPATH,BU_BUSINESS_Refund]
                         head:nil
                       method:@"POST"
                        async:YES
              inputInvocation:input
             outputInvocation:BSGetInvocationFromSel(self, @selector(refundOutput:ok:input:))
                     observer:observer
                       action:callback
                    extraInfo:extraInfo];

}


-(NSData *)refundInput:(NSString*) orderID withUserid:(NSString*) userId
{
     NSString *request = [NSString stringWithFormat:@"orderID=%@&userId=%@",orderID,userId];
     return [request dataUsingEncoding:NSUTF8StringEncoding];

}

-(NSError *)refundOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input

{
     UNPACKETOUTPUTHEAD(recvData, ok);
     _refund = nil;
      [jsonObj  deserializationSpecifityMap:self map:@{@"data":@"BURefund,refund"}];
     return SuccessedError;

}

-(BOOL)deleAddress:(NSString*) userId withAddressid:(NSString*) addressId observer:(id)observer callback:(SEL)callback
{
     return [self deleAddress: userId withAddressid: addressId observer:observer callback:callback extraInfo:nil];
}

-(BOOL)deleAddress:(NSString*) userId withAddressid:(NSString*) addressId observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo
{
     NSInvocation *input = BSGetInvocationFromSel(self, @selector(deleAddressInput: withAddressid:));
     [input setArgument:&userId atIndex:2];
     [input setArgument:&addressId atIndex:3];
     [input retainArguments];
     return [self sendRequest:[NSString stringWithFormat:@"%@%@",BU_BUSINESS_DOMAIN_MYPATH,BU_BUSINESS_DeleAddress]
                         head:nil
                       method:@"POST"
                        async:YES
              inputInvocation:input
             outputInvocation:BSGetInvocationFromSel(self, @selector(deleAddressOutput:ok:input:))
                     observer:observer
                       action:callback
                    extraInfo:extraInfo];

}


-(NSData *)deleAddressInput:(NSString*) userId withAddressid:(NSString*) addressId
{
     NSString *request = [NSString stringWithFormat:@"userId=%@&addressId=%@",userId,addressId];
     return [request dataUsingEncoding:NSUTF8StringEncoding];

}

-(NSError *)deleAddressOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input

{
     UNPACKETOUTPUTHEAD(recvData, ok);

     return SuccessedError;

}

-(BOOL)userCertification:(NSString*) userId observer:(id)observer callback:(SEL)callback
{
     return [self userCertification: userId observer:observer callback:callback extraInfo:nil];
}

-(BOOL)userCertification:(NSString*) userId observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo
{
     NSInvocation *input = BSGetInvocationFromSel(self, @selector(userCertificationInput:));
     [input setArgument:&userId atIndex:2];
     [input retainArguments];
     return [self sendRequest:[NSString stringWithFormat:@"%@%@",BU_BUSINESS_DOMAIN_MYPATH,BU_BUSINESS_UserCertification]
                         head:nil
                       method:@"POST"
                        async:YES
              inputInvocation:input
             outputInvocation:BSGetInvocationFromSel(self, @selector(userCertificationOutput:ok:input:))
                     observer:observer
                       action:callback
                    extraInfo:extraInfo];

}


-(NSData *)userCertificationInput:(NSString*) userId
{
     NSString *request = [NSString stringWithFormat:@"userId=%@",userId];
     return [request dataUsingEncoding:NSUTF8StringEncoding];

}

-(NSError *)userCertificationOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input

{
     UNPACKETOUTPUTHEAD(recvData, ok);
     _userCertification = nil;
     [jsonObj  deserializationSpecifityMap:self map:@{@"data":@"BUUserCertification,userCertification"}];
     return SuccessedError;

}
@end
