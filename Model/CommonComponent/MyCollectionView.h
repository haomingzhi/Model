//
//  MyCollectionView.h
//  chenxiaoerSv
//
//  Created by air on 16/5/30.
//  Copyright © 2016年 ORANLLC_IOS1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyCollectionView : UICollectionView

//加载下拉刷新视图。
@property(nonatomic, strong) EGORefreshTableHeaderView *refreshHeaderView;
@property(nonatomic, strong) EGORefreshTableFooterView *refreshFooterView;
@property(nonatomic, strong) NSMutableArray *dataArr;
@property(nonatomic, strong) NSMutableArray *cellArr;
@property(nonatomic, strong) NSMutableArray *extroDataArr;
@property(nonatomic, strong) UIView*  unfoundDataView;
@property(nonatomic, assign) BOOL hasInit;
@property(nonatomic, assign) BOOL isRefreshing;
@property(nonatomic, assign) BOOL hasMore; //设置是否有更多的数据。默认为NO 如果有则会出现refreshFooter，否则不会！！
//添加下拉加载视图。
@property(nonatomic, assign) BOOL headHasMore;
@end
