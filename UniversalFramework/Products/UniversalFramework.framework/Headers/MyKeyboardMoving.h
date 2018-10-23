//
//  MyKeyboardMoving.h
//  MiniClient
//
//  Created by apple on 14-7-20.
//  Copyright (c) 2014年 SunnadaSoft. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 键盘移动
 */
@interface MyKeyboardMoving : NSObject

-(id)initWithOwner:(UIView*)txtView;


@property(nonatomic, weak) UIView *kbMovingView;
@property(nonatomic) NSInteger extraHeight;

- (void)addObserverAndGesture;
- (void)removeObserverAndGesture;

@end
