//
//  MoreOptionTableViewCell.m
//  ulife
//
//  Created by air on 15/12/21.
//  Copyright © 2015年 ORANLLC_IOS1. All rights reserved.
//

#import "MoreOptionTableViewCell.h"

@implementation MoreOptionTableViewCell
{
    IBOutlet UILabel *_timeLb;
    IBOutlet UIView *_containerView;
    IBOutlet UIButton *_oneBtn;
    NSInteger _objRow;
    IBOutlet UIButton *_twoBtn;
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
    if([dataDic[@"cellStatus"] integerValue]== 1)
    {
        _containerView.x = 44;
    }
    else
    {
        _containerView.x = 0;
    }
    _timeLb.text = dataDic[@"time"];
    [_oneBtn setTitle:dataDic[@"oneTitle"] forState:UIControlStateNormal];
    [_twoBtn setTitle:dataDic[@"twoTitle"] forState:UIControlStateNormal];
    _objRow = [dataDic[@"row"] integerValue];
    if([dataDic[@"hiddenOneBtn"] boolValue])
    {
        _oneBtn.hidden = YES;
        _twoBtn.hidden = NO;
    }
    else
    if([dataDic[@"hiddenBtn"] boolValue])
    {
        [self hiddenBtn];
    }
    else
    {
        [self showBtn];
    }
    if ([dataDic[@"mode"] integerValue] == 1) {
        [self decoratorULifeView:dataDic];
    }
    else
    {
     [self decoratorULifeViewB:dataDic];
    }
        _containerView.width = __SCREEN_SIZE.width;
}


-(void)decoratorULifeViewB:(NSDictionary *)dataDic
{
//    [_oneBtn setTitle:@"取消合作" forState:UIControlStateNormal];
//    [_twoBtn setTitle:@"发布" forState:UIControlStateNormal];
    
    _oneBtn.layer.borderColor = kUIColorFromRGB(color_0xcdcdcd).CGColor;
    _oneBtn.layer.cornerRadius = 4;
    _oneBtn.layer.masksToBounds = YES;
    _oneBtn.layer.borderWidth = 0.5;
    
    _oneBtn.backgroundColor = [UIColor whiteColor];
    [_oneBtn setTitleColor:kUIColorFromRGB(color_0x303030) forState:UIControlStateNormal];
    
    _twoBtn.backgroundColor = kUIColorFromRGB(color_mainTheme);
    _twoBtn.layer.cornerRadius = 4;
    _twoBtn.layer.masksToBounds = YES;
    [_twoBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}

-(void)decoratorULifeView:(NSDictionary *)dataDic
{
    [_oneBtn setTitle:@"" forState:UIControlStateNormal];
    [_twoBtn setTitle:@"" forState:UIControlStateNormal];
    
    UIImageView *img = (UIImageView *)[_oneBtn viewWithTag:102];
    if(!img)
    {
        img= [[UIImageView alloc] initWithFrame:CGRectMake(4, 4, 17, 17)];
        [img imageWithContent:@"comment@2x"];
        img.tag = 102;
        [_oneBtn addSubview:img];
    }
   
    
    UILabel *textLb = (UILabel *)[_oneBtn viewWithTag:101];
    if (!textLb) {
        textLb = [[UILabel alloc] initWithFrame:CGRectMake(27, 4, 38, 18)];
        textLb.textColor = kUIColorFromRGB(color_0x999999);
        textLb.font = [UIFont systemFontOfSize:14];
        textLb.tag = 101;
        [_oneBtn addSubview:textLb];
    }
    textLb.text = dataDic[@"oneTitle"];

    UIImageView *img2 = (UIImageView *)[_twoBtn viewWithTag:200];
    UILabel *textLb2 = (UILabel *)[_twoBtn viewWithTag:201];
    if (!textLb2) {
        textLb2 = [[UILabel alloc] initWithFrame:CGRectMake(27, 4, 38, 18)];
        textLb2.textColor = kUIColorFromRGB(color_0x999999);
        textLb2.font = [UIFont systemFontOfSize:14];
        textLb2.tag = 201;
        [_twoBtn addSubview:textLb2];
    }
    textLb2.text = dataDic[@"twoTitle"];
    if (!img2) {
        img2 = [[UIImageView alloc] initWithFrame:CGRectMake(4, 4, 17, 17)];
        NSString *imgStr = @"unAttention@2x";
         UIColor *color = kUIColorFromRGB(color_0x999999);
        if ([dataDic[@"hasAttention"] boolValue]) {
            imgStr = @"attention@2x";
             color = kUIColorFromRGB(color_0xf54c36);
        }
        [img2 imageWithContent:imgStr];
        img2.tag = 200;
        [_twoBtn addSubview:img2];
         textLb2.textColor = color;
    }
    else
    {
        NSString *imgStr = @"unAttention@2x";
        UIColor *color = kUIColorFromRGB(color_0x999999);
        if ([dataDic[@"hasAttention"] boolValue]) {
            imgStr = @"attention@2x";
             color = kUIColorFromRGB(color_0xf54c36);
        }
        [img2 imageWithContent:imgStr];
          textLb2.textColor = color;
    }
   
    
  
    
}

-(void)hiddenBtn
{
    _twoBtn.hidden = YES;
    _oneBtn.hidden = YES;
}
- (IBAction)handleAction:(id)sender {
    if (self.handleAction) {
        self.handleAction(@{@"sender":sender,@"row":@(_objRow)});
    }
}

-(void)showBtn
{
    _twoBtn.hidden = NO;
    _oneBtn.hidden = NO;
}

@end
