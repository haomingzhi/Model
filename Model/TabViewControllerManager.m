//
//  TabViewControllerManager.m
//  B2C
//
//  Created by air on 15/7/14.
//  Copyright (c) 2015年 ORANLLC_IOS1. All rights reserved.
//

#import "TabViewControllerManager.h"
#import "JYBaseTabBarController.h"
#import "BUSystem.h"
@implementation TabViewControllerManager

+(UINavigationController *)NavViewController:(NSString * )classStr withTitle:(NSString *) title withSelImg:(NSString *)aSelImg withUnSelImg:(NSString *)aUnSelImg
{
    Class someClass = NSClassFromString(classStr);
     id obj;
     if ([classStr isEqualToString:@"MineViewController"]) {
          obj = [[someClass alloc] init];
     }
     else
   obj  = [[someClass alloc] initWithNibName:classStr bundle:nil];
    [obj performSelector:@selector(setTitle:) withObject:title];
    [obj setValue:[[UITabBarItem alloc] initWithTitle:title image:[[UIImage imageNamed:aUnSelImg] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ] selectedImage:[[UIImage imageNamed:aSelImg] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ]] forKey:@"tabBarItem"];
    UINavigationController *navSvc = [[UINavigationController alloc] initWithRootViewController:obj];
    navSvc.navigationBar.titleTextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:20],NSForegroundColorAttributeName:[UIColor whiteColor],} ;//[NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
    [obj setValue:@(NO) forKeyPath:@"navigationController.navigationBar.translucent"];
    
//    svc.navigationController.navigationBar.translucent = NO;
    return navSvc;
}

+(  UITabBarController * )mainUI
{
    UINavigationController *navSvc = [self NavViewController:@"HeadViewController" withTitle:@"首页" withSelImg:@"tab_home" withUnSelImg:@"tab_home_unSel"];
    [navSvc.navigationBar setShadowImage:[UIImage new]];
    UINavigationController *navCvc = [self NavViewController:@"ClassifyViewController" withTitle:@"分类" withSelImg:@"tab_classify" withUnSelImg:@"tab_classify_unSel"];
    UINavigationController *navPvc = [self NavViewController:@"DealViewController" withTitle:@"发现" withSelImg:@"tab_disc" withUnSelImg:@"tab_disc_unSel"];
//    UINavigationController *navEvc = [self NavViewController:@"EvaluateViewController" withTitle:@"评价" withSelImg:@"tab_Evaluate" withUnSelImg:@"tab_Evaluate_unSel"];
    UINavigationController *navMvc = [self NavViewController:@"MineViewController" withTitle:@"我的" withSelImg:@"tab_mine" withUnSelImg:@"tab_mine_unSel"];
//    [navMvc.navigationBar setShadowImage:[UIImage new]];
    JYBaseTabBarController *   tabbarController = [[JYBaseTabBarController alloc] init];
    //    tabbarController.delegate = self;
    tabbarController.viewControllers = @[navSvc,navCvc,navPvc,navMvc];
    tabbarController.tabBar.barTintColor = kUIColorFromRGB(color_2);//kUIColorFromRGB(<#rgbValue#>);//
    tabbarController.tabBar.translucent = NO;
//    _tabbarController.tabBar.frame = CGRectMake(0, __SCREEN_SIZE.height-62, __SCREEN_SIZE.width, 62);
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:10],NSForegroundColorAttributeName:kUIColorFromRGB(color_8),}  forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:10],NSForegroundColorAttributeName:kUIColorFromRGB(color_3),}  forState:UIControlStateSelected];
//    UIImageView *imgV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 47, __SCREEN_SIZE.width, 15)];
//    imgV.image = [UIImage imageNamed:@"tab_bottom"];
//    imgV.backgroundColor = kUIColorFromRGB(color_3);
//    [_tabbarController.tabBar addSubview:imgV];
//    _tabbarController.bottomImgV = imgV;
//    [[UITabBarItem appearance] setTitlePositionAdjustment:UIOffsetMake(-10, -6)];
//    [TabViewControllerManager fitImgPostion:UIEdgeInsetsMake(0, 0, 0, 0) withTabBarVC:_tabbarController];
    busiSystem.agent.isNeedRefreshTabA = YES;
     busiSystem.agent.isNeedRefreshTabB = YES;
     busiSystem.agent.isNeedRefreshTabC = YES;
        busiSystem.agent.isNeedRefreshTabD = YES;
    return tabbarController;
}

+(void)fitImgPostion:(UIEdgeInsets)edg withTabBarVC:(UITabBarController *)tbVC
{
    [tbVC.tabBar.items enumerateObjectsUsingBlock:^(UITabBarItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UITabBarItem *i =  obj;
        [i setImageInsets:edg];
    }];
    
}

+(void)setTabvBgColor:(UIColor *)color
{
    UITabBarController *tab = ( UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
//    tab.tabBarController.tabBar.backgroundColor = color;
//    tab.tabBar.backgroundColor = color;
    tab.tabBar.barTintColor = color;
}

+(void)setTabvImg:(NSString *)img withUnSecImg:(NSString *)uimg
{
 UITabBarController *tab = ( UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    [tab.tabBar.items enumerateObjectsUsingBlock:^(UITabBarItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
         UITabBarItem *i =  obj;
        [i setImage:[UIImage imageContentWithFileName:img]];
        [i setSelectedImage:[UIImage imageContentWithFileName:uimg]];
    }];
}


+(void)setTabvBottomImgV:(NSString *)img
{
     JYBaseTabBarController *tab = ( JYBaseTabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    tab.bottomImgV.image = [UIImage imageContentWithFileName:img];
//[self trans]
}
+(void)setTabvTextColor:(UIColor *)color withUnselectColor:(UIColor *)unScolor
{

    [[UITabBarItem appearance] setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:10],NSForegroundColorAttributeName:unScolor,}  forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:10],NSForegroundColorAttributeName:color,}  forState:UIControlStateSelected];
 
}
+(void)checkTabItem:(NSInteger)index
{
 UITabBarController *tab = ( UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
//    [UIView animateWithDuration:1.2 animations:^{
//            tab.tabBar.selectedItem.image.scale = 1.4;
//    } completion:^(BOOL finished) {
//           tab.tabBar.selectedItem.image.scale = 1.0;
//    }]

}
@end
