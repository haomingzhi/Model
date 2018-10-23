//
//  GoodsTitleTableViewCell.m
//  ChaoLiu
//
//  Created by air on 15/7/15.
//  Copyright (c) 2015年 ORANLLC_IOS1. All rights reserved.
//

#import "GoodsTitleTableViewCell.h"

@implementation GoodsTitleTableViewCell
{
    CGFloat _topPadding;
    CGFloat _bottomPadding;
    CGFloat _leftPadding;
    CGFloat _rightPadding;
    IBOutlet KZLinkLabel *_titleLb;
}
- (void)awakeFromNib {
    //_titleLb = [[KZLinkLabel alloc] initWithFrame:CGRectMake(_titleLb.frame.origin.x, _titleLb.frame.origin.y, _titleLb.frame.size.width, _titleLb.frame.size.height)];
    _topPadding = _titleLb.y;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)fitCell:(NSString *)content
{
    
    _titleLb.width = __SCREEN_SIZE.width - 20;
    _titleLb.text = content;
    _titleLb.textColor = kUIColorFromRGB(text_color);//[UIColor blackColor];
    [_titleLb sizeToFit];
    _titleLb.y = _topPadding;
    _titleLb.height = MAX(_titleLb.height, 20);
    self.height = _titleLb.height + _topPadding + _bottomPadding;
}

//-(CGFloat)heightOfCell
//{
//    return self.height;
//}

-(id)heightOfCell
{
//    [self fitCell:content];
    return @(self.height);
}

-(void)setCellData:(NSDictionary *)dataDic
{
    if (dataDic[@"titleFont"]) {
      _titleLb.font = dataDic[@"titleFont"];
    }
    if (dataDic[@"hPadding"]) {
 NSValue *v = dataDic[@"hPadding"] ;
        UIEdgeInsets n;
        [v getValue:&n];
        _topPadding = n.top;
        _bottomPadding = n.bottom;
        
    }
    else
    {
//        _topPadding = 8;
        _bottomPadding = _topPadding;
    }
     [self fitCell:dataDic[@"title"]];
    [super setCellData:dataDic];
//    [self layoutIfNeeded];
}
@end
