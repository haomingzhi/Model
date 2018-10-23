//

#import "UIKitHook.h"

#import <objc/runtime.h>


IMP G_defaultBecomeFirstResponder = NULL;
IMP G_defaultResignFirstResponder = NULL;
IMP G_defaultTextFieldAwakeFromNib = NULL;
IMP G_defaultViewDidLoad = NULL;
IMP G_defaultTextFieldinitWithFrame = NULL;
IMP G_defaultTextFieldsetBorderStyle =NULL;


BOOL myBecomeFirstResponder(UITextField *self, SEL _cmd)
{
    //选中项目 - Project - Build Settings - ENABLE_STRICT_OBJC_MSGSEND  将其设置为 NO 即可
    //如果父亲是搜索框，那么不进行变化
//    if ([self.superview isMemberOfClass:[UISearchBar class]])
        return (BOOL)G_defaultBecomeFirstResponder(self, _cmd);
//    if (self.borderStyle !=UITextBorderStyleNone) {
//        UIColor *borderColor = [UIColor colorWithRed:41.0f/255 green:166.0f/255 blue:231.0f/255 alpha:1];
//        self.layer.borderColor = borderColor.CGColor;
//        self.layer.borderWidth = 1;
//        self.layer.cornerRadius = 5.0;
//        self.layer.masksToBounds = YES;
        
//        CABasicAnimation *baseAni = [CABasicAnimation animationWithKeyPath:@"borderColor"];
//        baseAni.fromValue = (id)[ borderColor colorWithAlphaComponent:0].CGColor;
//        baseAni.toValue = (id)borderColor.CGColor;
//        baseAni.duration = 1;
//        [self.layer addAnimation:baseAni forKey:@"borderColor"];
//    }

    return (BOOL)G_defaultBecomeFirstResponder(self,_cmd);
}

BOOL myResignFirstResponder(UITextField *self, SEL _cmd)
{
    
    //如果父亲是搜索框，那么不进行变化
    if ([self.superview isMemberOfClass:[UISearchBar class]])
        return (BOOL)G_defaultResignFirstResponder(self, _cmd);
    
    
//    UIColor *borderColor = [UIColor colorWithRed:41.0f/255 green:166.0f/255 blue:231.0f/255 alpha:1];
    
//    self.layer.borderColor = [borderColor colorWithAlphaComponent:0].CGColor;
    
//    CABasicAnimation *baseAni = [CABasicAnimation animationWithKeyPath:@"borderColor"];
//    baseAni.fromValue = (id)borderColor.CGColor;
//    baseAni.toValue = (id)[borderColor colorWithAlphaComponent:0].CGColor;
//    baseAni.duration = 1;
//    [self.layer addAnimation:baseAni forKey:@"borderColor"];
    
    //不能在这里恢复窗口的位置，因为这里失去焦点会在获取焦点后调用。。
    
    return (BOOL)G_defaultResignFirstResponder(self,_cmd);
}


void myviewDidLoad(UIViewController *self, SEL _cmd)
{
    G_defaultViewDidLoad(self, _cmd);
    
/*
    //对于容器视图控制器不做处理。。
    if (![self isMemberOfClass:[UINavigationController class]] &&
        ![self isMemberOfClass:[UITabBarController class]] &&
        ![self isMemberOfClass:[UISplitViewController class]] )
    {
        
        if (!([[[UIDevice currentDevice] systemVersion] intValue] == 7&&[self isMemberOfClass:NSClassFromString(@"_UIModalItemsPresentingViewController")])) {
            self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"backgroundpattern.png"]];
            
        }
    }
  */  
}


void myTextFieldAwakeFromNib(UITextField *self, SEL _cmd)
{
    //对于自定义按钮类，我们这里自定义常规和高亮的图片和背景图
    
    if ([self.superview isMemberOfClass:[UISearchBar class]])
    {
        G_defaultTextFieldAwakeFromNib(self, _cmd);
        return;
    }
    
    //设置背景图片。
    self.backgroundColor = [UIColor clearColor];
//    self.layer.cornerRadius = 5.0f;
    self.borderStyle = UITextBorderStyleBezel;
    if (self.background == nil)
        self.background = [[UIImage imageNamed:@"textBackground"] stretchableImageWithLeftCapWidth:20 topCapHeight:0];
    
    
    G_defaultTextFieldAwakeFromNib(self, _cmd);
}


id myTextFieldinitWithFrame(UITextField *self, SEL _cmd, CGRect frame)
{
    if ([self.superview isMemberOfClass:[UISearchBar class]])
    {
        return G_defaultTextFieldinitWithFrame(self, _cmd, frame);
    }
    
    id a = G_defaultTextFieldinitWithFrame(self,_cmd, frame);
    if (a != nil)
    {
        self.backgroundColor = [UIColor clearColor];
//        self.layer.cornerRadius = 5.0f;
        self.borderStyle = UITextBorderStyleBezel;
        if (self.background == nil)
            self.background = [[UIImage imageNamed:@"textBackground"] stretchableImageWithLeftCapWidth:20 topCapHeight:0];
    }
    return a;
    
}

void myTextFieldsetBorderStyle(UITextField *self, SEL _cmd, NSInteger borderStyle)
{
    if ([self.superview isMemberOfClass:[UISearchBar class]])
    {
        G_defaultTextFieldsetBorderStyle(self, _cmd, borderStyle);
        return;
    }
    
    if (borderStyle != UITextBorderStyleRoundedRect )
    {
         G_defaultTextFieldsetBorderStyle(self, _cmd, borderStyle);
    }
}


@implementation UIKitHook


+(void)becomeFirstShowTextField
{
    G_defaultBecomeFirstResponder = class_replaceMethod([UITextField class], @selector(becomeFirstResponder), (IMP)&myBecomeFirstResponder, "@:");
    if (G_defaultBecomeFirstResponder == nil)
    {
        G_defaultBecomeFirstResponder = class_getMethodImplementation([UIControl class], @selector(becomeFirstResponder));
    }
}

+(void)resignFirstdismissTextField
{
    G_defaultResignFirstResponder = class_replaceMethod([UITextField class], @selector(resignFirstResponder), (IMP)&myResignFirstResponder, "@:");
    if (G_defaultResignFirstResponder == nil)
    {
        G_defaultResignFirstResponder = class_getMethodImplementation([UIControl class], @selector(myResignFirstResponder));
    }
}

+(void)viewDidLoadViewController
{
    G_defaultViewDidLoad = class_replaceMethod([UIViewController class], @selector(viewDidLoad), (IMP)&myviewDidLoad, "@:");
}

+(void)textFieldAwakeFromNib
{
    G_defaultTextFieldAwakeFromNib = class_replaceMethod([UITextField class], @selector(awakeFromNib), (IMP)&myTextFieldAwakeFromNib, "@:");
    if (G_defaultTextFieldAwakeFromNib == nil)
    {
        G_defaultTextFieldAwakeFromNib = class_getMethodImplementation([UIControl class], @selector(awakeFromNib));
    }
}

+(void)textFieldinitWithFrame
{
    G_defaultTextFieldinitWithFrame = class_replaceMethod([UITextField class], @selector(initWithFrame:), (IMP)&myTextFieldinitWithFrame, "@:{CGRect={CGPoint={ff}}{CGSize={ff}}}");
}

+(void)textFieldsetBorderStyle
{
     G_defaultTextFieldsetBorderStyle = class_replaceMethod([UITextField class], @selector(setBorderStyle:), (IMP)&myTextFieldsetBorderStyle, "@:I");
}


+(void)loadAllHooks
{
    //改造IOS7的导航条的默认实现。
    //IOS7的不要透明效果，而且设置某个默认的值。
    UIColor * navigationBarColor = kUIColorFromRGB(color_2);//[UIColor colorWithRed:0x3c/255.0 green:0x3c/255.0 blue:0x3c/255.0 alpha:1];
    if (__IOS7)
    {
        CGSize navBarSize = CGSizeMake(__SCREEN_SIZE.width, __NAVBAR_HEIGHT + __STATUSBAR_HEIGHT);
        [[UINavigationBar appearance]  setBackgroundImage:[UIImage imageWithColor: navigationBarColor withBounds:CGRectMake(0, 0, navBarSize.width,navBarSize.height)] forBarPosition:UIBarPositionTopAttached barMetrics:UIBarMetricsDefault];
    }
    else
    {
        CGSize navBarSize = CGSizeMake(__SCREEN_SIZE.width, __NAVBAR_HEIGHT );
//        UIImage *image = [[UIImage imageNamed:@"navbg"] imageToSize:navBarSize];
//        [[UINavigationBar appearance]  setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
        [[UINavigationBar appearance]  setBackgroundImage:[UIImage imageWithColor: navigationBarColor withBounds:CGRectMake(0, 0, navBarSize.width,navBarSize.height)] forBarPosition:UIBarPositionTopAttached barMetrics:UIBarMetricsDefault];
    }

//    NSDictionary *dict=[NSDictionary dictionaryWithObjects:
//                        [NSArray arrayWithObjects:[UIColor whiteColor],[UIFont boldSystemFontOfSize:20],[UIColor clearColor],nil]
////                                                   forKeys:
//                        [NSArray arrayWithObjects:NSForegroundColorAttributeName,NSFontAttributeName,NSShadowAttributeName,nil]];
//    [[UINavigationBar appearance] setTitleTextAttributes:dict];

    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                
                                kUIColorFromRGB(color_2),
                                
                                NSForegroundColorAttributeName, nil];
    
    [[UINavigationBar appearance] setTitleTextAttributes:attributes];
//    [[UITabBarItem appearance] setTitleTextAttributes:
//     [NSDictionary dictionaryWithObjectsAndKeys:
//      [UIColor redColor],
//      NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
    [UIKitHook becomeFirstShowTextField];
    [UIKitHook resignFirstdismissTextField];
    [UIKitHook viewDidLoadViewController];
    
    //如果是IOS6一下的版本设置编辑框的背景图片。
    if (!__IOS7)
    {
       // [UIKitHook textFieldAwakeFromNib];
      //  [UIKitHook textFieldinitWithFrame];
       // [UIKitHook textFieldsetBorderStyle];
    }
    
    
    //设置默认的toast的值。
    CATextLayer *textLayer = [[CATextLayer alloc] init];
    textLayer.foregroundColor = [UIColor redColor].CGColor;
//    textLayer.borderWidth = 1;
    textLayer.borderColor = [UIColor redColor].CGColor;
//    textLayer.cornerRadius = 3;
    textLayer.backgroundColor = [UIColor colorWithRed:252.0/255 green:252.0/255 blue:253.0/255 alpha:0.8].CGColor;
    textLayer.fontSize = 15;
    textLayer.font = @"Helvetica";
    [[MyToast appearance] setLabelLayer:textLayer];
    [textLayer release];
    
    
}

#pragma mark -- Notification Method



@end
