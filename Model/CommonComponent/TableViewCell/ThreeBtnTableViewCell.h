//
//  ThreeBtnTableViewCell.h
//  ulife
//
//  Created by air on 15/12/22.
//  Copyright © 2015年 ORANLLC_IOS1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JYAbstractTableViewCell.h"
@interface ThreeBtnTableViewCell : JYAbstractTableViewCell
-(void)fitMode;
-(void)fitHeadMode:(NSString *)defaultImg;
-(void)fitInfoSettingMode;
-(void)fitShareMode;
-(UIButton *)getBtn:(NSInteger)index;
-(void)fitMyYoubiMode;
-(void)fitVipCenterMode;
-(void)fitLuckMode;
-(void)fitSubmitSuccessMode;
-(void)fitPopularityRecMode;
-(void)fitBrandMakeShopMode;
-(void)fitVipHelpModeA;
-(void)fitVipHelpModeB:(CGFloat)height;
-(void)fitCheckAddressMode:(BOOL)isCheck;
-(void)fitClassifyMode;
-(void)fitMineMode;
-(void)fitRecycleRecMode;
@end
