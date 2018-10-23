//
//  TitleAndTwoTextfieldTableViewCell.m
//  taihe
//
//  Created by air on 2016/11/14.
//  Copyright © 2016年 ORANLLC_IOS1. All rights reserved.
//

#import "TitleAndTwoTextfieldTableViewCell.h"

@implementation TitleAndTwoTextfieldTableViewCell
{
    IBOutlet UILabel *_titleLb;

    IBOutlet UILabel *_lineLb;
 UITapGestureRecognizer *_tap;
   
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _lineLb.backgroundColor = kUIColorFromRGB(color_lineColor);
    _lineLb.height = 0.5;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setCellData:(NSDictionary *)dataDic
{
    _titleLb.text = dataDic[@"title"];
    if (![dataDic[@"textA"] isEqualToString:@""]) {
        _textTfA.text = dataDic[@"textA"];
    }
    if (![dataDic[@"textB"] isEqualToString:@""]) {
        _textTfB.text = dataDic[@"textB"];
    }
}

-(void)fitRantInfoMode
{
    self.height = 44;
    _titleLb.width = 126;
    _titleLb.font = [UIFont systemFontOfSize:15];
    _titleLb.textColor = kUIColorFromRGB(color_6);
    _titleLb.x = 15;
    _titleLb.y = self.height/2.0 - _titleLb.height/2.0;
    _textTfB.layer.borderColor = kUIColorFromRGB(color_lineColor).CGColor;
    _textTfB.layer.borderWidth = 0.5;
    _textTfB.width = 80;
    _textTfB.height = 35;
    _textTfB.y = self.height/2.0 - _textTfB.height/2.0;
    _textTfB.x = __SCREEN_SIZE.width - 15 - _textTfB.width;
    
    _textTfA.layer.borderColor =  kUIColorFromRGB(color_lineColor).CGColor;
    _textTfA.layer.borderWidth = 0.5;
    _textTfA.width = 80;
    _textTfA.height = 35;
    _textTfA.y = self.height/2.0 - _textTfA.height/2.0;
    _textTfA.x = __SCREEN_SIZE.width - 30 - _textTfB.width - _textTfA.width;
    _lineLb.width = 13;
    _textTfA.textAlignment = NSTextAlignmentCenter;
    _textTfB.textAlignment = NSTextAlignmentCenter;
    _lineLb.x = _textTfA.x + _textTfA.width + 1;
}

-(NSString *)getData:(NSString *)key
{
    if ([@"a" isEqualToString:key]) {
        return _textTfA.text;
    }
    return _textTfB.text;
}

-(void)fitPersonInfoSettingMode:(id)obj withSel:(SEL)sel
{
    self.height = 40;
    _titleLb.width = 126;
    _titleLb.font = [UIFont systemFontOfSize:15];
    _titleLb.textColor = kUIColorFromRGB(color_1);
    _titleLb.x = 15;
    _titleLb.y = self.height/2.0 - _titleLb.height/2.0;
    
    _textTfB.layer.borderColor = kUIColorFromRGB(color_5).CGColor;
    _textTfB.layer.cornerRadius = 2;
    _textTfB.layer.borderWidth = 0.5;
    _textTfB.width = 80;
    _textTfB.height = 30;
    _textTfB.y = self.height/2.0 - _textTfB.height/2.0;
    _textTfB.x = __SCREEN_SIZE.width - 15 - _textTfB.width;
    _textTfB.userInteractionEnabled = NO;
    UIImageView *imgv = [UIImageView new];
    imgv.width = 17;
    imgv.height = 10;
    imgv.x = 4;
    imgv.image = [UIImage imageContentWithFileName:@"more_down"];
    _textTfB.rightViewMode = UITextFieldViewModeAlways;
    UIView *v = [UIView new];
    v.width = 25;
    v.height = 10;
    [v addSubview:imgv];
    _textTfB.rightView = v;
    _textTfB.textAlignment = NSTextAlignmentRight;
    UIButton *btn = [self.contentView viewWithTag:8765];
    if (!btn) {
        btn = [UIButton new];
        btn.tag = 8765;
        btn.x = _textTfB.x;
        btn.y = _textTfB.y;
         btn.height = _textTfB.height;
        btn.width = _textTfB.width;
        [btn addTarget:obj action:sel forControlEvents:UIControlEventTouchUpInside];
    }
    [self.contentView addSubview:btn];
    
    _textTfA.layer.borderColor =  kUIColorFromRGB(color_5).CGColor;
     _textTfA.layer.cornerRadius = 2;
    _textTfA.layer.borderWidth = 0.5;
    _textTfA.width = 80;
    _textTfA.height = 30;
    _textTfA.y = self.height/2.0 - _textTfA.height/2.0;
    _textTfA.x = __SCREEN_SIZE.width - 30 - _textTfB.width - _textTfA.width;
    _lineLb.width = 14;
    _lineLb.height = 30;
    _lineLb.backgroundColor = kUIColorFromRGB(color_4);
    _lineLb.text = @"/";
    _lineLb.textAlignment = NSTextAlignmentCenter;
    _lineLb.y = self.height/2.0 - _lineLb.height/2.0;
    _textTfA.textAlignment = NSTextAlignmentRight;
//    _textTfB.textAlignment = NSTextAlignmentCenter;
    _lineLb.x = _textTfA.x + _textTfA.width + 1;
    _textTfA.delegate = self;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (!_tap) {
        _tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapHandle:)];
    }
    [self.window addGestureRecognizer:_tap];
    return YES;
}
-(void)dealloc
{
    [_tap.view removeGestureRecognizer:_tap];
    _tap = nil;
}

-(void)tapHandle:(UITapGestureRecognizer *)tap
{
    [tap.view removeGestureRecognizer:tap];
    [self endEditing:YES];
}
@end
