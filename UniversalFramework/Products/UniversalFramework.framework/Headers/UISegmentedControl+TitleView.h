//
//  UISegmentedControl+TitleView.h
//  MiniClient
//
//  Created by Apple on 14-10-20.
//  Copyright (c) 2014年 SunnadaSoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UISegmentedControl (TitleView)

+(instancetype)segmentedControlWithTitleView:(NSArray *)titles Target:(id)target action:(SEL)action;
@end
