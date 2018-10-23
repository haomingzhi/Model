

#import "JYBaseViewController.h"

@interface CommonWebViewViewController : JYBaseViewController<UIWebViewDelegate>
-(id)initWithString:(NSString*)str Title:(NSString*)title HintStr:(NSString *)hintStr;
-(id)initWithHtmlString:(NSString*)htmlString Title:(NSString*)title HintStr:(NSString *)hintStr;
@property (nonatomic)UIEdgeInsets webContentEdgeInsets;
@property (nonatomic)UIEdgeInsets webEdgeInsets;
@property (nonatomic) NSString *homeUrl;
@property (nonatomic,strong) NSString *currentPageUrl;
@property (nonatomic,strong) id userInfo;
@property(nonatomic,strong) void(^rightBtnHandle)();
@property(nonatomic,strong) NSString *jsonDataStr;
-(id)initWithString:(NSString*)str Title:(NSString*)title HintStr:(NSString *)hintStr withWebFrame:(CGRect)rect;
-(void)execJavaScript:(NSString *)js;
+(CommonWebViewViewController *)setWebViewController:(NSString *)title withUrl:(NSString *)url;
//-(void)setBoomGuideView:(NSDictionary *)dataDic;
@end
