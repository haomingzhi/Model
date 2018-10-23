//
//  MyLineView.h
//  MiniClient
//
//  Created by apple on 15/2/12.
//  Copyright (c) 2015年 SunnadaSoft. All rights reserved.
//

#import <UIKit/UIKit.h>



//用于线性布局的子视图的属性，描述离兄弟视图的间隔距离，以及在父视图中的比重。
@interface UIView(LinearLayoutExtra)

@property(nonatomic, assign) CGFloat headMargin;  //距离前面兄弟视图的距离，这个用于线性布局
@property(nonatomic, assign) CGFloat tailMargin;  //距离后面兄弟视图的距离，这个用于线性布局
@property(nonatomic, assign) CGFloat weight;      //比重，用于占用父视图的比重。取值为>=0 <=1
//@property(nonatomic, assign)

@end


//排列的方向
typedef enum : NSUInteger {
    LVORIENTATION_VERT,
    LVORIENTATION_HORZ,
} LineViewOrientation;

/*
   线性视图，类似android的LinearLayout布局。支持2个方向。现在的版本要求子视图的位置或者是否隐藏改变后需要调用
   使用线性布局时里面的子视图的frame.origin.y是无效的，而是通过子视图的headMargin,tailMargin分别指出其距离他
   兄弟的距离以及weight用来表明他在父视图之中的比重。因此在xib上如果用MyLineView来进行布局则可能实际上显示的内容
   和真实的内容是不一致的。而且线性布局会因为子视图的大小和边距而调整自己的尺寸。因此线性布局比较适合通过代码的方式来
   构造视图。同时适合于将线性布局作为scrollview的子视图来布局。因为线性布局在位置调整后会
 */
@interface MyLinearLayout : UIView

//方向，默认是纵向的
@property(nonatomic,assign) LineViewOrientation orientation;

//如果线性布局的父视图是UIScrollView或者子类则在线性布局的位置调整后是否调整滚动视图的contentsize,默认是NO
//这个属性适合与整个线性布局作为滚动视图的唯一子视图来使用。
@property(nonatomic, assign, getter = isAdjustScrollViewContentSize) BOOL adjustScrollViewContentSize;

//是否调整自己的大小，默认是YES的.如果设置为NO的话则adjustScrollViewContentSize就没有实际的意思了。
@property(nonatomic, assign, getter =isAutoAdjustSize) BOOL autoAdjustSize;


//子视图是否在指定的方向居中。默认是NO.如果设置为YES的话则边缘视图的边距不起作用了，而且子视图的weight也不起作用了。而且不是调整自己的大小了
//也就是当垂直方向则所有子视图按顺序排列在中间。
@property(nonatomic, assign,getter = isCentreSubview) BOOL centreSubview;

@end
