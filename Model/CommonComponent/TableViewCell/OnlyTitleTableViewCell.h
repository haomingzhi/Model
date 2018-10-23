//
//  PayWayTitleTableViewCell.h
//  ChaoLiu
//
//  Created by air on 15/7/21.
//  Copyright (c) 2015年 ORANLLC_IOS1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JYAbstractTableViewCell.h"
@interface OnlyTitleTableViewCell : JYAbstractTableViewCell
-(void)setNull;
//-(void)setCellData:(NSDictionary *)dataDic;
-(void)fitSheetMode;
-(void)fitSheetModeB;
-(void)fitMyAccountMode;
-(void)fitMyAccountModeB;
-(void)fitCodeMode;
-(void)fitMyActivityModeB;
-(void)fitMyActivityMode;
-(void)fitMyRantInfoMode;
-(void)fitMyRantInfoModeB;
-(void)fitServerInfoStateMode;
-(void)fitImgTipMode;
-(void)fitSendInfoMode;
-(void)fitRantInfoMode;
-(void)fitUserCerMode;
-(void)fitPersonInfoMode;
-(void)fitCerModeB;
-(void)fitShareMode;
//-(void)fitCerCompanyMode;
//-(void)fitRepairMode;
//-(void)fitRepairModeB;
-(void)fitUpPersonInfoModeC;
-(void)fitUpPersonInfoModeB;
-(void)fitUpPersonInfoMode;
-(void)fitPersonCerInfoMode;
//-(void)fitCompanyCerMode;
//-(void)fitCompanyInfoMode;
-(void)fitMeetingInfoMode;
-(void)fitCerInfoMode;
-(void)fitPublishActMode;
-(void)fitFuctionListMode;
-(void)fitPublishMode;
-(void)fitDesignTitleMode;
-(void)fitActInfoMode;
-(void)fitActInfoModeB;
-(void)fitNoticeInfoMode;
-(void)fitNoticeInfoModeB;
-(void)fitUserCerTipMode;
//-(void)fitCerFailTipMode;
-(void)setCenterMode:(CGFloat)height withY:(CGFloat)y;
//-(void)fitSendInfoModeB;
//-(void)fitSendInfoModeC;
-(void)fitServerInfoStateModeB;
-(void)fitLiveMode;
-(void)fitTipMode;
-(void)fitTipModeB;
-(void)fitSecondCallMode;
-(void)fitSecondCallModeB;
-(void)fitSecondCallModeC;
-(void)fitSendBackGoodsModeB;
-(void)fitSendBackGoodsMode;
-(void)fitCerFailTipModeB;
-(void)fitOrderInfoMode;
-(void)fitGoodsInfoMode;
-(void)fitMenuSelectionMode;
-(void)fitHasSeeClassMode;
-(void)fitClassMode;
-(void)fitPayPwdMode;
-(void)fitPayPwdModeB;
-(void)fitSignModeA;
-(void)fitSignModeB;
-(void)fitSignModeC;
-(void)fitInfoSettingMode;
-(void)fitPersonMode;
-(void)fitExamTicketMode;
-(void)fitExamTicketModeB;
-(void)fitCommentMode;
-(void)fitPersonInfoSettingMode;
-(void)fitPersonInfoSettingModeB;
-(void)fitWithdrawModeB;
-(void)fitWithdrawMode;
-(void)fitUserCardRechargeMode;
-(void)fitUserCardRechargeModeB;
-(void)fitMyInviteMode;
-(void)fitQusetionMode;
-(void)fitSeverCenterMode;
-(void)fitHeadMode;
-(void)fitHeadModeB;
-(void)fitFeedbackModeB;
-(void)fitFeedbackMode;
-(void)fitTaskCenterMode;
-(void)fitOrderInfoModeA;
-(void)fitOrderInfoModeB;
-(void)fitVipCenterModeA;
-(void)fitVipCenterModeB;
-(void)fitTraceOrderMode;
-(void)fitSpecialInfoMode;
-(void)fitSpecialInfoModeA;
-(void)fitSpecialInfoModeB;
-(void)fitSpecialInfoModeC;
-(void)fitSpecialInfoModeD;
-(void)fitAuditProgressMode;
-(void)fitApplyReturnMode;
-(void)fitApplyReturnModeB;
-(void)fitSubmitSuccessMode;
-(void)fitRecordInfoModeA;
-(void)fitRecordInfoModeB;
-(void)fitRecordInfoModeC;
-(void)fitInvGetGiftMode;
-(void)fitCouponInfoModeA;
-(void)fitCouponInfoModeB;
-(void)fitCouponInfoModeC;
-(void)fitCouponInfoModeD;
-(void)fitClasstifyMode;
-(void)fitClassifyTitleMode;
-(void)fitSeverMsgMode;
-(void)fitSeverMsgModeA;
-(void)fitSeverMsgModeB;
-(void)fitSysMsgModeA;
-(void)fitSysMsgModeB;
-(void)fitActMsgMode;
-(void)fitActMsgModeA;
-(void)fitActMsgModeB;
-(void)fitPublishEvaMode;
-(void)fitSearchModeB;
-(void)fitSearchMode;
-(void)fitOddsRecMode;
-(void)fitEvaMode;
-(void)fitEvaModeA;
-(void)fitEvaModeB;
-(void)fitEvaInfoMode;
-(void)fitAwardDetailMode;
-(void)fitSimilarityGoodsMode;
-(void)fitSysMsgInfoMode;
-(void)fitVipHelpMode:(CGFloat)y withTitleHeight:(CGFloat)height withH:(CGFloat)h withTitleColor:(UIColor *)color;
-(void)fitQuestionMode;
-(void)fitSecKillMode;
-(void)fitAboutUsModeA;
-(void)fitAboutUsModeB;
-(void)fitEvaModeD;
-(void)fitEvaRuleMode;
-(void)fitBrandMode:(BOOL)isShowMore;
-(void)fitPublishAnswerMode;
-(void)fitTopicMode;
-(void)fitTopicModeB;
-(void)fitTopicModeC;
-(void)fitTopicModeD;
-(void)fitTopicModeE;
-(void)fitCancelOrderModeA;
-(void)fitCancelOrderModeB;
-(void)fitCancelOrderModeC;
-(void)fitHtmlMode;
-(void)fitCartMode;
-(void)fitCartModeA;
-(void)fitSelectAddressMode;
-(void)fitServerInfoMode;
-(void)fitRegMode;
-(void)fitPointRankMode;
-(void)fitRecycleRecMode;
-(void)fitPublishSecHandMode;
-(void)fitPublishSecHandModeB;
-(void)fitApplySalesReturnMode;
-(void)fitApplySalesReturnModeB;
-(void)fitApplySalesReturnModeC;
-(void)fitMyRunMode;
-(void)fitMyRunModeB;
-(void)fitMyRunModeC;
-(void)fitMyRunModeD;
-(void)fitReplacementMode;
-(void)fitReplacementModeB;
-(void)fitReplacementConfirmMode;
-(void)fitReplacementOrderInfoMode;
-(void)fitRecycleInfoMode;
-(void)fitToDoorRecMode;
-(void)fitToDoorRecModeB;
-(void)fitReplacementOrderInfoModeB;
-(void)fitToDoorRecModeC;
-(void)fitDiscoveMode;
-(void)fitDiscoveModeB;
-(void)fitZhiMaAuthMode;
-(void)fitZhiMaAuthModeB;
@end
