//
//  BUGetOrderListManager.m
//  compassionpark
//
//  Created by air on 2017/3/24.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import "BUGetOrderListManager.h"

#import "BUSystem.h"

@implementation  BUOrderMsgList
-(id)init
{
     self = [super init];
     if(self){
          self.deserializationMap = @{@"BUImageRes":@"BUImageRes",@"subStr":@"NSString,subStr"};
     }
     return self;
}


@end


@implementation  BUGoods
-(id)init
{
    self = [super init];
    if(self){
         self.deserializationMap = @{@"BUImageRes":@"BUImageRes",@"goodsImage":@"BUImageRes,goodsImage"};
    }
    return self;
}

-(NSDictionary *)getDic
{
          return @{@"title":_goodsName?:@"",@"source":[NSString stringWithFormat:@"%@",_goodsSpec?:@""],@"time":[NSString stringWithFormat:@"￥%.2f",_salePrice],@"default":@"default",@"img":_goodsImage?:@"orderEx",@"num":[NSString stringWithFormat:@"×%ld",_count]};
}
@end
//
//@implementation BUOrderOper
//-(id)init
//{
//    self = [super init];
//    if(self){
//        self.deserializationMap = @{@"message":@"NSString,msg",@"BUImageRes":@"BUImageRes",@"cardList":@"BUGetUserGiftCard,cardList"};
//    }
//    return self;
//}
//
//-(NSDictionary *)getDicWithGiftCardInfo
//{
//    NSString *num;
//    if (_orderType == 4 || _orderType == 3 ) {
//        num = @"";
//    }else{
//        num = [NSString stringWithFormat:@"×%ld",_num];
//    }
//    return  @{@"img":_imagePath?:[NSNull new],@"title":_name?:@"日式色织水洗棉床笠",@"source":[NSString stringWithFormat:@"￥%.2f",_price],@"time":num,@"default":@"default"};
//}
//@end
//
//
//
@implementation BUGetOrder
-(id)init
{
    self = [super init];
    if(self){
         self.deserializationMap = @{@"BUImageRes":@"BUImageRes",@"goodsList":@"BUGoods,goodsList",@"subStr":@"NSString,subStr"};
    }
    return self;
}
//-(void)getDic
//{
//     BUImageRes *imgPath = _goodsList.firstObject;
//     return @{@"title":_name?:@"",@"img":imgPath?:@"default",@"default":@"default",@"source":[NSString stringWithFormat:@"%ld积分",_integral],@"time":_address?:@"",@"distance":[NSString stringWithFormat:@"%@",_distance?:@"0"]};
//}

-(NSDictionary *)getDicA1
{
     return @{@"title":[NSString stringWithFormat:@"订单编号：%@",_orderNO?:@""],@"detail":[NSString stringWithFormat:@"下单时间：%@",_createTime]};
}
-(NSDictionary *)getDicA
{
//     0 待付款 1 待发货 2 已发货 3 租赁中 34租赁中续费 5 到期归还 6 已完成 7 关闭
//0 待付款 1 待发货 2 已发货 3 租赁中 4租赁中续费 5 到期退还审核 6 已完成 7 关闭 8-评论完成 9-付款超时 10-到期退还
     NSString *title = [NSString stringWithFormat:@"订单编号:%@",_orderNO?:@""];
     NSString *detail = @"";
     BOOL b = NO;
     switch (_state) {
          case 0:
          {
               detail = @"待付款";
//               b = YES;
          }
               break;
          case 1:
               detail = @"待发货";
               break;
          case 2:
               detail = @"已发货";
               break;
          case 3:case 4:
          {
               if(_leaseType == 1)
               {
               detail = @"租赁中";
               }
               else
               {
                    NSInteger d = -[BSUtility numberOfDaysFromTodayByTime:_expireTime timeStringFormat:@"yyyy-MM-dd HH:mm:ss"];
                    if (d <=2) {
detail = @"待续费";
                    }
                    else
                    {
 detail = @"租赁中";
                    }
               }
          }
               break;
          case 5:
               detail = @"退还审核中";
               break;
          case 6:
               detail = @"已完成";
               break;
          case 7:
               detail = @"交易取消";
               break;
          case 8:
               detail = @"已完成";
               break;
          case 9:
               detail = @"交易超时";
               break;
          case 10:
               detail = @"到期退还";
               break;
          default:
               break;
     }
     return @{@"title":title?:@"",@"detail":detail?:@"",@"indexPath":_indexPath?:[NSIndexPath indexPathForRow:0 inSection:0],@"isShowBtn":@(b)};
}

-(NSDictionary *)getDicB:(NSInteger)row
{
//    if (_orderType == 4) {
//        NSString *f = [NSString stringWithFormat:@"￥%.2f",_totalPrice];
//        NSString *p = [NSString stringWithFormat:@"￥%.2f",_price];
//        if (_totalPrice == _price) {
//            f = @"";
//            p = @"";
//        }
//        return @{@"title":_name?:@"日式色织水洗棉床笠",@"source":[NSString stringWithFormat:@"肤色/M"],@"time":[NSString stringWithFormat:@"¥99"],@"default":@"default",@"img":_imagePath?:[NSNull new],@"price":@"22"};
//    }
//    else
//    return @{@"title":_name?:@"",@"source":[NSString stringWithFormat:@"￥%.2f×%ld",_price,_num],@"time":[NSString stringWithFormat:@"共计￥%.2f",_totalPrice],@"default":@"default",@"img":_imagePath?:[NSNull new]};
//     BUGoods *g;// = _goodsList[row];
     NSString *qishu = @"天";

     if (_leaseType == 0) {

          qishu = @"月";
     }
   NSString *tt = [_subStr componentsJoinedByString:@"/"];
     tt = [NSString stringWithFormat:@"%@/%ld%@",tt,_period,qishu];
     return @{@"title":_proName?:_productName?:@"",@"source":[NSString stringWithFormat:@"%@",tt],@"time":[NSString stringWithFormat:@"租金：%.2f元/%@",_leaseMoney,qishu],@"img":_img?:@"default",@"default":@"default",@"num":[NSString stringWithFormat:@"预授押金：￥%.2f",_deposit]};//@{@"title":g.goodsName?:@"",@"source":[NSString stringWithFormat:@"%@",g.goodsSpec?:@""],@"time":[NSString stringWithFormat:@"￥%ld",g.salePrice],@"default":@"default",@"img":g.goodsImage?:@"orderEx",@"num":[NSString stringWithFormat:@"×%ld",g.count]};
}

-(NSDictionary *)getDicC
{
     //      0 待付款 1 待发货 2 已发货 3 租赁中 34租赁中续费 5 到期归还 6 已完成 7 关闭

//0 待付款 1 待发货 2 已发货 3 租赁中 4租赁中续费 5 到期退还审核 6 已完成 7 关闭 8-评论完成 9-付款超时 10-到期退还

     if (_state == 0) {
          NSString *str = [NSString stringWithFormat:@"应付金额:￥%.2f",_payMoney];
          return @{@"title":@"立即付款",@"bTitle":@"取消订单",@"detail":str};
     }
     else if (_state == 2) {
NSString *str = [NSString stringWithFormat:@"合计:￥%.2f",_payMoney];

          return @{@"title":@"确认收货",@"detail":str};
     }
     else if (_state == 5) {
          NSString *str = [NSString stringWithFormat:@"合计:￥%.2f",_payMoney];
          return @{@"title":@"",@"detail":str};
     }
     else if (_state == 1) {
NSString *str = [NSString stringWithFormat:@"合计:￥%.2f",_payMoney];
          return @{@"title":@"",@"detail":str};
     }
     else if (_state == 3 ||_state == 4) {
          if(_leaseType == 1)//短租
          {
         NSString *str = [NSString stringWithFormat:@"合计:￥%.2f",_payMoney];
      return @{@"title":@"",@"detail":str};
          }
          else
          {
               //判断是否到期要缴费租金
               NSInteger d = -[BSUtility numberOfDaysFromTodayByTime:_expireTime timeStringFormat:@"yyyy-MM-dd HH:mm:ss"];
               if (d <=2) {
                    NSString *str = [NSString stringWithFormat:@"合计:￥%.2f",_payMoney];
                    return @{@"title":@"续缴租金",@"detail":str,@"titleX":@YES};
               }
               else
               {
                    NSString *str = [NSString stringWithFormat:@"合计:￥%.2f",_payMoney];
                    return @{@"title":@"续缴租金",@"detail":str,@"titleX":@NO};
               }

          }
     }
     else   if (_state == 10){
//要判断是否已还清租金
            NSString *str = [NSString stringWithFormat:@"合计:￥%.2f",_payMoney];
          if(_leaseCount > 0)
  return @{@"bTitle":@"续缴租金",@"title":@"退还商品",@"bTitleX":@YES,@"detail":str};
          else
          {
 return @{@"title":@"退还商品",@"detail":str};
          }
     }
     else   if (_state == 6){

  return @{@"bTitle":@"删除订单",@"title":@"评价"};
     }
     else  {

  return @{@"title":@"删除订单",@"detail":@""};
     }

}

-(NSDictionary *)getAfterSellDic:(NSInteger)row;
{
     if (row == 0) {
          NSString *nn = _orderNO;
//          if (!nn) {
//               nn = _serviceNo;
//          }
          NSString *tt = _createTime;
//          if (!tt) {
//               tt = _orderTime;
//          }
          tt = [tt substringWithRange:NSMakeRange(0, MIN(10, tt.length))];
          NSString *ts = @"下单时间：";
          if(__SCREEN_SIZE.width == 320)
          {
               ts = @"";
          }
          return @{@"title":[NSString stringWithFormat:@"订单编号：%@",nn],@"detail":[NSString stringWithFormat:@"%@%@",ts,tt]};
     }
     else
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
}
//-(NSDictionary *)getRunDic:(NSInteger)row
//{
//     if (row == 0) {
//          return @{@"title":[NSString stringWithFormat:@"订单编号:%@",_orderNo],@"detail":@"查看订单详情"};
//     }
//     else if (row == 1)
//     {
//          return @{@"title":[NSString stringWithFormat:@"收货人:%@",_contacts?:@""]};
//     }
//     else if (row == 2)
//     {
//          return @{@"title":[NSString stringWithFormat:@"收货地址:%@",_address?:@""]};
//     }
//     else if (row == 3)
//     {
//          return @{@"title":[NSString stringWithFormat:@"联系电话:%@",_telephone?:@""]};
//     }
//     else if (row == 4)
//     {
//          return @{@"title":[NSString stringWithFormat:@"下单时间:%@",_orderTime?:@""]};
//     }
//     else
//     {
//          if (!_hasRecv) {
//                 return @{@"title":@"马上接单"};
//          }
//          else
//          return @{@"title":@"确认送达"};
//     }
//}

@end

@implementation BUGetOrderListManager
-(BOOL)getOrderListNextPage:(id)observer callback:(SEL)callback
{
    return [self getOrderListNextPage:observer callback:callback extraInfo:nil];
}


-(BOOL)getOrderListNextPage:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo
{
    BUPageInfo *pageinfo = [[BUPageInfo alloc] init];
    self.pageInfo.page ++;
    pageinfo.page = self.pageInfo.page;
    pageinfo.type = self.pageInfo.type?:@"";
     pageinfo.uid = self.pageInfo.uid?:@"";
    pageinfo.state = self.pageInfo.state?:@"";
    pageinfo.keywords = self.pageInfo.keywords?:@"";
//    pageinfo.startDate = self.pageInfo.startDate?:@"";
//    pageinfo.endDate = self.pageInfo.endDate?:@"";
//    pageinfo.orderType = self.pageInfo.orderType?:@"";
    pageinfo.state = self.pageInfo.state?:@"";
    //    pageinfo.userInfo = _pageInfo.userInfo;
    return [self getDataList:pageinfo observer:observer callback:callback extraInfo:extraInfo];
}
-(BOOL)getOrderList:(NSString*)userId withOrderStatus:(NSString*)orderStatus  observer:(id)observer callback:(SEL)callback
{
     return   [self getOrderList:userId withOrderStatus:orderStatus  observer:observer callback:callback extraInfo:nil ];
}

-(BOOL)getOrderList:(NSString*)userId withOrderStatus:(NSString*)orderStatus observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo
{
     return [self getData:@{@"userId":userId?:@"",@"orderStatus":orderStatus?:@"",@"courierId":@""} observer:observer callback:callback extraInfo:extraInfo];
}

-(BOOL)getData:(NSDictionary *)dic  observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo
{
    
    self.pageInfo = nil;
    BUPageInfo *pageinfo = [[BUPageInfo alloc] init];
    pageinfo.uid = dic[@"userId"];
    pageinfo.state = dic[@"orderStatus"];
   pageinfo.keywords =  dic[@"courierId"];
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
   NSString *courierId = pageinfo.keywords;
    NSString *orderStatus = pageinfo.state?:@"";
     NSInvocation *input = BSGetInvocationFromSel(self, @selector(getDataListInput:withPagesize:withPageindex:withOrderStatus:withCourierId:));
    [input setArgument:&userId atIndex:2];
    [input setArgument:&pageSize atIndex:3];
    [input setArgument:&pageIndex atIndex:4];
    [input setArgument:&orderStatus atIndex:5];
      [input setArgument:&courierId atIndex:6];
    [input retainArguments];
    return [self sendRequest:[NSString stringWithFormat:@"%@%@%@",BU_BUSINESS_DOMAIN_MYPATH,BU_BUSINESS_GetOrderList,@""]
                        head:nil
                      method:@"POST"
                       async:YES
             inputInvocation:input
            outputInvocation:BSGetInvocationFromSel(self, @selector(getDataListOutput:ok:input:))
                    observer:observer
                      action:callback
                   extraInfo:extraInfo];
}

-(NSData *)getDataListInput:(NSString*) userId withPagesize:(NSString*) pageSize withPageindex:(NSString*) pageIndex withOrderStatus:(NSString*)orderStatus withCourierId:(NSString*)courierId
{
    NSString *request = [NSString stringWithFormat:@"userId=%@&pageSize=%@&pageIndex=%@&state=%@&%@",userId,pageSize,pageIndex,orderStatus,[self getBaseUrlParem]];
    return [request dataUsingEncoding:NSUTF8StringEncoding];
    
}

-(NSError *)getDataListOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input
{
    UNPACKETOUTPUTHEAD(recvData, ok);
    BUGetOrderListManager *msgManager = [[BUGetOrderListManager alloc] init];
    msgManager.pageInfo = [[BUPageInfo alloc] init];
    [(BSJSON *)jsonObj deserializationSpecifityMap:msgManager map:@{@"data":@"BUGetOrder,dataArr"}];
    //    [RequestStatus setRequestResultStatus:jsonObj];
    
    if (self.pageInfo == nil||self.pageInfo.page == 1 || msgManager.pageInfo.page == 1) {
        self.dataArr = msgManager.dataArr;
        //        msgManager.pageInfo.type = self.pageInfo.type;
        msgManager.pageInfo.keywords = self.pageInfo.keywords?:@"";
        msgManager.pageInfo.startDate = self.pageInfo.startDate?:@"";
        msgManager.pageInfo.endDate = self.pageInfo.endDate?:@"";
        msgManager.pageInfo.orderType = self.pageInfo.orderType?:@"";
        msgManager.pageInfo.state = self.pageInfo.state?:@"";
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

-(BOOL)getOrderDetail:(NSString*) aid observer:(id)observer callback:(SEL)callback {
    return [self getOrderDetail:aid observer:observer callback:callback extraInfo:nil];
}

-(BOOL)getOrderDetail:(NSString*) aid observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo
{
//    NSString *token = busiSystem.agent.token?:@"";
    NSInvocation *input = BSGetInvocationFromSel(self, @selector(getOrderDetailInput:));
    [input setArgument:&aid atIndex:2];
//    [input setArgument:&token atIndex:3];
    [input retainArguments];
    return [self sendRequest:[NSString stringWithFormat:@"%@%@",BU_BUSINESS_DOMAIN_MYPATH,BU_BUSINESS_GetOrderInfo]
                        head:nil
                      method:@"POST"
                       async:YES
             inputInvocation:input
            outputInvocation:BSGetInvocationFromSel(self, @selector(getOrderDetailOutput:ok:input:))
                    observer:observer
                      action:callback
                   extraInfo:extraInfo];
    
}


-(NSData *)getOrderDetailInput:(NSString*) sid
{
     NSString *request = [NSString stringWithFormat:@"orderID=%@&userId=%@&%@",sid,busiSystem.agent.userId?:@"",[self getBaseUrlParem]];
    return [request dataUsingEncoding:NSUTF8StringEncoding];
    
}

-(NSError *)getOrderDetailOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input

{
    UNPACKETOUTPUTHEAD(recvData, ok);
    _orderDetail = nil;
     [(BSJSON *)jsonObj deserializationSpecifityMap:self map:@{@"data":@"BUOrderDetail,orderDetail"}];
    return SuccessedError;
    
}

-(BOOL)orderAdd:(NSString*) presetTime withAddrid:(NSString*) addrId withCourierid:(NSString*) courierId withRecyclingtype:(NSString*) recyclingType withWeight:(NSString*) weight withUserid:(NSString*) userId withGoodslist:(NSArray*) goodsList withPaytype:(NSString*) payType withOrdertype:(NSString*) orderType withShopid:(NSString*) shopId withIntegral:(NSString*) integral withExpresstype:(NSString*) expressType withLinkid:(NSString*) linkId withRemark:(NSString*) remark  stationId:(NSString *)stationId  expressFee:(NSString *)expressFee observer:(id)observer callback:(SEL)callback
{
     return [self orderAdd: presetTime withAddrid: addrId withCourierid: courierId withRecyclingtype: recyclingType withWeight: weight withUserid: userId withGoodslist: goodsList withPaytype: payType withOrdertype: orderType withShopid: shopId withIntegral: integral withExpresstype: expressType withLinkid: linkId withRemark: remark stationId:stationId expressFee:expressFee observer:observer callback:callback extraInfo:nil];
}

-(BOOL)orderAdd:(NSString*) presetTime withAddrid:(NSString*) addrId withCourierid:(NSString*) courierId withRecyclingtype:(NSString*) recyclingType withWeight:(NSString*) weight withUserid:(NSString*) userId withGoodslist:(NSArray*) goodsList withPaytype:(NSString*) payType withOrdertype:(NSString*) orderType withShopid:(NSString*) shopId withIntegral:(NSString*) integral withExpresstype:(NSString*) expressType withLinkid:(NSString*) linkId withRemark:(NSString*) remark stationId:(NSString *)stationId expressFee:(NSString *)expressFee observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo
{
     NSInvocation *input = BSGetInvocationFromSel(self, @selector(orderAddInput: withAddrid: withCourierid: withRecyclingtype: withWeight: withUserid: withGoodslist: withPaytype: withOrdertype: withShopid: withIntegral: withExpresstype: withLinkid: withRemark:stationId: withExpressFee:));
     [input setArgument:&presetTime atIndex:2];
     [input setArgument:&addrId atIndex:3];
     [input setArgument:&courierId atIndex:4];
     [input setArgument:&recyclingType atIndex:5];
     [input setArgument:&weight atIndex:6];
     [input setArgument:&userId atIndex:7];
     [input setArgument:&goodsList atIndex:8];
     [input setArgument:&payType atIndex:9];
     [input setArgument:&orderType atIndex:10];
     [input setArgument:&shopId atIndex:11];
     [input setArgument:&integral atIndex:12];
     [input setArgument:&expressType atIndex:13];
     [input setArgument:&linkId atIndex:14];
     [input setArgument:&remark atIndex:15];
     [input setArgument:&stationId atIndex:16];
     [input setArgument:&expressFee atIndex:17];
     [input retainArguments];
     return [self sendRequest:[NSString stringWithFormat:@"%@%@",BU_BUSINESS_DOMAIN_ORDER,BU_BUSINESS_OrderAdd]
                         head:@{@"Content-Type":@"application/json;charset=UTF-8"}
                       method:@"POST"
                        async:YES
              inputInvocation:input
             outputInvocation:BSGetInvocationFromSel(self, @selector(orderAddOutput:ok:input:))
                     observer:observer
                       action:callback
                    extraInfo:extraInfo];

}


-(NSData *)orderAddInput:(NSString*) presetTime withAddrid:(NSString*) addrId withCourierid:(NSString*) courierId withRecyclingtype:(NSString*) recyclingType withWeight:(NSString*) weight withUserid:(NSString*) userId withGoodslist:(NSArray*) goodsList withPaytype:(NSString*) payType withOrdertype:(NSString*) orderType withShopid:(NSString*) shopId withIntegral:(NSString*) integral withExpresstype:(NSString*) expressType withLinkid:(NSString*) linkId withRemark:(NSString*) remark stationId:(NSString *)stationId withExpressFee:(NSString *)expressFee
{
//     NSString *request = [NSString stringWithFormat:@"presetTime=%@&addrId=%@&courierId=%@&recyclingType=%@&weight=%@&userId=%@&goodsList=%@&payType=%@&orderType=%@&shopId=%@&integral=%@&expressType=%@&linkId=%@&remark=%@",presetTime,addrId,courierId,recyclingType,weight,userId,goodsList,payType,orderType,shopId,integral,expressType,linkId,remark];
     /*
      userId (string, optional): 用户编号 ,
      shopId (string, optional): 店铺编号 ,
      orderType (integer, optional): 订单类别 1-商品，2-服务，3-二手 ,
      linkId (string, optional): 关联编号 除商品外 ,
      goodsList (Array[InOrderGoods], optional): 商品列表 ,
      integral (integer, optional): 积分 ,
      payType (integer, optional): 支付方式 1-支付宝，2-微信，3-积分兑换 ,
      expressType (integer, optional): 快递方式 1-同城快递，2-自取，3-跑腿师傅 ,
      courierId (string, optional): 跑腿师傅编号 ,
      addrId (string, optional): 地址编号 ,
      remark (string, optional): 订单留言 ,
      recyclingType (string, optional): 回收类别 ,
      presetTime (string, optional): 预约时间 ,
      weight (number, optional): 重量 ,
      appId (string, optional): AppId ,
      timeStamp (string, optional): 时间戳 ,
      nonce (string, optional): 六位随机数 ,
      sign (string, optional): 签名 将AppId、TimeStamp、Nonce的值进行升序排序后组成字符串，加上AppSecret的值后进行MD5加密
      }InOrderGoods {
      cartId (string, optional): 购物车编号 除商品外其他为空 ,
      goodsId (string, optional): 商品编号 ,
      count (integer, optional): 商品数量
      }
      */
     //goodList 封装成BSJson
     BSJSON *json = [BSJSON new];
     [json setObject:presetTime forKey:@"presetTime"];
     [json setObject:userId forKey:@"userId"];
     [json setObject:shopId forKey:@"shopId"];
     [json setObject:@([orderType integerValue]) forKey:@"orderType"];
     [json setObject:linkId forKey:@"linkId"];
     [json setObject:goodsList forKey:@"goodsList"];
     [json setObject:@([integral integerValue]) forKey:@"integral"];
     [json setObject:@([payType integerValue]) forKey:@"payType"];
     [json setObject:@([expressType integerValue]) forKey:@"expressType"];
     [json setObject:courierId forKey:@"courierId"];
     [json setObject:addrId forKey:@"addrId"];
     [json setObject:remark forKey:@"remark"];
     [json setObject:addrId forKey:@"addrId"];
     [json setObject:stationId forKey:@"stationId"];
     [json setObject:@([recyclingType integerValue]) forKey:@"recyclingType"];
     [json setObject:@([weight floatValue]) forKey:@"weight"];
     [json setObject:@([expressFee floatValue]) forKey:@"expressFee"];
     NSDictionary *dic = [self getBaseUrlParemDic];
     [json setObject:dic[@"appId"] forKey:@"appId"];
     [json setObject:dic[@"timeStamp"] forKey:@"timeStamp"];
     [json setObject:dic[@"nonce"] forKey:@"nonce"];
     [json setObject:dic[@"sign"] forKey:@"sign"];
     [json setObject:dic[@"token"] forKey:@"token"];
     NSString *request = [json description];
     return [request dataUsingEncoding:NSUTF8StringEncoding];

}

-(NSError *)orderAddOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input

{
     UNPACKETOUTPUTHEAD(recvData, ok);
     _getOrder = nil;
     [(BSJSON *)jsonObj deserializationSpecifityMap:self map:@{@"data":@"BUGetOrder,getOrder"}];
     return SuccessedError;

}

-(BOOL)orderOper:(NSString*) message withOrderid:(NSString*) orderId withPrice:(NSString*) price withOperType:(NSString *)operType observer:(id)observer callback:(SEL)callback
{
    return [self orderOper:message withOrderid:orderId withPrice:price withOperType:operType observer:observer callback:callback extraInfo:nil];
}

-(BOOL)orderOper:(NSString*) message withOrderid:(NSString*) orderId withPrice:(NSString*) price withOperType:(NSString *)operType observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo
{
    NSString *token = busiSystem.agent.token?:@"";
    NSInvocation *input = BSGetInvocationFromSel(self, @selector(orderOperInput: withOrderid: withPrice: withToken:withOperType:));
    [input setArgument:&message atIndex:2];
    [input setArgument:&orderId atIndex:3];
    [input setArgument:&price atIndex:4];
    [input setArgument:&token atIndex:5];
     [input setArgument:&operType atIndex:6];
    [input retainArguments];
    return [self sendRequest:[NSString stringWithFormat:@"%@%@",BU_BUSINESS_DOMAIN_MYPATH,BU_BUSINESS_OrderOper]
                        head:nil
                      method:@"POST"
                       async:YES
             inputInvocation:input
            outputInvocation:BSGetInvocationFromSel(self, @selector(orderOperOutput:ok:input:))
                    observer:observer
                      action:callback
                   extraInfo:extraInfo];
    
}


-(NSData *)orderOperInput:(NSString*) message withOrderid:(NSString*) orderId withPrice:(NSString*) price withToken:(NSString*) token withOperType:(NSString *)operType
{
    NSString *request = [NSString stringWithFormat:@"message=%@&orderId=%@&price=%@&token=%@&operType=%@",message,orderId,price,token,operType];
    return [request dataUsingEncoding:NSUTF8StringEncoding];
    
}

-(NSError *)orderOperOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input

{
    UNPACKETOUTPUTHEAD(recvData, ok);
//    _orderOper = nil;
    [(BSJSON *)jsonObj deserializationSpecifityMap:self map:@{@"data":@"BUOrderOper,orderOper"}];
    return SuccessedError;
    
}

-(BOOL)orderDel:(NSString*) sid withUserid:(NSString*) userId observer:(id)observer callback:(SEL)callback
{
     return [self orderDel: sid withUserid: userId observer:observer callback:callback extraInfo:nil];
}

-(BOOL)orderDel:(NSString*) sid withUserid:(NSString*) userId observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo
{
     NSInvocation *input = BSGetInvocationFromSel(self, @selector(orderDelInput: withUserid:));
     [input setArgument:&sid atIndex:2];
     [input setArgument:&userId atIndex:3];
     [input retainArguments];
     return [self sendRequest:[NSString stringWithFormat:@"%@%@",BU_BUSINESS_DOMAIN_ORDER,BU_BUSINESS_OrderDel]
                         head:nil
                       method:@"POST"
                        async:YES
              inputInvocation:input
             outputInvocation:BSGetInvocationFromSel(self, @selector(orderDelOutput:ok:input:))
                     observer:observer
                       action:callback
                    extraInfo:extraInfo];

}


-(NSData *)orderDelInput:(NSString*) sid withUserid:(NSString*) userId
{
     NSString *request = [NSString stringWithFormat:@"id=%@&userId=%@&%@",sid,userId,[self getBaseUrlParem]];
     return [request dataUsingEncoding:NSUTF8StringEncoding];

}

-(NSError *)orderDelOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input

{
     UNPACKETOUTPUTHEAD(recvData, ok);

     return SuccessedError;

}

-(BOOL)orderPay:(NSString*) payType withOrderid:(NSString*) orderId withUserid:(NSString*) userId observer:(id)observer callback:(SEL)callback
{
     return [self orderPay: payType withOrderid: orderId withUserid: userId observer:observer callback:callback extraInfo:nil];
}

-(BOOL)orderPay:(NSString*) payType withOrderid:(NSString*) orderId withUserid:(NSString*) userId observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo
{
     NSInvocation *input = BSGetInvocationFromSel(self, @selector(orderPayInput: withOrderid: withUserid:));
     [input setArgument:&payType atIndex:2];
     [input setArgument:&orderId atIndex:3];
     [input setArgument:&userId atIndex:4];
     [input retainArguments];
     return [self sendRequest:[NSString stringWithFormat:@"%@%@",BU_BUSINESS_DOMAIN_ORDER,BU_BUSINESS_OrderPay]
                         head:nil
                       method:@"POST"
                        async:YES
              inputInvocation:input
             outputInvocation:BSGetInvocationFromSel(self, @selector(orderPayOutput:ok:input:))
                     observer:observer
                       action:callback
                    extraInfo:extraInfo];

}


-(NSData *)orderPayInput:(NSString*) payType withOrderid:(NSString*) orderId withUserid:(NSString*) userId
{
     NSString *request = [NSString stringWithFormat:@"payType=%@&orderId=%@&userId=%@&%@",payType,orderId,userId,[self getBaseUrlParem]];
     return [request dataUsingEncoding:NSUTF8StringEncoding];

}

-(NSError *)orderPayOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input

{
     UNPACKETOUTPUTHEAD(recvData, ok);

     return SuccessedError;

}

-(BOOL)orderCancel:(NSString*) sid withUserid:(NSString*) userId observer:(id)observer callback:(SEL)callback
{
     return [self orderCancel: sid withUserid: userId observer:observer callback:callback extraInfo:nil];
}

-(BOOL)orderCancel:(NSString*) sid withUserid:(NSString*) userId observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo
{
     NSInvocation *input = BSGetInvocationFromSel(self, @selector(orderCancelInput: withUserid:));
     [input setArgument:&sid atIndex:2];
     [input setArgument:&userId atIndex:3];
     [input retainArguments];
     return [self sendRequest:[NSString stringWithFormat:@"%@%@",BU_BUSINESS_DOMAIN_ORDER,BU_BUSINESS_OrderCancel]
                         head:nil
                       method:@"POST"
                        async:YES
              inputInvocation:input
             outputInvocation:BSGetInvocationFromSel(self, @selector(orderCancelOutput:ok:input:))
                     observer:observer
                       action:callback
                    extraInfo:extraInfo];

}


-(NSData *)orderCancelInput:(NSString*) sid withUserid:(NSString*) userId
{
     NSString *request = [NSString stringWithFormat:@"id=%@&userId=%@&%@",sid,userId,[self getBaseUrlParem]];
     return [request dataUsingEncoding:NSUTF8StringEncoding];

}

-(NSError *)orderCancelOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input

{
     UNPACKETOUTPUTHEAD(recvData, ok);

     return SuccessedError;

}


-(BOOL)orderFinish:(NSString*) sid withUserid:(NSString*) userId observer:(id)observer callback:(SEL)callback
{
     return [self orderFinish: sid withUserid: userId observer:observer callback:callback extraInfo:nil];
}

-(BOOL)orderFinish:(NSString*) sid withUserid:(NSString*) userId observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo
{
     NSInvocation *input = BSGetInvocationFromSel(self, @selector(orderFinishInput: withUserid:));
     [input setArgument:&sid atIndex:2];
     [input setArgument:&userId atIndex:3];
     [input retainArguments];
     return [self sendRequest:[NSString stringWithFormat:@"%@%@",BU_BUSINESS_DOMAIN_ORDER,BU_BUSINESS_OrderFinish]
                         head:nil
                       method:@"POST"
                        async:YES
              inputInvocation:input
             outputInvocation:BSGetInvocationFromSel(self, @selector(orderFinishOutput:ok:input:))
                     observer:observer
                       action:callback
                    extraInfo:extraInfo];

}


-(NSData *)orderFinishInput:(NSString*) sid withUserid:(NSString*) userId
{
     NSString *request = [NSString stringWithFormat:@"id=%@&userId=%@&%@",sid,userId,[self getBaseUrlParem]];
     return [request dataUsingEncoding:NSUTF8StringEncoding];

}

-(NSError *)orderFinishOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input

{
     UNPACKETOUTPUTHEAD(recvData, ok);

     return SuccessedError;

}

-(BOOL)orderConfirmbyCourier:(NSString*) orderId withCourierid:(NSString*) courierId observer:(id)observer callback:(SEL)callback
{
     return [self orderConfirmbyCourier: orderId withCourierid: courierId observer:observer callback:callback extraInfo:nil];
}

-(BOOL)orderConfirmbyCourier:(NSString*) orderId withCourierid:(NSString*) courierId observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo
{
     NSInvocation *input = BSGetInvocationFromSel(self, @selector(orderConfirmbyCourierInput: withCourierid:));
     [input setArgument:&orderId atIndex:2];
     [input setArgument:&courierId atIndex:3];
     [input retainArguments];
     return [self sendRequest:[NSString stringWithFormat:@"%@%@",BU_BUSINESS_DOMAIN_ORDER,BU_BUSINESS_OrderConfirmbyCourier]
                         head:nil
                       method:@"POST"
                        async:YES
              inputInvocation:input
             outputInvocation:BSGetInvocationFromSel(self, @selector(orderConfirmbyCourierOutput:ok:input:))
                     observer:observer
                       action:callback
                    extraInfo:extraInfo];

}


-(NSData *)orderConfirmbyCourierInput:(NSString*) orderId withCourierid:(NSString*) courierId
{
     NSString *request = [NSString stringWithFormat:@"orderId=%@&courierId=%@&%@",orderId,courierId,[self getBaseUrlParem]];
     return [request dataUsingEncoding:NSUTF8StringEncoding];

}

-(NSError *)orderConfirmbyCourierOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input

{
     UNPACKETOUTPUTHEAD(recvData, ok);

     return SuccessedError;

}


-(BOOL)orderConfirm:(NSString*) sid withUserid:(NSString*) userId observer:(id)observer callback:(SEL)callback
{
     return [self orderConfirm: sid withUserid: userId observer:observer callback:callback extraInfo:nil];
}

-(BOOL)orderConfirm:(NSString*) sid withUserid:(NSString*) userId observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo
{
     NSInvocation *input = BSGetInvocationFromSel(self, @selector(orderConfirmInput: withUserid:));
     [input setArgument:&sid atIndex:2];
     [input setArgument:&userId atIndex:3];
     [input retainArguments];
     return [self sendRequest:[NSString stringWithFormat:@"%@%@",BU_BUSINESS_DOMAIN_ORDER,BU_BUSINESS_OrderConfirm]
                         head:nil
                       method:@"POST"
                        async:YES
              inputInvocation:input
             outputInvocation:BSGetInvocationFromSel(self, @selector(orderConfirmOutput:ok:input:))
                     observer:observer
                       action:callback
                    extraInfo:extraInfo];

}


-(NSData *)orderConfirmInput:(NSString*) sid withUserid:(NSString*) userId
{
     NSString *request = [NSString stringWithFormat:@"id=%@&userId=%@&%@",sid,userId,[self getBaseUrlParem]];
     return [request dataUsingEncoding:NSUTF8StringEncoding];

}

-(NSError *)orderConfirmOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input

{
     UNPACKETOUTPUTHEAD(recvData, ok);

     return SuccessedError;

}



-(BOOL)getExpressInfo:(NSString*)cityId longitude:(NSString*) longitude latitude:(NSString*) latitude shopId:(NSString*) shopId   observer:(id)observer callback:(SEL)callback
{
     return [self getExpressInfo: cityId longitude:(NSString*) longitude latitude:(NSString*) latitude shopId:(NSString*) shopId observer:observer callback:callback extraInfo:nil];
}

-(BOOL)getExpressInfo:(NSString*)cityId longitude:(NSString*) longitude latitude:(NSString*) latitude shopId:(NSString*) shopId observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo
{
     NSInvocation *input = BSGetInvocationFromSel(self, @selector(getExpressInfoInput:longitude:latitude:shopId:));
     [input setArgument:&cityId atIndex:2];
     [input setArgument:&longitude atIndex:3];
     [input setArgument:&latitude atIndex:4];
     [input setArgument:&shopId atIndex:5];
     [input retainArguments];
     return [self sendRequest:[NSString stringWithFormat:@"%@%@",BU_BUSINESS_DOMAIN_ORDER,BU_BUSINESS_GetExpressInfo]
                         head:nil
                       method:@"POST"
                        async:YES
              inputInvocation:input
             outputInvocation:BSGetInvocationFromSel(self, @selector(getExpressInfoOutput:ok:input:))
                     observer:observer
                       action:callback
                    extraInfo:extraInfo];
     
}


-(NSData *)getExpressInfoInput:(NSString*)cityId longitude:(NSString*) longitude latitude:(NSString*) latitude shopId:(NSString*) shopId
{
     NSString *request = [NSString stringWithFormat:@"cityId=%@&longitude=%@&latitude=%@&shopId=%@&%@",cityId,longitude,latitude,shopId,[self getBaseUrlParem]];
     return [request dataUsingEncoding:NSUTF8StringEncoding];
     
}

-(NSError *)getExpressInfoOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input

{
     UNPACKETOUTPUTHEAD(recvData, ok);
//     _expressFee = nil;
     [(BSJSON *)jsonObj deserializationSpecifityMap:self map:@{@"data":@"BUExpressFee,expressFee"}];
     return SuccessedError;
     
}

@end
