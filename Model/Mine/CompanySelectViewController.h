//
//  CompanySelectViewController.h
//  taihe
//
//  Created by air on 2016/11/15.
//  Copyright © 2016年 ORANLLC_IOS1. All rights reserved.
//

#import <UniversalFramework/UniversalFramework.h>

@interface CompanySelectViewController : BaseTableViewController
@property(nonatomic,strong) void (^callBack)(id o);
@property(nonatomic,strong)id userInfo;
@end
