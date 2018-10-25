//
//  DDImgTextBtn.m
//  DDZX_js
//
//  Created by apple on 2018/8/21.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import "DDImgTextBtn.h"
#import "UIImageView+WebCache.h"
#import "UIView+NTES.h"
@interface DDImgTextBtn()
@property(nonatomic,strong)UILabel *titleLb;
@property(nonatomic,strong)UIImageView *imgV;
@end


@implementation DDImgTextBtn

-(id)init
{
    self = [super init];
    if (self) {
        [self addSubview:self.titleLb];
        [self addSubview:self.imgV];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    _imgV.width = self.width;
    _imgV.height = self.height;
    
    _titleLb.left = 10;
    _titleLb.width = self.width - 20;
    _titleLb.height = 23;
    _titleLb.top = self.height - 8 - _titleLb.height;
    
}

-(void)setImg:(NSString *)img
{
    if ([img containsString:@"http"]) {
        [_imgV sd_setImageWithURL:[NSURL URLWithString:img] placeholderImage:[UIImage imageNamed:@""]];
    }
    else
    {
        _imgV.image = [UIImage imageNamed:img];
    }
    
}

-(void)setTitle:(NSString *)title
{
    _titleLb.text = title;
}

-(NSString *)title
{
    return _titleLb.text;
}

-(UIImageView *)imgV
{
    if (!_imgV) {
        _imgV = [UIImageView new];
    }
    return _imgV;
}

-(UILabel *)titleLb
{
    if (!_titleLb) {
        _titleLb = [UILabel new];
    }
    return _titleLb;
}



@end
