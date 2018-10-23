//
//  AppDelegate.m
//  B2C
//
//  Created by ORANLLC_IOS1 on 15/5/19.
//  Copyright (c) 2015年 ORANLLC_IOS1. All rights reserved.
//

#import "AppDelegate.h"

#import "WelcomeViewController.h"
#import "BUSystem.h"
#import "TabViewControllerManager.h"
#import "UIKitHook.h"
#import "LoginViewController.h"
#import "MineViewController.h"
//#import "UMSocial.h"
//#import "UMSocialQQHandler.h"
//#import "UMSocialWechatHandler.h"
//#if TARGET_IPHONE_SIMULATOR
////#define NSLog(format, ...)
//#elif TARGET_OS_IPHONE
//#import <JYAllPay/JYAllPay.h>
//#endif

#import "AdvertiseViewController.h"
#import <AudioToolbox/AudioToolbox.h>
//#import <AlipaySDK/AlipaySDK.h>
//#import "HuanxinKefuManager.h"
//#import <AMapFoundationKit/AMapFoundationKit.h>
//#import <AMapSearchKit/AMapSearchKit.h>
#import "MQSdkManager.h"

@interface AppDelegate ()
{

}
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

     //初始化UIKitHook，改造默认的实现
     [UIKitHook loadAllHooks];
     UniversalFramework_isGenThumb = YES;
     UniversalFrameworkImgUrl = BU_BUSINESS_DOMAIN;
     UniversalFrameworkApiHost = BU_BUSINESS_DOMAIN;
     //    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];//黑色
     NSString * appId = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"ClientAppId"];
     //初始化业务系统
     NSString * token =[[NSUserDefaults standardUserDefaults]objectForKey:@"token"];
     NSString *userId = [[NSUserDefaults standardUserDefaults]objectForKey:@"kuserId"];
     NSString *userName = [[NSUserDefaults standardUserDefaults]objectForKey:@"userName"];
     NSString *nickName = [[NSUserDefaults standardUserDefaults]objectForKey:@"nickName"];
     NSString *img = [[NSUserDefaults standardUserDefaults]objectForKey:@"img"];
     NSString *password =  [[NSUserDefaults standardUserDefaults]objectForKey:@"password"];
     BOOL canPush =  YES;//[[[NSUserDefaults standardUserDefaults]objectForKey:@"canPush"] boolValue];
     NSString *tel =  [[NSUserDefaults standardUserDefaults]objectForKey:@"tel"];
     initBusiSystem(appId);
     [busiSystem.pushManager initAPService:launchOptions];
     busiSystem.agent.token = token;
     busiSystem.agent.userId = userId;
     busiSystem.agent.userName = userName;
     busiSystem.agent.canPush = canPush;
     busiSystem.agent.nickName = nickName;
     BUImageRes *imgr = [BUImageRes new];
     imgr.Image = img;
     busiSystem.agent.img = imgr;
     if(!userId || [userId isEqualToString:@""])
     {
          busiSystem.agent.isLogin = NO;

     }
     else
     {
          busiSystem.agent.isLogin = YES;


     }
     //    busiSystem.agent.cardNo = cardNo;
     busiSystem.agent.tel = tel;
     busiSystem.agent.password = password;


     [[MQSdkManager manager] initData];

     //     [AMapServices sharedServices].apiKey = @"ac4c848c77e3aca27dd0c86d67c8a230";


     //    //初始化友盟库。
     NSString *umAppkey = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"UMengAppKey"];
     [UMWarp initWithAppid:umAppkey ];
     [UMWarp addThirdLogin:@"qq" param:@{@"appid":@"1105942482",@"appKey":@"ZgOKBAhZ5Et1fta7",@"url":@"http://mobile.umeng.com/social"}];
     [UMWarp addThirdLogin:@"wxsession" param:@{@"appid":WXUrlSchemes,@"appSecret":@"49b346470a35d23ed14a4598b2bae377",@"url":@"http://www.umeng.com/social"}];
     [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"resetToken"];
     [[NSUserDefaults standardUserDefaults] synchronize];
     NSString *welcomeKey = [NSString stringWithFormat:@"welcome%@", busiSystem.appVer];
     if ([[NSUserDefaults standardUserDefaults]objectForKey:welcomeKey] == NULL) {
          //    if ([[NSUserDefaults standardUserDefaults]objectForKey:welcomeKey] != NULL){
          WelcomeViewController *welcomeVC = [[WelcomeViewController alloc] initWithNibName:nil bundle:nil];
          self.window.rootViewController = welcomeVC;

     }else{
          //=======正常启动=====//
          //    UINavigationController *navSvc = [[UINavigationController alloc] initWithRootViewController:[[LoginViewController alloc] init]];
          //    self.window.rootViewController =navSvc;
        UIViewController *vc = [TabViewControllerManager mainUI];
          [AdvertiseViewController showView:vc];
 self.window.rootViewController = vc;
          [AdvertiseViewController hiddenAdvc:3.0];

          //     NSLog(@"vssssd:%@,%@,iidd :%@", [UIDevice currentDevice].model,[UIDevice currentDevice].systemVersion,[[UIDevice currentDevice] uniqueDeviceIdentifier]) ;


     }

     [[NSNotificationCenter defaultCenter] addObserver:self
                                              selector:@selector(keyBoardWillShow:)
                                                  name:UIKeyboardWillShowNotification
                                                object:nil];
     [[NSNotificationCenter defaultCenter] addObserver:self
                                              selector:@selector(keyBoardDidHide:)
                                                  name:UIKeyboardDidHideNotification
                                                object:nil];
     [UINavigationBar appearance].barTintColor = kUIColorFromRGB(color_2);

     return YES;
}



- (id)loadFrameworkViewControllerWithBundleNamed:(NSString *)frameworkName ViewControllerName:(NSString *)viewControllerName{
     NSFileManager *manager = [NSFileManager defaultManager];

     NSString *bundlePath = [[NSBundle mainBundle]pathForResource:[NSString stringWithFormat:@"/%@",frameworkName] ofType:@"framework"];
     NSArray  *arrd = [NSBundle allBundles];
     for (NSInteger i = 0; i < arrd.count; i ++) {
          NSBundle *db = arrd[i];
          NSLog(@"xxframedd:%@",db.bundlePath);
     }
     // Check bundle exists
     if (![manager fileExistsAtPath:bundlePath]) {
          UIAlertController *alertViewController = [UIAlertController alertControllerWithTitle:nil message:@"Not Found Framework" preferredStyle:UIAlertControllerStyleAlert];
          UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"👌" style:UIAlertActionStyleDefault handler:nil];
          [alertViewController addAction:okAction];
          //          [self presentViewController:alertViewController animated:YES completion:nil];
          return nil;
     }

     // Load bundle
     NSError *error = nil;
     NSBundle *frameworkBundle = [NSBundle bundleWithPath:bundlePath];
     if (frameworkBundle && [frameworkBundle loadAndReturnError:&error]) {
          NSLog(@"Load framework successfully");
     }else {
          NSLog(@"Failed to load framework : %@",error);
          return nil;
     }

     //     // Load class
     //     Class class = NSClassFromString(viewControllerName);
     //     if (!class) {
     //          NSLog(@"Unable to load class");
     //          return nil;
     //     }

     //     id object = [class new];
     return nil;
}



- (void)tagsAliasCallback:(int)iResCode tags:(NSSet*)tags alias:(NSString*)alias {
     NSLog(@"rescode1: %d, \ntags: %@, \nalias: %@\n", iResCode, tags , alias);
}
//强制使用系统键盘

- (BOOL)application:(UIApplication *)application

shouldAllowExtensionPointIdentifier:(NSString *)extensionPointIdentifier

{

     if ([extensionPointIdentifier isEqualToString:@"com.apple.keyboard-service"]) {

          return NO;

     }
     return YES;

}

- (void)applicationWillResignActive:(UIApplication *)application {
     // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.

     [[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:@"resetToken"];
     [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
     // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
     // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     //   _isActivity = NO;

     //     [HuanxinKefuManager applicationDidEnterBackground:application];
     // 进入后台 关闭美洽服务
     [[MQSdkManager manager] closeMeiqiaService];
}

- (UIViewController *)getCurrentVC
{
     UIViewController *result = nil;

     UIWindow * window = [[UIApplication sharedApplication] keyWindow];
     if (window.windowLevel != UIWindowLevelNormal)
     {
          NSArray *windows = [[UIApplication sharedApplication] windows];
          for(UIWindow * tmpWin in windows)
          {
               if (tmpWin.windowLevel == UIWindowLevelNormal)
               {
                    window = tmpWin;
                    break;
               }
          }
     }

     UIView *frontView = [[window subviews] objectAtIndex:0];
     id nextResponder = [frontView nextResponder];

     if ([nextResponder isKindOfClass:[UIViewController class]])
          result = nextResponder;
     else
          result = window.rootViewController;

     return result;
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
     // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     UIViewController *result = [BSUtility getCurrentVC];
     if (result) {
          if ([result isKindOfClass:[UITabBarController class]]) {
               result  = ((UITabBarController *) result).selectedViewController;
               if ([result isKindOfClass:[UINavigationController class]]) {
                    result = ((UINavigationController *)result).topViewController;
               }
          }
          [result viewDidAppear:YES];
     }
     //     [HuanxinKefuManager applicationWillEnterForeground:application];
     [[MQSdkManager manager] openMeiqiaService];
}


- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
     // Required
     //      [[HChatClient sharedClient] bindDeviceToken:deviceToken];
     [BUPushManager registerDeviceToken:deviceToken];
     if (busiSystem.agent.isLogin) {
          if ( busiSystem.agent.canPush) {
               [BUPushManager setTags:nil alias:busiSystem.agent.tel callbackSelector:@selector(tagsAliasCallback:tags:alias:) object:self];
          }
          else
          {
               [BUPushManager setTags:nil alias:@"" callbackSelector:@selector(tagsAliasCallback:tags:alias:) object:self];
          }
     }
     else
     {
          [BUPushManager setTags:nil alias:@"" callbackSelector:@selector(tagsAliasCallback:tags:alias:) object:self];
     }


     //上传设备deviceToken
     [[MQSdkManager manager] registerDeviceToken:deviceToken];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
     // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     //       _isActivity = YES;
     NSString *r = [[NSUserDefaults standardUserDefaults] objectForKey:@"resetToken"];
     if (r) {
          //        [self checkAuth];
     }

}

- (void)applicationWillTerminate:(UIApplication *)application {
     // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
     [[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:@"resetToken"];
     [[NSUserDefaults standardUserDefaults] synchronize];
}


- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
     return [UMWarp handleOpenURL:url];
}


-(void)pushToWhich:(NSDictionary *)Data
{
}
- (void)application:(UIApplication *)application
didReceiveRemoteNotification:(NSDictionary *)userInfo {
     // Required
     //[[UNUserNotificationCenter currentNotificationCenter] removeAllPendingNotificationRequests];
     [BUPushManager handleRemoteNotification:userInfo];
     NSInteger v = [UIApplication sharedApplication].applicationIconBadgeNumber - 1;
     if (v < 0) {
          v = 0;
     }
     [UIApplication sharedApplication].applicationIconBadgeNumber = v;
     NSLog(@"push33                                                                                                                                                                                                                                                                                                                                                 :%@",userInfo);
     [busiSystem.pushManager pushToWhich:userInfo[@"data"]];
}

//强制使用系统键盘
-(void)keyBoardWillShow:(NSNotification*)aNotification
{
     _isEdit = YES;
     NSDictionary* info = [aNotification userInfo];
     //kbSize即為鍵盤尺寸 (有width, height)
     _kbRect = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];//得到鍵盤的高度
}

-(void)keyBoardDidHide:(id)obj
{
     _isEdit = NO;
}


- (void)application:(UIApplication *)application
didReceiveRemoteNotification:(NSDictionary *)userInfo
fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
     // IOS 7 Support Required
     [BUPushManager handleRemoteNotification:userInfo];

     //    NSString
     NSDictionary *Data = userInfo[@"Data"];
     NSInteger noticeType = [Data[@"NoticeType"] integerValue];
     NSLog(@"push2:%@",userInfo);

     if([UIApplication sharedApplication].applicationState != UIApplicationStateActive)
     {
          NSInteger v = [UIApplication sharedApplication].applicationIconBadgeNumber - 1;
          if (v < 0) {
               v = 0;
          }
          [UIApplication sharedApplication].applicationIconBadgeNumber = v;
          NSLog(@"                                                                                                                                                                                                                                                                                                                                                 :%@",userInfo);
          [busiSystem.pushManager pushToWhich:userInfo[@"data"]];
          completionHandler(UIBackgroundFetchResultNewData);

     }
     else
     {
          AudioServicesPlaySystemSound(1007);
          if (busiSystem.agent.isLogin) {
               [busiSystem.agent getUserIndex:busiSystem.agent.userId observer:nil callback:nil ];
               //            [[NSNotificationCenter defaultCenter] postNotificationName:@"addRedDotForMsgTip" object:nil];
          }

     }

}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
     [UMWarp handleOpenURL:url];
     if ([url.absoluteString hasPrefix:WXUrlSchemes]||[url.absoluteString hasPrefix:AliUrlSchemes]) {
#if TARGET_IPHONE_SIMULATOR
          //#define NSLog(format, ...)
#elif TARGET_OS_IPHONE
          return  [[JYAllPaySDK manager] payResult:@{@"url":url}];
#endif
     }
     else if([url.absoluteString hasPrefix:ZMUrlSchemes])
     {
          NSLog(@"dd:%@",url.absoluteString);
          NSArray *strarray = [url.absoluteString componentsSeparatedByString:@"="];

          NSString *param = [strarray objectAtIndex:1];
          NSLog(@"dxxd:%@",param);
          NSArray *paramSrr = [param componentsSeparatedByString:@"&"];

          NSString *params =[paramSrr firstObject];
          NSLog(@"dfff:%@",params);
          NSString *sign =[strarray lastObject];
          [busiSystem.payManager getZhimaCreditScore:busiSystem.agent.userId?:@"" observer:self callback:@selector(getZhimaCreditNotification:)];
          return YES;
     }

     return YES;
}

-(void)getZhimaCreditNotification:(BSNotification *)noti
{
     [[NSNotificationCenter defaultCenter] postNotificationName:@"zhiMaGoBack" object:nil];
     if (noti.error.code == 0) {
          HUDDISMISS;

          [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshUserInfo" object:nil];
     }
     else
     {

          HUDCRY(noti.error.domain, 1);
     }
}
// NOTE: 9.0以后使用新API接口
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options
{
     [UMWarp handleOpenURL:url];
     if ([url.absoluteString hasPrefix:WXUrlSchemes]||[url.absoluteString hasPrefix:AliUrlSchemes]) {
#if TARGET_IPHONE_SIMULATOR
          //#define NSLog(format, ...)
#elif TARGET_OS_IPHONE
          return  [[JYAllPaySDK manager] payResult:@{@"url":url}];
#endif
     }
     else if([url.absoluteString hasPrefix:ZMUrlSchemes])
     {
          NSLog(@"dd:%@",url.absoluteString);
          NSArray *strarray = [url.absoluteString componentsSeparatedByString:@"="];

          NSString *param = [strarray objectAtIndex:1];
          NSLog(@"dxxd:%@",param);
          NSArray *paramSrr = [param componentsSeparatedByString:@"&"];

          NSString *params =[paramSrr firstObject];
          NSLog(@"dfff:%@",params);
          NSString *sign =[strarray lastObject];

          NSMutableDictionary *paraDic = @{}.mutableCopy;

          [paraDic setObject:params forKey:@"params"];

          [paraDic setObject:sign forKey:@"sign"];
          [busiSystem.payManager getZhimaCreditScore:busiSystem.agent.userId?:@"" observer:self callback:@selector(getZhimaCreditNotification:)];
          return YES;
     }
     return YES;
}



- (void)application:(UIApplication *)application  didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
     //Optional
     NSLog(@"did Fail To Register For Remote Notifications With Error: %@",
           error);
}

-(void)checkAuth{

     [busiSystem.agent checkAuth:self callback:@selector(checkAuthNotification:)];
}

-(void)checkAuthNotification:(BSNotification *)noti
{
}
@end
