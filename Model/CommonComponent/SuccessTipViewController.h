//
//  SuccessTipViewController.h
//  oranllcshoping
//
//  Created by air on 2017/8/9.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import <UniversalFramework/UniversalFramework.h>

@interface SuccessTipViewController : BaseTableViewController
+(SuccessTipViewController *)toVC:(UIViewController *)parentVC;
-(void)fitSignMode:(NSDictionary *)dic;
@end
