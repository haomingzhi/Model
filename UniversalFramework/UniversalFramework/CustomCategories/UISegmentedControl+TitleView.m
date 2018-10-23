//
//  UISegmentedControl+TitleView.m
//  MiniClient
//
//  Created by Apple on 14-10-20.
//  Copyright (c) 2014年 SunnadaSoft. All rights reserved.
//

#import "UISegmentedControl+TitleView.h"
#import "UIImage+SeparatorLine.h"
#import "colors.h"

@implementation UISegmentedControl (TitleView)
+(instancetype)segmentedControlWithTitleView:(NSArray *)titles Target:(id)target action:(SEL)action;
{
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc]initWithItems:titles];
    segmentedControl.frame = CGRectMake(0, 0, 200, 32);
    //segmentedControl.segmentedControlStyle = UISegmentedControlStyleBar;
    //点击后是否恢复原样
    segmentedControl.selectedSegmentIndex = 0;
    segmentedControl.multipleTouchEnabled=NO;
    NSDictionary *dicNormal = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"Helvetica" size:15],NSFontAttributeName,[UIColor whiteColor],NSForegroundColorAttributeName,[[NSShadow alloc] init],NSShadowAttributeName, nil];
    
    NSDictionary *dicSelected = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"Helvetica" size:15],NSFontAttributeName,kUIColorFromRGB(color_pink),NSForegroundColorAttributeName,[NSValue valueWithUIOffset:UIOffsetMake(0, 0)],NSShadowAttributeName, nil];
    [segmentedControl setTitleTextAttributes:dicNormal forState:UIControlStateNormal];
    [segmentedControl setTitleTextAttributes:dicSelected forState:UIControlStateSelected];
    
    CGRect imageFrame = CGRectMake(0, 0, segmentedControl.frame.size.width +0, segmentedControl.frame.size.height +0);
    
    [segmentedControl setBackgroundImage:[UIImage ImageWithellipse: imageFrame lineColor:[UIColor whiteColor] fillColor:kUIColorFromRGB(color_pink) offset:0] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];

    [segmentedControl setBackgroundImage:[UIImage ImageWithellipse:segmentedControl.frame lineColor:[UIColor whiteColor] fillColor:kUIColorFromRGB(color_pink) offset:0] forState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
    
    [segmentedControl setBackgroundImage:[UIImage ImageWithellipse:segmentedControl.frame lineColor:[UIColor whiteColor] fillColor:[UIColor whiteColor] offset:0] forState:UIControlStateSelected barMetrics:UIBarMetricsDefault];
    
    [segmentedControl setDividerImage:[UIImage imageWithColor:[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.5] withBounds:CGRectMake(0, 0, 1, segmentedControl.frame.size.height)] forLeftSegmentState:UIControlStateNormal rightSegmentState:UIControlStateNormal barMetrics:UIBarMetricsDefault];

    [segmentedControl addTarget:target action:action forControlEvents:UIControlEventValueChanged];
    return segmentedControl;
}
@end
