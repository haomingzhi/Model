//
//  JYBaseScrollView.m
//  yihui
//
//  Created by air on 15/9/10.
//  Copyright (c) 2015年 ORANLLC_IOS1. All rights reserved.
//

#import "JYBaseScrollView.h"

@implementation JYBaseScrollView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
//- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
//{
//    return  [super.panGestureRecognizer.delegate gestureRecognizerShouldBegin:gestureRecognizer];
//}
//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
//{
//    return [super.panGestureRecognizer.delegate gestureRecognizer:gestureRecognizer shouldReceiveTouch:touch];
//}
//
//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldBeRequiredToFailByGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
//{
//    return [super.panGestureRecognizer.delegate gestureRecognizer:gestureRecognizer shouldBeRequiredToFailByGestureRecognizer:otherGestureRecognizer];
//}

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    if (gestureRecognizer.state != 0 && gestureRecognizer && gestureRecognizer.state != UIGestureRecognizerStateFailed && self.contentOffset.x <= 0)
    {
        
        return  YES;
    }
    else
    {
        return NO;
    }
}
@end
