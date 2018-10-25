//
//  DDMarkTitleTableViewCell.m
//  DDZX_js
//
//  Created by apple on 2018/8/23.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import "DDMarkTitleTableViewCell.h"
#import "UIView+NTES.h"
@interface DDMarkTitleTableViewCell()
@property(nonatomic,strong)UILabel *markLb;
@end

@implementation DDMarkTitleTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.markLb];
    }
    return self;
}

-(UILabel *)markLb
{
    if (!_markLb) {
        _markLb = [UILabel new];
        _markLb.width = 90;
        _markLb.height = 22;
        _markLb.layer.cornerRadius = _markLb.height/2.0;
        _markLb.layer.masksToBounds = YES;
        _markLb.textColor = UIColorFromRGB(0xffffff);
        _markLb.backgroundColor = UIColorFromRGB(0x4ED065);
        _markLb.textAlignment = NSTextAlignmentCenter;
        _markLb.font = [UIFont systemFontOfSize:12];
        _markLb.top = 32;
        _markLb.left = -11;
    }
    return _markLb;
}

-(void)refresh:(NSDictionary *)dic
{
    _markLb.text = dic[@"title"];
    [self setNeedsLayout];
}




@end
