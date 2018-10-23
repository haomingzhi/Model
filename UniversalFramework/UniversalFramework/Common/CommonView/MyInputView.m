//
//  MyInputView.m
//  MiniClient
//
//  Created by longgong on 14-9-19.
//  Copyright (c) 2014年 SunnadaSoft. All rights reserved.
//

#import "MyInputView.h"
#import "MyKeyboardMoving.h"
#import "UIImage+SeparatorLine.h"

#define DATEPICKE 1001

@interface MyInputView()
{
    
    CGFloat m_imageWidth;
    
}
@property (nonatomic,strong) UIImage *normalImage;
@property (nonatomic,strong) UIImage *highlightedImage;
@end



@implementation MyInputView

-(void)initInputView
{
    
    [self initInputView:UITextBorderStyleNone];
    
}

-(void)setInputView:(UITextBorderStyle)borderStyle andWidth:(int ) width andheigth:(int) heigth
{
    self.borderStyle=borderStyle;
    self.borderWidth=0;
    _leftLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, self.frame.size.height)];
    [_leftLabel setText:self.leftText];
    _leftLabel.textAlignment = NSTextAlignmentCenter;
    _leftLabel.font=self.size;
//    _leftLabel.textColor=self.color;
    UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(width+1, 6, 1, self.frame.size.height-12)];
//    label.backgroundColor=[UIColor colorWithRed:223/255.0 green:223/255.0 blue:223/255.0 alpha:1];
    [self addSubview:_leftLabel];
    //[self addSubview:label];
     m_imageWidth = label.frame.origin.x;
    UILabel * leftView = [[UILabel alloc] initWithFrame:CGRectMake(0,0,m_imageWidth+10,heigth)];
    leftView.backgroundColor = [UIColor clearColor];
    
    self.leftView = leftView;
    
    self.leftViewMode = UITextFieldViewModeAlways;
    self.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    
    //self.background = [self getSeparatorLineImage:[UIColor colorWithRed:223/255.0 green:223/255.0 blue:223/255.0 alpha:1]];
    
}
-(void) initInputView:(UITextBorderStyle)borderStyle
{
    self.borderStyle = borderStyle;
    //定义输入框左边图标
    if (self.normalImage != NULL) {
        _leftImgView= [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.height, self.frame.size.height)];
        [_leftImgView setImage:self.normalImage];
        _leftImgView.contentMode = UIViewContentModeCenter;
        [self addSubview:_leftImgView];
        m_imageWidth = self.frame.size.height;
    }
    
    UILabel * leftView = [[UILabel alloc] initWithFrame:CGRectMake(0,0,m_imageWidth+10,26)];
    leftView.backgroundColor = [UIColor clearColor];
    
    self.leftView = leftView;
    
    self.leftViewMode = UITextFieldViewModeAlways;
    self.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    
    //self.background = [self getSeparatorLineImage:[UIColor colorWithRed:223/255.0 green:223/255.0 blue:223/255.0 alpha:1]];
}

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    m_imageWidth = 0;
    if (self != nil)
    {
        self.clearButtonMode = UITextFieldViewModeWhileEditing;
    }
    
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
}


-(BOOL)becomeFirstResponder
{
    //[_lineImg setImage:[UIImage imageNamed:@""]];
    //self.background = [self getSeparatorLineImage:[UIColor orangeColor]];
    if (_borderLightColor) {
        self.layer.borderColor = _borderLightColor.CGColor;
        self.layer.borderWidth = 0.5;
    }
    else
    {
//        self.layer.borderColor = _borderColor.CGColor;
//        self.layer.borderWidth = 0;
    }
    if(self.highlightedImage != NULL)
    {
        [_leftImgView setImage:self.highlightedImage];
    }
    BOOL bOK = [super becomeFirstResponder];
    return bOK;
}

-(BOOL)resignFirstResponder
{
    //self.background = [self getSeparatorLineImage:[UIColor colorWithRed:223/255.0 green:223/255.0 blue:223/255.0 alpha:1]];
    if(self.normalImage != NULL)
    {
        [_leftImgView setImage:self.normalImage];
    }
    if (_borderColor) {
        self.layer.borderColor = _borderColor.CGColor;
    }else
    {
//        self.layer.borderColor = kUIColorFromRGB(color_lineColor).CGColor;
    }
    
    BOOL ok  = [super resignFirstResponder];
    return ok;
}
/**
 *  返回背景图片
 *
 *  @return 返回分割线图片
 */
-(UIImage *)getSeparatorLineImage:(UIColor *)color
{
    CGFloat leftOffset =0;
    CGFloat rigthOffset =0;
    CGFloat topOffset = self.bounds.size.height -5;
    CGFloat bottomOffset =0;
    
    return [UIImage imageWithSeparatorLine:UISeparatorLineTypeLeft| UISeparatorLineTypeBottom|UISeparatorLineTypeRight lineColor:color withBounds:self.bounds offset:UIEdgeInsetsMake(topOffset, leftOffset, bottomOffset, rigthOffset) lineWidth:2];
}

- (void)setLeftImage:(UIImage *)leftImage forState:(UIControlState)state
{
    if(state == UIControlStateNormal)
    {
        self.normalImage = leftImage;
    }
    else if (state == UIControlStateHighlighted)
    {
        self.highlightedImage = leftImage;
    }
}


@end
