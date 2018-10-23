//
//  SVProgressHUD.m
//
//  Created by Sam Vermette on 27.03.11.
//  Copyright 2011 Sam Vermette. All rights reserved.
//
//  https://github.com/samvermette/SVProgressHUD
//

#import "SVProgressHUD.h"
#import <QuartzCore/QuartzCore.h>


@interface SVProgressHUDWindow : UIWindow

@end

@implementation SVProgressHUDWindow


@end


@interface SVProgressHUD ()

@property (nonatomic, readwrite) SVProgressHUDMaskType maskType;
@property (nonatomic) NSTimer *fadeOutTimer;

@property (nonatomic) UIWindow *overlayWindow;
@property (nonatomic) UIView *hudView;
@property (nonatomic) UILabel *stringLabel;
@property (nonatomic) UIImageView *imageView;
@property (nonatomic) UIActivityIndicatorView *spinnerView;
@property (nonatomic) NSString *hintContext;
@property (nonatomic, readonly) CGFloat visibleKeyboardHeight;

- (void)showWithStatus:(NSString*)string maskType:(SVProgressHUDMaskType)hudMaskType networkIndicator:(BOOL)show;
- (void)setStatus:(NSString*)string;
- (void)registerNotifications;
- (void)moveToPoint:(CGPoint)newCenter rotateAngle:(CGFloat)angle;
- (void)positionHUD:(NSNotification*)notification;


@end


@implementation SVProgressHUD

@synthesize overlayWindow, hudView, maskType, fadeOutTimer, stringLabel, imageView, spinnerView, visibleKeyboardHeight,hintContext;;

- (void)dealloc {
	
    
    
    [(NSNotificationCenter*)[NSNotificationCenter defaultCenter] removeObserver:self];
    
}


+ (SVProgressHUD*)sharedView {
    static dispatch_once_t once;
    static SVProgressHUD *sharedView;
    dispatch_once(&once, ^ { sharedView = [[SVProgressHUD alloc] initWithFrame:[[UIScreen mainScreen] bounds]]; });
    return sharedView;
}


+ (void)setStatus:(NSString *)string {
	[[SVProgressHUD sharedView] setStatus:string];
}

+(NSString*)status
{
    return [[SVProgressHUD sharedView] hintContext ];
}

#pragma mark - Show Methods

+ (void)show {
    [[SVProgressHUD sharedView] showWithStatus:nil maskType:SVProgressHUDMaskTypeClear networkIndicator:NO];
}

+ (void)showWithInteraction
{
    [[SVProgressHUD sharedView] showWithStatus:nil maskType:SVProgressHUDMaskTypeNone networkIndicator:NO];
}

+ (void)showWithStatus:(NSString *)status {
    [[SVProgressHUD sharedView] showWithStatus:status maskType:SVProgressHUDMaskTypeClear networkIndicator:NO];
}

+ (void)showWithMaskType:(SVProgressHUDMaskType)maskType {
    [[SVProgressHUD sharedView] showWithStatus:nil maskType:maskType networkIndicator:NO];
}

+ (void)showWithStatus:(NSString*)status maskType:(SVProgressHUDMaskType)maskType {
    [[SVProgressHUD sharedView] showWithStatus:status maskType:maskType networkIndicator:NO];
}



#pragma mark - Dismiss Methods

+ (void)dismiss {
	[[SVProgressHUD sharedView] dismiss];
}

+(void)dismissSync;//同步执行，立马消失
{
    [[SVProgressHUD sharedView] dismissSync];

}
+ (void)dismissWithStatus:(NSString*)string
{
    [SVProgressHUD dismissWithStatus:string image:nil];
}

+ (void)dismissWithStatus:(NSString*)string image:(UIImage*)image
{
    [SVProgressHUD dismissWithStatus:string image:image afterDelay:0.9];
}

+ (void)dismissWithStatus:(NSString*)string image:(UIImage*)image afterDelay:(NSTimeInterval)seconds
{
    [[SVProgressHUD sharedView] dismissWithStatus:string image:image afterDelay:seconds];
}

#pragma mark - ShowAndDismiss Methods
+(void)showAndDismissWithStatus:(NSString*)string
{
    [SVProgressHUD showAndDismissWithStatus:string image:nil];
}

+(void)showAndDismissWithStatus:(NSString*)string image:(UIImage*)image
{
    [SVProgressHUD showAndDismissWithStatus:string image:image duration:1.0];
}

+(void)showAndDismissWithStatus:(NSString*)string image:(UIImage*)image duration:(NSTimeInterval)duration
{
    [SVProgressHUD showWithInteraction];
    [SVProgressHUD dismissWithStatus:string image:image afterDelay:duration];
}




#pragma mark - Instance Methods

- (id)initWithFrame:(CGRect)frame {
	
    if ((self = [super initWithFrame:frame])) {
		self.userInteractionEnabled = NO;
        self.backgroundColor = [UIColor clearColor];
		self.alpha = 0;
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    }
	
    return self;
}

- (void)drawRect:(CGRect)rect {
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    switch (self.maskType) {
            
        case SVProgressHUDMaskTypeBlack: {
            [[UIColor colorWithWhite:0 alpha:0.5] set];
            CGContextFillRect(context, self.bounds);
            break;
        }
            
        case SVProgressHUDMaskTypeGradient: {
            
            size_t locationsCount = 2;
            CGFloat locations[2] = {0.0f, 1.0f};
            CGFloat colors[8] = {0.0f,0.0f,0.0f,0.0f,0.0f,0.0f,0.0f,0.75f}; 
            CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
            CGGradientRef gradient = CGGradientCreateWithColorComponents(colorSpace, colors, locations, locationsCount);
            CGColorSpaceRelease(colorSpace);
            
            CGPoint center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
            float radius = MIN(self.bounds.size.width , self.bounds.size.height) ;
            CGContextDrawRadialGradient (context, gradient, center, 0, center, radius, kCGGradientDrawsAfterEndLocation);
            CGGradientRelease(gradient);
            
            break;
        }
    }
}

- (void)setStatus:(NSString *)string {
    CGFloat hudWidth = 100;
    CGFloat hudHeight = 100;
    CGFloat stringWidth = 0;
    CGFloat stringHeight = 0;
    CGRect labelRect = CGRectZero;
    
    if(string) {
        
        CGSize stringSize = [string size:self.stringLabel.font constrainedToSize:CGSizeMake(200, 300)];;
        stringWidth = stringSize.width;
        stringHeight = stringSize.height;
        hudHeight = 80+stringHeight;
        
        if(stringWidth > hudWidth)
            hudWidth = ceil(stringWidth/2)*2;
        
        if(hudHeight > 100) {
            labelRect = CGRectMake(12, 66, hudWidth, stringHeight);
            hudWidth+=24;
        } else {
            hudWidth+=24;  
            labelRect = CGRectMake(0, 66, hudWidth, stringHeight);   
        }
    }
	
	self.hudView.bounds = CGRectMake(0, 0, hudWidth, hudHeight);
	
    if(string)
        self.imageView.center = CGPointMake(CGRectGetWidth(self.hudView.bounds)/2, 36);
	else
       	self.imageView.center = CGPointMake(CGRectGetWidth(self.hudView.bounds)/2, CGRectGetHeight(self.hudView.bounds)/2);
	
	self.stringLabel.hidden = NO;
	self.stringLabel.text = string;
	self.stringLabel.frame = labelRect;
	
	if(string)
		self.spinnerView.center = CGPointMake(ceil(CGRectGetWidth(self.hudView.bounds)/2)+0.5, 40.5);
	else
		self.spinnerView.center = CGPointMake(ceil(CGRectGetWidth(self.hudView.bounds)/2)+0.5, ceil(self.hudView.bounds.size.height/2)+0.5);
}


- (void)registerNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self 
                                             selector:@selector(positionHUD:) 
                                                 name:UIApplicationDidChangeStatusBarOrientationNotification 
                                               object:nil];  
    
    [[NSNotificationCenter defaultCenter] addObserver:self 
                                             selector:@selector(positionHUD:) 
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self 
                                             selector:@selector(positionHUD:) 
                                                 name:UIKeyboardDidHideNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self 
                                             selector:@selector(positionHUD:) 
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self 
                                             selector:@selector(positionHUD:) 
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
}


- (void)positionHUD:(NSNotification*)notification {
    
    CGFloat keyboardHeight;
    double animationDuration =0;
    
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    
    if(notification) {
        NSDictionary* keyboardInfo = [notification userInfo];
        CGRect keyboardFrame = [[keyboardInfo valueForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
        animationDuration = [[keyboardInfo valueForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
        
        if(notification.name == UIKeyboardWillShowNotification || notification.name == UIKeyboardDidShowNotification) {
            if(UIInterfaceOrientationIsPortrait(orientation))
                keyboardHeight = keyboardFrame.size.height;
            else
                keyboardHeight = keyboardFrame.size.width;
        } else
            keyboardHeight = 0;
    } else {
        keyboardHeight = self.visibleKeyboardHeight;
    }
    
    CGRect orientationFrame = [UIScreen mainScreen].bounds;
    CGRect statusBarFrame = [UIApplication sharedApplication].statusBarFrame;
    
    if(UIInterfaceOrientationIsLandscape(orientation)) {
        float temp = orientationFrame.size.width;
        orientationFrame.size.width = orientationFrame.size.height;
        orientationFrame.size.height = temp;
        
        temp = statusBarFrame.size.width;
        statusBarFrame.size.width = statusBarFrame.size.height;
        statusBarFrame.size.height = temp;
    }
    
    CGFloat activeHeight = orientationFrame.size.height;
    
    if(keyboardHeight > 0)
        activeHeight += statusBarFrame.size.height*2;
    
    activeHeight -= keyboardHeight;
    CGFloat posY = floor(activeHeight*0.45);
    CGFloat posX = orientationFrame.size.width/2;
    
    CGPoint newCenter;
    CGFloat rotateAngle;
    
    switch (orientation) { 
        case UIInterfaceOrientationPortraitUpsideDown:
            rotateAngle = M_PI; 
            newCenter = CGPointMake(posX, orientationFrame.size.height-posY);
            break;
        case UIInterfaceOrientationLandscapeLeft:
            rotateAngle = -M_PI/2.0f;
            newCenter = CGPointMake(posY, posX);
            break;
        case UIInterfaceOrientationLandscapeRight:
            rotateAngle = M_PI/2.0f;
            newCenter = CGPointMake(orientationFrame.size.height-posY, posX);
            break;
        default: // as UIInterfaceOrientationPortrait
            rotateAngle = 0.0;
            newCenter = CGPointMake(posX, posY);
            break;
    } 
    
    if(notification) {
        [UIView animateWithDuration:animationDuration 
                              delay:0 
                            options:UIViewAnimationOptionAllowUserInteraction 
                         animations:^{
                             [self moveToPoint:newCenter rotateAngle:rotateAngle];
                         } completion:NULL];
    } 
    
    else {
        [self moveToPoint:newCenter rotateAngle:rotateAngle];
    }
    
}

- (void)moveToPoint:(CGPoint)newCenter rotateAngle:(CGFloat)angle {
    self.hudView.transform = CGAffineTransformMakeRotation(angle); 
    self.hudView.center = newCenter;
}

#pragma mark - Master show/dismiss methods

- (void)showWithStatus:(NSString*)string maskType:(SVProgressHUDMaskType)hudMaskType networkIndicator:(BOOL)show {
    hintContext = string;
    dispatch_async(dispatch_get_main_queue(), ^{
        if(!self.superview)
            [self.overlayWindow addSubview:self];
        
        if (self.fadeOutTimer != nil)
            [self.fadeOutTimer invalidate];
        self.fadeOutTimer = nil;
        self.imageView.hidden = YES;
        self.maskType = hudMaskType;
        
        [self setStatus:string];
//        self.spinnerView.hidden = NO;
        [self.spinnerView startAnimating];
        
        if(self.maskType != SVProgressHUDMaskTypeNone) {
            self.overlayWindow.userInteractionEnabled = YES;
        } else {
            self.overlayWindow.userInteractionEnabled = NO;
        }
        
        //[self.overlayWindow makeKeyAndVisible];
        self.overlayWindow.hidden = NO;
        [self positionHUD:nil];
        
        if(self.alpha != 1) {
            [self registerNotifications];
            self.hudView.transform = CGAffineTransformScale(self.hudView.transform, 1.3, 1.3);
            
            [UIView animateWithDuration:0.15
                                  delay:0
                                options:UIViewAnimationOptionAllowUserInteraction | UIViewAnimationCurveEaseOut | UIViewAnimationOptionBeginFromCurrentState
                             animations:^{	
                                 self.hudView.transform = CGAffineTransformScale(self.hudView.transform, 1/1.3, 1/1.3);
                                 self.alpha = 1;
                             }
                             completion:NULL];
        }
        
        [self setNeedsDisplay];
    });
}



- (void)dismissWithStatus:(NSString *)string image:(UIImage *)image afterDelay:(NSTimeInterval)seconds
{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        if(self.alpha != 1)
            return;
        
        
        if (image == nil)
            self.imageView.hidden = YES;
        else
        {
            self.imageView.image = image;
            self.imageView.hidden = NO;
            
           // self.imageView.bounds = CGRectMake(0, 0, image.size.width, image.size.height);
        }
        
        [self setStatus:string];
        self.spinnerView.hidden = YES;
        
        if (self.fadeOutTimer != nil)
            [self.fadeOutTimer invalidate];
        self.fadeOutTimer = [NSTimer scheduledTimerWithTimeInterval:seconds target:self selector:@selector(dismiss) userInfo:nil repeats:NO];
    });
}

- (void)dismissSync
{
    [(NSNotificationCenter*)[NSNotificationCenter defaultCenter] removeObserver:self];
    [hudView removeFromSuperview];
    self.hudView = nil;
    overlayWindow = nil;
}

- (void)dismiss {
    self.hintContext = @"";
    dispatch_async(dispatch_get_main_queue(), ^{

        [UIView animateWithDuration:0.15
                              delay:0
                            options:UIViewAnimationCurveEaseIn | UIViewAnimationOptionAllowUserInteraction
                         animations:^{
                             self.hudView.transform = CGAffineTransformScale(self.hudView.transform, 0.8, 0.8);
                             self.alpha = 0;
                         }
                         completion:^(BOOL finished){
                             if(self.alpha == 0) {
                                 [(NSNotificationCenter*)[NSNotificationCenter defaultCenter] removeObserver:self];
                                 [hudView removeFromSuperview];
                                 self.hudView = nil;
                                 
                                 // Make sure to remove the overlay window from the list of windows
                                 // before trying to find the key window in that same list
                               //  NSArray *windows =[UIApplication sharedApplication].windows;
                                // [windows removeObject:overlayWindow];
                               
                                 overlayWindow = nil;
                                 
                                /* [windows enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(UIWindow *window, NSUInteger idx, BOOL *stop) {
                                   if([window isKindOfClass:[UIWindow class]] && window.windowLevel == UIWindowLevelNormal) {
                                     [window makeKeyWindow];
                                     *stop = YES;
                                   }
                                 }];*/
                                 
                                 // uncomment to make sure UIWindow is gone from app.windows
                                 //NSLog(@"%@", [UIApplication sharedApplication].windows);
                                 //NSLog(@"keyWindow = %@", [UIApplication sharedApplication].keyWindow);
                             }
                         }];
    });
}

#pragma mark - Utilities

+ (BOOL)isVisible {
    return ([SVProgressHUD sharedView].alpha == 1);
}


#pragma mark - Getters

- (UIWindow *)overlayWindow {
    if(!overlayWindow) {
        overlayWindow = [[SVProgressHUDWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        overlayWindow.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        overlayWindow.windowLevel = UIWindowLevelAlert - 100;
        overlayWindow.backgroundColor = [UIColor clearColor];
        overlayWindow.userInteractionEnabled = NO;
        
    }
    return overlayWindow;
}

- (UIView *)hudView {
    if(!hudView) {
        hudView = [[UIView alloc] initWithFrame:CGRectZero];
        hudView.layer.cornerRadius = 10;
     //   hudView.layer.shadowColor = [UIColor blackColor].CGColor;
     //   hudView.layer.shadowOffset = CGSizeMake(10.0, 1.0);
     //   hudView.layer.opacity = 0.8;
        //hudView.backgroundColor = [UIColor clearColor];//[UIColor colorWithWhite:10.0/255 alpha:0.8];
        hudView.backgroundColor = [UIColor colorWithWhite:10.0/255 alpha:0.5];
        hudView.autoresizingMask = (UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin |
                                    UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin);
        
        [self addSubview:hudView];
    }
    return hudView;
}

- (UILabel *)stringLabel {
    if (stringLabel == nil) {
        stringLabel = [[UILabel alloc] initWithFrame:CGRectZero];
		stringLabel.textColor = [UIColor whiteColor];
		stringLabel.backgroundColor = [UIColor clearColor];
		stringLabel.adjustsFontSizeToFitWidth = YES;
		stringLabel.textAlignment = NSTextAlignmentCenter;
		stringLabel.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
		stringLabel.font = [UIFont boldSystemFontOfSize:16];
		stringLabel.shadowColor = [UIColor blackColor];
		stringLabel.shadowOffset = CGSizeMake(0, -1);
        stringLabel.numberOfLines = 0;
    }
    
    if(!stringLabel.superview)
        [self.hudView addSubview:stringLabel];
    
    return stringLabel;
}

- (UIImageView *)imageView {
    if (imageView == nil)
        imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    
    if(!imageView.superview)
        [self.hudView addSubview:imageView];
    
    return imageView;
}

- (UIImageView *)spinnerView {
    if (spinnerView == nil) {
        spinnerView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        spinnerView.hidesWhenStopped = YES;
        spinnerView.bounds = CGRectMake(0, 0, 37, 37);
//        spinnerView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 37, 37)];
//        spinnerView.hidden = YES;
//        spinnerView.image = [UIImage imageNamed:@"loading"];
//        [spinnerView rotation:M_PI * 2.0 animationDuration:2.0 repeatCount:MAXFLOAT];
    }
    
    if(!spinnerView.superview)
        [self.hudView addSubview:spinnerView];
    
    return spinnerView;
}

- (CGFloat)visibleKeyboardHeight {
        
    UIWindow *keyboardWindow = nil;
    for (UIWindow *testWindow in [[UIApplication sharedApplication] windows]) {
        if(![[testWindow class] isEqual:[UIWindow class]]) {
            keyboardWindow = testWindow;
            break;
        }
    }

    // Locate UIKeyboard.  
    UIView *foundKeyboard = nil;
    for (UIView *possibleKeyboard in [keyboardWindow subviews]) {
        
        // iOS 4 sticks the UIKeyboard inside a UIPeripheralHostView.
        UIView *tempView =possibleKeyboard;
        if ([[tempView description] hasPrefix:@"<UIPeripheralHostView"]) {
            tempView = [[tempView subviews] objectAtIndex:0];
        }                                                                                
        
        if ([[tempView description] hasPrefix:@"<UIKeyboard"]) {
            foundKeyboard = tempView;
            break;
        }
    }
        
    if(foundKeyboard && foundKeyboard.bounds.size.height > 100)
        return foundKeyboard.bounds.size.height;
    
    return 0;
}

@end
