//
//  DDTwoBtnTableViewCell.m
//  DDZX_js
//
//  Created by apple on 2018/8/21.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import "DDTwoBtnTableViewCell.h"
#import "DDImgTextBtn.h"
#import "UIView+NTES.h"
@interface DDTwoBtnTableViewCell()
@property(nonatomic,strong)DDImgTextBtn *abtn;
@property(nonatomic,strong)DDImgTextBtn *bbtn;
@end

@implementation DDTwoBtnTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.abtn];
        [self.contentView addSubview:self.bbtn];
    }
    return self;
}
-(void)refresh:(NSDictionary *)dic
{

    _abtn.title = dic[@"aTitle"];
    _abtn.img = dic[@"aImg"];
    
    _bbtn.title = dic[@"bTitle"];
    _bbtn.img = dic[@"bImg"];
    [self setNeedsLayout];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    _abtn.width = (UIScreenWidth - 48) /2.0;
    _abtn.height = 162/324.0 *_abtn.width;
    _abtn.left = 18;
    _abtn.top = 18;
    
    _bbtn.width = _abtn.width;
    _bbtn.height = 162/324.0 *_bbtn.width;
    _bbtn.left = UIScreenWidth - 18 - _abtn.width;
    _bbtn.top = 18;
}

-(DDImgTextBtn *)abtn
{
    if (!_abtn) {
        _abtn = [DDImgTextBtn new];
        [_abtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        _abtn.tag = 100;
    }
    return _abtn;
}

-(void)btnClick:(UIButton *)btn
{
    if (_btnClickCallBack) {
        _btnClickCallBack(@{@"index":@(btn.tag - 100)});
    }
}

-(DDImgTextBtn *)bbtn
{
    if (!_bbtn) {
        _bbtn = [DDImgTextBtn new];
         [_bbtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
         _bbtn.tag = 101;
    }
    return _bbtn;
}

@end
