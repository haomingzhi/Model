//
//  JYContainerView.h
//  lovecommunity
//
//  Created by air on 16/6/27.
//  Copyright © 2016年 ORANLLC_IOS1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JYContainerView : UIView
@property(nonatomic,strong)void (^clickHandle)(id);
@property(nonatomic)CGRect clickRect;
 @end
