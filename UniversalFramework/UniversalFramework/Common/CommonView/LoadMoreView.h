//
//  loadMoreView.h
//  MiniClient
//
//  Created by Apple on 14-10-22.
//  Copyright (c) 2014年 SunnadaSoft. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kXHLoadMoreViewHeight 50

typedef enum {
    loadMoreStatue_Normal,
    loadMoreStatue_Manual,
    loadMoreStatue_Loading,
    loadMoreStatue_end
}loadMoreStatue;

@interface loadMoreView : UIView

@property (nonatomic, strong) UIButton *loadMoreButton;
@property (nonatomic) loadMoreStatue statue;

- (void)startLoading;

- (void)endLoading;
//默认提示加载20条
- (void)configuraManualState;
//自定义加载提示信息
- (void)configuraManualState:(NSString *)message;

- (void)configuraNothingMoreWithMessage:(NSString *)message;

@end
