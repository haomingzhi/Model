//
//  MyActivityVCDelegate.h
//  taihe
//
//  Created by air on 2016/11/8.
//  Copyright © 2016年 ORANLLC_IOS1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JYTableViewDelegate.h"
@interface MyActivityVCDelegate  : NSObject<UITableViewDataSource,UITableViewDelegate,JYTableViewDelegate>
@property(nonatomic,strong)void (^callBack)();
@property(nonatomic,weak)UIViewController *parentVC;@end
