//
//  MyGridItem.h
//  MiniClient
//
//  Created by oybq on 13-4-17.
//  Copyright (c) 2013年 Wuxi Smart Sencing Star. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CustomCategories.h"



@interface MyGridItem : NSObject
@property(nonatomic,assign) NSInteger padding;           //间隔
@property(nonatomic,strong) UIImage *image;              //图片
@property(nonatomic,strong) UIImage *highlightedImage;   //高亮的图片
@property(nonatomic,strong) UIImage *selectedImage;      //选中图片

//一般来说背景图片和前景图片不要同时设置，而且一般文字要配背景图片，前景图片是不配文字的。
@property(nonatomic,strong) UIImage *backgroundImage;     //背景图片
@property(nonatomic,strong) UIImage *backgroundHighlightedImage;  //背景高亮图片
@property(nonatomic, strong) UIImage *backgroundSelectedImage;   //背景选中图片。

@property(nonatomic,strong) NSString *title;   //标题
@property(nonatomic,copy) NSString *badgeValue; //如果设置了则会在右上角现实角标，如果为nil则不显示。

@property(nonatomic, strong) UIColor *titleColor; //颜色
@property(nonatomic, strong) UIColor *highlightedTitleColor; //高亮颜色，可选
@property(nonatomic, strong) UIColor *selectedTitleColor;    //选中的颜色

@property(nonatomic, strong) UIFont *font;    //字体

@property(nonatomic,strong) UIImage *editingImage; //编辑时的图片
@property(nonatomic, assign) BOOL isRemovable;  //是否可删除
@property(nonatomic, assign) BOOL isEditable;   //是否可编辑

//文字风格，居右，居左，居上，居下，居中。默认是默认
@property(nonatomic, assign) ButtonTitleStyle style;
@end
