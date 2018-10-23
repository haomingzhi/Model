//
//  FlashCollectionViewCell.m
//  JiXie
//
//  Created by air on 15/5/25.
//  Copyright (c) 2015年 ORANLLC_IOS1. All rights reserved.
//

#import "GoodsFlashCollectionViewCell.h"

@implementation GoodsFlashCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
    _textLbl.frame = CGRectMake(15, 0, __SCREEN_SIZE.width-30, self.frame.size.height-40);
    [_textLbl setFont:[UIFont systemFontOfSize:15]];
    _textLbl.textAlignment = NSTextAlignmentCenter;
    _textLbl.numberOfLines = 0;
//    _textLbl.backgroundColor = [[UIColor whiteColor]colorWithAlphaComponent:0.0];
}



@end
