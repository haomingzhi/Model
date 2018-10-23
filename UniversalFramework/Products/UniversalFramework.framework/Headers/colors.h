//
//  colors.h
//  SCWCYClient
//  定义系统用到的颜色
//  Created by qiuzq on 14-5-30.
//  Copyright (c) 2014年 SunnadaSoft. All rights reserved.
//

#ifndef SCWCYClient_colors_h
#define SCWCYClient_colors_h


//系统的颜色
#define color_main_bottom_default  0x959595
#define color_main_bottom_press  0xff7c32
#define color_head_bg  0xff7c32
#define color_head_title  0xffffff
#define color_main_bottom_bg  0xf9f9f9
#define color_divider_color  0xcecece
#define color_black  0x000000
#define color_white  0xffffff
#define color_black_item  0x8c8c8c
#define color_red  0xCB2113
#define color_gray  0x9B9C9D
#define color_view_focused  0x55000000
#define color_view_look  0x33000000
#define color_common_bg  0xe9e9e9
#define color_common_color  0xececec
#define color_blue  0x057ce9
#define color_transparent  0x00000000
//粉色
#define color_pink 0xDB4C38


//主色调，导航栏颜色
#define color_mainTheme 0x3c3c3c

#define color_placeHolder 0x777777

#define color_control 0xE8EAEB

#define color_unSelColor 0xaaaaaa

#define color_0xff6b00  0xff6b00

#define color_0xf5f5f5  0xf5f5f5



#define kUIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0  green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define color_PatternImageWithImageName(imageName) [UIColor colorWithPatternImage:[UIImage imageNamed:imageName]]

#define color_PatternImageWithImage(img) [UIColor colorWithPatternImage:img]

#endif
