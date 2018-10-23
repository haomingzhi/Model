//
//  JYContainerView.m
//  lovecommunity
//
//  Created by air on 16/6/27.
//  Copyright © 2016年 ORANLLC_IOS1. All rights reserved.
//

#import "JYContainerView.h"
#import "AppDelegate.h"
@implementation JYContainerView
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    UIView  *hitView;
    
  
    if([(AppDelegate *)[UIApplication sharedApplication].delegate isEdit])
    {
        
        if (CGRectContainsPoint([(AppDelegate *)[UIApplication sharedApplication].delegate kbRect], point))
        {
            return [super hitTest:point withEvent:event];
        }
        else
        {
        [self.superview.superview.superview endEditing:YES];
    [self endEditing:YES];
//        [(AppDelegate *)[UIApplication sharedApplication].delegate setIsEdit:NO];
            if (_clickHandle) {
                if (CGRectContainsPoint(self.clickRect, point))
                {
                _clickHandle(nil);
                }
            }

        return nil;
        }
    }
      hitView = [super hitTest:point withEvent:event];
    if (_clickHandle) {
        if (CGRectContainsPoint(self.clickRect, point))
        {
             _clickHandle(hitView);
        }
    }
    return (hitView);
}
@end
