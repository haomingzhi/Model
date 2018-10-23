//
//  MenuThreeBtnView.m
//  ulife
//
//  Created by air on 15/12/24.
//  Copyright © 2015年 ORANLLC_IOS1. All rights reserved.
//

#import "MenuThreeBtnView.h"

@implementation MenuThreeBtnView
{

    IBOutlet UIButton *_threeBtn;
    IBOutlet UIButton *_twoBtn;
    IBOutlet UIButton *_oneBtn;
      bool _canClickAgain;
}
-(void)awakeFromNib
{
    self.height = 49;
    self.width = __SCREEN_SIZE.width;
 
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (IBAction)handleAction:(UIButton *)btn {
    //    btn.userInteractionEnabled = NO;
    if (btn == _curBtn&&!_canClickAgain) {
        btn.userInteractionEnabled = NO;
        return ;
    }
    _curBtn.userInteractionEnabled = YES;
    _curBtn.selected = NO;
//    if (btn.tag != 103) {
//        if (_title1Lb) {
//            //        UILabel *curlb = (UILabel *)[self viewWithTag:_curBtn.tag + 100];
//            //            curlb.textColor = kUIColorFromRGB(color_mainTheme);
//            //            UILabel *lb = (UILabel *)[self viewWithTag:btn.tag + 100];
//            //            lb.textColor = kUIColorFromRGB(color_0xff6b00);
//        }
//        else
//        {
//            //        [_curBtn setTitleColor:kUIColorFromRGB(color_mainTheme) forState:UIControlStateNormal];
//            //        [btn setTitleColor:kUIColorFromRGB(color_0xff6b00) forState:UIControlStateNormal];
//        }
//        _curBtn.height = 49;
        //         _curBtn.backgroundColor = kUIColorFromRGB(0x39c1b8);
        _curBtn  = btn;
//        _curBtn.height = 49;
        //                _curBtn.backgroundColor = [UIColor whiteColor];
        _curBtn.selected = YES;
//    }
    if (_handle) {
        _handle(btn);
    }
}
-(void)setMenuTitleTexts:(NSArray *)titleArr
{
//    if(_title1Lb)
//    {
//        UIButton *btn1 = (UIButton *)[self viewWithTag:100];
//        [btn1 setTitle:@"" forState:UIControlStateNormal];
//        UIButton *btn2 = (UIButton *)[self viewWithTag:101];
//        [btn2 setTitle:@"" forState:UIControlStateNormal];
////        _title1Lb.text = titleArr[0];
////        _title2Lb.text = titleArr[1];
////        _title1Lb.textAlignment = NSTextAlignmentCenter;
////        _title2Lb.textAlignment = NSTextAlignmentCenter;
//    }
//    else
//    {
        UIButton *btn1 = (UIButton *)[self viewWithTag:100];
        [btn1 setTitle:titleArr[0] forState:UIControlStateNormal];
        UIButton *btn2 = (UIButton *)[self viewWithTag:101];
        [btn2 setTitle:titleArr[1] forState:UIControlStateNormal];
    UIButton *btn3 = (UIButton *)[self viewWithTag:102];
    [btn3 setTitle:titleArr[2] forState:UIControlStateNormal];
//    }
}
-(void)setCurIndex:(NSInteger )curIndex
{
    curIndex += 100;
    UIButton *btn = (UIButton *)[self viewWithTag:curIndex];
    [self handleAction:btn];
    
}

-(void)setCurBtnIndex:(NSInteger)curBtnIndex
{
    UIButton *btn = (UIButton *)[self viewWithTag:curBtnIndex + 100];
    if (btn == _curBtn&&!_canClickAgain) {
        return ;
    }
    if (btn.tag != 103) {
        [_curBtn setTitleColor:kUIColorFromRGB(color_mainTheme) forState:UIControlStateNormal];
        [btn setTitleColor:kUIColorFromRGB(color_0xff6b00) forState:UIControlStateNormal];
        _curBtn  = btn;
    }
}
-(NSInteger)curIndex
{
    return _curBtn.tag - 100;
}

-(void)setMenuTitleColors:(NSArray *)titleArr
{
    UIButton *btn1 = (UIButton *)[self viewWithTag:100];
    [btn1 setTitleColor:titleArr[0] forState:UIControlStateNormal];
    UIButton *btn2 = (UIButton *)[self viewWithTag:101];
    [btn2 setTitleColor:titleArr[1] forState:UIControlStateNormal];
}
-(void)decoratorULifeView
{
    _canClickAgain = YES;
    [_oneBtn setTitleColor:kUIColorFromRGB(color_mainTheme) forState:UIControlStateNormal];
    _oneBtn.height = 36;
    _oneBtn.y = 7;
    _oneBtn.x = 10;
    _oneBtn.width = 93*FITWIDTHSCALE;
    _oneBtn.layer.cornerRadius = 8;
    _oneBtn.layer.masksToBounds = YES;
    _oneBtn.layer.borderColor = kUIColorFromRGB(color_0xcdcdcd).CGColor;
    _oneBtn.layer.borderWidth = 0.5;
    _oneBtn.backgroundColor = [UIColor whiteColor];
    
    [_twoBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _twoBtn.layer.cornerRadius = 8;
     _twoBtn.height = 36;
      _twoBtn.y = 7;
     _twoBtn.width = 93*FITWIDTHSCALE;
    _twoBtn.layer.masksToBounds = YES;
    _twoBtn.backgroundColor = kUIColorFromRGB(color_mainTheme);
    _twoBtn.x = __SCREEN_SIZE.width/2.0 -_twoBtn.width/2.0;
    
    [_threeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _threeBtn.layer.cornerRadius = 8;
     _threeBtn.height = 36;
    _threeBtn.y = 7;
     _threeBtn.width = 93*FITWIDTHSCALE;
    _threeBtn.layer.masksToBounds = YES;
    _threeBtn.backgroundColor = kUIColorFromRGB(color_mainTheme);
     _threeBtn.x =  __SCREEN_SIZE.width - 10 - _threeBtn.width;
    UILabel *lineLb = (UILabel *)[self viewWithTag:822];
    if(!lineLb)
    {
        lineLb = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, __SCREEN_SIZE.width, 0.5)];
        lineLb.backgroundColor = kUIColorFromRGB(color_0xe2e2e2);
        [self addSubview:lineLb];
    }
}
@end
