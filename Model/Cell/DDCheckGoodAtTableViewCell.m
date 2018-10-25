//
//  DDCheckGoodAtTableViewCell.m
//  DDZX_js
//
//  Created by apple on 2018/8/27.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import "DDCheckGoodAtTableViewCell.h"
#import "UIView+NTES.h"

@interface DDCheckGoodAtTableViewCell()
@property(nonatomic,strong)UILabel *titleLb;
//@property(nonatomic,strong)NSMutableArray *marks;
@property(nonatomic,strong)UIImageView *arrowImgV;
@end

@implementation DDCheckGoodAtTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.titleLb];
//        self.marks = [NSMutableArray new];
        [self.contentView addSubview:self.arrowImgV];
    }
    return self;
}

-(UIImageView *)arrowImgV
{
    if (!_arrowImgV) {
        _arrowImgV = [UIImageView new];
        _arrowImgV.height = 14;
        _arrowImgV.width = 14;
        _arrowImgV.image = [UIImage imageNamed:@"进入 copy"];
    }
    return _arrowImgV;
}


//-(void)genMarks:(NSArray *)arr
//{
//    [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        if (idx < self.marks.count ) {
//            UILabel *lb = self.marks[idx];
//            lb.text = obj;
//        }
//        else
//        {
//            UILabel *lb = [UILabel new];
//            lb.tag = 100 + idx;
//            lb.width = 69;
//            lb.height = 21;
//            lb.layer.cornerRadius = lb.height/2.0;
//            lb.layer.masksToBounds = YES;
//            lb.layer.borderColor = UIColorFromRGB(0x20A0FF).CGColor;
//            lb.layer.borderWidth = 0.5;
//            lb.textColor = UIColorFromRGB(0x20A0FF);
//            lb.font = [UIFont systemFontOfSize:14];
//            lb.text = obj;
//            lb.textAlignment = NSTextAlignmentCenter;
//            [self.contentView addSubview:lb];
//            [self.marks addObject:lb];
//        }
//    }];
//    if (self.marks.count > arr.count) {
//        NSInteger n = self.marks.count - arr.count;
//        for (NSInteger i = 0; i < n; i ++) {
//            UILabel *lb = self.marks[arr.count + i];
//            [lb removeFromSuperview];
//        }
//        [self.marks removeObjectsInRange:NSMakeRange(arr.count, self.marks.count - arr.count)];
//    }
//}
-(UILabel *)titleLb
{
    if (!_titleLb) {
        _titleLb = [UILabel new];
        _titleLb.font = [UIFont systemFontOfSize:14];
        _titleLb.textColor = UIColorFromRGB(0x3A424D);
    }
    return _titleLb;
}
-(void)refresh:(NSDictionary *)dic
{
    self.titleLb.text = dic[@"title"];
    if (dic[@"font"]) {
        self.titleLb.font = dic[@"font"];
    }
    [self setNeedsLayout];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.titleLb.width = 100;
    self.titleLb.height = 20;
    self.titleLb.left = 18;
    self.titleLb.centerY = self.height/2.0;
    
//    [self.marks enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        UILabel *lb = obj;
//        lb.top = 27 + idx / 4 *(lb.height + 12);
//        NSInteger sp = (self.width - 36 - lb.width * 4)/3.0;
//        lb.left  = 18 + idx % 4 * (lb.width + sp);
//    }];
//    UILabel *lb = self.marks.lastObject;
//    self.height = MAX(lb.height + lb.top  + 19, 58);
//        self.detailLb.left = self.width - 18 - self.arrowImgV.width - 10 - self.detailLb.width;
    _arrowImgV.left = UIScreenWidth - 18 - _arrowImgV.width;
    _arrowImgV.centerY = self.height/2.0;
}
@end
