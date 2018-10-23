//
//  MyPageViewController.h
//  ChaoLiu
//
//  Created by ORANLLC_IOS1 on 15/8/27.
//  Copyright (c) 2015年 ORANLLC_IOS1. All rights reserved.
//

#import <UniversalFramework/UniversalFramework.h>

@interface ImageExplorerViewController : JYBaseViewController
-(id) initWithDatasource:(NSArray *) datasource;
//showStyle 显示样式，1--push 2--pop
+(void)showImageList:(NSArray *) images index:(NSInteger) index context:(JYBaseViewController *)context frame:(CGRect) frame style:(NSInteger) showStyle;
@end
