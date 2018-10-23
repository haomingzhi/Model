//
//  TwoTabsTableViewCell.h
//  ulife
//
//  Created by air on 15/12/17.
//  Copyright © 2015年 ORANLLC_IOS1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JYAbstractTableViewCell.h"
@interface TwoTabsTableViewCell : JYAbstractTableViewCell
-(void)setSelectLineHidden:(BOOL)b;
-(void)setCurBtnIndex:(NSInteger)curBtnIndex;
@property(nonatomic)  NSInteger curIndex;
//-(void)setLineHidden:(BOOL)b;
@property(nonatomic,strong) UIColor *unSelectBgColor;
@property(nonatomic,strong) UIColor *selectBgColor;
@property(nonatomic,strong) void(^tabOneCallBack)(id o);
@property(nonatomic,strong) void(^tabTwoCallBack)(id o);
@property(nonatomic,strong) NSIndexPath *curIndexPath;
-(void)fitMyActivityMode;
-(void)fitCerMode;
-(void)fitHeadMode;
-(void)fitRepairsMode;
-(void)fitHeadModeB;
-(void)fitMyfavMode;
-(void)fitOrderMode;
-(void)fitClassRegOrderMode;
-(void)fitMyAccountMode;
-(void)fitMyInviteMode;
-(void)fitCheckAddressMode:(BOOL)isCheck;
-(void)fitPersonInfoSettingMode;
-(void)fitOrderInfoForTeacherMode;
-(void)fitOrderInfoForTeacherModeB;
-(void)fitTaskCenterMode;
-(void)fitModiPhoneMode:(NSInteger)index;
-(void)fitSeverCenterMode;
-(void)fitSignMode;
-(void)fitFreshRecMode;
-(void)fitInvGetGiftMode;
-(void)fitAwardDetailMode;
-(void)fitVIPHelpMode;
-(void)fitVipCenterMode;
-(void)fitVipCenterModeB;
-(void)fitMySecHandMode;
-(void)fitMySecHandDealMode;
-(void)fitMySecHandDealModeB;
-(void)fitPublishSecHandMode;
-(void)fitToDoorRecycleMode;
-(void)fitReplacementConfirmMode;
-(void)fitReplacementOrderInfoMode;
-(void)fitToDoorRecycleModeB;
-(void)fitReplacementConfirmModeB;
@end
