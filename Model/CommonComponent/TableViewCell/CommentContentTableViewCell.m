//
//  CommentContentTableViewCell.m
//  yihui
//
//  Created by wujiayuan on 15/9/23.
//  Copyright (c) 2015年 ORANLLC_IOS1. All rights reserved.
//

#import "CommentContentTableViewCell.h"
#import "YYKit.h"
#import "WBStatusHelper.h"
#import "WBStatusLayout.h"
#import "WBStatusComposeTextParser.h"
@implementation CommentContentTableViewCell
{
    IBOutlet UILabel *_titleLb;
    NSInteger _objRow;
    UILongPressGestureRecognizer *_lPg;
    YYLabel *_contentYYLb;
}
- (void)awakeFromNib {
    // Initialization code
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)longpressAction:(UILongPressGestureRecognizer *)lpg
{
    if (self.handleAction) {
          if (lpg.state == UIGestureRecognizerStateBegan) {
        self.handleAction(lpg);
          }
    }
}

-(void)setCellData:(NSDictionary *)dataDic
{
    _objRow = [dataDic[@"objRow"] integerValue];
    [_contentYYLb removeFromSuperview];
    _contentYYLb = nil;
    [self initYYlable];
    
    if (!_lPg) {
        _lPg = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longpressAction:)];
        //        _lPg.minimumPressDuration = 1.2;
        [self.contentView addGestureRecognizer:_lPg];
    }
    if([dataDic[@"mode"] integerValue] == 1)
    {
        NSString *name = dataDic[@"name"];
        _titleLb.text = [NSString stringWithFormat:@"回复%@:%@",name,dataDic[@"title"]];
        [_titleLb richText:name color:[UIColor orangeColor]];
        
        
        NSRange aRange = NSMakeRange(2, name.length);
        NSMutableAttributedString *mStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"回复%@:%@",name,dataDic[@"title"]]];
        [mStr addAttribute:NSForegroundColorAttributeName value:[UIColor orangeColor] range:aRange];
        _contentYYLb.attributedText = mStr;
        
        [self fitCell:[NSString stringWithFormat:@"回复%@:%@",name,dataDic[@"title"]]];
    }
    else
    {
        _titleLb.text = dataDic[@"title"];
         _contentYYLb.text = dataDic[@"title"];
        [self fitCell:dataDic[@"title"]];
    }
    [super setCellData:dataDic];
}
-(void)fitCell:(NSString *)content
{
    _titleLb.width = __SCREEN_SIZE.width - 20;
  
    [_titleLb sizeToFit];
    _titleLb.height = MAX(_titleLb.height, 20);
    
    
    [_contentYYLb sizeToFit];
    WBTextLinePositionModifier *modifier = _contentYYLb.linePositionModifier;
    NSInteger row = _contentYYLb.textLayout.lines.count; //[_contentYYLb.textLayout lineCountForRow:5];
    _contentYYLb.height = MAX([modifier heightForLineCount:row], _contentYYLb.height);

    self.height = _contentYYLb.height + 4 * 2;
}

-(void)initYYlable
{
    _contentYYLb = [[YYLabel alloc] initWithFrame:CGRectMake(10, 32, 280, 200)];
    _contentYYLb.font = [UIFont systemFontOfSize:14];
    WBStatusComposeTextParser *parser = [WBStatusComposeTextParser new];
    parser.font = [UIFont systemFontOfSize:14];
    _contentYYLb.textParser = parser;
    
    WBTextLinePositionModifier *modifier = [WBTextLinePositionModifier new];
    modifier.font = [UIFont fontWithName:@"Heiti SC" size:14];
    modifier.paddingTop = 9;
    modifier.paddingBottom = 6;
    modifier.lineHeightMultiple = 1.5;
    _contentYYLb.linePositionModifier = modifier;
    _contentYYLb.width = __SCREEN_SIZE.width - 10 - _contentYYLb.x;
    [self.contentView addSubview:_contentYYLb];
}

@end
