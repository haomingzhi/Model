//
//  MyPopupViewController.h
//  MiniClient
//
//  Created by apple on 14-7-24.
//  Copyright (c) 2014年 SunnadaSoft. All rights reserved.
//

#import <UIKit/UIKit.h>

/*泡泡框控制器，处理一些弹出单项列表选择的对话框*/
@interface MyPopoverController : NSObject

//如果是未选中则是NSNotFound
+(id)popoverWithArray:(NSArray*)items selectedIndex:(NSInteger)selectedIndex;

//设置内容的大小，必须在show之前调用，这里返回对象本身
-(void)setContentSize:(CGSize)size;

//居中显示
-(void)show:(void(^)(NSInteger selected))completed;

//在某个视图下显示对话框，yOffset是视图的垂直偏移。
-(void)showUnderView:(UIView*)underView offset:(CGPoint)offset completed:(void(^)(NSInteger selected))completed;

@end
