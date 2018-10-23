//
//  WaveProgressView.m
//  WaveViewDemo
//
//  Created by Darwin on 2017/4/6.
//  Copyright © 2017年 Darwin. All rights reserved.
//

#import "WaveProgressView.h"
#import "WaveView.h"
#import "TargetWeakProxy.h"

@interface WaveProgressView ()

@property (nonatomic, strong) WaveView *waveView;

@property (nonatomic, strong) UILabel *percentLabel;

@property (nonatomic, strong) CADisplayLink *displayLink;

@end

@implementation WaveProgressView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupProperty];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self setupProperty];
    }
    return self;
}

- (void)setupProperty {
    self.backgroundColor = [UIColor clearColor];
    self.layer.masksToBounds = YES;
    _percent = 0;
    _showPercent = YES;
    _isCircle = YES;
    self.layer.cornerRadius = self.bounds.size.width * 0.5;
//    self.layer.borderWidth = 1;
    _firstWaveColor = [UIColor colorWithRed:99 / 256.0 green:229 / 256.0 blue:189 / 256.0 alpha:1];
    self.layer.borderColor = _firstWaveColor.CGColor;
}

- (UILabel *)percentLabel {
    if(_percentLabel == nil) {
        _percentLabel = [UILabel new];
        _percentLabel.text = @"0.0 %%";
        _percentLabel.textColor = [UIColor blueColor];
        [_percentLabel sizeToFit];
        _percentLabel.center = CGPointMake(self.bounds.size.width * 0.5, self.bounds.size.height * 0.5);
        [self addSubview:_percentLabel];
    }
    return _percentLabel;
}

- (WaveView *)waveView {
    if(_waveView == nil) {
        WaveView *waveView = [[WaveView alloc] initWithFrame:CGRectMake(0, self.bounds.size.height, self.bounds.size.width, 0)];
        [self insertSubview:waveView atIndex:0];
        waveView.isDouble = YES;
        _waveView = waveView;
        
        if(_firstWaveColor) {
            _waveView.firsetWaveColor = _firstWaveColor;
        }
        if(_secondWaveColor) {
            _waveView.secondWaveColor = _secondWaveColor;
        }
        self.backgroundColor = [UIColor clearColor];
    }
    return _waveView;
}

- (void)setFirstWaveColor:(UIColor *)firstWaveColor {
    _firstWaveColor = firstWaveColor;
    self.waveView.firsetWaveColor = firstWaveColor;
    self.layer.borderColor = firstWaveColor.CGColor;
    if(_percentColor == nil) {
        self.percentLabel.textColor = firstWaveColor;
    }
}

- (void)setSecondWaveColor:(UIColor *)secondWaveColor {
    _secondWaveColor = secondWaveColor;
    self.waveView.secondWaveColor = secondWaveColor;
}

- (void)setPercent:(CGFloat)percent {
    
    if(percent > 1 || percent < 0) {
        NSLog(@"percent设置错误：%lf,percent的范围为 0 - 1 区间", percent);
        return;
    }
    _percent = percent;
    
    if(_displayLink == nil) {
        _displayLink = [CADisplayLink displayLinkWithTarget:[TargetWeakProxy proxyWithTarget:self] selector:@selector(changeAnimation)];
        [_displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    }
    
    if(_showPercent) {
        self.percentLabel.text = [NSString stringWithFormat:@"%.1lf %%", _percent * 100];
        [self.percentLabel sizeToFit];
        
        if(_percent > 0.5 && _percentColor == nil) {
            self.percentLabel.textColor = [UIColor whiteColor];
        } else {
            self.percentLabel.textColor = _firstWaveColor;
        }
          self.percentLabel.hidden = YES;
    }
     else
     {
          self.percentLabel.hidden = YES;
     }
}


- (void)changeAnimation {
    
    // 得到当前的y值
    CGFloat currentY = self.waveView.frame.origin.y;
    // 得到应该的y值
    CGFloat objectY = (1 - _percent) * self.bounds.size.height;
    
    if(currentY > objectY) {
        CGFloat y = currentY - 1;
        self.waveView.frame = CGRectMake(0, y, self.bounds.size.width, self.bounds.size.height);
        if(y <= objectY) {
            [self stopDisplayLink];
        }
    } else if(currentY < objectY){
        CGFloat y = currentY + 1;
        self.waveView.frame = CGRectMake(0, y, self.bounds.size.width, self.bounds.size.height);
        if(y >= objectY) {
            [self stopDisplayLink];
        }
    }

}

- (void)stopDisplayLink {
    if(_displayLink) {
        [_displayLink invalidate];
        _displayLink = nil;
    }
    if(_percent == 1) {
        self.backgroundColor = _firstWaveColor;
        [self.waveView stopWave];
        [self.waveView removeFromSuperview];
        self.waveView = nil;
    }
}

- (void)setShowPercent:(BOOL)showPercent {
    _showPercent = showPercent;
    if(showPercent == NO) {
        _percentLabel.textColor = [UIColor clearColor];
    } else {
        self.percent += 0;
    }
     _percentLabel.hidden = YES;
}

- (void)setPercentColor:(UIColor *)percentColor {
    _percentColor = percentColor;
    _percentLabel.textColor = percentColor;
}

- (void)setIsDouble:(BOOL)isDouble {
    _isDouble = isDouble;
    self.waveView.isDouble = isDouble;
}

- (void)setIsCircle:(BOOL)isCircle {
    _isCircle = isCircle;
    if(isCircle) {
        self.layer.cornerRadius = self.bounds.size.width * 0.5;
    } else {
        self.layer.cornerRadius = 0;
    }
}

@end
