//
//  MyTabBar.h
//  SCWCYClient
//
//  Created by apple on 14-5-22.
//  Copyright (c) 2014年 SunnadaSoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MyTabBar;


@protocol MyTabBarDelegate <NSObject>

@optional
-(void)myTabBar:(MyTabBar*)myTabBar itemSelected:(NSInteger)item;

@end

/**
  自定义TabBar
 **/
@interface MyTabBar : UIControl

@property(nonatomic,weak) id<MyTabBarDelegate> delegate;

@property(nonatomic,assign) NSInteger currentItem;
@property(nonatomic,assign, readonly) NSInteger count;


//添加条目
-(NSInteger)addItem:(NSString*)text normalImage:(UIImage*)normalImage highlightImage:(UIImage*)highlightImage;

//设置某个条目的bagImage。如果为nil则表示取消。
-(void)setItem:(NSInteger)itemIndex badgeImage:(UIImage*)badgeImage;

@end
