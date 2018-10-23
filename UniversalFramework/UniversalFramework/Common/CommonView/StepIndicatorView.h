//
//  SetpIndicator.h
//  UniversalFramework
//
//  Created by ORANLLC_IOS1 on 15/10/29.
//  Copyright (c) 2015年 ORANLLC_IOS1. All rights reserved.
//

#import <UIKit/UIKit.h>


//布局排列的方向
typedef enum : NSUInteger {
    StepIndicatorView_ORIENTATION_VERT,
    StepIndicatorView_ORIENTATION_HORZ,
} StepIndicatorViewOrientation;

@interface StepIndicatorView : UIView

@property (nonatomic,strong) NSArray *stepDescripts;
@property (nonatomic) NSInteger currentStep;
@property (nonatomic,strong) NSArray *normalImages;
@property (nonatomic,strong) NSArray *selectImages;
@property (nonatomic,strong) UIFont *font;
@property (nonatomic,strong) UIColor *normalCorlor,*marketColor;
@property (nonatomic)StepIndicatorViewOrientation orientation;
-(void) setup;

@end
