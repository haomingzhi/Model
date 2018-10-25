//
//  DDGongHaoTableViewCell.m
//  DDZX_js
//
//  Created by apple on 2018/8/28.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import "DDGongHaoTableViewCell.h"
#import "UIView+NTES.h"
@interface DDGongHaoTableViewCell()
@property(nonatomic,strong)UIButton *btn;
@end


@implementation DDGongHaoTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.btn];
    }
    return self;
}

-(UIButton *)btn
{
    if (!_btn) {
        _btn = [UIButton new];
    }
    return _btn;
}

-(void)refresh:(NSDictionary *)dic
{
    [super refresh:dic];
}

@end
