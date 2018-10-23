

#import "BaseViewController.h"

@interface CommonWebViewViewController : BaseViewController<UIWebViewDelegate>
-(id)initWithString:(NSString*)str Title:(NSString*)title HintStr:(NSString *)hintStr;

@property (nonatomic) NSString *homeUrl;
@property (nonatomic) NSString *currentPageUrl;
@property(nonatomic,strong) void(^rightBtnHandle)();
-(void)execJavaScript:(NSString *)js;
@end
