//
//  JYNodataManager.m
//  chenxiaoer
//
//  Created by air on 16/3/30.
//  Copyright © 2016年 ORANLLC_IOS1. All rights reserved.
//

#import "JYNoDataManager.h"
#import "JYNoDataViewController.h"
@implementation JYNoDataManager
{
     JYNoDataViewController *_curNoDataVC;
      NSMutableDictionary *_noDataDic;
      NSString *_curTag;
    UIView *_curView;
}

static JYNoDataManager *nodataManager;
+(id)manager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        nodataManager = [[JYNoDataManager alloc] init];
        nodataManager->_noDataDic = [NSMutableDictionary dictionary];
    });
    
    return nodataManager;
}
-(void)addNodataView:(UIView *)tableView  withTip:(NSString *)tip withImg:(NSString *)img withCount:(NSInteger )count
{
    [self addNodataView:tableView withTip:tip withImg:img withCount:count withTag:@"0"];
}

-(void)addNodataView:(UIView *)view  withTip:(NSString *)tip withImg:(NSString *)img withCount:(NSInteger )count withTag:(NSString *)tag
{
    
    UIViewController *nvc = [self createNodataViewController:tag];//_loadingVC;
    _curNoDataVC = (JYNoDataViewController*)nvc;
     _curNoDataVC.view.width = view.width;
     _curTag = tag;
    _curView = view;
    if (count == 0) {
        (nvc).view.width = view.width;
        (nvc).view.height = view.height;
        (nvc).view.x = 0;
        [view addSubview:(nvc).view];
        [view bringSubviewToFront:nvc.view];
        [nvc setValue:tip forKey:@"noDataHint"];
        [nvc setValue:img forKey:@"noDataImageView"];
        _noDataDic[tag] = nvc;
        if ([view isKindOfClass:[UIScrollView class]]) {
            [(UIScrollView *)view setScrollEnabled:NO];
        }
    }
    else
    {
        [(nvc).view removeFromSuperview];
        [_noDataDic removeObjectForKey:tag];
        if ([view isKindOfClass:[UIScrollView class]]) {
            [(UIScrollView *)view setScrollEnabled:YES];
        }
    }
    nvc.view.backgroundColor = view.backgroundColor;
}

-(void)dismiss
{
    if ([_curView isKindOfClass:[UIScrollView class]]) {
     [(UIScrollView *)_curView setScrollEnabled:YES];
    }
    [_curNoDataVC.view removeFromSuperview];
    [_noDataDic removeObjectForKey:_curTag?:@""];
    
}


-(UIViewController *)createNodataViewController:(NSString *)tag
{
    UIViewController *vc = _noDataDic[tag];
    if (vc) {
        return vc;
    }
    return [[JYNoDataViewController alloc] initWithNibName:@"JYNoDataViewController" bundle:nil];
}
-(void)fitModeY:(CGFloat)y
{
    [_curNoDataVC fitModeY:y];
}
-(void)fitModeY:(CGFloat)y withImgVWidth:(CGFloat)w withViewY:(CGFloat)vy
{
     [_curNoDataVC fitModeY:y withImgVWidth:w withViewY:vy];
}

-(void)fitMode:(CGRect)rect
{
    _curNoDataVC.view.frame = rect;
}

-(void)fitModeBY:(CGFloat)y
{
//    [_curNoDataVC fitModeBY:y];
}
-(void)fitModeX:(CGFloat)x
{
//    _curNoDataVC.imgV.x = x;
//    _curNoDataVC.labelNoData.y = _curNoDataVC.imgV.x;
}

//-(void)fitMode:(CGRect)cgrect
//{
////    _curNoDataVC.imgV.frame = cgrect;
////     _curNoDataVC.labelNoData.y = _curNoDataVC.imgV.y + _curNoDataVC.imgV.height + 20;
//}

-(void)fitModeColor:(UIColor*)color
{
    _curNoDataVC.view.backgroundColor = color;
}
@end
