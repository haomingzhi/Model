//
//  MeetingInfoViewController.h
//  taihe
//
//  Created by air on 2016/11/14.
//  Copyright © 2016年 ORANLLC_IOS1. All rights reserved.
//

#import <UniversalFramework/UniversalFramework.h>

@interface MeetingInfoViewController : BaseTableViewController
@property(nonatomic)NSInteger mode;
@property(nonatomic)NSInteger type;
@property(nonatomic,strong)id userInfo;
- (IBAction)reserveAction:(UIButton *)sender;
@end
