//
//  JYNetErrorViewController.m
//  chenxiaoer
//
//  Created by air on 16/3/31.
//  Copyright © 2016年 ORANLLC_IOS1. All rights reserved.
//

#import "JYNetErrorViewController.h"
#import "YYKit.h"
#import "WBStatusHelper.h"
#import "WBStatusLayout.h"
#import "WBStatusComposeTextParser.h"
@interface JYNetErrorViewController ()
{
 YYLabel *_contentYYLb;
}
@end

@implementation JYNetErrorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _tipBtn.layer.cornerRadius = 6;
    _tipBtn.layer.masksToBounds = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setTip:(NSString *)tip
{
    [_tipBtn setTitle:tip forState:UIControlStateNormal];
}
-(void)fitModeY:(CGFloat)y
{
    [self fitModeY:y withImgVWidth:70];
}
-(void)fitModeY:(CGFloat)y withImgVWidth:(CGFloat)w
{
    _imgV.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    self.imgV.y = y;
    _imgV.height = w;
    _imgV.width = w;
    _imgV.x = __SCREEN_SIZE.width/2.0 - _imgV.width/2.0;
    self.labelNoData.y = self.imgV.y + self.imgV.height + 20;
    self.labelNoData.textColor = kUIColorFromRGB(color_1);
   
    [self fitMode];

}

-(void)fitModeNoImgV:(CGFloat)y
{
    self.labelNoData.y = y;
    self.labelNoData.font = [UIFont systemFontOfSize:15];
    self.labelNoData.textColor = kUIColorFromRGB(color_1);
}

-(void)fitModeBY:(CGFloat)y
{
    [self fitModeY:y withImgVWidth:40];
}

-(void)fitMode
{
    _labelNoData.hidden = YES;
    _tipBtn.hidden = YES;
    if(!_contentYYLb)
    {
        [self initYYlable];
    }
    NSString *name = @"数据获取失败,请检查网络后点击";
    
    
    
    NSRange aRange = NSMakeRange(name.length, 4);
    NSMutableAttributedString *mStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%@",name,@"重新连接"]];
    [mStr addAttribute:NSForegroundColorAttributeName value:kUIColorFromRGB(color_1) range:NSMakeRange(0, name.length)];
    [mStr addAttribute:NSForegroundColorAttributeName value:kUIColorFromRGB(color_1) range:aRange];
    YYTextHighlight *highlight = [YYTextHighlight new];
    //            [highlight setBorder:border];
    highlight.tapAction = ^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect) {
        //                [_self showMessage:[NSString stringWithFormat:@"Tap: %@",[text.string substringWithRange:range]]];
        //                NSLog(@"xfffddd");
//        if(self.tapLinkAction)
//        {
//            self.tapLinkAction(@{@"phone":[text.string substringWithRange:range]});
//        }
        [_tipBtn sendActionsForControlEvents:UIControlEventTouchUpInside];
    };
    [mStr setTextHighlight:highlight range:aRange];
    _contentYYLb.attributedText = mStr;
    [_contentYYLb sizeToFit];
    _contentYYLb.x = __SCREEN_SIZE.width/2.0 - _contentYYLb.width/2.0;
}

-(void)initYYlable
{
    _contentYYLb = [[YYLabel alloc] initWithFrame:CGRectMake(15, _imgV.y + _imgV.height, 280, 40)];
    _contentYYLb.font = [UIFont systemFontOfSize:14];
    WBStatusComposeTextParser *parser = [WBStatusComposeTextParser new];
    parser.font = [UIFont systemFontOfSize:14];
    _contentYYLb.textParser = parser;
    _contentYYLb.textAlignment = NSTextAlignmentCenter;
   
    WBTextLinePositionModifier *modifier = [WBTextLinePositionModifier new];
    modifier.font = [UIFont systemFontOfSize:14];//[UIFont fontWithName:@"Heiti SC" size:14];
    modifier.paddingTop = 4;
    modifier.paddingBottom = 6;
    modifier.lineHeightMultiple = 1.5;
    //    _contentYYLb.textColor = kUIColorFromRGB(color_1);
    _contentYYLb.linePositionModifier = modifier;
    _contentYYLb.width = __SCREEN_SIZE.width - 30;//15 - _contentYYLb.x;
    [self.view addSubview:_contentYYLb];
    _contentYYLb.numberOfLines = 2;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
