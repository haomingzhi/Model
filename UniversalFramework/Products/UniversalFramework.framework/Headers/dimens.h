//
//  dimens.h
//  SCWCYClient
//  定义系统用到的样式常量
//  Created by qiuzq on 14-6-9.
//  Copyright (c) 2014年 SunnadaSoft. All rights reserved.
//

#ifndef SCWCYClient_dimens_h
#define SCWCYClient_dimens_h

//系统使用到的字体大小
#define FONTS_H0 24
#define FONTS_H1 22
#define FONTS_H2 20
#define FONTS_H3 18
#define FONTS_H4 16
#define FONTS_H5 14
#define FONTS_H6 12

//系统使用到的字体
#define FONT_NAME_TITLE @"System-Bold"
#define FONT_NAME_BODY  @"System"

#define FontWithTitle(fontSize) [UIFont boldSystemFontOfSize:fontSize]
#define FontWithBody(fontSize) [UIFont systemFontOfSize:fontSize]


#endif
