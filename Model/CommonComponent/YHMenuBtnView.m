//
//  YHMenuBtnView.m
//  yihui
//
//  Created by air on 15/8/26.
//  Copyright (c) 2015年 ORANLLC_IOS1. All rights reserved.
//

#import "YHMenuBtnView.h"
#import "MenuTwoBtnView.h"
@implementation YHMenuBtnView
{
    UILabel *_title1Lb;
     UILabel *_titleLb2;
    UILabel *_btn2TitleLb;
    UIImageView *_img1V;
    UIImageView *_img2V;
    id<JYTwoBtnMenuComponent> _component;
}
+ (UILabel *)createLableWithBtn:(UIButton *)btn1
{
   UILabel *titleLb = [[UILabel alloc] init];
    titleLb.tag = btn1.tag + 100;
    [titleLb setTranslatesAutoresizingMaskIntoConstraints:NO];
    [titleLb addWidthConstraint:JYLayoutRelationGreaterThanOrEqual width:30];
    [titleLb addHeightConstraint:JYLayoutRelationGreaterThanOrEqual width:15];
    
    titleLb.textColor = [UIColor blackColor];
    titleLb.text = @"xxxx";
    [titleLb sizeToFit];
//    UIButton *btn1 = (UIButton *)[self viewWithTag:100];
    [btn1 addSubview:titleLb];
    [titleLb alignViewCenter];
    return titleLb;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(id)initWithComponent:(id<JYTwoBtnMenuComponent>)comp
{
    self = [super init];
    if (self) {
          _component = comp;
//        UILabel *titleLb = [[UILabel alloc] init];
//        [titleLb setTranslatesAutoresizingMaskIntoConstraints:NO];
//        [titleLb addWidthConstraint:JYLayoutRelationGreaterThanOrEqual width:30];
//        [titleLb addHeightConstraint:JYLayoutRelationGreaterThanOrEqual width:15];
//        
//        titleLb.textColor = [UIColor blackColor];
//        titleLb.text = @"xxxx";
//        [titleLb sizeToFit];
//        UIButton *btn1 = (UIButton *)[(UIView *)_component viewWithTag:100];
//        [btn1 addSubview:titleLb];
//        [titleLb alignViewCenter];
//        _title1Lb = titleLb;
//        
//        
//        UILabel *titleLb2 = [[UILabel alloc] init];
//                _titleLb2 = titleLb2;
//        [titleLb2 setTranslatesAutoresizingMaskIntoConstraints:NO];
//        [titleLb2 addWidthConstraint:JYLayoutRelationGreaterThanOrEqual width:30];
//        [titleLb2 addHeightConstraint:JYLayoutRelationGreaterThanOrEqual width:15];
//        
//        titleLb2.textColor = [UIColor blackColor];
//        titleLb2.text = @"xxxx";
//        [titleLb2 sizeToFit];
//        UIButton *btn2 = (UIButton *)[(UIView *)_component viewWithTag:101];
//        [btn2 removeTarget:_component action:@selector(handleAction:) forControlEvents:UIControlEventTouchUpInside];
//        [btn2 addTarget:self action:@selector(handleAction:) forControlEvents:UIControlEventTouchUpInside];
//        [btn2 addSubview:titleLb2];
//        [titleLb2 alignViewCenter];
        
        [self addSubview:(UIView *)_component];
    }
  
    return self;
}

//-(id)init
//{
//    self = [super init];
//    if (self) {
////        [YHMenuBtnView createLableWithBtn:(UIButton *)[self viewWithTag:100]];
////        [YHMenuBtnView createLableWithBtn:(UIButton *)[self viewWithTag:101]];
////      _title1Lb =  (UILabel *)[self viewWithTag:200];
////        _titleLb2 =  (UILabel *)[self viewWithTag:201];
//        UILabel *titleLb = [[UILabel alloc] init];
//        [titleLb setTranslatesAutoresizingMaskIntoConstraints:NO];
//        [titleLb addWidthConstraint:JYLayoutRelationGreaterThanOrEqual width:30];
//        [titleLb addHeightConstraint:JYLayoutRelationGreaterThanOrEqual width:15];
//        
//        titleLb.textColor = [UIColor blackColor];
//        titleLb.text = @"xxxx";
//        [titleLb sizeToFit];
//            UIButton *btn1 = (UIButton *)[self viewWithTag:100];
//        [btn1 addSubview:titleLb];
//        [titleLb alignViewCenter];
//        _title1Lb = titleLb;
//        
//        
//        UILabel *titleLb2 = [[UILabel alloc] init];
////        _titleLb2 = titleLb2;
//        [titleLb2 setTranslatesAutoresizingMaskIntoConstraints:NO];
//        [titleLb2 addWidthConstraint:JYLayoutRelationGreaterThanOrEqual width:30];
//        [titleLb2 addHeightConstraint:JYLayoutRelationGreaterThanOrEqual width:15];
//        
//        titleLb2.textColor = [UIColor blackColor];
//        titleLb2.text = @"xxxx";
//        [titleLb2 sizeToFit];
//            UIButton *btn2 = (UIButton *)[self viewWithTag:101];
//        [btn2 addSubview:titleLb2];
//        [titleLb2 alignViewCenter];
//    }
//    return self;
//}

-(void)setMenuTitleTexts:(NSArray *)titleArr
{
//    [_component setMenuTitleTexts:@[@"",@""]];
//    _title1Lb.text = titleArr[0];
//    _titleLb2.text = titleArr[1];
}

-(void)setMenuTitleColors:(NSArray *)titleArr
{
    [_component setMenuTitleColors:titleArr];
}

-(void)handleAction:(UIButton *)btn
{
    NSLog(@"sss fff");
    [_component handleAction:btn];
}

-(void)setMenuTitleImgs:(NSArray *)imgArr
{
    _img1V.image = [UIImage imageNamed:imgArr[0]];
    _img2V.image = [UIImage imageNamed:imgArr[1]];
}

@end
