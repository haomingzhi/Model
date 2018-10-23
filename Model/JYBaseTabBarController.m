//
//  JYBaseTabBarController.m
//  compassionpark
//
//  Created by air on 2017/2/28.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import "JYBaseTabBarController.h"
#import "BUSystem.h"
#import "LoginViewController.h"
#import "MineViewController.h"
@implementation JYBaseTabBarController

-(void)viewDidLoad
{
    self.delegate = self;
}
//-(void)viewDidLayoutSubviews
//{
//     self.tabBar.height = 49;
//    self.tabBar.y = __SCREEN_SIZE.height - 49;
//    [super viewDidLayoutSubviews];
//   
////    self.view.height = __SCREEN_SIZE.height - 62;
//}
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
//     if (!busiSystem.agent.isLogin && [[(UINavigationController *)viewController viewControllers].firstObject isKindOfClass:[MineViewController class]]) {
//          [LoginViewController toLogin:self];
////          self.tabBarController.selectedIndex = 1;//self.indexFlag;
//          //              self.indexFlag = index;
//          return NO;
//     }
     return YES;
}
- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    
    NSInteger index = [self.tabBar.items indexOfObject:item];
    
    if (self.indexFlag != index) {

        [self animationWithIndex:index];
    }
    
}
// 动画
- (void)animationWithIndex:(NSInteger) index {
    NSMutableArray * tabbarbuttonArray = [NSMutableArray array];
    for (UIView *tabBarButton in self.tabBar.subviews) {
        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            [tabbarbuttonArray addObject:tabBarButton];
        }
    }
    CABasicAnimation*pulse = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    pulse.timingFunction= [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    pulse.duration = 0.24;
    pulse.repeatCount= 1;
    pulse.autoreverses= YES;
    pulse.fromValue= [NSNumber numberWithFloat:0.8];
    pulse.toValue= [NSNumber numberWithFloat:1.2];
    [[tabbarbuttonArray[index] layer]
     addAnimation:pulse forKey:nil];
    
    self.indexFlag = index;
    
}
@end
