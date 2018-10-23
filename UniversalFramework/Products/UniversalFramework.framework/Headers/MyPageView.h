//
//  MyPageView.h
//  MiniClient
//
//  Created by apple on 14-7-13.
//  Copyright (c) 2014年 SunnadaSoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StyledPageControl.h"
//typedef enum
//{
//    PageControlStyleDefault = 0,
//    PageControlStyleThumb = 1
//} PageControlStyle;
//
//@interface MyPageController : UIPageControl
//@property (nonatomic,strong) UIImage *thumbImage;          //默认图片
//@property (nonatomic,strong) UIImage *selectedThumbImage;  //选中图片
//@property (nonatomic) PageControlStyle pageControlStyle;
//
//
//@end

@class MyPageView;

@protocol MyPageViewDelegate <NSObject>

//里面视图的数量。
-(NSInteger)countOfPageView:(MyPageView*)pageView;

//从获取某个位置的视图
-(UIView*)pageView:(MyPageView*)pageView pageFromIndex:(NSInteger)index;

@optional
//单击了某页面视图
-(void)pageView:(MyPageView*)pageView didSelected:(NSInteger)index;

//滑动时某个视图将要显示出来。
-(void)pageView:(MyPageView *)pageView wilDisplayAtIndex:(NSInteger)index;

//已经显示出来了。
-(void)pageView:(MyPageView *)pageView didDisplayAtIndex:(NSInteger)index;

@end


/*
  左右滑动按页面滑动的的视图，可以有循环模式和非循环模式。
 */
@interface MyPageView : UIView

@property(nonatomic, assign) BOOL cycle;  //是否循环显示。必须在reloadData前调用。
@property(nonatomic, weak) id<MyPageViewDelegate> delegate; //委托。
@property(nonatomic, assign) NSInteger currentPageIndex;    //当前页面的索引。
@property(nonatomic, assign, readonly) NSInteger count;     //数量。
@property(nonatomic) BOOL showPageController;               //是否显示页面控制,默认不现实
@property(nonatomic,strong) UIPageControl *pageController;


//重新刷新数据
-(void)reloadData;

//下一页,如果是非循环则到末尾后不会有任何动作。。
-(void)nextPage:(BOOL)animated;

//前一页，如果是非循环则到第一页不会有任何动作。
-(void)prevPage:(BOOL)animated;

-(void)setCurrentPageIndex:(NSInteger)index animated:(BOOL)animated;

//得到指定页面的视图，这个可以用于异步加载成功后的更新处理。
-(UIView*)pageFromIndex:(NSInteger)index;

@end
