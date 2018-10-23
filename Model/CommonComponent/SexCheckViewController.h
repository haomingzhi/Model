//
//  SexCheckViewController.h
//  rentingshop
//
//  Created by air on 2018/3/26.
//  Copyright © 2018年 ORANLLC_IOS1. All rights reserved.
//

#import <UniversalFramework/UniversalFramework.h>

@interface SexCheckViewController : BaseTableViewController
@property(nonatomic,strong) void (^callBack)(id sender);
@property(nonatomic) NSInteger check;
@end
