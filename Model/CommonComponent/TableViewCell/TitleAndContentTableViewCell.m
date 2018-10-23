//
//  TitleAndContentTableViewCell.m
//  ulife
//
//  Created by air on 15/12/22.
//  Copyright © 2015年 ORANLLC_IOS1. All rights reserved.
//

#import "TitleAndContentTableViewCell.h"
#import "YYKit.h"
#import "WBStatusHelper.h"
#import "WBStatusLayout.h"
#import "WBStatusComposeTextParser.h"
@implementation TitleAndContentTableViewCell
{
    IBOutlet UILabel *_contentLb;
    YYLabel *_contentYYLb;
    IBOutlet UILabel *_titleLb;
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setCellData:(NSDictionary *)dataDic
{
    _titleLb.text = dataDic[@"title"];
    _contentLb.text = dataDic[@"content"];
    [_contentYYLb removeFromSuperview];
    _contentYYLb = nil;
    [self initYYlable];
    _contentYYLb.text = dataDic[@"content"];
    _contentYYLb.width = __SCREEN_SIZE.width - 20;
    NSInteger row = _contentYYLb.textLayout.lines.count;
    [_contentYYLb sizeToFit];
    //[_contentYYLb.textLayout lineCountForRow:5];
    _contentYYLb.height = MAX(2 * (_contentYYLb.font.lineHeight + 8), _contentYYLb.height);
    if(row == 1)
    {
        _contentYYLb.height = 26;
    }
//    if (!_contentYYLb.hidden) {
//        self.height = _contentYYLb.height + 4 + _contentYYLb.y;
//    }

}

-(void)initYYlable
{
    _contentYYLb = [[YYLabel alloc] initWithFrame:CGRectMake(10, 36, 280, 48)];
    _contentYYLb.font = [UIFont systemFontOfSize:14];
    WBStatusComposeTextParser *parser = [WBStatusComposeTextParser new];
    parser.font = [UIFont systemFontOfSize:14];
    _contentYYLb.textColor = kUIColorFromRGB(color_0x303030);
    _contentYYLb.textParser = parser;
    _contentYYLb.numberOfLines = 2;
    WBTextLinePositionModifier *modifier = [WBTextLinePositionModifier new];
    modifier.font = [UIFont fontWithName:@"Heiti SC" size:14];
    //    modifier.paddingTop = 2;
    //    modifier.paddingBottom = 2;
    //    modifier.lineHeightMultiple = 1.5;
    _contentYYLb.linePositionModifier = modifier;
    _contentYYLb.textContainerInset = UIEdgeInsetsMake(0, 0, 0, 0);
    _contentYYLb.width = __SCREEN_SIZE.width - 10 - _contentYYLb.x;
    [self.contentView addSubview:_contentYYLb];
}

@end
