//
//  OnlyBottomBtnTableViewCell.m
//  ChaoLiu
//
//  Created by air on 15/7/27.
//  Copyright (c) 2015年 ORANLLC_IOS1. All rights reserved.
//

#import "OnlyBottomBtnTableViewCell.h"
#import "WBStatusHelper.h"
#import "WBStatusLayout.h"
#import "WBStatusComposeTextParser.h"

@implementation OnlyBottomBtnTableViewCell
{
    NSInteger _row;
    IBOutlet UIButton *btn;
    NSDictionary *_dataDic;
    YYLabel *_contentYYLb;
     NSIndexPath *_curIndexPath;
}
- (void)awakeFromNib {
    // Initialization code
    btn.width = __SCREEN_SIZE.width;
//    self.width = __SCREEN_SIZE.width;
}
-(UIButton *)getBtn
{
     return btn;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)handleAction:(id)sender {
    if (self.handleAction) {
         self.handleAction(@{@"obj":sender,@"row":@(_row),@"indexPath":_curIndexPath?:[NSIndexPath indexPathForRow:0 inSection:0]});
    }
}

-(void)setPadding:(CGFloat)padding
{
    btn.x = padding;
    btn.width = __SCREEN_SIZE.width - padding * 2;
}
-(void)setHeightPadding:(CGFloat)padding
{
    btn.y = padding;
    btn.height = self.height - padding * 2;
}
-(void)setBtnBackgroundColor:(UIColor *)color
{

    
    btn.backgroundColor = color;
}
-(void)setBtnEnabled:(BOOL)b
{
    btn.enabled = b;
}
-(void)btnLayer:(BOOL)J
{
    if (J==YES)
    {
        btn.layer.borderWidth = 1;
        btn.layer.borderColor = [[UIColor colorWithRed:0.831f green:0.831f blue:0.843f alpha:1.00f] CGColor];
    }
    else
    {
        btn.layer.borderWidth = 0;
        btn.layer.borderColor = [[UIColor blackColor] CGColor];
    }
}

-(void)setBtnTitleColor:(UIColor *)color
{
    [btn setTitleColor:color forState:UIControlStateNormal];
}

-(void)setCellData:(NSDictionary *)dataDic
{
    _dataDic = dataDic;
     _curIndexPath = dataDic[@"indexPath"];
    _row = [dataDic[@"row"] integerValue];
    [btn setTitle:dataDic[@"title"] forState:UIControlStateNormal];
//    [super setCellData:dataDic];
}

-(void)decoratorULifeView
{
    self.backgroundColor = [UIColor whiteColor];
    btn.x = 10;
    btn.y = 6;
    btn.width = __SCREEN_SIZE.width - 20;
    btn.height = self.height - btn.y*2;
    
    btn.backgroundColor = kUIColorFromRGB(color_mainTheme);
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.layer.cornerRadius = 8;
    btn.layer.masksToBounds = YES;
    btn.titleLabel.font = [UIFont systemFontOfSize:18];
    
    UILabel *lineLb = (UILabel *)[self viewWithTag:822];
    if(!lineLb)
    {
        lineLb = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, __SCREEN_SIZE.width, 0.5)];
        lineLb.backgroundColor = kUIColorFromRGB(color_0xe2e2e2);
        [self addSubview:lineLb];
    }

}

-(void)fitMyServerApplyMode:(BOOL)upDown
{
     self.height = 44;
    self.backgroundColor = kUIColorFromRGB(color_4);
    btn.backgroundColor = kUIColorFromRGB(color_4);
    [btn setTitleColor:kUIColorFromRGB(color_5) forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:16];
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [btn sizeToFit];
    btn.width += 20;
 
    btn.x = __SCREEN_SIZE.width/2.0 - btn.width/2.0;
   
    btn.y = self.height/2.0 - btn.height/2.0;
    UIImageView *imgv = [btn viewWithTag:973];
    if (!imgv) {
        imgv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 9, 5)];
        imgv.tag = 973;
       
        imgv.y = 14;
       
        
    }
     imgv.x = btn.width - 14;
    if (upDown) {
        imgv.image = [UIImage imageContentWithFileName:@"up"];
    }
    else
    {
    imgv.image = [UIImage imageContentWithFileName:@"down"];
    }
    [btn addSubview:imgv];
    UIButton *cbtn = [self.contentView viewWithTag:9322];
    if(!cbtn)
    {
        cbtn = [[UIButton alloc] initWithFrame:CGRectMake(0,0,__SCREEN_SIZE.width,44)];
//        cbtn.x = __SCREEN_SIZE.width - 15 - 70;
//        [cbtn setTitle:@"忘记密码" forState:UIControlStateNormal];
        cbtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [cbtn setTitleColor:kUIColorFromRGB(color_3) forState:UIControlStateNormal];
    }
    btn.enabled = NO;
    [cbtn addTarget:self action:@selector(handleAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:cbtn];
}

-(void)fitMyServerApplyModeB
{
    btn.width = 80;
    btn.height = 30;
    btn.x = __SCREEN_SIZE.width - 15 - btn.width;
    btn.y = 28;
    btn.layer.cornerRadius = 3;
    btn.layer.masksToBounds = YES;
    btn.layer.borderColor = kUIColorFromRGB(color_3).CGColor;
    btn.layer.borderWidth = 0.5;
    btn.backgroundColor = kUIColorFromRGB(color_2);
    [btn setTitleColor:kUIColorFromRGB(color_3) forState:UIControlStateNormal];
    self.height = 74;
    if ([_dataDic[@"title"] isEqualToString:@""]) {
        btn.hidden = YES;
    }
    else
        btn.hidden = NO;
    UIButton *cbtn = [self.contentView viewWithTag:726];
    cbtn.hidden = YES;
}


-(void)fitConfirmOrderMode
{
    self.height = 40;
    btn.width = 41;
    btn.height = 22;
    btn.x = __SCREEN_SIZE.width - 15 - btn.width;
    btn.y = self.height/2.0 - btn.height/2.0;
//    btn.layer.cornerRadius = 3;
//    btn.layer.masksToBounds = YES;
//    btn.layer.borderColor = kUIColorFromRGB(color_3).CGColor;
//    btn.layer.borderWidth = 0.5;
    btn.backgroundColor = [UIColor clearColor];
    [btn setTitle:@"" forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:@"icon_switch_normal"] forState:UIControlStateNormal];
    
    
    if(!_contentYYLb)
    {
        [self initYYlable];
    }
    NSString *str1 = @"可用";
    NSString *str2 = _dataDic[@"integral"];
    NSString *str3 = @"积分抵用";
    NSString *str4 = _dataDic[@"money"];
    NSString *str5 = @"元";
    
    NSRange range1 = NSMakeRange(str1.length, str2.length);
    NSRange range2 = NSMakeRange(str1.length+str2.length, str3.length);
    NSRange range3 = NSMakeRange(str1.length+str2.length+str3.length,str4.length);
    NSRange range4 = NSMakeRange(str1.length+str2.length+str3.length+str4.length,str5.length);
    NSMutableAttributedString *mStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%@%@%@%@",str1,str2,str3,str4,str5]];
    [mStr addAttribute:NSForegroundColorAttributeName value:kUIColorFromRGB(color_1) range:NSMakeRange(0, str1.length)];
    [mStr addAttribute:NSForegroundColorAttributeName value:kUIColorFromRGB(color_3) range:range1];
    [mStr addAttribute:NSForegroundColorAttributeName value:kUIColorFromRGB(color_1) range:range2];
    [mStr addAttribute:NSForegroundColorAttributeName value:kUIColorFromRGB(color_3) range:range3];
    [mStr addAttribute:NSForegroundColorAttributeName value:kUIColorFromRGB(color_1) range:range4];
    YYTextHighlight *highlight = [YYTextHighlight new];
    //            [highlight setBorder:border];
   
    
    
//    YYTextHighlight *highlightPhone = [YYTextHighlight new];
//    //            [highlight setBorder:border];
//    highlightPhone.tapAction = ^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect) {
//        NSString *str= [NSString stringWithFormat: @"tel://%@",busiSystem.setPageManager.tell];
//        str=[str stringByReplacingOccurrencesOfString:@"(" withString:@""];
//        str=[str stringByReplacingOccurrencesOfString:@")" withString:@""];
//        UIWebView * callWebview = [[UIWebView alloc] init];
//        [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
//        [self.view addSubview:callWebview];
//    };
//    [mStr setTextHighlight:highlightPhone range:rangePhone];
    
    _contentYYLb.attributedText = mStr;
    

    
}

-(void)initYYlable
{
    _contentYYLb = [[YYLabel alloc] initWithFrame:CGRectMake(15, 0,__SCREEN_SIZE.width - 60, 40)];
    _contentYYLb.font = [UIFont systemFontOfSize:15];
    WBStatusComposeTextParser *parser = [WBStatusComposeTextParser new];
    parser.font = [UIFont systemFontOfSize:15];
    _contentYYLb.textParser = parser;
    _contentYYLb.textAlignment = NSTextAlignmentLeft;
    
    WBTextLinePositionModifier *modifier = [WBTextLinePositionModifier new];
    modifier.font = [UIFont systemFontOfSize:15];
    modifier.paddingTop = 0;
    modifier.paddingBottom = 0;
    modifier.lineHeightMultiple = 1.2;
    //    modifier.pa
    _contentYYLb.textColor = kUIColorFromRGB(color_1);
    _contentYYLb.linePositionModifier = modifier;
    _contentYYLb.x = 15;
    _contentYYLb.width = __SCREEN_SIZE.width-60; //15 - _contentYYLb.x;
    _contentYYLb.height = 40;
    
    _contentYYLb.numberOfLines = 1;
    [_contentYYLb setBackgroundColor:[UIColor clearColor]];
    [self.contentView addSubview:_contentYYLb];
    
    
}

-(void)fitMyServerApplyModeC
{
    btn.hidden = YES;
     UIButton *cbtn = [self.contentView viewWithTag:726];
       cbtn.hidden = YES;
     self.height = 74;
}

-(void)fitMyServerApplyModeD:(NSString *)btnName
{
      btn.hidden = NO;
    self.height = 74;
    btn.width = 80;
    btn.height = 30;
    btn.x = __SCREEN_SIZE.width - 15 - btn.width;
    btn.y = 28;
    btn.layer.cornerRadius = 3;
    btn.layer.masksToBounds = YES;
    btn.layer.borderColor = kUIColorFromRGB(color_3).CGColor;
    btn.layer.borderWidth = 0.5;
    
    btn.backgroundColor = kUIColorFromRGB(color_2);
    [btn setTitleColor:kUIColorFromRGB(color_3) forState:UIControlStateNormal];
    
    UIButton *cbtn = [self.contentView viewWithTag:726];
    if (!cbtn) {
        cbtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 28, 80, 30)];
        cbtn.tag = 726;
           [cbtn addTarget:self action:@selector(extrHandle:) forControlEvents:UIControlEventTouchUpInside];
    }
    cbtn.x = btn.x - 10 - cbtn.width;
    cbtn.layer.cornerRadius = 3;
    cbtn.layer.masksToBounds = YES;
    cbtn.layer.borderColor = kUIColorFromRGB(color_3).CGColor;
    cbtn.layer.borderWidth = 0.5;
    [cbtn setTitle:btnName forState:UIControlStateNormal];
    [cbtn setTitleColor:kUIColorFromRGB(color_3) forState:UIControlStateNormal];
    [self.contentView addSubview:cbtn];
    cbtn.hidden = NO;
}

-(void)extrHandle:(UIButton *)sbtn
{
    if (_extrHandleAction) {
        _extrHandleAction(@{@"obj":btn,@"row":@(_row)});
    }
}

-(void)extrHandle2:(UIButton *)sbtn
{
    if (_extrHandleAction2) {
        _extrHandleAction2(@{@"obj":sbtn,@"row":@(_row)});
    }
}

-(void)extrHandle3:(UIButton *)sbtn
{
     if (_extrHandleAction3) {
          _extrHandleAction3(@{@"obj":sbtn,@"row":@(_row)});
     }
}

-(void)fitRepairMode
{
    btn.hidden = NO;
    self.height = 50;
    btn.width = 80;
    btn.height = 35;
    btn.x = __SCREEN_SIZE.width - 15 - btn.width;
    btn.y = 8;
    btn.layer.cornerRadius = 3;
    btn.layer.masksToBounds = YES;
    btn.layer.borderColor = kUIColorFromRGB(color_3).CGColor;
    btn.layer.borderWidth = 0.5;
    
    btn.backgroundColor = kUIColorFromRGB(color_2);
    [btn setTitleColor:kUIColorFromRGB(color_3) forState:UIControlStateNormal];
    
    UIButton *cbtn = [self.contentView viewWithTag:726];
    if (!cbtn) {
        cbtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 8, 80, 35)];
        cbtn.tag = 726;
        [cbtn addTarget:self action:@selector(extrHandle:) forControlEvents:UIControlEventTouchUpInside];
    }
    cbtn.x = btn.x - 10 - cbtn.width;
    cbtn.layer.cornerRadius = 3;
    cbtn.layer.masksToBounds = YES;
    cbtn.layer.borderColor = kUIColorFromRGB(color_3).CGColor;
    cbtn.layer.borderWidth = 0.5;
    [cbtn setTitle:@"再次申请" forState:UIControlStateNormal];
    [cbtn setTitleColor:kUIColorFromRGB(color_3) forState:UIControlStateNormal];
       cbtn.hidden = NO;
    [self.contentView addSubview:cbtn];
    UILabel *lineLb = (UILabel *)[self.contentView viewWithTag:822];
    if(!lineLb)
    {
        lineLb = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, __SCREEN_SIZE.width, 0.5)];
        lineLb.backgroundColor = kUIColorFromRGB(color_lineColor);
        [self.contentView addSubview:lineLb];
    }
   
}

-(void)fitRepairModeB
{
    [self fitWaterInfoMode];
    
}

-(void)fitRegMode
{
    self.height = 87;
    btn.width = __SCREEN_SIZE.width - 30;
    btn.height = 46;
    btn.x = 15;
    btn.y = 41;
     btn.layer.cornerRadius = btn.height/2.0;
//    btn.layer.masksToBounds = YES;
      [btn setTitleColor:kUIColorFromRGB(color_2) forState:UIControlStateNormal];
//    self.backgroundColor = kUIColorFromRGB(color_9);
    btn.backgroundColor = kUIColorFromRGB(color_0xf82D45);
     btn.layer.shadowRadius = 8.0;
     btn.layer.shadowOpacity = 0.43;
     btn.layer.shadowOffset = CGSizeMake(0,0);
     btn.layer.shadowColor = kUIColorFromRGB(color_0xf82D45).CGColor;

     
     self.contentView.backgroundColor = [UIColor clearColor];
}
-(void)fitRegModeB
{
     self.height = 30;
     btn.width = 120;//__SCREEN_SIZE.width - 60;
     btn.height = 15;
     btn.x = 15;
     btn.y = 15;
     btn.backgroundColor = kUIColorFromRGB(color_2);
     [btn setTitleColor:kUIColorFromRGB(color_3) forState:UIControlStateNormal];
         self.backgroundColor = kUIColorFromRGB(color_2);
     btn.titleLabel.font = [UIFont systemFontOfSize:13];
     btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
     self.contentView.backgroundColor = [UIColor clearColor];
}

-(void)fitRegNextMode
{
    self.height = 100;
    btn.width = __SCREEN_SIZE.width - 60;
    btn.height = 40;
    btn.x = 30;
    btn.y = 60;
    btn.layer.cornerRadius = 3;
    btn.layer.masksToBounds = YES;
    [btn setTitleColor:kUIColorFromRGB(color_2) forState:UIControlStateNormal];
    self.backgroundColor = kUIColorFromRGB(color_2);
        btn.backgroundColor = kUIColorFromRGB(color_3);
}

-(void)fitModiPwdMode:(id)target withSel:(SEL)sel
{
    [self fitRegMode];
    UIButton *cbtn = [self.contentView viewWithTag:9322];
    if(!cbtn)
    {
        cbtn = [[UIButton alloc] initWithFrame:CGRectMake(0,8,80,18)];
        cbtn.x = __SCREEN_SIZE.width - 15 - 70;
        [cbtn setTitle:@"忘记密码" forState:UIControlStateNormal];
        cbtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [cbtn setTitleColor:kUIColorFromRGB(color_3) forState:UIControlStateNormal];
    }
    cbtn.hidden = YES;
    [cbtn addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:cbtn];
}

-(void)fitCodeMode
{
    self.height = 94;
    btn.height = 40;
    btn.y = 53;
    btn.width = __SCREEN_SIZE.width - 70;
    btn.x = 35;
    btn.backgroundColor = kUIColorFromRGB(color_8);
    [btn setTitleColor:kUIColorFromRGB(color_2) forState:UIControlStateNormal];
    btn.layer.cornerRadius = 6;
    btn.layer.masksToBounds = YES;
    self.backgroundColor = kUIColorFromRGB(color_9);
    self.contentView.backgroundColor = kUIColorFromRGB(color_9);
}

-(void)fitSendInfoMode
{
    self.height = 40;
    btn.width = 120;
    btn.height = 30;
    btn.x = __SCREEN_SIZE.width - 15 - btn.width;
    btn.y = 2;
    btn.layer.cornerRadius = 3;
    btn.layer.masksToBounds = YES;
    [btn setTitleColor:kUIColorFromRGB(color_2) forState:UIControlStateNormal];
    self.backgroundColor = kUIColorFromRGB(color_2);
    btn.backgroundColor = kUIColorFromRGB(color_3);
}


-(void)fitGoodsInfoMode
{
     self.height = 40;
     btn.width = __SCREEN_SIZE.width;
     btn.height = self.height;
     btn.x = 0;
     btn.y = 0;
//     btn.layer.cornerRadius = 3;
//     btn.layer.masksToBounds = YES;
     btn.titleLabel.font = [UIFont systemFontOfSize:15];
     [btn setTitleColor:kUIColorFromRGB(color_7) forState:UIControlStateNormal];
     self.backgroundColor = kUIColorFromRGB(color_2);
     btn.backgroundColor = kUIColorFromRGB(color_2);
}

-(void)fitPersonCerInfoMode
{
    self.height = 44;
    btn.width = __SCREEN_SIZE.width;
    btn.height = 44;
    btn.x = 0;//__SCREEN_SIZE.width - 15 - btn.width;
    btn.y = 0;
//    btn.layer.cornerRadius = 3;
//    btn.layer.masksToBounds = YES;
    [btn setTitleColor:kUIColorFromRGB(color_2) forState:UIControlStateNormal];
//    self.backgroundColor = kUIColorFromRGB(color_2);
    btn.backgroundColor = kUIColorFromRGB(color_3);
}

-(void)fitRepairsMode:(BUImageRes *)image{
    btn.width = __SCREEN_SIZE.width -30;
    btn.height = btn.width/330.0*200;
    btn.x = __SCREEN_SIZE.width - 15 - btn.width;
    btn.y = 2;
    [image download:self callback:@selector(getImgNotification:) extraInfo:nil];
}

-(void)getImgNotification:(BSNotification *) noti
{
    if(noti.error.code ==0)
    {
        BUImageRes *res =(BUImageRes *) noti.target;
        if (res.isCached) {
            UIImage *im =  [UIImage imageWithContentsOfFile:res.cacheFile];
            if (im) {
                [btn setImage:im forState:UIControlStateNormal];
            }
            
        }
    }
}
-(void)fitActInfoMode
{
    self.height = 44;
    btn.width = __SCREEN_SIZE.width;
    btn.height = 44;
    btn.x = 0;
    btn.y = 0;
//    btn.layer.cornerRadius = 3;
//    btn.layer.masksToBounds = YES;
    [btn setTitleColor:kUIColorFromRGB(color_2) forState:UIControlStateNormal];
    self.backgroundColor = kUIColorFromRGB(color_2);
    btn.backgroundColor = kUIColorFromRGB(color_3);
}

-(void)fitWaterInfoMode
{
    self.height = 50;
    btn.width = 100;
    btn.height = 35;
    btn.x = __SCREEN_SIZE.width - 15 - btn.width;
    btn.y = 8;
    btn.layer.cornerRadius = 3;
    btn.layer.borderColor = kUIColorFromRGB(color_3).CGColor;
    btn.layer.borderWidth = 0.5;
    btn.layer.masksToBounds = YES;
    [btn setTitleColor:kUIColorFromRGB(color_3) forState:UIControlStateNormal];
    self.backgroundColor = kUIColorFromRGB(color_2);
    btn.backgroundColor = kUIColorFromRGB(color_2);
    UILabel *lineLb = (UILabel *)[self viewWithTag:822];
    if(!lineLb)
    {
        lineLb = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, __SCREEN_SIZE.width, 0.5)];
        lineLb.backgroundColor = kUIColorFromRGB(color_lineColor);
        [self addSubview:lineLb];
    }
}

-(void)fitOrderMode
{
    self.height = 50;
    btn.width = 100;
    btn.height = 35;
    btn.x = __SCREEN_SIZE.width - 15 - btn.width;
    btn.y = 8;
    btn.layer.cornerRadius = 3;
    btn.layer.borderColor = kUIColorFromRGB(color_3).CGColor;
    btn.layer.borderWidth = 0.5;
    btn.layer.masksToBounds = YES;
    [btn setTitleColor:kUIColorFromRGB(color_2) forState:UIControlStateNormal];
    self.backgroundColor = kUIColorFromRGB(color_2);
    btn.backgroundColor = kUIColorFromRGB(color_0xf74056);
}

-(void)fitForgetPwdMode
{
     [self fitRegMode];
    self.height = 87;
     btn.y = 41;
//    btn.width = __SCREEN_SIZE.width - 60;
//    btn.height = 40;
//    btn.x = 30;
//    btn.y = 60;
//    btn.layer.cornerRadius = 3;
//    btn.layer.masksToBounds = YES;
//    [btn setTitleColor:kUIColorFromRGB(color_5) forState:UIControlStateNormal];
//    self.backgroundColor = kUIColorFromRGB(color_9);
//    btn.backgroundColor = kUIColorFromRGB(color_8);
//     [self setBtnTitleColor:kUIColorFromRGB(color_2)];
//    self.contentView.backgroundColor = [UIColor clearColor];
}

-(void)fitMyAccountMode
{
    self.height = 75;
    self.backgroundColor = kUIColorFromRGB(color_4);
    btn.backgroundColor = kUIColorFromRGB(color_mainTheme);
    [btn setTitleColor:kUIColorFromRGB(color_5) forState:UIControlStateNormal];
    btn.width = 80;
    btn.height = 30;
    btn.titleLabel.font = [UIFont systemFontOfSize:15];
    btn.x = __SCREEN_SIZE.width/2.0 - btn.width/2.0;
    btn.y = self.height/2.0 - btn.height/2.0;
    btn.layer.cornerRadius = 3;
    btn.layer.masksToBounds = YES;
}

-(void)fitMyAccountModeB
{
    self.height = 53;
    btn.y = 12;
    self.backgroundColor = kUIColorFromRGB(color_4);
    btn.backgroundColor = kUIColorFromRGB(color_mainTheme);
    [btn setTitleColor:kUIColorFromRGB(color_5) forState:UIControlStateNormal];
    btn.width = __SCREEN_SIZE.width - 60;
    btn.layer.cornerRadius = 3;
    btn.layer.masksToBounds = YES;
    btn.height = 40;
    btn.x = 30;
    
}
-(void)fitMyOrderInfoModeB
{
     [self fitMyOrderMode];
     self.height = TABHEIGHT + 1;
     if ([_dataDic[@"title"] isEqualToString:@"立即付款"]||([_dataDic[@"title"] isEqualToString:@"退还商品"]&&[_dataDic[@"titleX"] boolValue])||[_dataDic[@"title"] isEqualToString:@"确认收货"]||([_dataDic[@"title"] isEqualToString:@"续缴租金"]&&[_dataDic[@"titleX"] boolValue])) {
          btn.backgroundColor = kUIColorFromRGB(color_0xf74056);
          [btn setTitleColor:kUIColorFromRGB(color_2) forState:UIControlStateNormal];
          //        btn.layer.borderColor = kUIColorFromRGB(color_5).CGColor;
          btn.layer.borderWidth = 0;
     }
     else
     {
          btn.backgroundColor = kUIColorFromRGB(color_2);
          [btn setTitleColor:kUIColorFromRGB(color_0xb0b0b0) forState:UIControlStateNormal];
          btn.layer.cornerRadius = 6;
          btn.layer.masksToBounds = YES;
          btn.layer.borderColor = kUIColorFromRGB(color_lineColor).CGColor;
          btn.layer.borderWidth = 0.5;

     }
      UILabel *dLb = (UILabel *)[self viewWithTag:822];
     dLb.y = self.height/2.0 - dLb.height/2.0;
     btn.y = self.height/2.0 - btn.height/2.0;
         UIButton *cbtn = [self.contentView viewWithTag:726];
     cbtn.y = self.height/2.0 - cbtn.height/2.0;
         UIButton *dbtn = [self.contentView viewWithTag:8726];
        dbtn.y = self.height/2.0 - dbtn.height/2.0;
}
-(void)fitMyRunMode
{
     self.height = 71;
     btn.y = 16;
     btn.backgroundColor = kUIColorFromRGB(color_3);

     btn.layer.cornerRadius = 6;
     btn.layer.masksToBounds = YES;

     self.contentView.backgroundColor = kUIColorFromRGB(color_0xf5f5f5);
     [btn setTitleColor:kUIColorFromRGB(color_2) forState:UIControlStateNormal];

     btn.width = __SCREEN_SIZE.width - 30;
     btn.height = 40;
     btn.titleLabel.font = [UIFont systemFontOfSize:13];
     btn.x = 15;


}

-(void)fitSelledSeverModeB
{
     self.height = 45;
     btn.y = 12;
     btn.backgroundColor = kUIColorFromRGB(color_2);

     btn.layer.cornerRadius = 6;
     btn.layer.masksToBounds = YES;

     btn.layer.borderWidth = 0.5;

     if ([_dataDic[@"title"] isEqualToString:@"立即付款"]||[_dataDic[@"title"] isEqualToString:@"确认收货"]||[_dataDic[@"title"] isEqualToString:@"立即支付"]||([_dataDic[@"title"] isEqualToString:@"续缴租金"]&&[_dataDic[@"titleX"] boolValue])) {
          [btn setTitleColor:kUIColorFromRGB(color_2) forState:UIControlStateNormal];
          //          btn.layer.borderColor = kUIColorFromRGB(color_3).CGColor;
          btn.layer.borderWidth = 0;
          btn.backgroundColor = kUIColorFromRGB(color_0xf74056);
     }else{
          [btn setTitleColor:kUIColorFromRGB(color_0xb0b0b0) forState:UIControlStateNormal];
          btn.layer.borderColor = kUIColorFromRGB(color_0xb0b0b0).CGColor;
          btn.layer.borderWidth = 0.5;
          btn.backgroundColor = kUIColorFromRGB(color_2);
     }

     btn.width = 80;
     btn.height = 30;
     btn.titleLabel.font = [UIFont systemFontOfSize:13];
     btn.x = __SCREEN_SIZE.width - 15 - btn.width;
     btn.y = self.height/2.0 - btn.height/2.0;


     if (_dataDic[@"title"]&&![_dataDic[@"title"] isEqualToString:@""]) {
          btn.hidden = NO;
          btn.userInteractionEnabled = YES;
     }else{
          btn.hidden = YES;
          btn.userInteractionEnabled = NO;
     }

     UIButton *cbtn = [self.contentView viewWithTag:726];
     if (!cbtn) {
          cbtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 8, 80, 30)];
          cbtn.tag = 726;
          [cbtn addTarget:self action:@selector(extrHandle:) forControlEvents:UIControlEventTouchUpInside];
          cbtn.x = btn.x - 10 - cbtn.width;
          cbtn.y = btn.y;
          cbtn.layer.cornerRadius = 6;
          cbtn.layer.masksToBounds = YES;
          cbtn.layer.borderColor = kUIColorFromRGB(color_0xb0b0b0).CGColor;
          cbtn.layer.borderWidth = 0.5;
          cbtn.titleLabel.font = [UIFont systemFontOfSize:13];
     }

     [cbtn setTitle:_dataDic[@"bTitle"] forState:UIControlStateNormal];
     [cbtn setTitleColor:kUIColorFromRGB(color_0xb0b0b0) forState:UIControlStateNormal];
     if (_dataDic[@"bTitle"]&&![_dataDic[@"bTitle"] isEqualToString:@""]) {
          cbtn.hidden = NO;
     }else
     {
          cbtn.hidden = YES;
     }
     if([_dataDic[@"bTitle"] isEqualToString:@"续缴租金"]&&[_dataDic[@"bTitleX"] boolValue])
     {
          [cbtn setTitleColor:kUIColorFromRGB(color_2) forState:UIControlStateNormal];
          //          btn.layer.borderColor = kUIColorFromRGB(color_3).CGColor;
          cbtn.layer.borderWidth = 0;
          cbtn.backgroundColor = kUIColorFromRGB(color_0xf74056);
     }else{
          [cbtn setTitleColor:kUIColorFromRGB(color_0xb0b0b0) forState:UIControlStateNormal];
          cbtn.layer.borderColor = kUIColorFromRGB(color_0xb0b0b0).CGColor;
          cbtn.layer.borderWidth = 0.5;
          cbtn.backgroundColor = kUIColorFromRGB(color_2);
     }
     [self.contentView addSubview:cbtn];
     if (_dataDic[@"cTitle"]&&![_dataDic[@"cTitle"] isEqualToString:@""]) {
          UIButton *dbtn = [self.contentView viewWithTag:8726];
          if (!dbtn) {
               dbtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 8, 80, 30)];
               dbtn.tag = 8726;
               [dbtn addTarget:self action:@selector(extrHandle2:) forControlEvents:UIControlEventTouchUpInside];
          }
          dbtn.x = cbtn.x - 10 - dbtn.width ;
          dbtn.y = cbtn.y;
          dbtn.layer.cornerRadius = 6;
          dbtn.layer.masksToBounds = YES;
          dbtn.layer.borderColor = kUIColorFromRGB(color_0xb0b0b0).CGColor;
          dbtn.layer.borderWidth = 0.5;
          dbtn.titleLabel.font = [UIFont systemFontOfSize:13];
          [dbtn setTitle:_dataDic[@"cTitle"] forState:UIControlStateNormal];
          [dbtn setTitleColor:kUIColorFromRGB(color_0xb0b0b0) forState:UIControlStateNormal];
          dbtn.hidden = NO;
          [self.contentView addSubview:dbtn];
     }
     else
     {
          UIButton *dbtn = [self.contentView viewWithTag:8726];
          dbtn.hidden = YES;
     }
     UILabel *dLb = (UILabel *)[self viewWithTag:822];
     if(!dLb)
     {
          dLb = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, __SCREEN_SIZE.width/2.0 + 10, 13)];
          dLb.textColor = kUIColorFromRGB(color_0xb0b0b0);
          dLb.font = [UIFont systemFontOfSize:15];
          dLb.tag = 822;
          dLb.x = 15;
          dLb.y = 16;
          [self addSubview:dLb];
     }
     if (__SCREEN_SIZE.width == 320) {
          dLb.font = [UIFont systemFontOfSize:14];
     }
     dLb.text = _dataDic[@"detail"];
}

-(void)fitMyOrderMode
{
    self.height = 40;
    btn.y = 12;
     btn.backgroundColor = kUIColorFromRGB(color_2);
    
     btn.layer.cornerRadius = 6;
     btn.layer.masksToBounds = YES;
     
     btn.layer.borderWidth = 0.5;
     
     if ([_dataDic[@"title"] isEqualToString:@"立即付款"]||[_dataDic[@"title"] isEqualToString:@"确认收货"]||[_dataDic[@"title"] isEqualToString:@"评价"]||([_dataDic[@"title"] isEqualToString:@"续缴租金"]&&[_dataDic[@"titleX"] boolValue])) {
          [btn setTitleColor:kUIColorFromRGB(color_2) forState:UIControlStateNormal];
//          btn.layer.borderColor = kUIColorFromRGB(color_3).CGColor;
          btn.layer.borderWidth = 0;
          btn.backgroundColor = kUIColorFromRGB(color_0xf74056);
     }else{
          [btn setTitleColor:kUIColorFromRGB(color_0xb0b0b0) forState:UIControlStateNormal];
          btn.layer.borderColor = kUIColorFromRGB(color_0xb0b0b0).CGColor;
            btn.layer.borderWidth = 0.5;
          btn.backgroundColor = kUIColorFromRGB(color_2);
     }

    btn.width = 80;
    btn.height = 30;
    btn.titleLabel.font = [UIFont systemFontOfSize:13];
    btn.x = __SCREEN_SIZE.width - 15 - btn.width;
    btn.y = self.height/2.0 - btn.height/2.0;
     
     
     if (_dataDic[@"title"]&&![_dataDic[@"title"] isEqualToString:@""]) {
          btn.hidden = NO;
          btn.userInteractionEnabled = YES;
     }else{
          btn.hidden = YES;
          btn.userInteractionEnabled = NO;
     }
    
    UIButton *cbtn = [self.contentView viewWithTag:726];
    if (!cbtn) {
        cbtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 8, 80, 30)];
        cbtn.tag = 726;
        [cbtn addTarget:self action:@selector(extrHandle:) forControlEvents:UIControlEventTouchUpInside];
         cbtn.x = btn.x - 10 - cbtn.width;
         cbtn.y = btn.y;
         cbtn.layer.cornerRadius = 6;
         cbtn.layer.masksToBounds = YES;
         cbtn.layer.borderColor = kUIColorFromRGB(color_0xb0b0b0).CGColor;
         cbtn.layer.borderWidth = 0.5;
         cbtn.titleLabel.font = [UIFont systemFontOfSize:13];
    }

    [cbtn setTitle:_dataDic[@"bTitle"] forState:UIControlStateNormal];
    [cbtn setTitleColor:kUIColorFromRGB(color_0xb0b0b0) forState:UIControlStateNormal];
        if (_dataDic[@"bTitle"]&&![_dataDic[@"bTitle"] isEqualToString:@""]) {
    cbtn.hidden = NO;
        }else
        {
            cbtn.hidden = YES;
        }
     if([_dataDic[@"bTitle"] isEqualToString:@"续缴租金"]&&[_dataDic[@"bTitleX"] boolValue])
     {
          [cbtn setTitleColor:kUIColorFromRGB(color_2) forState:UIControlStateNormal];
          //          btn.layer.borderColor = kUIColorFromRGB(color_3).CGColor;
          cbtn.layer.borderWidth = 0;
          cbtn.backgroundColor = kUIColorFromRGB(color_0xf74056);
     }else{
          [cbtn setTitleColor:kUIColorFromRGB(color_0xb0b0b0) forState:UIControlStateNormal];
          cbtn.layer.borderColor = kUIColorFromRGB(color_0xb0b0b0).CGColor;
          cbtn.layer.borderWidth = 0.5;
          cbtn.backgroundColor = kUIColorFromRGB(color_2);
     }
    [self.contentView addSubview:cbtn];
    if (_dataDic[@"cTitle"]&&![_dataDic[@"cTitle"] isEqualToString:@""]) {
        UIButton *dbtn = [self.contentView viewWithTag:8726];
        if (!dbtn) {
            dbtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 8, 80, 30)];
            dbtn.tag = 8726;
            [dbtn addTarget:self action:@selector(extrHandle2:) forControlEvents:UIControlEventTouchUpInside];
        }
        dbtn.x = cbtn.x - 10 - dbtn.width ;
        dbtn.y = cbtn.y;
        dbtn.layer.cornerRadius = 6;
        dbtn.layer.masksToBounds = YES;
        dbtn.layer.borderColor = kUIColorFromRGB(color_0xb0b0b0).CGColor;
        dbtn.layer.borderWidth = 0.5;
        dbtn.titleLabel.font = [UIFont systemFontOfSize:13];
        [dbtn setTitle:_dataDic[@"cTitle"] forState:UIControlStateNormal];
        [dbtn setTitleColor:kUIColorFromRGB(color_0xb0b0b0) forState:UIControlStateNormal];
        dbtn.hidden = NO;
        [self.contentView addSubview:dbtn];
    }
    else
    {
         UIButton *dbtn = [self.contentView viewWithTag:8726];
      dbtn.hidden = YES;
    }
     UILabel *dLb = (UILabel *)[self viewWithTag:822];
     if(!dLb)
     {
          dLb = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, __SCREEN_SIZE.width/2.0 - 20, 13)];
          dLb.textColor = kUIColorFromRGB(color_0xb0b0b0);
          dLb.font = [UIFont systemFontOfSize:15];
          dLb.tag = 822;
          dLb.x = 15;
          dLb.y = 16;
          [self addSubview:dLb];
     }
     if (__SCREEN_SIZE.width == 320) {
           dLb.font = [UIFont systemFontOfSize:12];
     }
     dLb.text = _dataDic[@"detail"];
}

-(void)fitBuyoutMode
{
     self.height = 40;
     btn.y = 12;
     btn.backgroundColor = kUIColorFromRGB(color_2);

     btn.layer.cornerRadius = 6;
     btn.layer.masksToBounds = YES;

     btn.layer.borderWidth = 0.5;

     if ([_dataDic[@"title"] isEqualToString:@"立即付款"]||[_dataDic[@"title"] isEqualToString:@"确认收货"]||[_dataDic[@"title"] isEqualToString:@"评价"]||([_dataDic[@"title"] isEqualToString:@"续缴租金"]&&[_dataDic[@"titleX"] boolValue])) {
          [btn setTitleColor:kUIColorFromRGB(color_2) forState:UIControlStateNormal];
          //          btn.layer.borderColor = kUIColorFromRGB(color_3).CGColor;
          btn.layer.borderWidth = 0;
          btn.backgroundColor = kUIColorFromRGB(color_0xf74056);
     }else{
          [btn setTitleColor:kUIColorFromRGB(color_0xb0b0b0) forState:UIControlStateNormal];
          btn.layer.borderColor = kUIColorFromRGB(color_0xb0b0b0).CGColor;
          btn.layer.borderWidth = 0.5;
          btn.backgroundColor = kUIColorFromRGB(color_2);
     }

     btn.width = 80;
     btn.height = 30;
     btn.titleLabel.font = [UIFont systemFontOfSize:13];
     btn.x = __SCREEN_SIZE.width - 15 - btn.width;
     btn.y = self.height/2.0 - btn.height/2.0;


}

-(void)fitMyOrderInfoMode
{
    self.height = 45;
    btn.y = 7;
    self.backgroundColor = kUIColorFromRGB(color_2);
         if ([_dataDic[@"title"] isEqualToString:@"立即付款"]||[_dataDic[@"title"] isEqualToString:@"退还商品"]||[_dataDic[@"title"] isEqualToString:@"确认收货"]||[_dataDic[@"title"] isEqualToString:@"服务完成"]) {
        btn.backgroundColor = kUIColorFromRGB(color_0xf74056);
        [btn setTitleColor:kUIColorFromRGB(color_2) forState:UIControlStateNormal];
        //        btn.layer.borderColor = kUIColorFromRGB(color_5).CGColor;
        btn.layer.borderWidth = 0;
    }
    else
    {
        btn.backgroundColor = kUIColorFromRGB(color_2);
        [btn setTitleColor:kUIColorFromRGB(color_0xb0b0b0) forState:UIControlStateNormal];
        btn.layer.cornerRadius = 6;
        btn.layer.masksToBounds = YES;
        btn.layer.borderColor = kUIColorFromRGB(color_lineColor).CGColor;
        btn.layer.borderWidth = 0.5;
    }
    btn.width = 80;
//     if (__SCREEN_SIZE.width == 320) {
//          btn.width = 70;
//     }
    btn.layer.cornerRadius = 6;
    btn.layer.masksToBounds = YES;
    btn.height = 30;
    btn.titleLabel.font = [UIFont systemFontOfSize:15];
     
    btn.x = __SCREEN_SIZE.width - 15 - btn.width;
        if (__SCREEN_SIZE.width == 320) {
               btn.x = __SCREEN_SIZE.width - 12.5 - btn.width;
        }
    btn.y = self.height/2.0 - btn.height/2.0;
    
    UIButton *cbtn = [self.contentView viewWithTag:726];
    if (!cbtn) {
        cbtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 8, btn.width, btn.height)];
        cbtn.tag = 726;
        [cbtn addTarget:self action:@selector(extrHandle:) forControlEvents:UIControlEventTouchUpInside];
    }
     if (__SCREEN_SIZE.width == 320) {
           cbtn.x = btn.x - 5 - cbtn.width;
     }
     else
    cbtn.x = btn.x - 10 - cbtn.width;
    cbtn.y = btn.y;
    cbtn.layer.cornerRadius = 6;
    cbtn.layer.masksToBounds = YES;
    cbtn.layer.borderColor = kUIColorFromRGB(color_lineColor).CGColor;
    cbtn.layer.borderWidth = 0.5;
    cbtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [cbtn setTitle:_dataDic[@"bTitle"] forState:UIControlStateNormal];
    [cbtn setTitleColor:kUIColorFromRGB(color_0xb0b0b0) forState:UIControlStateNormal];
    if (_dataDic[@"bTitle"]&&![_dataDic[@"bTitle"] isEqualToString:@""]) {
        cbtn.hidden = NO;
    }else
    {
        cbtn.hidden = YES;
    }
    [self.contentView addSubview:cbtn];
       UIButton *dbtn = [self.contentView viewWithTag:8726];
     
    if (_dataDic[@"cTitle"]&&![_dataDic[@"cTitle"] isEqualToString:@""]) {
      
        if (!dbtn) {
            dbtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 8, btn.width, btn.height)];
            dbtn.tag = 8726;
            [dbtn addTarget:self action:@selector(extrHandle2:) forControlEvents:UIControlEventTouchUpInside];
        }
         if (__SCREEN_SIZE.width == 320) {
              dbtn.x = cbtn.x - 5 - dbtn.width;
         }
         else
        dbtn.x = cbtn.x - 10 - dbtn.width ;
        dbtn.y = cbtn.y;
        dbtn.layer.cornerRadius = 6;
        dbtn.layer.masksToBounds = YES;
        dbtn.layer.borderColor = kUIColorFromRGB(color_lineColor).CGColor;
        dbtn.layer.borderWidth = 0.5;
        dbtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [dbtn setTitle:_dataDic[@"cTitle"] forState:UIControlStateNormal];
        [dbtn setTitleColor:kUIColorFromRGB(color_0xb0b0b0) forState:UIControlStateNormal];
        dbtn.hidden = NO;
      
    }
       [self.contentView addSubview:dbtn];
     
       UIButton *ebtn = [self.contentView viewWithTag:8729];
     if (_dataDic[@"dTitle"]&&![_dataDic[@"dTitle"] isEqualToString:@""]) {
        
          if (!ebtn) {
               ebtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 8, btn.width, btn.height)];
               ebtn.tag = 8729;
               [ebtn addTarget:self action:@selector(extrHandle3:) forControlEvents:UIControlEventTouchUpInside];
          }
          if (__SCREEN_SIZE.width == 320) {
               ebtn.x = dbtn.x - 5 - dbtn.width;
          }
          else
          ebtn.x = dbtn.x - 10 - dbtn.width ;
          ebtn.y = dbtn.y;
          ebtn.layer.cornerRadius = 3;
          ebtn.layer.masksToBounds = YES;
          ebtn.layer.borderColor = kUIColorFromRGB(color_lineColor).CGColor;
          ebtn.layer.borderWidth = 0.5;
          ebtn.titleLabel.font = [UIFont systemFontOfSize:15];
          [ebtn setTitle:_dataDic[@"dTitle"] forState:UIControlStateNormal];
          [ebtn setTitleColor:kUIColorFromRGB(color_0xb0b0b0) forState:UIControlStateNormal];
          ebtn.hidden = NO;
          
     }
    [self.contentView addSubview:ebtn];
}



-(void)fitMyInviteMode
{
    self.height = 70;
    btn.y = 15;
    self.backgroundColor = kUIColorFromRGB(color_9);
    self.contentView.backgroundColor = kUIColorFromRGB(color_9);
    btn.backgroundColor = kUIColorFromRGB(color_mainTheme);
    [btn setTitleColor:kUIColorFromRGB(color_5) forState:UIControlStateNormal];
    btn.width = __SCREEN_SIZE.width - 60;
    btn.layer.cornerRadius = 3;
    btn.layer.masksToBounds = YES;
    btn.height = 40;
    btn.x = 30;
}

-(void)fitSignMode
{
    self.height = 125;
    btn.y = 44;
    self.backgroundColor = kUIColorFromRGB(color_4);
    btn.backgroundColor = kUIColorFromRGB(color_mainTheme);
    [btn setTitleColor:kUIColorFromRGB(color_5) forState:UIControlStateNormal];
    btn.width = __SCREEN_SIZE.width - 60;
    btn.layer.cornerRadius = 3;
    btn.layer.masksToBounds = YES;
    btn.height = 40;
    btn.x = 30;
}

-(void)fitWithdrawMode
{
    self.height = 94;
    btn.y = 53;
   self.contentView.backgroundColor = kUIColorFromRGB(color_9);
    btn.backgroundColor = kUIColorFromRGB(color_mainTheme);
    [btn setTitleColor:kUIColorFromRGB(color_5) forState:UIControlStateNormal];
    btn.width = __SCREEN_SIZE.width - 60;
    btn.layer.cornerRadius = 3;
    btn.layer.masksToBounds = YES;
    btn.height = 40;
    btn.x = 30;
    
}

-(void)fitMyAccountModeC
{
    self.height = 47;
    self.backgroundColor = kUIColorFromRGB( color_4);
    [btn sizeToFit];
    btn.x = __SCREEN_SIZE.width/2.0 - btn.width/2.0;
    [btn setTitleColor:kUIColorFromRGB(color_8) forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:16];
    btn.y = 11;
    btn.backgroundColor = [UIColor clearColor];
}

-(void)fitUserCardRechargeMode
{
    self.height = 50;
    self.contentView.backgroundColor = kUIColorFromRGB( color_9);
    btn.width = 80;
    btn.height = 30;
    btn.x = __SCREEN_SIZE.width/2.0 - btn.width/2.0;
    [btn setTitleColor:kUIColorFromRGB(color_5) forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:15];
    btn.y = 10;
    btn.backgroundColor = kUIColorFromRGB(color_mainTheme);
    btn.layer.cornerRadius = 3;
    btn.layer.masksToBounds = YES;
}

-(void)fitSecondCallMode
{
     self.height = TABHEIGHT + 9;
     self.contentView.backgroundColor = kUIColorFromRGB( color_2);
     btn.width = 165;
     if(__SCREEN_SIZE.width == 320)
          btn.width = 130;
     btn.height = 36;
     btn.x = __SCREEN_SIZE.width - 15 - btn.width;
     [btn setTitleColor:kUIColorFromRGB(color_2) forState:UIControlStateNormal];
     btn.titleLabel.font = [UIFont systemFontOfSize:15];
     btn.y = 9;
     btn.backgroundColor = kUIColorFromRGB(color_0xf74056);
     btn.layer.cornerRadius = btn.height/2.0;
     btn.layer.masksToBounds = YES;

     UILabel *lb = [self.contentView viewWithTag:12113];
     if (!lb) {
          lb = [UILabel new];
          lb.width = 140;
          lb.height = 15;
          lb.tag = 12113;
     }
     lb.textAlignment = NSTextAlignmentLeft;
     lb.text = _dataDic[@"detail"];
     lb.textColor = kUIColorFromRGB(color_0xf74056);
     lb.font =  [UIFont systemFontOfSize:13];
     [lb richMText:@"需付款:" color:kUIColorFromRGB(color_5) withFont:[UIFont systemFontOfSize:13]];
     lb.x = 15;
     lb.y = 10;
     [self.contentView addSubview:lb];

     UILabel *lb2 = [self.contentView viewWithTag:12155];
     if (!lb2) {
          lb2 = [UILabel new];
          lb2.width = 160;
          lb2.height = 13;
          lb2.tag = 12155;
     }
     lb2.textAlignment = NSTextAlignmentLeft;
     lb2.text = _dataDic[@"detail2"];
     lb2.textColor = kUIColorFromRGB(color_0xb0b0b0);
     lb2.font =  [UIFont systemFontOfSize:12];
//     [lb2 richMText:@"还需支付：" color:kUIColorFromRGB(color_8) withFont:[UIFont systemFontOfSize:13]];
     lb2.x = 15;
     lb2.y = lb.y + lb.height + 8;
     [self.contentView addSubview:lb2];
}

-(void)fitPublishEvaMode
{
     self.height = 85;
     btn.y = 44;
     
     btn.backgroundColor = kUIColorFromRGB(color_mainTheme);
     [btn setTitleColor:kUIColorFromRGB(color_2) forState:UIControlStateNormal];
     btn.width = __SCREEN_SIZE.width - 30;
     btn.backgroundColor = kUIColorFromRGB(color_0xf82D45);
     btn.layer.shadowRadius = 8.0;
     btn.layer.shadowOpacity = 0.43;
     btn.layer.shadowOffset = CGSizeMake(0,0);
     btn.layer.shadowColor = kUIColorFromRGB(color_0xf82D45).CGColor;
     btn.height = 40;
     btn.x = 15;
     btn.layer.cornerRadius = btn.height/2.0;
     self.backgroundColor = kUIColorFromRGB( color_0xf0f0f0);

}

-(void)fitPublishAnswerMode
{
     self.height = 90;
     btn.y = 50;
     
     btn.backgroundColor = kUIColorFromRGB(color_mainTheme);
     [btn setTitleColor:kUIColorFromRGB(color_2) forState:UIControlStateNormal];
     btn.width = __SCREEN_SIZE.width - 30;
     btn.layer.cornerRadius = 8;
     btn.layer.masksToBounds = YES;
     btn.height = 40;
     btn.x = 15;
     self.backgroundColor = kUIColorFromRGB( color_2);
}
-(void)fitApplySalesReturnMode
{
     self.height = 82;
     btn.y = 41;

     btn.backgroundColor = kUIColorFromRGB(color_mainTheme);
     [btn setTitleColor:kUIColorFromRGB(color_2) forState:UIControlStateNormal];
     btn.width = __SCREEN_SIZE.width - 30;
     btn.layer.cornerRadius = 8;
     btn.layer.masksToBounds = YES;
     btn.height = 41;
     btn.x = 15;
     self.backgroundColor = kUIColorFromRGB( color_0xf0f0f0);
}
-(void)fitFeedbackMode
{
     self.height = 91;
     btn.y = 50;

     btn.backgroundColor = kUIColorFromRGB(color_mainTheme);
     [btn setTitleColor:kUIColorFromRGB(color_2) forState:UIControlStateNormal];
     btn.width = __SCREEN_SIZE.width - 30;
     btn.backgroundColor = kUIColorFromRGB(color_0xf82D45);
     btn.layer.shadowRadius = 8.0;
     btn.layer.shadowOpacity = 0.43;
     btn.layer.shadowOffset = CGSizeMake(0,0);
     btn.layer.shadowColor = kUIColorFromRGB(color_0xf82D45).CGColor;
     btn.height = 40;
     btn.x = 15;
      btn.layer.cornerRadius = btn.height/2.0;
 self.backgroundColor = kUIColorFromRGB( color_0xf0f0f0);
}

-(void)fitModiPhoneMode
{
     self.height = 66;
     btn.y = 25;
     
     btn.backgroundColor = kUIColorFromRGB(color_mainTheme);
     [btn setTitleColor:kUIColorFromRGB(color_2) forState:UIControlStateNormal];
     btn.width = __SCREEN_SIZE.width - 60;
     btn.layer.cornerRadius = 8;
     btn.layer.masksToBounds = YES;
     btn.height = 40;
     btn.x = 30;
     self.backgroundColor = kUIColorFromRGB( color_0xf0f0f0);
}

-(void)fitMyHisMode
{
     self.height = 45;
     btn.y = 7;
     
     btn.backgroundColor = kUIColorFromRGB(color_2);
     [btn setTitleColor:kUIColorFromRGB(color_mainTheme) forState:UIControlStateNormal];
     btn.width = 80;
     btn.layer.cornerRadius = 4;
     btn.layer.borderWidth = 0.5;
     btn.layer.borderColor = kUIColorFromRGB(color_mainTheme).CGColor;
     btn.layer.masksToBounds = YES;
     btn.height = 31;
     btn.x = __SCREEN_SIZE.width - 15 - btn.width;
     self.backgroundColor = kUIColorFromRGB( color_2);
     
     UIButton *dbtn = [self.contentView viewWithTag:8726];
     if (!dbtn) {
          dbtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 8, 80, 45)];
          dbtn.tag = 8726;
          [dbtn addTarget:self action:@selector(extrHandle2:) forControlEvents:UIControlEventTouchUpInside];
     }
     dbtn.x = 0;
     dbtn.y = 0;
     dbtn.customImgV.image = [UIImage imageContentWithFileName:@"unCheck2"];
     dbtn.customImgV.highlightedImage = [UIImage imageContentWithFileName:@"check"];
     dbtn.customImgV.x = 15;
     dbtn.customImgV.y = 15;
     dbtn.customImgV.width = 16;
     dbtn.customImgV.height = 16;
     
     dbtn.customTitleLb.y = 17;
     dbtn.customTitleLb.x = dbtn.customImgV.x + dbtn.customImgV.width + 17;
     dbtn.customTitleLb.width  = 34;
     dbtn.customTitleLb.height = 13;
     dbtn.customTitleLb.text = @"全选";
     dbtn.customTitleLb.textColor = kUIColorFromRGB(color_0xb0b0b0);
     dbtn.customTitleLb.font = [UIFont systemFontOfSize:13];
     dbtn.hidden = NO;
     [self.contentView addSubview:dbtn];

}
-(void)fitSendBackGoodsMode
{
     self.height = 60;
     btn.y = 11;

     btn.backgroundColor = kUIColorFromRGB(color_3);
     [btn setTitleColor:kUIColorFromRGB(color_2) forState:UIControlStateNormal];
     btn.width = __SCREEN_SIZE.width - 15 * 2;

     //     //     btn.layer.borderWidth = 0.5;
     //     //     btn.layer.borderColor = kUIColorFromRGB(color_mainTheme).CGColor;
     //          btn.layer.masksToBounds = YES;
     btn.height = 36;
     btn.titleLabel.font = [UIFont systemFontOfSize:15];
     btn.x = 15;
     self.backgroundColor = kUIColorFromRGB(color_2);
     btn.backgroundColor = kUIColorFromRGB(color_0xf82D45);
     btn.layer.shadowRadius = 8.0;
     btn.layer.shadowOpacity = 0.43;
     btn.layer.shadowOffset = CGSizeMake(0,0);
     btn.layer.shadowColor = kUIColorFromRGB(color_0xf82D45).CGColor;
     btn.layer.cornerRadius = btn.height/2.0;
     self.contentView.backgroundColor = [UIColor clearColor];
}
-(void)fitSelledSeverMode
{
     self.height = 45;
     btn.y = 7;
     
     btn.backgroundColor = kUIColorFromRGB(color_2);
     [btn setTitleColor:kUIColorFromRGB(color_mainTheme) forState:UIControlStateNormal];
     btn.width = 80;
     btn.layer.cornerRadius = 6;
     btn.layer.borderWidth = 0.5;
     btn.layer.borderColor = kUIColorFromRGB(color_mainTheme).CGColor;
     btn.layer.masksToBounds = YES;
     btn.height = 31;
     btn.titleLabel.font = [UIFont systemFontOfSize:13];
     btn.x = __SCREEN_SIZE.width - 15 - btn.width;
     self.backgroundColor = kUIColorFromRGB( color_2);
     
     UIImageView *img = [self.contentView viewWithTag:1632];
     if (!img) {
          img = [[UIImageView alloc]initWithFrame:CGRectMake(15, self.height/2.0 - 9, 18, 18)];
          img.tag = 1632;
          img.image = [UIImage imageNamed:@"icon_warn"];
          [self.contentView addSubview:img];
     }
     
     UILabel *label = [self.contentView viewWithTag:1633];
     if (!label) {
          label = [[UILabel alloc]initWithFrame:CGRectMake(48, 0, 120, self.height)];
          label.tag = 1633;
          label.text = @"该商品已超过售后期";
          label.font = [UIFont systemFontOfSize:13];
          label.textColor = kUIColorFromRGB(color_0xb0b0b0);
          [self.contentView addSubview:label];
     }
     
     if (![_dataDic[@"outOfDate"] boolValue]) {
          img.hidden = YES;
          label.hidden = YES;
          btn.layer.borderColor = nil;
          btn.layer.borderWidth = 0;
          btn.backgroundColor = kUIColorFromRGB(color_0xf74056);
          [btn setTitleColor:kUIColorFromRGB(color_2) forState:UIControlStateNormal];
          btn.userInteractionEnabled = YES;
     }else{
          img.hidden = NO;
          label.hidden = NO;
          btn.layer.borderColor = kUIColorFromRGB(color_0xb0b0b0).CGColor;
          [btn setTitleColor:kUIColorFromRGB(color_0xb0b0b0) forState:UIControlStateNormal];
           btn.userInteractionEnabled = NO;
     }

     UILabel *lb = [self.contentView viewWithTag:12113];
     if (!lb) {
          lb = [UILabel new];
          lb.width = 200;
          lb.height = 15;
          lb.tag = 12113;
     }
     lb.textAlignment = NSTextAlignmentLeft;
     lb.text = _dataDic[@"detail"];
     lb.textColor = kUIColorFromRGB(color_7);
     lb.font =  [UIFont systemFontOfSize:15];
//     [lb richMText:@"应付金额：" color:kUIColorFromRGB(color_8) withFont:[UIFont systemFontOfSize:13]];
     lb.x = 15;
     lb.y = self.height/2.0 - lb.height/2.0;
     [self.contentView addSubview:lb];
}

-(void)fitInvGetGiftMode
{
     self.height = 76;
     btn.y = 17;
     
     btn.backgroundColor = kUIColorFromRGB(color_3);
     [btn setTitleColor:kUIColorFromRGB(color_2) forState:UIControlStateNormal];
     btn.width = __SCREEN_SIZE.width - 65 * 2;
     btn.layer.cornerRadius = 5;
//     btn.layer.borderWidth = 0.5;
//     btn.layer.borderColor = kUIColorFromRGB(color_mainTheme).CGColor;
     btn.layer.masksToBounds = YES;
     btn.height = 40;
     btn.titleLabel.font = [UIFont systemFontOfSize:15];
     btn.x = 65;
     self.backgroundColor = kUIColorFromRGB( color_2);
}

-(void)fitCouponInfoMode
{
     self.height = 248;
     btn.y = 207;
     
     btn.backgroundColor = kUIColorFromRGB(color_3);
     [btn setTitleColor:kUIColorFromRGB(color_2) forState:UIControlStateNormal];
     btn.width = __SCREEN_SIZE.width - 65 * 2;
     btn.layer.cornerRadius = 5;
     //     btn.layer.borderWidth = 0.5;
     //     btn.layer.borderColor = kUIColorFromRGB(color_mainTheme).CGColor;
     btn.layer.masksToBounds = YES;
     btn.height = 41;
     btn.titleLabel.font = [UIFont systemFontOfSize:15];
     btn.x = 65;
     self.backgroundColor = [UIColor clearColor];
}

-(void)fitSearchMode
{
     self.height = 45;
     btn.y = 0;
     
     btn.backgroundColor = kUIColorFromRGB(color_2);
     [btn setTitleColor:kUIColorFromRGB(color_0xb0b0b0) forState:UIControlStateNormal];
     btn.width = __SCREEN_SIZE.width - 65 * 2;
//     btn.layer.cornerRadius = 5;
//     //     btn.layer.borderWidth = 0.5;
//     //     btn.layer.borderColor = kUIColorFromRGB(color_mainTheme).CGColor;
//     btn.layer.masksToBounds = YES;
     btn.height = 45;
     btn.titleLabel.font = [UIFont systemFontOfSize:15];
     btn.x = 65;
     self.backgroundColor = kUIColorFromRGB(color_2);
}

-(void)fitAddressManagerModeA:(BOOL)isCheck
{
     self.height = 31;
     btn.y = 15;
     btn.width = 180;//__SCREEN_SIZE.width - 15 * 2;
     btn.height = 16;
     btn.x = 15;
     [btn fitImgAndTitleMode];
     btn.customImgV.width = 15;
     btn.customImgV.height = 16;
     btn.customImgV.x = 0;
     btn.customImgV.y = 0;
     btn.customImgV.highlightedImage = [UIImage imageContentWithFileName:@"check"];
     btn.customImgV.image = [UIImage imageContentWithFileName:@"unCheck2"];
     btn.customImgV.highlighted = isCheck;
     btn.customTitleLb.width = 150;
     btn.customTitleLb.height = 16;
     btn.customTitleLb.x = btn.customImgV.width + 14;
     btn.customTitleLb.y = 0;
     btn.customTitleLb.text = _dataDic[@"title"];
//     [btn setTitle:@"" forState:UIControlStateNormal];
     btn.customTitleLb.font = [UIFont systemFontOfSize:14];
     btn.customTitleLb.textColor = kUIColorFromRGB(color_0xb0b0b0);
     btn.backgroundColor = [UIColor clearColor];
     self.backgroundColor = kUIColorFromRGB(color_0xf0f0f0);
}

-(void)fitAddressManagerModeB
{
     self.height = 105;
     btn.y = 64;
     
     btn.backgroundColor = kUIColorFromRGB(color_3);
     [btn setTitleColor:kUIColorFromRGB(color_2) forState:UIControlStateNormal];
     btn.width = __SCREEN_SIZE.width - 15 * 2;

     //     //     btn.layer.borderWidth = 0.5;
     //     //     btn.layer.borderColor = kUIColorFromRGB(color_mainTheme).CGColor;
//          btn.layer.masksToBounds = YES;
     btn.height = 41;
     btn.titleLabel.font = [UIFont systemFontOfSize:15];
     btn.x = 15;
     self.backgroundColor = kUIColorFromRGB(color_0xf0f0f0);
     btn.backgroundColor = kUIColorFromRGB(color_0xf82D45);
     btn.layer.shadowRadius = 8.0;
     btn.layer.shadowOpacity = 0.43;
     btn.layer.shadowOffset = CGSizeMake(0,0);
     btn.layer.shadowColor = kUIColorFromRGB(color_0xf82D45).CGColor;
        btn.layer.cornerRadius = btn.height/2.0;
     self.contentView.backgroundColor = [UIColor clearColor];
}

-(void)fitTopicMode
{
     self.height = 44;
     btn.y = 0;
     
     btn.backgroundColor = kUIColorFromRGB(color_3);
     [btn setTitleColor:kUIColorFromRGB(color_2) forState:UIControlStateNormal];
     btn.width = __SCREEN_SIZE.width;
     btn.layer.cornerRadius = 0;
     //     //     btn.layer.borderWidth = 0.5;
     //     //     btn.layer.borderColor = kUIColorFromRGB(color_mainTheme).CGColor;
     btn.layer.masksToBounds = YES;
     btn.height = 44;
     btn.titleLabel.font = [UIFont systemFontOfSize:15];
     btn.x = 0;
//     self.backgroundColor = kUIColorFromRGB(color_0xf0f0f0);
}

-(void)fitCancelOrderInfoA:(BOOL)isCheck
{
     self.height = 28;
     btn.y = 10;
     btn.width = 180;//__SCREEN_SIZE.width - 15 * 2;
     btn.height = 16;
     btn.x = 15;
     [btn fitImgAndTitleMode];
     btn.customImgV.width = 15;
     btn.customImgV.height = 15;
     btn.customImgV.x = 0;
     btn.customImgV.y = 0;
     btn.customImgV.highlightedImage = [UIImage imageContentWithFileName:@"check"];
     btn.customImgV.image = [UIImage imageContentWithFileName:@"unCheck2"];
     btn.customImgV.highlighted = isCheck;
     btn.customTitleLb.width = 150;
     btn.customTitleLb.height = 16;
     btn.customTitleLb.x = btn.customImgV.width + 15;
     btn.customTitleLb.textAlignment = NSTextAlignmentLeft;
     btn.customTitleLb.y = 0;
     btn.customTitleLb.text = _dataDic[@"title"];
     //     [btn setTitle:@"" forState:UIControlStateNormal];
     btn.customTitleLb.font = [UIFont systemFontOfSize:13];
     btn.customTitleLb.textColor = kUIColorFromRGB(color_7);
     btn.backgroundColor = [UIColor clearColor];
     self.backgroundColor = kUIColorFromRGB(color_2);
}
-(void)fitCancelOrderInfoB
{
     self.height = 44;
     btn.y = 0;
     
     btn.backgroundColor = kUIColorFromRGB(color_3);
     [btn setTitleColor:kUIColorFromRGB(color_2) forState:UIControlStateNormal];
     btn.width = __SCREEN_SIZE.width;
     btn.layer.cornerRadius = 0;
     //     //     btn.layer.borderWidth = 0.5;
     //     //     btn.layer.borderColor = kUIColorFromRGB(color_mainTheme).CGColor;
     btn.layer.masksToBounds = YES;
     btn.height = 44;
     btn.titleLabel.font = [UIFont systemFontOfSize:15];
     btn.x = 0;

}
-(void)fitEditNickMode
{
     self.height = 45;
     btn.y = 0;

     btn.backgroundColor = kUIColorFromRGB(color_3);
     [btn setTitleColor:kUIColorFromRGB(color_2) forState:UIControlStateNormal];
     btn.width = __SCREEN_SIZE.width;
     btn.layer.cornerRadius = 0;
     //     //     btn.layer.borderWidth = 0.5;
     //     //     btn.layer.borderColor = kUIColorFromRGB(color_mainTheme).CGColor;
     btn.layer.masksToBounds = YES;
     btn.height = 45;
     btn.titleLabel.font = [UIFont systemFontOfSize:16];
     btn.x = 0;

}

-(void)fitReplacementConfirmMode
{
     self.height = 45;
     self.backgroundColor = kUIColorFromRGB( color_2);
     btn.width = 110;
     btn.height = 46;
     btn.x = __SCREEN_SIZE.width - btn.width;
     [btn setTitleColor:kUIColorFromRGB(color_2) forState:UIControlStateNormal];
     btn.titleLabel.font = [UIFont systemFontOfSize:16];
     btn.y = 0;
     btn.backgroundColor = kUIColorFromRGB(color_3);


     UILabel *lb = [self.contentView viewWithTag:12113];
     if (!lb) {
          lb = [UILabel new];
          lb.width = 200;
          lb.height = 15;
          lb.tag = 12113;
     }
     lb.textAlignment = NSTextAlignmentLeft;
     lb.text = _dataDic[@"detail"];
     lb.textColor = kUIColorFromRGB(color_3);
     lb.font =  [UIFont systemFontOfSize:15];
     [lb richMText:@"还需支付：" color:kUIColorFromRGB(color_8) withFont:[UIFont systemFontOfSize:13]];
     lb.x = 15;
     lb.y = self.height/2.0 - lb.height/2.0;
     [self.contentView addSubview:lb];
}

-(void)fitZhiMaAuthMode
{
     self.height = 71;
     btn.width = __SCREEN_SIZE.width - 66;
     btn.height = 36;
     btn.x = 33;
     btn.y = 35;
     btn.layer.cornerRadius = btn.height/2.0;
     //    btn.layer.masksToBounds = YES;
     [btn setTitleColor:kUIColorFromRGB(color_2) forState:UIControlStateNormal];
     //    self.backgroundColor = kUIColorFromRGB(color_9);
     btn.backgroundColor = kUIColorFromRGB(color_0xf82D45);
     btn.layer.shadowRadius = 8.0;
     btn.layer.shadowOpacity = 0.43;
     btn.layer.shadowOffset = CGSizeMake(0,0);
     btn.layer.shadowColor = kUIColorFromRGB(color_0xf82D45).CGColor;


     self.contentView.backgroundColor = kUIColorFromRGB(color_F2F2F2);
}
-(void)fitVIPCenterMode
{

     self.height = 45;
     self.backgroundColor = kUIColorFromRGB( color_2);
     btn.width = 110;
     btn.height = 46;
     btn.x = __SCREEN_SIZE.width - btn.width;
     [btn setTitleColor:kUIColorFromRGB(color_2) forState:UIControlStateNormal];
     btn.titleLabel.font = [UIFont systemFontOfSize:16];
     btn.y = 0;
     btn.backgroundColor = kUIColorFromRGB(color_3);


     UILabel *lb = [self.contentView viewWithTag:12113];
     if (!lb) {
          lb = [UILabel new];
          lb.width = 200;
          lb.height = 15;
          lb.tag = 12113;
     }
     lb.textAlignment = NSTextAlignmentLeft;
     lb.text = _dataDic[@"detail"];
     lb.textColor = kUIColorFromRGB(color_3);
     lb.font =  [UIFont systemFontOfSize:15];
     [lb richMText:@"应付金额：" color:kUIColorFromRGB(color_8) withFont:[UIFont systemFontOfSize:13]];
     lb.x = 15;
     lb.y = self.height/2.0 - lb.height/2.0;
     [self.contentView addSubview:lb];
}
@end
