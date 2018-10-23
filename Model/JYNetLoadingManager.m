//
//  JYNetLoadingManager.m
//  chenxiaoer
//
//  Created by air on 16/3/31.
//  Copyright © 2016年 ORANLLC_IOS1. All rights reserved.
//

#import "JYNetLoadingManager.h"
#import "JYNetLoadingViewController.h"
@implementation JYNetLoadingManager
{
//    JYNetLoadingViewController *_loadingVC;
    NSMutableDictionary *_loadingDic;
}

static JYNetLoadingManager *netLoadingManager;
+(id)manager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        netLoadingManager = [[JYNetLoadingManager alloc] init];
//        netLoadingManager->_loadingVC = [[JYNetLoadingViewController alloc] initWithNibName:@"JYNetLoadingViewController" bundle:nil];
        netLoadingManager->_loadingDic = [NSMutableDictionary dictionary];
    });
    
    return netLoadingManager;
}

-(void)addLoadingView:(UIView *)tableView  withTip:(NSString *)tip withImg:(UIImage *)img
{
    [self addLoadingView:tableView withTip:tip withImg:img  withTag:@"0"];
}

-(void)addLoadingView:(UIView *)tableView  withTip:(NSString *)tip withImg:(UIImage *)img withTag:(NSString *)tag
{
    UIViewController *nvc = [self createLoaddingViewController:tag];//_loadingVC;
//    if (count == 0) {
         (nvc).view.width = tableView.width;
         (nvc).view.height = tableView.height;
        (nvc).view.x = 0;
        [tableView addSubview:(nvc).view];
        [tableView bringSubviewToFront:nvc.view];
        [nvc setValue:tip forKeyPath:@"tipLb.text"];
        [nvc setValue:img forKeyPath:@"imageView.image"];
        _loadingDic[tag] = nvc;
//    }
//    else
//    {
//        [(nvc).view removeFromSuperview];
//        [_loadingDic removeObjectForKey:tag];
//    }
    
}
-(void)dismissLoadingView
{
    [self dismissLoadingView:@"0"];
}
-(void)dismissLoadingView:(NSString *)tag
{
    UIViewController *nvc = _loadingDic[tag];
    
    [nvc.view removeFromSuperview];
     [_loadingDic removeObjectForKey:tag];
}

-(UIViewController *)createLoaddingViewController:(NSString *)tag
{
    UIViewController *vc = _loadingDic[tag];
    if (vc) {
        return vc;
    }
  return [[JYNetLoadingViewController alloc] initWithNibName:@"JYNetLoadingViewController" bundle:nil];
}
@end
