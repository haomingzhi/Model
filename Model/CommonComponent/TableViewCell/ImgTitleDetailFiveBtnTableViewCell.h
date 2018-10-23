//
//  ImgTitleDetailFiveBtnTableViewCell.h
//  chenxiaoer
//
//  Created by air on 2017/2/15.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JYAbstractTableViewCell.h"
@interface ImgTitleDetailFiveBtnTableViewCell : JYAbstractTableViewCell<CWStarRateViewDelegate>
@property(nonatomic,weak) IBOutlet UILabel *detailLb;
-(void)fitCommentMode;
@end
