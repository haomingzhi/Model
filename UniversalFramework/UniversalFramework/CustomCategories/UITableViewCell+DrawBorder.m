//
//  UITableViewCell+DrawBorder.m
//  JiXie
//
//  Created by air on 15/5/27.
//  Copyright (c) 2015年 ORANLLC_IOS1. All rights reserved.
//

#import "UITableViewCell+DrawBorder.h"
#define  PIX_TIMES 4
@implementation UITableViewCell (DrawBorder)

//以下画边框方法在drawRect内调用才有用

-(NSArray *)drawBorder:(BorderMode)borderMode
{
   return  [self drawBorder:borderMode withIsNeedBottomLine:YES withPadding:5];
}

-(NSArray *)drawBorder:(BorderMode)borderMode withLRPadding:(CGFloat)padding
{
  return   [self drawBorder:borderMode withIsNeedBottomLine:YES withPadding:padding];
}

-(NSArray *)drawBorder:(BorderMode)borderMode withIsNeedBottomLine:(BOOL)isNeed withPadding:(CGFloat)padding
{
    switch (borderMode)
    {
        case BorderModeAll:
        {
          return   [self drawAllBorder];
        }
            break;
        case BorderModeTop:
        {
          NSMutableArray *arr =  (NSMutableArray *)[self drawLostBottomBorder];
            if (isNeed) {
               [arr addObjectsFromArray:[self drawBottomLine:padding]] ;
            }
            return arr;
        }
            break;
        case BorderModeCenter:
        {
           NSMutableArray *arr = (NSMutableArray *)[self drawLostTopAndBottomBorder];
            if (isNeed) {
             [ arr addObjectsFromArray:[self drawBottomLine:padding]];
            }
            return arr;
        }
            break;
        case BorderModeBottom:
        {
           return  [self drawLostTopBorder];
        }
            break;
        case BorderModeNone:
            return nil;
            break;
        default:
            break;
    }
    return nil;
}

//画缺底的边框
-(NSArray *)drawLostBottomBorder
{
   return  [self drawLostBottomBorder:5];
}

-(NSArray *)drawLostBottomBorder:(CGFloat)padding
{
   return  [self drawLostBottomBorder:padding withRadius:0];
}

-(NSArray *)drawLostBottomBorder:(CGFloat)padding withRadius:(CGFloat)radius
{
   return  [self drawLostBottomBorder:padding withRadius:radius withBorderColor:[UIColor lightGrayColor]];
}

-(NSArray *)drawLostBottomBorder:(CGFloat)padding withRadius:(CGFloat)radius withBorderColor:(UIColor *)color
{
   return  [self drawLostBottomBorder:padding withRadius:radius withBorderColor:color  drawType:DrawTypeLayerDraw];
}

-(NSArray *)drawLostBottomBorder:(CGFloat)aPadding withRadius:(CGFloat)aRadius withBorderColor:(UIColor *)color drawType:(DrawType)b
{
    switch (b) {
        case DrawTypeLayerDraw:
        {
          return   [self layerDrawLostBottomBorder:aPadding withRadius:aRadius withBorderColor:color];
        }
            break;
        case DrawTypeBezierPathDraw:
        {
             [self drawBezierPathLostBottomBorder:aPadding withRadius:aRadius];
        }
            break;
        default:
            break;
    }
    return nil;
}

-(NSArray *)layerDrawLostBottomBorder:(CGFloat)aPadding withRadius:(CGFloat)aRadius withBorderColor:(UIColor *)color
{
    CALayer *aLayer = [CALayer layer];
    aLayer.frame = CGRectMake(aPadding, 0, self.bounds.size.width - 2 * aPadding, self.bounds.size.height);
    aLayer.borderWidth = 0.5;
    aLayer.borderColor = color.CGColor;
    [self.layer addSublayer:aLayer];
    CALayer *bLayer = [CALayer layer];
    bLayer.frame = CGRectMake(aPadding + 0.5, self.bounds.size.height - 1, self.bounds.size.width - 2 * aPadding - 1, 2);
    bLayer.backgroundColor = [UIColor whiteColor].CGColor;
    [self.layer addSublayer:bLayer];
    
    NSMutableArray *arr = [NSMutableArray array];
    [arr addObject:aLayer];
    [arr addObject:bLayer];
    return arr;
}

-(void)drawBezierPathLostBottomBorder:(CGFloat)aPadding withRadius:(CGFloat)aRadius
{
    CGFloat padding = aPadding * PIX_TIMES;
    CGFloat radius = aRadius * PIX_TIMES;
    [self drawImgOnGraphics:^(CGSize size){
            UIBezierPath *path = [UIBezierPath bezierPath];
            [path moveToPoint:CGPointMake(padding, size.height)];
            [path addLineToPoint:CGPointMake(padding, radius + PIX_TIMES)];
            [path addArcWithCenter:CGPointMake(padding + radius, radius + PIX_TIMES) radius:radius startAngle:M_PI endAngle:M_PI + M_PI_2 clockwise:YES];
            [path addLineToPoint:CGPointMake(size.width - padding - radius, PIX_TIMES)];
            [path addArcWithCenter:CGPointMake(size.width - padding - radius,  radius + PIX_TIMES) radius:radius startAngle:M_PI + M_PI_2 endAngle:2 * M_PI clockwise:YES];
            [path addLineToPoint:CGPointMake(size.width - padding, size.height)];
            path.lineWidth = 0.5 * PIX_TIMES;
            //    [path closePath];
            [path stroke];

    }];
}

-(void)drawImgOnGraphics:(void (^)(CGSize size))block
{
    CGSize size = CGSizeMake(self.frame.size.width * PIX_TIMES , self.frame.size.height * PIX_TIMES);
    UIGraphicsBeginImageContext(size);
    block(size);
    UIImage *newimg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [self addImgVToLayer:newimg];
}

-(void)addImgVToLayer:(UIImage *)newimg
{
    CALayer *layer=[[CALayer alloc]init];
    layer.contents = (id)newimg.CGImage;
    //    self.borderWidth = 2;
    layer.bounds=CGRectMake(0, 0, self.frame.size.width,self.frame.size.height);
    layer.position=CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    [self.contentView.layer addSublayer:layer];
}

//画缺头的边框
-(NSArray *)drawLostTopBorder
{
   return  [self drawLostTopBorder:5];
}

-(NSArray *)drawLostTopBorder:(CGFloat)padding
{
  return   [self drawLostTopBorder:padding withRadius:0];
}
-(NSArray *)drawLostTopBorder:(CGFloat)padding withRadius:(CGFloat)radius
{
  return   [self drawLostTopBorder:padding withRadius:radius withBorderColor:[UIColor lightGrayColor]];
}

-(NSArray *)drawLostTopBorder:(CGFloat)padding withRadius:(CGFloat)radius withBorderColor:(UIColor *)color
{
  return  [self drawLostTopBorder:padding withRadius:radius withBorderColor:color  drawType:DrawTypeLayerDraw];
}

-(NSArray *)drawLostTopBorder:(CGFloat)aPadding withRadius:(CGFloat)aRadius withBorderColor:(UIColor *)color drawType:(DrawType)b
{
    switch (b) {
        case DrawTypeLayerDraw:
        {
           return  [self layerDrawLostTopBorder:aPadding withRadius:aRadius withBorderColor:color];
        }
            break;
        case DrawTypeBezierPathDraw:
        {
            [self drawBezierPathLostTopBorder:aPadding withRadius:aRadius];
        }
            break;
        default:
            break;
    }
    return nil;
}

-(NSArray *)layerDrawLostTopBorder:(CGFloat)aPadding withRadius:(CGFloat)aRadius withBorderColor:(UIColor *)color
{
    CALayer *aLayer = [CALayer layer];
    aLayer.frame = CGRectMake(aPadding, 0, self.bounds.size.width - 2 * aPadding, self.bounds.size.height);
    aLayer.borderWidth = 0.5;
    aLayer.borderColor = color.CGColor;
    [self.layer addSublayer:aLayer];
    CALayer *bLayer = [CALayer layer];
    bLayer.frame = CGRectMake(aPadding + 0.5, 0, self.bounds.size.width - 2 * aPadding - 1, 2);
    bLayer.backgroundColor = [UIColor whiteColor].CGColor;
    [self.layer addSublayer:bLayer];
    NSMutableArray *arr = [NSMutableArray array];
    [arr addObject:aLayer];
    [arr addObject:bLayer];
    return arr;
}



-(void)drawBezierPathLostTopBorder:(CGFloat)aPadding withRadius:(CGFloat)aRadius
{
    CGFloat padding = aPadding * PIX_TIMES;
    CGFloat radius = aRadius * PIX_TIMES;
    [self drawImgOnGraphics:^(CGSize size){
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint:CGPointMake(padding, 0)];
        [path addLineToPoint:CGPointMake(padding, size.height - PIX_TIMES - radius)];
        [path addArcWithCenter:CGPointMake(padding + radius, size.height - PIX_TIMES - radius) radius:radius startAngle:M_PI endAngle:M_PI_2 clockwise:NO];
        [path addLineToPoint:CGPointMake(size.width - padding - radius, size.height - PIX_TIMES)];
        [path addArcWithCenter:CGPointMake(size.width - padding - radius, size.height - PIX_TIMES - radius) radius:radius startAngle:M_PI_2 endAngle:0 clockwise:NO];
        [path addLineToPoint:CGPointMake(size.width - padding, 0)];
        path.lineWidth = 0.5 * PIX_TIMES;
        [path stroke];
        
    }];

}

//画缺头底的边框
-(NSArray *)drawLostTopAndBottomBorder
{
  return   [self drawLostTopAndBottomBorder:5];
}

-(NSArray *)drawLostTopAndBottomBorder:(CGFloat)padding
{
  return  [self drawLostTopAndBottomBorder:padding withBorderColor:[UIColor lightGrayColor]];
}

-(NSArray *)drawLostTopAndBottomBorder:(CGFloat)padding withBorderColor:(UIColor *)color
{
   return  [self drawLostTopAndBottomBorder:padding withBorderColor:color  drawType:DrawTypeLayerDraw];
}

-(NSArray *)drawLostTopAndBottomBorder:(CGFloat)aPadding withBorderColor:(UIColor *)color drawType:(DrawType)b
{
    switch (b) {
        case DrawTypeLayerDraw:
        {
           return  [self layerDrawLostTopAndBottomBorder:aPadding withBorderColor:color];
        }
            break;
        case DrawTypeBezierPathDraw:
        {
            [self drawBezierPathLostTopAndBottomBorder:aPadding];
        }
            break;
        default:
            break;
    }
    return nil;
}

-(NSArray *)layerDrawLostTopAndBottomBorder:(CGFloat)aPadding withBorderColor:(UIColor *)color
{
    CALayer *aLayer = [CALayer layer];
    aLayer.frame = CGRectMake(aPadding, 0, self.bounds.size.width - 2 * aPadding, self.bounds.size.height);
    aLayer.borderWidth = 0.5;
    aLayer.borderColor = color.CGColor;
    [self.layer addSublayer:aLayer];
    
    CALayer *bLayer = [CALayer layer];
    bLayer.frame = CGRectMake(aPadding + 0.5, 0, self.bounds.size.width - 2 * aPadding -1, 2);
    bLayer.backgroundColor = [UIColor whiteColor].CGColor;
    [self.layer addSublayer:bLayer];
    
    CALayer *cLayer = [CALayer layer];
    cLayer.frame = CGRectMake(aPadding + 0.5, self.bounds.size.height - 1, self.bounds.size.width - 2 * aPadding -1, 1);
    cLayer.backgroundColor = [UIColor whiteColor].CGColor;
    [self.layer addSublayer:cLayer];
    
    NSMutableArray *arr = [NSMutableArray array];
    [arr addObject:aLayer];
    [arr addObject:bLayer];
    [arr addObject:cLayer];
    return arr;
}

-(void)drawBezierPathLostTopAndBottomBorder:(CGFloat)aPadding
{
    CGFloat padding = aPadding * PIX_TIMES;
    [self drawImgOnGraphics:^(CGSize size){
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint:CGPointMake(padding , 0)];
        [path addLineToPoint:CGPointMake(padding, size.height)];
        [path moveToPoint:CGPointMake(size.width - padding, 0)];
        [path addLineToPoint:CGPointMake(size.width - padding, size.height)];
        path.lineWidth = 0.5 * PIX_TIMES;
        [path stroke];
    }];
}

//画全部边框

-(NSArray *)drawAllBorder
{
   return  [self drawAllBorder:5];
}

-(NSArray *)drawAllBorder:(CGFloat)padding
{
   return  [self drawAllBorder:padding withRadius:0];
}

-(NSArray *)drawAllBorder:(CGFloat)aPadding withRadius:(CGFloat)radius
{
  return  [self drawAllBorder:aPadding withRadius:radius withBorderColor:[UIColor lightGrayColor]];
}

-(NSArray *)drawAllBorder:(CGFloat)aPadding withRadius:(CGFloat)aRadius withBorderColor:(UIColor *)color
{
 return   [self drawAllBorder:aPadding withRadius:aRadius withBorderColor:color drawType:DrawTypeLayerDraw];
}

-(NSArray *)drawAllBorder:(CGFloat)aPadding withRadius:(CGFloat)aRadius withBorderColor:(UIColor *)color drawType:(DrawType)b
{
    switch (b) {
        case DrawTypeLayerDraw:
        {
          return   [self layerDrawAllBorder:aPadding withRadius:aRadius withBorderColor:color];
        }
            break;
        case DrawTypeBezierPathDraw:
        {
          [self drawBezierPathAllBorder:aPadding withRadius:aRadius];
        }
            break;
        default:
            break;
    }
    return nil;
}


-(NSArray *)layerDrawAllBorder:(CGFloat)aPadding withRadius:(CGFloat)aRadius withBorderColor:(UIColor *)color
{
//    NSInteger count = self.layer.sublayers.count;
//    for (int i = 0 ; i < count - 3; i ++) {
//        CALayer *layer = self.layer.sublayers[3];
//        [layer removeFromSuperlayer];
//    }
    
    CALayer *aLayer = [CALayer layer];
    aLayer.frame = CGRectMake(aPadding, aPadding, self.bounds.size.width - 2 * aPadding, self.bounds.size.height  - 2 * aPadding);
    aLayer.borderWidth = 0.5;
    aLayer.borderColor = color.CGColor;
    [self.layer addSublayer:aLayer];
    
    self.layer.masksToBounds = YES;
    NSMutableArray *arr = [NSMutableArray array];
    [arr addObject:aLayer];
    return arr;
}

-(void)drawBezierPathAllBorder:(CGFloat)aPadding withRadius:(CGFloat)aRadius
{
    CGFloat padding = aPadding * PIX_TIMES;
    CGFloat radius = aRadius * PIX_TIMES;
    [self drawImgOnGraphics:^(CGSize size){
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint:CGPointMake(padding + radius, padding)];
        [path addLineToPoint:CGPointMake(size.width - padding - radius, padding)];
        [path addArcWithCenter:CGPointMake(size.width - padding - radius, padding + radius) radius:radius startAngle:M_PI + M_PI_2 endAngle:2 * M_PI clockwise:YES];
        [path addLineToPoint:CGPointMake(size.width - padding, size.height - padding - radius)];
        [path addArcWithCenter:CGPointMake(size.width - padding - radius, size.height - padding - radius) radius:radius startAngle:0 endAngle:M_PI_2 clockwise:YES];
        [path addLineToPoint:CGPointMake(padding + radius, size.height - padding)];
        [path addArcWithCenter:CGPointMake(padding + radius, size.height - padding - radius) radius:radius startAngle:M_PI_2 endAngle:M_PI clockwise:YES];
        [path addLineToPoint:CGPointMake(padding, padding + radius)];
        [path addArcWithCenter:CGPointMake(radius + padding, radius + padding) radius:radius startAngle:M_PI endAngle:M_PI + M_PI_2 clockwise:YES];
        path.lineWidth = 0.5 * PIX_TIMES;
        [path stroke];
    }];
}

-(NSArray *)drawBottomLine
{
  return   [self drawBottomLine:5];
}
-(NSArray *)drawBottomLine:(CGFloat)padding
{
   return  [self drawBottomLine:padding withBorderColor:[UIColor lightGrayColor]];
}

-(NSArray *)drawBottomLine:(CGFloat)padding withBorderColor:(UIColor *)color
{
return  [self drawBottomLineY:(self.frame.size.height - 2) withLeftPadding:padding withRightPading:padding  withBorderColor:color  drawType:DrawTypeLayerDraw];
}

-(NSArray *)drawBottomLineY:(CGFloat)cuy  withLeftPadding:(CGFloat) aPaddingLeft withRightPading:(CGFloat)aPaddingRight withBorderColor:(UIColor *)color drawType:(DrawType)b
{
    switch (b) {
        case DrawTypeLayerDraw:
        {
          return  [self layerDrawBottomLineY:(self.frame.size.height - 2) withLeftPadding:aPaddingLeft withRightPading:aPaddingRight withBorderColor:color];
        }
            break;
        case DrawTypeBezierPathDraw:
        {
             [self drawBezierPathBottomLineY:(self.frame.size.height - 2) withLeftPadding:aPaddingLeft withRightPading:aPaddingRight];
        }
            break;
        default:
            break;
    }
    return nil;
}

-(NSArray *)layerDrawBottomLineY:(CGFloat)cury  withLeftPadding:(CGFloat) aPaddingLeft withRightPading:(CGFloat)aPaddingRight withBorderColor:(UIColor *)color
{
    CALayer *aLayer = [CALayer layer];
    aLayer.frame = CGRectMake(aPaddingLeft + 0.5,cury - 2, self.bounds.size.width - aPaddingLeft - aPaddingRight - 1, 2);
    aLayer.borderWidth = 0.5;
    aLayer.borderColor = color.CGColor;
    [self.layer addSublayer:aLayer];
    
    CALayer *bLayer = [CALayer layer];
    bLayer.frame = CGRectMake(aPaddingLeft + 0.5, cury - 2, self.bounds.size.width  - aPaddingLeft - aPaddingRight - 1, 1.5);
    bLayer.backgroundColor = [UIColor whiteColor].CGColor;
    [self.layer addSublayer:bLayer];
    
    NSMutableArray *arr = [NSMutableArray array];
    [arr addObject:aLayer];
    [arr addObject:bLayer];
    return arr;
}

-(void)drawBezierPathBottomLineY:(CGFloat)cury  withLeftPadding:(CGFloat) aPaddingLeft withRightPading:(CGFloat)aPaddingRight
{
    CGFloat y = cury * PIX_TIMES;
    CGFloat paddingLeft = aPaddingLeft * PIX_TIMES;
    CGFloat paddingRight = aPaddingRight * PIX_TIMES;
    [self drawImgOnGraphics:^(CGSize size){
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint:CGPointMake(paddingLeft, y)];
        [path addLineToPoint:CGPointMake(size.width - paddingRight, y)];
        path.lineWidth = 0.5 * PIX_TIMES;
        [path stroke];
    }];
}
@end
