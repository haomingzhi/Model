//
//  UIButton+Pop.h
//  MeiliWan
//
//  Created by ORANLLC_IOS1 on 15/4/30.
//  Copyright (c) 2015年 oranllc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Pop)

@property (nonatomic) NSArray * popArray;

-(void) setPopAttribute:(NSArray *)popArray completed:(void(^)(NSInteger selected))completed;

@end
