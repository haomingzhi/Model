//
//  JYNoDataViewController.m
//  yihui
//
//  Created by wujiayuan on 15/9/25.
//  Copyright (c) 2015年 ORANLLC_IOS1. All rights reserved.
//

#import "JYNoDataViewController.h"

@interface JYNoDataViewController ()
{
    
    IBOutlet UIImageView *_imgV;
    IBOutlet UIButton *_handleBtn;
}
@property (weak, nonatomic) IBOutlet UILabel *labelNoData;

@end

@implementation JYNoDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _handleBtn.layer.borderColor = kUIColorFromRGB(color_unSelColor).CGColor;
    _handleBtn.layer.borderWidth = 0.5;
    self.view.height = __SCREEN_SIZE.height - 64;
    self.view.width = __SCREEN_SIZE.width;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) setNoDataHint:(NSString *)noDataHint
{
    _noDataHint = noDataHint;
    self.labelNoData.text = _noDataHint;
}

-(void)fitModeY:(CGFloat)y
{
    [self fitModeY:y withImgVWidth:130 withViewY:0];
}
-(void)fitModeY:(CGFloat)y withImgVWidth:(CGFloat)w
{
     [self fitModeY:y withImgVWidth:w withViewY:0];
}
-(void)fitModeY:(CGFloat)y withImgVWidth:(CGFloat)w withViewY:(CGFloat)vy
{
    _imgV.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _imgV.y = y;
    _imgV.height = w;
    _imgV.width = w;
    _imgV.x = self.view.width/2.0 - _imgV.width/2.0;
    self.labelNoData.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    self.labelNoData.y = _imgV.y + _imgV.height + 12;
    self.labelNoData.x = 0;
     self.labelNoData.font = [UIFont systemFontOfSize:14];
    self.labelNoData.width = self.view.width;
    self.labelNoData.textColor = kUIColorFromRGB(color_8);
     self.view.y = vy;
//    [self fitMode];
    
}

-(void)fitMode
{
    _labelNoData.hidden = YES;
//    _tipBtn.hidden = YES;
//    if(!_contentYYLb)
//    {
//        [self initYYlable];
//    }
//    NSString *name = @"数据获取失败,请检查网络后点击";
//    
//    
//    
//    NSRange aRange = NSMakeRange(name.length, 4);
//    NSMutableAttributedString *mStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%@",name,@"重新连接"]];
//    [mStr addAttribute:NSForegroundColorAttributeName value:kUIColorFromRGB(color_1) range:NSMakeRange(0, name.length)];
//    [mStr addAttribute:NSForegroundColorAttributeName value:kUIColorFromRGB(color_1) range:aRange];
//    YYTextHighlight *highlight = [YYTextHighlight new];
//    //            [highlight setBorder:border];
//    highlight.tapAction = ^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect) {
//        //                [_self showMessage:[NSString stringWithFormat:@"Tap: %@",[text.string substringWithRange:range]]];
//        //                NSLog(@"xfffddd");
//        //        if(self.tapLinkAction)
//        //        {
//        //            self.tapLinkAction(@{@"phone":[text.string substringWithRange:range]});
//        //        }
//        [_tipBtn sendActionsForControlEvents:UIControlEventTouchUpInside];
//    };
//    [mStr setTextHighlight:highlight range:aRange];
//    _contentYYLb.attributedText = mStr;
//    [_contentYYLb sizeToFit];
//    _contentYYLb.x = __SCREEN_SIZE.width/2.0 - _contentYYLb.width/2.0;
}

-(void)setNoDataImageView:(NSString *)img
{
    _imgV.image = [UIImage imageNamed:img];
}


-(void)addNoDataHandleBtn:(NSString*)title
{
    if (_handleBtn.hidden) {
        _handleBtn.hidden = NO;
    }
    [_handleBtn setTitle:title forState:UIControlStateNormal];
}

- (IBAction)handleAction:(id)sender {
    if (_handleAction) {
        _handleAction(sender);
    }
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
