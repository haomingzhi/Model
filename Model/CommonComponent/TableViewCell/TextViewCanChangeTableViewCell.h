//
//  TextViewCanChangeTableViewCell.h
//  yihui
//
//  Created by air on 15/9/10.
//  Copyright (c) 2015年 ORANLLC_IOS1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JYAbstractTableViewCell.h"
@interface TextViewCanChangeTableViewCell : JYAbstractTableViewCell<UITextViewDelegate>
@property(nonatomic,strong) MyTextView *textView;
@property(nonatomic) CGFloat minHeight;
-(void)fitMode ;
-(void)fitModeB;
-(void)fitModeC;
-(void)fitPublishMode;
-(void)fitRentMode;
-(void)fitRentModeB;
-(void)fitCreateRent;
-(void)fitCreateRentB;
-(void)fitPublishActMode;
-(void)fitApplyUintMode;
-(void)fitAddressMode;
-(void)fitCommentMode;
-(void)fitPersonInfoSettingMode;

-(void)fitFeedbackMode;
-(void)fitWriteEvaluationMode;
-(void)fitPublishEvaMode;
-(void)fitPublishAnswerMode;
-(void)fitPublishSecHandDealMode;
-(void)fitToDoorRecycleMode;
-(void)fitApplySalesReturnMode;
@end
