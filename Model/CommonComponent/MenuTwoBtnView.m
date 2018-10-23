//
//  MenuTwoBtnView.m
//  ChaoLiu
//
//  Created by air on 15/8/5.
//  Copyright (c) 2015年 ORANLLC_IOS1. All rights reserved.
//

#import "MenuTwoBtnView.h"

@implementation MenuTwoBtnView
{
    UILabel *_title1Lb;
    UILabel *_title2Lb;
    UIImageView *_img1V;
    UIImageView *_img2V;
    bool _canClickAgain;
}
-(void)awakeFromNib
{
    self.height = 49;
    self.width = __SCREEN_SIZE.width;
    [self setCurIndex:0];
//    [self addObserver:self forKeyPath:@"frame" options:NSKeyValueObservingOptionOld context:nil];
}

//-(void)dealloc
//{
//    [self removeObserver:self forKeyPath:@"frame"];
//}

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

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqual:@"frame"]) {
        UIButton *btn1 = (UIButton *)[self viewWithTag:100];
        btn1.height = self.height;
        
        UIButton *btn2 = (UIButton *)[self viewWithTag:101];
        btn2.height = self.height;
    }
}

-(NSInteger)curIndex
{
    return _curBtn.tag - 100;
}

- (IBAction)handleAction:(UIButton *)btn {
//    btn.userInteractionEnabled = NO;
    if (btn == _curBtn&&!_canClickAgain) {
        btn.userInteractionEnabled = NO;
        return ;
    }
    _curBtn.userInteractionEnabled = YES;
    _curBtn.selected = NO;
    if (btn.tag != 103) {
        if (_title1Lb) {
//        UILabel *curlb = (UILabel *)[self viewWithTag:_curBtn.tag + 100];
//            curlb.textColor = kUIColorFromRGB(color_mainTheme);
//            UILabel *lb = (UILabel *)[self viewWithTag:btn.tag + 100];
//            lb.textColor = kUIColorFromRGB(color_0xff6b00);
        }
        else
        {
//        [_curBtn setTitleColor:kUIColorFromRGB(color_mainTheme) forState:UIControlStateNormal];
//        [btn setTitleColor:kUIColorFromRGB(color_0xff6b00) forState:UIControlStateNormal];
        }
//        _curBtn.height = 49;
//         _curBtn.backgroundColor = kUIColorFromRGB(0x39c1b8);
        _curBtn  = btn;
//        _curBtn.height = 49;
//                _curBtn.backgroundColor = [UIColor whiteColor];
        _curBtn.selected = YES;
    }
    if (_handle) {
        _handle(btn);
    }
}

-(void)setMenuTitleTexts:(NSArray *)titleArr
{
    if(_title1Lb)
    {
        UIButton *btn1 = (UIButton *)[self viewWithTag:100];
        [btn1 setTitle:@"" forState:UIControlStateNormal];
        UIButton *btn2 = (UIButton *)[self viewWithTag:101];
        [btn2 setTitle:@"" forState:UIControlStateNormal];
            _title1Lb.text = titleArr[0];
            _title2Lb.text = titleArr[1];
        _title1Lb.textAlignment = NSTextAlignmentCenter;
        _title2Lb.textAlignment = NSTextAlignmentCenter;
        if (_title2Lb.text.length == 3) {
            [_img2V addHorizontalConstraint:-19];
        }
        else
        {
        [_img2V addHorizontalConstraint:-15];
            [_img2V updateConstraints];
        }
    }
    else
    {
     UIButton *btn1 = (UIButton *)[self viewWithTag:100];
    [btn1 setTitle:titleArr[0] forState:UIControlStateNormal];
     UIButton *btn2 = (UIButton *)[self viewWithTag:101];
    [btn2 setTitle:titleArr[1] forState:UIControlStateNormal];
    }
}

-(void)setMenuTitleColors:(NSArray *)titleArr
{
    UIButton *btn1 = (UIButton *)[self viewWithTag:100];
    [btn1 setTitleColor:titleArr[0] forState:UIControlStateNormal];
    UIButton *btn2 = (UIButton *)[self viewWithTag:101];
    [btn2 setTitleColor:titleArr[1] forState:UIControlStateNormal];
}

-(void)decoratorView
{
    //      _title1Lb =  (UILabel *)[self viewWithTag:200];
    //        _titleLb2 =  (UILabel *)[self viewWithTag:201];
//            UILabel *titleLb = [[UILabel alloc] init];
//            [titleLb setTranslatesAutoresizingMaskIntoConstraints:NO];
//            [titleLb addWidthConstraint:JYLayoutRelationGreaterThanOrEqual width:30];
//            [titleLb addHeightConstraint:JYLayoutRelationGreaterThanOrEqual width:15];
//    
//            titleLb.textColor = [UIColor blackColor];
//            titleLb.text = @"xxxx";
//            [titleLb sizeToFit];
//                UIButton *btn1 = (UIButton *)[self viewWithTag:100];
//            [btn1 addSubview:titleLb];
//            [titleLb alignViewHCenter:29];
//            _title1Lb = titleLb;
//            _title1Lb.tag = 200;

//            UILabel *titleLb2 = [[UILabel alloc] init];
//            _title2Lb = titleLb2;
//            [titleLb2 setTranslatesAutoresizingMaskIntoConstraints:NO];
//            [titleLb2 addWidthConstraint:JYLayoutRelationGreaterThanOrEqual width:30];
//            [titleLb2 addHeightConstraint:JYLayoutRelationGreaterThanOrEqual width:15];
//            _title2Lb.tag = 201;
//            titleLb2.textColor = [UIColor blackColor];
//            titleLb2.text = @"xxxx";
//            [titleLb2 sizeToFit];
//                UIButton *btn2 = (UIButton *)[self viewWithTag:101];
//            [btn2 addSubview:titleLb2];
//            [titleLb2 alignViewHCenter:29];
    
    _title1Lb = [self createView:@"UILabel" withParentView:[self viewWithTag:100] withFrame:CGRectMake(33, 0, 30, 15)];
    _title1Lb.tag = 200;
    _title2Lb = [self createView:@"UILabel" withParentView:[self viewWithTag:101] withFrame:CGRectMake(33, 29, 30, 15)];
     _title2Lb.tag = 201;
    
    _img1V = [self createView:@"UIImageView" withParentView:[self viewWithTag:100] withFrame:CGRectMake(-15, 6, 20, 20)];
    _img1V.image = [UIImage imageContentWithFileName:@"news_comment@2x"];
    _img2V = [self createView:@"UIImageView" withParentView:[self viewWithTag:101] withFrame:CGRectMake(-15, 6, 20, 20)];
    _img2V.image = [UIImage imageContentWithFileName:@"news_attention@2x"];
//    UIButton *btn1 = (UIButton *)[self viewWithTag:100];
//    [btn1 setBackgroundImage:[[UIImage imageNamed:@"tab_bg_sel"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 2, 0) resizingMode:UIImageResizingModeStretch] forState:UIControlStateSelected];
//
//    UIButton *btn2 = (UIButton *)[self viewWithTag:100];
//    [btn2 setBackgroundImage:[[UIImage imageNamed:@"tab_bg_sel"] stretchableImageWithLeftCapWidth:12 topCapHeight:10] forState:UIControlStateSelected];
}
-(id)createView:(NSString *)viewName withParentView:(UIView *)v withFrame:(CGRect)frame
{
    Class cls = NSClassFromString(viewName);
    id  titleLb2 = [[cls alloc] init];
//    _title2Lb = titleLb2;
    [titleLb2 setTranslatesAutoresizingMaskIntoConstraints:NO];
    [titleLb2 addWidthConstraint:JYLayoutRelationGreaterThanOrEqual width:frame.size.width];
    [titleLb2 addHeightConstraint:JYLayoutRelationGreaterThanOrEqual width:frame.size.height];
    if ([titleLb2 isKindOfClass:[UILabel class]]) {
        [titleLb2 setValue:[UIFont systemFontOfSize:16] forKey:@"font"];
        [titleLb2 setValue:kUIColorFromRGB(color_0x666666) forKey:@"textColor" ];
//        [titleLb2 setValue:@"xxxx" forKey:@"text"];
        [titleLb2 sizeToFit];
    }
    
    UIButton *btn2 = (UIButton *)v;
    [btn2 addSubview:titleLb2];
    [titleLb2 addVerticalConstraint];
    [titleLb2 addHorizontalConstraint:frame.origin.x];
    return titleLb2;
}

-(void)setMenuTitleImgs:(NSArray *)imgArr
{
    _img1V.image = [UIImage imageContentWithFileName:imgArr[0]];
    _img2V.image = [UIImage imageContentWithFileName:imgArr[1]];
}

-(void)setMenuBackgroundImgs:(NSArray *)imgArr
{

}

-(void)setMenuSelectedBackgroundImgs:(NSArray *)imgArr
{

}
-(void)decoratorULifeViewNormal
{
    _canClickAgain = YES;
    _title1Lb = [self createView:@"UILabel" withParentView:[self viewWithTag:100] withFrame:CGRectMake(18, 29, 30, 15)];
    _title1Lb.tag = 200;
    _title2Lb = [self createView:@"UILabel" withParentView:[self viewWithTag:101] withFrame:CGRectMake(18, 29, 30, 15)];
    _title2Lb.tag = 201;
    
    _img1V = [self createView:@"UIImageView" withParentView:[self viewWithTag:100] withFrame:CGRectMake(-15, 6, 20, 20)];
    _img1V.image = [UIImage imageContentWithFileName:@"news_comment@2x"];
    _img2V = [self createView:@"UIImageView" withParentView:[self viewWithTag:101] withFrame:CGRectMake(-15, 6, 20, 20)];
    _img2V.image = [UIImage imageContentWithFileName:@"news_unAtttention@2x"];
    _img1V.superview.backgroundColor = [UIColor whiteColor];
    _img2V.superview.backgroundColor = [UIColor whiteColor];
    [self viewWithTag:800].backgroundColor = kUIColorFromRGB(color_0xe2e2e2);
    UILabel *lineLb = [self viewWithTag:333];
    if(!lineLb)
    {
        lineLb = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, __SCREEN_SIZE.width, 0.5)];
        lineLb.backgroundColor = kUIColorFromRGB(color_0xe2e2e2);
        lineLb.tag = 333;
        [self addSubview:lineLb];
    }
}

-(void)decoratorULifeViewEdit
{
     _canClickAgain = YES;
    UIButton *btn =(UIButton *)[self viewWithTag:100];
     btn.titleLabel.font = [UIFont systemFontOfSize:18];
    [btn setTitleColor:kUIColorFromRGB(color_mainTheme) forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor whiteColor];
    btn.x = 10;
    btn.y = 5;
    btn.width = (__SCREEN_SIZE.width - 20)/2 - 5;
    btn.height = self.height - btn.y * 2;
    btn.layer.cornerRadius = 8;
    btn.layer.borderWidth = 0.5;
    btn.layer.masksToBounds = YES;
    btn.layer.borderColor = kUIColorFromRGB(color_0xcdcdcd).CGColor;
    
    UIButton *btn2 =(UIButton *)[self viewWithTag:101];
    btn2.titleLabel.font = [UIFont systemFontOfSize:18];
    [btn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn2.y = 5;
    btn2.width = (__SCREEN_SIZE.width - 20)/2 - 5;
    btn2.x = btn2.width + 10 + 10;
    btn2.height = self.height - btn2.y * 2;
    btn2.layer.cornerRadius = 8;
    btn2.backgroundColor = kUIColorFromRGB(color_mainTheme);
    btn2.layer.masksToBounds = YES;
     UILabel *lineLb = [self viewWithTag:800];
    [lineLb removeFromSuperview];
    UILabel *lineLb2 = (UILabel *)[self viewWithTag:822];
    if(!lineLb2)
    {
        lineLb2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, __SCREEN_SIZE.width, 0.5)];
        lineLb2.backgroundColor = kUIColorFromRGB(color_0xe2e2e2);
        [self addSubview:lineLb2];
    }
    self.backgroundColor = [UIColor whiteColor];
    
    
}
//-(id)init
//{
//    self = [[[NSBundle mainBundle] loadNibNamed:@"MenuTwoBtnView" owner:nil options:nil] lastObject];
//    if (self) {
//        
//    }
//    return self;
//}

@end
