//
//  UMPSpringBoardView.m
//
//  Created by oybq on 13-4-17.
//  Copyright (c) 2013年 Wuxi Smart Sencing Star. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "MySpringBoardView.h"
#import "MyGridItem.h"

#define SBITEM_MIN_WIDTH  44
#define SBITEM_MAX_WIDTH  150
#define SBITEM_LABEL_HEIGHT 30


@interface MySpringBoardView()

@property(nonatomic, assign) CGFloat horzGap;
@property(nonatomic, assign) CGSize itemSize;  //宽度，图标部分是正方形，再加上文字变成长方形, 文字部分按30来计算，有一个最小宽度是44
@property(nonatomic) NSMutableArray *gridItemViews;  //单元格视图数组
@property(nonatomic) UIScrollView *containerView;   //容器视图

@property(nonatomic, assign) MyGridItemView *movingItemView;  //编辑状态时当前移动的视图,如果为nil则表示没有移动的视图。
@property(nonatomic, assign) CGPoint lastMovedPoint;           //移动时上次移动到的位置。
@property(nonatomic, assign) BOOL isEditing; //是否是编辑状态。
@property(nonatomic) UITapGestureRecognizer *tapGesture;
@property(nonatomic) UILongPressGestureRecognizer *longPressGesture;


//构造
-(void)construct;

//取消移动视图的操作
-(void)cancelMovingItemView;

-(void)submitItemSelected:(UIButton *)sender;
-(void)submitItemRemoved:(UIButton *)sender;

@end



@interface MyGridItemView()

@property(nonatomic,strong) UIButton *removeBtn;  //删除按钮
@property(nonatomic, weak) MySpringBoardView *containerView;




@property(nonatomic, assign) BOOL isEditing;    //是否在编辑中。



//进入编辑状态
-(void)enableEditing;

//结束编辑状态
- (void) disableEditing;


@end

@implementation MyGridItemView


-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self != nil)
    {
        self.backgroundColor = [UIColor clearColor];
        self.isEditing = NO;
        self.clipsToBounds = YES;
        
        self.btn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.btn.adjustsImageWhenHighlighted = NO;
        self.btn.frame = self.bounds;
        [self.btn addTarget:self.containerView action:@selector(submitItemSelected:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.btn];
        
        _customView = nil;
        
    }
    
    return self;
}



-(void)setItem:(MyGridItem *)theItem
{
    
    _item = theItem;
    
    if (_item == nil)
        return;
    
    if (theItem.image != nil)
        [self.btn setImage: theItem.image forState:UIControlStateNormal];
   
    if (theItem.highlightedImage != nil)
        [self.btn setImage:theItem.highlightedImage forState:UIControlStateHighlighted];
    
    if (theItem.selectedImage != nil)
        [self.btn setImage:theItem.selectedImage forState:UIControlStateSelected];
    
    if (theItem.backgroundImage != nil)
        [self.btn setBackgroundImage:theItem.backgroundImage forState:UIControlStateNormal];
    if (theItem.backgroundHighlightedImage != nil)
        [self.btn setBackgroundImage:theItem.backgroundHighlightedImage forState:UIControlStateHighlighted];
    if (theItem.backgroundSelectedImage != nil)
        [self.btn setBackgroundImage:theItem.backgroundSelectedImage forState:UIControlStateSelected];
        
    if (theItem.titleColor != nil)
        [self.btn setTitleColor:theItem.titleColor forState:UIControlStateNormal];
    if (theItem.highlightedTitleColor != nil)
        [self.btn setTitleColor:theItem.highlightedTitleColor forState:UIControlStateHighlighted];
    
    if (theItem.selectedTitleColor != nil)
        [self.btn setTitleColor:theItem.selectedTitleColor forState:UIControlStateSelected];
    
    if (theItem.font != nil && self.btn.titleLabel != nil)
        self.btn.titleLabel.font = theItem.font;
    
    if (theItem.title != nil)
        [self.btn setTitle:theItem.title forState:UIControlStateNormal];
    
    [self.btn setButtonTitleStyle:theItem.style padding:theItem.padding];
    
    //如果条目可删除则添加删除按钮
    if (theItem.isRemovable)
    {
        //添加删除按钮
        if (self.removeBtn != nil)
            [self.removeBtn removeFromSuperview];
        self.removeBtn = nil;
        
        if (self.containerView.delegate != nil && [self.containerView.delegate respondsToSelector:@selector(removeImageOfSpringBoardView:)])
        {
            self.removeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [self.removeBtn addTarget:self.containerView action:@selector(submitItemRemoved:) forControlEvents:UIControlEventTouchUpInside];
            [self.removeBtn setImage:[self.containerView.delegate removeImageOfSpringBoardView:self.containerView] forState:UIControlStateNormal];
        }
        
        if (self.removeBtn != nil && self.containerView.delegate != nil && [self.containerView.delegate respondsToSelector:@selector(removeHighlightImageOfSpringBoardView:)])
        {
            [self.removeBtn setImage:[self.containerView.delegate removeHighlightImageOfSpringBoardView:self.containerView] forState:UIControlStateHighlighted];
        }
        
        if (self.removeBtn != nil)
        {
            self.removeBtn.frame = CGRectMake(0, 0, 30, 30);
            [self addSubview:self.removeBtn];
            self.removeBtn.hidden = YES;
        }
        
    }
    
    
   
    
}

-(void)layoutSubviews
{
    self.btn.frame = self.bounds;
    if (self.customView != nil)
        self.customView.frame = self.btn.frame;
}

-(void)enableEditing
{
    
     if (self.item == nil || !self.item.isEditable)
         return;
    
    if (self.isEditing)
        return;
    
    // put item in editing mode
    self.isEditing = YES;
    
    //如果有删除按钮则显示删除按钮
    if (self.removeBtn !=  nil)
    {
        [self.removeBtn setHidden:NO];
    }
    
    //编辑过程中不接收事件响应
    [self.btn setUserInteractionEnabled:NO];
    
    // start the wiggling animation
    CGFloat rotation = 0.03;
    
    CABasicAnimation *shake = [CABasicAnimation animationWithKeyPath:@"transform"];
    shake.duration = 0.13;
    shake.autoreverses = YES;
    shake.repeatCount  = MAXFLOAT;
    shake.removedOnCompletion = NO;
    shake.fromValue = [NSValue valueWithCATransform3D:CATransform3DRotate(self.layer.transform,-rotation, 0.0 ,0.0 ,1.0)];
    shake.toValue   = [NSValue valueWithCATransform3D:CATransform3DRotate(self.layer.transform, rotation, 0.0 ,0.0 ,1.0)];
    
    [self.layer addAnimation:shake forKey:@"shakeAnimation"];

}

- (void) disableEditing
{
    if (self.item == nil || !self.item.isEditable)
        return;
    
    if (!self.isEditing)
        return;

    self.isEditing = NO;
    
    //取消动画
    [self.layer removeAnimationForKey:@"shakeAnimation"];
    
    //隐藏删除按钮
    if (self.removeBtn != nil)
    {
        [self.removeBtn setHidden:YES];
    }
    
    [self.btn setUserInteractionEnabled:YES];
}

@end


@interface MySpringBoardViewScrollView : UIScrollView

@end

@implementation MySpringBoardViewScrollView


// called before scrolling begins if touches have already been delivered to a subview of the scroll view. if it returns NO the touches will continue to be delivered to the subview and scrolling will not occur
// not called if canCancelContentTouches is NO. default returns YES if view isn't a UIControl
- (BOOL)touchesShouldCancelInContentView:(UIView *)view
{

    return YES;
}


@end





@implementation MySpringBoardView




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




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

-(void)layoutSubviews
{
    //布局子视图。。。
    self.containerView.frame = self.bounds;
    NSInteger count = self.gridItemViews.count;
    
    if (self.refreshHeaderView != nil)
        self.refreshHeaderView.frame = CGRectMake(0, -1*self.containerView.bounds.size.height, self.containerView.bounds.size.width, self.containerView.bounds.size.height);
    
    
    CGSize size = self.containerView.bounds.size;
    
    if (self.countsPerRow == 1)
    {
        self.horzGap = 0;
       
    }
    else
    {
        self.horzGap = (size.width - self.contentInset.left - self.contentInset.right - self.countsPerRow * self.itemSize.width)/(self.countsPerRow - 1);
    }
    

    
    for (NSInteger i = 0; i < count; i++)
    {
        MyGridItemView *itemView = [self.gridItemViews objectAtIndex:i];
        
        CGPoint pt = [self pointFromIndex:i];
        itemView.frame = CGRectMake(pt.x,
                                    pt.y,
                                    self.itemSize.width,
                                    self.itemSize.height);
        
    }
    

  
    
    
    NSInteger rows = (count + self.countsPerRow - 1) / self.countsPerRow;
    CGSize contentSize = CGSizeMake(size.width, rows * self.itemSize.height + (rows - 1) * self.vertGap);
    
    if (self.refreshFooterView != nil && self.hasMore)
    {
        self.refreshFooterView.frame = CGRectMake(0, contentSize.height, size.width, self.refreshFooterView.frame.size.height);
        contentSize.height += self.refreshFooterView.frame.size.height;
    }
    
    //加上下面边距
    contentSize.height += self.contentInset.bottom;
    
    //如果支持下拉刷新则需要启动滚动条！！！
    if (self.refreshHeaderView != nil && contentSize.height <= self.containerView.bounds.size.height)
    {
        contentSize.height = self.containerView.bounds.size.height + 1;
    }
    
    self.containerView.contentSize = contentSize;
    
    if (self.noDataView != nil)
    {
        self.noDataView.center = self.containerView.center;
        
    }

    
}

#pragma mark -- public method

-(NSInteger)count
{
    return self.gridItemViews.count;
}

-(void)setSelectedItem:(NSInteger)selectedItem
{
    NSInteger oldSelected = _selectedItem;
    _selectedItem = selectedItem;
    
    if (oldSelected == _selectedItem)
        return;
    
    if (oldSelected != -1)
    {
        if (self.delegate != nil &&
            [self.delegate respondsToSelector:@selector(springBoardView:showItemView:atIndex:isSelected:)] &&
            self.gridItemViews.count > oldSelected
            )
        {
            [self.delegate springBoardView:self showItemView:[self.gridItemViews objectAtIndex:oldSelected] atIndex:oldSelected isSelected:NO];
        }
    }
    
    if (_selectedItem != -1)
    {
        if (self.delegate != nil &&
            [self.delegate respondsToSelector:@selector(springBoardView:showItemView:atIndex:isSelected:)] &&
            self.gridItemViews.count > _selectedItem)
        {
            [self.delegate springBoardView:self showItemView:[self.gridItemViews objectAtIndex:_selectedItem] atIndex:_selectedItem isSelected:YES];
            //[self scrollToRow:_selectedItem animated:TRUE]; commen by luolc @ 2014.9.25 再派单选号中发现闪退
        }
        
        if (self.delegate != nil && [self.delegate respondsToSelector:@selector(springBoardView:didSelectedAtIndex:)])
        {
            [self.delegate springBoardView:self didSelectedAtIndex:_selectedItem];
        }
        
    }
    
}


-(void)setRefreshHeaderView:(EGORefreshTableHeaderView *)refreshHeaderView
{
    if (_refreshHeaderView != nil)
    {
        [_refreshHeaderView removeFromSuperview];
    }

    _refreshHeaderView = refreshHeaderView;
    
    if (refreshHeaderView != nil)
    {
        [self.containerView addSubview:refreshHeaderView];
        [self setNeedsLayout];
    }
}

-(void)setRefreshFooterView:(EGORefreshTableFooterView *)refreshFooterView
{
    if (_refreshFooterView != nil)
    {
        [_refreshFooterView removeFromSuperview];
    }
    
    _refreshFooterView = refreshFooterView;
    
    if (_refreshFooterView != nil)
    {
        [self.containerView addSubview:_refreshFooterView];
        [self setNeedsLayout];
    }
}



-(void)setNoDataView:(UIView *)noDataView
{
    if (_noDataView != nil)
        [_noDataView removeFromSuperview];
    
    _noDataView = noDataView;
    
    if (noDataView != nil)
    {
        noDataView.center = self.containerView.center;
        [self.containerView addSubview:noDataView];
        noDataView.hidden = !_showNoDataView;
    }
}

-(void)setShowNoDataView:(BOOL)showNoDataView
{
    _showNoDataView = showNoDataView;
    
    if (self.noDataView != nil)
        self.noDataView.hidden = !_showNoDataView;
}

-(void)setHasMore:(BOOL)hasMore
{
    _hasMore = hasMore;
    
    if (self.refreshFooterView != nil)
    {
        [self.refreshFooterView resetState:NO];
        [self.refreshFooterView removeFromSuperview];
    }
    
    if (self.hasMore)
    {
        //添加屁股后面来。
        [self.containerView addSubview:self.refreshFooterView];
    }
    
    [self setNeedsLayout];
}

//重新装载数据
-(void)reloadData
{
    [self setSelectedItem:-1];
    //删除所有的子视图
    for (UIView *v in self.containerView.subviews)
    {
        [v removeFromSuperview];
    }
    if (self.refreshHeaderView != nil)
    {
        [self.containerView addSubview:self.refreshHeaderView];
        //这里设置状态！！！
    }
    
    if (self.refreshFooterView != nil)
    {
        [self.containerView addSubview:self.refreshFooterView];
    }
    
    [self removeGestureRecognizer:self.longPressGesture];
    [self removeGestureRecognizer:self.tapGesture];
    
    self.movingItemView = nil;
    [self enableEditing:NO];
    [self.gridItemViews removeAllObjects];
    
    self.itemSize = [self.dataSource itemViewSizeOfSpringBoardView:self];
    NSInteger count = [self.dataSource countOfSpringBoardView:self];
    
    if (self.selectedItem >= count)
        self.selectedItem = -1;
    
    if (count == 0)
    {
        self.containerView.contentSize = CGSizeZero;
        self.containerView.contentOffset = CGPointMake(0, 0);
        
    }
    else
    {
        BOOL canEdit = NO;
        for (int i = 0; i < count; i++)
        {
            MyGridItem *item = nil;
            
            //按每行4个来计算。
            MyGridItemView *itemView = [[MyGridItemView alloc] initWithFrame:CGRectMake(0,0,self.itemSize.width,self.itemSize.height)];
            itemView.containerView = self;
            
            if ([self.dataSource respondsToSelector:@selector(springBoardView:itemAtIndex:showItemView:)])
            {
                itemView.customView = [self.dataSource springBoardView:self itemAtIndex:i showItemView:itemView];
                [itemView addSubview:itemView.customView];
            }
            if (itemView.customView == NULL && [self.dataSource respondsToSelector:@selector(springBoardView:itemAtIndex:)]) {
                item = [self.dataSource springBoardView:self itemAtIndex:i];
            }
            
            itemView.item = item;
            
            if (item != nil && !canEdit)
                canEdit = item.isEditable;
            
            [self.gridItemViews addObject:itemView];
            [self.containerView addSubview:itemView];
        }
        
        if (canEdit)
        {
            [self addGestureRecognizer:self.longPressGesture];
            [self addGestureRecognizer:self.tapGesture];
        }
    }
    
    if (self.noDataView != nil)
    {
        [self.containerView addSubview:self.noDataView];
        self.noDataView.hidden = !self.showNoDataView;
    }
    
    [self setNeedsLayout];
}

-(void)enableEditing:(BOOL)enabled
{
    //如果状态相同则什么也不做
    if (self.isEditing == enabled)
        return;
    
    self.isEditing = enabled;
    
    if (self.tapGesture != nil)
        self.tapGesture.enabled = self.isEditing;
    
    for (MyGridItemView *itemView in self.gridItemViews)
    {
        if (self.movingItemView != itemView)
        {
            if (self.isEditing)
                [itemView enableEditing];
            else
                [itemView disableEditing];
        }
    }
    
}

-(MyGridItemView*)getItemView:(NSInteger)index
{
    if (self.count <= index)
        return nil;
    
    return [self.gridItemViews objectAtIndex:index];
}


#pragma mark -- private method

-(void)construct
{
    
    _isEditing = NO;
    _movingItemView = nil;
    _lastMovedPoint = CGPointZero;
    
    _layoutStyle = 0;  //垂直
    _vertGap = 12;
    _horzGap = 12;
    _itemSize = CGSizeMake(44, 44);
    _countsPerRow = 4;
    _contentInset = UIEdgeInsetsZero;
    _gridItemViews = [NSMutableArray array];
    _selectedItem = -1;
    //创建容器视图
    self.autoresizesSubviews = YES;
    _containerView = [[MySpringBoardViewScrollView alloc] initWithFrame:self.bounds];
    _containerView.backgroundColor = [UIColor clearColor];
    _containerView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _containerView.showsHorizontalScrollIndicator = false;
    _containerView.showsVerticalScrollIndicator = false;
    _containerView.delaysContentTouches = NO;
    _containerView.canCancelContentTouches = YES;
    _containerView.delegate = self;
    [self addSubview:_containerView];
    
    //处理长按
    self.longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(submitLongPress:)];
    
    //添加一个单击效果，在编辑时单击会取消编辑状态
    self.tapGesture =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(submitTap:)];
    self.tapGesture.enabled = NO;
    
    _showNoDataView = NO; //不显示
    
    _hasMore = NO;
    
    
}

-(void)cancelMovingItemView
{
    //如果没有移动的子视图则什么也不处理。
    if (self.movingItemView == nil)
        return;
    
    NSInteger fromIndex = [self.gridItemViews indexOfObject:self.movingItemView];
    CGPoint pt = [self pointFromIndex:fromIndex];
    self.movingItemView.btn.highlighted = NO;
    [UIView animateWithDuration:0.2 animations:^{
        
        self.movingItemView.transform = CGAffineTransformIdentity;
        
        self.movingItemView.frame = CGRectMake(pt.x,pt.y
                                               , self.movingItemView.frame.size.width, self.movingItemView.frame.size.height);
        
        
        
    }];
    
    //移动按钮恢复编辑状态
    [self.movingItemView enableEditing];
    self.movingItemView = nil;
    
}

-(CGPoint)pointFromIndex:(NSInteger)index
{
    //根据索引计算位置。
    
    //计算水平间隔和垂直间隔
    CGSize size = self.containerView.bounds.size;
    CGFloat leftStart = self.contentInset.left;
    CGFloat topStart = self.contentInset.top;
    if (self.countsPerRow == 1)
    {
        leftStart = self.contentInset.left + (size.width - self.contentInset.left - self.contentInset.right - self.itemSize.width)/2;
    }
    
    NSInteger col  = index % self.countsPerRow;
    NSInteger row  = index / self.countsPerRow;
    
    return CGPointMake(leftStart + col * (self.itemSize.width + self.horzGap),
                       topStart + row *(self.itemSize.height + self.vertGap));
}



#pragma mark-- UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if (self.refreshHeaderView != nil)
        [self.refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
    
    if (self.refreshFooterView != nil && self.hasMore)
        [self.refreshFooterView egoRefreshScrollViewDidScroll:scrollView];
    
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (self.refreshHeaderView != nil)
        [self.refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
    
    if (self.refreshFooterView != nil && self.hasMore)
        [self.refreshFooterView egoRefreshScrollViewDidEndDragging:scrollView];
    
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
/*    preX = scrollView.contentOffset.x;
    preFrame = backgoundImage.frame;
    NSLog(@"prex:%f",preX);*/
}

#pragma mark -- submit method

- (void) submitLongPress:(UILongPressGestureRecognizer *) gestureRecognizer{
    
    switch (gestureRecognizer.state) {
        case UIGestureRecognizerStateBegan:
        {
             NSLog(@"press long began");
            
            self.lastMovedPoint = [gestureRecognizer locationInView:self.containerView];
            
            //根据点击的位置得到要移动的子视图
            self.movingItemView = nil;
            for (int i = 0 ; i < self.gridItemViews.count; i++)
            {
                MyGridItemView *itemView = [self.gridItemViews objectAtIndex:i];
                if (itemView.item.isEditable && CGRectContainsPoint(itemView.frame, self.lastMovedPoint))
                {
                    self.movingItemView = itemView;
                    break;
                }
            }
            
            if (self.movingItemView != nil)
            {
                [self.movingItemView disableEditing];
                [self enableEditing:YES];
                
                //选中高亮并且扩大1.1倍
                self.movingItemView.btn.highlighted = YES;
                [self.containerView bringSubviewToFront:self.movingItemView];
                
                [UIView animateWithDuration:0.2 animations:^{
                    self.movingItemView.transform = CGAffineTransformMakeScale(1.2, 1.2);
                }];
            }
            
            
           
        }
            break;
        case UIGestureRecognizerStateEnded:
            
             NSLog(@"press long ended");
            [self cancelMovingItemView];
            break;
        case UIGestureRecognizerStateFailed:
            
            NSLog(@"press long failed");
            
            [self cancelMovingItemView];
            break;
        case UIGestureRecognizerStateChanged:
             NSLog(@"press long changed");
            
            if (self.movingItemView == nil)
                return;
            
            CGPoint point = [gestureRecognizer locationInView:self.containerView];
            CGPoint pointInView = [gestureRecognizer locationInView:self];
            
            CGRect frame = self.movingItemView.frame;
            frame.origin.x += point.x - self.lastMovedPoint.x;
            frame.origin.y += point.y - self.lastMovedPoint.y;
            self.lastMovedPoint = point;
            
            self.movingItemView.frame = frame;
            
            //根据坐标查找目标子视图的索引
            NSInteger toIndex = NSNotFound;
            for (int i = 0 ; i < self.gridItemViews.count; i++)
            {
                MyGridItemView *itemView = [self.gridItemViews objectAtIndex:i];
                if (itemView != self.movingItemView && itemView.item.isEditable && CGRectContainsPoint(itemView.frame, point))
                {
                    toIndex = i;
                    break;
                }
            }
            
            if (toIndex != NSNotFound)
            {
                //将目标子视图的位置，转化为移动子视图前面一个位置
                NSInteger fromIndex = [self.gridItemViews indexOfObject:self.movingItemView];
                CGPoint pt =  [self pointFromIndex:fromIndex];
                if (fromIndex != toIndex)
                {
                    [UIView animateWithDuration:0.2 animations:^{
                        
                        MyGridItemView *toItemView = [self.gridItemViews objectAtIndex:toIndex];
                        toItemView.frame = CGRectMake(pt.x,pt.y, self.itemSize.width, self.itemSize.height);
                        
                    }];
                    [self.gridItemViews exchangeObjectAtIndex:fromIndex withObjectAtIndex:toIndex];
                    
                    //执行移动操作。
                    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(springBoardView:didMovedFromIndex:toIndex:)])
                    {
                        [self.delegate springBoardView:self didMovedFromIndex:fromIndex toIndex:toIndex];
                    }
                    
                }
            }
            
            
            //翻页
            if (pointInView.y >= self.containerView.frame.size.height - 30) {
                [self.containerView scrollRectToVisible:CGRectMake(0, self.containerView.contentOffset.y + self.containerView.frame.size.height, self.containerView.frame.size.width, self.containerView.frame.size.height) animated:YES];
                
            }else if (pointInView.y < 30) {
                [self.containerView scrollRectToVisible:CGRectMake(0, self.containerView.contentOffset.y - self.containerView.frame.size.height, self.containerView.frame.size.width, self.containerView.frame.size.height) animated:YES];
            }
            
            break;
        default:
            NSLog(@"press long else");
            [self cancelMovingItemView];
            break;
    }
    
    //CABasicAnimation *scale = [CABasicAnimation animationWithKeyPath:@"transform"];
    
}

-(void)submitTap:(UITapGestureRecognizer *) gestureRecognizer{
    
    NSLog(@"sdsfd");
    
    if (!self.isEditing)
        return;
    
    //如果是在条目视图下单击则不处理。
    CGPoint point = [gestureRecognizer locationInView:self.containerView];
    for (int i = 0 ; i < self.gridItemViews.count; i++)
    {
        MyGridItemView *itemView = [self.gridItemViews objectAtIndex:i];
        if (CGRectContainsPoint(itemView.frame, point))
        {
            return;
        }
    }

    
    
    [self enableEditing:NO];
    
    
}



-(void)submitItemSelected:(UIButton *)sender
{
    MyGridItemView *itemView = (MyGridItemView*)sender.superview;
    NSInteger index = [self.gridItemViews indexOfObject:itemView];
    
    if (index == NSNotFound)
        return;
    
    self.selectedItem = index;
    
//    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(springBoardView:didSelectedAtIndex:)])
//    {
//        [self.delegate springBoardView:self didSelectedAtIndex:index];
//    }
    
}

-(void)submitItemRemoved:(UIButton *)sender
{
    MyGridItemView *itemView = (MyGridItemView*)sender.superview;
    NSInteger index = [self.gridItemViews indexOfObject:itemView];
    if (index == NSNotFound)
        return;
    
    //动态重新布局。
    
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(springBoardView:didRemovedAtIndex:)])
    {
        [self.delegate springBoardView:self didRemovedAtIndex:index];
    }

}


//滚动到指定行
-(void)scrollToRow:(NSInteger)index animated:(BOOL)aniated
{
    NSInteger contrainHeight = self.frame.size.height;
    NSInteger itemHeight = self.itemSize.height;
    BOOL isMustScroll = (contrainHeight / (itemHeight +self.vertGap)) * self.countsPerRow < (index +1);
    if (isMustScroll) {
        NSInteger row =  ((index + self.countsPerRow ) / self.countsPerRow);
        row = row ==0 ? row : row -1;
        CGPoint offset = CGPointMake(0,  self.contentInset.top+row * (self.itemSize.height + self.vertGap ) );
        [self.containerView setContentOffset:offset animated:aniated];
    }
}

@end
