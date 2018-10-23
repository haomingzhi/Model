//
//  MyToast.m
//  MiniClient
//
//  Created by apple on 14-7-10.
//  Copyright (c) 2014年 SunnadaSoft. All rights reserved.
//

#import "MyToast.h"

@interface MyToastProxy : NSProxy

@property(nonatomic) NSMutableArray *invocations;

-(id)init;

-(void)loadInvocations:(MyToast*)toast;

@end

@implementation MyToastProxy

-(id)init
{
    _invocations = [[NSMutableArray alloc] init];
    return self;
}

//这里的从定向就是增加对方法调用的持有，因此没有真正实现从定向。
-(void)forwardInvocation:(NSInvocation *)anInvocation;
{
    // tell the invocation to retain arguments
    
    [anInvocation retainArguments];
    
    // add the invocation to the array
    [self.invocations addObject:anInvocation];
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    return [MyToast instanceMethodSignatureForSelector:aSelector];
}

-(void)loadInvocations:(MyToast*)toast
{
    for (NSInvocation *invocation in self.invocations) {
        [invocation setTarget:toast];
        [invocation invoke];
    }
}

@end

@interface MyToast()

-(void)handleDestroy:(UILabel*)label;

@end

@implementation MyToast

#pragma mark -- Public Method

+(MyToast*)toast
{
    return [[MyToast alloc] init];
}

-(id)init
{
    self = [super init];
    if (self != nil)
    {
        _timeInterval = 1.0;
        
        //这里视图初始化后调用loadInvocations实现将代理的属性调用转化为真实的对象的属性设置。
        [((MyToastProxy*)[MyToast appearance]) loadInvocations:self];
    }
    
    return self;
}

-(void)show:(NSString *)text
{
    return [self show:text atPosition:CGPointZero];
}
-(void)show:(NSString*)text withTextColor:(UIColor *)color
{
    self.labelLayer.foregroundColor = color.CGColor;
    [self show:text atPosition:CGPointZero];
}

//在某个位置显示这里的pt是基于Window坐标
-(void)show:(NSString *)text atPosition:(CGPoint)pt
{
    //创建一个视图，然后查找当前最顶端的可视窗口，然后显示特定的时候后销毁。
    UILabel *label =  [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 1, 1)];
    _labelLayer = nil;
    label.textColor = _labelLayer != nil ? [UIColor colorWithCGColor:self.labelLayer.foregroundColor] : [UIColor whiteColor];
//    label.layer.borderWidth = _labelLayer != nil ? self.labelLayer.borderWidth :1;
//    label.layer.borderColor = _labelLayer != nil ? self.labelLayer.borderColor : [UIColor blackColor].CGColor;
    label.layer.cornerRadius = _labelLayer != nil ? self.labelLayer.cornerRadius : 6;
    label.layer.masksToBounds = YES;
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = _labelLayer != nil ?  [UIColor colorWithCGColor:self.labelLayer.backgroundColor] : [UIColor blackColor];
    label.font =  _labelLayer != nil ? [UIFont fontWithName:_labelLayer.font size:_labelLayer.fontSize]: [UIFont systemFontOfSize:15];
    
    
    
    
    [label setText:text];
    label.alpha = 0;
    
    NSArray *winArr = [UIApplication sharedApplication].windows;
    int count = winArr.count;
    for (int i = count - 1; i >= 0; i--)
    {
        UIWindow *win = [winArr objectAtIndex:i];
        if (win.alpha != 0 && ![win isMemberOfClass:NSClassFromString(@"SVProgressHUDWindow")])
        {
            //根据文字的宽度设置文本框的宽度.
            CGSize sz = [text size:label.font constrainedToSize:CGSizeMake(260, MAXFLOAT)];
            sz.width += 10;
            sz.height += 10;
            CGRect winRect = win.bounds;
            
            if (__CGPointEqualToPoint(pt, CGPointZero))
            {
                pt.x = (winRect.size.width - sz.width)/2 - 10;
                pt.y = (winRect.size.height- sz.height)/2;
            }
            else
            {
                pt.x -= (sz.width + 10)/2;
            }
            label.numberOfLines = 0;
            label.frame = CGRectMake(pt.x, pt.y, sz.width + 10, sz.height + 10);
            //[label autoRelayout];
            [win addSubview:label];
            break;
        }
        
    }
    
    //执行动画。。
    [UIView animateWithDuration:0.3 animations:^{
        
        label.alpha = 1.0;
        
    } completion:^(BOOL finished){
        
        label.alpha = 1.0;
        [self performSelector:@selector(handleDestroy:) withObject:label afterDelay:self.timeInterval];
        
    }];

}

-(void)show:(NSString *)text underView:(UIView*)underView offsetPosition:(CGPoint)offsetPosition
{
    CGRect rect = [underView convertRect:underView.bounds toView:underView.window];
    CGPoint pt =  CGPointMake(CGRectGetMidX(rect)+offsetPosition.x, CGRectGetMaxY(rect) + offsetPosition.y);
    
    [self show:text atPosition:pt];
    
}

#pragma mark -- UIAppearance

//appearance的实现是一个NSProxy代理的实现，代理的作用并不是对象的实体，也就是说对一个代理对象可以调用任何已经存在的方法。但同时也要求我们在请求的时候需要处理具体的
//调用。因此一个NSProxy的派生类必须实现methodSignatureForSelector，forwardInvocation两个函数。在对代理对象调用某个方法时会首先调用函数methodSignatureForSelector
//得到方法的签名，因此需要在methodSignatureForSeletor中调用实体类的instanceMethodSignatureForSelector函数来告诉某个方法签名，否则就会返回异常。
//当得到方法的签名后，就会调用代理的forwardInvocation函数来将代理的方法从定向到具体的实体对象中去，因此需要在forwardInvocation中要实现到具体对象的调用中去。

+ (instancetype)appearance
{
    static MyToastProxy *proxy = nil;
    
    if (proxy == nil)
    {
        proxy = [[MyToastProxy alloc] init];
    }
    return (MyToast*)proxy;
}


+ (instancetype)appearanceWhenContainedIn:(Class <UIAppearanceContainer>)ContainerClass, ...
{
    return [self appearance];
}


    
#pragma mark -- handle Method
    
-(void)handleDestroy:(UILabel*)label
{
    [UIView animateWithDuration:0.2 animations:^{
        
        label.alpha = 0.0;
        
    } completion:^(BOOL finished){
        
        [label removeFromSuperview];
        
    }];
}

@end
