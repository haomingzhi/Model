//
//  MenuFourBtnViewController.m
//  yihui
//
//  Created by wujiayuan on 15/9/21.
//  Copyright (c) 2015年 ORANLLC_IOS1. All rights reserved.
//

#import "MenuFourBtnViewController.h"

@interface MenuFourBtnViewController ()
{
    UILabel *_title1Lb;
    UILabel *_title2Lb;
    UILabel *_title3Lb;
    UILabel *_title4Lb;
    UIImageView *_img1V;
    UIImageView *_img2V;
    UIImageView *_img3V;
    UIImageView *_img4V;
}
@end

@implementation MenuFourBtnViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.height = 48;
    self.view.width = __SCREEN_SIZE.width;
    [self setCurIndex:0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)setCurIndex:(NSInteger )curIndex
{
    curIndex += 100;
    UIButton *btn = (UIButton *)[self.view viewWithTag:curIndex];
    [self handleAction:btn];
    
}

-(NSInteger)curIndex
{
    return _curBtn.tag - 100;
}

- (IBAction)handleAction:(UIButton *)btn {
    btn.userInteractionEnabled = NO;
    if (btn == _curBtn) {
        return ;
    }
    _curBtn.selected = NO;
    _curBtn.userInteractionEnabled = YES;
    if (btn.tag != 104) {
        if (_title1Lb) {
            //        UILabel *curlb = (UILabel *)[self viewWithTag:_curBtn.tag + 100];
            //            curlb.textColor = kUIColorFromRGB(color_mainTheme);
            //            UILabel *lb = (UILabel *)[self viewWithTag:btn.tag + 100];
            //            lb.textColor = kUIColorFromRGB(color_0xff6b00);
        }
        else
        {
            [_curBtn setTitleColor:kUIColorFromRGB(color_mainTheme) forState:UIControlStateNormal];
            [btn setTitleColor:kUIColorFromRGB(color_0xff6b00) forState:UIControlStateNormal];
        }
        _curBtn.height = 48;
        _curBtn.backgroundColor = kUIColorFromRGB(0x39c1b8);
        _curBtn  = btn;
        _curBtn.height = 50.5;
        _curBtn.backgroundColor = [UIColor clearColor];
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
        UIButton *btn1 = (UIButton *)[self.view viewWithTag:100];
        [btn1 setTitle:@"" forState:UIControlStateNormal];
        UIButton *btn2 = (UIButton *)[self.view viewWithTag:101];
        [btn2 setTitle:@"" forState:UIControlStateNormal];
        UIButton *btn3 = (UIButton *)[self.view viewWithTag:102];
        [btn3 setTitle:@"" forState:UIControlStateNormal];
        UIButton *btn4 = (UIButton *)[self.view viewWithTag:103];
        [btn4 setTitle:@"" forState:UIControlStateNormal];
        _title1Lb.text = titleArr[0];
        _title2Lb.text = titleArr[1];
        _title3Lb.text = titleArr[2];
         _title4Lb.text = titleArr[3];
    }
    else
    {
        UIButton *btn1 = (UIButton *)[self.view viewWithTag:100];
        [btn1 setTitle:titleArr[0] forState:UIControlStateNormal];
        UIButton *btn2 = (UIButton *)[self.view viewWithTag:101];
        [btn2 setTitle:titleArr[1] forState:UIControlStateNormal];
        UIButton *btn3 = (UIButton *)[self.view viewWithTag:102];
        [btn3 setTitle:titleArr[2] forState:UIControlStateNormal];
        UIButton *btn4 = (UIButton *)[self.view viewWithTag:103];
        [btn4 setTitle:titleArr[2] forState:UIControlStateNormal];
    }
}

-(void)setMenuTitleColors:(NSArray *)titleArr
{
    UIButton *btn1 = (UIButton *)[self.view viewWithTag:100];
    [btn1 setTitleColor:titleArr[0] forState:UIControlStateNormal];
    UIButton *btn2 = (UIButton *)[self.view viewWithTag:101];
    [btn2 setTitleColor:titleArr[1] forState:UIControlStateNormal];
    UIButton *btn3 = (UIButton *)[self.view viewWithTag:102];
    [btn3 setTitleColor:titleArr[2] forState:UIControlStateNormal];
    UIButton *btn4 = (UIButton *)[self.view viewWithTag:103];
    [btn4 setTitleColor:titleArr[3] forState:UIControlStateNormal];
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
-(id)createView:(NSString *)viewName withParentView:(UIView *)v withFrame:(CGRect)frame
{
    Class cls = NSClassFromString(viewName);
    id  titleLb2 = [[cls alloc] init];
    //    _title2Lb = titleLb2;
    [titleLb2 setTranslatesAutoresizingMaskIntoConstraints:NO];
    [titleLb2 addWidthConstraint:JYLayoutRelationGreaterThanOrEqual width:frame.size.width];
    [titleLb2 addHeightConstraint:JYLayoutRelationGreaterThanOrEqual width:frame.size.height];
    if ([titleLb2 isKindOfClass:[UILabel class]]) {
        [titleLb2 setValue:[UIFont systemFontOfSize:12] forKey:@"font"];
        [titleLb2 setValue:[UIColor whiteColor] forKey:@"textColor" ];
        [titleLb2 setValue:@"xxxx" forKey:@"text"];
        [titleLb2 sizeToFit];
        [titleLb2 setValue:@(NSTextAlignmentCenter) forKey:@"textAlignment"];
    }
    
    UIButton *btn2 = (UIButton *)v;
    [btn2 addSubview:titleLb2];
    [titleLb2 alignViewHCenter:frame.origin.y];
    return titleLb2;
}

-(void)decoratorView
{
    _title1Lb = [self createView:@"UILabel" withParentView:[self.view viewWithTag:100] withFrame:CGRectMake(0, 29, 30, 15)];
    _title1Lb.tag = 200;
    _title2Lb = [self createView:@"UILabel" withParentView:[self.view viewWithTag:101] withFrame:CGRectMake(0, 29, 30, 15)];
    _title2Lb.tag = 201;
    
    _title3Lb = [self createView:@"UILabel" withParentView:[self.view viewWithTag:102] withFrame:CGRectMake(0, 29, 30, 15)];
    _title3Lb.tag = 202;
    _title4Lb = [self createView:@"UILabel" withParentView:[self.view viewWithTag:103] withFrame:CGRectMake(0, 29, 30, 15)];
    _title4Lb.tag = 203;
    
    _img1V = [self createView:@"UIImageView" withParentView:[self.view viewWithTag:100] withFrame:CGRectMake(0, 6, 20, 20)];
    _img1V.image = [UIImage imageNamed:@"icon_association"];
    _img2V = [self createView:@"UIImageView" withParentView:[self.view viewWithTag:101] withFrame:CGRectMake(0, 6, 20, 20)];
    _img2V.image = [UIImage imageNamed:@"icon_compaty"];
    _img3V = [self createView:@"UIImageView" withParentView:[self.view viewWithTag:102] withFrame:CGRectMake(0, 6, 20, 20)];
    _img3V.image = [UIImage imageNamed:@"btn_icon_contact"];
    _img4V = [self createView:@"UIImageView" withParentView:[self.view viewWithTag:103] withFrame:CGRectMake(0, 6, 20, 20)];
    _img4V.image = [UIImage imageNamed:@"icon_circle"];
}

-(void)setMenuTitleImgs:(NSArray *)imgArr
{
    _img1V.image = [UIImage imageNamed:imgArr[0]];
    _img2V.image = [UIImage imageNamed:imgArr[1]];
    _img3V.image = [UIImage imageNamed:imgArr[2]];
     _img4V.image = [UIImage imageNamed:imgArr[3]];
}

-(void)setMenuBackgroundImgs:(NSArray *)imgArr
{
    
}

-(void)setMenuSelectedBackgroundImgs:(NSArray *)imgArr
{
    
}

@end
