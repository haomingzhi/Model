//
//  JYNodataManager.h
//  chenxiaoer
//
//  Created by air on 16/3/30.
//  Copyright © 2016年 ORANLLC_IOS1. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JYNoDataManager : NSObject
+(id)manager;
-(void)addNodataView:(UIView *)tableView withTip:(NSString *)tip withImg:(NSString *)img withCount:(NSInteger )count;
-(void)addNodataView:(UIView *)view  withTip:(NSString *)tip withImg:(NSString *)img withCount:(NSInteger )count withTag:(NSString *)tag;
-(void)fitModeY:(CGFloat)y;
-(void)fitModeX:(CGFloat)x;
-(void)fitMode:(CGRect)rect;
-(void)fitModeBY:(CGFloat)y;
-(void)fitModeColor:(UIColor*)color;
-(void)dismiss;
-(void)fitModeY:(CGFloat)y withImgVWidth:(CGFloat)w withViewY:(CGFloat)vy;
@end
