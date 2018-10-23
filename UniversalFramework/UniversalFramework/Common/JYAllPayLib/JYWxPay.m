//
//  JYWxPay.m
//  TestPayApp
//
//  Created by air on 15/6/10.
//  Copyright (c) 2015年 air. All rights reserved.
//

#import "JYWxPay.h"
#import "WXApi.h"
#import "WXApiObject.h"
#import "WXUtil.h"
#import "ApiXml.h"


@interface JYWxPay()<WXApiDelegate>
{
    void (^_completionBlock)(NSDictionary *);
    
}
@end

@implementation JYWxPay


+ (instancetype )manager
{
    static dispatch_once_t  onceToken;
    static JYWxPay * sSharedInstance;
    
    dispatch_once(&onceToken, ^{
        sSharedInstance = [[JYWxPay alloc] init];
        //        sSharedInstance->_dataDic = [NSMutableDictionary dictionary];
      
    });
    return sSharedInstance;
}

-(void)payOrder:(NSDictionary *)payInfo callback:(void (^)(NSDictionary *))completionBlock
{
    if (![WXApi isWXAppInstalled])
    {
//        [BSUtility showDialog:@"未安装微信，请先安装微信"];
          [self alert:@"提示信息" msg:@"未安装微信，请先安装微信"];
        return;
    }

    if ( payInfo != nil) {
        NSDictionary *dict  = payInfo;
//        NSLog(@"url:%@",urlString);
        if(dict != nil){
            NSMutableString *retcode = [dict objectForKey:@"retcode"];
            if (retcode.intValue == 0){
                NSMutableString *stamp  = [dict objectForKey:@"timestamp"];
                
                //调起微信支付
                PayReq* req             = [[PayReq alloc] init];
                req.openID              = [dict objectForKey:@"appid"];
                req.partnerId           = [dict objectForKey:@"partnerid"];
                req.prepayId            = [dict objectForKey:@"prepayid"];
                req.nonceStr            = [dict objectForKey:@"noncestr"];
                req.timeStamp           = stamp.intValue;
                req.package             = [dict objectForKey:@"package"];
                req.sign                = [dict objectForKey:@"sign"];
                [WXApi sendReq:req];
//                [WXApi sendAuthReq:req viewController:dict[@"mainViewController"] delegate:self];
                _completionBlock = completionBlock;
                //日志输出
                NSLog(@"appid=%@\npartid=%@\nprepayid=%@\nnoncestr=%@\ntimestamp=%ld\npackage=%@\nsign=%@",req.openID,req.partnerId,req.prepayId,req.nonceStr,(long)req.timeStamp,req.package,req.sign );
            }else{
                [self alert:@"提示信息" msg:[dict objectForKey:@"retmsg"]];
            }
        }else{
            [self alert:@"提示信息" msg:@"服务器返回错误，未获取到json对象"];
        }
    }else{
        [self alert:@"提示信息" msg:@"服务器返回错误"];
    }

}
-(void)registerAppId:(NSString*)appId withDescription:(NSString *)description
{
    NSLog(@"app id xx:%@",appId);
  [WXApi registerApp:appId];
}

-(BOOL)payResult:(NSDictionary *)dataDic
{
    NSLog(@"wx prr%@",dataDic);
    NSURL *url = dataDic[@"url"];
//    NSArray *arr = [[url relativeString] componentsSeparatedByString:@"?"];
//    NSArray *a = [arr[1] componentsSeparatedByString:@"&"];
//   NSArray *r = [a[1] componentsSeparatedByString:@"="];
//    if([r[1] isEqualToString:@"-1"])
//    {
//        NSLog(@"程序出错");
////        return YES;
//    }
    
    NSLog(@"ssurl%@",url);
    return   [WXApi handleOpenURL:url delegate:self];
}

//-(void) onReq:(BaseReq*)req
//{
//   
//}

/*! @brief 发送一个sendReq后，收到微信的回应
 *
 * 收到一个来自微信的处理结果。调用一次sendReq后会收到onResp。
 * 可能收到的处理结果有SendMessageToWXResp、SendAuthResp等。
 * @param resp具体的回应内容，是自动释放的
 */
-(void) onResp:(BaseResp*)resp
{
    NSLog(@"xx bb %@,ff %@,jj %@",@(resp.errCode),resp.errStr?:@"",@(resp.type));
    _completionBlock(@{@"errCode":@(resp.errCode),@"errStr":resp.errStr?:@"",@"type":@(resp.type)});
}

//客户端提示信息
- (void)alert:(NSString *)title msg:(NSString *)msg
{
    UIAlertView *alter = [[UIAlertView alloc] initWithTitle:title message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
    [alter show];
}
@end
