//
//  UMWarp.m
//  UniversalFramework
//
//  Created by ORANLLC_IOS1 on 15/8/5.
//  Copyright (c) 2015年 ORANLLC_IOS1. All rights reserved.
//

#import "UMWarp.h"
//#import "UMSocial.h"
#import "UMSocialQQHandler.h"
#import "UMSocialWechatHandler.h"
#import "WXApi.h"
#import "UMSocialSinaHandler.h"
#import <UMSocialCore/UMSocialCore.h>
#import <UMMobClick/MobClick.h>
BOOL UniversalFramework_isUMEnable;
static NSString* const UMS_Title = @"欢迎使用【友盟+】社会化组件U-Share";
static NSString* const UMS_Text = @"欢迎使用【友盟+】社会化组件U-Share，SDK包最小，集成成本最低，助力您的产品开发、运营与推广！";

static NSString* const UMS_THUMB_IMAGE = @"https://mobile.umeng.com/images/pic/home/social/img-1.png";
static NSString* const UMS_IMAGE = @"https://mobile.umeng.com/images/pic/home/social/img-1.png";

static NSString* const UMS_WebLink = @"http://mobile.umeng.com/social";

static NSString *UMS_SHARE_TBL_CELL = @"UMS_SHARE_TBL_CELL";

@implementation UMWarp
{
    
}

static NSMutableDictionary *snsNameList;
static NSString *umAppid;
+(void) initWithAppid:(NSString *)appId
{
    [[UMSocialManager defaultManager] openLog:YES];
    umAppid = appId;
    [UMSocialGlobal shareInstance].isClearCacheWhenGetUserInfo = NO;
    [[UMSocialManager defaultManager] setUmSocialAppkey:appId];
    
    //    [UMSocialData setAppKey:umAppid];
    UniversalFramework_isUMEnable = NO;
    
    UMConfigInstance.appKey = appId;
    //UMConfigInstance.secret = @"secretstringaldfkals";
    [MobClick startWithConfigure:UMConfigInstance];
    [MobClick setLogEnabled:YES];
    [MobClick setCrashReportEnabled:YES];
}

+(NSInteger)getPlatform:(NSString *)snsName
{
    if ([snsName isEqualToString:@"qq"]) {
        return UMSocialPlatformType_QQ;
    }
    else if ([snsName isEqualToString:@"wxsession"])
    {
        return UMSocialPlatformType_WechatSession;
    }
    else if ( [snsName isEqualToString:@"wxTimeLine"])
    {
        return UMSocialPlatformType_WechatTimeLine;
    }
    return UMSocialPlatformType_UnKnown;
}

+(BOOL) addThirdLogin:(NSString * )snsName param:(NSDictionary *) params
{
    if (!snsNameList) {
        snsNameList = [[NSMutableDictionary alloc] init];
    }
    if ([UMWarp getPlatform:snsName] == UMSocialPlatformType_QQ) {
        NSString * appid = params[@"appid"];
        NSString *appKey = params[@"appKey"];
        NSString *url = params[@"url"];
        if (appid.length >0 && appKey.length >0 ) {
            //            [UMSocialQQHandler setQQWithAppId:appid appKey:appKey url:url];
            [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:appid/*设置QQ平台的appID*/  appSecret:nil redirectURL:url];
            
            snsNameList[snsName] = params;
            //[snsNameList addObject:snsName];
            return YES;
        }
    }
    else if ([UMWarp getPlatform:snsName] == UMSocialPlatformType_WechatSession)
    {
        NSString * appid = params[@"appid"];
        NSString *appSecret = params[@"appSecret"];
        NSString *url = params[@"url"];
        if (appid.length >0 && appSecret.length >0 && url.length >0) {
            [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:appid  appSecret:appSecret redirectURL:url];
            
            snsNameList[snsName] = params;
            //            [snsNameList addObject:snsName];
            return YES;
        }
    }
    return NO;
}
+(BOOL)hasInstalledQQ
{
    return  [[UMSocialManager defaultManager] isInstall:UMSocialPlatformType_QQ];
}
+(BOOL) hasInstalledWx
{
    return [[UMSocialManager defaultManager] isInstall:UMSocialPlatformType_WechatSession];
}

+(void) login:(UIViewController *)presentingController snsName:(NSString *) snsName  callback:(void (^)(NSString* userid,NSString * userName)) callback
{
    if ([UMWarp getPlatform:snsName] == UMSocialPlatformType_WechatSession) {
        UMSocialManager *um = [UMSocialManager defaultManager];
        if (![um isInstall:UMSocialPlatformType_WechatSession])
        {
            [BSUtility showDialog:@"未安装微信，请先安装微信"];
            return;
        }
    }
    
    [[UMSocialManager defaultManager] authWithPlatform:[UMWarp getPlatform:snsName] currentViewController:nil completion:^(id result, NSError *error) {
        
        
        NSString *message = nil;
        
        if (error) {
            message = @"Get info fail";
            UMSocialLogInfo(@"Get info fail with error %@",error);
        } else {
            
            if ([result isKindOfClass:[UMSocialAuthResponse class]]) {
                UMSocialAuthResponse * resp = result;
                
                UMSocialUserInfoResponse *userInfoResp = [[UMSocialUserInfoResponse alloc] init];
                userInfoResp.uid = resp.uid;
                userInfoResp.openid = resp.openid;
                userInfoResp.accessToken = resp.accessToken;
                userInfoResp.refreshToken = resp.refreshToken;
                userInfoResp.expiration = resp.expiration;
                callback(resp.uid,nil);
                //                authInfo.response = userInfoResp;
                //
                //                ws.authOpFinish();
                //                [ws reloadInfo];
            }else{
                message = @"Get info fail";
                // UMSocialLogInfo(@"Get info fail with  unknow error");
            }
        }
        /*  if (message) {
         UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Auth info"
         message:message
         delegate:nil
         cancelButtonTitle:NSLocalizedString(@"sure", @"确定")
         otherButtonTitles:nil];
         [alert show];
         }*/
    }];
    //
    //    [UMSocialConfig hiddenNotInstallPlatforms:snsNameList.allKeys];
    //    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:snsName];
    //    snsPlatform.haveWebViewAuth = YES;
    //    snsPlatform.loginClickHandler(presentingController,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
    //        //          获取微博用户名、uid、token等
    //        if (response.responseCode == UMSResponseCodeSuccess) {
    //            UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:snsName];
    //            if (callback) {
    //                callback(snsAccount.usid,snsAccount.userName);
    //            }
    //            //            HUDSHOW(@"正在登录中...");
    //            //            [busiSystem.agent thirdLogin:snsAccount.usid userName:snsAccount.userName auth: @[@"weixin",@"qq",@"weibo"][tag-1] observer:self callback:@selector(loginNotification:)];
    //            //            //            NSLog(@"username is %@, uid is %@, token is %@ url is %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL);
    //        }});
}

+(UMSocialPlatformType)toFitPlatformType:(PlatformMode)platformType
{
    if (platformType == PlatformWeChat) {
        return UMSocialPlatformType_WechatSession;
    }
    else if (platformType == PlatformQQ) {
        return UMSocialPlatformType_QQ;
    }
    if (platformType == PlatformWeChatFriend) {
        return UMSocialPlatformType_WechatTimeLine;
    }
    return UMSocialPlatformType_UnKnown;
}

+(void)getUserInfo:(PlatformMode)platformType callBack:(void (^)(NSDictionary *dic)) callback
{
    
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:[UMWarp toFitPlatformType:platformType] currentViewController:nil completion:^(id result, NSError *error) {
        UMSocialUserInfoResponse * resp = result;
        
//        UMSocialUserInfoResponse *userInfoResp = [[UMSocialUserInfoResponse alloc] init];
//        userInfoResp.uid = resp.uid;
//        userInfoResp.openid = resp.openid;
//        userInfoResp.accessToken = resp.accessToken;
//        userInfoResp.refreshToken = resp.refreshToken;
//        userInfoResp.expiration = resp.expiration;
        callback(@{@"uid":resp.uid,@"name":((UMSocialUserInfoResponse*)resp).name?:@"",@"token":resp.accessToken?:@"",@"expiration":resp.expiration?:@"",@"headImg":resp.iconurl?:@""});
    }];
}

+(void) share:(UIViewController *)presentingController shareContent:(NSString *) content  image:(NSString *) contentFile withPlatformType:(NSInteger)platformType
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    //设置文本
    messageObject.text = UMS_Text;
    
    //创建图片内容对象
    UMShareImageObject *shareObject = [[UMShareImageObject alloc] init];
    //如果有缩略图，则设置缩略图
    if (platformType == UMSocialPlatformType_Linkedin) {
        // linkedin仅支持URL图片
        shareObject.thumbImage = UMS_THUMB_IMAGE;
        [shareObject setShareImage:UMS_IMAGE];
    } else {
        shareObject.thumbImage = [UIImage imageNamed:@"icon"];
        shareObject.shareImage = [UIImage imageNamed:@"logo"];
    }
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    [UMWarp shareImageAndTextToPlatformType:platformType withSharemessageObject:messageObject withCurrentVC:presentingController];
    //    [UMSocialConfig hiddenNotInstallPlatforms:@[UMShareToWechatSession,UMShareToWechatTimeline]];
    //    [UMSocialSnsService presentSnsIconSheetView:presentingController
    //                                         appKey:umAppid
    //                                      shareText:content
    //                                     shareImage:contentFile.length >0 ? [UIImage imageWithContentsOfFile: contentFile] : NULL
    //                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToWechatSession,UMShareToWechatTimeline,UMShareToSina,UMShareToQzone,nil]
    //                                       delegate:nil];
}

+(void)loadWeChatUrl:(NSString *)url withWeChat:(NSString *)str
{
    NSDictionary *params = snsNameList[str];
    NSString * appid = params[@"appid"];
    NSString *appSecret = params[@"appSecret"];
    //    NSString *url = params[@"url"];
    if (appid.length >0 && appSecret.length >0 ) {
        // [[UMSocialWechatHandler defaultManager] setAppId:appid appSecret:appSecret url:url];
        //        snsNameList[snsName] = params;
        [[UMSocialManager defaultManager] setPlaform:[UMWarp getPlatform:str] appKey:appid appSecret:appSecret redirectURL:url];
    }
}

+(void)share:(id) observer title:(NSString *)title content:(NSString *)content image:(NSString *)contentFile whithPlatform:(PlatformMode)mode withUrl:(NSString *)url
{
    NSString *modeStr;
    switch (mode) {
        case 0:
        {
            modeStr = @"wxsession";
            [self loadWeChatUrl:url withWeChat:@"wxsession"];
        }
            break;
        case 1:
        {
            modeStr = @"wxTimeLine";
            [self loadWeChatUrl:url withWeChat:@"WxTimeLine"];
        }
            break;
        case 2:
        {
            modeStr = @"qq";//UMShareToQzone;
            if (snsNameList[@"qq"]) {
                NSDictionary *params = snsNameList[@"qq"];
                [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:params[@"appid"]/*设置QQ平台的appID*/  appSecret:params[@"appKey"] redirectURL:url];
                // [[UMSocialQQHandler defaultManager] setAppId:params[@"appid"] appKey:params[@"appKey"] url:url];
            }
            
        }
            break;
        case 3:
        {
            modeStr = UMSocialPlatformType_Sina;
            //            [UMSocialSinaHandler openSSOWithRedirectURL:url];
        }
            break;
            
        default:
            break;
    }
    content = (modeStr == UMSocialPlatformType_Sina) ? [NSString stringWithFormat:@"%@ %@",content,url] : content;
    if([content isEqualToString:@""])
    {
        content = @" ";
    }
    //    [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToSina] content:@"分享内嵌文字" image:nil location:nil urlResource:nil presentedController:self completion:^(UMSocialResponseEntity *shareResponse){
    //        if (shareResponse.responseCode == UMSResponseCodeSuccess) {
    //            NSLog(@"分享成功！");
    //        }
    //    }];
    UIImage *img;
    if(contentFile.length > 0)
    {
        img = [UIImage imageWithContentsOfFile: contentFile] ;
    }
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    //创建网页内容对象
    //    NSString* thumbURL =  UMS_THUMB_IMAGE;
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:title descr:content thumImage:img];
    //设置网页地址
    shareObject.webpageUrl = url;
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    [UMWarp shareWebPageToPlatformType:[UMWarp getPlatform:modeStr] withShareMessageObject:messageObject];
    //    [UMSocialData defaultData].extConfig.title = title;
    //    [[UMSocialControllerService defaultControllerService] setShareText:content shareImage: img socialUIDelegate:observer];        //设置分享内容和回调对象
    //    [UMSocialSnsPlatformManager getSocialPlatformWithName:modeStr].snsClickHandler(observer,[UMSocialControllerService defaultControllerService],YES);
}

+(BOOL)handleOpenURL:(NSURL *)url;
{
    return  [[UMSocialManager defaultManager] handleOpenURL:url];
}


//分享图片和文字
+ (void)shareImageAndTextToPlatformType:(UMSocialPlatformType)platformType withSharemessageObject:(UMSocialMessageObject *) messageObject withCurrentVC:(UIViewController *)curVC
{
    //    //创建分享消息对象
    //    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    //
    //    //设置文本
    //    messageObject.text = UMS_Text;
    //
    //    //创建图片内容对象
    //    UMShareImageObject *shareObject = [[UMShareImageObject alloc] init];
    //    //如果有缩略图，则设置缩略图
    //    if (platformType == UMSocialPlatformType_Linkedin) {
    //        // linkedin仅支持URL图片
    //        shareObject.thumbImage = UMS_THUMB_IMAGE;
    //        [shareObject setShareImage:UMS_IMAGE];
    //    } else {
    //        shareObject.thumbImage = [UIImage imageNamed:@"icon"];
    //        shareObject.shareImage = [UIImage imageNamed:@"logo"];
    //    }
    //
    //    //分享消息对象设置分享内容对象
    //    messageObject.shareObject = shareObject;
    
#ifdef UM_Swift
    [UMSocialSwiftInterface shareWithPlattype:platformType messageObject:messageObject viewController:curVC completion:^(UMSocialShareResponse * data, NSError * error) {
#else
        //调用分享接口
        [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:curVC completion:^(id data, NSError *error) {
#endif
            if (error) {
                UMSocialLogInfo(@"************Share fail with error %@*********",error);
            }else{
                if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                    UMSocialShareResponse *resp = data;
                    //分享结果消息
                    UMSocialLogInfo(@"response message is %@",resp.message);
                    //第三方原始返回的数据
                    UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
                    
                }else{
                    UMSocialLogInfo(@"response data is %@",data);
                }
            }
          //  [UMWarp alertWithError:error];
        }];
    }
     
     
     //网页分享
     + (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType withShareMessageObject:(UMSocialMessageObject *)messageObject
     {
         //        创建分享消息对象
         //        UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
         
         //创建网页内容对象
         //        NSString* thumbURL =  UMS_THUMB_IMAGE;
         //        UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:UMS_Title descr:UMS_Text thumImage:thumbURL];
         //设置网页地址
         //        shareObject.webpageUrl = UMS_WebLink;
         
         //分享消息对象设置分享内容对象
         //        messageObject.shareObject = shareObject;
         
#ifdef UM_Swift
         [UMSocialSwiftInterface shareWithPlattype:platformType messageObject:messageObject viewController:self completion:^(UMSocialShareResponse * data, NSError * error) {
#else
             //调用分享接口
             [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
#endif
                 if (error) {
                     UMSocialLogInfo(@"************Share fail with error %@*********",error);
                 }else{
                     if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                         UMSocialShareResponse *resp = data;
                         //分享结果消息
                         UMSocialLogInfo(@"response message is %@",resp.message);
                         //第三方原始返回的数据
                         UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
                         
                     }else{
                         UMSocialLogInfo(@"response data is %@",data);
                     }
                 }
                // [UMWarp alertWithError:error];
             }];
         }
          
          
          + (void)alertWithError:(NSError *)error
          {
              NSString *result = nil;
              if (!error) {
                  result = [NSString stringWithFormat:@"Share succeed"];
              }
              else{
                  NSMutableString *str = [NSMutableString string];
                  if (error.userInfo) {
                      for (NSString *key in error.userInfo) {
                          [str appendFormat:@"%@ = %@\n", key, error.userInfo[key]];
                      }
                  }
                  if (error) {
                      result = [NSString stringWithFormat:@"Share fail with error code: %d\n%@",(int)error.code, str];
                  }
                  else{
                      result = [NSString stringWithFormat:@"Share fail"];
                  }
              }
              UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"share"
                                                              message:result
                                                             delegate:nil
                                                    cancelButtonTitle:NSLocalizedString(@"sure", @"确定")
                                                    otherButtonTitles:nil];
              [alert show];
          }
          
          
          
          @end
