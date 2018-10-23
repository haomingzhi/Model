//
//  VIPTipViewController.h
//  oranllcshoping
//
//  Created by air on 2017/7/27.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VIPTipViewController : UIViewController
+(VIPTipViewController *)toVC:(UIViewController *)parentVC;
-(void)selectIndex:(NSInteger)index;
@end
