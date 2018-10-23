//
//  JYBaseButton.m
//  MeiliWan
//
//  Created by Air on 15-4-19.
//  Copyright (c) 2015年 wujyapp. All rights reserved.
//

#import "JYBaseButton.h"
@interface JYBaseButton()
{
    UIImage *_backgroundImg;
}
@end
@implementation JYBaseButton
-(void)awakeFromNib
{
  _backgroundImg = [self backgroundImageForState:UIControlStateNormal];
    [self setBackgroundImage:[_backgroundImg resizableImageWithCapInsets:UIEdgeInsetsMake(8, 8, 8, 8) resizingMode:UIImageResizingModeStretch] forState:UIControlStateNormal];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
