//
//  TextConfirmViewController.h
//  taihe
//
//  Created by air on 2016/12/6.
//  Copyright © 2016年 ORANLLC_IOS1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TextConfirmViewController : UIViewController
@property(nonatomic,strong)void (^callBack)(id o);
+(TextConfirmViewController *)createVC:(UIViewController *)parentVC;
@property (strong, nonatomic) IBOutlet MyTextView *textView;
-(void)fitMode;
@end
