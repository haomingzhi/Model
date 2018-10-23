//
//  UMPSpringBoardView.h
//  YinXinBao
//
//  Created by oybq on 13-4-17.
//  Copyright (c) 2013年 Wuxi Smart Sencing Star. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyGridItem.h"
#import "EGORefreshTableHeaderView.h"
#import "EGORefreshTableFooterView.h"



@interface MyGridItemView : UIView

@property(nonatomic,strong) UIButton *btn;         //处理按钮，用户可以在这里调整视图的选中未选择项目
@property(nonatomic, strong) UIView  *customView;   //自定义的视图，用户可以在这里设置选中未选中状态。
@property(nonatomic,strong) MyGridItem *item;
@end



@class MySpringBoardView;


@protocol MySpringBoardViewDataSource <NSObject>

//有多少个条目
-(NSInteger)countOfSpringBoardView:(MySpringBoardView*)sbView;

//每个单元格的SIZE
-(CGSize)itemViewSizeOfSpringBoardView:(MySpringBoardView*)sbView;

@optional
//每个单元格的值
-(MyGridItem*)springBoardView:(MySpringBoardView*)sbView itemAtIndex:(NSInteger)index;

//自定每个单元格的视图，这个与上面的方法互斥，如果定义了自定义视图则优先使用自定义视图。
-(UIView*)springBoardView:(MySpringBoardView*)sbView itemAtIndex:(NSInteger)index showItemView:(MyGridItemView*)itemView;

@end

@protocol MySpringBoardViewDelegate <NSObject>

@optional

//得到删除按钮的图片，包括常规和高亮
-(UIImage*) removeImageOfSpringBoardView:(MySpringBoardView*)sbView;
-(UIImage*) removeHighlightImageOfSpringBoardView:(MySpringBoardView*)sbView;

//删除某个位置的值
-(void)springBoardView:(MySpringBoardView*)sbView didRemovedAtIndex:(NSInteger)index;

//这个会在用户选中前调用取消选中的和最新选中的。
-(void)springBoardView:(MySpringBoardView *)sbView showItemView:(MyGridItemView*)itemView atIndex:(NSInteger)atIndex isSelected:(BOOL)isSelected;


//选择了某个行列，这个函数是在选择了某个条目后调用的。注意，这里面手动调用setSelectedItem是不会激发这个函数调用的。
-(void)springBoardView:(MySpringBoardView *)sbView didSelectedAtIndex:(NSInteger)index;

//移动某个行列
-(void)springBoardView:(MySpringBoardView *)sbView didMovedFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex;

@end

/**
   表格型视图。
 */
@interface MySpringBoardView : UIView<UIScrollViewDelegate>


//设置布局的方式：水平，还是垂直，默认是垂直
@property(nonatomic, assign) NSInteger layoutStyle;
@property(nonatomic, weak) id<MySpringBoardViewDataSource> dataSource;
@property(nonatomic, weak) id<MySpringBoardViewDelegate> delegate;

@property(nonatomic, assign) UIEdgeInsets contentInset;  //内容的缩进
@property(nonatomic, assign) CGFloat vertGap;    //列间距
@property(nonatomic, assign,readonly) CGSize itemSize;
@property(nonatomic, assign, readonly) NSInteger count;  //条目的数量
@property(nonatomic, assign) NSInteger countsPerRow;   //每行的数量，默认是4
@property(nonatomic, assign) NSInteger selectedItem;  //当前选中的位置索引没有选中时默认为-1

//水平间隔图片，垂直间隔图片。

//加载下拉刷新视图。
@property(nonatomic, strong) EGORefreshTableHeaderView *refreshHeaderView;
@property(nonatomic, strong) EGORefreshTableFooterView *refreshFooterView;

@property(nonatomic, assign) BOOL hasMore; //设置是否有更多的数据。默认为NO 如果有则会出现refreshFooter，否则不会！！


//添加下拉加载视图。


//没有数据时指定的视图，以及是否显示这个视图，这个视图的是否显示需要由用户自己控制。
@property(nonatomic, strong) UIView *noDataView;
@property(nonatomic, assign) BOOL showNoDataView;  //是否显示无数据视图，默认是不显示


//重新装载数据
-(void)reloadData;


//控件进行编辑状态如果为YES则编辑状态，为NO则非编辑状态。
-(void)enableEditing:(BOOL)enabled;


//获取某个索引下的条目视图。
-(MyGridItemView*)getItemView:(NSInteger)index;

//设置是否分页
//滚动到指定行
-(void)scrollToRow:(NSInteger)index animated:(BOOL)aniated;

@end
