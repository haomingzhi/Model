//
//  OnlyBottomBtnTableViewCell.h
//  ChaoLiu
//
//  Created by air on 15/7/27.
//  Copyright (c) 2015年 ORANLLC_IOS1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableViewCell.h"

#define OneButtonTableViewCell_Title @"Title"
#define OneButtonTableViewCell_TitleColor @"TitleColor"
#define OneButtonTableViewCell_XPadding @"XPadding"
#define OneButtonTableViewCell_YPadding @"YPadding"

@interface OneButtonTableViewCell : BaseTableViewCell
+(NSDictionary *) defaultCellData:(NSString *) title;
//-(void)setPadding:(CGFloat)padding;
//-(void)setHeightPadding:(CGFloat)padding;
//-(void)setBtnBackgroundColor:(UIColor *)color;
//-(void)setBtnTitleColor:(UIColor *)color;
//-(void)btnLayer:(BOOL)J;
@end
