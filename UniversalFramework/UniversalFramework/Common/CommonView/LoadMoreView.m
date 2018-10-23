//
//  loadMoreView.m
//  MiniClient
//
//  Created by Apple on 14-10-22.
//  Copyright (c) 2014年 SunnadaSoft. All rights reserved.
//


#import "LoadMoreView.h"

@interface loadMoreView ()

@property (nonatomic, strong) UIActivityIndicatorView *activityIndicatorView;

@end

@implementation loadMoreView

- (void)startLoading {
    self.statue = loadMoreStatue_Loading;
    self.hidden = NO;
    self.loadMoreButton.userInteractionEnabled = NO;
    [self.loadMoreButton setTitle:@"正在载入" forState:UIControlStateNormal];
    [self.activityIndicatorView startAnimating];
}

- (void)endLoading {
    self.statue = loadMoreStatue_end;
    self.hidden = YES;
    self.loadMoreButton.userInteractionEnabled = NO;
    [self.loadMoreButton setTitle:@"显示下20条" forState:UIControlStateNormal];
    [self.activityIndicatorView stopAnimating];
}

- (void)configuraManualState:(NSString *)message
{
    self.statue = loadMoreStatue_Manual;
    self.hidden = NO;
    self.loadMoreButton.userInteractionEnabled = YES;
    [self.loadMoreButton setTitle:message forState:UIControlStateNormal];
}
- (void)configuraManualState {
    [self configuraManualState:@"显示下20条"];
}

- (void)configuraNothingMoreWithMessage:(NSString *)message {
    self.statue = loadMoreStatue_Manual;
    self.hidden = NO;
    self.loadMoreButton.userInteractionEnabled = NO;
    [self.loadMoreButton setTitle:message forState:UIControlStateNormal];
}

#pragma mark - Propertys

- (UIButton *)loadMoreButton {
    if (!_loadMoreButton) {
        _loadMoreButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 5, CGRectGetWidth(self.bounds) - 20, CGRectGetHeight(self.bounds) - 10)];
        _loadMoreButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [_loadMoreButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_loadMoreButton setBackgroundColor:[UIColor colorWithWhite:0.922 alpha:1.000]];
    }
    return _loadMoreButton;
}

- (UIActivityIndicatorView *)activityIndicatorView {
    if (!_activityIndicatorView) {
        _activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        _activityIndicatorView.hidesWhenStopped = YES;
        _activityIndicatorView.center = CGPointMake(CGRectGetWidth(self.bounds) / 3, CGRectGetHeight(self.bounds) / 2.0);
    }
    return _activityIndicatorView;
}

#pragma mark - Life Cycle

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.loadMoreButton];
        [self addSubview:self.activityIndicatorView];
        [self endLoading];
    }
    return self;
}

@end
