//
//  UMWarp.h
//  UniversalFramework
//
//  Created by ORANLLC_IOS1 on 15/8/5.
//  Copyright (c) 2015年 ORANLLC_IOS1. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum : NSUInteger {
    PlatformWeChat,
    PlatformTencent,
    PlatformQQ,
    PlatformSina,
    PlatformWeChatFriend
}  PlatformMode;


@interface UMWarp : NSObject


+(void) initWithAppid:(NSString *) appId;
+(void)getUserInfo:(PlatformMode)platformType callBack:(void (^)(NSDictionary *dic)) callback;
+(BOOL) addThirdLogin:(NSString * )snsName param:(NSDictionary *) params;
+(BOOL)hasInstalledQQ;
+(void) login:(UIViewController *)presentingController snsName:(NSString *) snsName  callback:(void (^)(NSString* userid,NSString * userName)) callback;

+(void) share:(UIViewController *)presentingController shareContent:(NSString *) content  image:(NSString *) contentFile withPlatformType:(NSInteger)platformType;

+(void)share:(id) observer title:(NSString *)title content:(NSString *)content image:(NSString *)contentFile whithPlatform:(PlatformMode)mode withUrl:(NSString *)url;

+(BOOL)handleOpenURL:(NSURL *)url;
//判断是否已经安装了微信
+(BOOL) hasInstalledWx;
@end
extern BOOL   UniversalFramework_isUMEnable;//是否启用
