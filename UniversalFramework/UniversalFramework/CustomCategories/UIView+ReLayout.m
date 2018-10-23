//
//  UIView+ReLayout.m
//  MiniClient
//
//  Created by apple on 14-7-24.
//  Copyright (c) 2014年 SunnadaSoft. All rights reserved.
//

#import "UIView+ReLayout.h"

@implementation UIView (ReLayout)



+(CGFloat)convertHeight:(NSInteger) markedHeight referenceHeight:(NSInteger) refrenceHeight
{
    return (CGFloat)markedHeight /refrenceHeight *__SCREEN_SIZE.height;
}
+(CGFloat)convertwidth:(NSInteger) markedWidth referenceWidth:(NSInteger) refrenceWidth
{
    return (CGFloat)markedWidth /refrenceWidth *__SCREEN_SIZE.width;
}

-(CGFloat)vertShrinkSubview:(UIView*)subview resizeSelf:(BOOL)resizeSelf
{
    UIView *nextView = nil;
    for (int i = 0; i < self.subviews.count; i++)
    {
        UIView* v = [self.subviews objectAtIndex:i];
        if (v == subview)
        {
            if (i + 1 < self.subviews.count)
            {
                nextView = [self.subviews objectAtIndex:i+1];
            }
            
            break;
        }
    }
    
    if (nextView != nil)
    {
        int dir = subview.hidden ? -1 : 1;
        return [self vertInflateSubview:nextView offsetY:dir * subview.frame.size.height resizeSelf:resizeSelf];
    }
    else
        return 0;
    
}

-(CGFloat)horizShrinkSubview:(UIView*)subview resizeSelf:(BOOL)resizeSelf
{
    UIView *nextView = nil;
    for (int i = 0; i < self.subviews.count; i++)
    {
        UIView* v = [self.subviews objectAtIndex:i];
        if (v == subview)
        {
            if (i + 1 < self.subviews.count)
            {
                nextView = [self.subviews objectAtIndex:i+1];
            }
            
            break;
        }
    }
    
    if (nextView != nil)
    {
       return [self horizInflateSubview:nextView offsetX:-1 * subview.frame.size.width resizeSelf:resizeSelf];
    }
    else
        return 0;
    
}

-(CGFloat)vertInflateSubview:(UIView*)subview subViews:(NSArray *) subViews  offsetY:(CGFloat)offsetY resizeSelf:(BOOL)resizeSelf
{
    int i = 0;
    for (; i < subViews.count; i++)
    {
        UIView *v = [subViews objectAtIndex:i];
        if (v == subview)
            break;
    }
    
    for (; i < subViews.count; i++)
    {
        UIView *v = [subViews objectAtIndex:i];
        if (!v.isHidden)
            break;
    }
    
    BOOL bOK = NO;
    for (; i < subViews.count; i++)
    {
        UIView *v = [subViews objectAtIndex:i];
        
        CGRect rect = v.frame;
        rect = CGRectOffset(rect, 0, offsetY);
        v.frame = rect;
        bOK = YES;
    }
    
    if (resizeSelf && bOK)
    {
        CGRect rect = self.frame;
        rect = CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, rect.size.height + offsetY);
        self.frame = rect;
    }
    
    if (bOK)
        return offsetY;
    else
        return 0;
}

-(CGFloat)vertInflateSubview:(UIView*)subview offsetY:(CGFloat)offsetY resizeSelf:(BOOL)resizeSelf
{
    return [self vertInflateSubview:subview subViews:self.subviews offsetY:offsetY resizeSelf:resizeSelf];
    
}

-(CGFloat)horizInflateSubview:(UIView*)subview offsetX:(CGFloat)offsetX resizeSelf:(BOOL)resizeSelf
{
    int i = 0;
    for (; i < self.subviews.count; i++)
    {
        UIView *v = [self.subviews objectAtIndex:i];
        if (v == subview)
            break;
    }
    
    for (; i < self.subviews.count; i++)
    {
        UIView *v = [self.subviews objectAtIndex:i];
        if (!v.isHidden)
            break;
    }

    
    BOOL bOK = NO;
    for (; i < self.subviews.count; i++)
    {
        UIView *v = [self.subviews objectAtIndex:i];
        
        CGRect rect = v.frame;
        rect = CGRectOffset(rect, offsetX, 0);
        v.frame = rect;
        bOK = YES;
    }
    
    if (resizeSelf && bOK)
    {
        CGRect rect = self.frame;
        rect = CGRectMake(rect.origin.x, rect.origin.y, rect.size.width + offsetX, rect.size.height);
        self.frame = rect;
    }
    
    if (bOK)
        return offsetX;
    else
        return 0;

}



@end
