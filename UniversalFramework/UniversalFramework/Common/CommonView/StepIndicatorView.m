//
//  SetpIndicator.m
//  UniversalFramework
//
//  Created by ORANLLC_IOS1 on 15/10/29.
//  Copyright (c) 2015年 ORANLLC_IOS1. All rights reserved.
//

#import "StepIndicatorView.h"

#define xoffset 20
@implementation StepIndicatorView

-(void)construct
{
    if (self.normalImages.count >0 && self.selectImages.count >0) {
        CGFloat xOffset =xoffset;
        CGFloat yOffset;
        for (int i =0; i < self.stepDescripts.count; i++) {
            NSArray *imgs = [self getImages:i];
            if (self.orientation == StepIndicatorView_ORIENTATION_HORZ) {//水平位置
                yOffset = [self getYStart];
                UIImageView *imgView = [self getImageView:imgs[0]];
                imgView.frame = CGRectMake(xOffset, yOffset, imgView.frame.size.width, imgView.frame.size.height);
                [self addSubview:imgView];
                
                UILabel *labelView = [self getLabel:self.stepDescripts[i] font:self.font color:i > _currentStep ? _normalCorlor : _marketColor];
                labelView.frame = CGRectMake((labelView.width -imgView.width )/2, yOffset + imgView.frame.size.height, labelView.width, labelView.height);
                xOffset += imgView.width;
                UIImageView *lineView = [self getImageView:imgs[1]];
                lineView.frame = CGRectMake(xoffset, yOffset, [self getStepViewWidth] - imgView.width, lineView.height);
                [self addSubview:labelView];
                [self addSubview:lineView];
            }
        }
    
    }
}

-(CGFloat )getStepViewWidth
{
    return (self.width - xoffset *2)/self.stepDescripts.count;
}

-(NSArray *) getImages:(NSInteger) step
{
    return step> self.currentStep ? self.normalImages : self.selectImages;
}

//-(UIView *) getStepView:(NSString *) stepDescript images:(NSArray *) images size:(CGSize) viewSize
//{
//    UIView *stepView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, viewSize.width, viewSize.height)];
//    CGFloat yoffset = [self getYStart];
//    UIImageView *imgView =[self  getImageView:images[0]];
//    imgView.frame = CGRectMake(0, yoffset, imgView.frame.size.width, imgView.frame.size.height);
//    [stepView addSubview:imgView];
//    
//    return stepView;
//    
//}

-(UIImageView *) getImageView:(UIImage *)img
{
    CGSize s = [self getImageSize:img];
    return  [self getImageView:img size:s];
}

-(UIImageView *) getImageView:(UIImage *) img size:(CGSize) size
{
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    imgView.image = img;
    return imgView;
}

-(UILabel *) getLabel:(NSString *) title font:(UIFont *) font color:(UIColor *) color
{
    CGSize s = [title size:font constrainedToSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    UILabel * lable = [[UILabel alloc]initWithFrame:CGRectMake(0,0,s.width, s.height)];
    lable.backgroundColor = [UIColor clearColor];
    lable.font = font;
    lable.textColor = color;
    lable.text =  title;
    return lable;
}

-(CGFloat) getYStart
{
    CGSize titleSize = self.stepDescripts.count >0 ? [@"你好" size:self.font constrainedToSize:CGSizeMake(MAXFLOAT, MAXFLOAT)] : CGSizeZero;
    CGSize imageSize = [self getImageSize:self.normalImages[0]];
    
    return [self middle:CGSizeMake(titleSize.width + imageSize.width, titleSize.height + imageSize.height)].height;
    
}

-(CGSize) getImageSize:(UIImage *)img
{
    return CGSizeMake(img.size.width / img.scale, img.size.height/img.scale);
}

-(void) setup
{
    [self construct];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self construct];
    }
    return self;
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    [self construct];
}

@end
