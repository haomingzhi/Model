//
//  InvoiceExplainViewController.m
//  oranllcshoping
//
//  Created by Steve on 2017/7/27.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import "InvoiceExplainViewController.h"

@interface InvoiceExplainViewController ()<UITextViewDelegate>

@end

@implementation InvoiceExplainViewController

- (void)viewDidLoad {
     [super viewDidLoad];
     // Do any additional setup after loading the view from its nib.
     self.title = @"发票问题详情";
     _textFView.editable = NO;
     //    _textFView.hidden = YES;
     //    _textFView.backgroundColor = kUIColorFromRGB(color_4);
     //    [self.view addSubview:self.webView];
     //    [self getData];
     //    self.view.backgroundColor = kUIColorFromRGB(color_4);
     [self setNavigateLeftButton:@"nav_back"];
     _textFView.text = @"1.优惠券的获取\n\n通过活动赠送、客服补偿等获得(系统自动添加, 无需兑换);\n\n2.优惠券使用\n1）每张抵用券仅能使用一次，不找零，不退换，不兑换现金\n 2）单笔订单只能使用1张优惠券, 不支持同时使用多张, 用券后差额不找零, 不退回；\n3）优惠券 (包括新用户券) 不能抵扣配送费, 只能抵扣商品金额。特价商品不可使用优惠券, 与其他优惠不同享；\n4）每张优惠券的使用条件请查看对应优惠券的使用说明；\n5）请在有效期内使用优惠券, 未使用的优惠券过期后, 将自动作废；\n6）每个用户仅限使用1张新用户专享优惠券, 同一帐号和手机号均视为同一用户；\n7）用券前订单满88元即可包邮（港澳台地区需满500元包邮）；\n8）使用抵用券抵扣部分的货款不开具发票\n\n3.优惠券失效\n\n1）新用户券使用一张后其他新用户券失效, 取消订单后不返还；\n2）使用优惠券的订单, 若产生退货, 优惠券均不退回, 退款金额按优惠后的小计金额退款；\n3）参加满赠券活动获得的赠券,发生退货时,若订单中剩余商品不满足赠券条件,实物赠品需勾选退货并寄回,否则将从退款中扣减对应金额,客服审核通过退货申请后,所获赠券将会自动失效；\n4）优惠券严禁出售或转让, 如经发现并证实的, 该券将予以失效处理；\n5）如需了解更多, 请联系在线客服或拨打客服电话400-0000-000。";
     _textFView.textColor = kUIColorFromRGB(color_7);
     _textFView.font = [UIFont systemFontOfSize:13];
     _textFView.attributedText = [self richText:_textFView.text];
     _textFView.frame = self.view.frame;
}

-(NSMutableAttributedString *)richText:(NSString *)txt
{
     //     NSRange range =[self.text rangeOfString:text];
     //     if (range.location == NSNotFound) {
     //          return ;
     //     }
     //     NSAttributedString *attrStr = self.attributedText;
     NSMutableAttributedString *str =  [[NSMutableAttributedString alloc] initWithString:txt];
     NSRange range = [txt rangeOfString:@"1.优惠券的获取"];
     NSRange range2 = [txt rangeOfString:@"2.优惠券使用"];
     NSRange range3 = [txt rangeOfString:@"3.优惠券失效"];
//     NSRange range4 = [txt rangeOfString:@"4. 为什么我的订单不支持开发票？"];
//     NSRange range5 = [txt rangeOfString:@"5. 为什么使用礼品卡支付时不支持开发票？"];
//     NSRange range6 = [txt rangeOfString:@"6. 什么是电子发票？"];
//     NSRange range7 = [txt rangeOfString:@"7. 电子发票什么时候开具？"];
//     NSRange range8 = [txt rangeOfString:@"8. 电子发票在哪里下载"];
//     NSRange range9 = [txt rangeOfString:@"9. 电子发票如何在网上查验？"];
//     NSRange range10 = [txt rangeOfString:@"10. 如果申请退换货，发票如何处理？"];
//     NSRange range11 = [txt rangeOfString:@"11. 纸质增值税普通发票和增值税专用发票怎么开？"];
     //设置字号
     [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:range];
     //设置文字颜色
     [str addAttribute:NSForegroundColorAttributeName value:kUIColorFromRGB(color_1) range:range];
     
     [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:range2];
     //设置文字颜色
     [str addAttribute:NSForegroundColorAttributeName value:kUIColorFromRGB(color_1) range:range2];
     
     //设置字号
     [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:range3];
     //设置文字颜色
     [str addAttribute:NSForegroundColorAttributeName value:kUIColorFromRGB(color_1) range:range3];
     
//     //设置字号
//     [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13] range:range4];
//     //设置文字颜色
//     [str addAttribute:NSForegroundColorAttributeName value:kUIColorFromRGB(color_3) range:range4];
//
//     //设置字号
//     [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13] range:range5];
//     //设置文字颜色
//     [str addAttribute:NSForegroundColorAttributeName value:kUIColorFromRGB(color_3) range:range5];
//
//     //设置字号
//     [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13] range:range6];
//     //设置文字颜色
//     [str addAttribute:NSForegroundColorAttributeName value:kUIColorFromRGB(color_3) range:range6];
//
//
//     //设置字号
//     [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13] range:range7];
//     //设置文字颜色
//     [str addAttribute:NSForegroundColorAttributeName value:kUIColorFromRGB(color_3) range:range7];
//
//     //设置字号
//     [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13] range:range8];
//     //设置文字颜色
//     [str addAttribute:NSForegroundColorAttributeName value:kUIColorFromRGB(color_3) range:range8];
//
//     //设置字号
//     [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13] range:range9];
//     //设置文字颜色
//     [str addAttribute:NSForegroundColorAttributeName value:kUIColorFromRGB(color_3) range:range9];
//
//     //设置字号
//     [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13] range:range10];
//     //设置文字颜色
//     [str addAttribute:NSForegroundColorAttributeName value:kUIColorFromRGB(color_3) range:range10];
//
//     //设置字号
//     [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13] range:range11];
//     //设置文字颜色
//     [str addAttribute:NSForegroundColorAttributeName value:kUIColorFromRGB(color_3) range:range11];
     
     return  str;
}

-(void)getData
{
     //    [busiSystem.agent getUserAgreement:self callback:@selector(getDataNotification:)];
}

-(void)getDataNotification:(BSNotification*)noti
{
     //    if (noti.error.code == 0) {
     //        HUDDISMISS;
     //        _textFView.text =  busiSystem.agent.sysUserAgreement.content?:@"";
     //    }
     //    else
     //    {
     //        HUDCRY(noti.error.domain, 1);
     //    }
}

//-(UIWebView *)webView{
//
//    if (!_webView) {
//        NSString *str = [NSString stringWithFormat:@"%@%@",BU_BUSINESS_DOMAINIP,BU_BUSINESS_UserAggrementt];
//        _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, __SCREEN_SIZE.width, __SCREEN_SIZE.height)];
//        [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
//    }
//
//    return _webView;
//
//}

- (void)didReceiveMemoryWarning {
     [super didReceiveMemoryWarning];
     // Dispose of any resources that can be recreated.
}

@end
