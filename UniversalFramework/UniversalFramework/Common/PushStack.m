//
//  PushStack.m
//  cpvs
//
//  Created by 耶通 on 14-12-3.
//  Copyright (c) 2014年 com.nd. All rights reserved.
//
#import <AudioToolbox/AudioToolbox.h>
#import "PushStack.h"
//#import "AppDelegate.h"
//@interface PushStack()
//{
//    NSMutableArray *pushArr;
//}
//@end
//static PushStack *ps;
@implementation PushStack
{
    NSMutableArray *pushArr;
    UIButton *pushBtn;
    //    UIWindow  *_overlayWindow;
    UIWindow *_overlayView;
    UIWindowLevel _oldLevel;
    UIView *bar;
}
-(void)addPushInfo:(NSDictionary *)dic
{
    if (pushArr == nil) {
        pushArr = [[NSMutableArray alloc] init];
    }
    //    if (pushArr.count == 0) {
    //        [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationNone];
    //    }
    if (!_overlayView) {
        _overlayView = [[UIApplication sharedApplication].delegate window];
        _oldLevel = _overlayView.windowLevel;
        //        _overlayWindow = [[UIWindow alloc] initWithFrame:CGRectMake(0, 0, __SCREEN_SIZE.width, 20)];
        //        _overlayWindow.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        //        _overlayWindow.backgroundColor = [UIColor clearColor];
        //        _overlayWindow.userInteractionEnabled = YES;
        _overlayView.windowLevel = UIWindowLevelStatusBar;
        //        _overlayWindow.rootViewController = [[TestNotificationViewController alloc] init];
        //        _overlayWindow.rootViewController.view.backgroundColor = [UIColor clearColor];
        //        _overlayWindow.layer.borderColor = [UIColor redColor].CGColor;
        //        _overlayWindow.layer.borderWidth = 2;
        //         bar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, __SCREEN_SIZE.width/2, 20)];
        //        bar.backgroundColor = [UIColor redColor];
        //        [_overlayView.rootViewController.view addSubview:bar];
        //        [_overlayView makeKeyAndVisible];
    }
    if (_overlayView.windowLevel != UIWindowLevelStatusBar) {
        _overlayView.windowLevel = UIWindowLevelStatusBar;
    }
    
    [pushArr addObject:dic];
    AudioServicesPlaySystemSound(1007);
    //    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    
    //更新界面
    [self showPushButtons];
}

-(void) showPushButtons
{
    if (!pushBtn) {
        pushBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, __SCREEN_SIZE.width, 30)];
        pushBtn.backgroundColor = [UIColor lightGrayColor];
        [pushBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    [pushBtn setHidden:NO];
    //    AppDelegate *app =  [UIApplication sharedApplication].delegate;
    [_overlayView addSubview:pushBtn];
    NSString *str = [pushArr lastObject][@"aps"][@"alert"];
    //取最后一条推送显示
    [pushBtn setTitle:str forState:UIControlStateNormal];
    
    [pushBtn addTarget:self action:@selector(pushAction:) forControlEvents:UIControlEventTouchUpInside];
    [self performSelector:@selector(deleteData:) withObject:str afterDelay:15];
}

-(void)deleteData:(NSString*)str
{
    if ([[pushArr firstObject][@"aps"][@"alert"] isEqualToString:str]) {
        [pushArr removeObject:[pushArr firstObject]];
        if (pushArr.count == 0) {
            //删除推送通知
            //        [[UIApplication sharedApplication]setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
            //        [_overlayWindow resignKeyWindow];
            //        [_overlayWindow removeFromSuperview];
            //        _overlayWindow= nil;
            [pushBtn setHidden:YES];
            [pushBtn removeFromSuperview];
            _overlayView.windowLevel = _oldLevel;
        }
        else
        {
            [pushBtn removeFromSuperview];
            [self showPushButtons];
        }
        
    }
}

-(void)pushAction:(UIButton *)btn
{
    //打开推送信息
    NSDictionary *m = [pushArr lastObject];
    //    NSString *msgId = m[@"message_id"];
    //    NSString *pushId = m[@"pushId"];
    //    AppDelegate *app =  [UIApplication sharedApplication].delegate;
    //    CPVSTabBarViewController *tabs=   (CPVSTabBarViewController *) app.navtab;
    //    // int i=tabs.selectedIndex;
    //    //    MessageViewController *vcMessage= [self.ncMessage viewControllers][0];
    //    //    vcMessage.messageTheme=MVMessageThemeTime;
    //    UINavigationController *n = [app.navtab viewControllers][0];
    //    [n popToRootViewControllerAnimated:NO];
    //    tabs.selectedViewController = n;
    //    CPVSSubjectMessagesViewController *vcSubjectMessage =[[CPVSSubjectMessagesViewController alloc] init];
    //    vcSubjectMessage.parent_message_id = msgId;
    //    //    vcSubjectMessage.enMessage = message;
    //    vcSubjectMessage.hidesBottomBarWhenPushed = YES;
    //    //    vcSubjectMessage.indexPath=indexPath;
    //    vcSubjectMessage.message_src=@"0";
    //    vcSubjectMessage.process_status = @"0";
    //    [n pushViewController:vcSubjectMessage animated:YES];
    if(_pushBlock)
    {
        _pushBlock(m[@"Data"]);
    }
    [pushArr removeObject:[pushArr lastObject]];
    if (pushArr.count == 0) {
        //删除推送通知
        //        [[UIApplication sharedApplication]setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
        //        [_overlayWindow resignKeyWindow];
        //        [_overlayWindow removeFromSuperview];
        //        _overlayWindow= nil;
        [pushBtn setHidden:YES];
        [pushBtn removeFromSuperview];
        _overlayView.windowLevel = _oldLevel;
    }
    else
    {
        [pushBtn removeFromSuperview];
        [self showPushButtons];
    }
}

+(instancetype)sharePushStack
{
    
    static dispatch_once_t  onceToken;
    static PushStack * sSharedInstance;
    
    dispatch_once(&onceToken, ^{
        sSharedInstance = [[PushStack alloc] init];
    });
    return sSharedInstance;
}

@end
