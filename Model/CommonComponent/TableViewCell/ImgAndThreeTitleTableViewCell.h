//
//  ImgAndThreeTitleTableViewCell.h
//  taihe
//
//  Created by air on 2016/11/15.
//  Copyright © 2016年 ORANLLC_IOS1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JYAbstractTableViewCell.h"
#import "AddPhotoManager.h"
@interface ImgAndThreeTitleTableViewCell : JYAbstractTableViewCell
@property(nonatomic,strong) void (^imgChangeHandle)(id sender);
@property(nonatomic,strong) IBOutlet UIImageView *imgV;
@property(nonatomic)AddPhotoManager *addPhotoManager;
-(void)fitLiveAndEatMode;//生活餐饮
-(void)fitRentMode;//租房
-(void)fitLiveMode;//拎包入住
-(void)fitMeetingMode;
-(void)fitCleanMode;
-(void)fitGovCenterMode;
-(void)fitNoticeMode;
-(void)fitGreenRentMode;
-(void)fitNetMode;
-(void)fitLawMode;
-(void)fitWarnMode;
-(void)fitapplyUnitMode;
//new
-(void)fitProductMode;
-(void)fitAddressMode;
-(void)fitNoAddressMode;
-(void)fitEvalutionMode;
-(void)fitMyAccountMode;
-(void)fitMyAccountModeB;
-(void)fitExclusiveMode;
-(void)fitTeacherMode;
-(void)fitMyOrderMode;
-(void)fitSureOrderMode;
-(void)fitMsgMode;
-(void)fitMyEvaModeB;
-(void)fitMyEvaModeC;
-(void)fitTalentMode;
-(void)fitActMode;

-(void)fitMyFavMode;
-(void)fitHeadMode;
-(void)fitFillInOrderMode;
-(void)fitOrderAddressMode;
-(void)fitChoseAddressMode:(BOOL) isSelected;
-(void)fitPayOrderMode;
-(void)fitOrderInfoMode;
-(void)fitTraceOrderMode;
-(void)fitSepcialMode;
-(void)fitMyHisMode:(BOOL)isEdit;
-(void)fitSpecialModeA;
-(void)fitSpecialEvalutionMode;
-(void)fitEvaluationInfoMode;
-(void)fitMyEvaMode;
-(void)fitSelledSeverMode;
-(void)fitInvGetGiftMode;
-(void)fitSearchMode;
-(void)fitOddsRecMode;
-(void)fitEvaMode;
-(void)fitEvaInfoMode;
-(void)fitEvaInfoModeA;
-(void)fitAwardDetailMode;
-(void)fitSimilarityGoodsMode;
-(void)fitSeconKillMode;
-(void)fitMyFavModeC;
-(void)fitMyFavModeB;
-(void)fitFavEvaMode;
-(void)fitGoodsInfoMode;
-(void)fitGoodsInfoModeA;
-(void)fitBrandMode;
-(void)fitTopicMode;
-(void)fitTopicModeB;
-(void)fitAnswerInfoMode;
-(void)fitServerListMode;
-(void)fitErrandServerListListMode;
-(void)fitFillInServiceOrderMode;
-(void)fitSearchResultMode;
-(void)fitOptimizationMode;

-(void)fitErrandServerInfoMode;
-(void)fitGoodsMode;
-(void)fitGoodsModeA;
-(void)fitClassifyDetailMode;
-(void)fitCartMode;
-(void)fitCartModeA;
-(void)fitSelectAddressMode;
-(void)fitSelectAddressModeA;
-(void)fitNoCartMode;
-(void)fitPointRankMode;
-(void)fitPointRankModeB;
-(void)fitMySecHandMode;
-(void)fitShopListMode;
-(void)fitShopInfoMode;
-(void)fitRecycleRecMode;
-(void)fitMyfavMode;
-(void)fitMySecHandDealMode;
-(void)fitReplacementConfirmMode;
-(void)fitSelledServerMode;
-(void)fitSecondCallMode;
-(void)fitPayOrderModeB;
-(void)fitNoOrderAddressMode;
-(void)fitNoCashApproveMode;
-(void)toPhoto;
-(void)initAddPhotoManager:(NSInteger)count withImgArr:(NSMutableArray *)aimgArr withVC:(UIViewController *)vc withTableView:(UITableView*)tableView;
-(void)toCheckOption:(id)userInfo;
-(void)delImg:(NSInteger )indexPath;
-(void)delImg:(NSInteger )indexPath withImgArr:(NSArray *)arr;
- (void) setupPhotoBrowser:(NSDictionary *)dic;
@end
