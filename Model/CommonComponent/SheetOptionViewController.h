//
//  SheetOptionViewController.h
//  taihe
//
//  Created by air on 2016/12/6.
//  Copyright © 2016年 ORANLLC_IOS1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SheetOptionViewController : UIViewController
@property(nonatomic,strong)void (^callBack)(id o);
-(void)fitMode;
+(SheetOptionViewController *)createVC:(UIViewController *)parentVC;
@end
