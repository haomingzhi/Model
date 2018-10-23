//
//  UIImageView+AutoSize.m
//  JiXie
//
//  Created by ORANLLC_IOS1 on 15/6/16.
//  Copyright (c) 2015年 ORANLLC_IOS1. All rights reserved.
//

#import "UIImageView+AutoSize.h"

@implementation UIImageView (AutoSize)

-(CGSize) autoSize
{
    CGSize frameSize = CGSizeMake(self.frame.size.width ,self.frame.size.width  * (  self.image.size.height /self.image.size.width)) ;
    int changeY = frameSize.height - self.frame.size.height;
    int changeX = frameSize.width -self.frame.size.width ;
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, frameSize.width, frameSize.height);
    return CGSizeMake(changeX, changeY);
}

@end
