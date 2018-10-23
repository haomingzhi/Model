//
//  MyTabBar.m
//  SCWCYClient
//
//  Created by apple on 14-5-22.
//  Copyright (c) 2014年 SunnadaSoft. All rights reserved.
//

#import "MyTabBar.h"


#define MYTABBAR_PADDING 4  //内容的边距
#define MYTABBAR_IMAGE_HEIGHT 24   //图片的高度
#define MYTABBAR_IMAGE_WIDTH 30    //图片的宽度

@interface MyTabBar()

-(void)construct;

@end


@implementation MyTabBar
{
 NSMutableArray *_itemViews;
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self construct];
    }
    return self;
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    [self construct];

}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    
    
    
}

#pragma mark -- Public Method
-(NSInteger)count
{
    return _itemViews.count;
}

-(void)setCurrentItem:(NSInteger)currentItem
{
    if (_currentItem == currentItem)
        return;
    
    //把前面一个设置为正常状态。
    if (_currentItem != -1)
    {
        UIView *itemContainerView = [_itemViews objectAtIndex:_currentItem];
        UIButton *itemButton = (UIButton*)[itemContainerView.subviews objectAtIndex:0];
        itemButton.selected = NO;
    }
    
    _currentItem = currentItem;
    
    if (_currentItem != -1)
    {
        UIView *itemContainerView = [_itemViews objectAtIndex:_currentItem];
        UIButton *itemButton = (UIButton*)[itemContainerView.subviews objectAtIndex:0];
        itemButton.selected = YES;
        
        if (_delegate !=  nil && [_delegate respondsToSelector:@selector(myTabBar:itemSelected:)])
        {
            [_delegate myTabBar:self itemSelected:_currentItem];
        }
    }
    
}


-(NSInteger)addItem:(NSString*)text normalImage:(UIImage*)normalImage highlightImage:(UIImage*)highlightImage
{
    
    
    
    //添加一个视图并添加一个按钮
    UIView *itemContainerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, 1)];
    itemContainerView.autoresizesSubviews = YES;
    itemContainerView.userInteractionEnabled = YES;
    itemContainerView.backgroundColor = [UIColor clearColor];
    itemContainerView.clipsToBounds = YES;
    
    //创建一个按钮
    UIButton *itemButton = [UIButton buttonWithType:UIButtonTypeCustom];
    itemButton.adjustsImageWhenHighlighted = NO;
    itemButton.frame = itemContainerView.bounds;
    itemButton.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin |
    UIViewAutoresizingFlexibleWidth |
    UIViewAutoresizingFlexibleRightMargin |
    UIViewAutoresizingFlexibleTopMargin |
    UIViewAutoresizingFlexibleHeight |
    UIViewAutoresizingFlexibleBottomMargin;
    [itemButton setTitle:text forState:UIControlStateNormal];
    [itemButton setImage:normalImage forState:UIControlStateNormal];
    [itemButton setImage:highlightImage forState:UIControlStateHighlighted];
    [itemButton setImage:highlightImage forState:UIControlStateSelected];
    itemButton.imageView.bounds = CGRectMake(0, 0, 30, 24);
    [itemButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [itemButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [itemButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    
    
   
    itemButton.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:13];
    
    [itemButton setTag:self.count + 1];
    [itemButton addTarget:self action:@selector(handleClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [itemContainerView addSubview:itemButton];
    
    [_itemViews addObject:itemContainerView];
    
    [self addSubview:itemContainerView];
    
    //创建一个视图。每次添加一个调整视图的宽度。调整布局
    [self setNeedsLayout];
    
    return _itemViews.count - 1;
    
}

-(void)setItem:(NSInteger)itemIndex badgeImage:(UIImage*)badgeImage
{
    if (itemIndex >= 0 && itemIndex < _itemViews.count)
    {
        
        UIView *itemContainerView = [_itemViews objectAtIndex:itemIndex];
        UIImageView *imgV = (UIImageView*)[itemContainerView viewWithTag:2014729];
        if (imgV == nil)
        {
            if (badgeImage != nil)
            {
                imgV = [[UIImageView alloc] initWithImage:badgeImage];
                imgV.tag = 2014729;
                [itemContainerView addSubview:imgV];
            }
        }
        else
        {
            if (badgeImage == nil)
            {
                [imgV removeFromSuperview];
                imgV = nil;
            }
            else
                imgV.image = badgeImage;
        }
        
        if (imgV != nil)
        {
          //  imgV.bounds =  CGRectMake(0, 0, badgeImage.size.width / 2,badgeImage.size.height/2);
            imgV.center = CGPointMake(itemContainerView.bounds.size.width - 10, 10);
        }
        
    }
}


#pragma mark -- Overwrite Method

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    //如果没有则什么也不做
    if (self.count == 0)
        return;
    
    //重新布局
    //得到当前的数量，然后再计算视图的宽度
    CGFloat itemWidth = self.bounds.size.width / self.count;
    CGFloat itemHeight = self.bounds.size.height;
    
    CGFloat startX = 0;
    for (UIView *v in self.subviews)
    {
        v.frame = CGRectMake(startX, 0, itemWidth, itemHeight);
        startX += itemWidth;
        
         UIButton *itemButton = (UIButton*)[v.subviews objectAtIndex:0];
        
        if (v.subviews.count > 1)
        {
            UIImageView *imgv = [v.subviews objectAtIndex:1];
            imgv.center = CGPointMake(v.bounds.size.width - 10, 10);
        }
        
        [itemButton setButtonTitleStyle:ButtonTitleStyleBottom padding:3];
    }
    
}


#pragma mark -- Handle Method
-(void)handleClick:(UIButton*)button
{
    NSInteger item = button.tag - 1;
    self.currentItem = item;
}



#pragma mark -- Private Method

-(void)construct
{
    _currentItem = -1;
    _itemViews = [[NSMutableArray alloc] init];
    
}

@end
