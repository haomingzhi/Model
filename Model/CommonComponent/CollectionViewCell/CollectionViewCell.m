//
//  CollectionViewCell.m
//  yihui
//
//  Created by orange on 15/9/28.
//  Copyright (c) 2015年 ORANLLC_IOS1. All rights reserved.
//

#import "CollectionViewCell.h"

@implementation CollectionViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (IBAction)handleDeletede:(UIButton *)sender {
    if (_deleBlock) {
        _deleBlock(sender.tag);
    }
}
@end
