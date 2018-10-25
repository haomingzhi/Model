//
//  DDZxBtnTableViewCell.m
//  NIM
//
//  Created by apple on 2018/7/26.
//  Copyright © 2018年 Netease. All rights reserved.
//

#import "DDZxBtnTableViewCell.h"
#import "UIView+NTES.h"
@interface DDZxBtnTableViewCell()
@property(nonatomic,strong)UIButton *btn;
@end

@implementation DDZxBtnTableViewCell

-(id)init
{
    self = [super init];
    if (self) {
        [self.contentView addSubview:self.btn];
        self.height = 108;
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor clearColor];
    }
    return self;
}

-(void)layoutSubviews
{
    self.btn.top = 50;
    self.btn.left = 36;
}

-(UIButton *)btn{
    if (!_btn) {
        _btn = [UIButton new];
        _btn.width = UIScreenWidth - 72;
        _btn.height = 44;
        [_btn setTitle:@"登录" forState:UIControlStateNormal];
        _btn.backgroundColor = UIColorFromRGB(0xFA8E31);
        _btn.layer.cornerRadius = 6;
        [_btn addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn;
}
- (void)refresh:(NSDictionary *)dic
{
    
}
-(void)onClick:(UIButton *)btn
{
    if (_callBack) {
        _callBack(@{});
    }
}
@end
