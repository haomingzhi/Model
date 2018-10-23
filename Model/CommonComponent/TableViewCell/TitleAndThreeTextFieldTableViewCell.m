//
//  TitleAndThreeTextFieldTableViewCell.m
//  taihe
//
//  Created by air on 2016/11/14.
//  Copyright © 2016年 ORANLLC_IOS1. All rights reserved.
//

#import "TitleAndThreeTextFieldTableViewCell.h"

@implementation TitleAndThreeTextFieldTableViewCell
{
    IBOutlet UILabel *_titleLb;
    IBOutlet UITextField *_textTfB;
    IBOutlet UILabel *_aLb;

    IBOutlet UILabel *_bLb;
    IBOutlet UILabel *_cLb;
    IBOutlet UITextField *_textTfC;
    IBOutlet UITextField *_textTfA;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setCellData:(NSDictionary *)dataDic
{
    _titleLb.text = dataDic[@"title"];
    _textTfA.text = dataDic[@"a"];
     _textTfB.text = dataDic[@"b"];
     _textTfC.text = dataDic[@"c"];
}

-(void)fitRantInfoMode
{
    self.height = 44;
    _titleLb.x = 15;
    _titleLb.textColor = kUIColorFromRGB(color_6);
    _titleLb.font = [UIFont systemFontOfSize:15];
    _aLb.textColor = kUIColorFromRGB(color_6);
    _aLb.font = [UIFont systemFontOfSize:15];
    _bLb.textColor = kUIColorFromRGB(color_6);
    _bLb.font = [UIFont systemFontOfSize:15];
    _cLb.textColor = kUIColorFromRGB(color_6);
    _cLb.font = [UIFont systemFontOfSize:15];
    
    _textTfA.layer.borderWidth = 0.5;
    _textTfA.layer.borderColor = kUIColorFromRGB(color_lineColor).CGColor;
    _textTfB.layer.borderWidth = 0.5;
    _textTfB.layer.borderColor = kUIColorFromRGB(color_lineColor).CGColor;
    _textTfC.layer.borderWidth = 0.5;
    _textTfC.layer.borderColor = kUIColorFromRGB(color_lineColor).CGColor;
    _cLb.width = 13;
    _bLb.width = 13;
    _aLb.width = 13;
    _textTfA.textAlignment = NSTextAlignmentCenter;
    _textTfB.textAlignment = NSTextAlignmentCenter;
    _textTfC.textAlignment = NSTextAlignmentCenter;
    _cLb.x = __SCREEN_SIZE.width - 15 - _cLb.width;
    
    _textTfC.x = _cLb.x - 2 - _textTfC.width;
    
    _bLb.x = _textTfC.x - 3 - _bLb.width;
    
    _textTfB.x = _bLb.x - 2 - _textTfB.width;
    
    _aLb.x = _textTfB.x - 3 - _aLb.width;
    
    _textTfA.x = _aLb.x - 2 - _textTfA.width;
}
-(NSString*)getData
{
    return [NSString stringWithFormat:@"%@室%@厅%@卫",_textTfA.text?:@"0",_textTfB.text?:@"0",_textTfC.text?:@"0"];
}
@end
