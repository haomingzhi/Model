//
//  DDCarouselTableViewCell.m
//  DDZX_xyzx
//
//  Created by apple on 2018/8/16.
//  Copyright © 2018年 ddzx. All rights reserved.
//

#import "DDCarouselTableViewCell.h"
#import "SDCycleScrollView.h"
#import "UIView+NTES.h"
@interface DDCarouselTableViewCell()
@property(nonatomic,strong)SDCycleScrollView *flashView;
@end

@implementation DDCarouselTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self.contentView addSubview:self.flashView];
        
    }
    return self;
}

-(SDCycleScrollView *)flashView
{
    if(!_flashView)
    {
        _flashView = [SDCycleScrollView new];
        _flashView.top = 15;
        _flashView.left = 18;
        _flashView.width = UIScreenWidth - 36;
        _flashView.height = (UIScreenWidth - 36) * 560.0/1356;
        _flashView.layer.cornerRadius = 6;
        _flashView.layer.masksToBounds = YES;
        _flashView.delegate = self;
    }
    return _flashView;
}

-(void)dealloc
{
    _flashView.delegate = nil;
}
/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    if (_callBack) {
        _callBack(@{@"index":@(index)});
    }
}
- (void)refresh:(NSDictionary *)dic
{
   _flashView.imageURLStringsGroup = dic[@"arr"];
//    _flashView.localizationImageNamesGroup = dic[@"defaultArr"];
    _flashView.placeholderImage = [UIImage imageNamed:dic[@"defaultImg"]];
    [self setNeedsLayout];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
}
@end
