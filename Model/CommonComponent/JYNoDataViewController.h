//
//  JYNoDataViewController.h
//  yihui
//
//  Created by wujiayuan on 15/9/25.
//  Copyright (c) 2015年 ORANLLC_IOS1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JYNoDataViewController : UIViewController

@property (nonatomic) NSString* noDataHint;
@property (nonatomic) NSString *noDataImageView;
-(void)addNoDataHandleBtn:(NSString*)title;
-(void)fitModeY:(CGFloat)y;
-(void)fitModeY:(CGFloat)y withImgVWidth:(CGFloat)w withViewY:(CGFloat)vy;
@property (nonatomic,strong)void (^handleAction)(id obj);
@end
