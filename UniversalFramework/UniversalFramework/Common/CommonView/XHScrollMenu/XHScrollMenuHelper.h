//
//  XHScrollMenuHelper.h
//  JiXie
//
//  Created by ORANLLC_IOS1 on 15/6/1.
//  Copyright (c) 2015年 ORANLLC_IOS1. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XHScrollMenu.h"

@interface XHScrollMenuHelper : NSObject

-(XHScrollMenu *) scrollMenuWithTitleAndFrame:(CGRect)frame titles:(NSArray *)titles selectIndex:(NSInteger)index target:(id)target action:(SEL)action;

//titles 菜单，target，action：点击回调 normalColor：默认字体颜色，selectedColor：选中字体颜色 markerColor：选中标记颜色
-(XHScrollMenu *) scrollMenuWithTitleAndFrame:(CGRect)frame titles:(NSArray *) titles selectIndex:(NSInteger)index target:(id)target action:(SEL)action titleNormalColor:(UIColor *) normalColor titleSelectedColor:(UIColor *) selectedColor markerColor:(UIColor *)markerColor showUnderLine:(BOOL) isShowUnderLine;
-(XHScrollMenu *) scrollMenuWithTitleAndFrame:(CGRect)frame titles:(NSArray *)titles target:(id)target action:(SEL)action;

@end
