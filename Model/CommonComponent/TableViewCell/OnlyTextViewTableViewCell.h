//
//  OnlyTextViewTableViewCell.h
//  ChaoLiu
//
//  Created by air on 15/8/6.
//  Copyright (c) 2015年 ORANLLC_IOS1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JYAbstractTableViewCell.h"
#import "YYTextView.h"
@interface OnlyTextViewTableViewCell : JYAbstractTableViewCell<UITextViewDelegate>
//@property(nonatomic,strong)MyTextView *textView;
//-(void)setCellData:(NSDictionary *)dataDic;
@property (strong, nonatomic)  MyTextView *textTv;
@property (strong, nonatomic)  YYTextView *textYYTv;
-(void)setYYTextViewHeight:(CGFloat)h;
@property (nonatomic,strong) void (^handleTextViewDidBeginEditing)(id sender);
-(void)setLimit:(NSInteger)num;
-(void)setHiddenWarn:(BOOL)hidden;
-(NSString *)getData;
@end
