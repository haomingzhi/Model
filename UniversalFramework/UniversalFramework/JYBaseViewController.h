

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


-(void)registerWithUserId:(NSString *)userId  password:(NSString*)password;

@end

@interface JYBaseViewController : UIViewController<MyDialogDelegate>
{
@private
    NSMutableArray *historyCommands; //历史命令
    
}
@property (nonatomic) BOOL hasInit;
@property (nonatomic,readonly) BOOL isFirst;
@property (nonatomic,strong) NSInvocation *appearAction;
@property (nonatomic,strong) UIPanGestureRecognizer *panGesture;
@property (nonatomic,readonly) JYBaseViewController *myMainVc;
//pop 代码快
@property(nonatomic,strong) void (^handleGoBack)(id userData);

@property (nonatomic,readonly) NSArray *monitorErrors;

//创建无数据时的界面
-(UIView *)getUnfoundViewImageName:(NSString *)imageName LabelUnfoundText:(NSString *)labelUnfoundText;
-(void)navRightBtnaddBadage:(NSInteger )count withBtn:(UIButton *)btn;
-(void)setExtraCellLineHidden: (UITableView *)tableView;

-(BOOL) handleGroupNotification:(BSNotification *) noti;

//把命令加入到历史，如果网络失败，执行redo重新执行
-(void)addToHistoryCommand:(BSNetworkCommand *)networkCommand;
-(BOOL)redo;
- (CGSize)detailSizeTitle:(NSString *)title size:(NSInteger)size flo:(CGFloat)flo;
-(void) setNavigateLeftView:(UIView *)btn view1:(UIView *)btn1;
-(void)handleReturnBack:(id)sender;
-(void)handleDidTitle:(id)sender;
-(void)setMainVc:(JYBaseViewController *)vc;
-(void)poptoMianVc;
-(void)poptoClass:(NSString *)className animated:(BOOL) animated;
//显示正在加载遮罩层
-(void)showLoadingCoverView:(NSString *)loadingHint animated:(BOOL) animated;
-(void)showLoadingCoverView:(NSString *)loadingHint;
-(void)hideLoadingCoverView;
-(void)showLoadingFailureCoverView:(NSString *)failureHint;
-(void)handleRedo:(id)btn;
-(void) setNavigateLeftButton:(NSString *)imgName;
-(void) setNavigateLeftView:(UIView *)btn;
-(void)setNavigateLeftButton:(NSString *) title font:(UIFont *) font color:(UIColor *) color;
-(void)setNavigateLeftButton:(NSString *) title font:(UIFont *) font color:(UIColor *) color frame:(CGRect)frame;
-(void)setNavigateLeftButton:(UIImage *)img observer:(id)obj callBack:(SEL)action;
-(void)setNavigateLefeButtonNULL;

-(void)setNavigateRightView:(UIView *)rightView;
-(void)setNavigateRightButton:(NSString *)imgName ;
-(void)setNavigateRightButton:(UIImage *)img observer:(id)obj callBack:(SEL)action;
-(void)setNavigateRightButton:(UIImage *)img frame:(CGRect)frame observer:(id)obj callBack:(SEL)action;

-(void)setNavigateLeftButton:(NSString *) title  image:(UIImage *)image font:(UIFont *) font color:(UIColor *) color;
-(void)setNavigateRightButton:(NSString *) title font:(UIFont *) font color:(UIColor *) color;
-(void)setNavigateRightButton:(NSString *) title font:(UIFont *) font color:(UIColor *) color frame:(CGRect)frame;
-(void)setNavigateRightButton:(NSString *) title font:(UIFont *) font color:(UIColor *) color backgroundColor:(UIColor *)backgroundColor;
-(UIView *)setNavigateRightButton:(NSString *)title font:(UIFont *)font color:(UIColor *)color frame:(CGRect)frame backgroundColor:(UIColor *)backgroundColor;
-(void) setNavigateRightButtonColor:(UIColor *)textColor;
-(void)setNavigateRightButtonNULL:(NSInteger)width;

-(UILabel *)setLabel;

-(UIButton *)setRightButton;
-(BOOL)noLoginToWitch:(BSNotification *)noti;
//右边按钮事件
-(void)handleDidRightButton:(id)sender;

-(void)setNavigateRightButtonNULL;
-(void) handleInputReturn:(id) sender;
/**
 *  获取焦点视图
 *
 *  @return 当前焦点视图
 */
-(UIView *)getActiveView;

-(void)handleShare:(NSString *)shareText shareImage:(NSString *)imageFileName;

-(void)displayRemoteImage:(BURes *) res  imgView:(UIImageView *) imageView imageName:(NSString *) imageName;

-(UIViewController *) pushTabViewController:(NSString * ) viewControllClass;

-(UIViewController *) pushTabViewController:(NSString *)viewControllClass propertyValues:(NSDictionary *) propertys;

-(UIViewController *) pushTabViewController:(NSString *) viewControllClass animated:(BOOL)animated;


-(UIViewController *) pushTabViewController:(NSString *) viewControllClass title:(NSString *) title;
-(UIViewController *) pushTabViewController:(NSString *) viewControllClass title:(NSString *) title propertyValues:(NSDictionary *) propertys  animated:(BOOL)animated;

-(void)setCenterTitleView:(NSString *)title withImgName:(NSString *)imgName;

//******拍照******//
-(void) tackPhonts:(NSInteger) numberCanTake ;
-(void) tackPhontsCallback:(NSArray *) photos error:(NSError*)error;
-(void)navRightBtnaddDot:(NSInteger )count;
@end
