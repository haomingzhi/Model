//
//  MyMessageBox.m
//  MyTest13
//
//  Created by oybq on 11-4-13.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MyMessageBox.h"


@interface MyMessageBox()<UIAlertViewDelegate,UIActionSheetDelegate>

@property(nonatomic,copy) void(^completion)(NSInteger index);

@end


@implementation MyMessageBox
{
MyMessageBox *_myMessageBox;  //用于自己持有自己保证不会被销毁！！！
}

+msgBox
{
	return [[MyMessageBox alloc] init];
}

-(void)dismiss:(UIAlertView*)alertView
{
    
	[alertView dismissWithClickedButtonIndex:0 animated:NO];  //带动画会奔溃
    _myMessageBox = nil;
}


-(void)dealloc
{
    
}

#pragma mark -- UIAlertView



-(void)show:(NSString *)title message:(NSString *)message until:(NSTimeInterval)sec
{
	UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
	[alertView show];
	[self performSelector:@selector(dismiss:) withObject:alertView afterDelay:sec];
    _myMessageBox = self;
	
}


-(void)show:(NSString*)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles completion:(void (^)(NSInteger index))completion
{
    [self show:title message:message cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtonTitles withCustom:nil completion:completion];
}

-(void)show:(NSString*)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles withCustom:(NSInvocation*)custom completion:(void (^)(NSInteger index))completion
{
	/*
	if (otherButtonTitles == nil)
	{
		UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtonTitles, nil];
		[alertView show];
		return;
	}*/
	
	UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtonTitles, nil];
	
    if (custom != nil)
    {
    	 NSMethodSignature *sig = [custom methodSignature];
	    [custom setArgument:&alertView atIndex:[sig numberOfArguments] - 1];
	    [custom invoke];
	}
    
	[alertView show];
   
	
    self.completion = completion;
    _myMessageBox = self;
    
}

- (void)willPresentAlertView:(UIAlertView *)alertView
{
    // 只在定时显示里面,在显示前把size的高度设置小一点。。
    if (alertView.numberOfButtons == 0)
    {
        if (alertView.subviews.count > 2)
        {
            UIView * messageView = [alertView.subviews objectAtIndex:2];
            messageView.transform = CGAffineTransformMakeTranslation(0, 25);
        }
        
    }
    
}


- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (self.completion != nil)
    {
        _completion(buttonIndex);
    }
    
    _myMessageBox = nil;  //释放自己！！！
}


#pragma mark -- UIActionSheet

- (UIActionSheet*)createActionSheetWithStyle:(UIActionSheetStyle)style title:(NSString*)title cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle buttons:(NSArray*)buttons completion:(void (^)(NSInteger index))completion
{
    
    int count = 0;
    
    NSMutableArray *titleArray = [NSMutableArray array];
    
    if (destructiveButtonTitle != nil)
    {
        [titleArray addObject:destructiveButtonTitle];
        count = 1;
    }
    
    if (buttons != nil)
    {
        [titleArray  addObjectsFromArray:buttons];
        count += buttons.count;
    }
    
    
    if (cancelButtonTitle != nil)
        [titleArray addObject:cancelButtonTitle];
    
    
	UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:title delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil];
	actionSheet.actionSheetStyle = style;
	
    
    for (NSString *button in titleArray)
    {
        [actionSheet addButtonWithTitle:button];
    }
    
    if (destructiveButtonTitle != nil)
        actionSheet.destructiveButtonIndex = 0;
    
    
    if (cancelButtonTitle != nil)
        actionSheet.cancelButtonIndex = count;
    
    
    self.completion = completion;
    _myMessageBox = self;
    
    return actionSheet;
}


- (void)showFromToolbar:(UIToolbar *)view withStyle:(UIActionSheetStyle)style title:(NSString*)title cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle buttons:(NSArray*)buttons completion:(void (^)(NSInteger index))completion
{
     UIActionSheet *actionSheet = [self createActionSheetWithStyle:style title:title cancelButtonTitle:cancelButtonTitle destructiveButtonTitle:destructiveButtonTitle buttons:buttons completion:completion];
    [actionSheet showFromToolbar:view];
}

- (void)showFromTabBar:(UITabBar *)view withStyle:(UIActionSheetStyle)style title:(NSString*)title cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle buttons:(NSArray*)buttons completion:(void (^)(NSInteger index))completion
{
		//显示
    UIActionSheet *actionSheet = [self createActionSheetWithStyle:style title:title cancelButtonTitle:cancelButtonTitle destructiveButtonTitle:destructiveButtonTitle buttons:buttons completion:completion];
	[actionSheet showFromTabBar:view];
}

- (void)showFromBarButtonItem:(UIBarButtonItem *)item animated:(BOOL)animated withStyle:(UIActionSheetStyle)style title:(NSString*)title cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle buttons:(NSArray*)buttons completion:(void (^)(NSInteger index))completion
{
    //显示
    UIActionSheet *actionSheet = [self createActionSheetWithStyle:style title:title cancelButtonTitle:cancelButtonTitle destructiveButtonTitle:destructiveButtonTitle buttons:buttons completion:completion];
	[actionSheet showFromBarButtonItem:item animated:animated];
}

- (void)showFromRect:(CGRect)rect inView:(UIView *)view animated:(BOOL)animated withStyle:(UIActionSheetStyle)style title:(NSString*)title cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle buttons:(NSArray*)buttons completion:(void (^)(NSInteger index))completion
{

    UIActionSheet *actionSheet = [self createActionSheetWithStyle:style title:title cancelButtonTitle:cancelButtonTitle destructiveButtonTitle:destructiveButtonTitle buttons:buttons completion:completion];
	[actionSheet showFromRect:rect inView:view animated:animated];
}

-(void)showInView:(UIView *)inView withStyle:(UIActionSheetStyle)style title:(NSString*)title cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle buttons:(NSArray*)buttons completion:(void (^)(NSInteger index))completion
{
    UIActionSheet *actionSheet = [self createActionSheetWithStyle:style title:title cancelButtonTitle:cancelButtonTitle destructiveButtonTitle:destructiveButtonTitle buttons:buttons completion:completion];
    [actionSheet showInView:inView];
}


- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    
    if (self.completion != nil)
    {
        _completion(buttonIndex);
    }
    
    _myMessageBox = nil;
}

- (void)actionSheetCancel:(UIActionSheet *)actionSheet
{
    if (self.completion != nil)
    {
        _completion(-1);
    }
    
    _myMessageBox = nil;
}

- (void)willPresentActionSheet:(UIActionSheet *)actionSheet
{
    //这里可以设置标题字体的大小。。。。。
}

@end
