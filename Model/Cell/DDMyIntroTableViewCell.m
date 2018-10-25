//
//  DDMyIntroTableViewCell.m
//  DDZX_js
//
//  Created by apple on 2018/8/23.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import "DDMyIntroTableViewCell.h"
#import "UIView+NTES.h"
#import "UIImageView+WebCache.h"
#import "DDTitleDetailBtn.h"
#define markLimit (UIScreenWidth > 320 ? 4:3)
@interface DDMyIntroTableViewCell()
@property(nonatomic,strong)UILabel *stateLb;
@property(nonatomic,strong)UILabel *nameLb;
@property(nonatomic,strong)UILabel *infoLb;
@property(nonatomic,strong)NSMutableArray *goods;
@property(nonatomic,strong)UIImageView *imgV;
@property(nonatomic,strong)DDTitleDetailBtn *btnA;
@property(nonatomic,strong)DDTitleDetailBtn *btnB;
@property(nonatomic,strong)UILabel *line;
@property(nonatomic,strong)UIView *containerView;
@property(nonatomic,strong)NSDictionary *dataDic;
@property(nonatomic,strong)UIButton *goodsBtn;
@property (nonatomic, strong)UIButton *moreBtn;
@end


@implementation DDMyIntroTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.containerView];
        [self.containerView addSubview:self.nameLb];
        [self.containerView addSubview:self.stateLb];
        
        [self.containerView addSubview:self.imgV];
        [self.containerView addSubview:self.infoLb];
        [self.containerView addSubview:self.btnA];
        [self.containerView addSubview:self.btnB];
        [self.containerView addSubview:self.line];
        [self.containerView addSubview:self.moreBtn];
        [self.containerView addSubview:self.goodsBtn];
        
        self.hidden = YES;
    }
    return self;
}

-(UIButton *)goodsBtn
{
    if (!_goodsBtn) {
        _goodsBtn = [UIButton new];
        [_goodsBtn addTarget:self action:@selector(goodAtClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _goodsBtn;
}

-(void)goodAtClick:(UIButton *)btn
{
    NSArray *marks = _dataDic[@"type"];
    if (_goodAtCallBack&& marks.count > markLimit) {
        _goodAtCallBack();
    }
}

-(void)refresh:(NSDictionary *)dic
{
    self.hidden = YES;
    _dataDic = dic;
    _nameLb.text = dic[@"name"];
    _infoLb.text = dic[@"info"];
    _stateLb.text = dic[@"state"];
    _btnA.title = dic[@"aTitle"];
    _btnA.detail = dic[@"aDetail"];
    
    _btnB.title = dic[@"bTitle"];
    _btnB.detail = dic[@"bDetail"];
    [_imgV sd_setImageWithURL:[NSURL URLWithString:dic[@"imgUrl"]] placeholderImage:[UIImage imageNamed:dic[@"img"]]];
    [self genMarkLbs];
    [self setNeedsLayout];
    if ((!dic[@"name"]|| [dic[@"name"] isEqualToString:@""] )&& (!dic[@"info"] || [dic[@"info"] isEqualToString:@""])&&( !dic[@"state"] || [dic[@"state"] isEqualToString:@""]))
    {
        self.hidden = YES;
    }
    else
    {
        self.hidden = NO;
    }
    if([_stateLb.text isEqualToString:@"已审核"])
    {
        _stateLb.hidden = YES;
    }
    else
    {
        _stateLb.hidden = NO;
    }
    NSArray *marks = _dataDic[@"type"];
    if (marks.count > markLimit) {
        _moreBtn.hidden = NO;
    }
    else
    {
        _moreBtn.hidden = YES;
    }
}
-(UIButton*)moreBtn
{
    if (!_moreBtn) {
        _moreBtn = [UIButton new];
        _moreBtn.height = 14;
        _moreBtn.width = 30;
        [_moreBtn setTitle:@"..." forState:UIControlStateNormal];
        [_moreBtn setTitleColor:UIColorFromRGB(0xF97D1F) forState:UIControlStateNormal];
    }
    return _moreBtn;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    _imgV.top = 18;
    _imgV.left = 18;
    __weak typeof(self) weak_self = self;
    _nameLb.left = 15 + _imgV.width + _imgV.left;
    _nameLb.top = _imgV.top;
    [_nameLb sizeToFit];
    if ( _stateLb.hidden) {
        _nameLb.width = MIN(UIScreenWidth - _nameLb.left - 40, _nameLb.width);
    }
    else
    {
        _nameLb.width = MIN(UIScreenWidth - _nameLb.left - 90, _nameLb.width);
    }
    
    _stateLb.left = _nameLb.width + _nameLb.left + 6;
    _stateLb.top = _nameLb.top + 4;
    
    _infoLb.left = _nameLb.left;
    _infoLb.top = _nameLb.top + _nameLb.height + 3;
    _infoLb.width = UIScreenWidth - _infoLb.left - 40;
    
    [_goods enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UILabel *a = obj;
        a.left = weak_self.nameLb.left + (a.width + 10) * idx;
    }];
    
    _goodsBtn.width = _goods.count * 60 + 16;
    _goodsBtn.left = _nameLb.left;
    _goodsBtn.height = 25;
    _goodsBtn.top = 66;
    UILabel *a = _goods.lastObject;
    _moreBtn.top = a.top - 4;
    _moreBtn.left = a.left + a.width  + 2;
    
    _btnA.top = _containerView.height - 26 - _btnA.height;
    _btnA.left = (_containerView.width - _btnA.width * 2)/4.0;
    
    _btnB.top = _btnA.top;
    _btnB.left = _containerView.width - _btnA.left - _btnB.width;
}


-(UILabel *)stateLb
{
    if (!_stateLb) {
        _stateLb = [UILabel new];
        _stateLb.width = 45;
        _stateLb.height = 16;
        _stateLb.layer.cornerRadius = _stateLb.height/2.0;
        _stateLb.layer.masksToBounds = YES;
        _stateLb.textColor = UIColorFromRGB(0xffffff);
        _stateLb.textAlignment = NSTextAlignmentCenter;
        _stateLb.backgroundColor = UIColorFromRGB(0xF97D1F);
        _stateLb.font = [UIFont systemFontOfSize:9];
        _stateLb.left = 76;
        _stateLb.top = _nameLb.top + 4;
    }
    return _stateLb;
}

-(UILabel *)nameLb
{
    if (!_nameLb) {
        _nameLb = [UILabel new];
        _nameLb.width = 160;
        _nameLb.height = 25;
        _nameLb.font = [UIFont systemFontOfSize:18];
        _nameLb.textColor = UIColorFromRGB(0x3A424D);
    }
    return _nameLb;
}

-(UILabel *)infoLb
{
    if (!_infoLb) {
        _infoLb = [UILabel new];
        _infoLb.textColor = UIColorFromRGB(0xA2A3A7);
        _infoLb.font = [UIFont systemFontOfSize:14];
        _infoLb.height = 20;
        
        _infoLb.left = 15 + _imgV.width + _imgV.left;
        _infoLb.top = 46;
    }
    return _infoLb;
}

-(UILabel *)line
{
    if (!_line) {
        _line = [UILabel new];
        _line.width = 0.5;
        _line.height = 37;
        _line.top = 125;
        _line.centerX = _containerView.width/2.0;
        _line.backgroundColor = UIColorFromRGB(0xE5E5E5);
    }
    return _line;
}

-(DDTitleDetailBtn *)btnA
{
    if (!_btnA) {
        _btnA = [DDTitleDetailBtn new];
    }
    return _btnA;
}

-(DDTitleDetailBtn*)btnB
{
    if (!_btnB) {
        _btnB = [DDTitleDetailBtn new];
        [_btnB addTarget:self action:@selector(myPointClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnB;
}

-(void)myPointClick:(UIButton *)btn
{
    if (_myPointCallBack) {
        _myPointCallBack();
    }
}

-(UIView *)containerView
{
    if (!_containerView) {
        _containerView = [UIView new];
        _containerView.height = 189;
        _containerView.width = UIScreenWidth - 36;
        _containerView.top = 25;
        _containerView.left = 18;
        
        _containerView.layer.cornerRadius = 9;
        _containerView.layer.masksToBounds = YES;
        _containerView.layer.borderColor = UIColorFromRGB(0xE5E5E5).CGColor;
        _containerView.layer.borderWidth = 0.5;
        
    }
    return _containerView;
}

-(UIImageView *)imgV
{
    if (!_imgV) {
        _imgV = [UIImageView new];
        _imgV.height = 64;
        _imgV.width = 64;
        _imgV.layer.cornerRadius = _imgV.height/2.0;
        _imgV.layer.masksToBounds = YES;
    }
    return _imgV;
}

-(void)genMarkLbs
{
    NSArray *marks = _dataDic[@"type"];
    NSMutableArray *arr = [NSMutableArray new];
    NSInteger c = MIN(markLimit, marks.count);
    for (NSInteger i = 0; i < c; i++) {
        UILabel *a;
        if (_goods.count !=0 ) {
            a = _goods.lastObject;
            [_goods removeLastObject];
            [arr addObject:a];
        }
        else
        {
            a  = [UILabel new];
            [arr addObject:a];
            a.width = 45;
            a.height = 14;
            a.top = 66;
            a.left =  3 + (a.width + 10) * i;
            a.layer.cornerRadius = a.height/2.0;
            a.layer.borderColor = UIColorFromRGB(0xFA8E31).CGColor;
            a.layer.borderWidth = 0.5;
            a.textColor = UIColorFromRGB(0xFA8E31);
            a.font = [UIFont systemFontOfSize:9];
            a.textAlignment = NSTextAlignmentCenter;
            [self.containerView addSubview:a];
        }
        a.text = marks[i];
    }
    if (_goods.count > 0) {
        NSInteger c = _goods.count;
        for (NSInteger i = 0;i < c ; i ++) {
            UIView *  a = _goods.lastObject;
            [_goods removeLastObject];
            [a removeFromSuperview];
        }
    }
    _goods = arr;
    
}
@end
