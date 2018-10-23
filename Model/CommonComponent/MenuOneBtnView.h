//
//  MenuOneBtnView.h
//  oranllcshoping
//
//  Created by air on 2017/7/28.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuOneBtnView : UIView
@property(nonatomic,strong)UIButton *btn;
@property(nonatomic,strong)UILabel *lineLb;
-(void)fitMode:(BOOL)isEdit;
@end
