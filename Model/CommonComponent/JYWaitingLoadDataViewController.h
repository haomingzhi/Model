//
//  JYWaitingLoadDataViewController.h
//  ChaoLiu
//
//  Created by air on 15/12/2.
//  Copyright © 2015年 ORANLLC_IOS1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JYWaitingLoadDataViewController : UIViewController
+(void)WaitingDataView:(UIViewController *)waitingVC withOldVC:(UIViewController *)ovc;
+(void)WaitingDataView:(UIViewController *)waitingVC withOldVC:(UIViewController *)ovc withTargetView:(UIView *)targetView;
+(void)WaitingDataViewNotOne:(UIViewController *)waitingVC withOldVC:(UIViewController *)ovc withTargetView:(UIView *)targetView;
+(void)WaitingDataViewNotOne:(UIViewController *)waitingVC withOldVC:(UIViewController *)ovc;
+(void)completeWaiting;
+(void)completeWaitingNotOne:(UIView *)waitingDataVC;
@end
