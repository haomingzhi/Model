//
//  UILabel+Autosize.h
//  ZhongGengGroup
//
//  Created by luolc's macBook air on 15/4/12.
//  Copyright (c) 2015年 SunnadaSoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Autosize)

//根据text自动计算高度，返回调整的大小
-(NSInteger)autoRelayout:(CGSize) maxSize;
-(NSInteger)autoRelayout;
@end
