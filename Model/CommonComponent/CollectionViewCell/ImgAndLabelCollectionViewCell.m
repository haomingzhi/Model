//
//  ImgAndLabelCollectionViewCell.m
//  yihui
//
//  Created by orange on 15/9/23.
//  Copyright (c) 2015年 ORANLLC_IOS1. All rights reserved.
//

#import "ImgAndLabelCollectionViewCell.h"

@implementation ImgAndLabelCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
    [self.userImg corner:[UIColor clearColor] radius:self.userImg.frame.size.width/2.0];
}

@end
