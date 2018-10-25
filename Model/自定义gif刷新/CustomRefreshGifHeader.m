//
//  CustomRefreshGifHeader.m
//  校园在线
//
//  Created by 游 on 2017/10/16.
//  Copyright © 2017年 游. All rights reserved.
//

#import "CustomRefreshGifHeader.h"

@implementation CustomRefreshGifHeader

- (void)prepare
{
    [super prepare];
    // 设置普通状态的动画图片
    NSMutableArray *idleImages = [NSMutableArray array];
    for (NSUInteger i = 1; i<=17; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"加载动画_000%.2d", i]];
         if(image)
        [idleImages addObject:image];
    }
    [self setImages:idleImages forState:MJRefreshStateIdle];
    
    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
    NSMutableArray *refreshingImages = [NSMutableArray array];
    for (NSUInteger i = 1; i<=17; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"加载动画_000%.2ld", i]];
          if(image)
        [refreshingImages addObject:image];
    }
    [self setImages:refreshingImages forState:MJRefreshStatePulling];
    
    // 设置正在刷新状态的动画图片
    [self setImages:refreshingImages forState:MJRefreshStateRefreshing];
    
    //隐藏时间
    self.lastUpdatedTimeLabel.hidden = YES;
    //隐藏状态
    self.stateLabel.hidden = YES;
}

@end
