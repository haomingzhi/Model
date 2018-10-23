//
//  SysMsgInfoViewController.h
//  oranllcshoping
//
//  Created by air on 2017/8/4.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import <UniversalFramework/UniversalFramework.h>
#import "BUSystem.h"
@interface SysMsgInfoViewController : BaseTableViewController
@property(nonatomic,strong)BUGetUserMsg *msg;
@property(nonatomic,strong)NSString *msgId;
@end
