

#import "CommonWebViewViewController.h"


@interface CommonWebViewViewController ()

@end

@implementation CommonWebViewViewController
{
    NSString *mStringWeb;
     NSString *_htmlString;
    NSString *mTtileWeb;
    NSString *hintString;
    BOOL isMustReload; //标记是否需要重新加载，如果需要重新加载，viewDidAppear 中重新加载
    NSString *reloadUrl;//重新登陆的Url
    UIWebView *_webView;
    UIProgressView *_progressView;
    
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(id)initWithString:(NSString*)str Title:(NSString*)title HintStr:(NSString *)hintStr
{
   return  [self initWithString:str Title:title HintStr:title withWebFrame:CGRectMake(0, 0,__SCREEN_SIZE.width, __SCREEN_SIZE.height - 64)];
}
-(id)initWithHtmlString:(NSString*)htmlString Title:(NSString*)title HintStr:(NSString *)hintStr
{
    self = [super init];
    if (self)
    {
        _htmlString = htmlString;
        mTtileWeb=title;
        hintString =hintStr;
       
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0,__SCREEN_SIZE.width, __SCREEN_SIZE.height - 64)];
        _webView.dataDetectorTypes = UIDataDetectorTypeNone;
        _webView.delegate = self;
        _progressView = [[UIProgressView alloc]initWithFrame:CGRectMake(0, 0, __SCREEN_SIZE.width, 5)];
        //_progressView.progressTintColor = kUIColorFromRGB(color_12);
        //_progressView.trackTintColor = kUIColorFromRGB(0xffa600);
        //        _webView.backgroundColor = [UIColor yellowColor];
    }
    return self;
}

-(id)initWithString:(NSString*)str Title:(NSString*)title HintStr:(NSString *)hintStr withWebFrame:(CGRect)rect
{
    self = [super init];
    if (self)
    {
        mStringWeb = str;
        mTtileWeb=title;
        hintString =hintStr;
        _homeUrl = [[str componentsSeparatedByString:@"?"]objectAtIndex:0];
         _webView = [[UIWebView alloc] initWithFrame:rect];
        _webView.dataDetectorTypes = UIDataDetectorTypeNone;
        _webView.delegate = self;
        _progressView = [[UIProgressView alloc]initWithFrame:CGRectMake(0, 0, __SCREEN_SIZE.width, 5)];
        //_progressView.progressTintColor = kUIColorFromRGB(color_12);
        //_progressView.trackTintColor = kUIColorFromRGB(0xffa600);
//        _webView.backgroundColor = [UIColor yellowColor]; 
    }
    return self;
}
//-(void) loadView
//{
//        webView.scrollView.contentInset = self.webContentEdgeInsets;
////    webView.height = self.webEdgeInsets.bottom;
//   
//    HUDSHOW(s);
//}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = mTtileWeb;
  
    if (_rightBtnHandle) {
        [self setNav];
    }
    [self.view addSubview:_webView];
//     _webView.scrollView.contentInset = self.webContentEdgeInsets.bottom;
    //    NSString *htmlstring =[[NSString alloc] initWithContentsOfFile:mStringWeb encoding:NSUTF8StringEncoding error:nil];
    //    [webView loadHTMLString:htmlstring  baseURL:[NSURL fileURLWithPath: [[NSBundle mainBundle]  bundlePath]]];
    if (!_htmlString) {
        NSURL *url = [NSURL URLWithString:mStringWeb ];
        [_webView loadRequest:[NSURLRequest requestWithURL:url]];
    }
    else
    {
    NSURL *url = [NSURL URLWithString:_homeUrl ];
        [_webView loadHTMLString:_htmlString baseURL:url];
    }
    
    //[BSUtility displayCookies];
//    NSString *s =[NSString stringWithFormat:@"正在加载%@...",hintString];
}

//-(void)setWebContentEdgeInsets:(UIEdgeInsets)webContentEdgeInsets
//{
//    _webView.height = __SCREEN_SIZE.height - 64 - webContentEdgeInsets.bottom;
//}

-(void)setNav
{
   [self setNavigateRightButton:@"下一步" font:[UIFont systemFontOfSize:15] color:[UIColor whiteColor]];

}

-(void)handleDidRightButton:(id)sender
{
//    ‘{\"classity\":\"服装\",\"des\":\"这个货色真好\",\"name\":\"真皮\",\"pics_url\":[\"www.baidu.com\"],\"postage\":\"30元\",\"price\":\"15元\",\"stock\":\"19件\"}\’
//    NSDictionary *dic = @{@"classity":@"服装",@"des":@"这个货色真好",@"name":@"真皮",@"pics_url":@[@"www.baidu.com"],@"postage":@"30元",@"price":@"15元",@"stock":@"19件"};
//    NSData *data = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
//    NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
     if (_rightBtnHandle) {
         [self execJavaScript:[NSString stringWithFormat:@"SetQuantity(%@)",_jsonDataStr]];
         _rightBtnHandle();
     }
}

-(void)viewDidLayoutSubviews
{
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear: animated];
   
    [self reloadWebPage];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -- UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    _currentPageUrl = request.URL.absoluteString;
    _currentPageUrl = [_currentPageUrl componentsSeparatedByString:@"?"].count >0 ? [[_currentPageUrl componentsSeparatedByString:@"?"]objectAtIndex:0] : _currentPageUrl;
    if ([_currentPageUrl hasPrefix:@"tel:"]) {
        _currentPageUrl = @"";
        return false;
    }
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [self.view    addSubview:_progressView];
    [_progressView setProgress:0.95 animated:YES];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    _currentPageUrl = [[webView.request.URL.absoluteString componentsSeparatedByString:@"?"] objectAtIndex:0];
    isMustReload = FALSE;
    reloadUrl = @"";
    HUDDISMISS;
    //NSLog([BSUtility getWebViewSource:webView]);
    
    [_progressView setProgress:1.0 animated:YES];
    _progressView.hidden = YES;
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    isMustReload = true;
    reloadUrl = webView.request != NULL ? webView.request.URL.absoluteString : @"";
    if (reloadUrl == NULL || reloadUrl.length ==0) {
        reloadUrl = [error.userInfo objectForKey:@"NSErrorFailingURLStringKey"];
    }
    HUDDISMISS;
}

-(void)reloadWebPage
{
    if (isMustReload && reloadUrl != NULL && reloadUrl.length >0) {
//        UIWebView *webView = (UIWebView *)self.view;
        [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:reloadUrl]]];
    }
}
/**
 *  执行脚本
 *
 *  @param js js脚本 如javascript:queryOrder() 执行一个js函数
 */
-(void)execJavaScript:(NSString *)js;
{
    NSLog(@"%@",js);
    UIWebView * webView = (UIWebView *)self.view;
   NSLog(@"%@",[webView stringByEvaluatingJavaScriptFromString:js]) ;
}

+(CommonWebViewViewController *)setWebViewController:(NSString *)title withUrl:(NSString *)url
{
    CommonWebViewViewController *wvc;
    wvc = [[CommonWebViewViewController alloc] initWithString:url Title:title HintStr:@"加载中" withWebFrame:CGRectMake(0, 0,__SCREEN_SIZE.width, __SCREEN_SIZE.height-64 )];
    //    wvc.title = @"ddd";
    return wvc;
    
}






@end
