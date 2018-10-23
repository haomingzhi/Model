
//
//  MyTextField.m
//  MiniClient
//
//  Created by apple on 14-7-9.
//  Copyright (c) 2014年 SunnadaSoft. All rights reserved.
//

#import "MyTextField.h"
#import "MyKeyboardMoving.h"


@interface MyTextField()


@property(nonatomic) UILabel *floatingView;


@property(nonatomic,strong) MyKeyboardMoving *keyboardMoving;

@end

@implementation MyTextField



-(void)construct
{
    self.clearButtonMode = UITextFieldViewModeWhileEditing;
    _showFloatingView = NO;
    _floatingView = nil;
    
    self.autocorrectionType = UITextAutocorrectionTypeNo;
    self.spellCheckingType = UITextSpellCheckingTypeNo;
    
    _keyboardMoving = [[MyKeyboardMoving alloc] initWithOwner:self];

    if (!__IOS7 && self.borderStyle != UITextBorderStyleNone)
    {
        //设置背景图片。
        self.backgroundColor = [UIColor clearColor];
//        self.layer.cornerRadius = 5.0f;
//        self.borderStyle = UITextBorderStyleBezel;
        if (self.background == nil)
            self.background = [[UIImage imageNamed:@"textBackground"] stretchableImageWithLeftCapWidth:20 topCapHeight:0];
    }
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self construct];
    }
    return self;
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    [self construct];
}

-(void)setBorderStyle:(UITextBorderStyle)borderStyle
{
    if (!__IOS7 && borderStyle == UITextBorderStyleRoundedRect)
    {
        borderStyle = UITextBorderStyleBezel;
        
        self.backgroundColor = [UIColor clearColor];
//        self.layer.cornerRadius = 5.0f;
        if (self.background == nil)
            self.background = [[UIImage imageNamed:@"textBackground"] stretchableImageWithLeftCapWidth:20 topCapHeight:0];

    }
    
    [super setBorderStyle:borderStyle];
}


-(void)setKbMovingView:(UIView *)kbMovingView
{
    [self.keyboardMoving removeObserverAndGesture];
    self.keyboardMoving.kbMovingView = kbMovingView;
}

-(UIView*)kbMovingView
{
    return self.keyboardMoving.kbMovingView;
}



-(BOOL)becomeFirstResponder
{
    [self.keyboardMoving addObserverAndGesture];
    
//    if (self.borderStyle != UITextBorderStyleNone)
//    {
//        UIColor *borderColor = [UIColor colorWithRed:41.0f/255 green:166.0f/255 blue:231.0f/255 alpha:1];
//        self.layer.borderColor = borderColor.CGColor;
//        self.layer.borderWidth = 1;
//        self.layer.cornerRadius = 5.0;
//        self.layer.masksToBounds = YES;
//        
//        CABasicAnimation *baseAni = [CABasicAnimation animationWithKeyPath:@"borderColor"];
//        baseAni.fromValue = (id)[ borderColor colorWithAlphaComponent:0].CGColor;
//        baseAni.toValue = (id)borderColor.CGColor;
//        baseAni.duration = 1;
//        [self.layer addAnimation:baseAni forKey:@"borderColor"];
//    }
    
    
   BOOL bOK = [super becomeFirstResponder];
   return bOK;
}

-(BOOL)resignFirstResponder
{
    if (self.borderStyle != UITextBorderStyleNone)
    {
//        UIColor *borderColor = [UIColor clearColor];
//        
//        self.layer.borderColor = [borderColor colorWithAlphaComponent:0].CGColor;
//        
//        CABasicAnimation *baseAni = [CABasicAnimation animationWithKeyPath:@"borderColor"];
//        baseAni.fromValue = (id)borderColor.CGColor;
//        baseAni.toValue = (id)[borderColor colorWithAlphaComponent:0].CGColor;
//        baseAni.duration = 1;
//        [self.layer addAnimation:baseAni forKey:@"borderColor"];
    }
    
    
    
    BOOL ok  = [super resignFirstResponder];
   
    [self.keyboardMoving removeObserverAndGesture];
    
    
    return ok;
}

-(void)dealloc
{
    
}


-(void)handleEditingChanged:(id)sender
{
    if (!self.showFloatingView || self.floatingView == nil)
        return;
    
    
    NSString *tt = nil;
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(floatTextForMyTextField:)])
    {
        tt = [((id<MyTextFieldDelegate>)(self.delegate)) floatTextForMyTextField:self];
    }
        
    if (tt == nil)
        tt = self.text;
        
    self.floatingView.text = tt;
   
    
}



#pragma mark -- Handle Method


-(void)setShowFloatingView:(BOOL)showFloatingView
{
    _showFloatingView = showFloatingView;
    
    
    
        if (self.floatingView == nil)
        {
            self.floatingView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 1, 30)];
            self.floatingView.userInteractionEnabled = NO;
            self.floatingView.textAlignment = NSTextAlignmentCenter;
//            self.floatingView.layer.shadowColor = [UIColor clearColor].CGColor;
//            self.floatingView.layer.shadowRadius = 3;
//            self.floatingView.layer.shadowOpacity = 1.0;
//            self.floatingView.layer.shadowOffset = CGSizeMake(0, 0);
            self.floatingView.textColor = [UIColor colorWithRed:11.0/255 green:96.0/255 blue:254.0/255 alpha:1.0];
            self.floatingView.backgroundColor = [UIColor clearColor];
           // self.floatingView.layer.borderColor = [UIColor orangeColor].CGColor;
           // self.floatingView.layer.borderWidth = 1.0;
            self.floatingView.font = [UIFont boldSystemFontOfSize:26];
            
            [self addTarget:self action:@selector(handleEditingChanged:) forControlEvents:UIControlEventEditingChanged];
            
            [self addTarget:self action:@selector(handleEditingChanged:) forControlEvents:UIControlEventEditingDidBegin];
        }
    
    
    if (_showFloatingView)
        self.inputAccessoryView = self.floatingView;
    else
        self.inputAccessoryView = nil;
    
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

#pragma mark -- Private Method




@end



