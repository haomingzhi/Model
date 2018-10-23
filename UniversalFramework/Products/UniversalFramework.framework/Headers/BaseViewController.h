

#import <UIKit/UIKit.h>
#import "colors.h"
#import "dimens.h"
#import "strings.h"
#import "UIView+Surface.h"
#import "BURes.h"


#define SHOWLOADING(text)   SHOWLOADINGAndAnimated(text,YES)
#define SHOWLOADINGAndAnimated(text,isAnimated)             {NSLog(@"%@",text);[self showLoadingCoverView:text animated:isAnimated];}
#define HIDELOADING                   [self hideLoadingCoverView];

//基本的输入验证
#define BASEVERIFY  \
if ([string isEqualToString:@"\n" ]|| [string isEqualToString:@""])\
return YES;
//手机输入验证（长度与数字）
#define MOBILEVERFY \
{\
BASEVERIFY;\
BOOL bResult =[BSUtility contextDomainLimit:string ValidDomain:NUMBERS];\
return  bResult && range.location<11;}\





@protocol UserRegisterDelegate <NSObject>


-(void)registerWithUserId:(NSString*)userId  password:(NSString*)password;

@end

@interface BaseViewController : UIViewController<MyDialogDelegate>
{
@private
    NSMutableArray *historyCommands; //历史命令
    
}

@property (nonatomic,strong) NSInvocation *appearAction;
@property (nonatomic,readonly) BaseViewController *myMainVc;

//把命令加入到历史，如果网络失败，执行redo重新执行
-(void)addToHistoryCommand:(BSNetworkCommand *)networkCommand;
-(BOOL)redo;


-(void)handleReturnBack:(id)sender;
-(void)setMainVc:(BaseViewController *)vc;
-(void)poptoMianVc;
-(void)poptoClass:(NSString *)className animated:(BOOL) animated;
//显示正在加载遮罩层
-(void)showLoadingCoverView:(NSString *)loadingHint animated:(BOOL) animated;
-(void)showLoadingCoverView:(NSString *)loadingHint;
-(void)hideLoadingCoverView;
-(void)showLoadingFailureCoverView:(NSString *)failureHint;

-(void)setNavigateRightButton:(UIImage *)img observer:(id)obj callBack:(SEL)action;
-(void)setNavigateRightButton:(UIImage *)img frame:(CGRect)frame observer:(id)obj callBack:(SEL)action;
-(void)setNavigateRightButton:(NSString *)imgName ;

-(void)setNavigateRightButton:(NSString *) title font:(UIFont *) font color:(UIColor *) color;
-(void)setNavigateRightButton:(NSString *) title font:(UIFont *) font color:(UIColor *) color frame:(CGRect)frame;
//右边按钮事件
-(void)handleDidRightButton:(id)sender;

-(void) handleInputReturn:(id) sender;
/**
 *  获取焦点视图
 *
 *  @return 当前焦点视图
 */
-(UIView *)getActiveView;

-(void)handleShare:(NSString *)umAppkey shareText:(NSString *)shareText shareImage:(NSString *)imageFileName;

-(void)displayRemoteImage:(BURes *) res  imgView:(UIImageView *) imageView imageName:(NSString *) imageName;

-(UIViewController *) pushTabViewController:(Class ) viewControllClass;

-(UIViewController *) pushTabViewController:(Class ) viewControllClass title:(NSString *) title;


@end
