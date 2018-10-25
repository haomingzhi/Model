

#import "JYBaseViewController.h"
#import "dimens.h"
//#import "UMSocial.h"
//#import "MobClick.h"
#import <AVFoundation/AVFoundation.h>
//#import "LoginViewController.h"
#import <UMMobClick/MobClick.h>
#define REFITWIDTHSCALE  320.0/__SCREEN_SIZE.width



@interface JYBaseViewController ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate>
{
    UIButton *btnLeft;
    UILabel *lbl;
    UIButton *btnRight;
}

@end

static __weak JYBaseViewController *mainvc;
@implementation JYBaseViewController
{
    UIButton *buttonTitle;
    NSInteger _numberCanTake;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        historyCommands = [[NSMutableArray alloc] init];
        buttonTitle = [UIButton buttonWithType:UIButtonTypeCustom];
        buttonTitle.frame = CGRectMake(0, 0, 200, 32);
        [buttonTitle setTitleColor:kUIColorFromRGB(color_1) forState:UIControlStateNormal];
        buttonTitle.titleLabel.font = FontWithBody(FONTS_H3);
        [buttonTitle addTarget:self action:@selector(handleDidTitle:) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.titleView = buttonTitle;
        
        
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)])
    {
        [self setEdgesForExtendedLayout:UIRectEdgeNone];
    }
    
    [self.view autokbMovingView];
   
	// Do any additional setup after loading the view.
    //self.view.backgroundColor= kUIColorFromRGB(color_main_bottom_bg);
    //self.view.layer.contents = (id)image_backgroup;
    if (self.navigationController != nil && self.navigationController.viewControllers.count > 1)
    {
        [self setNavigateLeftButton:@"nav_back"];
    }
    _isFirst = YES;
//    _hasInit = YES;
    id target = self.navigationController.interactivePopGestureRecognizer.delegate;
    
    // handleNavigationTransition:为系统私有API,即系统自带侧滑手势的回调方法，我们在自己的手势上直接用它的回调方法
    _panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:target action:@selector(handleNavigationTransition:)];
    _panGesture.delegate = self; // 设置手势代理，拦截手势触发
    [self.view addGestureRecognizer:_panGesture];
    
    // 一定要禁止系统自带的滑动手势
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
}


// 什么时候调用，每次触发手势之前都会询问下代理方法，是否触发
// 作用：拦截手势触发
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    // 当当前控制器是根控制器时，不可以侧滑返回，所以不能使其触发手势
    if(self.navigationController.childViewControllers.count == 1)
    {
        return NO;
    }
    
    return YES;
}


//文字长度
- (CGSize)detailSizeTitle:(NSString *)title size:(NSInteger)size flo:(CGFloat)flo;
{
    //文字宽
    CGSize detailSize = [title sizeWithFont:[UIFont systemFontOfSize:size] constrainedToSize:CGSizeMake(flo, MAXFLOAT) lineBreakMode:UILineBreakModeWordWrap];
    return detailSize;
}


//隐藏分割线
-(void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //    if (UniversalFramework_isUMEnable && self.title.length >0) {
    //        [MobClick beginLogPageView:self.title];
    //    }
    if (self.navigationController != nil && self.navigationController.viewControllers.count > 1)
    {
        [self setNavigateLeftButton:@"nav_back"];
    }
}

-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (self.appearAction != NULL) {
        if (self.appearAction.target != NULL) {
            [self.appearAction invoke];
        }else
        [self.appearAction invokeWithTarget:self];
        self.appearAction = NULL;
    }
    _isFirst = NO;
    self.navigationController.navigationBar.shadowImage = nil;
}


-(void) viewDidDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    if (UniversalFramework_isUMEnable) {
        [MobClick endLogPageView:self.title];
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc
{
    //[busiSystem removeObserver:self];

}


-(BOOL) handleGroupNotification:(BSNotification *) noti
{
    static NSString *errorDomain;
    if (noti.error.code ==0 && [BUBase commandCount] ==0) {
        errorDomain = @"";
//        HUDDISMISS;
        return YES;
    }
    else if (noti.error.code != 0 ) {
        if (errorDomain.length ==0 ||  ![errorDomain containsString:noti.error.domain]) {
            errorDomain = errorDomain == NULL || errorDomain.length ==0 ? noti.error.domain : [NSString stringWithFormat:@"%@,%@",errorDomain,noti.error.domain];
        }
        if ([BUBase commandCount] ==0) {
//            [SVProgressHUD dismiss];
            if ([self isKindOfClass:NSClassFromString(@"JYBaseViewController")] && [self.monitorErrors indexOfObject:@(noti.error.code)] != NSNotFound)
            {
                BSNetworkCommand *cmd = noti.cmd;
                [self performSelector:@selector(addToHistoryCommand:) withObject:cmd];
                [self performSelector:@selector(showLoadingFailureCoverView:) withObject:[NSString stringWithFormat:@"%@,请点击屏幕重试",errorDomain]];
            }
            errorDomain = @"";
        }
        return false;
    }
    return false;
}

-(void) setNavigateLeftButton:(NSString *)imgName
{
    //建立一个自己的返回视图。。
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 29, 29);
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [btn setImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:imgName] forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(handleReturnBack:) forControlEvents:UIControlEventTouchUpInside];
    [self setNavigateLeftView:btn];
}

-(void) setNavigateLeftView:(UIView *)btn
{
    UIBarButtonItem *leftNavButton = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
    UIBarButtonItem *negativeSpacer = [[ UIBarButtonItem alloc ] initWithBarButtonSystemItem : UIBarButtonSystemItemFixedSpace
                                                                                      target : nil action : nil ];
    negativeSpacer. width = - 1 ;
    self.navigationItem.leftBarButtonItems = [ NSArray arrayWithObjects :negativeSpacer, leftNavButton, nil ];

}

-(void) setNavigateLeftView:(UIView *)btn view1:(UIView *)btn1
{
    UIBarButtonItem *leftNavButton = [[UIBarButtonItem alloc] initWithCustomView:btn];
    UIBarButtonItem *leftNavButton1 = [[UIBarButtonItem alloc] initWithCustomView:btn1];
    UIBarButtonItem *negativeSpacer = [[ UIBarButtonItem alloc ] initWithBarButtonSystemItem : UIBarButtonSystemItemFixedSpace
                                                                                      target : nil action : nil ];
    negativeSpacer. width = -2 ;
    
    self.navigationItem.leftBarButtonItems = [ NSArray arrayWithObjects :negativeSpacer,leftNavButton, leftNavButton1,nil ];
}

-(void)setNavigateLeftButton:(NSString *) title  image:(UIImage *)image font:(UIFont *) font color:(UIColor *) color
{
//    CGSize size = [title size:font constrainedToSize:CGSizeMake(MAXFLOAT, 30)];
//    size.width += 10;
    [self setNavigateLeftButton:title font:font color:color frame:CGRectMake(0, 0,70*REFITWIDTHSCALE, 40) image:image]  ;
}

-(UILabel *)setLabel
{
    return lbl;
}

-(void)setNavigateLeftButton:(NSString *) title font:(UIFont *) font color:(UIColor *) color frame:(CGRect)frame image:(UIImage *)image
{
    btnLeft = [UIButton buttonWithType:UIButtonTypeCustom];
    btnLeft.frame = frame;
//    btn.tag =1111;
    //    btn.layer.borderWidth =1;
    //    btn.layer.borderColor = kUIColorFromRGB(color_unSelColor).CGColor;
//    [btnLeft setTitle:title forState:UIControlStateNormal];
//    [btnLeft setTitleColor:color forState:UIControlStateNormal];
    [btnLeft addTarget:self action:@selector(handleReturnBack:) forControlEvents:UIControlEventTouchUpInside];
    UIImageView *imgView =[[UIImageView alloc]initWithFrame:CGRectMake(0, (btnLeft.height -22)/2, 22, 22)];
    imgView.image =image;
    imgView.height = image.size.height;
    imgView.width = image.size.width;
    lbl =[[UILabel alloc] initWithFrame:CGRectMake(26, 0,70 * REFITWIDTHSCALE, 40)];
    lbl.font =[UIFont systemFontOfSize:14];
    lbl.textColor =[UIColor whiteColor];
//    lbl.tintColor =[UIColor whiteColor];
    lbl.text =title;
    [btnLeft addSubview:imgView];
    [btnLeft addSubview:lbl];
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame = CGRectMake(0, 0, 22, 22);
    //    btn.layer.borderWidth =1;
    //    btn.layer.borderColor = kUIColorFromRGB(color_unSelColor).CGColor;
//    [btn1 setTitle:title forState:UIControlStateNormal];
    [btn1 setImage:image forState:UIControlStateNormal];
    [btn1 setTitleColor:color forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(handleReturnBack:) forControlEvents:UIControlEventTouchUpInside];
    [self setNavigateLeftView:btnLeft];
}

-(void)setNavigateLeftButton:(NSString *) title font:(UIFont *) font color:(UIColor *) color
{
    CGSize size = [title size:font constrainedToSize:CGSizeMake(MAXFLOAT, 30)];
    size.width += 10;
    [self setNavigateLeftButton:title font:font color:color frame:CGRectMake(0, 0, size.width, size.height)];
}
-(void)setNavigateLeftButton:(NSString *) title font:(UIFont *) font color:(UIColor *) color frame:(CGRect)frame
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = frame;
    btn.titleLabel.font = font;
    //    btn.layer.borderWidth =1;
    //    btn.layer.borderColor = kUIColorFromRGB(color_unSelColor).CGColor;
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:color forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(handleReturnBack:) forControlEvents:UIControlEventTouchUpInside];
    [self setNavigateLeftView:btn];
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string Index:(int)index
{
    //回车删除都OK
    if ([string isEqualToString:@"\n"] || [string isEqualToString:@""])
        return YES;
    return [BSUtility contextLengthLimit:range replacementString:string MaxLength:6];
}





#pragma mark -- Handle Method

-(void)handleShare :(NSString *)shareText shareImage:(NSString *)imageFileName
{
//    [UMWarp share:self shareContent:shareText image:imageFileName];
    

}

-(void) handleDidTitle:(id)sender
{
    NSLog(@"%@",@"handleDidTitle");
}

-(void)handleReturnBack:(id)sender
{
    [self.view endEditing:YES];
    [self poptoMianVc];
}

-(JYBaseViewController *)myMainVc
{
    return mainvc;
}
-(void)setMainVc:(JYBaseViewController *)vc
{
    mainvc = vc;
}


-(void)poptoMianVc
{
    BOOL isExists = false;
    //有可能不是使用push，所以要检测一下是否存在
    for (int i =0;mainvc !=NULL && i < self.navigationController.viewControllers.count; i++) {
        if (mainvc == [self.navigationController.viewControllers objectAtIndex:i]) {
            isExists = true;
            break;
        }
    }
    if (! isExists) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else [self.navigationController popToViewController:mainvc animated:TRUE];
}

-(void)poptoClass:(NSString *)className animated:(BOOL)animated
{
    UIViewController * vc =[BSUtility FindViewControllerByClass:self className:className];
    if (vc != NULL) {
        [self.navigationController popToViewController:vc animated:animated];
    }
}
-(UIView *)getActiveView
{
    for (int i =0; i < self.view.subviews.count; i++) {
        UIView *tmpView = [self.view.subviews objectAtIndex:i];
        UIView *activeView = [self getActiveView:tmpView];
        if (activeView != NULL) {
            return activeView;
        }
    }
    return NULL;
}

-(UIView *)getActiveView:(UIView *)checkView
{
    if ([checkView isFirstResponder]) {
        return checkView;
    }
    for (int i =0; i < checkView.subviews.count; i++) {
        UIView *tmpView = [self getActiveView:[checkView.subviews objectAtIndex:i ]];
        if (tmpView != NULL) {
            return tmpView;
        }
    }
    return NULL;
}


const int CoverViewFlag = 135140999;

-(void)showLoadingCoverView:(NSString *)loadingHint animated:(BOOL) animated
{
    UIView *cView = [self.view viewWithTag:CoverViewFlag] == NULL ? [[UIView alloc] initWithFrame:CGRectMake(0, 0, __SCREEN_SIZE.width,__SCREEN_SIZE.height)] : [self.view viewWithTag:CoverViewFlag];
    CGPoint centerPoint = cView.center;
    cView.tag = CoverViewFlag;
    cView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:cView];
    if (animated) {
        
        UIActivityIndicatorView *a = [[UIActivityIndicatorView  alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
        a.center = centerPoint;
        [a startAnimating];
        //    a.backgroundColor = [UIColor redColor];
        a.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
        [cView addSubview:a];
        centerPoint.y += 26;
    }
    UILabel *tipLb = [[UILabel alloc] initWithFrame:CGRectMake(130, 240, 200, 20)];
    
    tipLb.center = centerPoint;
    tipLb.text = loadingHint;
    tipLb.textAlignment = NSTextAlignmentCenter;
    tipLb.font = [UIFont boldSystemFontOfSize:14];
    tipLb.textColor = [UIColor blackColor];
    [cView addSubview:tipLb];
    [self.view bringSubviewToFront:cView];
}

-(void)showLoadingFailureCoverView:(NSString *)failureHint
{
    UIView *coverView = [self.view viewWithTag:CoverViewFlag];
    if (coverView) {
        [coverView removeFromSuperview];
    }
    
    UIView *cView =  [[UIView alloc] initWithFrame:CGRectMake(0, 0, __SCREEN_SIZE.width,self.view.frame.size.height)] ;
    CGPoint centerPoint = cView.center;
    cView.tag = CoverViewFlag;
    cView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:cView];
    centerPoint.y -= 50;
    
    UIButton *b = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 200, 300)];
    [b addTarget:self action:@selector(handleRedo:) forControlEvents:UIControlEventTouchUpInside];
    b.center = centerPoint;
    [b setImage:[UIImage readImageFromBundle:@"loading_fail_N" bundleName:@"UniversalFramework.framework"] forState:UIControlStateNormal];
    [cView addSubview:b];
    
    centerPoint.y += 100;
    UILabel *tipLb = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, __SCREEN_SIZE.width, 20)];
    tipLb.center = centerPoint;
    tipLb.text = failureHint;
    tipLb.textAlignment = NSTextAlignmentCenter;
    tipLb.font = [UIFont systemFontOfSize:14];
    tipLb.textColor = [UIColor blackColor];
    [cView addSubview:tipLb];
    [self.view bringSubviewToFront:cView];
    
}

-(NSString*) title
{
    return [buttonTitle titleForState:UIControlStateNormal];
}

-(void) setTitle:(NSString *)title
{
    title = title.length >11 ? [NSString stringWithFormat:@"%@...",[title substringToIndex:6]] :title;
    //[super setTitle:title];
    [buttonTitle setTitle:title forState:UIControlStateNormal];
    if (UniversalFramework_isUMEnable) {
        [MobClick beginLogPageView:self.title];
    }
}

-(BOOL)prefersStatusBarHidden
{
    return NO;
}

-(void)showLoadingCoverView:(NSString *) loadingHint
{
    [self showLoadingCoverView:loadingHint animated:loadingHint.length >0];
}

-(void)hideLoadingCoverView
{
    UIView *cView = [self.view viewWithTag:CoverViewFlag];
    [cView removeFromSuperview];
}
//根据tag自动跳转到下一个
-(void) handleInputReturn:(id) sender
{
    
    UIView *v = (UIView *)sender;
    NSInteger tag = v.tag;
    UIView *nextView = [v.superview viewWithTag:tag +1];
    if (nextView != NULL) {
        [nextView becomeFirstResponder];
    }
    else [v resignFirstResponder];
}

//-(void)displayRemoteImage:(BURes *) res  btnImgView:(UIButton *) imageView imageName:(NSString *) imageName
//{
//    if (res.isCached) {
//        imageView.image = [UIImage imageWithContentsOfFile:res.cacheFile];
//    }
//    else
//    {
//        if ( imageName.length >0) {
////            [imageView.imageView set]
//            imageView.image = [UIImage imageNamed:imageName];
//        }
//        if (res.relativeURL.length >0 )
//            [res download:self callback:@selector(resDownloadNotification:) extraInfo:@{@"imageView":imageView}];
//    }
//}

-(void)displayRemoteImage:(BURes *) res  imgView:(UIImageView *) imageView imageName:(NSString *) imageName
{
    if (res.isCached) {
        imageView.image = [UIImage imageWithContentsOfFile:res.cacheFile];
    }
    else
    {
        if ( imageName.length >0) {
            imageView.image = [UIImage imageNamed:imageName];
        }
        if (res.relativeURL.length >0 )
            [res download:self callback:@selector(resDownloadNotification:) extraInfo:@{@"imageView":imageView}];
    }
}

-(void) resDownloadNotification:(BSNotification *) noti
{
    if (noti.error.code ==0) {
        BURes *res = (BURes *) noti.target;
        UIImageView * imageView = (UIImageView *)[ noti.extraInfo objectForKey:@"imageView"];
        imageView.image = [UIImage imageWithContentsOfFile:res.cacheFile];
    }
}

-(void)setNavigateRightButton:(UIImage *)img observer:(id)obj callBack:(SEL)action
{
    [self setNavigateRightButton:img frame:CGRectMake(0, 0, 30, 30) observer:obj callBack:action];
}


-(void)setNavigateLeftButton:(UIImage *)img observer:(id)obj callBack:(SEL)action
{
    [self setNavigateLeftButton:img frame:CGRectMake(0, 0, 30, 30) observer:obj callBack:action];
}

-(void)setNavigateRightButtonNULL:(NSInteger)width
{
    UIButton *b = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    b.width = width;
    UIBarButtonItem *rightNavButton = [[UIBarButtonItem alloc] initWithCustomView:b];
    
    UIBarButtonItem *negativeSpacer = [[ UIBarButtonItem alloc ] initWithBarButtonSystemItem : UIBarButtonSystemItemFixedSpace
                                                                                      target : nil action : nil ];
    negativeSpacer.width = -6 ;
    self.navigationItem.rightBarButtonItems = [ NSArray arrayWithObjects :negativeSpacer, rightNavButton, nil ];
}

-(void)setNavigateRightButtonNULL
{
    UIBarButtonItem *rightNavButton = [[UIBarButtonItem alloc] initWithCustomView:[[UIView alloc] init]];
    
    UIBarButtonItem *negativeSpacer = [[ UIBarButtonItem alloc ] initWithBarButtonSystemItem : UIBarButtonSystemItemFixedSpace
                                                                                      target : nil action : nil ];
    negativeSpacer.width = -6 ;
    self.navigationItem.rightBarButtonItems = [ NSArray arrayWithObjects :negativeSpacer, rightNavButton, nil ];
}


-(void)setNavigateLefeButtonNULL
{
    UIBarButtonItem *rightNavButton = [[UIBarButtonItem alloc] initWithCustomView:[[UIView alloc] init]];
    
    UIBarButtonItem *negativeSpacer = [[ UIBarButtonItem alloc ] initWithBarButtonSystemItem : UIBarButtonSystemItemFixedSpace
                                                                                      target : nil action : nil ];
    negativeSpacer.width = -6 ;
    self.navigationItem.leftBarButtonItems = [ NSArray arrayWithObjects :negativeSpacer, rightNavButton, nil ];
}

-(UIView *)setNavigateRightButton:(NSString *)title font:(UIFont *)font color:(UIColor *)color frame:(CGRect)frame backgroundColor:(UIColor *)backgroundColor
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = frame;
    //    btn.layer.borderWidth =1;
    //    btn.layer.borderColor = kUIColorFromRGB(color_unSelColor).CGColor;
    btn.titleLabel.font=font;
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:color forState:UIControlStateNormal];
    if (backgroundColor) {
        btn.backgroundColor = backgroundColor;
    }
    [btn addTarget:self action:@selector(handleDidRightButton:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    return btn;
}

-(void) setNavigateRightView:(UIView *)rightView
{
    //btn.backgroundColor = [UIColor redColor];
    UIBarButtonItem *rightNavButton = [[UIBarButtonItem alloc] initWithCustomView:rightView];
    
    UIBarButtonItem *negativeSpacer = [[ UIBarButtonItem alloc ] initWithBarButtonSystemItem : UIBarButtonSystemItemFixedSpace
                                                                                      target : nil action : nil ];
    negativeSpacer.width = -6 ;
    self.navigationItem.rightBarButtonItems = [ NSArray arrayWithObjects :negativeSpacer, rightNavButton, nil ];
}

-(void)setNavigateRightButton:(UIImage *)img frame:(CGRect)frame observer:(id)obj callBack:(SEL)action
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = frame;
    [btn setImage:img forState:UIControlStateNormal];
    if (action != NULL) {
        [btn addTarget:obj action:action forControlEvents:UIControlEventTouchUpInside];
    }
     btnRight = btn;
    [self setNavigateRightView:btn];
}



-(void)setNavigateLeftButton:(UIImage *)img frame:(CGRect)frame observer:(id)obj callBack:(SEL)action
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = frame;
    [btn setImage:img forState:UIControlStateNormal];
    if (action != NULL) {
        [btn addTarget:obj action:action forControlEvents:UIControlEventTouchUpInside];
    }
    btnRight = btn;
    [self setNavigateLeftView:btn];
}



-(void)setNavigateRightButton:(NSString *)imgName
{
    [self setNavigateRightButton:[UIImage imageNamed:imgName] observer:self callBack:@selector(handleDidRightButton:)];
}
-(void)setNavigateRightButton:(NSString *) title font:(UIFont *) font color:(UIColor *) color
{
    CGSize size = [title size:font constrainedToSize:CGSizeMake(MAXFLOAT, 30)];
    size.width += 10;
    [self setNavigateRightButton:title font:font color:color frame:CGRectMake(0, 0, size.width, size.height)]  ;
}

-(void)setNavigateRightButton:(NSString *) title font:(UIFont *) font color:(UIColor *) color backgroundColor:(UIColor *)backgroundColor
{
    CGSize size = [title size:font constrainedToSize:CGSizeMake(MAXFLOAT, 30)];
    size.width += 10;
    [self setNavigateRightButton1:title font:font color:color frame:CGRectMake(0, 0, size.width, size.height) backgroundColor:backgroundColor]  ;
}

-(void)setNavigateRightButton1:(NSString *) title font:(UIFont *) font color:(UIColor *) color frame:(CGRect)frame backgroundColor:(UIColor *)backgroundColor
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = frame;
    btn.backgroundColor =backgroundColor;
    //    btn.layer.borderWidth =1;
    //    btn.layer.borderColor = kUIColorFromRGB(color_unSelColor).CGColor;
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:color forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(handleDidRightButton:) forControlEvents:UIControlEventTouchUpInside];
    
    [self setNavigateRightView:btn];
}

-(UIButton *)setRightButton
{
    return btnRight;
}

-(void)setNavigateRightButton:(NSString *) title font:(UIFont *) font color:(UIColor *) color frame:(CGRect)frame
{
    btnRight = [UIButton buttonWithType:UIButtonTypeCustom];
    btnRight.frame = frame;
    btnRight.titleLabel.font =font;
//    btn.layer.borderWidth =1;
//    btn.layer.borderColor = kUIColorFromRGB(color_unSelColor).CGColor;
    [btnRight setTitle:title forState:UIControlStateNormal];
    [btnRight setTitleColor:color forState:UIControlStateNormal];
    [btnRight addTarget:self action:@selector(handleDidRightButton:) forControlEvents:UIControlEventTouchUpInside];
    [self setNavigateRightView:btnRight];
}
/**
 *  修改导航右按钮字体颜色
 *
 *  @param textColor 字体颜色
 */
-(void) setNavigateRightButtonColor:(UIColor *)textColor
{
    UIButton *btn = (UIButton *)self.navigationItem.rightBarButtonItem.customView;
    if (!btn && self.navigationItem.rightBarButtonItems.count >=2 ) {
        btn = (UIButton *)[self.navigationItem.rightBarButtonItems[1] customView];
    }
    [btn setTitleColor:textColor forState:UIControlStateNormal];
}

//右边按钮事件
-(void)handleDidRightButton:(id)sender
{
    
}


-(UIViewController *) pushTabViewController:(NSString* ) viewControllClass
{
    return [self pushTabViewController:viewControllClass propertyValues:NULL];
}

-(UIViewController *) pushTabViewController:(NSString *)viewControllClass propertyValues:(NSDictionary *)propertys
{
    return [self pushTabViewController:viewControllClass title:@"" propertyValues:propertys animated:YES];
}

-(UIViewController *) pushTabViewController:(NSString* ) viewControllClass animated:(BOOL)animated
{
    return [self pushTabViewController:viewControllClass title:@"" propertyValues:NULL animated:animated];
}

-(UIViewController *) pushTabViewController:(NSString* ) viewControllClass title:(NSString *) title
{
    return [self pushTabViewController:viewControllClass title:title propertyValues:NULL animated:YES];
}

-(UIViewController *) pushTabViewController:(NSString* ) viewControllClass title:(NSString *) title propertyValues:(NSDictionary *) propertys animated:(BOOL)animated
{
    UIViewController *vc = (UIViewController *) [[NSClassFromString(viewControllClass) alloc] init];
    if (propertys) {
        for (NSString *propertyName in propertys.allKeys) {
            [vc setValue:propertys[propertyName] forKey:propertyName];
        }
    }
    if (title.length >0) {
        vc.title = title;
    }
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:animated];
    return  vc;
}
#pragma mark --redo

-(void)addToHistoryCommand:(BSNetworkCommand *)networkCommand;
{
    [historyCommands addObject:networkCommand];
}
-(BOOL)redo
{
    if (historyCommands.count >0) {
//        HUDSHOW(LoadingHintString);
        for (BSNetworkCommand *cmd in historyCommands) {
            [cmd execute];
        }
        [historyCommands removeAllObjects];
        return YES;
    }
    return NO;
}
-(void) handleRedo:(id) sender
{
    [self redo];
}

//******拍照******//
-(void) tackPhonts:(NSInteger) numberCanTake
{
    _numberCanTake = numberCanTake;
//    TSAssetsPickerController *pcikervc = [[TSAssetsPickerController alloc]init];
//    TSAssetsViewController *vc = [[TSAssetsViewController alloc]init];
//    vc.picker = pcikervc;
//    vc.delegate = self;
//    [self.navigationController pushViewController:vc animated:YES];

}
-(void) tackPhontsCallback:(NSArray *) photos error:(NSError*)error
{
    
}
//#pragma mark --TSAssetsViewControllerDelegate
//- (void)assetsViewController:(TSAssetsViewController *)assetsVC didFinishPickingAssets:(NSArray *)assets
//{
//    if (assets == NULL || assets.count ==0) {
//        //tod 拍照
//        [self takeImage];
//    }
//    else
//    {
//        NSLog(@"count = %ld",assets.count);
//        NSMutableArray *imgs = [[NSMutableArray alloc] init];
//        [assets enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
//            ALAsset *asset = (ALAsset *)obj;
//            CGImageRef ref = [[asset  defaultRepresentation]fullScreenImage];
//            [imgs addObject: [UIImage imageWithCGImage:ref]];
//        }];
//        [self tackPhontsCallback:imgs error:SuccessedError];
//        [self.navigationController popViewControllerAnimated:YES];
//    }
//}
//-(void)assetsViewController:(TSAssetsViewController *)albumsVC failedWithError:(NSError *)error{
//    [self tackPhontsCallback:NULL error:error];
//}

-(NSInteger) numberOfItemsCanSelected
{
    return 1;
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:^{}];
    [self tackPhontsCallback:@[[info objectForKey:UIImagePickerControllerOriginalImage]] error:SuccessedError];
}
//用户取消拍照
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    [self tackPhontsCallback:NULL error:CustomError(1,@"用户取消")];
}


-(void)takeImage
{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        if (status != AVAuthorizationStatusAuthorized && status != AVAuthorizationStatusNotDetermined) {
            
            NSString *hint = [NSString stringWithFormat:@"                            使用提示\n            请在【设置->隐私->相机】下\n              允许[%@]访问相机",UniversalFramework_BundleName];
            [[MyMessageBox msgBox] show:@"温馨提示" message:hint cancelButtonTitle:@"确定" otherButtonTitles:nil completion:nil];
            
            return;
        }
    }
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        UIImagePickerController *imagePickerController  = [[UIImagePickerController alloc] init];
        imagePickerController.delegate = self;
        imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:imagePickerController animated:YES completion:nil];
    }
}


//创建无数据时的界面
-(UIView *)getUnfoundViewImageName:(NSString *)imageName LabelUnfoundText:(NSString *)labelUnfoundText
{
    NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"OrderUnfound" owner:nil options:nil];
    UIView *headView = [nib objectAtIndex:0];
    headView.backgroundColor = kUIColorFromRGB(color_white);
    headView.frame =CGRectMake(0, 0, __SCREEN_SIZE.width, __SCREEN_SIZE.height);
    UILabel *labelUnfound = (UILabel *)[headView viewWithTag:2];
    UIImageView *imgV =(UIImageView *)[headView viewWithTag:1];
    imgV.image =[UIImage imageNamed:imageName];
    labelUnfound.textColor = kUIColorFromRGB(color_0x999999);
    labelUnfound.text=labelUnfoundText;
    UILabel *goShopping = (UILabel *)[headView viewWithTag:4];
    [goShopping setText:@"" ];
    CGRect frame = headView.frame;
    frame.size.height = self.view.frame.size.height;
    headView.frame = frame;
    return headView;
}

-(void)navRightBtnaddBadage:(NSInteger )count withBtn:(UIButton *)btn
{
    UILabel *badeLb = [btn viewWithTag:333];
    if (!badeLb) {
        badeLb = [[UILabel alloc] initWithFrame:CGRectMake(28, 6, 12, 12)];
        badeLb.backgroundColor = [UIColor redColor];
        badeLb.textColor = [UIColor whiteColor];
        badeLb.layer.masksToBounds = YES;
        badeLb.layer.cornerRadius = badeLb.height/2;
        badeLb.font = [UIFont systemFontOfSize:10];
        badeLb.tag = 333;
        badeLb.textAlignment = NSTextAlignmentCenter;
        [btn addSubview:badeLb];
    }
    badeLb.text = [NSString stringWithFormat:@"%ld",count];
    if (count == 0) {
        [badeLb setHidden:YES];
    }
    else
    {
        
        if (count < 10) {
            badeLb.width = 12;
            badeLb.x = 28;
        }
        else if(count < 100)
        {
            badeLb.width = 18;
            badeLb.x = 25;
        }
        else
        {
            badeLb.text = @"99+";
            badeLb.width = 25;
            badeLb.x = 21;
        }
        [badeLb setHidden:NO];
    }
}

-(void)navRightBtnaddDot:(NSInteger )count
{
    UILabel *badeLb = [btnRight viewWithTag:333];
    if (!badeLb) {
        badeLb = [[UILabel alloc] initWithFrame:CGRectMake(20, 6, 6, 6)];
        badeLb.backgroundColor = kUIColorFromRGB(color_5);
        badeLb.textColor = [UIColor whiteColor];
        badeLb.layer.masksToBounds = YES;
        badeLb.layer.cornerRadius = badeLb.height/2;
        badeLb.font = [UIFont systemFontOfSize:10];
        badeLb.tag = 333;
        badeLb.textAlignment = NSTextAlignmentCenter;
        [btnRight addSubview:badeLb];
    }
    //    badeLb.text = [NSString stringWithFormat:@"%ld",count];
    if (count == 0) {
        [badeLb setHidden:YES];
    }
    else
    {
        
        [badeLb setHidden:NO];
    }
}



-(void)setCenterTitleView:(NSString *)title withImgName:(NSString *)imgName
{
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 120, 40)];
    
    UILabel *l = [[UILabel alloc] initWithFrame:CGRectMake(35, 0, 80, 40)];
    l.textColor = [UIColor whiteColor];
    l.text = title;
    l.font = [UIFont systemFontOfSize:24];
    [v addSubview:l];
    
    UIImageView *imgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 5, 30, 30)];
    imgV.image = [UIImage imageContentWithFileName:imgName];
    [v addSubview:imgV];
    self.navigationItem.titleView = v;
}

-(BOOL)noLoginToWitch:(BSNotification *)noti
{
  BUBase *base = noti.target;
    if (base.codeState == -1) {
//        [LoginViewController toLogin:self];
        return NO;
    }
    return YES;
}

@end
