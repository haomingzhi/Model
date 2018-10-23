//
//  SVProgressHUD.h
//
//  Created by Sam Vermette on 27.03.11.
//  Copyright 2011 Sam Vermette. All rights reserved.
//
//  https://github.com/samvermette/SVProgressHUD
//

#import <UIKit/UIKit.h>
#import <AvailabilityMacros.h>

enum {
    SVProgressHUDMaskTypeNone = 1, // allow user interactions while HUD is displayed
    SVProgressHUDMaskTypeClear, // don't allow
    SVProgressHUDMaskTypeBlack, // don't allow and dim the UI in the back of the HUD
    SVProgressHUDMaskTypeGradient // don't allow and dim the UI with a a-la-alert-view bg gradient
};

typedef NSUInteger SVProgressHUDMaskType;

@interface SVProgressHUD : UIView


+ (void)show;
+ (void)showWithInteraction;
+ (void)showWithStatus:(NSString*)status;
+ (void)showWithStatus:(NSString*)status maskType:(SVProgressHUDMaskType)maskType;
+ (void)showWithMaskType:(SVProgressHUDMaskType)maskType;

+ (void)dismiss; // simply dismiss the HUD with a fade+scale out animation
+ (void)dismissWithStatus:(NSString*)string;
+ (void)dismissWithStatus:(NSString*)string image:(UIImage*)image; // also displays the success icon image
+ (void)dismissWithStatus:(NSString*)string image:(UIImage*)image afterDelay:(NSTimeInterval)seconds;

+(void)dismissSync;//同步执行，立马消失

+(void)showAndDismissWithStatus:(NSString*)string;
+(void)showAndDismissWithStatus:(NSString*)string image:(UIImage*)image;
+(void)showAndDismissWithStatus:(NSString*)string image:(UIImage*)image duration:(NSTimeInterval)duration;



+ (void)setStatus:(NSString*)string; // change the HUD loading status while it's showing
+(NSString*)status;



+ (BOOL)isVisible;


- (void)dismiss;
- (void)dismissWithStatus:(NSString*)string image:(UIImage*)image afterDelay:(NSTimeInterval)seconds;


@end
#define HUDCONTENT                [SVProgressHUD status];

#define HUDSHOWCover(text,isCover)     {NSLog(@"%@",text);[SVProgressHUD showWithStatus:text];if (isCover && [self isKindOfClass:NSClassFromString(@"JYBaseViewController")])[self performSelector:@selector(showLoadingCoverView:) withObject:NULL];}

#define HUDSHOWCoverWITHVC(text,isCover,VC)     {NSLog(@"%@",text);[SVProgressHUD showWithStatus:text];if (isCover && [VC isKindOfClass:NSClassFromString(@"JYBaseViewController")])[VC performSelector:@selector(showLoadingCoverView:) withObject:NULL];}

//#define HUDSHOWCover(text,isCover) {NSLog(@"%@",text);[SVProgressHUD showWithStatus:text];if (isCover && [self isKindOfClass:NSClassFromString(@"BaseViewController")])[self performSelector:@selector(showLoadingFailureCoverView:) withObject:@"加载失败,请点击屏幕重试"];}
#define HUDSHOWWITHVC(text,VC)              HUDSHOWCoverWITHVC(text,NO,VC)
#define HUDSHOW(text)              HUDSHOWCover(text,NO)
#define JYWAITSHOW(text,view)   HUDSHOW(text) 
#define HUDSHOWDISMISS(text,sec)  {NSLog(@"%@",text);[SVProgressHUD showAndDismissWithStatus:text image:nil duration:sec];}
//#define HUDDISMISS                {[SVProgressHUD dismiss];}
#define JYWAITDISMISS  HUDDISMISS
#define HUDDISMISS                {[SVProgressHUD dismiss];if ([self isKindOfClass:NSClassFromString(@"JYBaseViewController")])[self performSelector:@selector(hideLoadingCoverView)];};
#define HUDDISMISSSYNC            [SVProgressHUD dismissSync];
#define HUDSHOWSYNC(text)         [SVProgressHUD showWithStatusSync:text];
#define HUDDISMISSSMILE(text)     {NSLog(@"%@",text);[SVProgressHUD dismissWithStatus:text image:[UIImage readImageFromBundle:@"icon_ok" bundleName:@"UniversalFramework.framework"]];if ([self isKindOfClass:NSClassFromString(@"JYBaseViewController")])[self performSelector:@selector(hideLoadingCoverView)];}
#define HUDDISMISSCRY(text)       {NSLog(@"%@",text);[SVProgressHUD dismissWithStatus:text image:[UIImage readImageFromBundle:@"icon_fail" bundleName:@"UniversalFramework.framework"]];if ([self isKindOfClass:NSClassFromString(@"JYBaseViewController")])[self performSelector:@selector(hideLoadingCoverView)];}

#define HUDSMILE(text,sec)        {NSLog(@"%@",text);[SVProgressHUD showAndDismissWithStatus:text image:[UIImage readImageFromBundle:@"icon_ok" bundleName:@"UniversalFramework.framework"] duration:sec];if ([self isKindOfClass:NSClassFromString(@"JYBaseViewController")])[self performSelector:@selector(hideLoadingCoverView)];}
#define HUDCRY(text,sec)          {NSLog(@"%@",text);[SVProgressHUD showAndDismissWithStatus:text image:[UIImage readImageFromBundle:@"icon_fail" bundleName:@"UniversalFramework.framework"] duration:sec];if ([self isKindOfClass:NSClassFromString(@"JYBaseViewController")])[self performSelector:@selector(hideLoadingCoverView)];}

#define HUDCRYWITHVC(text,sec,vc)          {NSLog(@"%@",text);[SVProgressHUD showAndDismissWithStatus:text image:[UIImage readImageFromBundle:@"icon_fail" bundleName:@"UniversalFramework.framework"] duration:sec];if ([vc isKindOfClass:NSClassFromString(@"JYBaseViewController")])[vc performSelector:@selector(hideLoadingCoverView)];}

