//
//  CustomTextView.m
//  UMPControl
//
//  Created by kong fugen on 13-2-22.
//  Copyright (c) 2013年 kong fugen. All rights reserved.
//

#import "MyTextView.h"
#import "MyKeyboardMoving.h"
#import <QuartzCore/QuartzCore.h>

@class UITextViewDelegateImpl;

@interface MyTextView ()

@property (nonatomic, strong) UITextViewDelegateImpl *delegateImpl;

@property(nonatomic,strong) MyKeyboardMoving *keyboardMoving;



- (BOOL)textViewShouldBeginEditing:(UITextView *)textView;
- (BOOL)textViewShouldEndEditing:(UITextView *)textView;
- (void)textViewDidBeginEditing:(UITextView *)textView;
- (void)textViewDidEndEditing:(UITextView *)textView;
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text;
- (void)textViewDidChange:(UITextView *)textView;
- (void)textViewDidChangeSelection:(UITextView *)textView;

//显示附加的组件。
-(void)showAdditiveControl;

//
-(void)construct;

@end



/*
 UITextViewDelegate协议的实现者，因UITextView类不是自己实现UITextViewDelegate协议，
 所以只能委托第三方类来实现，否则会造成死循环。
 */
@interface UITextViewDelegateImpl : NSObject<UITextViewDelegate>
{
    __weak MyTextView *_custTextView;
}

-(id)initWithCustomTextView:(MyTextView*)custTextView;

@end

@implementation UITextViewDelegateImpl

-(id)initWithCustomTextView:(MyTextView*)custTextView
{
    self = [self init];
    if (self != nil)
    {
        _custTextView = custTextView;
    }
    
    return  self;
}



#pragma mark -- UITextViewDelegate


- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    return [_custTextView textView:textView shouldChangeTextInRange:range replacementText:text];
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    return [_custTextView textViewShouldBeginEditing:textView];
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    return [_custTextView textViewShouldEndEditing:textView];
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    [_custTextView textViewDidBeginEditing:textView];
}
- (void)textViewDidEndEditing:(UITextView *)textView
{
    [_custTextView textViewDidEndEditing:textView];
}

- (void)textViewDidChange:(UITextView *)textView
{
    [_custTextView textViewDidChange:textView];
}

- (void)textViewDidChangeSelection:(UITextView *)textView
{
    [_custTextView textViewDidChangeSelection:textView];
}



@end




@implementation MyTextView

- (id)initWithFrame:(CGRect)frame
{
    if( (self = [super initWithFrame:frame]) )
    {
        [self construct];
    }
    return self;
}


- (void)awakeFromNib
{
    [super awakeFromNib];
    [self construct];
}



-(void)setKbMovingView:(UIView *)kbMovingView
{
    [self.keyboardMoving removeObserverAndGesture];
    self.keyboardMoving.kbMovingView = kbMovingView;
}

-(void) setExtraHeight:(NSInteger)extraHeight
{
    _extraHeight = extraHeight;
    self.keyboardMoving.extraHeight = _extraHeight;
}
-(UIView*)kbMovingView
{
    return self.keyboardMoving.kbMovingView;
}


-(void)setEditable:(BOOL)editable
{
    //self.layer.borderWidth = editable ? 0.5 : 0;
    self.clearButton.hidden = (self.text.length > 0) &&  editable ? NO: YES;
    [super setEditable:editable];
}

- (void)dealloc
{

    self.textDelegate = nil;
    self.delegate = nil;
    
    [self removeObserver:self forKeyPath:@"text"];
    [_placeholder removeObserver:self forKeyPath:@"text"];
    
}

-(BOOL)becomeFirstResponder
{
    
    [self.keyboardMoving addObserverAndGesture];
    [_leftImgView setImage:[UIImage imageNamed:@"addressIcon_P"]];
    BOOL flag = [super becomeFirstResponder];
    if (flag && self.isEditable && self.borderWidth != 0.0f)
    {
//        UIColor *bc = [UIColor colorWithRed:41.0f/255 green:166.0f/255 blue:231.0f/255 alpha:1];
//        self.layer.borderWidth = 1;
//        
//        CABasicAnimation *baseAni = [CABasicAnimation animationWithKeyPath:@"borderColor"];
//        baseAni.fromValue = (id)[ bc colorWithAlphaComponent:0].CGColor;
//        baseAni.toValue = (id)bc.CGColor;
//        baseAni.duration = 1;
//        baseAni.removedOnCompletion = NO;
//        baseAni.fillMode = kCAFillModeForwards;
//        [self.layer addAnimation:baseAni forKey:@"borderColor"];
        
        //只要获得焦点，剩余数字就显示，并且根据是否有文字来显示清除按钮与否
        _clearButton.hidden = (self.text.length == 0);
        _shownumLabel.hidden = NO;
    }
    else if (flag && self.isEditable)
        _clearButton.hidden = (self.text.length == 0);
    return flag;
}

-(BOOL)resignFirstResponder
{
    BOOL flag = [super resignFirstResponder];
    [_leftImgView setImage:[UIImage imageNamed:@"addressPic"]];
    if (flag && self.isEditable && self.borderWidth != 0.0f)
    {
//        UIColor *bc = [UIColor colorWithRed:41.0f/255 green:166.0f/255 blue:231.0f/255 alpha:1];
//       
//        //恢复原始边框和颜色。
//        self.layer.borderWidth = self.borderWidth;
//        CABasicAnimation *baseAni = [CABasicAnimation animationWithKeyPath:@"borderColor"];
//        baseAni.fromValue = (id)bc.CGColor;
//        baseAni.toValue = (id)self.borderColor.CGColor;
//        baseAni.duration = 0.7;
//        baseAni.fillMode = kCAFillModeForwards;
//        baseAni.removedOnCompletion = NO;
        
//        [self.layer addAnimation:baseAni forKey:@"borderColor"];
        
        //如果失去焦点，则根据是否有文字来显示删除按钮，以及如果没有文字则隐藏提示文字信息。
        _clearButton.hidden = (self.text.length == 0);
        _shownumLabel.hidden = (self.text.length == 0);
    }
    else if (flag && self.isEditable)
        _clearButton.hidden = TRUE;
    [self.keyboardMoving removeObserverAndGesture];
    
    return flag;
}

-(void)setBorderColor:(UIColor*)color
{
    if (_borderColor == color)
        return;
    
   
    _borderColor = color;
    self.layer.borderColor = _borderColor.CGColor;
}

-(void)setBorderWidth:(CGFloat)width
{
    //_borderWidth = width;
    //self.layer.borderWidth = width;
}

-(void)setBorderRadius:(CGFloat)radius
{
    //_borderRadius = radius;
    //self.layer.cornerRadius = radius;
}



-(void)setMaxTextLength:(NSInteger)maxTextLength
{
    _maxTextLength = maxTextLength;
    

    _shownumLabel.hidden = (_maxTextLength == 0);
    
    [self showAdditiveControl];
    
}



- (void)drawRect:(CGRect)rect
{
    //绘制背景图片。
    if (self.background != nil)
    {
        [self.background drawInRect:self.bounds];
    }
    
    [super drawRect:rect];
}


-(void)setContentOffset:(CGPoint)contentOffset
{
    [super setContentOffset:contentOffset];
    
    _clearButton.frame = CGRectMake(self.frame.size.width - 50, contentOffset.y + self.frame.size.height - 25, 50, 19);
    _shownumLabel.frame = CGRectMake(self.frame.size.width - 90, contentOffset.y + self.frame.size.height - 45, 60, 60);
    
}

#pragma mark -- KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    
    if (object == _placeholder && [keyPath isEqualToString:@"text"])
    {
        [_placeholder sizeToFit];
    }
    
    if (object == self && [keyPath isEqualToString:@"text"])
    {
        [self showAdditiveControl];
    }
    
}


#pragma mark -- submit Method
- (void)submitClearText:(id)sender
{
    self.text = @"";
    if (self.textDelegate != nil && [self.textDelegate respondsToSelector:@selector(textViewDidChange:)])
    {
        return [self.textDelegate textViewDidChange:self ];
    }
}


#pragma mark -- Private Method

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if (_maxTextLength == 0)
    {
        if (self.textDelegate != nil && [self.textDelegate respondsToSelector:@selector(textView:shouldChangeTextInRange:replacementText:)])
        {
            return [self.textDelegate textView:self shouldChangeTextInRange:range replacementText:text];
        }
    }
    else
    {
        NSMutableString *str = [textView.text mutableCopy];
        [str replaceCharactersInRange:range withString:text];
        if (str.length > _maxTextLength)
        {
            
            return NO;
        }
        else
        {
            
            if (self.textDelegate != nil && [self.textDelegate respondsToSelector:@selector(textView:shouldChangeTextInRange:replacementText:)])
            {
                return [self.textDelegate textView:self shouldChangeTextInRange:range replacementText:text];
            }
        }
        
    }
    
    return YES;
}


- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    if (self.textDelegate != nil && [self.textDelegate respondsToSelector:@selector(textViewShouldBeginEditing:)])
    {
        return [self.textDelegate textViewShouldBeginEditing:self];
    }
    
    return YES;
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    if (self.textDelegate != nil && [self.textDelegate respondsToSelector:@selector(textViewShouldEndEditing:)])
    {
        return [self.textDelegate textViewShouldEndEditing:self];
    }
    
   return YES;
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if (self.textDelegate != nil && [self.textDelegate respondsToSelector:@selector(textViewDidBeginEditing:)])
    {
        [self.textDelegate textViewDidBeginEditing:self];
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if (self.textDelegate != nil && [self.textDelegate respondsToSelector:@selector(textViewDidEndEditing:)])
    {
        [self.textDelegate textViewDidEndEditing:self];
    }
}

- (void)textViewDidChange:(UITextView *)textView
{
    [self showAdditiveControl];
    
    if (self.textDelegate != nil && [self.textDelegate respondsToSelector:@selector(textViewDidChange:)])
    {
        [self.textDelegate textViewDidChange:self];
    }
}

- (void)textViewDidChangeSelection:(UITextView *)textView
{
    if (self.textDelegate != nil && [self.textDelegate respondsToSelector:@selector(textViewDidChangeSelection:)])
    {
        [self.textDelegate textViewDidChangeSelection:self];
    }
}

-(void)showAdditiveControl
{
    if (_maxTextLength != 0)
    {
        if (_maxTextLength > self.text.length)
        {
            _shownumLabel.text = [NSString stringWithFormat:@"%ld", _maxTextLength - self.text.length];
        }
        else
        {
            _shownumLabel.text = @"0";
        }
    }
    
    _placeholder.hidden = (self.text.length > 0);
    
    _clearButton.hidden = (self.text.length == 0) || !self.isEditable;

}


-(void)construct
{
    
//    self.layer.masksToBounds = YES;
    
//    self.borderWidth = 0.5;
//    self.borderRadius = 5;
//    self.borderColor = [UIColor colorWithWhite:202.0/255.0 alpha:1];
    _extraHeight = 0;
    _leftImgView= [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 20, 20)];
    [_leftImgView setImage:[UIImage imageNamed:@"addressPic"]];
    _leftImgView.hidden = YES;
    [self addSubview:_leftImgView];
    
    _placeholder = [[UILabel alloc] initWithFrame:CGRectMake(30, 8, 200, 21)];
    _placeholder.numberOfLines = 0;
    [self addSubview:_placeholder];
    [self sendSubviewToBack:_placeholder];
    //观察文本的变化。
    [_placeholder addObserver:self forKeyPath:@"text" options:NSKeyValueObservingOptionNew context:nil];
    
    self.backgroundColor = [UIColor clearColor];
    self.textAlignment = NSTextAlignmentLeft;
    self.autocorrectionType = UITextAutocorrectionTypeNo;
    self.contentInset = UIEdgeInsetsMake(0, 0, 20, 0);
    
    //添加删除按钮。
    _clearButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _clearButton.frame = CGRectMake(self.frame.size.width - 50, self.frame.size.height - 20, 50, 15);
    _clearButton.imageEdgeInsets =  UIEdgeInsetsMake(2,30,2,5);
    _clearButton.backgroundColor = [UIColor clearColor];
    _clearButton.hidden = YES;
    _clearButton.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin;
    [_clearButton setImage:[UIImage imageNamed:@"clearButton"] forState:UIControlStateNormal];
    [_clearButton addTarget:self action:@selector(submitClearText:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_clearButton];
    [self bringSubviewToFront:_clearButton];
    
    //添加显示文字。
    _shownumLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width - 30, self.frame.size.height - 20, 20, 20)];
    _shownumLabel.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin;
    _shownumLabel.backgroundColor = [UIColor clearColor];
    _shownumLabel.hidden = YES;
    _shownumLabel.textAlignment = NSTextAlignmentRight;
    [self addSubview:_shownumLabel];
    
    
    UITextViewDelegateImpl *delegateImpl = [[UITextViewDelegateImpl alloc] initWithCustomTextView:self];
    self.delegateImpl = delegateImpl;
    self.delegate = self.delegateImpl;
    //
    [self addObserver:self forKeyPath:@"text" options:NSKeyValueObservingOptionNew context:nil];
    
     _keyboardMoving = [[MyKeyboardMoving alloc] initWithOwner:self];
}


@end
