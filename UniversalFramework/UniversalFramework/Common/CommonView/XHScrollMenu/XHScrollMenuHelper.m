//
//  XHScrollMenuHelper.m
//  JiXie
//
//  Created by ORANLLC_IOS1 on 15/6/1.
//  Copyright (c) 2015年 ORANLLC_IOS1. All rights reserved.
//

#import "XHScrollMenuHelper.h"
#import "colors.h"

@interface XHScrollMenuHelper () <XHScrollMenuDelegate>

@end

@implementation XHScrollMenuHelper
{
    NSArray *myTitles;
    id myTarget;
    SEL myAction;
}
-(XHScrollMenu *) scrollMenuWithTitleAndFrame:(CGRect)frame titles:(NSArray *)titles target:(id)target action:(SEL)action
{
    return [self scrollMenuWithTitleAndFrame:frame titles:titles target:target action:action titleNormalColor:kUIColorFromRGB(color_0xb0b0b0) titleSelectedColor:kUIColorFromRGB(color_3)  markerColor:kUIColorFromRGB(color_3)];
}

-(XHScrollMenu *) scrollMenuWithTitleAndFrame:(CGRect)frame titles:(NSArray *)titles selectIndex:(NSInteger)index target:(id)target action:(SEL)action
{
    return [self scrollMenuWithTitleAndFrame:frame titles:titles selectIndex:(NSInteger)index target:target action:action titleNormalColor:kUIColorFromRGB(color_text) titleSelectedColor:[UIColor redColor] markerColor:[UIColor redColor] showUnderLine:YES];
}

//titles 菜单，target，action：点击回调 normalColor：默认字体颜色，selectedColor：选中字体颜色 markerColor：选中标记颜色
-(XHScrollMenu *) scrollMenuWithTitleAndFrame:(CGRect)frame titles:(NSArray *) titles target:(id)target action:(SEL)action titleNormalColor:(UIColor *) normalColor titleSelectedColor:(UIColor *) selectedColor markerColor:(UIColor *)markerColor;
{
    myTarget = target;
    myAction = action;
    myTitles = titles;
    NSMutableArray *menus = [[NSMutableArray alloc] init];
    XHScrollMenu *scrollMenu = [[XHScrollMenu alloc] initWithFrame:frame];
    scrollMenu.markColor = markerColor;
    scrollMenu.delegate = self;
    for (int i =0; i < myTitles.count; i++) {
        XHMenu *menu = [[XHMenu alloc] init];
        menu.index = i;
        menu.title = myTitles[i];
        menu.titleNormalColor = normalColor;
        menu.titleSelectedColor = selectedColor;
        menu.titleFont = [UIFont systemFontOfSize:13];
        [menus addObject:menu];
    }
    scrollMenu.menus = menus;
    [scrollMenu reloadData];
    //    UILabel *labelUnderLine = [[UILabel alloc] initWithFrame:CGRectMake(0, scrollMenu.frame.size.height -1, scrollMenu.frame.size.width, 1)];
    //    //labelUnderLine.tag=15;
    //    labelUnderLine.backgroundColor = [UIColor colorWithRed:0xd6/255.0 green:0xd6/255.0 blue:0xd6/255.0 alpha:1];
    //    labelUnderLine.tag = 999;
    //    [scrollMenu addSubview:labelUnderLine];
    //    [scrollMenu sendSubviewToBack:labelUnderLine];
    [scrollMenu setSelectedIndex:0 animated:YES calledDelegate:YES];
    return scrollMenu;
}


//titles 菜单，target，action：点击回调 normalColor：默认字体颜色，selectedColor：选中字体颜色 markerColor：选中标记颜色
-(XHScrollMenu *) scrollMenuWithTitleAndFrame:(CGRect)frame titles:(NSArray *) titles selectIndex:(NSInteger)index target:(id)target action:(SEL)action titleNormalColor:(UIColor *) normalColor titleSelectedColor:(UIColor *) selectedColor markerColor:(UIColor *)markerColor showUnderLine:(BOOL) isShowUnderLine
{
    myTarget = target;
    myAction = action;
    myTitles = titles;
    NSMutableArray *menus = [[NSMutableArray alloc] init];
    XHScrollMenu *scrollMenu = [[XHScrollMenu alloc] initWithFrame:frame];
    scrollMenu.markColor = markerColor;
    scrollMenu.delegate = self;
    for (int i =0; i < myTitles.count; i++) {
        XHMenu *menu = [[XHMenu alloc] init];
        menu.index = i;
        menu.title = myTitles[i];
        menu.titleNormalColor = normalColor;
        menu.titleSelectedColor = selectedColor;
        menu.titleFont = [UIFont boldSystemFontOfSize:16];
        [menus addObject:menu];

        //        UILabel *labelUnderLine = [[UILabel alloc] initWithFrame:CGRectMake(scrollMenu.frame.size.width/4.0*i, 2, 1, scrollMenu.frame.size.height -4)];
        //        //labelUnderLine.tag=15;
        //        labelUnderLine.backgroundColor = [UIColor colorWithRed:0xd6/255.0 green:0xd6/255.0 blue:0xd6/255.0 alpha:1];
        //        labelUnderLine.tag = 999;
        //        [scrollMenu addSubview:labelUnderLine];
        //        [scrollMenu sendSubviewToBack:labelUnderLine];

    }
    scrollMenu.menus = menus;
    [scrollMenu reloadData];
    if(isShowUnderLine){
        UILabel *labelUnderLine = [[UILabel alloc] initWithFrame:CGRectMake(0, scrollMenu.frame.size.height -1, scrollMenu.frame.size.width, 1)];
        //labelUnderLine.tag=15;
        labelUnderLine.backgroundColor = [UIColor colorWithRed:0xd6/255.0 green:0xd6/255.0 blue:0xd6/255.0 alpha:1];
        labelUnderLine.tag = 999;
        [scrollMenu addSubview:labelUnderLine];
        [scrollMenu sendSubviewToBack:labelUnderLine];
    }
    [scrollMenu setSelectedIndex:index animated:YES calledDelegate:YES];
    return scrollMenu;
}

#pragma mark --XHScrollMenuDelegate

- (void)scrollMenuDidSelected:(XHScrollMenu *)scrollMenu menuIndex:(NSUInteger)selectIndex
{

    if ([myTarget respondsToSelector:myAction]) {
        SuppressPerformSelectorLeakWarning(
                                           [myTarget performSelector:myAction withObject:scrollMenu.menus[selectIndex]]
                                           );
    }
}
- (void)scrollMenuDidManagerSelected:(XHScrollMenu *)scrollMenu
{

}
@end

