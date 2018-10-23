//
//  JYDatePickViewController.h
//  yihui
//
//  Created by air on 15/9/24.
//  Copyright (c) 2015年 ORANLLC_IOS1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JYDatePickViewController : UIViewController
@property(nonatomic,strong) void (^callBack)(id obj);
@property(nonatomic,strong) NSString *dateInfo;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;
@property (weak, nonatomic) IBOutlet UIButton *finishBtn;

@property (weak, nonatomic) IBOutlet UIView *backView;
+(JYDatePickViewController*)createLimitVC;
-(void)setMinDate:(NSDate *)minDate;
-(void)setMaxDate:(NSDate *)maxDate;
-(void)setDate:(NSDate *)date;
-(void)fitDateMode;
-(void)fitTimeMode;
-(void)fitVcMode;
-(void)fitDateTimeMode;
@end
