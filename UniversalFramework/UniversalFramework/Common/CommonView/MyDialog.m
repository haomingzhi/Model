//
//  MyDialog.m
//  MiniClient
//
//  Created by apple on 14-7-10.
//  Copyright (c) 2014年 SunnadaSoft. All rights reserved.
//

#import "MyDialog.h"
#import "BSUtility.h"


@interface MyDialogWindow : UIWindow

@property(nonatomic,weak) MyDialog *dlg;
@property(nonatomic,strong) UITapGestureRecognizer *tap;
@end



@implementation UIViewController(MyDialog)


-(MyDialog*)parentDialog
{
    MyDialogWindow *dlgwin =  (MyDialogWindow*)self.view.window;
    if (![dlgwin isKindOfClass:[MyDialogWindow class]])
    {
        return nil;
    }

    return dlgwin.dlg;
}

@end

@interface MyDialog()

//@property(nonatomic) UIWindow *prevKeyWindow;
@property(nonatomic) MyDialogWindow *dialogWindow;
@property(nonatomic) MyDialog *myDialog;       //自己持有自己防止被释放

@end

@implementation MyDialog

-(id)initWithViewController:(UIViewController*)vc
{

    self = [self init];
    {
        _dialogWindow = [[MyDialogWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        _dialogWindow.dlg = self;
        _dialogWindow.windowLevel = UIWindowLevelNormal;
        _dialogWindow.rootViewController = vc;
        _dismissOnTouchOutside = NO;
        //        CALayer *maskLayer = [[CALayer alloc] init];
        //        maskLayer.frame = CGRectMake(0, 50, 320, 568);
        //            maskLayer.backgroundColor = [UIColor whiteColor].CGColor;//imageWithColor:[UIColor blackColor] withBounds:CGRectMake(0, 0, 300, 300)
        ////        maskLayer.contents = (id)[UIImage imageNamed:@"guide_tip"].CGImage;
        //        //    CALayer *layer = [[CALayer alloc] init];
        //        //    layer.frame = CGRectMake(0, 0, self.view.width, self.view.height);
        //        //    layer.mask = maskLayer;
        //        //    layer.masksToBounds = YES;
        //        //    layer.backgroundColor = [UIColor blackColor].blackColor;
        //        //    [self.view.layer addSublayer:layer];
        //        //    self.view.layer = layer;
        //        //    self.view.layer.mask = maskLayer;
        //        //    self.view.layer.masksToBounds = YES;
        //        _dialogWindow.layer.mask = maskLayer;
        //        _dialogWindow.layer.masksToBounds = YES;
    }

    return self;

}

-(void)setDismissOnTouchOutside:(BOOL)dismissOnTouchOutside
{
    if (dismissOnTouchOutside) {
        [_dialogWindow.tap setEnabled:YES];
    }
    else
    {
        [_dialogWindow.tap setEnabled:NO];
    }
    _dismissOnTouchOutside = dismissOnTouchOutside;
}
#pragma mark -- Public Method


-(void)show
{
    [self showAtPosition:CGPointZero];
}


-(void)showAtPosition:(CGPoint)pt
{
    [self showAtPosition:pt animated:YES];
}

-(void)showAtPosition:(CGPoint)pt animated:(BOOL)animated
{
    if ([self isShowing])
        return;

    self.myDialog = self;

    CGRect orgRect = self.dialogWindow.rootViewController.view.bounds;
    self.dialogWindow.hidden = NO;
    CGPoint tempPt=pt;
    if (CGPointEqualToPoint(pt, CGPointZero))
    {
        self.dialogWindow.rootViewController.view.bounds = orgRect;
        self.dialogWindow.rootViewController.view.center = self.dialogWindow.center;
        self.dialogWindow.rootViewController.view.transform = CGAffineTransformMakeScale(1.02,1.02);
        self.dialogWindow.rootViewController.view.alpha = 0.618;

        [UIView animateWithDuration:0.2 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{

            self.dialogWindow.rootViewController.view.transform = CGAffineTransformIdentity;
            self.dialogWindow.rootViewController.view.alpha = 1.0;
            self.dialogWindow.backgroundColor =  self.bgColor?:[UIColor colorWithWhite:0.0 alpha:0.3];

        } completion:^(BOOL finished){



        }];
    }
    else
    {
        //如果是控制器超出了最左边或者最右边则以0为标准或者最右边为标准。//从下往上。。

        if (animated) {
            //            if (pt.x - orgRect.size.width/2 < 0)
            //                //pt.x = orgRect.size.width/2;
            //
            //                if (pt.x + orgRect.size.width /2 > self.dialogWindow.bounds.size.width)
            //                    pt.x = self.dialogWindow.bounds.size.width - orgRect.size.width /2;
            //

            self.dialogWindow.rootViewController.view.frame = CGRectMake(tempPt.x , self.dialogWindow.bounds.size.height , [UIScreen mainScreen].bounds.size.width, orgRect.size.height);
            self.dialogWindow.backgroundColor = self.bgColor?:[UIColor colorWithWhite:0.0 alpha:0.3];
            [UIView animateWithDuration:0.4 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{

                self.dialogWindow.rootViewController.view.frame = CGRectMake(tempPt.x , pt.y,[UIScreen mainScreen].bounds.size.width, orgRect.size.height);
            } completion:^(BOOL finished){



            }];
        }
        else {
            if (pt.x - orgRect.size.width/2 < 0)
                pt.x = orgRect.size.width/2;


            self.dialogWindow.rootViewController.view.frame = CGRectMake(tempPt.x , self.dialogWindow.bounds.size.height, orgRect.size.width+20, orgRect.size.height);
            // self.dialogWindow.rootViewController.view.frame = CGRectMake(tempPt.x , tempPt.y, orgRect.size.width+10, orgRect.size.height);
            self.dialogWindow.backgroundColor = self.bgColor?:[UIColor colorWithWhite:0.0 alpha:0.3];

            if (pt.x + orgRect.size.width /2 > self.dialogWindow.bounds.size.width)
                pt.x = self.dialogWindow.bounds.size.width - orgRect.size.width /2;

            self.dialogWindow.rootViewController.view.frame = CGRectMake(pt.x - orgRect.size.width/2, pt.y, orgRect.size.width, orgRect.size.height);
        }




    }
}




//在某个视图下显示对话框，offset是视图正中间下面的偏移。
-(void)showUnderView:(UIView*)underView offset:(CGPoint)offset
{

    CGRect rect = [underView convertRect:underView.bounds toView:underView.window];
    CGPoint pt =  CGPointMake(CGRectGetMidX(rect)+offset.x, CGRectGetMaxY(rect) + offset.y);

    [self showAtPosition:pt animated:NO];
}

-(BOOL)isShowing
{
    return !self.dialogWindow.isHidden;
}

-(void)hide
{
    self.dialogWindow.hidden = YES;
}

-(void)dismiss
{
    if (self.isDownAnimate) {
        [self doDownAnimateDismiss:NO];
    }
    else
    {
        [self doDismiss:NO];
    }

}

-(void)cancel
{
    if (self.isDownAnimate) {
        [self doDownAnimateDismiss:NO];
    }
    else
    {
        [self doDismiss:NO];
    }
}

-(void)dealloc
{

}

#pragma mark -- Private Method

-(void)test:(NSNumber*)isCanceled
{

}

-(void)doDismiss:(BOOL)isCanceled
{
    [UIView animateWithDuration:0.3 animations:^{
        self.dialogWindow.alpha = 0;
    } completion:^(BOOL finished) {
        UIViewController *vc = self.dialogWindow.rootViewController;
        if (self.mydelegate != nil && [self.mydelegate respondsToSelector:@selector(dismissBy:withViewController:isCanceled:)])
        {
            [self.mydelegate dismissBy:self withViewController:vc isCanceled:isCanceled];
        }

        if (finished) {
            [self.dialogWindow removeFromSuperview];
            self.dialogWindow.rootViewController = nil;
            //        self.dialogWindow.hidden = YES;
            self.dialogWindow = nil;

            //UIWindow *prevWin = self.prevKeyWindow;
            //  self.prevKeyWindow = nil;
            self.myDialog = nil;
        }


        //  if (prevWin != nil)
        // {
        //  [prevWin makeKeyWindow];
        //  [prevWin setNeedsDisplay];
        //}
        //        NSArray *windows = [[UIApplication sharedApplication] windows];
        //        for (UIWindow *w in windows) {
        //            NSLog(@"%f",w.alpha);
        //        }

    }];
}

-(void)doDownAnimateDismiss:(BOOL)isCanceled
{
    //    UIViewController *vc = self.dialogWindow.rootViewController;

    [UIView animateWithDuration:0.3 animations:^{
        self.dialogWindow.alpha = 0;
        UIViewController *vc = self.dialogWindow.rootViewController;
        vc.view.transform = CGAffineTransformMakeTranslation(0, vc.view.height);
    } completion:^(BOOL finished) {
        if (finished) {

            UIViewController *vc = self.dialogWindow.rootViewController;
            //            [vc.view removeFromSuperview];
            vc.view.transform = CGAffineTransformMakeTranslation(0, 0);
            [self.dialogWindow removeFromSuperview];
            self.dialogWindow.rootViewController = nil;
            //        self.dialogWindow.hidden = YES;
            self.dialogWindow = nil;

            if (self.mydelegate != nil && [self.mydelegate respondsToSelector:@selector(dismissBy:withViewController:isCanceled:)])
            {
                [self.mydelegate dismissBy:self withViewController:vc isCanceled:isCanceled];
            }
            //
            //
            //        //UIWindow *prevWin = self.prevKeyWindow;
            //        //  self.prevKeyWindow = nil;
            self.myDialog = nil;

        }
        //  if (prevWin != nil)
        // {
        //  [prevWin makeKeyWindow];
        //  [prevWin setNeedsDisplay];
        //}
        //        NSArray *windows = [[UIApplication sharedApplication] windows];
        //        for (UIWindow *w in windows) {
        //            NSLog(@"%f",w.alpha);
        //        }

    }];
}


@end

@implementation MyDialogWindow
-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addGes];
    }
    return self;
}
-(void)addGes
{
    self.tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapHandle:)];
    [self addGestureRecognizer:self.tap];
    self.tap.enabled = NO;
}

-(void)tapHandle:(UITapGestureRecognizer *)tap
{
    if (self.dlg.dismissOnTouchOutside)
    {
        [self outsideHitHandle];
    }
}


//static int tostFlag = 0;

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    //    tostFlag += 1;
    //    if (!self.dlg.isDismissOnTouchOutSide)
    //        return [super hitTest:point withEvent:event];
    //#if 0
    //    for (UIWindow *w in [[UIApplication sharedApplication] windows]){
    //        NSLog(@"className = %@,frame=%@,windowlevel=%f,isKeyWindow=%@",NSStringFromClass([w class]) , [BSUtility rectToString: w.frame],w.windowLevel,w.isKeyWindow ? @"true":@"false");
    //    }
    //    NSLog(@"===========================");
    //
    //    for (UIWindow *w in [[UIApplication sharedApplication] windows]){
    //         NSLog(@"className = %@,frame=%@,windowlevel=%f,isKeyWindow=%@",NSStringFromClass([w class]) , [BSUtility rectToString: w.frame],w.windowLevel,w.isKeyWindow ? @"true":@"false");
    ////        int viewCount = [w.subviews count];
    ////        for (int i = 0; i < viewCount; i++)
    ////        {
    ////            [BSUtility displayViewDescription:[w.subviews objectAtIndex:i]];
    ////        }
    //    }
    //#endif

    CGRect f = self.rootViewController.view.frame;
    //    NSLog(@"f=%@,point = %@",[BSUtility rectToString:f],[BSUtility pointToString:point]);

    if (CGRectContainsPoint(f, point))//窗体内部
    {
        return [super hitTest:point withEvent:event];
        //        return nil;
    }
    else//窗体外部
    {
        //        if ([[UIDevice currentDevice].systemVersion floatValue] >= 9.0) {
        if (self.dlg.hasKeyboard) {
            if (CGRectContainsPoint(self.dlg.kbRect, point))
            {
                return  nil;
            }
        }

        UIView *v = [super hitTest:point withEvent:event];
        //        if (tostFlag % 2 == 0) {
        if ( v == self) {
            //           [self outsideHitHandle];
        }
        //        }

        //        }
        return v;
        //        return [super hitTest:point withEvent:event];
    }
}
//- (BOOL)pointInside:(CGPoint)point withEvent:(nullable UIEvent *)event
//{
//    return NO;
//}
-(void)outsideHitHandle
{
    if (self.dlg.outsideHitCallBack) {
        self.dlg.outsideHitCallBack(nil);
    }
    else{
        if (self.dlg.isDownAnimate) {
            [self.dlg doDownAnimateDismiss:YES];
        }
        else
        {
            [self.dlg doDismiss:YES];
        }
    }
}

-(void)dealloc
{
    [self removeGestureRecognizer:self.tap];
    self.tap = nil;
}


@end
