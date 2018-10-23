//
//  ThreeTitleTogetherTableViewCell.m
//  taihe
//
//  Created by LinFeng on 2016/11/25.
//  Copyright © 2016年 ORANLLC_IOS1. All rights reserved.
//

#import "ThreeTitleTogetherTableViewCell.h"



@implementation ThreeTitleTogetherTableViewCell


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setCellData:(NSDictionary *)dataDic{
    if(!_contentYYLb)
    {
        [self initYYlable];
    }
    
    NSString *name = @"";
    NSString *service = @"";
    NSString *content = @"";
    NSString *phone = @"";
    if (dataDic[@"titleA"]) {
        name = dataDic[@"titleA"];
    }
    if (dataDic[@"titleB"]) {
        service = dataDic[@"titleB"];
    }
    if (dataDic[@"titleB"]) {
        content = dataDic[@"titleC"];
    }
    
    NSRange aRange = NSMakeRange(name.length, service.length);
    NSRange range = NSMakeRange(name.length+service.length, content.length);
    NSRange rangePhone = NSMakeRange(name.length+service.length+content.length,phone.length);
    NSMutableAttributedString *mStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%@%@%@",name,service,content,phone]];
    [mStr addAttribute:NSForegroundColorAttributeName value:kUIColorFromRGB(color_6) range:NSMakeRange(0, name.length)];
    [mStr addAttribute:NSForegroundColorAttributeName value:kUIColorFromRGB(color_3) range:aRange];
    [mStr addAttribute:NSForegroundColorAttributeName value:kUIColorFromRGB(color_6) range:range];
    [mStr addAttribute:NSForegroundColorAttributeName value:kUIColorFromRGB(color_3) range:rangePhone];
    YYTextHighlight *highlight = [YYTextHighlight new];
    //            [highlight setBorder:border];
    highlight.tapAction = ^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect) {
//        CommonWebViewViewController *vc = [CommonWebViewViewController setWebViewController:@"在线客服" withUrl:busiSystem.mineManager.serviceUrl];
//        [self.navigationController pushViewController:vc animated:YES];
    };
    [mStr setTextHighlight:highlight range:aRange];
    
    
    YYTextHighlight *highlightPhone = [YYTextHighlight new];
    //            [highlight setBorder:border];
    highlightPhone.tapAction = ^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect) {
//        NSString *str= [NSString stringWithFormat: @"tel://%@",busiSystem.setPageManager.tell];
//        str=[str stringByReplacingOccurrencesOfString:@"(" withString:@""];
//        str=[str stringByReplacingOccurrencesOfString:@")" withString:@""];
//        UIWebView * callWebview = [[UIWebView alloc] init];
//        [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
//        [self.view addSubview:callWebview];
    };
    [mStr setTextHighlight:highlightPhone range:rangePhone];
    
    _contentYYLb.attributedText = mStr;
    
}


-(void)initYYlable
{
    _contentYYLb = [[YYLabel alloc] initWithFrame:CGRectMake(0, 15,__SCREEN_SIZE.width - 30, 50)];
    _contentYYLb.font = [UIFont systemFontOfSize:15];
    WBStatusComposeTextParser *parser = [WBStatusComposeTextParser new];
    parser.font = [UIFont systemFontOfSize:15];
    _contentYYLb.textParser = parser;
    _contentYYLb.textAlignment = NSTextAlignmentCenter;
    
    WBTextLinePositionModifier *modifier = [WBTextLinePositionModifier new];
    modifier.font = [UIFont systemFontOfSize:15];
    modifier.paddingTop = 0;
    modifier.paddingBottom = 0;
    modifier.lineHeightMultiple = 1.2;
    //    modifier.pa
    _contentYYLb.textColor = kUIColorFromRGB(color_6);
    _contentYYLb.linePositionModifier = modifier;
    _contentYYLb.x = 15;
    _contentYYLb.width = __SCREEN_SIZE.width-30; //15 - _contentYYLb.x;
    _contentYYLb.y = 15;
    _contentYYLb.numberOfLines = 0;
    [_contentYYLb setBackgroundColor:kUIColorFromRGB(color_2)];
    [self.contentView addSubview:_contentYYLb];
    
}

-(void)fitCellMode{
    CGSize size = [_contentYYLb.text size:[UIFont systemFontOfSize:15] constrainedToSize:CGSizeMake(__SCREEN_SIZE.width-30, __SCREEN_SIZE.height*2)];
    _contentYYLb.height = size.height;
    self.height = size.height +30;
}

@end
