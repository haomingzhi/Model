//
//  BUGetMyCouponManager.m
//  rentingshop
//
//  Created by air on 2018/3/30.
//  Copyright © 2018年 ORANLLC_IOS1. All rights reserved.
//

#import "BUGetMyCouponManager.h"
#import "BUSystem.h"

@implementation BUGetMyCoupon
-(NSDictionary *)getDic:(NSInteger)index
{
     NSString *st = @"全场通用";
     if (_scope == 1) {
          st = @"指定商品";
     }
     else  if (_scope == 2)
     {
          st = @"指定分类";
     }
     NSString *sy = @"注册赠券";
     if (_type == 1) {
          sy = @"购物赠券";
     }
     else if (_type == 2)
     {
           sy = @"全场赠券";
     }
     else if (_type == 3)
     {
           sy = @"签到赠券";
     }
     NSString *yy = @"无限制";
     if (_threshold > 0) {
         yy = [NSString stringWithFormat:@"满%ld元可用",_threshold];
     }
     if (index == 0) {

          return @{@"aTitle":[NSString stringWithFormat:@"¥%ld",_price],@"bTitle":yy,@"cTitle":_title?:@"",@"dTitle":[NSString stringWithFormat:@"适用商品：%@",_scopeName?:@""],@"eTitle":[NSString stringWithFormat:@"有效期至：%@",_effectime?:@""],@"bgImg":@"coupon_bg"};
//          return @{@"aTitle":@"¥60",@"bTitle":[NSString stringWithFormat:@"满100元可用"],@"cTitle":[NSString stringWithFormat:@"全品类通用券"],@"dTitle":@"适用平台：全平台",@"eTitle":@"有效期至：2017-08-01",@"bgImg":@"coupon_bg"};
     }
     else if (index == 1)
     {
          return @{@"aTitle":[NSString stringWithFormat:@"¥%ld",_price],@"bTitle":yy,@"cTitle":_title?:@"",@"dTitle":[NSString stringWithFormat:@"适用商品：%@",_scopeName?:@""],@"eTitle":[NSString stringWithFormat:@"有效期至：%@",_effectime?:@""],@"bgImg":@"coupon_bg2",@"markImg":@"couponUsed"};
//          return @{@"aTitle":@"¥60",@"bTitle":[NSString stringWithFormat:@"满100元可用"],@"cTitle":[NSString stringWithFormat:@"全品类通用券"],@"dTitle":@"适用平台：全平台",@"eTitle":@"有效期至：2017-08-01",@"bgImg":@"coupon_bg2",@"markImg":@"couponUsed"};
     }
     else if(index == 2)
     {
             return @{@"aTitle":[NSString stringWithFormat:@"¥%ld",_price],@"bTitle":yy,@"cTitle":_title?:@"",@"dTitle":[NSString stringWithFormat:@"适用商品：%@",_scopeName?:@""],@"eTitle":[NSString stringWithFormat:@"有效期至：%@",_effectime?:@""],@"bgImg":@"coupon_bg2",@"markImg":@"couponPassed"};
//          return @{@"aTitle":@"¥60",@"bTitle":[NSString stringWithFormat:@"满100元可用"],@"cTitle":[NSString stringWithFormat:@"全品类通用券"],@"dTitle":@"适用平台：全平台",@"eTitle":@"有效期至：2017-08-01",@"bgImg":@"coupon_bg2",@"markImg":@"couponPassed"};
     }
     else
     {
          return @{@"aTitle":[NSString stringWithFormat:@"¥%ld",_price],@"bTitle":yy,@"cTitle":_title?:@"",@"dTitle":[NSString stringWithFormat:@"适用商品：%@",_scopeName?:@""],@"eTitle":[NSString stringWithFormat:@"有效期至：%@",_effectime?:@""],@"bgImg":@"coupon_bg",@"btn":@"领取",@"row":_indexPath?:[NSNull new]};
//        return   @{@"aTitle":@"¥60",@"bTitle":[NSString stringWithFormat:@"满100元可用"],@"cTitle":[NSString stringWithFormat:@"全品类通用券"],@"dTitle":@"适用平台：全平台",@"eTitle":@"有效期至：2017-08-01",@"bgImg":@"coupon_bg",@"btn":@"领取"}
     }
}
@end

@implementation BUGetMyCouponManager

-(BOOL)getMyCouponNextPage:(id)observer callback:(SEL)callback
{
     return [self getMyCouponNextPage:observer callback:callback extraInfo:nil];
}


-(BOOL)getMyCouponNextPage:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo
{
     BUPageInfo *pageinfo = [[BUPageInfo alloc] init];
     self.pageInfo.page ++;
     pageinfo.page = self.pageInfo.page;
     pageinfo.type = self.pageInfo.type;
     pageinfo.keywords = self.pageInfo.keywords;

     //    pageinfo.userInfo = _pageInfo.userInfo;
     return [self getDataList:pageinfo observer:observer callback:callback extraInfo:extraInfo];
}
-(BOOL)getMyCoupon:(id)observer callback:(SEL)callback
{
     return   [self getMyCoupon:observer callback:callback extraInfo:nil];
}

-(BOOL)getMyCoupon:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo
{
 return   [self getMyCoupon: _typeCou observer:observer callback:callback extraInfo:extraInfo];
}
-(BOOL)getMyCoupon:(NSString*)type observer:(id)observer callback:(SEL)callback
{
     return   [self getMyCoupon: type observer:observer callback:callback extraInfo:nil];
}

-(BOOL)getMyCoupon:(NSString*)type observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo
{
     return [self getData:@{@"typeMsg":type?:@""} observer:observer callback:callback extraInfo:extraInfo];
}


-(BOOL)getData:(NSDictionary *)dic  observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo
{

     self.pageInfo = nil;
     BUPageInfo *pageinfo = [[BUPageInfo alloc] init];

     pageinfo.page = 1;
         pageinfo.type = dic[@"typeMsg"];
     return [self getDataList:pageinfo observer:observer callback:callback extraInfo:extraInfo];

}


-(BOOL)getDataList:(BUPageInfo *)pageinfo  observer:(id) observer callback:(SEL) callback  extraInfo:(NSDictionary*)extraInfo
{


     if (!self.pageInfo) {
          self.pageInfo = pageinfo;
     }
     NSString *page = [NSString stringWithFormat:@"%ld",pageinfo.page];
     NSString *type = pageinfo.type;//[NSString stringWithFormat:@"%ld",pageinfo.type];
     NSInvocation *input = BSGetInvocationFromSel(self, @selector(getDataListInput:withType:));
     [input setArgument:&page atIndex:2];
 [input setArgument:&type atIndex:3];
     [input retainArguments];
     return [self sendRequest:[NSString stringWithFormat:@"%@%@%@",BU_BUSINESS_DOMAIN_MYPATH,BU_BUSINESS_GetMyCoupon,@""]
                         head:nil
                       method:@"POST"
                        async:YES
              inputInvocation:input
             outputInvocation:BSGetInvocationFromSel(self, @selector(getDataListOutput:ok:input:))
                     observer:observer
                       action:callback
                    extraInfo:extraInfo];
}

-(NSData *) getDataListInput:(NSString *)page withType:(NSString*)type
{

     return [[NSString stringWithFormat:@"token=%@&pageIndex=%@&userId=%@&pageSize=%@&typeMsg=%@",busiSystem.agent.token?:@"",page,busiSystem.agent.userId,@"20",type] dataUsingEncoding:NSUTF8StringEncoding];
}

-(NSError *)getDataListOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input
{
     UNPACKETOUTPUTHEAD(recvData, ok);
     BUGetMyCouponManager *msgManager = [[BUGetMyCouponManager alloc] init];
     msgManager.pageInfo = [[BUPageInfo alloc] init];
     [(BSJSON *)jsonObj deserializationSpecifityMap:msgManager map:@{@"data":@"BUGetMyCoupon,getMyCouponArr"}];
     //    [RequestStatus setRequestResultStatus:jsonObj];

     if (self.pageInfo == nil||self.pageInfo.page == 1 || msgManager.pageInfo.page == 1) {
     self.getMyCouponArr = msgManager.getMyCouponArr;
          //        msgManager.pageInfo.type = self.pageInfo.type;
          msgManager.pageInfo.keywords = self.pageInfo.keywords;
          //        msgManager.pageInfo.lat = self.pageInfo.lat;
          //        msgManager.pageInfo.lng = self.pageInfo.lng;
          self.pageInfo = msgManager.pageInfo;
          self.pageInfo.page = 1;
          self.pageInfo.pageall  = [[jsonObj objectForKey:@"total"] integerValue];
     }
     else
     {
          NSMutableArray * plist = [[NSMutableArray alloc] init];
          if (self.pageInfo.page != msgManager.pageInfo.page) {
               [plist addObjectsFromArray:self.getMyCouponArr];
               self.pageInfo.pageall  = [[jsonObj objectForKey:@"total"] integerValue];
          }
          [plist addObjectsFromArray:msgManager.getMyCouponArr];
          self.getMyCouponArr = plist;
     }

     //    [self setRequestStatus:jsonObj];

     //    _shopInfos = nil;


     return SuccessedError;
}
@end
