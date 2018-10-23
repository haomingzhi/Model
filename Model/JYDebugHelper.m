//
//  JYDebugHelper.m
//  ulife
//
//  Created by air on 16/1/21.
//  Copyright © 2016年 ORANLLC_IOS1. All rights reserved.
//

#import "JYDebugHelper.h"
#import "YYKit.h"
static BOOL DebugEnabled = NO;
@implementation JYDebugHelper
+ (void)setDebug:(BOOL)debug {
    YYTextDebugOption *debugOptions = [YYTextDebugOption new];
    if (debug) {
        debugOptions.baselineColor = [UIColor redColor];
        debugOptions.CTFrameBorderColor = [UIColor redColor];
        debugOptions.CTLineFillColor = [UIColor colorWithRed:0.000 green:0.463 blue:1.000 alpha:0.180];
        debugOptions.CGGlyphBorderColor = [UIColor colorWithRed:1.000 green:0.524 blue:0.000 alpha:0.200];
    } else {
        [debugOptions clear];
    }
    [YYTextDebugOption setSharedDebugOption:debugOptions];
    DebugEnabled = debug;
}

+ (BOOL)isDebug {
    return DebugEnabled;
}

+ (void)addDebugOptionToViewController:(UIViewController *)vc {
    UISwitch *switcher = [UISwitch new];
    switcher.layer.transformScale = 0.8;
    
    [switcher setOn:DebugEnabled];
    [switcher addBlockForControlEvents:UIControlEventValueChanged block:^(UISwitch *sender) {
        [self setDebug:sender.isOn];
    }];
    
    UIView *view = [UIView new];
    view.size = CGSizeMake(40, 44);
    [view addSubview:switcher];
    switcher.centerX = view.width / 2;
    switcher.centerY = view.height / 2;
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:view];
    vc.navigationItem.rightBarButtonItem = item;
}
//-(void)initFpsLb
//{
//    _fpsLabel = [YYFPSLabel new];
//    [_fpsLabel sizeToFit];
//    _fpsLabel.y = self.view.height - 110;
//    _fpsLabel.x = 20;
//    _fpsLabel.alpha = 0;
//    [self.view addSubview:_fpsLabel];
//    
// 
//}
//- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
//    if (_fpsLabel.alpha == 0) {
//        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
//            _fpsLabel.alpha = 1;
//        } completion:NULL];
//    }
//}
//
//- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
//    if (!decelerate) {
//        if (_fpsLabel.alpha != 0) {
//            [UIView animateWithDuration:1 delay:2 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
//                _fpsLabel.alpha = 0;
//            } completion:NULL];
//        }
//    }
//}
//
//- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
//    if (_fpsLabel.alpha != 0) {
//        [UIView animateWithDuration:1 delay:2 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
//            _fpsLabel.alpha = 0;
//        } completion:NULL];
//    }
//}

@end
