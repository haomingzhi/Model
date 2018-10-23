//
//  MyKeyboardMoving.m
//  MiniClient
//
//  Created by apple on 14-7-20.
//  Copyright (c) 2014年 SunnadaSoft. All rights reserved.
//

#import "MyKeyboardMoving.h"

@interface MyKeyboardMoving()

@property(nonatomic) UITapGestureRecognizer *tapGesture;
@property(nonatomic) UISwipeGestureRecognizer *swipeGesture;

@property(nonatomic, assign) UIView *txtView;

@end


@implementation MyKeyboardMoving


-(id)initWithOwner:(UIView*)txtView
{
    self = [self init];
    if (self != nil)
    {
        _txtView = txtView;
    }
    
    return self;
}


-(void)handleKeyboardWillShow:(NSNotification*)noti
{
    if (self.kbMovingView != nil)
    {
        NSDictionary *userInfo = [noti userInfo];
        NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
        CGFloat keyboardHeight = [aValue CGRectValue].size.height;
        
        [self movingView:keyboardHeight];
    }
    
    
}

-(void)handleKeyboardWillHide:(NSNotification*)noti
{
    if (self.kbMovingView != nil)
    {
        if (!CGAffineTransformIsIdentity(self.kbMovingView.transform))
        {
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:0.1];
            self.kbMovingView.transform =CGAffineTransformIdentity;
            [UIView commitAnimations];
        }
    }
}

-(void)handleKeyboardWillChange:(NSNotification*)noti
{
    [self handleKeyboardWillShow:noti];
}

-(void)handleGesture:(UIGestureRecognizer*)gesture
{
    if (self.kbMovingView != nil)
    {
        [self.txtView resignFirstResponder];
    }
}

- (void)addObserverAndGesture
{
    if (self.kbMovingView != nil)
    {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleKeyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleKeyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleKeyboardWillChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
        
        
        //添加一个触摸事件
        
        if (self.tapGesture == nil)
        {
            self.tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
        }
        
        if (self.swipeGesture == nil)
        {
            self.swipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
            
            self.swipeGesture.direction = UISwipeGestureRecognizerDirectionDown;
        }
        
        [self.kbMovingView addGestureRecognizer:self.tapGesture];
        [self.kbMovingView addGestureRecognizer:self.swipeGesture];
        
    }
    
    //如果当前已经显示键盘则直接调整位置。。
    if (self.kbMovingView != nil)
    {
        UIWindow *windowTemp = nil;
        for (UIWindow *w in [[UIApplication sharedApplication] windows]) {
            if ([NSStringFromClass([w class]) isEqualToString:@"UITextEffectsWindow"]) {
                windowTemp = w;
                break;
            }
        }
        
        if (windowTemp != nil && !windowTemp.isHidden)
        {
            UIView *keyboard;
            NSInteger viewCount = [windowTemp.subviews count];
            for (int i = 0; i < viewCount; i++)
            {
                keyboard = [BSUtility FindViewByClass:[windowTemp.subviews objectAtIndex:i] ViewClassName:@"UIInputSetHostView"];
                if (keyboard != NULL) {
                    [BSUtility displayViewDescription:keyboard];
                }
            }
            if (__IOS8) {
                if (keyboard != NULL && keyboard.bounds.size.height >0) {
                    [self movingView:keyboard.bounds.size.height];
                }
            }
            else {
                if (windowTemp.subviews.count > 0)
                    [self movingView:((UIView*)[windowTemp.subviews objectAtIndex:0]).bounds.size.height];
            }
        }
    }
}



- (void)removeObserverAndGesture
{
    if (self.kbMovingView != nil)
    {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
        
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
        
        if (self.tapGesture != nil &&  self.swipeGesture != nil)
        {
            [self.kbMovingView removeGestureRecognizer:self.tapGesture];
            [self.kbMovingView removeGestureRecognizer:self.swipeGesture];
        }
    }
}

//键盘移动，keyboardHeight键盘高度
- (void)movingView:(CGFloat)keyboardHeight
{
    CGRect rect = [self.txtView convertRect:self.txtView.bounds toView:self.txtView.window];//坐标系统转换
    CGFloat h = rect.origin.y + rect.size.height + self.extraHeight - (self.txtView.window.bounds.size.height - keyboardHeight);
    if (h > 0)
    {//向上移动
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.3];
        NSLog(@"%f",h  - self.kbMovingView.transform.ty);
        self.kbMovingView.transform = CGAffineTransformMakeTranslation(0, -1 * (h  - self.kbMovingView.transform.ty));
        [UIView commitAnimations];
    }
    else
    {
        //如果太高要往下移动。。。。
//        if (!CGAffineTransformIsIdentity(self.kbMovingView.transform))
//        {
//            CGAffineTransform at = CGAffineTransformMakeTranslation(0, -1 * (h  - self.kbMovingView.transform.ty));
//            
//            if (at.ty > 0)
//                at = CGAffineTransformIdentity;
//            
//            [UIView beginAnimations:nil context:nil];
//            [UIView setAnimationDuration:0.3];
//            self.kbMovingView.transform = at;//CGAffineTransformMakeTranslation(0, -1 * (h + 30 - self.kbMovingView.transform.ty));
//            [UIView commitAnimations];
//        }
        
    }
}

-(void)dealloc
{
    [self removeObserverAndGesture];
    
    //保证能删除干净。。
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
    
}


@end
