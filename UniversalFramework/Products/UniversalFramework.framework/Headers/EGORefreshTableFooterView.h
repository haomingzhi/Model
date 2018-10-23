//
//  EGORefreshTableFooterView.h
//  MiniClient
//
//  Created by apple on 14-7-13.
//  Copyright (c) 2014年 SunnadaSoft. All rights reserved.
//

#import <UIKit/UIKit.h>

#define FOOTER_TEXT_COLOR	 [UIColor colorWithRed:87.0/255.0 green:108.0/255.0 blue:137.0/255.0 alpha:1.0]


typedef enum{
    EGOOPushRefreshNormal = 0,  //正常.
	EGOPushRefreshLoading = 1,  //正在加载
} EGOPushRefreshState;


@class EGORefreshTableFooterView;

//上拉刷新必须要实现这几个接口协议
@protocol EGORefreshTableFooterDelegate<NSObject>

@required
- (void)egoRefreshTableFooterDidTriggerRefresh:(EGORefreshTableFooterView*)view;

@optional

//给用户一次机会，当滚动条往上走不出现加载更多时是否继续请求，如果是YES则继续，如果是NO则不继续。
- (BOOL)egoRefreshTableFooterDataSourceIsLoading:(EGORefreshTableFooterView*)view;

@end



@interface EGORefreshTableFooterView : UIView

@property(nonatomic,weak) id <EGORefreshTableFooterDelegate> delegate;
@property(nonatomic, strong) NSString *statusLabelText;  //状态文本的内容。
//设置是否显示正在加载的视图
@property(nonatomic) BOOL showLoading;
//设置状态文本和设置当前是否显示loading视图。
-(void)setStatusText:(NSString*)text;


- (void)resetState:(BOOL)canRetry;   //恢复为正常状态,canRetry表示是否可以重试

//用户不需要自己调用。系统自己调用
- (void)egoRefreshScrollViewDidScroll:(UIScrollView *)scrollView;
- (void)egoRefreshScrollViewDidEndDragging:(UIScrollView *)scrollView;

@end
