//
//  OnlyBottomBtnTableViewCell.h
//  ChaoLiu
//
//  Created by air on 15/7/27.
//  Copyright (c) 2015年 ORANLLC_IOS1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JYAbstractTableViewCell.h"
#import "BUImageRes.h"

@interface OnlyBottomBtnTableViewCell : JYAbstractTableViewCell
@property(nonatomic,strong) void (^extrHandleAction)(id o);
@property(nonatomic,strong) void (^extrHandleAction2)(id o);
@property(nonatomic,strong) void (^extrHandleAction3)(id o);
//-(void)setCellData:(NSDictionary *)dataDic;
@property(nonatomic,strong)   UIButton *getBtn;
-(void)setPadding:(CGFloat)padding;
-(void)setHeightPadding:(CGFloat)padding;
-(void)setBtnBackgroundColor:(UIColor *)color;
-(void)setBtnTitleColor:(UIColor *)color;
-(void)btnLayer:(BOOL)J;
-(void)decoratorULifeView;

-(void)fitSelledSeverMode;
-(void)fitMyServerApplyMode:(BOOL)upDown;
-(void)fitMyServerApplyModeB;
-(void)fitMyServerApplyModeC;
-(void)fitMyServerApplyModeD:(NSString *)btnName;
-(void)setBtnEnabled:(BOOL)b;
-(void)fitRegMode;
-(void)fitRegModeB;
-(void)fitRegNextMode;
-(void)fitModiPwdMode:(id)target withSel:(SEL)sel;
-(void)fitSendInfoMode;
-(void)fitPersonCerInfoMode;
-(void)fitOrderMode;
-(void)fitRepairsMode:(BUImageRes *)image;
-(void)fitActInfoMode;
-(void)fitWaterInfoMode;
-(void)fitRepairMode;
-(void)fitRepairModeB;
-(void)fitCodeMode;
-(void)fitForgetPwdMode;
-(void)fitConfirmOrderMode;
-(void)fitMyAccountMode;
-(void)fitMyAccountModeB;
-(void)fitSecondCallMode;
-(void)fitMyOrderMode;
-(void)fitSendBackGoodsMode;
-(void)fitSelledSeverModeB;
-(void)fitBuyoutMode;
-(void)fitMyInviteMode;
-(void)fitSignMode;
-(void)fitWithdrawMode;
-(void)fitMyAccountModeC;
-(void)fitUserCardRechargeMode;
-(void)fitMyOrderInfoMode;
-(void)fitModiPhoneMode;
-(void)fitFeedbackMode;
-(void)fitMyHisMode;
-(void)fitInvGetGiftMode;
-(void)fitCouponInfoMode;
-(void)fitPublishEvaMode;
-(void)fitSearchMode;
-(void)fitAddressManagerModeA:(BOOL)isCheck;
-(void)fitAddressManagerModeB;
-(void)fitPublishAnswerMode;
-(void)fitTopicMode;
-(void)fitMyOrderInfoModeB;
-(void)fitCancelOrderInfoA:(BOOL)isCheck;
-(void)fitCancelOrderInfoB;
-(void)fitVIPCenterMode;
-(void)fitGoodsInfoMode;-(void)fitEditNickMode;
-(void)fitApplySalesReturnMode;
-(void)fitMyRunMode;
-(void)fitReplacementConfirmMode;
-(void)fitZhiMaAuthMode;
-(void)fitZhiMaAuthMode;
@end
