//
//  ViewController.m
//  MySlideMenu
//
//  Created by apple on 14-10-10.
//  Copyright (c) 2014年 SunnadaSoft. All rights reserved.
//

#import "MySlideMenu.h"

#ifndef COVERTBUTTON_TAG
#define COVERTBUTTON_TAG 20141011
#define SIDE_MAXSCALE  1.2
#define CENTER_MAXSCALE 0.8
#endif

const NSString * kSlideMenuStateCenter  = @"kSlideMenuStateCenter";
const NSString * kSlideMenuStateLeft  = @"kSlideMenuStateLeft";
const NSString * kSlideMenuStateRight  = @"kSlideMenuStateRight";
const NSString * kSlideMenuStateStyle  = @"kSlideMenuStateStyle";
const NSString * kSlideMenuStateDelegate = @"kSlideMenuStateDelegate";

//视图控制器滑动方向
@interface ViewControllerSlideDirection : NSObject

@property(nonatomic, weak) UIViewController *viewController;
@property(nonatomic) int direction;

@end


@implementation ViewControllerSlideDirection

@end

//视图控制器滑动方向栈
@interface ViewControllerSlideDirectionStack : NSObject

@property(nonatomic) NSMutableArray *stack;

//栈顶，如果无则返回NULL
@property(nonatomic, readonly) ViewControllerSlideDirection *top;

@property(nonatomic,readonly) NSInteger count;

//压入栈顶,或者弹出栈，保证唯一
-(void)setSlideDirection:(UIViewController*)vc direction:(int)direction;




@end


@implementation ViewControllerSlideDirectionStack

-(id)init
{
    self = [super init];
    if (self != nil) {
        
        _stack = [[NSMutableArray alloc] init];
    }
    
    return self;
}

-(void)setSlideDirection:(UIViewController *)vc direction:(int)direction
{
    if (vc == nil)
        return;
    
    //从后到前遍历。
    NSInteger count = _stack.count;
    for (NSInteger i = count - 1; i >= 0; i--)
    {
        
        ViewControllerSlideDirection *vcdir = [_stack objectAtIndex:i];
        
        //如果视图控制器销毁了则删除掉在栈里的引用
        if (vcdir.viewController == nil)
        {
            [_stack removeObjectAtIndex:i];
            continue;
        }
        
        //如果是等于当前的则也删除掉，并移到最后面去。
        if (vcdir.viewController == vc)
        {
            [_stack removeObjectAtIndex:i];
            continue;
        }
    }
    
    if (direction != SLIDEMENU_FREEZING)
    {
        ViewControllerSlideDirection *vcdir = [[ViewControllerSlideDirection alloc] init];
        vcdir.viewController = vc;
        vcdir.direction = direction;
        [_stack addObject:vcdir];
    }
}

-(ViewControllerSlideDirection*)top
{
    NSInteger count = _stack.count;
    for (NSInteger i = count - 1; i >= 0; i--)
    {
        ViewControllerSlideDirection *vcdir = [_stack objectAtIndex:i];
        if (vcdir.viewController == nil)
        {
            [_stack removeObjectAtIndex:i];
            continue;
        }
    }
    
    if (_stack.count == 0)
        return nil;
    
    return _stack.lastObject;
    
}

-(NSInteger)count
{
    NSInteger count = _stack.count;
    for (NSInteger i = count - 1; i >= 0; i--)
    {
        ViewControllerSlideDirection *vcdir = [_stack objectAtIndex:i];
        if (vcdir.viewController == nil)
        {
            [_stack removeObjectAtIndex:i];
            continue;
        }
    }
    
    return _stack.count;
}

@end


@interface MySlideMenu ()<UIGestureRecognizerDelegate>

//视图控制器方向控制数组
@property(nonatomic) ViewControllerSlideDirectionStack *stack;
@property(nonatomic) UIPanGestureRecognizer *panGesture;
@property(nonatomic) CGPoint startSlidePoint;
@property(nonatomic) NSMutableArray *stateStack;   //状态栈，里面的元素是NSDictory。分别对应3个KEY，中间的，样式，左边的，右边的

@end

@implementation MySlideMenu
{
    NSInteger specifityWidth;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    specifityWidth = NSNotFound;
    [self addChildViewController:_centerVC];
    if (_leftVC != nil)
        [self addChildViewController:_leftVC];
    if (_rightVC != nil)
        [self addChildViewController:_rightVC];
    
    //为中间的视图加上左滑和又滑的事件。
    [self.view addSubview:_centerVC.view];
    _centerVC.view.frame = self.view.bounds;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setLeftVC:(UIViewController *)leftVC
{
    if (self == nil)
        return;
    
    if (_leftVC == leftVC)
        return;
    
    BOOL hasShowLeftView = NO;
    if (_leftVC != nil)
    {
        if (_leftVC.isViewLoaded)
        {
            hasShowLeftView = _leftVC.view.superview != nil;
            
            if (hasShowLeftView)
            {
                [_leftVC.view removeFromSuperview];
                _leftVC.view = nil;
            }
        }
        
        [_leftVC removeFromParentViewController];
    }
    
    _leftVC = leftVC;
    if (_leftVC != nil)
    {
        [self addChildViewController:_leftVC];
        
        if (hasShowLeftView)
        {
            [self.view insertSubview:_leftVC.view belowSubview:_centerVC.view];
            _leftVC.view.frame = self.view.bounds;
        }
    }
}

-(void)setRightVC:(UIViewController *)rightVC
{
    if (self == nil)
        return;
    
    if (_rightVC == rightVC)
        return;
    
    BOOL hasShowRightView = NO;
    if (_rightVC != nil)
    {
        if (_rightVC.isViewLoaded)
        {
            hasShowRightView = _rightVC.view.superview != nil;
            
            if (hasShowRightView)
            {
                [_rightVC.view removeFromSuperview];
                _rightVC.view = nil;
            }
        }
        
        [_rightVC removeFromParentViewController];
    }
    
    _rightVC = rightVC;
    if (_rightVC != nil)
    {
        [self addChildViewController:_rightVC];
        
        if (hasShowRightView)
        {
            [self.view insertSubview:_rightVC.view belowSubview:_centerVC.view];
            _rightVC.view.frame = self.view.bounds;
        }
    }

}

-(void)setCenterVC:(UIViewController *)centerVC
{
    if (self == nil) {
        return;
    }
    
    
    if (_centerVC == centerVC)
        return;
    
    BOOL hasShowCenterView = NO;
    if (_centerVC != nil)
    {
        if (_centerVC.isViewLoaded)
        {
            hasShowCenterView = _centerVC.view.superview != nil;
            
            if (hasShowCenterView)
            {
                [_centerVC.view removeFromSuperview];
                _centerVC.view = nil;
            }
        }
        
        [_centerVC removeFromParentViewController];
    }
    
    _centerVC = centerVC;
    if (_centerVC != nil)
    {
        [self addChildViewController:_centerVC];
        
        if (hasShowCenterView)
        {
            [self.view addSubview:_centerVC.view];
            _centerVC.view.frame = self.view.bounds;
        }
    }

}


-(id)initWithCenterVC:(UIViewController*)centerVC
               leftVC:(UIViewController*)leftVC
              rightVC:(UIViewController*)rightVC
{
    self = [self init];
    if (self != nil)
    {
        _centerVC = centerVC;
        _leftVC = leftVC;
        _rightVC = rightVC;
        _status = SLIDEMENU_NORMAL;
        _style = SLIDEMENU_SCALESTYLE;
        _panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:)];
        _panGesture.delegate = self;
        _panGesture.maximumNumberOfTouches = 1;
        _startSlidePoint = CGPointZero;
        _stateStack = [[NSMutableArray alloc] init];
    
        
        _stack = [[ViewControllerSlideDirectionStack alloc] init];
        
    }
    
    return self;
}

-(void)presentLeft
{
    if (self == nil)
        return;
    
    [self presentSideHelper:_leftVC direction:SLIDEMENU_RIGHTDIRECTION];
}

-(void)hideLeft
{
    if (self == nil) {
        return;
    }
    
    [self hideSideHelper:_leftVC status:SLIDEMENU_LEFTPRESENT];
}

-(void)presentRight
{
    [self presentRightSpecifityWidth:NSNotFound];
}

-(void)presentRightSpecifityWidth:(NSInteger)width
{
    if (self == nil)
        return;
    specifityWidth = width;
    [self presentSideHelper:_rightVC direction:SLIDEMENU_LEFTDIRECTION];
    specifityWidth = NSNotFound;
}

-(void)hideRight
{
    if (self == nil)
        return;
    
    [self hideSideHelper:_rightVC status:SLIDEMENU_RIGHTPRESENT];
}


- (void)presentCenterScaleHelper
{
    if (self == nil)
        return;
    
    if (_stack.count > 0)
        [self.view addGestureRecognizer:_panGesture];
    
    [self removeCovertButton];
    
    if (_status == SLIDEMENU_NORMAL)
        return;
    
    
    if (_rightVC != nil && _rightVC.isViewLoaded && _rightVC.view.superview != nil)
    {
        [self callWillHiddenDelegate:_rightVC status:SLIDEMENU_RIGHTPRESENT];
    }
    
    if (_leftVC != nil && _leftVC.isViewLoaded && _leftVC.view.superview != nil)
    {
        [self callWillHiddenDelegate:_leftVC status:SLIDEMENU_LEFTPRESENT];
        
    }
    
    
    [UIView animateWithDuration:0.3 animations:^{
        
        if (_rightVC != nil && _rightVC.isViewLoaded && _rightVC.view.superview != nil)
            _rightVC.view.transform = CGAffineTransformMakeScale(SIDE_MAXSCALE, SIDE_MAXSCALE);
        
        if (_leftVC != nil && _leftVC.isViewLoaded && _leftVC.view.superview != nil)
            _leftVC.view.transform = CGAffineTransformMakeScale(SIDE_MAXSCALE, SIDE_MAXSCALE);
        
        _centerVC.view.transform = CGAffineTransformIdentity;
        
    } completion:^(BOOL finished){
        
        _status = SLIDEMENU_NORMAL;
        
        if (_rightVC != nil && _rightVC.isViewLoaded && _rightVC.view.superview != nil)
        {
            _rightVC.view.transform = CGAffineTransformIdentity;
            [_rightVC.view removeFromSuperview];
            
            [self callDidHiddenDelegate:_rightVC status:SLIDEMENU_RIGHTPRESENT];
            
            _rightVC.view = nil;
        }
        
        if (_leftVC != nil && _leftVC.isViewLoaded && _leftVC.view.superview != nil)
        {
            _leftVC.view.transform = CGAffineTransformIdentity;
            [_leftVC.view removeFromSuperview];
            
            [self callDidHiddenDelegate:_leftVC status:SLIDEMENU_LEFTPRESENT];
            
            _leftVC.view = nil;
        }
        
        
    }];
}


- (void)presentCenterCoverHelper
{
    if (self == nil)
        return;
    
    if (_stack.count > 0)
        [self.view addGestureRecognizer:_panGesture];
    
  
    
    if (_status == SLIDEMENU_NORMAL)
        return;
    
    
    if (_rightVC != nil && _rightVC.isViewLoaded && _rightVC.view.superview != nil)
    {
        [self callWillHiddenDelegate:_rightVC status:SLIDEMENU_RIGHTPRESENT];
    }
    
    if (_leftVC != nil && _leftVC.isViewLoaded && _leftVC.view.superview != nil)
    {
        [self callWillHiddenDelegate:_leftVC status:SLIDEMENU_LEFTPRESENT];
        
    }
    
    
    [UIView animateWithDuration:0.3 animations:^{
        
        if (_rightVC != nil && _rightVC.isViewLoaded && _rightVC.view.superview != nil)
            _rightVC.view.transform = CGAffineTransformMakeTranslation(self.view.bounds.size.width, 0);
        
        if (_leftVC != nil && _leftVC.isViewLoaded && _leftVC.view.superview != nil)
            _leftVC.view.transform = CGAffineTransformMakeTranslation(-1 * self.view.bounds.size.width, 0);
        
    } completion:^(BOOL finished){
        
        _status = SLIDEMENU_NORMAL;
        
        if (_rightVC != nil && _rightVC.isViewLoaded && _rightVC.view.superview != nil)
        {
            _rightVC.view.transform = CGAffineTransformIdentity;
            [_rightVC.view removeFromSuperview];
            
            [self callDidHiddenDelegate:_rightVC status:SLIDEMENU_RIGHTPRESENT];
            
            _rightVC.view = nil;
        }
        
        if (_leftVC != nil && _leftVC.isViewLoaded && _leftVC.view.superview != nil)
        {
            _leftVC.view.transform = CGAffineTransformIdentity;
            [_leftVC.view removeFromSuperview];
            
            [self callDidHiddenDelegate:_leftVC status:SLIDEMENU_LEFTPRESENT];
            
            _leftVC.view = nil;
        }
        
        
         [self removeCovertButton];
        
        
    }];
}


-(void)presentCenter
{
    
    if (_style == SLIDEMENU_SCALESTYLE)
    {
        [self presentCenterScaleHelper];
    }
    else
    {
        [self presentCenterCoverHelper];
    }
    
    

}

-(void)setSlidable:(UIViewController*)viewController direction:(int)direction
{
    //保证为空也不会出错。
    if (self == nil)
        return;
    
    [_stack setSlideDirection:viewController direction:direction];
    if (_stack.count == 0)
        [self.view removeGestureRecognizer:_panGesture];
    else
        [self.view addGestureRecognizer:_panGesture];
}

//保存滑动菜单栈。也就是保护中间，左边，右边，和样式
-(void)saveSlideStack
{
    //保护中间。
    NSDictionary *dict = @{kSlideMenuStateCenter:_centerVC == nil ? [NSNull null] : _centerVC,
                           kSlideMenuStateLeft:_leftVC == nil ? [NSNull null] : _leftVC,
                           kSlideMenuStateRight:_rightVC == nil ? [NSNull null] : _rightVC,
                           kSlideMenuStateDelegate:_delegate == nil ? [NSNull null] : [[BSWeakObject alloc] initWithObject:_delegate],
                           kSlideMenuStateStyle:[NSNumber numberWithInteger:_style]};
    
    [_stateStack addObject:dict];
    
}

//恢复滑动菜单栈，恢复中间，左边，右边和样式
-(BOOL)restoreSlideStack
{
    if (_stateStack.count > 0)
    {
        NSDictionary *dict = _stateStack.lastObject;
        
        id cobj = [dict objectForKey:kSlideMenuStateCenter];
        id lobj = [dict objectForKey:kSlideMenuStateLeft];
        id robj = [dict objectForKey:kSlideMenuStateRight];
        id dobj = [dict objectForKey:kSlideMenuStateDelegate];
        id sobj = [dict objectForKey:kSlideMenuStateStyle];
        
        if (cobj == [NSNull null])
            cobj = nil;
        
        if (lobj == [NSNull null])
            lobj = nil;
        if (robj == [NSNull null])
            robj = nil;
        
        if (dobj == [NSNull null])
            dobj = nil;
        else
            dobj = ((BSWeakObject*)dobj).obj;
        
        self.centerVC = cobj;
        self.leftVC = lobj;
        self.rightVC = robj;
        self.delegate = dobj;
        self.style = ((NSNumber*)sobj).intValue;
        
        
        [_stateStack removeLastObject];
        return TRUE;
    }
    return FALSE;
    
}


#pragma mark -- Handle Method
-(void)handleCenterVCReset:(UIButton*)sender
{
    [self presentCenter];
}

-(void)handlePanGesture:(UIPanGestureRecognizer*)gesture
{
    if (gesture.state == UIGestureRecognizerStateBegan)
    {
        _startSlidePoint =  [gesture locationInView:self.view];
    }
    else if (gesture.state == UIGestureRecognizerStateChanged)
    {
        CGPoint pt = [gesture locationInView:self.view];
        CGFloat distance = pt.x - _startSlidePoint.x;
        //检测如果不是横向右滑动则取消掉
        if (fabsf((float)(pt.y - _startSlidePoint.y)) > 50)
        {
            return;
        }
        //右滑出左视图
        if (distance > 0)
        {
            
            //如果栈顶可以左滑
            if ((_stack.top.direction & SLIDEMENU_RIGHTDIRECTION) == SLIDEMENU_RIGHTDIRECTION)
                [self slideVC:_leftVC hideVC:_rightVC distance:distance direction:SLIDEMENU_RIGHTDIRECTION];
            
        }
        else  //左滑出右视图
        {
            if ((_stack.top.direction & SLIDEMENU_LEFTDIRECTION) == SLIDEMENU_LEFTDIRECTION)
                [self slideVC:_rightVC hideVC:_leftVC distance:distance direction:SLIDEMENU_LEFTDIRECTION];
        }
    
    }
    else if (gesture.state == UIGestureRecognizerStateEnded)
    {
        if (_leftVC != nil && _leftVC.isViewLoaded && _leftVC.view.superview != nil)
        {
            
            [self presentSideAnimate:_leftVC direction:SLIDEMENU_RIGHTDIRECTION];
            return;
        }
        
        if (_rightVC != nil && _rightVC.isViewLoaded &&  _rightVC.view.superview != nil)
        {
            [self presentSideAnimate:_rightVC direction:SLIDEMENU_LEFTDIRECTION];
            return;
        }
        
    }
    else
    {
        //其他的都恢复还原
        [self presentCenter];
        
        
    }

}


#pragma mark -- UIGestureRecognizerDelegate

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    
    
    if (_status != SLIDEMENU_NORMAL)
        return NO;
    
    if (_leftVC == nil && _rightVC == nil)
        return NO;
    
    ViewControllerSlideDirection *vcdir = _stack.top;
    if (vcdir == nil)
        return NO;
    
    //取到手势的视图的父视图是不是栈顶里面的子视图，如果是则可以，否则不可以。
    if (!vcdir.viewController.isViewLoaded)
        return NO;
    
    if (![vcdir.viewController.view isDescendantOfView:_centerVC.view])
        return NO;
    
    //如果当前的可滑动的方向和菜单具有的菜单没有交集则返回NO
    BOOL canLeft = ((vcdir.direction & SLIDEMENU_LEFTDIRECTION) == SLIDEMENU_LEFTDIRECTION) && (_rightVC != nil);
    BOOL canRight = ((vcdir.direction & SLIDEMENU_RIGHTDIRECTION) == SLIDEMENU_RIGHTDIRECTION) && (_leftVC != nil);
    
    return canLeft || canRight;
}

/*
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return gestureRecognizer != otherGestureRecognizer;
}
*/

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
 
    //判断只能在边缘滑动其他的位置不处理
    if (touch.phase == UITouchPhaseBegan)
    {
        CGPoint pt = [touch locationInView:self.view];
        if (pt.x > self.view.bounds.origin.x + 30 && pt.x < self.view.bounds.origin.x + self.view.bounds.size.width - 30)
            return NO;
    }
    
    
    
    //不截获UISlider的事件
    if ([touch.view isKindOfClass:[UISlider class]])
    {
        return NO;
    }
    
    //如果发现有其他的手势时优先处理其他的手势，这里不处理自己的手势。
  /*  NSArray *arr = touch.gestureRecognizers;
    
    if (arr == nil)
        return YES;
    
    if (arr.count > 1)
        return NO;
    
    return [arr lastObject] == self.panGesture;
*/
    return YES;
}


#pragma mark -- Private Method

- (void)slideVCScaleHelper:(UIViewController*)slideVC hideVC:(UIViewController*)hideVC distance:(CGFloat)distance direction:(int)direction
{
    
    CGFloat maxOffsetX = self.view.bounds.size.width / 2;
    
    if (distance > maxOffsetX)
        distance = maxOffsetX;
    if (distance < -1 * maxOffsetX)
        distance = -1 * maxOffsetX;
    
    CGFloat absdistance = fabsf((float)distance);
    
    if (hideVC != nil && hideVC.isViewLoaded && hideVC.view.superview != nil)
    {
        [hideVC.view removeFromSuperview];
        hideVC.view = nil;
    }
    
    if (slideVC == nil)
        return;
    
    if (slideVC.view.superview == nil)
    {
        [self.view insertSubview:slideVC.view belowSubview:_centerVC.view];
        slideVC.view.frame = self.view.bounds;
        [self createCovertButton];
        
        [self callWillPresentDelegate:slideVC direction:direction];
    }
    
    
    slideVC.view.transform = CGAffineTransformMakeScale(SIDE_MAXSCALE - (SIDE_MAXSCALE - 1) * absdistance / maxOffsetX,
                                                        SIDE_MAXSCALE - (SIDE_MAXSCALE - 1) * absdistance / maxOffsetX);
    
    CGAffineTransform t1 = CGAffineTransformMakeScale(1 - (1 - CENTER_MAXSCALE) * absdistance / maxOffsetX,
                                                      1 - (1 - CENTER_MAXSCALE) * absdistance / maxOffsetX);
    CGAffineTransform t2 = CGAffineTransformMakeTranslation(distance, 0);
    CGAffineTransform t3 =  CGAffineTransformConcat(t1,t2);
    _centerVC.view.transform = t3;

}

- (void)slideVCCoverHelper:(UIViewController*)slideVC hideVC:(UIViewController*)hideVC distance:(CGFloat)distance direction:(int)direction
{
    
    CGFloat maxOffsetX = self.view.bounds.size.width / 2;
    
    if (distance > maxOffsetX)
        distance = maxOffsetX;
    if (distance < -1 * maxOffsetX)
        distance = -1 * maxOffsetX;
    
    CGFloat absdistance = fabsf((float)distance);
    
    UIButton *btn  = [self createCovertButton];
    
    if (hideVC != nil && hideVC.isViewLoaded && hideVC.view.superview != nil)
    {
        [hideVC.view removeFromSuperview];
        hideVC.view = nil;
    }
    
    if (slideVC == nil)
        return;
    
    if (slideVC.view.superview == nil)
    {
        [self.view addSubview:slideVC.view];
        slideVC.view.frame = self.view.bounds;
        
        slideVC.view.layer.shadowRadius = 3;
        slideVC.view.layer.shadowOffset = CGSizeMake(0, 0);
        slideVC.view.layer.shadowOpacity = 0.5;
        UIBezierPath *path = [UIBezierPath bezierPathWithRect: slideVC.view.layer.bounds];
        slideVC.view.layer.shadowPath = path.CGPath;
        

       
        [self callWillPresentDelegate:slideVC direction:direction];
    }
    
    if (direction == SLIDEMENU_RIGHTDIRECTION)
        slideVC.view.transform = CGAffineTransformMakeTranslation(distance - self.view.bounds.size.width, 0);
    else
        slideVC.view.transform = CGAffineTransformMakeTranslation(self.view.bounds.size.width - absdistance, 0);

    
    
    btn.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5 * absdistance / maxOffsetX];

}


- (void)slideVC:(UIViewController*)slideVC hideVC:(UIViewController*)hideVC distance:(CGFloat)distance direction:(int)direction
{
    
    if (_style == SLIDEMENU_SCALESTYLE)
    {
        [self slideVCScaleHelper:slideVC hideVC:hideVC distance:distance direction:direction];
    }
    else
    {
        [self slideVCCoverHelper:slideVC hideVC:hideVC distance:distance direction:direction];

    }
  }


- (void)presentSideScaleAnimate:(UIViewController*)sideVC direction:(int)direction
{
    CGFloat maxOffsetX = self.view.bounds.size.width / 2;
    if (direction == SLIDEMENU_LEFTDIRECTION)
        maxOffsetX = -1 * maxOffsetX;
    
    
    CGAffineTransform t1 = CGAffineTransformMakeScale(CENTER_MAXSCALE,CENTER_MAXSCALE);
    CGAffineTransform t2 = CGAffineTransformMakeTranslation(maxOffsetX,0);
    CGAffineTransform t3 = CGAffineTransformConcat(t1,t2);
    
    [UIView animateWithDuration:0.3 animations:^{
        
        sideVC.view.transform = CGAffineTransformIdentity;
        _centerVC.view.transform = t3;
        
    } completion:^(BOOL finished){
        
        _status = ((direction == SLIDEMENU_RIGHTDIRECTION) ? SLIDEMENU_LEFTPRESENT : SLIDEMENU_RIGHTPRESENT);
        
        [self.view removeGestureRecognizer:_panGesture];
        
        [self callDidPresentDelegate:sideVC direction:direction];
        
        
    }];

}

- (void)presentSideCoverAnimate:(UIViewController*)sideVC direction:(int)direction
{
    CGFloat maxOffsetX = self.view.bounds.size.width * 0.75;
    if (direction == SLIDEMENU_RIGHTDIRECTION)
        maxOffsetX = -1 * maxOffsetX;
    
    UIButton *btn = [self createCovertButton];
    btn.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    
    
    [UIView animateWithDuration:0.3 animations:^{
        
        sideVC.view.transform = CGAffineTransformMakeTranslation(maxOffsetX,0);
       
        
    } completion:^(BOOL finished){
        
        _status = ((direction == SLIDEMENU_RIGHTDIRECTION) ? SLIDEMENU_LEFTPRESENT : SLIDEMENU_RIGHTPRESENT);
        
        [self.view removeGestureRecognizer:_panGesture];
        
        [self callDidPresentDelegate:sideVC direction:direction];
        
        
    }];

}



- (void)presentSideAnimate:(UIViewController*)sideVC direction:(int)direction
{
    if (_style == SLIDEMENU_SCALESTYLE)
    {
        [self presentSideScaleAnimate:sideVC direction:direction];
    }
    else
    {
        [self presentSideCoverAnimate:sideVC direction:direction];
    }
    
  }


- (void)callWillPresentDelegate:(UIViewController *)vc direction:(int)direction
{
    if (_delegate != nil)
    {
        
        if ([_delegate respondsToSelector:@selector(slideMenuWillPresent:)])
            [_delegate slideMenuWillPresent:self];
        
        //右边展示
        if (direction == SLIDEMENU_LEFTDIRECTION)
        {
            if ([_delegate respondsToSelector:@selector(slideMenu:rightViewControllerWillPresent:)])
                [_delegate slideMenu:self rightViewControllerWillPresent:vc];
        }
        else
        {
            if ([_delegate respondsToSelector:@selector(slideMenu:leftViewControllerWillPresent:)])
                [_delegate slideMenu:self leftViewControllerWillPresent:vc];
        }
    }
}

- (void)callDidPresentDelegate:(UIViewController *)sideVC direction:(int)direction
{
    if (_delegate != nil)
    {
        
        if ([_delegate respondsToSelector:@selector(slideMenuDidPresent:)])
            [_delegate slideMenuDidPresent:self];
        
        //右边展示
        if (direction == SLIDEMENU_LEFTDIRECTION)
        {
            if ([_delegate respondsToSelector:@selector(slideMenu:rightViewControllerDidPresent:)])
                [_delegate slideMenu:self rightViewControllerDidPresent:sideVC];
        }
        else
        {
            if ([_delegate respondsToSelector:@selector(slideMenu:leftViewControllerDidPresent:)])
                [_delegate slideMenu:self leftViewControllerDidPresent:sideVC];
        }
    }
}

- (void)callWillHiddenDelegate:(UIViewController *)sideVC status:(int)status
{
    if (_delegate != nil)
    {
        if ([_delegate respondsToSelector:@selector(slideMenuWillHidden:)])
            [_delegate slideMenuWillHidden:self];
        
        //右边展示
        if (status == SLIDEMENU_RIGHTPRESENT)
        {
            if ([_delegate respondsToSelector:@selector(slideMenu:rightViewControllerWillHidden:)])
                [_delegate slideMenu:self rightViewControllerWillHidden:sideVC];
        }
        else
        {
            if ([_delegate respondsToSelector:@selector(slideMenu:leftViewControllerWillHidden:)])
                [_delegate slideMenu:self leftViewControllerWillHidden:sideVC];
        }
        
    }
}


- (void)callDidHiddenDelegate:(UIViewController *)sideVC status:(int)status
{
    if (_delegate != nil)
    {
        if ([_delegate respondsToSelector:@selector(slideMenuDidHidden:)])
            [_delegate slideMenuWillHidden:self];
        
        //右边展示
        if (status == SLIDEMENU_RIGHTPRESENT)
        {
            if ([_delegate respondsToSelector:@selector(slideMenu:rightViewControllerDidHidden:)])
                [_delegate slideMenu:self rightViewControllerDidHidden:sideVC];
        }
        else
        {
            if ([_delegate respondsToSelector:@selector(slideMenu:leftViewControllerDidHidden:)])
                [_delegate slideMenu:self leftViewControllerDidHidden:sideVC];
        }
        
    }
}
/**
 * 点击了左滑动视图或者右滑动视图的某一个选项
 */
- (void)touchOnDisplay:(UIViewController *) displayVc ViewTag:(NSInteger)tag;
{
    if ([self.delegate respondsToSelector:@selector(slideMenu: SideDisplayed:ViewTag:)])
    {
        [self.delegate slideMenu:self SideDisplayed:displayVc ViewTag:tag];
    }
}


- (void)presentSideScaleHelper:(UIViewController *)vc direction:(int)direction
{
    //删除手势
    [self.view removeGestureRecognizer:_panGesture];
    
    
    if (vc == nil || _status != SLIDEMENU_NORMAL)
        return;
    
    //在当前中间的下面插入一个子视图
    [self.view insertSubview:vc.view belowSubview:_centerVC.view];
    vc.view.frame = self.view.bounds;
    [self createCovertButton];
    
    
    [self callWillPresentDelegate:vc direction:direction];
    
    //左边的做一个放大缩小的效果。
    vc.view.transform = CGAffineTransformMakeScale(SIDE_MAXSCALE, SIDE_MAXSCALE);
    _centerVC.view.transform = CGAffineTransformIdentity;
    
    [self presentSideAnimate:vc direction:direction];
}


- (void)presentSideCoverHelper:(UIViewController *)vc direction:(int)direction
{
    //删除手势
    [self.view removeGestureRecognizer:_panGesture];
    
    
    if (vc == nil || _status != SLIDEMENU_NORMAL)
        return;
    
    //先插入一个按钮并设置透明度
    UIButton *covertButton = [self createCovertButton];
    covertButton.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    
    
    //再覆盖上边缘视图
    CGRect rect = self.view.bounds;
    [self.view addSubview:vc.view];
    vc.view.frame = self.view.bounds;
    
    
    
    
    [self callWillPresentDelegate:vc direction:direction];
    
    //边缘先在边缘
    vc.view.transform =  CGAffineTransformMakeTranslation(direction == SLIDEMENU_RIGHTDIRECTION ? -1 *rect.size.width:rect.size.width, 0);     // CGAffineTransformMakeScale(SIDE_MAXSCALE, SIDE_MAXSCALE);
    
    vc.view.layer.shadowRadius = 3;
    vc.view.layer.shadowOffset = CGSizeMake(0, 0);
    vc.view.layer.shadowOpacity = 0.5;
    UIBezierPath *path = [UIBezierPath bezierPathWithRect: vc.view.layer.bounds];
    vc.view.layer.shadowPath = path.CGPath;

    
    CGFloat maxOffsetX = self.view.bounds.size.width *0.13 ;
    maxOffsetX = specifityWidth == NSNotFound ? maxOffsetX : specifityWidth;
    if (direction == SLIDEMENU_RIGHTDIRECTION)
        maxOffsetX = -1 * maxOffsetX;
    
    [UIView animateWithDuration:0.3 animations:^{
        
        vc.view.transform = CGAffineTransformMakeTranslation(maxOffsetX,0);;
        
    } completion:^(BOOL finished){
        
        _status = ((direction == SLIDEMENU_RIGHTDIRECTION) ? SLIDEMENU_LEFTPRESENT : SLIDEMENU_RIGHTPRESENT);
        
        [self.view removeGestureRecognizer:_panGesture];
        
        [self callDidPresentDelegate:vc direction:direction];
        
        
    }];

    
    
}



-(void)presentSideHelper:(UIViewController*)vc direction:(int)direction
{
    
    if (_style == SLIDEMENU_SCALESTYLE)
    {
      [self presentSideScaleHelper:vc direction:direction];
    }
    else
    {
        [self presentSideCoverHelper:vc direction:direction];
    }
    
    
}


-(void)hideSideAnimate:(UIViewController*)sideVC status:(int)status
{
    if (!sideVC.isViewLoaded)
        return;
    
    [self callWillHiddenDelegate:sideVC status:status];

    
    [UIView animateWithDuration:0.3 animations:^{
        
        sideVC.view.transform = CGAffineTransformMakeScale(SIDE_MAXSCALE, SIDE_MAXSCALE);
        _centerVC.view.transform = CGAffineTransformIdentity;
        
    } completion:^(BOOL finished){
        
         _status = SLIDEMENU_NORMAL;
        [sideVC.view removeFromSuperview];
        
        
        [self callDidHiddenDelegate:sideVC status:status];
        

        sideVC.view = nil;
       
    }];
    
}


-(void)hideSideHelper:(UIViewController*)vc status:(int)status
{
    if (self.stack.count > 0)
        [self.view addGestureRecognizer:_panGesture];
    
    if (_style ==  SLIDEMENU_SCALESTYLE)
    {
        [self removeCovertButton];
        
        if (vc == nil || _status != status)
            return;
        
        [self hideSideAnimate:vc status:status];
    }
    else
    {
        if (vc == nil || _status != status)
            return;
        
        if (!vc.isViewLoaded)
            return;
        
        [self callWillHiddenDelegate:vc status:status];
        
        
        [UIView animateWithDuration:0.3 animations:^{
            
            vc.view.transform = CGAffineTransformMakeTranslation(status == SLIDEMENU_LEFTPRESENT ? -1 * self.view.bounds.size.width : self.view.bounds.size.width, 0);
            
        } completion:^(BOOL finished){
            
            _status = SLIDEMENU_NORMAL;
            [vc.view removeFromSuperview];
            
            [self callDidHiddenDelegate:vc status:status];
            
            vc.view = nil;
            [self removeCovertButton];
            
        }];

    }

    
    
}

-(UIButton*)createCovertButton
{
    //在_centerVC.view中覆盖一个透明的按钮。并且带上阴影
    
    UIButton *covertButton = (UIButton*)[_centerVC.view viewWithTag:COVERTBUTTON_TAG];
    
    if (covertButton == nil)
    {
        covertButton = [UIButton buttonWithType:UIButtonTypeCustom];
        covertButton.frame = _centerVC.view.bounds;
        covertButton.backgroundColor = [UIColor clearColor];
        covertButton.tag = COVERTBUTTON_TAG;
        [covertButton addTarget:self action:@selector(handleCenterVCReset:) forControlEvents:UIControlEventTouchUpInside];
        [_centerVC.view addSubview:covertButton];
        
        _centerVC.view.layer.shadowRadius = 3;
        _centerVC.view.layer.shadowOffset = CGSizeMake(0, 0);
        _centerVC.view.layer.shadowOpacity = 0.5;
        UIBezierPath *path = [UIBezierPath bezierPathWithRect: _centerVC.view.layer.bounds];
        _centerVC.view.layer.shadowPath = path.CGPath;
    }
    
    return covertButton;
    
}

- (void)removeCovertButton
{
    UIView *covertButton = [_centerVC.view viewWithTag:COVERTBUTTON_TAG];
    if (covertButton != nil)
    {
        [covertButton removeFromSuperview];
        
        _centerVC.view.layer.shadowRadius = 0;
        _centerVC.view.layer.shadowOffset = CGSizeMake(0, 0);
        _centerVC.view.layer.shadowOpacity = 0;
        _centerVC.view.layer.shadowPath = NULL;
    }
}



@end


@implementation UIViewController(MySlideMenuExtra)

-(MySlideMenu*)slideMenu
{
    if ([self isKindOfClass:[MySlideMenu class]])
        return (MySlideMenu*)self;
    
    UIViewController *p = self.parentViewController;
    do
    {
        if (p == nil)
            return nil;
        
        if ([p isKindOfClass:[MySlideMenu class]])
            return (MySlideMenu*)p;
        
        p = p.parentViewController;
        
    }while (p != nil);
    
    return (MySlideMenu*)p;
    
}

@end

