//
//  UIView+Animation.m
//  MiniClient
//
//  Created by Apple on 14-12-23.
//  Copyright (c) 2014年 SunnadaSoft. All rights reserved.
//

#import "UIView+Animation.h"

@implementation UIView (Animation)

//视图平移
-(void)translation:(CGPoint)point animationDuration:(NSTimeInterval)duration
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:duration];
    self.transform = CGAffineTransformMakeTranslation(point.x,point.y);
    [UIView commitAnimations];
}
//淡入淡出，sx,sy 长宽缩放比例，duration 动画时长
-(void)curveEaseInOut:(CGFloat) sx  scaleSy:(CGFloat) sy animationDuration:(NSTimeInterval)duration
{
    [UIView animateWithDuration:duration
                     animations:^{
                         //[UIView beginAnimations:nil context:nil];
                         //[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut]; //InOut 表示进入和出去时都启动动画
                         //[UIView setAnimationDuration:duration];//动画时间
                         self.transform=CGAffineTransformMakeScale(sx, sy);//先让要显示的view最小直至消失
                         //[UIView commitAnimations]; //启动动画
                         
                     }
                     completion:^(BOOL finished){
                         if (finished) {
                             [UIView animateWithDuration:duration
                                              animations:^{
                                                  self.transform=CGAffineTransformIdentity;
                                              }
                                              completion:NULL];
                         }
                         
                     }];
}


//旋转
-(void)rotation:(CGFloat)angle animationDuration:(NSTimeInterval)duration repeatCount:(CGFloat)count
{
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: angle ];
    [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    rotationAnimation.duration = duration;
    rotationAnimation.repeatCount = count;//你可以设置到最大的整数值
    rotationAnimation.cumulative = NO;
    rotationAnimation.removedOnCompletion = NO;
    rotationAnimation.fillMode = kCAFillModeForwards;
    [self.layer addAnimation:rotationAnimation forKey:@"Rotation"];
}


///渐变动画
+(void)gradient:(UIView *) backgroundView textView:(UIView *) textView
{
    [UIView gradient:@[(id)[UIColor blackColor].CGColor,(id)[UIColor whiteColor].CGColor,(id)[UIColor blackColor].CGColor] locations:@[@(0.2), @(0.5), @(0.8)] backgroundView:backgroundView textView:textView];
}
///渐变动画
+(void)gradient:(NSArray *) colors locations:(NSArray *)locations  backgroundView:(UIView *) backgroundView textView:(UIView *) textView
{
    CAGradientLayer *gradientLayer =  [[CAGradientLayer alloc] init];
    gradientLayer.bounds = backgroundView.bounds;
    gradientLayer.position = CGPointMake(backgroundView.frame.size.width/2, backgroundView.frame.size.height/2);
    gradientLayer.startPoint = CGPointMake(0, 0.5);
    gradientLayer.endPoint = CGPointMake(1,0.5);
    gradientLayer.colors = colors;
    gradientLayer.locations = locations;// @[@(0.2), @(0.5), @(0.8)];
    [backgroundView.layer addSublayer:gradientLayer];
    
    CABasicAnimation* gradient = [CABasicAnimation animationWithKeyPath:@"locations"];
    gradient.fromValue = @[@(0), @(0), @(0.25)];
    gradient.toValue = @[@(0.75), @(1), @(1)];
    gradient.duration = 2.5;
    gradient.repeatCount = MAXFLOAT;
    [gradientLayer addAnimation:gradient forKey: nil];
    gradientLayer.mask = textView.layer;
}

///画笔动画
+(void)strokeAnimation:(UIView *) view
{
    CAShapeLayer *ovalShapeLayer = [[CAShapeLayer alloc] init];
    ovalShapeLayer.strokeColor = [UIColor whiteColor].CGColor;
    ovalShapeLayer.fillColor = [UIColor clearColor].CGColor;
    ovalShapeLayer.lineWidth = 7;
    
    CGFloat anotherOvalRadius = view.frame.size.height/2 * 0.8;
    ovalShapeLayer.path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(view.frame.size.width/2 - anotherOvalRadius, view.frame.size.height/2 - anotherOvalRadius, anotherOvalRadius * 2, anotherOvalRadius * 2)].CGPath;
    ovalShapeLayer.lineCap = kCALineCapRound;
    ovalShapeLayer.strokeEnd = 0.4;
    [view.layer addSublayer:ovalShapeLayer];
    
    CABasicAnimation* strokeStartAnimate = [CABasicAnimation animationWithKeyPath: @"strokeStart"];
    strokeStartAnimate.fromValue = @(-0.5);
    strokeStartAnimate.toValue = @(1);
    
    CABasicAnimation* strokeEndAnimate = [CABasicAnimation animationWithKeyPath: @"strokeEnd"];
    strokeEndAnimate.fromValue = @(0.0);
    strokeEndAnimate.toValue = @(1);
    
    CAAnimationGroup *strokeAnimateGroup = [[CAAnimationGroup alloc] init];
    strokeAnimateGroup.duration = 1.5;
    strokeAnimateGroup.repeatCount = MAXFLOAT;
    strokeAnimateGroup.animations = @[strokeStartAnimate, strokeEndAnimate];
    [ovalShapeLayer addAnimation:strokeAnimateGroup forKey: nil];
    
}

//http://www.devtalking.com/articles/calayer-animation-replicator-animation/
+(void) replicatorAnimation:(UIView *) view
{
    CAReplicatorLayer * replicatorLayer = [[CAReplicatorLayer alloc] init];
    replicatorLayer.bounds = CGRectMake( view.frame.origin.x,  view.frame.origin.y,  view.frame.size.width,  view.frame.size.height);
    replicatorLayer.anchorPoint = CGPointMake(0, 0);
    replicatorLayer.backgroundColor = [UIColor lightGrayColor].CGColor;//view.backgroundColor.CGColor;
    [view.layer addSublayer:replicatorLayer];
    
    CALayer *rectangle = [[CALayer alloc] init];
    rectangle.bounds = CGRectMake(0, 0,  30,  90);
    rectangle.anchorPoint = CGPointMake(0, 0);
    rectangle.position = CGPointMake(view.frame.origin.x + 10,  view.frame.origin.y + 80);
    rectangle.cornerRadius = 2;
    rectangle.backgroundColor = [UIColor whiteColor].CGColor;
    [replicatorLayer addSublayer:rectangle];
    replicatorLayer.instanceCount = 3;
    replicatorLayer.instanceTransform = CATransform3DMakeTranslation(40, 0, 0);
    replicatorLayer.instanceDelay = 0.3;
    replicatorLayer.masksToBounds = true;
    
    CABasicAnimation *moveRectangle = [CABasicAnimation animationWithKeyPath:@"position.y"];
    moveRectangle.toValue = @(rectangle.position.y - 70);
    moveRectangle.duration = 0.7;
    moveRectangle.autoreverses = true;
    moveRectangle.repeatCount = MAXFLOAT;
    [rectangle addAnimation:moveRectangle forKey: nil];
}


@end
