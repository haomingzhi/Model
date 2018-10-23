//
//  JYCodeBtn.m
//  MeiliWan
//
//  Created by Air on 15-4-21.
//  Copyright (c) 2015年 wujyapp. All rights reserved.
//

#import "JYCodeBtn.h"
@interface JYCodeBtn()
{
    int _times;
    NSTimer *_codeTimer;
}
@end
@implementation JYCodeBtn

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)awakeFromNib
{
    [self addTarget:self action:@selector(innerAction:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)innerAction:(UIButton *)btn {
    btn.userInteractionEnabled = NO;
    _times = 10;
    _codeTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(canStartGetCode) userInfo:nil repeats:YES];
    [self canStartGetCode];
}

-(void)canStartGetCode
{
    _times --;
    if (_times == 0) {
           self.userInteractionEnabled = YES;
        [_codeTimer invalidate];
        [self setTitle:@"获取信息验证码" forState:UIControlStateNormal];
    }
    else
    {
        [self setTitle:[NSString stringWithFormat:@"剩余%d秒",_times] forState:UIControlStateNormal];
        
    }
}

@end
