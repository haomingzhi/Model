//
//  DDExDialogView.m
//  NIM
//
//  Created by apple on 2018/7/25.
//  Copyright © 2018年 Netease. All rights reserved.
//

#import "DDExDialogView.h"
//#import "AppDelegate.h"
@interface DDExDialogView()
@property(nonatomic,strong)UITapGestureRecognizer *tapGes;
@property(nonatomic,strong)UISwipeGestureRecognizer *swGes;
@end

@implementation DDExDialogView
-(id)initWithView:(UIView *)view
{
    self = [super init];
    if (self) {
        self.frame = [UIScreen mainScreen].bounds;
        _view = view;
        self.backgroundColor = UIColorFromRGBA(0x000000, 0.5);
        [self addSubview:_view];
        [self addGestureRecognizer:self.tapGes];
        [self addGestureRecognizer:self.swGes];
        self.tapGes.enabled = NO;
    }
    return self;
}

-(void)setIsOutSideClickClose:(BOOL)isOutSideClickClose
{
    _isOutSideClickClose = isOutSideClickClose;
    self.tapGes.enabled = isOutSideClickClose;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
}

-(UISwipeGestureRecognizer *)swGes
{
    if (!_swGes) {
        _swGes = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swHandle:)];
    }
    return _swGes;
}

-(void)swHandle:(UISwipeGestureRecognizer*)ges
{
    
}
-(UITapGestureRecognizer *)tapGes
{
    if (!_tapGes) {
        _tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(outSideClick:)];
    }
    return _tapGes;
}

-(void)outSideClick:(UITapGestureRecognizer *)tap
{
    CGPoint p = [tap locationInView:self.view];
    if (p.x < 0 ||p.y < 0) {
        self.hidden = YES;
        if (_closeCallBack) {
            _closeCallBack(@{});
        }
    }
}

-(void)addToWindow
{
    [[UIApplication sharedApplication].delegate.window addSubview:self];
    
}

-(void)removeFromWindow
{
    [self removeFromSuperview];
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
