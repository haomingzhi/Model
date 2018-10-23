//
//  IconAndTitleTableViewCell.h
//  ulife
//
//  Created by air on 15/12/10.
//  Copyright © 2015年 ORANLLC_IOS1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JYAbstractTableViewCell.h"
@interface IconAndTitleTableViewCell : JYAbstractTableViewCell
@property(nonatomic,strong) void (^imgBtnAction)(id sender);
-(void)fitHeadMode;
-(void)fitFavMode;
-(void)fitMsgMode;
-(void)fitSearchModeA;
-(void)fitSearchModeB;
-(void)fitTopicMode;
-(void)fitPayMode:(BOOL)b;
@end
