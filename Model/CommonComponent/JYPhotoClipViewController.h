//
//  JYPhotoClipViewController.h
//  TestYiHui
//
//  Created by wujiayuan on 15/10/29.
//  Copyright (c) 2015年 wujyapp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JYPhotoClipViewController : UIViewController
@property(nonatomic,strong)NSArray *dataArr;
@property (nonatomic) BOOL isPresent;
@property(nonatomic,strong) void(^callBack)(NSArray *);
@property(nonatomic)CGRect clipRect;
- (void)showPickerVc:(UIViewController *)vc;
@end
