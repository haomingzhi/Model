//
//  JYInputViewController.h
//  ulife
//
//  Created by air on 16/1/9.
//  Copyright © 2016年 ORANLLC_IOS1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YYTextView.h"
@protocol JYInputViewDelegate<NSObject>
@optional
-(void)JYInputViewhandleAction:(YYTextView *)textView;
-(void)JYListBtnHandleAction:(UIButton *)btn withIndex:(NSInteger)index;
-(void)JYBeginEditing:(YYTextView *)textView;
-(void)JYEndEditing:(YYTextView *)textView;
//-(UIView *)getParentView;
-(void)keyBoardViewHeightChange:(CGFloat)height;
@end


@interface JYInputViewController : UIViewController
@property(nonatomic,weak)id<JYInputViewDelegate> delegate;
-(void)setBtnListImgs:(NSArray *)imgArr withTitles:(NSArray *)tArr;
-(void)setPlaceholderText:(NSString *)str;
-(void)setCommentMode;
-(void)setAddWordMode:(YYTextView *)textView;
-(void)breakTextView;
-(void)setEmotionViewHeight:(CGFloat)height;
-(void)focurs;
@end
