//
//  ConmentTableViewCell.m
//  ulife
//
//  Created by air on 15/12/18.
//  Copyright © 2015年 ORANLLC_IOS1. All rights reserved.
//

#import "ConmentTableViewCell.h"
#import "BUImageRes.h"
#import "YYKit.h"
#import "WBStatusHelper.h"
#import "WBStatusLayout.h"
#import "WBStatusComposeTextParser.h"
@implementation ConmentTableViewCell
{
    IBOutlet UILabel *_userNameLb;
    BUImageRes *_curImgRes;
    IBOutlet UIButton *_imgBtn;
    IBOutlet UILabel *_contentLb;
    IBOutlet UILabel *_timeLb;
    IBOutlet UIImageView *_imgV;
    NSInteger _objRow;
        YYLabel *_contentYYLb;
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
    [_contentYYLb removeFromSuperview];
    _contentYYLb = nil;
    [self initYYlable];
     _contentYYLb.numberOfLines = 0;
    _userNameLb.text = dataDic[@"userName"];
    _userNameLb.textColor = kUIColorFromRGB(color_mainTheme);
    _timeLb.text = dataDic[@"time"];
    _contentLb.text = dataDic[@"content"];
    _objRow = [dataDic[@"row"] integerValue];
    if([dataDic[@"mode"] integerValue] == 1)
    {
        NSString *name = dataDic[@"replyName"];
        _contentLb.text = [NSString stringWithFormat:@"回复%@:%@",name,dataDic[@"content"]];
        [_contentLb richText:name color:kUIColorFromRGB(color_mainTheme)];
        NSRange aRange = NSMakeRange(2, name.length);
        NSMutableAttributedString *mStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"回复%@:%@",name,dataDic[@"content"]]];
          [mStr addAttribute:NSForegroundColorAttributeName value: kUIColorFromRGB(color_0x303030) range:NSMakeRange(0, mStr.length)];
        [mStr addAttribute:NSForegroundColorAttributeName value:kUIColorFromRGB(color_mainTheme) range:aRange];
        _contentYYLb.attributedText = mStr;//[self mutableText:name withContent:dataDic[@"content"]];
        
//        [self fitCell:[NSString stringWithFormat:@"回复%@:%@",name,dataDic[@"title"]]];
    }
    else
    {
       
        _contentLb.text = dataDic[@"content"];
        _contentYYLb.text =  dataDic[@"content"];
//        [self fitCell:dataDic[@"title"]];
    }
    _curImgRes.isValid = NO;
    id img = dataDic[@"img"];
    [_imgV imageWithContent:@"defaultHead1@2x"];
    if (img&&[img isKindOfClass:[BUImageRes class]]) {
        BUImageRes *imgRes = img;
        imgRes.isValid = YES;
        _curImgRes = imgRes;
        _imgV.backgroundColor = [UIColor blueColor];
        [imgRes displayRemoteImage:_imgV imageName:@"defaultHead1@2x" thumb:YES];
    }

    [self fitContentSize];
}

-(void)fitContentSize
{
    _contentLb.width = __SCREEN_SIZE.width - 10 - _contentLb.x;
    //_titleLb.text = content;
//    WBTextLinePositionModifier *modifier = _contentYYLb.linePositionModifier;
    NSInteger row = _contentYYLb.textLayout.lines.count;
    [_contentLb sizeToFit];
    _contentLb.height = MAX(_contentLb.height, 20);
    [_contentYYLb sizeToFit];
//    NSInteger f = [_contentYYLb.textLayout lineCountForRow:row + 1];
    CGFloat h = 10;
    if (row >= 5) {
        h = 0;
    }
    _contentYYLb.height = MAX(row * (_contentYYLb.font.lineHeight + 3.5), _contentYYLb.height) + h;
    self.height = _contentYYLb.height + 0 + _contentYYLb.y;
}

- (IBAction)imgBtnHandle:(id)sender {
    if (self.handleAction) {
        self.handleAction(@(_objRow));
    }
}

-(void)initYYlable
{
    _contentYYLb = [[YYLabel alloc] initWithFrame:CGRectMake(54, 46, 280, 990)];
    _contentYYLb.font = [UIFont systemFontOfSize:14];
    WBStatusComposeTextParser *parser = [WBStatusComposeTextParser new];
    parser.font = [UIFont systemFontOfSize:14];
    _contentYYLb.textParser = parser;
     _contentYYLb.textColor = kUIColorFromRGB(color_0x303030);
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
