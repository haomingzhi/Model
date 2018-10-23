//
//  ContentTableViewCell.m
//  ulife
//
//  Created by air on 15/12/22.
//  Copyright © 2015年 ORANLLC_IOS1. All rights reserved.
//

#import "ContentTableViewCell.h"
#import "JYQueueView.h"
#import "YYKit.h"
#import "WBStatusHelper.h"
#import "WBStatusLayout.h"
#import "WBStatusComposeTextParser.h"

@implementation ContentTableViewCell
{
    IBOutlet UILabel *_titleLb;
    IBOutlet UIImageView *_bgImgV;
    UILongPressGestureRecognizer *_ges;
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
   
    _titleLb.text = dataDic[@"title"];
    [_contentYYLb removeFromSuperview];
    _contentYYLb = nil;
    [self initYYlable];
     _contentYYLb.numberOfLines = 5;
    _objRow = [dataDic[@"row"] integerValue];
     _contentYYLb.text =  dataDic[@"title"];
    if(![dataDic[@"hiddenBg"] boolValue])
    {
          _bgImgV.hidden = NO;
         _bgImgV.width = __SCREEN_SIZE.width - 45 - 15;
         _titleLb.width = _bgImgV.width - 22;
        _contentYYLb.width = _bgImgV.width - 22;
        self.contentView.backgroundColor = kUIColorFromRGB(color_0xf6f6f6);
        _titleLb.textColor = kUIColorFromRGB(color_0x303030);
    if([dataDic[@"mode"] integerValue] == 1)
    {
      [_bgImgV imageWithContent:@"chat1@2x" withUIEdgeInsets:UIEdgeInsetsMake(12, 12, 16, 16)];
        _bgImgV.x = 45;
        _titleLb.x = _bgImgV.x + 22;
         _contentYYLb.x = _bgImgV.x + 10;
        _titleLb.hidden = YES;
       
         _contentYYLb.hidden = NO;
    }
    else  if([dataDic[@"mode"] integerValue] == 2)
    {
       [_bgImgV imageWithContent:@"chat2@2x" withUIEdgeInsets:UIEdgeInsetsMake(16, 16,12, 12)];
        _bgImgV.x = 15;
        _titleLb.x = _bgImgV.x + 22;
         _contentYYLb.x = _bgImgV.x + 22;
        _titleLb.textColor = [UIColor whiteColor];
         _contentYYLb.hidden = NO;
        _contentYYLb.textColor = [UIColor whiteColor];
         _titleLb.hidden = YES;
//         _contentYYLb.text =  dataDic[@"title"];
    }
    else  if([dataDic[@"mode"] integerValue] == 3)
    {
         [_bgImgV imageWithContent:@"upChat@2x" withUIEdgeInsets:UIEdgeInsetsMake(12, 12, 12,12)];
        _bgImgV.x = 45;
        _titleLb.x = _bgImgV.x + 10;
         _contentYYLb.x = _bgImgV.x + 10;
        _contentYYLb.hidden = NO;
        _titleLb.hidden = YES;
//         _contentYYLb.text =  dataDic[@"title"];
    }
    else  if([dataDic[@"mode"] integerValue] == 4)
    {
//        _bgImgV.image = [UIImage imageNamed:@"chat1"];
        [_bgImgV imageWithContent:@"downChat@2x" withUIEdgeInsets:UIEdgeInsetsMake(12, 12, 12, 12)];
        _bgImgV.x = 45;
        _titleLb.x = _bgImgV.x + 10;
         _contentYYLb.x = _bgImgV.x + 10;
        _contentYYLb.hidden = NO;
        _titleLb.hidden = YES;
    }
        else  if([dataDic[@"mode"] integerValue] == 5)
        {
            [_bgImgV imageWithContent:@"upChat2@2x" withUIEdgeInsets:UIEdgeInsetsMake(12, 12, 12,12)];
            _bgImgV.x = 15;
            _titleLb.x = _bgImgV.x + 22;
             _contentYYLb.x = _bgImgV.x + 22;
            _titleLb.textColor = [UIColor whiteColor];
             _contentYYLb.textColor = [UIColor whiteColor];
            _contentYYLb.hidden = NO;
            _titleLb.hidden = YES;

        }else
        {
            [_bgImgV imageWithContent:@"downChat2@2x" withUIEdgeInsets:UIEdgeInsetsMake(12, 12, 12, 12)];
            _bgImgV.x = 15;
            _titleLb.x = _bgImgV.x + 22;
            _contentYYLb.x = _bgImgV.x + 22;
            _titleLb.textColor = [UIColor whiteColor];
            _contentYYLb.textColor = [UIColor whiteColor];
            _contentYYLb.hidden = NO;
            _titleLb.hidden = YES;
        }
    }
    else
    {
        _bgImgV.hidden = YES;
        _contentYYLb.hidden = YES;
        _titleLb.hidden = NO;
    }
    
    if (_ges) {
        [self removeGestureRecognizer:_ges];
    }
    if (_ges) {
        [self removeGestureRecognizer:_ges];
        _ges = nil;
    }
    _ges = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressAction:)];
    [self addGestureRecognizer:_ges];
    [self fitContentSize:_titleLb withPadding:UIEdgeInsetsMake(0, 0, _titleLb.y, 0)];
    NSInteger row = _contentYYLb.textLayout.lines.count;
    [_contentYYLb sizeToFit];
    //[_contentYYLb.textLayout lineCountForRow:5];
    _contentYYLb.height = MAX(row * (_contentYYLb.font.lineHeight + 12), _contentYYLb.height);
    if (!_contentYYLb.hidden) {
         self.height = _contentYYLb.height + 2 + _contentYYLb.y;
    }
   
    _bgImgV.height = self.height;
}

-(void)longPressAction:(UIGestureRecognizer *)ges
{
    if (ges.state == UIGestureRecognizerStateBegan) {
        if (self.handleAction) {
            self.handleAction(@{@"row":@(_objRow)});
        }
    }
}

-(void)initYYlable
{
    _contentYYLb = [[YYLabel alloc] initWithFrame:CGRectMake(0, 7, 280, 990)];
    _contentYYLb.font = [UIFont systemFontOfSize:16];
    WBStatusComposeTextParser *parser = [WBStatusComposeTextParser new];
    parser.font = [UIFont systemFontOfSize:16];
    _contentYYLb.textParser = parser;
      _contentYYLb.textColor = kUIColorFromRGB(color_0x303030);
    WBTextLinePositionModifier *modifier = [WBTextLinePositionModifier new];
    modifier.font = [UIFont fontWithName:@"Heiti SC" size:16];
    //    modifier.paddingTop = 2;
    //    modifier.paddingBottom = 2;
    //    modifier.lineHeightMultiple = 1.5;
    _contentYYLb.linePositionModifier = modifier;
    _contentYYLb.textContainerInset = UIEdgeInsetsMake(0, 0, 0, 0);
    _contentYYLb.width = __SCREEN_SIZE.width - 10 - _contentYYLb.x;
    [self.contentView addSubview:_contentYYLb];
}

@end
