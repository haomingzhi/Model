//
//  JYCheckAndBtnView.m
//  yihui
//
//  Created by air on 15/9/14.
//  Copyright (c) 2015年 ORANLLC_IOS1. All rights reserved.
//

#import "JYCheckAndBtnView.h"

@implementation JYCheckAndBtnView
{
    IBOutlet UIImageView *_imgV;
    IBOutlet UILabel *_lineLb;
    IBOutlet UIButton *_btn;

    IBOutlet UIButton *_btn2;
    IBOutlet UIButton *_selectBtn;
    IBOutlet UILabel *_titleLb;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)awakeFromNib
{
    _lineLb.height = 0.5;
    _lineLb.width = __SCREEN_SIZE.width;
    self.height = 49;
//    _isFirstTap = YES;
}
- (IBAction)handleAction:(UIButton *)btn {
    NSLog(@"btn test xxx");
    if (_handleAction) {
       
        _handleAction(btn);
        if (btn.enabled) {
            if(btn.tag == 200)
            {
                if (btn.selected) {
                    _imgV.image = [UIImage imageContentWithFileName:@"pitchOn---Assistor@2x"];
                }
                else
                {
                _imgV.image = [UIImage  imageContentWithFileName:@"NoPitchOn---Assistor@2x"];
                }
//                if (btn ==_selectBtn&&_isFirstTap == YES) {
//                    _isFirstTap = NO;
//                }
            }
        }
    }
}


-(void)setIsSelected:(BOOL)isSelected
{
    _selectBtn.selected = isSelected;
    if (_selectBtn.selected) {
        _imgV.image = [UIImage imageContentWithFileName:@"pitchOn---Assistor@2x"];
    }
    else
    {
        _imgV.image = [UIImage imageContentWithFileName:@"NoPitchOn---Assistor@2x"];
    }

}
-(void)setBtnWidth:(CGFloat)btnWidth
{
    _btn.width = btnWidth;
}

-(void)setBtnTitle:(NSString *)btnTitle
{
    [_btn setTitle:btnTitle forState:UIControlStateNormal];
}

-(void)setBtnBackgroundColor:(UIColor *)btnBackgroundColor
{
    [_btn setBackgroundColor:btnBackgroundColor];
}
-(void)hideAllSelectedView
{
    _selectBtn.hidden = YES;
    _titleLb.hidden = YES;
    _imgV.hidden = YES;
}


-(void)decoratorULifeView
{
    _imgV.x = 10;
    _imgV.y = 12;
    _imgV.height = 24;
    _imgV.width = 24;
     _imgV.image = [UIImage  imageContentWithFileName:@"NoPitchOn---Assistor@2x"];
    _btn2.layer.borderColor = kUIColorFromRGB(color_0xcdcdcd).CGColor;
    _btn2.layer.borderWidth = 0.5;
    _btn2.layer.cornerRadius = 8;
    _btn2.backgroundColor = [UIColor whiteColor];
    [_btn2 setTitleColor:kUIColorFromRGB(color_0x303030) forState:UIControlStateNormal];
    _btn2.titleLabel.font = [UIFont systemFontOfSize:16];
    [_btn2 setTitle:@"取消合作" forState:UIControlStateNormal ];
    
    _btn.layer.cornerRadius = 8;
    _btn.layer.masksToBounds = YES;
    _btn.backgroundColor = kUIColorFromRGB(color_mainTheme);
    [_btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _btn.titleLabel.font = [UIFont systemFontOfSize:16];
     [_btn setTitle:@"发布" forState:UIControlStateNormal ];
}
@end
