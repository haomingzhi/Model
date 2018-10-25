//
//  DDWorkNumberTableViewCell.m
//  DDZX_js
//
//  Created by apple on 2018/9/19.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import "DDWorkNumberTableViewCell.h"
#import "UIView+NTES.h"
@interface DDWorkNumberTableViewCell()
@property(nonatomic,strong)UIButton *btn;
@end


@implementation DDWorkNumberTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
//        self.textTf.leftView = self.btn;
//        self.textTf.leftViewMode = UITextFieldViewModeAlways;
        [self.contentView addSubview:self.btn];
        self.btn.top = 10;
        self.btn.left = 54;
    }
    return self;
}

-(UIButton *)btn
{
    if (!_btn) {
        _btn = [UIButton new];
        _btn.height = 34;
        _btn.width = 34;
        _btn.imageEdgeInsets = UIEdgeInsetsMake(8, 8, 8, 8);
        [_btn addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn;
}

-(void)onClick:(UIButton*)btn
{
    if(_callBack)
    {
        _callBack(@{});
    }
}
-(void)refresh:(NSDictionary *)dic
{
    [super refresh:dic];
    [_btn setImage:[UIImage imageNamed:dic[@"img"]] forState:UIControlStateNormal];
}
@end
