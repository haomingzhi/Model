//
//  JYNetErrorManager.h
//  chenxiaoer
//
//  Created by air on 16/3/31.
//  Copyright © 2016年 ORANLLC_IOS1. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JYNetErrorManager : NSObject
+(id)manager;
-(void)dismissErrorView;
-(void)addErrorView:(UIView *)tableView  withTip:(NSString *)tip withImg:(UIImage *)img;
-(void)addErrorView:(UIView *)tableView  withTip:(NSString *)tip withImg:(UIImage *)img withTag:(NSString *)tag;
-(void)addErrorView:(UIView *)tableView  withTip:(NSString *)tip withImg:(UIImage *)img withTag:(NSString *)tag withTarget:(id)target withAction:(SEL)sel;
-(void)dismissErrorView:(NSString *)tag;
-(void)addErrorView:(UIView *)tableView  withTip:(NSString *)tip withImg:(UIImage *)img  withTarget:(id)target withAction:(SEL)sel;
-(void)fitModeY:(CGFloat)y;
-(void)fitModeX:(CGFloat)x;
-(void)fitMode:(CGRect)rect;
-(void)fitModeBY:(CGFloat)y;
@end
