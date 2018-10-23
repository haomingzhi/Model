//
//  JYNetLoadingManager.h
//  chenxiaoer
//
//  Created by air on 16/3/31.
//  Copyright © 2016年 ORANLLC_IOS1. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JYNetLoadingManager : NSObject
+(id)manager;
-(void)addLoadingView:(UIView *)tableView  withTip:(NSString *)tip withImg:(UIImage *)img ;
-(void)addLoadingView:(UIView *)tableView  withTip:(NSString *)tip withImg:(UIImage *)img withTag:(NSString *)tag;
-(void)dismissLoadingView;
-(void)dismissLoadingView:(NSString *)tag;
@end
