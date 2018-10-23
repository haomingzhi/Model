//
//  UISearchBar+Cornor.m
//  MeiliWan
//
//  Created by ORANLLC_IOS1 on 15/4/21.
//  Copyright (c) 2015年 oranllc. All rights reserved.
//

#import "UISearchBar+Cornor.h"
#import "colors.h"

@implementation UISearchBar (Cornor)


+(MySearchBar *)getSearchBar :(CGSize ) size
{
    MySearchBar *searchBar = [[MySearchBar alloc] initWithFrame:CGRectMake(0, 0, size.width , size.height)];
    searchBar.tag = 9999;
    //[searchBar setBarTintColor:[UIColor colorWithRed:254/255.0 green:64/255.0 blue:61/255.0 alpha:1]];
    [searchBar setBarTintColor:[UIColor whiteColor]];
    searchBar.backgroundColor = [UIColor whiteColor];
    searchBar.barStyle = UIBarStyleBlackTranslucent;
    searchBar.translucent = YES;
    searchBar.placeholder = @"请输入关键字";
    [searchBar corner:[UIColor grayColor] radius:4];
    return searchBar;
}

+(UIView *)genSearchBar:(UIViewController<UISearchBarDelegate> *)hostvc withSize:(CGSize)size
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, size.width , size.height)];
    [view corner:[UIColor grayColor]];
    MySearchBar *searchBar = [[MySearchBar alloc] initWithFrame:CGRectMake(0, 0, size.width , size.height)];
    searchBar.tag = 9999;
    [searchBar setBarTintColor:[UIColor colorWithRed:254/255.0 green:64/255.0 blue:61/255.0 alpha:1]];
    searchBar.barStyle = UIBarStyleBlackTranslucent;
    searchBar.translucent = YES;
    searchBar.delegate = hostvc;
    searchBar.placeholder = @"快速查找商品";
    [view addSubview:searchBar];
    hostvc.navigationItem.titleView = view;
    return view;
    
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, size.width , size.height+14)];
//    view.backgroundColor = [UIColor clearColor];
//    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 7, size.width , size.height)];
//    searchBar.tag = 9999;
//    [searchBar setBarTintColor:[UIColor colorWithRed:254/255.0 green:64/255.0 blue:61/255.0 alpha:1]];
//    searchBar.barStyle = UIBarStyleBlack;
//    searchBar.translucent = YES;
//    searchBar.delegate = hostvc;
//    searchBar.placeholder = @"搜索";
//    //searchBar.layer.cornerRadius = 2;
////    searchBar.layer.masksToBounds = YES;
//    [searchBar.layer setBorderWidth:2];
//    [searchBar.layer setBorderColor:[UIColor whiteColor].CGColor];
//    [view addSubview:searchBar];
//    hostvc.navigationItem.titleView = view;
//    return view;
}


-(void)setCustomBackground:(UIColor *)color
{
    UIView *vs = [self  subviews][0];
    vs.backgroundColor = color;
    vs.superview.backgroundColor = color;
    [[vs subviews] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        //       NSString  *v = NSStringFromClass([obj class]);
        //       if ( [v isEqualToString:@"UISearchBarTextField"]) {
        
        ((UIView *)obj).backgroundColor = color;
        //       }
    }];
}

@end
