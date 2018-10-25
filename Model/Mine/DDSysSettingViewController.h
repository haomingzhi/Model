//
//  DDSysSettingViewController.h
//  DDZX_js
//
//  Created by apple on 2018/8/23.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DDSysSettingViewController : UIViewController
@property (nonatomic, copy, setter=loginoutBlock:) void (^loginoutBlock)(void);
@end
