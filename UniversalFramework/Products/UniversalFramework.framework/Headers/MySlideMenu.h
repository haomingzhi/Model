//
//  ViewController.h
//  MySlideMenu
//
//  Created by apple on 14-10-10.
//  Copyright (c) 2014年 SunnadaSoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MySlideMenu;

//滑动菜单协议
@protocol MySlideMenuDelegate <NSObject>

//当左边滑动时
@optional
-(void)slideMenu:(MySlideMenu*)slideMenu leftViewControllerWillPresent:(UIViewController*)leftVC;
-(void)slideMenu:(MySlideMenu*)slideMenu leftViewControllerDidPresent:(UIViewController *)leftVC;
-(void)slideMenu:(MySlideMenu*)slideMenu leftViewControllerWillHidden:(UIViewController*)leftVC;
-(void)slideMenu:(MySlideMenu*)slideMenu leftViewControllerDidHidden:(UIViewController *)leftVC;

-(void)slideMenu:(MySlideMenu*)slideMenu rightViewControllerWillPresent:(UIViewController*)rightVC;
-(void)slideMenu:(MySlideMenu*)slideMenu rightViewControllerDidPresent:(UIViewController *)rightVC;
-(void)slideMenu:(MySlideMenu*)slideMenu rightViewControllerWillHidden:(UIViewController*)rightVC;
-(void)slideMenu:(MySlideMenu*)slideMenu rightViewControllerDidHidden:(UIViewController *)rightVC;

/**
 * 点击了左滑动视图或者右滑动视图的某一个选项
 */
-(void)slideMenu:(MySlideMenu*)slideMenu SideDisplayed:(UIViewController *) vc ViewTag:(NSInteger)tag;

//不考虑左右只考虑边缘将要展示和收起
-(void)slideMenuWillPresent:(MySlideMenu*)slideMenu;
-(void)slideMenuDidPresent:(MySlideMenu*)slideMenu;
-(void)slideMenuWillHidden:(MySlideMenu*)slideMenu;
-(void)slideMenuDidHidden:(MySlideMenu*)slideMenu;



@end

//滑动菜单控制器的状态
enum MYSLIDEMENU_STATUS {
  SLIDEMENU_NORMAL = 0,
  SLIDEMENU_LEFTPRESENT = 1,
  SLIDEMENU_RIGHTPRESENT = 2
};

//滑动菜单控制器可以滑动的方向，主要是用于手势控制。
enum MYSLIDEMENU_DIRECTION {
    SLIDEMENU_FREEZING = 0,    //不能滑动
    SLIDEMENU_LEFTDIRECTION = 1,   //向左滑动
    SLIDEMENU_RIGHTDIRECTION = 2,   //向右滑动
    SLIDEMENU_DOUBLEDIRECTION = 3   //双向滑动。
    };


//滑动菜单的样式,分为缩放式和覆盖式
enum MYSLIDEMENU_STYLE{
    
    SLIDEMENU_SCALESTYLE = 0,  //缩放式
    SLIDEMENU_COVERSTYLE = 1    //覆盖式
};


@interface MySlideMenu : UIViewController

//三个位置的视图控制器。
@property(nonatomic,strong) UIViewController *centerVC;
@property(nonatomic, strong) UIViewController *leftVC;
@property(nonatomic, strong) UIViewController *rightVC;

@property(nonatomic, readonly) NSInteger status;   //状态： 正常，左边滑出，右边滑出

@property(nonatomic) NSInteger style;      //设置滑动时的样式。默认为SLIDEMENU_SCALESTYLE 属性只能在状态为SLIDEMENU_NORMAL是才设置有效


//左滑手势和右滑手势，用户可以增加到要添加的中间视图控制器中去,如果没有设置则中间视图上滑动时不会有效果
//@property(nonatomic,readonly) UIPanGestureRecognizer *leftPanGesture;    //左滑出现右边视图
//@property(nonatomic, readonly) UIPanGestureRecognizer *rightPanGesture;  //右滑出现左边视图


@property(nonatomic, weak) id<MySlideMenuDelegate> delegate;


-(id)initWithCenterVC:(UIViewController*)centerVC
               leftVC:(UIViewController*)leftVC
              rightVC:(UIViewController*)rightVC;


//显示和隐藏左边
-(void)presentLeft;
-(void)hideLeft;

//显示和隐藏右边
-(void)presentRight;
-(void)presentRightSpecifityWidth:(NSInteger)width;
-(void)hideRight;

//恢复显示中间。
-(void)presentCenter;

//设置某个中间视图控制器可以滑动的方向, 菜单不会持有viewController的引用，因此
//可以手动设置viewController的方向为SLIDEMENU_FREEZING来取消滑动，或者不用管他，系统在销毁或者
//没有视图装载时是自动会销毁掉的。
-(void)setSlidable:(UIViewController*)viewController direction:(int)direction;


//保存滑动菜单栈。也就是保护中间，左边，右边，和样式
-(void)saveSlideStack;

//恢复滑动菜单栈，恢复中间，左边，右边和样式， 注意保存和恢复必须要成对的调用，否则有可能出现异常的状态。
-(BOOL)restoreSlideStack;


/**
 * 点击了左滑动视图或者右滑动视图的某一个选项
 */
- (void)touchOnDisplay:(UIViewController *) displayVc ViewTag:(NSInteger)tag;

@end


@interface UIViewController(MySlideMenuExtra)

-(MySlideMenu*)slideMenu;

@end


