//
//  UserAgreementViewController.m
//  lovecommunity
//
//  Created by orange on 16/6/29.
//  Copyright © 2016年 ORANLLC_IOS1. All rights reserved.
//

#import "UserAgreementViewController.h"
#import "BUSystem.h"
@interface UserAgreementViewController ()<UITextViewDelegate>
//@property (strong, nonatomic) IBOutlet UITextView *textView;

//@property(strong,nonatomic)UIWebView *webView;

@end

@implementation UserAgreementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"用户协议";
    _textFView.editable = NO;
//    _textFView.hidden = YES;
//    _textFView.backgroundColor = kUIColorFromRGB(color_4);
//    [self.view addSubview:self.webView];
//    [self getData];
//    self.view.backgroundColor = kUIColorFromRGB(color_4);
      [self setNavigateLeftButton:@"nav_back"];
//     busiSystem.agent.config.userAgreement = @"本协议是您与“优品汇”的所有者“XXX公司”（以下简称为“ 优品汇”）之间就优品汇所提供的服务及相关事宜所立订的 契约，请您仔细阅读本注册协议，在您确认阅读并选择注 册后，本协议即构成对双方有约束力的法律文件。 第一条 优品汇服务条款的确认和接纳 1.优品汇的各项电子服务的所有权和运作权归“优品汇”所 有。客户同意所有注册协议条款并完成注册程序，才能成 为优品汇的正式客户。客户确认：本协议条款是处理双方 权利义务的契约，始终有效，法律另有强制性规定或双方 另有特别约定的，依其规定。 2.客户点击同意本协议的，即视为客户确认自己具有享受 优品汇服务、下单购物等相应的权利能力和行为能力，能 够独立承担法律责任。 3.如果您在18周岁以下，您只能在父母或监护人的监护参 与下才能使用优品汇。 4.“优品汇”保留在中华人民共和国大陆地区法施行之法律 允许的范围内独自决定拒绝服务、关闭客户账户、清除或 编辑内容或取消订单的权利。 第二条 法律管辖和适用 本协议的订立、执行和解释及争议的解决均应适用在中华 人民共和国大陆地区适用之有效法律（但不包括其冲突法 规则）。 如发生优品汇服务条款与适用之法律相抵触时， 则这些条款将完全按法律规定重新解释，而其它有效条款 继续有效。 如缔约方就本协议内容或其执行发生任何争议， 双方应尽力友好协商解决；协商不成时，任何一方均可向 有管辖权的中华人民共和国大陆地区法院提起诉讼。";
//    _textFView.text = @"本协议是您与“优品汇”的所有者“XXX公司”（以下简称为“ 优品汇”）之间就优品汇所提供的服务及相关事宜所立订的 契约，请您仔细阅读本注册协议，在您确认阅读并选择注 册后，本协议即构成对双方有约束力的法律文件。\n\n 第一条 优品汇服务条款的确认和接纳 \n\n1.优品汇的各项电子服务的所有权和运作权归“优品汇”所 有。客户同意所有注册协议条款并完成注册程序，才能成 为优品汇的正式客户。客户确认：本协议条款是处理双方 权利义务的契约，始终有效，法律另有强制性规定或双方 另有特别约定的，依其规定。\n 2.客户点击同意本协议的，即视为客户确认自己具有享受 优品汇服务、下单购物等相应的权利能力和行为能力，能 够独立承担法律责任。\n 3.如果您在18周岁以下，您只能在父母或监护人的监护参 与下才能使用优品汇。\n 4.“优品汇”保留在中华人民共和国大陆地区法施行之法律 允许的范围内独自决定拒绝服务、关闭客户账户、清除或 编辑内容或取消订单的权利。\n\n 第二条 法律管辖和适用\n\n 本协议的订立、执行和解释及争议的解决均应适用在中华 人民共和国大陆地区适用之有效法律（但不包括其冲突法 规则）。 如发生优品汇服务条款与适用之法律相抵触时， 则这些条款将完全按法律规定重新解释，而其它有效条款 继续有效。 如缔约方就本协议内容或其执行发生任何争议， 双方应尽力友好协商解决；协商不成时，任何一方均可向 有管辖权的中华人民共和国大陆地区法院提起诉讼。";
     _textFView.textColor = kUIColorFromRGB(color_1);
     _textFView.font = [UIFont systemFontOfSize:13];
     _textFView.attributedText = [self richText:_textFView.text];
}

-(NSMutableAttributedString *)richText:(NSString *)txt
{
//     NSRange range =[self.text rangeOfString:text];
//     if (range.location == NSNotFound) {
//          return ;
//     }
//     NSAttributedString *attrStr = self.attributedText;
     NSMutableAttributedString *str =  [[NSMutableAttributedString alloc] initWithString:txt];
     NSRange range = [txt rangeOfString:@"第一条 优品汇服务条款的确认和接纳"];
       NSRange range2 = [txt rangeOfString:@"第二条 法律管辖和适用"];
     //设置字号
     [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13] range:range];
     //设置文字颜色
     [str addAttribute:NSForegroundColorAttributeName value:kUIColorFromRGB(color_3) range:range];
     
     [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13] range:range2];
     //设置文字颜色
     [str addAttribute:NSForegroundColorAttributeName value:kUIColorFromRGB(color_3) range:range2];
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
//- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
//    return NO;
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
