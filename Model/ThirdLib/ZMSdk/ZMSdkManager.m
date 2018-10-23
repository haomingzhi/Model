//
//  ZMSdkManager.m
//  rentingshop
//
//  Created by air on 2018/4/9.
//  Copyright © 2018年 ORANLLC_IOS1. All rights reserved.
//

#import "ZMSdkManager.h"

@implementation ZMSdkManager

+(instancetype)manager
{

     static dispatch_once_t  onceToken;
     static ZMSdkManager * sSharedInstance;

     dispatch_once(&onceToken, ^{
          sSharedInstance = [[ZMSdkManager alloc] init];
     });
     return sSharedInstance;
}

-(void)doVerify:(NSString* )url {
     // 这里使用固定appid 20000067

     NSString *alipayUrl = [NSString stringWithFormat:@"alipays://platformapi/startapp?appId=20000067&url=%@",
                            [self URLEncodedStringWithUrl:url]];
     if ([self canOpenAlipay]) {
          [[UIApplication sharedApplication] openURL:[NSURL URLWithString:alipayUrl] options:@{} completionHandler:nil];
     } else {
          //引导安装支付宝 根据需求这里也可以跳转到一个VC界面进行网页认证
          UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:@"是否下载并安装支付宝完成认证?"
                                                             delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"好的", nil];
          [alertView show];
          //网页认证
          //（传入认证 URL）
//          BBDCZMCreditViewController *zmCreditVC = [[BBDCZMCreditViewController alloc] init];
//          zmCreditVC.zmUrl = url;
//          [self.navigationController pushViewController:zmCreditVC animated:YES];



     }
}

- (NSString *)URLEncodedStringWithUrl:(NSString *)url {
     NSString *encodedString = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL,(CFStringRef)url,NULL,(CFStringRef) @"!'();:@&=+$,%#[]|",kCFStringEncodingUTF8));
     return encodedString;
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
     if (buttonIndex == 1) {
          NSString *appstoreUrl = @"itms-apps://itunes.apple.com/app/id333206289";
          [[UIApplication sharedApplication] openURL:[NSURL URLWithString:appstoreUrl] options:@{} completionHandler:nil];
     }
}

- (BOOL)canOpenAlipay {
     return [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"alipay://"]];
}

@end
