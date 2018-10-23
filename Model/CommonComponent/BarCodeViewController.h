//
//  BarCodeViewController.h
//  compassionpark
//
//  Created by air on 2017/4/11.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BarCodeViewController : UIViewController
@property(nonatomic,strong)void (^handleAction)(id o);
@property(nonatomic,strong)UIViewController *parentVC;
+(BarCodeViewController *)toBarCodeVC:(UIViewController *)parentVC;
@end
