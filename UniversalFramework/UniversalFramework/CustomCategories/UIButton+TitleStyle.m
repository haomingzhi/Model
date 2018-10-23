//
//  UIButton+TitleStyle.m
//  MiniClient
//
//  Created by apple on 14-7-13.
//  Copyright (c) 2014年 SunnadaSoft. All rights reserved.
//

#import "UIButton+TitleStyle.h"
#import <objc/runtime.h>
@implementation UIButton (TitleStyle)

-(void)setButtonTitleStyle:(ButtonTitleStyle)style padding:(CGFloat)padding
{
    if (style != ButtonTitleStyleDefault && self.imageView.image != nil && self.titleLabel.text != nil)
    {
        //默认是图片居中
        CGSize btnSz = self.bounds.size;
        CGSize imageSz = self.imageView.bounds.size;
        CGSize titleSz = self.titleLabel.bounds.size;
        titleSz = titleSz.height ==0 ? [self.titleLabel.text size:self.titleLabel.font constrainedToSize:btnSz] : titleSz;
        if (style == ButtonTitleStyleBottom || style == ButtonTitleStyleTop) {
            if (imageSz.height + titleSz.height > btnSz.height) {
                CGSize imgsz = CGSizeMake(btnSz.height - titleSz.height > imageSz.width ? imageSz.width : btnSz.height - titleSz.height, btnSz.height - titleSz.height > imageSz.width ? imageSz.width : btnSz.height - titleSz.height);
                [self setImage:[[self imageForState:UIControlStateNormal ] imageToSize:imgsz] forState:UIControlStateNormal];
                [self setImage:[[self imageForState:UIControlStateSelected ] imageToSize:imgsz] forState:UIControlStateSelected];
                [self setTitle:self.titleLabel.text forState:UIControlStateNormal];
            }
            titleSz = CGSizeMake(btnSz.width - self.imageView.frame.origin.x *3 - self.imageView.frame.size.width, ceil(titleSz.height));
            imageSz = self.imageView.bounds.size;
        }
        
        CGFloat lri = (btnSz.width - imageSz.width - titleSz.width)/2;
        CGFloat tbii = (btnSz.height -imageSz.height) / 2;
        CGFloat tbti = (btnSz.height - titleSz.height) / 2;
        
        switch (style) {
            case ButtonTitleStyleLeft:
                //默认属性不用改动。。。。
                break;
            case ButtonTitleStyleRight:
            {
                //暂时不实现。。。。
                
                //文字往左移图片大小的位置
                self.titleEdgeInsets = UIEdgeInsetsMake(0,
                                                        -1 * (btnSz.width - self.titleLabel.frame.origin.x) + lri * 2 ,
                                                        0,
                                                        0);
                
                self.imageEdgeInsets = UIEdgeInsetsMake(0,
                                                        btnSz.width - 2 *imageSz.width - lri + padding,
                                                        0,
                                                        0);
                
                
                
            }
                break;
            case ButtonTitleStyleTop:
            {
                
                //图片部分往上移动，而且要左右居中
                
                self.titleEdgeInsets = UIEdgeInsetsMake(-1*tbti + padding,
                                                        -1 * imageSz.width,
                                                        tbti - padding,
                                                        0);
                
                self.imageEdgeInsets = UIEdgeInsetsMake(tbii - padding,
                                                        btnSz.width / 2  - lri  - imageSz.width / 2,
                                                        -1 * tbii + padding,
                                                        -1*(btnSz.width / 2  - lri  - imageSz.width / 2));
            }
                break;
            case ButtonTitleStyleBottom:
            {
                self.titleEdgeInsets = UIEdgeInsetsMake(tbti - padding,
                                                        -1 * imageSz.width,
                                                        -1*tbti + padding,
                                                        0);
                //图片部分往上移动，而且要左右居中
                self.imageEdgeInsets = UIEdgeInsetsMake(-1 * tbii + padding,
                                                        btnSz.width / 2  - lri  - imageSz.width / 2,
                                                        tbii - padding,
                                                        -1*(btnSz.width / 2  - lri  - imageSz.width / 2));
                
            }
                break;
            case ButtonTitleStyleCenter:
            {
                self.titleEdgeInsets = UIEdgeInsetsMake(0,
                                                        -1 * imageSz.width,
                                                        0,
                                                        0);
                //图片部分往上移动，而且要左右居中
                self.imageEdgeInsets = UIEdgeInsetsMake(0,
                                                        btnSz.width / 2  - lri  - imageSz.width / 2,
                                                        0,
                                                        -1*(btnSz.width / 2  - lri  - imageSz.width / 2));
                
            }
                break;
            default:
                break;
        }
        
        
    }
    
    
}

-(UIImageView *)customImgV
{
    UIImageView *img1 = [self viewWithTag:3322];
    if (!img1) {
        img1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.width - 30, 46)];
        img1.tag = 3322;
        img1.x = 15;
        img1.y = 10;
        [self addSubview:img1];
    }
    
    return img1;
}

-(void)setCustomImgV:(UIImageView *)customImgV
{
    customImgV.tag = 3322;
    [self addSubview:customImgV];
}

-(UILabel *)customTitleLb
{
    UILabel *detail1 = [self viewWithTag:3222];
    if (!detail1) {
        detail1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.width, 16)];
        detail1.tag = 3222;
        detail1.x = 0 ;
        detail1.y = self.height - 25;
        detail1.text = self.titleLabel.text;
        detail1.font = [UIFont systemFontOfSize:14];
        detail1.textColor =  kUIColorFromRGB(color_1);
        
        detail1.textAlignment = NSTextAlignmentCenter;
        [self addSubview:detail1];
    }
    return detail1;
}

-(void)setCustomTitleLb:(UILabel *)customTitleLb
{
    customTitleLb.tag = 3222;
    [self addSubview:customTitleLb];
}

-(UILabel *)customDetailLb
{
    UILabel *detail1 = [self viewWithTag:3223];
    if (!detail1) {
        detail1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.width, 16)];
        detail1.tag = 3223;
        detail1.x = 0 ;
        detail1.y = self.height - 15;
        detail1.text = self.titleLabel.text;
        detail1.font = [UIFont systemFontOfSize:14];
        detail1.textColor =  kUIColorFromRGB(color_1);
        
        detail1.textAlignment = NSTextAlignmentCenter;
        [self addSubview:detail1];
    }
    return detail1;
}

-(void)setCustomDetailLb:(UILabel *)customTDetailLb
{
    customTDetailLb.tag = 3223;
    [self addSubview:customTDetailLb];
}

-(void)fitImgAndTitleMode
{
    UILabel *detail1 = [self viewWithTag:3222];
    if (!detail1) {
        detail1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.width, 16)];
        detail1.tag = 3222;
        detail1.x = 0 ;
        detail1.y = self.height - 25;
    }
    detail1.text = self.titleLabel.text;
    detail1.font = [UIFont systemFontOfSize:14];
    detail1.textColor =  kUIColorFromRGB(color_1);
    
    detail1.textAlignment = NSTextAlignmentCenter;
    [self addSubview:detail1];
    [self setTitle:@"" forState:UIControlStateNormal];
    UIImageView *img1 = [self viewWithTag:3322];
    if (!img1) {
        img1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.width - 30, 46)];
        img1.tag = 3322;
        img1.x = 15;
        img1.y = 10;

    }
    if (self.imageView.image) {
        img1.image = self.imageView.image;//[UIImage imageContentWithFileName:@"defaultHead"];
    }
    self.imageView.image = nil;
    [self addSubview:img1];
    UILabel *detail2 = [self viewWithTag:3223];
    detail2.text = nil;
}

-(void)fitUpImgAndDownTitleMode
{
    UILabel *detail1 = [self viewWithTag:3222];
    if (!detail1) {
        detail1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.width, 16)];
        detail1.tag = 3222;

    }
    detail1.x = 0 ;
    detail1.y = self.height - 18;
    detail1.text = self.titleLabel.text;
    detail1.font = [UIFont systemFontOfSize:14];
    detail1.textColor =  kUIColorFromRGB(color_1);

    detail1.textAlignment = NSTextAlignmentCenter;
    [self addSubview:detail1];
    [self setTitle:@"" forState:UIControlStateNormal];
    UIImageView *img1 = [self viewWithTag:3322];
    if (!img1) {
        img1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
        img1.tag = 3322;


    }
    if (self.imageView.image) {
        img1.image = self.imageView.image;//[UIImage imageContentWithFileName:@"defaultHead"];
    }
    img1.width = 25;
    img1.height = 25;
    self.imageView.image = nil;
    img1.x = 15;
    img1.y = 4;
    [self addSubview:img1];
    UILabel *detail2 = [self viewWithTag:3223];
    detail2.text = nil;
}

-(void)fitDownImgAndUpTitleMode
{
    UILabel *detail1 = [self viewWithTag:3222];
    if (!detail1) {
        detail1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.width, 16)];
        detail1.tag = 3222;

    }
    detail1.x = 0 ;
    detail1.y = 3;
    detail1.text = self.titleLabel.text;
    detail1.font = [UIFont systemFontOfSize:14];
    detail1.textColor =  kUIColorFromRGB(color_1);

    detail1.textAlignment = NSTextAlignmentCenter;
    [self addSubview:detail1];
    [self setTitle:@"" forState:UIControlStateNormal];
    UIImageView *img1 = [self viewWithTag:3322];
    if (!img1) {
        img1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0,25, 25)];
        img1.tag = 3322;


    }
    if (self.imageView.image) {
        img1.image = self.imageView.image;//[UIImage imageContentWithFileName:@"defaultHead"];
    }
    img1.width = 25;
    img1.height = 25;
    self.imageView.image = nil;
    img1.x = 15;
    img1.y = self.height - img1.height - 3;
    [self addSubview:img1];
    UILabel *detail2 = [self viewWithTag:3223];
    detail2.text = nil;
}

-(void)fitLeftImgAndRightTitleMode
{
    UILabel *detail1 = [self viewWithTag:3222];
    if (!detail1) {
        detail1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.width, 16)];
        detail1.tag = 3222;

    }

    detail1.y = self.height/2.0 - detail1.height/2.0;
    detail1.text = self.titleLabel.text;
    detail1.font = [UIFont systemFontOfSize:14];
    detail1.textColor =  kUIColorFromRGB(color_1);

    detail1.textAlignment = NSTextAlignmentCenter;
    [self addSubview:detail1];
    [self setTitle:@"" forState:UIControlStateNormal];
    UIImageView *img1 = [self viewWithTag:3322];
    if (!img1) {
        img1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.width - 30, 46)];
        img1.tag = 3322;


    }
    img1.width = 25;
    img1.height = 25;
    if (self.imageView.image) {
        img1.image = self.imageView.image;//[UIImage imageContentWithFileName:@"defaultHead"];
    }
    self.imageView.image = nil;
    img1.x = 3;
    img1.y = self.height/2.0 - img1.height/2.0;
    [self addSubview:img1];
    detail1.x = img1.width + img1.x ;
    UILabel *detail2 = [self viewWithTag:3223];
    detail2.text = nil;
}

-(void)fitRightImgAndLeftTitleMode
{
    UILabel *detail1 = [self viewWithTag:3222];
    if (!detail1) {
        detail1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.width, 16)];
        detail1.tag = 3222;

    }
    detail1.x = 0 ;
    detail1.y = self.height/2.0 - detail1.height/2.0;
    detail1.text = self.titleLabel.text;
    detail1.font = [UIFont systemFontOfSize:14];
    detail1.textColor =  kUIColorFromRGB(color_1);

    detail1.textAlignment = NSTextAlignmentCenter;
    [self addSubview:detail1];
    [self setTitle:@"" forState:UIControlStateNormal];
    UIImageView *img1 = [self viewWithTag:3322];
    if (!img1) {
        img1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.width - 30, 46)];
        img1.tag = 3322;
       ;

    }
    img1.width = 25;
    img1.height = 25;
    if (self.imageView.image) {
        img1.image = self.imageView.image;//[UIImage imageContentWithFileName:@"defaultHead"];
    }
    self.imageView.image = nil;
    img1.x = detail1.x + detail1.width + 3;
    img1.y = self.height/2.0 - img1.height/2.0;;
    [self addSubview:img1];
       UILabel *detail2 = [self viewWithTag:3223];
    detail2.text = nil;
}

-(void)fitUpTitleAndDownTitleMode
{
    UILabel *detail1 = [self viewWithTag:3222];
    if (!detail1) {
        detail1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.width, 16)];
        detail1.tag = 3222;

    }
    detail1.x = 0 ;
    detail1.y = self.height - 3;
    detail1.text = self.titleLabel.text;
    detail1.font = [UIFont systemFontOfSize:14];
    detail1.textColor =  kUIColorFromRGB(color_1);

    detail1.textAlignment = NSTextAlignmentCenter;
    [self addSubview:detail1];
        [self setTitle:@"" forState:UIControlStateNormal];
    UILabel *detail2 = [self viewWithTag:3223];
    if (!detail2) {
        detail2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.width, 16)];
        detail2.tag = 3223;

    }
    detail2.x = 0 ;
    detail2.y = self.height - 18;
    detail2.text = self.titleLabel.text;
    detail2.font = [UIFont systemFontOfSize:14];
    detail2.textColor =  kUIColorFromRGB(color_1);

    detail2.textAlignment = NSTextAlignmentCenter;
    [self addSubview:detail2];
       UIImageView *img1 = [self viewWithTag:3322];
    img1.image = nil;
}
static id  extrInfo;

-(id)userInfo
{
    return objc_getAssociatedObject(self, &extrInfo);
}

-(void) setUserInfo:(id)userInfo
{
    objc_setAssociatedObject(self, &extrInfo, userInfo, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

@end
