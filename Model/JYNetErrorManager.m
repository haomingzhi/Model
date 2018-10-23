//
//  JYNetErrorManager.m
//  chenxiaoer
//
//  Created by air on 16/3/31.
//  Copyright © 2016年 ORANLLC_IOS1. All rights reserved.
//

#import "JYNetErrorManager.h"
#import "JYNetErrorViewController.h"
#import "JYNetLoadingManager.h"
@implementation JYNetErrorManager
{
    NSMutableDictionary *_errorDic;
    JYNetErrorViewController *_curNoDataVC;
}

static JYNetErrorManager *netErrorManager;
+(id)manager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        netErrorManager = [[JYNetErrorManager alloc] init];
        netErrorManager->_errorDic = [NSMutableDictionary dictionary];
    });
    
    return netErrorManager;
}

-(void)addErrorView:(UIView *)tableView  withTip:(NSString *)tip withImg:(UIImage *)img
{
    [self addErrorView:tableView withTip:tip withImg:img  withTag:@"0"];
}
-(void)addErrorView:(UIView *)tableView  withTip:(NSString *)tip withImg:(UIImage *)img withTag:(NSString *)tag
{
    [self addErrorView:tableView withTip:tip withImg:img withTag:tag withTarget:nil withAction:nil];
}

-(void)addErrorView:(UIView *)tableView  withTip:(NSString *)tip withImg:(UIImage *)img  withTarget:(id)target withAction:(SEL)sel
{
    [self addErrorView:tableView withTip:tip withImg:img withTag:@"0" withTarget:target withAction:sel];
}

-(void)addErrorView:(UIView *)tableView  withTip:(NSString *)tip withImg:(UIImage *)img withTag:(NSString *)tag withTarget:(id)target withAction:(SEL)sel
{
    UIViewController *nvc = [self createErrorViewController:tag];//_loadingVC;
    //    if (count == 0) {
      _curNoDataVC = (JYNetErrorViewController*)nvc;
    (nvc).view.width = tableView.width;
     (nvc).view.height = tableView.height;
    (nvc).view.x = 0;
    [tableView addSubview:(nvc).view];
    [nvc setValue:@"请重试" forKey:@"tip"];
      [nvc setValue:tip forKeyPath:@"tipLb.text"];
    [nvc setValue:img forKeyPath:@"imageView.image"];
    UIButton *btn = [nvc valueForKey:@"tipBtn"];
    btn.tag = [tag integerValue];
    [btn addTarget:self action:@selector(loadingHandle:) forControlEvents:UIControlEventTouchUpInside];
    [btn addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
    _errorDic[tag] = nvc;
    [_curNoDataVC fitMode];
  }

-(void)loadingHandle:(UIButton *)btn
{
     UIViewController *nvc = _errorDic[[NSString stringWithFormat:@"%ld",btn.tag]];
    [[JYNetLoadingManager manager] addLoadingView:nvc.view  withTip:@"拼命加载中..." withImg:[UIImage imageContentWithFileName:@"run2"]];
}

-(void)dismissErrorView
{
    [self dismissErrorView:@"0"];
}
-(void)dismissErrorView:(NSString *)tag
{
    UIViewController *nvc = _errorDic[tag];
    
    [nvc.view removeFromSuperview];
    [_errorDic removeObjectForKey:tag];
}

-(UIViewController *)createErrorViewController:(NSString *)tag
{
    UIViewController *vc = _errorDic[tag];
    if (vc) {
        return vc;
    }
    return [[JYNetErrorViewController alloc] initWithNibName:@"JYNetErrorViewController" bundle:nil];
}

-(void)fitModeY:(CGFloat)y
{
    [_curNoDataVC fitModeY:y];
}

-(void)fitModeBY:(CGFloat)y
{
    [_curNoDataVC fitModeBY:y];
}
-(void)fitModeX:(CGFloat)x
{
    _curNoDataVC.imgV.x = x;
    _curNoDataVC.labelNoData.y = _curNoDataVC.imgV.x;
}

-(void)fitMode:(CGRect)cgrect
{
    _curNoDataVC.imgV.frame = cgrect;
    _curNoDataVC.labelNoData.y = _curNoDataVC.imgV.y + _curNoDataVC.imgV.height + 20;
}
@end
