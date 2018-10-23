//
//  RefuseRefuse ViewController.h
//  compassionpark
//
//  Created by air on 2017/4/10.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RefuseRefuse_ViewController : UIViewController
@property(nonatomic,strong)void (^handleAction)(id o);
@property(nonatomic,strong)UIViewController *parentVC;
+(RefuseRefuse_ViewController *)toRefuseVC:(UIViewController *)parentVC;
@end
