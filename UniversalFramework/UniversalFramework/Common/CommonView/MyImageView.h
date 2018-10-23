//
//  MyImageView.h
//  JiXie
//
//  Created by ORANLLC_IOS1 on 15/7/7.
//  Copyright (c) 2015年 ORANLLC_IOS1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BURes.h"

@interface MyImageView : UIImageView

@property (nonatomic) BURes * imageRes;

-(void) handleDid:(id) sender;

@end
