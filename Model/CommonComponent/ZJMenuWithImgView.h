//
//  ZJMenuWithImgView.h
//  compassionpark
//
//  Created by Steve on 2017/2/6.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZJMenuWithImgView : UIView
@property (nonatomic,strong) UIColor *normalColor;
@property (nonatomic,strong) UIColor *selectedColor;
@property (nonatomic,strong) NSMutableArray *viewsArr;
@property (nonatomic,assign) NSInteger curIndex;
@property (nonatomic,assign) NSInteger sumIndex;
@property (nonatomic,strong) void (^callBack) (id o);
@property (nonatomic,strong) UIImageView *lineImv;
@property (nonatomic,strong) UIImage *selectedImage;
@property (nonatomic,strong) UIImage *NormalImage;
@property (nonatomic,assign) BOOL isShow;
 -(void)setMenuData:(NSArray *)arr;
-(void)setTitle:(NSString *)title index:(NSInteger)index isSelect:(BOOL)isSelected;
@end
