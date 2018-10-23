//
//  BUdetailsViewController.m
//  ulife
//
//  Created by sunmax on 16/1/15.
//  Copyright © 2016年 ORANLLC_IOS1. All rights reserved.
//

/**
 *　　　　　　　　┏┓　　　┏┓+ +
 *　　　　　　　┏┛┻━━━┛┻┓ + +
 *　　　　　　　┃　　　　　　　┃
 *　　　　　　　┃　　　━　　　┃ ++ + + +
 *　　　　　　 ████━████ ┃+
 *　　　　　　　┃　　　　　　　┃ +
 *　　　　　　　┃　　　┻　　　┃
 *　　　　　　　┃　　　　　　　┃ + +
 *　　　　　　　┗━┓　　　┏━┛
 *　　　　　　　　　┃　　　┃
 *　　　　　　　　　┃　　　┃ + + + +
 *　　　　　　　　　┃　　　┃　　　　Code is far away from bug with the animal protecting
 *　　　　　　　　　┃　　　┃ + 　　　　神兽保佑,代码无bug
 *　　　　　　　　　┃　　　┃
 *　　　　　　　　　┃　　　┃　　+
 *　　　　　　　　　┃　 　　┗━━━┓ + +
 *　　　　　　　　　┃ 　　　　　　　┣┓
 *　　　　　　　　　┃ 　　　　　　　┏┛
 *　　　　　　　　　┗┓┓┏━┳┓┏┛ + + + +
 *　　　　　　　　　　┃┫┫　┃┫┫
 *　　　　　　　　　　┗┻┛　┗┻┛+ + + +
 */




#import "BUdetailsViewController.h"
#import "BUSystem.h"
@interface BUdetailsViewController ()<UIWebViewDelegate>
{
    UIWebView *_webView;
    __weak IBOutlet UILabel *_title;
    __weak IBOutlet UILabel *_time;
}

@end

@implementation BUdetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = _type==Notification?@"通知详情":@"说明详情";
    HUDSHOW(@"正在加载...")
    if (_type==Notification) {
//        [busiSystem.notice noticeDetailNoticeId:_NoticeId observer:self callback:@selector(noticeDetailNotification:)];
    }
    else{
        _time.hidden=YES;
//        [busiSystem.appBasicDocument instruction:_NoticeId Uid:busiSystem.agent.userId observer:self callback:@selector(instructionNotification:)];
    }
    _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 70, __SCREEN_SIZE.width, __SCREEN_SIZE.height- 64 - 70)];
    _webView.backgroundColor =[UIColor whiteColor];
    [_webView setUserInteractionEnabled:YES];//是否支持交互
    _webView.scrollView.bounces=NO;
    //[webView setDelegate:self];
    _webView.delegate=self;
    [_webView setOpaque:NO];//opaque是不透明的意思
//    [_webView setScalesPageToFit:YES];//自动缩放以适应屏幕
    [self.view addSubview:_webView];
    // Do any additional setup after loading the view from its nib.
}


-(void)instructionNotification:(BSNotification *) noti
{ ISTOLOGIN;
//    BASENOTIFICATION(noti);
//    _title.text =busiSystem.appBasicDocument.notice.Title;
//    [_webView loadHTMLString:busiSystem.appBasicDocument.notice.Content baseURL:[NSURL URLWithString:BU_BUSINESS_DOMAIN]];
}

- (void)noticeDetailNotification:(BSNotification *)noti
{ ISTOLOGIN;
//    BASENOTIFICATION(noti);
   
//    _title.text=busiSystem.notice.noticeList.Title;
//    _time.text=busiSystem.notice.noticeList.AddTime;
//    [_webView loadHTMLString:busiSystem.notice.noticeList.Content baseURL:[NSURL URLWithString:BU_BUSINESS_DOMAIN]];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"RefreshNoticeView" object:nil];
//    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '230%'"];
//    UIFont *fontSize =[UIFont systemFontOfSize:14];
//    NSString *jsString = [[NSString alloc] initWithFormat:@"document.body.clientWidth=%f",__SCREEN_SIZE.width];
//    [webView stringByEvaluatingJavaScriptFromString:jsString];
    
//    NSString *meta = [NSString stringWithFormat:@"document.getElementsByName(\"viewport\")[0].content = \"width=self.view.frame.size.width, initial-scale=0.1, minimum-scale=0.1, maximum-scale=5.0, user-scalable=no\""];
//    [webView stringByEvaluatingJavaScriptFromString:meta];//(initial-scale是初始缩放比,minimum-scale=1.0最小缩放比,maximum-scale=5.0最大缩放比,user-scalable=yes是否支持缩放)
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
