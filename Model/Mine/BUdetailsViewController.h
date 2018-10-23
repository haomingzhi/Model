//
//  BUdetailsViewController.h
//  ulife
//
//  Created by sunmax on 16/1/15.
//  Copyright © 2016年 ORANLLC_IOS1. All rights reserved.
//

#import <UniversalFramework/UniversalFramework.h>
typedef enum {
    Notification,//通知详情
    Description//说明详情
}DetailsTpye;

@interface BUdetailsViewController : BaseViewController
@property (nonatomic, strong)NSString *NoticeId;
@property (nonatomic, assign)DetailsTpye type;
@end
