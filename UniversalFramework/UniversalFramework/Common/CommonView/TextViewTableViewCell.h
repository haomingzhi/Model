//
//  TextViewCanChangeTableViewCell.h
//  yihui
//
//  Created by air on 15/9/10.
//  Copyright (c) 2015年 ORANLLC_IOS1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableViewCell.h"


#define TextViewTableViewCell_minHeight @"minHeight"
#define TextViewTableViewCell_text      @"text"
#define TextViewTableViewCell_placeholder @"placeholder"
#define TextViewTableViewCell_tableview @"tableview"

@interface TextViewTableViewCell : BaseTableViewCell<UITextViewDelegate>

@end
