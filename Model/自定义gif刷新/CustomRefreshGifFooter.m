//
//  CustomRefreshGifFooter.m
//  校园在线
//
//  Created by 游 on 2017/10/18.
//  Copyright © 2017年 游. All rights reserved.
//

#import "CustomRefreshGifFooter.h"

@implementation CustomRefreshGifFooter

- (void)prepare
{
    [super prepare];
    
    // 设置普通状态的动画图片
    NSMutableArray *idleImages = [NSMutableArray array];
    for (NSUInteger i = 1; i<=11; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"上拉加载_000%.2ld", i]];
        [idleImages addObject:image];
    }
    [self setImages:idleImages forState:MJRefreshStateIdle];
    
    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
    NSMutableArray *refreshingImages = [NSMutableArray array];
    for (NSUInteger i = 1; i<=11; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"上拉加载_000%.2ld", i]];
        [refreshingImages addObject:image];
    }
    [self setImages:refreshingImages forState:MJRefreshStatePulling];
    
    // 设置正在刷新状态的动画图片
    [self setImages:refreshingImages forState:MJRefreshStateRefreshing];
    
    [self setTitle:@"小π努力加载中" forState:MJRefreshStateIdle];
    [self setTitle:@"小π努力加载中" forState:MJRefreshStatePulling];
    [self setTitle:@"小π努力加载中" forState:MJRefreshStateRefreshing];
    [self setTitle:@"小π努力加载中" forState:MJRefreshStateWillRefresh];
    [self setTitle:@"页面到底啦~" forState:MJRefreshStateNoMoreData];
}

@end
