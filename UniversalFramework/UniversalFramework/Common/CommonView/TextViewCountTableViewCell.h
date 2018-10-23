//
//  OnlyTextViewTableViewCell.h
//  ChaoLiu
//
//  Created by air on 15/8/6.
//  Copyright (c) 2015年 ORANLLC_IOS1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableViewCell.h"
@interface TextViewCountTableViewCell : BaseTableViewCell<UITextViewDelegate>
//@property(nonatomic,strong)MyTextView *textView;
//-(void)setCellData:(NSDictionary *)dataDic;

@property (nonatomic,strong) void (^handleTextViewDidBeginEditing)(id sender);
@end
