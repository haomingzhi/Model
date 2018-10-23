//
//  CancelOrderViewController.h
//  oranllcshoping
//
//  Created by air on 2017/8/16.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import <UniversalFramework/UniversalFramework.h>

@interface CancelOrderViewController : BaseTableViewController
@property(nonatomic,strong)NSArray *dataArr;
+(CancelOrderViewController *)toVC:(NSArray*)dataArr;
@end
