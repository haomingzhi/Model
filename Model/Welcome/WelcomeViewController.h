//
//  MiniWelcomeViewController.h
//  MiniClient
//
//  Created by longgong on 14-8-11.
//  Copyright (c) 2014年 SunnadaSoft. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface WelcomeViewController : JYBaseViewController<MyPageViewDelegate>

@property (strong, nonatomic) MyPageView *pageView;

@end
