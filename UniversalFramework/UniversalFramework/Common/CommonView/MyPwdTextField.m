//
//  MyPwdTextField.m
//  MiniClient
//
//  Created by apple on 14-8-6.
//  Copyright (c) 2014年 SunnadaSoft. All rights reserved.
//

#import "MyPwdTextField.h"

@interface MyLayerImpl : NSObject

@property(nonatomic, weak) UITextField *textField;
@property(nonatomic)CGFloat pwdWidth;//密码小框宽度
@end

@implementation MyLayerImpl

-(id)initWithTextField:(UITextField*)textField
{
    self = [self init];
    if (self != nil)
    {
        self.textField = textField;
    }
    
    return self;
}


-(void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx
{
    if ([self.textField text].length > 6) {
        self.textField.text = [[self.textField text] substringToIndex:6];
    }
    CGContextSetFillColorWithColor(ctx, [UIColor blackColor].CGColor);
    layer.contentsScale = 2;
    //得到间隔
    CGFloat w = _pwdWidth;
    if (w == 0) {
        w = 40;
    }
    CGFloat intelv = w - 16;//(self.textField.bounds.size.width - (15 * 6))/7;
    
    CGFloat x = w/2.0 - 8;
    for (int i = 0; i < self.textField.text.length; i++)
    {
        //        CGContextAddLines(ctx,CGPointMake(40 * i, 0));
        
        CGRect rect1 = CGRectMake(x, (self.textField.bounds.size.height - 15)/2, 16, 16);
        x += 16 + intelv;
        CGContextAddEllipseInRect(ctx, rect1);
        
    }
    CGContextFillPath(ctx);
}

@end

@interface MyPwdTextField()

@property(nonatomic) MyLayerImpl *layerImpl;
@property(nonatomic) CALayer *myl;
@end

@implementation MyPwdTextField



-(void)constructEx
{
    
    self.textColor = [UIColor clearColor];
    self.secureTextEntry = NO;
    
    [self addTarget:self action:@selector(handleEditingChanged:) forControlEvents:UIControlEventEditingChanged];
    
    //添加一个层。
    
    _myl= [[CALayer alloc] init];
    _myl.frame = self.layer.bounds;
    [self.layer addSublayer:_myl];
    self.layerImpl = [[MyLayerImpl alloc] initWithTextField:self];
    self.layerImpl.pwdWidth = _pwdWidth;
    _myl.delegate = self.layerImpl;
    
    
}

-(void)setPwdWidth:(CGFloat)pwdWidth
{
    _pwdWidth = pwdWidth;
    if (self.myl) {
        self.layerImpl.pwdWidth = _pwdWidth;
        [self.myl setNeedsDisplay];
    }
}

-(void)setWidth:(CGFloat)width
{
    [super setWidth:width];
    _myl.frame = self.layer.bounds;
    [self.myl setNeedsDisplay];
}

-(void)drawRect:(CGRect)rect
{
    if (_isShowBorder) {
        CGFloat w = _pwdWidth;
        if (w == 0) {
            w = 40;
        }
        UIColor *col = kUIColorFromRGB(color_5);
        if (_pwdBorderColor) {
            col = _pwdBorderColor;
        }
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        for (NSInteger i = 1;  i < 6; i ++ ) {
            //        if (i < 6 && i > 0) {
            CGContextBeginPath(ctx);
            CGContextMoveToPoint(ctx, w * i, 0);
            
            CGContextAddLineToPoint(ctx, w * i, w);
            CGContextSetStrokeColorWithColor(ctx,col.CGColor);
            CGContextSetLineWidth(ctx,0.5);
            CGContextStrokePath(ctx);
            //        }
            
        }
    }
    
}

//-(void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx
//{
//
//}

-(void)setText:(NSString *)text
{
    [super setText:text];
    [_myl setNeedsDisplay];
}

-(NSString *)text
{
    if ([super text].length > 6) {
        super.text = [[super text] substringToIndex:6];
        //        return [[super text] substringToIndex:6];
    }
    return [super text];
}

-(void)handleEditingChanged:(id)sender
{
    [_myl setNeedsDisplay];
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self constructEx];
    }
    return self;
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    [self constructEx];
}



// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.


@end
