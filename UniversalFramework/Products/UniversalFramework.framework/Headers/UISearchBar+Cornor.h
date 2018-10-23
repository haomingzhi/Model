//
//  UISearchBar+Cornor.h
//  MeiliWan
//
//  Created by ORANLLC_IOS1 on 15/4/21.
//  Copyright (c) 2015年 oranllc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UISearchBar (Cornor)

+(UIView *)genSearchBar:(UIViewController<UISearchBarDelegate> *)hostvc withSize:(CGSize) size;

@end
