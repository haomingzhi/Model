//
//  WaveView.m
//  WaveViewDemo
//
//  Created by Darwin on 2017/4/6.
//  Copyright © 2017年 Darwin. All rights reserved.
//

#import "WaveView.h"
#import "TargetWeakProxy.h"

@interface WaveView ()

/*
 * 波动的宽度
 */
@property (nonatomic, assign) CGFloat waveWidth;

/*
 * 设置位移
 */
@property (nonatomic, assign) CGFloat offset;

/*
 * 可变量变化相关
 */
@property (nonatomic, assign) CGFloat variable;
@property (nonatomic, assign) BOOL isIncrease;

/*
 * 两个图层
 */
@property (nonatomic, strong) CAShapeLayer *firstWaveLayer;
@property (nonatomic, strong) CAShapeLayer *secondWaveLayer;

/*
 * 定时器
 */
@property (nonatomic, strong) CADisplayLink *waveDisplayLink;

/*
 * 是否正在波动
 */
@property (nonatomic, assign) BOOL isWaving;

/*
 * 是否是手动设置的振幅
 */
@property (nonatomic, assign) BOOL isCustomAmplitude;

@end

@implementation WaveView


- (void)setWaveViewType:(WaveViewType)waveViewType {
    
    _waveViewType = waveViewType;
    
    if(_waveViewType == 2 || _waveViewType == 3) {
        _waveWidth = self.bounds.size.height;
    }
    
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    
    _waveWidth = frame.size.width;
    
    if(_waveViewType == 2 || _waveViewType == 3) {
        _waveWidth = frame.size.height;
    }
    
    if (_waveWidth > 0) {
        _waveCycle = 1.29 * M_PI / _waveWidth;
    }
    
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.layer.masksToBounds = YES;
        [self setupProperty];
        [self startWave];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.layer.masksToBounds = YES;
        [self setupProperty];
        [self startWave];
    }
    return self;
}

- (void)setupProperty
{
    _firsetWaveColor = [UIColor colorWithRed:99 / 256.0 green:229 / 256.0 blue:189 / 256.0 alpha:1];
    _secondWaveColor = [UIColor colorWithRed:153 / 256.0 green:244 / 256.0 blue:226 / 256.0 alpha:1];
    
    _offset = 0;
    _waveSpeed = -1;
    
    _variable = 1.6;
    _isIncrease = NO;
    
    _isDouble = NO;
    _isMutable = NO;
    _isWaving = NO;
    _isCustomAmplitude = NO;

    _waveViewType = WaveViewTypeDefault;

}

- (void)setFirsetWaveColor:(UIColor *)firsetWaveColor {
    _firsetWaveColor = firsetWaveColor;
    _firstWaveLayer.fillColor = firsetWaveColor.CGColor;
}

- (void)setSecondWaveColor:(UIColor *)secondWaveColor {
    _secondWaveColor = secondWaveColor;
    _secondWaveLayer.fillColor = secondWaveColor.CGColor;
}

- (void)startWave {
    
    if(_isWaving) {
        [self stopWave];
    }
    
    _isWaving = YES;
    
    if(_firstWaveLayer == nil) {
        _firstWaveLayer = [CAShapeLayer layer];
        _firstWaveLayer.fillColor = _firsetWaveColor.CGColor;
        [self.layer addSublayer:_firstWaveLayer];
    }
    
    if(_secondWaveLayer == nil) {
        _secondWaveLayer = [CAShapeLayer layer];
        _secondWaveLayer.fillColor = _secondWaveColor.CGColor;
        [self.layer insertSublayer:_secondWaveLayer atIndex:0];
    }
    
    if(_waveDisplayLink == nil) {
        
        _waveDisplayLink = [CADisplayLink displayLinkWithTarget:[TargetWeakProxy proxyWithTarget:self] selector:@selector(getCurrentWave)];
            
        [_waveDisplayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
        
    }
}

- (void)getCurrentWave {
    
    [self waveSetVariable];
    
    _offset += _waveSpeed / 60;
    
    [self drawWaveSinPathInLayer:_firstWaveLayer];
    
    if(_isDouble) {

        [self drawWaveCosPathInLayer:_secondWaveLayer];
        
    }
}

- (void)drawWaveSinPathInLayer:(CAShapeLayer *)shapeLayer {
    
    CGMutablePathRef path = CGPathCreateMutable();
    
    CGFloat x = 0.0;
    CGFloat y = 0.0;
    
    // 和type有关了
    switch (_waveViewType) {
        case 0:
            
            CGPathMoveToPoint(path, nil, x, y);
            
            for ( ; x <= self.bounds.size.width; x++) {
                
                y = _waveAmplitude / 2 * sinf(_waveCycle * x + _offset) + _waveAmplitude / 2;
                
                CGPathAddLineToPoint(path, nil, x, y);
                
            }
            
            CGPathAddLineToPoint(path, nil, self.bounds.size.width, self.bounds.size.height);
            CGPathAddLineToPoint(path, nil, 0, self.bounds.size.height);
            
            break;
        case 1:
            
            // 底部情况
            y = self.bounds.size.height - _waveAmplitude / 2;
            
            CGPathMoveToPoint(path, nil, x, y);
            
            for ( ; x <= self.bounds.size.width; x++) {
                
                y = _waveAmplitude / 2 * sinf(_waveCycle * x + _offset) + self.bounds.size.height - _waveAmplitude / 2;
                
                CGPathAddLineToPoint(path, nil, x, y);
                
            }
            
            CGPathAddLineToPoint(path, nil, self.bounds.size.width, 0);
            CGPathAddLineToPoint(path, nil, 0, 0);
            
            break;
        case 2:
            
            // y变化， x不变, 左侧状态
            CGPathMoveToPoint(path, nil, x, y);
            
            for ( ; y <= self.bounds.size.height; y++) {
                
                x =  _waveAmplitude / 2 * sinf(_waveCycle * y + _offset) + _waveAmplitude / 2;
                
                CGPathAddLineToPoint(path, nil, x, y);
            }
            
            CGPathAddLineToPoint(path, nil, self.bounds.size.width, self.bounds.size.height);
            CGPathAddLineToPoint(path, nil, self.bounds.size.width, 0);
            
            break;
        case 3:
            
            // y变化， x不变, 右侧状态
            x = self.bounds.size.width - _waveAmplitude / 2;
            
            CGPathMoveToPoint(path, nil, x, y);
            
            for ( ; y <= self.bounds.size.height; y++) {
                
                x =  _waveAmplitude / 2 * sinf(_waveCycle * y + _offset) + self.bounds.size.width - _waveAmplitude / 2;
                
                CGPathAddLineToPoint(path, nil, x, y);
            }
            
            CGPathAddLineToPoint(path, nil, 0, self.bounds.size.height);
            CGPathAddLineToPoint(path, nil, 0, 0);
            
            break;
        default:
            break;
    }
    
    
    // 结束和type有关的代码
    
    CGPathCloseSubpath(path);
    
    shapeLayer.path = path;
    
    CGPathRelease(path);

}

- (void)drawWaveCosPathInLayer:(CAShapeLayer *)shapeLayer {
    
    CGMutablePathRef path = CGPathCreateMutable();
    
    CGFloat x = 0.0;
    CGFloat y = 0.0;
    
    // 和type有关了
    switch (_waveViewType) {
        case 0:
            
            CGPathMoveToPoint(path, nil, x, y);
            
            for ( ; x <= self.bounds.size.width; x++) {
                
                y = _waveAmplitude / 2 * cosf(_waveCycle * x + _offset) + _waveAmplitude / 2;
                
                CGPathAddLineToPoint(path, nil, x, y);
                
            }
            
            CGPathAddLineToPoint(path, nil, self.bounds.size.width, self.bounds.size.height);
            CGPathAddLineToPoint(path, nil, 0, self.bounds.size.height);
            
            break;
        case 1:
            
            // 底部情况
            y = self.bounds.size.height - _waveAmplitude / 2;
            
            CGPathMoveToPoint(path, nil, x, y);
            
            for ( ; x <= self.bounds.size.width; x++) {
                
                y = _waveAmplitude / 2 * cosf(_waveCycle * x + _offset) + self.bounds.size.height - _waveAmplitude / 2;
                
                CGPathAddLineToPoint(path, nil, x, y);
                
            }
            
            CGPathAddLineToPoint(path, nil, self.bounds.size.width, 0);
            CGPathAddLineToPoint(path, nil, 0, 0);
            
            break;
        case 2:
            
            // y变化， x不变, 左侧状态
            CGPathMoveToPoint(path, nil, x, y);
            
            for ( ; y <= self.bounds.size.height; y++) {
                
                x =  _waveAmplitude / 2 * cosf(_waveCycle * y + _offset) + _waveAmplitude / 2;
                
                CGPathAddLineToPoint(path, nil, x, y);
            }
            
            CGPathAddLineToPoint(path, nil, self.bounds.size.width, self.bounds.size.height);
            CGPathAddLineToPoint(path, nil, self.bounds.size.width, 0);
            
            break;
        case 3:
            
            // y变化， x不变, 右侧状态
            x = self.bounds.size.width - _waveAmplitude / 2;
            
            CGPathMoveToPoint(path, nil, x, y);
            
            for ( ; y <= self.bounds.size.height; y++) {
                
                x =  _waveAmplitude / 2 * cosf(_waveCycle * y + _offset) + self.bounds.size.width - _waveAmplitude / 2;
                
                CGPathAddLineToPoint(path, nil, x, y);
            }
            
            CGPathAddLineToPoint(path, nil, 0, self.bounds.size.height);
            CGPathAddLineToPoint(path, nil, 0, 0);
            
            break;
        default:
            break;
    }
    
    
    // 结束和type有关的代码
    
    CGPathCloseSubpath(path);
    
    shapeLayer.path = path;
    
    CGPathRelease(path);
    
}

- (void)waveSetVariable {
    
    if(_isIncrease) {
        _variable += 0.01;
    } else {
        _variable -= 0.01;
    }
    
    if(_variable <= 1) {
        _isIncrease = YES;
    }
    
    if(_variable >= 1.6) {
        _isIncrease = NO;
    }
    
    if(_isCustomAmplitude == NO) {
        
        if(_isMutable) {
            _waveAmplitude = _variable * 5 * 2;
        } else {
            _waveAmplitude = 1.6 * 5 * 2;
        }
        
    }
}

- (void)setWaveAmplitude:(CGFloat)waveAmplitude {
    _waveAmplitude = waveAmplitude;
    
    if(waveAmplitude == -1) {
        _isCustomAmplitude = NO;
    }else {
        _isCustomAmplitude = YES;
    }
}

- (void)stopWave {
    
    _isWaving = NO;
    
    if(_waveDisplayLink) {
        [_waveDisplayLink invalidate];
        _waveDisplayLink = nil;
    }
    
    if(_firstWaveLayer) {
        [_firstWaveLayer removeFromSuperlayer];
        _firstWaveLayer = nil;
    }
    
    if(_secondWaveLayer) {
        [_secondWaveLayer removeFromSuperlayer];
        _secondWaveLayer = nil;
    }
}

- (void)setIsDouble:(BOOL)isDouble {
    _isDouble = isDouble;
    
    if(isDouble == NO) {
        _secondWaveLayer.fillColor = [UIColor clearColor].CGColor;
    } else {
        _secondWaveLayer.fillColor = self.secondWaveColor.CGColor;
    }
    
}

@end
