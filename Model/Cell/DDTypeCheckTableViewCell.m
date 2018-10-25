//
//  DDTypeCheckTableViewCell.m
//  DDZX_js
//
//  Created by apple on 2018/9/3.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import "DDTypeCheckTableViewCell.h"
#import "UIView+NTES.h"

@interface DDTypeCheckTableViewCell()
@property(nonatomic,strong)UIImageView *imgV;
@property(nonatomic,strong)UIImageView *arrowImgV;
@property(nonatomic,strong)UITextField *typeLb;
@property(nonatomic,strong)UIView *lineV;

@end

@implementation DDTypeCheckTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.imgV];
        [self.contentView addSubview:self.arrowImgV];
        [self.contentView addSubview:self.typeLb];
         [self.contentView addSubview:self.lineV];
          self.height = UIScreenWidth <= 320 ? 60:75;
    }
    return self;
}

-(UIImageView *)imgV
{
    if (!_imgV) {
        _imgV = [UIImageView new];
        _imgV.height = 17;
        _imgV.width = 17;
        _imgV.image = [UIImage imageNamed:@"导师类型"];
    }
    return _imgV;
}

-(UIImageView *)arrowImgV
{
    if (!_arrowImgV) {
        _arrowImgV = [UIImageView new];
        _arrowImgV.height = 17;
        _arrowImgV.width = 17;
        _arrowImgV.image = [UIImage imageNamed:@"导师类型-下拉"];
    }
    return _arrowImgV;
}

-(UITextField *)typeLb
{
    if (!_typeLb) {
        _typeLb = [UITextField new];
        _typeLb.height = 30;
        _typeLb.width = 280;
        _typeLb.textColor = UIColorFromRGB(0x3A424D);
        _typeLb.font = [UIFont systemFontOfSize:20];
        _typeLb.userInteractionEnabled = NO;
        NSString *str = @"导师类型";
        _typeLb.placeholder = str;
        NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:str];
        [attrStr addAttribute:NSForegroundColorAttributeName
                        value:UIColorFromRGB(0xA2A3A7)
                        range:NSMakeRange(0, str.length)];
        [attrStr addAttribute:NSFontAttributeName
                        value:[UIFont systemFontOfSize:14]
                        range:NSMakeRange(0, str.length)];
        _typeLb.attributedPlaceholder =  attrStr;
    }
    return _typeLb;
}

-(UIView *)lineV
{
    if (!_lineV) {
        _lineV = [UIView new];
        _lineV.backgroundColor = UIColorFromRGB(0xE5E5E5);
        _lineV.width = UIScreenWidth - 72;
        _lineV.height = 0.5;
    }
    return _lineV;
}


-(NSString *)type
{
    return _typeLb.text;
}

-(void)setType:(NSString *)type
{
    _typeLb.text = type;
}

- (void)refresh:(NSDictionary *)dic
{
    self.typeLb.text = dic[@"title"];
   
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.imgV.top = UIScreenWidth <= 320 ? 30:45;
    self.imgV.left = 36;
    self.typeLb.left = self.imgV.width + self.imgV.left + 15;
    self.typeLb.width = UIScreenWidth - self.typeLb.left - 36;
    self.typeLb.top = UIScreenWidth <= 320 ? 25:40;
    self.typeLb.height = 28;
    self.lineV.top = self.height - 1;
    self.lineV.left = 36;
    
    self.arrowImgV.left = UIScreenWidth - 36 - self.arrowImgV.width;
    self.arrowImgV.top = self.imgV.top;
}
@end
