//
//  MyPageView.m
//  MiniClient
//
//  Created by apple on 14-7-13.
//  Copyright (c) 2014年 SunnadaSoft. All rights reserved.
//

#import "MyPageView.h"

//@implementation MyPageController
//
//- (void)setPageControlStyle:(PageControlStyle)style
//{
//    _pageControlStyle = style;
//    [self setNeedsDisplay];
//}
//
//- (void)drawRect:(CGRect)rect
//{
//    NSLog(@"drawrect");
//    if (self.pageControlStyle == PageControlStyleDefault) {
//        return [super drawRect:rect];
//    }
////    // Drawing code
////    if (self.hidesForSinglePage && self.numberOfPages==1)
////	{
////		return;
////	}
////	
////	//CGContextRef myContext = UIGraphicsGetCurrentContext();
////	
////	int gap = self.gapWidth;
////    float length = self.diameter;// - 2*self._strokeWidth;
////    
////    if (self.pageControlStyle==PageControlStyleThumb)
////    {
////        if (self.thumbImage && self.selectedThumbImage)
////        {
////            length = self.thumbImage.size.width;
////        }
////    }
////	
////	int total_width = self.numberOfPages*_diameter + (self.numberOfPages-1)*gap;
////	
////	if (total_width>self.frame.size.width)
////	{
////		while (total_width>self.frame.size.width)
////		{
////			_diameter -= 2;
////			gap = _diameter + 2;
////			while (total_width>self.frame.size.width)
////			{
////				gap -= 1;
////				total_width = self.numberOfPages*_diameter + (self.numberOfPages-1)*gap;
////				
////				if (gap==2)
////				{
////					break;
////					total_width = self.numberOfPages*_diameter + (self.numberOfPages-1)*gap;
////				}
////			}
////			
////			if (_diameter==2)
////			{
////				break;
////				total_width = self.numberOfPages*_diameter + (self.numberOfPages-1)*gap;
////			}
////		}
////		
////		
////	}
////	
////	int i;
////	for (i=0; i<self.numberOfPages; i++)
////	{
////		int x = (self.frame.size.width-total_width)/2 + i*(_diameter+gap);
////        
////        if (self.pageControlStyle==PageControlStyleThumb)
////        {
////            if (self.thumbImage && self.selectedThumbImage)
////            {
////                if (i==self.currentPage)
////                {
////                    [self.selectedThumbImage drawInRect:CGRectMake(x,(self.frame.size.height-_diameter)/2,_diameter,_diameter)];
////                }
////                else
////                {
////                    [self.thumbImage drawInRect:CGRectMake(x,(self.frame.size.height-_diameter)/2,_diameter,_diameter)];
////                }
////            }
////        }
////	}
//}
//
//-(void)setCurrentPage:(NSInteger)currentPage
//{
//    [super setCurrentPage:currentPage];
//    [self setNeedsDisplay];
//    
//    
//}
//@end


@interface MyPageView()<UIScrollViewDelegate>


@property(nonatomic, strong) NSMutableArray *pages;  //页数
@property(nonatomic, assign) BOOL isScroll;  //判断是否可以滚动


-(void)construct;

@end

@implementation MyPageView
{
    NSInteger from,to;
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

-(void)setScrollEnabled:(BOOL)b
{
    _scrollView.scrollEnabled = b;
}

-(void)construct
{
    _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    _scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _scrollView.delegate = self;
    _scrollView.pagingEnabled = YES;
    _scrollView.directionalLockEnabled = YES;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.bounces = NO;
    [_scrollView autoresizesSubviews];
    [self addSubview:_scrollView];
    
    
    _pages = [[NSMutableArray alloc] init];
    
    _currentPageIndex = 0;
    _cycle = NO;
    _showPageController = YES;
    //为滚动条添加一个单击触摸事件。
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    [_scrollView addGestureRecognizer:tap];
    
    //为滚动条添加一个双击触摸事件
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap:)];
    doubleTap.numberOfTapsRequired =2;
    [_scrollView addGestureRecognizer:doubleTap];

    _isScroll = YES;

}


-(void) handleDoubleTap:(UITapGestureRecognizer*)gesture
{
    //只要是点击就把
    if (_currentPageIndex != -1 &&
        !self.scrollView.isDragging &&
        !self.scrollView.isDecelerating)
    {
        if ([self.delegate respondsToSelector:@selector(pageView:didDoubleClick:)])
        {
            [self.delegate pageView:self didDoubleClick:_currentPageIndex];
        }
    }
}


//单击手势
-(void)handleTap:(UITapGestureRecognizer*)gesture
{
    //只要是点击就把
    if (_currentPageIndex != -1 &&
        !self.scrollView.isDragging &&
        !self.scrollView.isDecelerating)
    {
        if ([self.delegate respondsToSelector:@selector(pageView:didSelected:)])
            [self.delegate pageView:self didSelected:_currentPageIndex];
    }
    
}


-(void)setCurrentPageIndex:(NSInteger)currentPageIndex
{
//    if (currentPageIndex >= self.count)
//        return;
//    if (currentPageIndex < 0)
//        return;
//    
//    //if (_currentPageIndex != currentPageIndex)
//    {
//        _currentPageIndex = currentPageIndex;
//        self.scrollView.contentOffset = CGPointMake((_currentPageIndex + ((int)(self.cycle && self.count > 1)))*self.scrollView.bounds.size.width, 0);
//    }
    [self setCurrentPageIndex:currentPageIndex animated:YES];
}

-(NSInteger)count
{

    if (self.pages.count ==0 || (self.delegate !=  nil && [self.delegate respondsToSelector:@selector(countOfPageView:)]))
    {
        NSInteger totalCount = [self.delegate countOfPageView:self];
        if (self.showPageController && self.pageController != NULL) {
            self.pageController.numberOfPages = totalCount;
        }
        return totalCount;
    }
    
    return self.pages.count;
}


#pragma mark -- Public Method

-(void)reloadData
{
    //。。。
    
    //销毁前面的数据。。
    for (UIView *v in self.pages)
    {
        if (v != (UIView*)[NSNull null])
        {
            [v removeFromSuperview];
        }
    }
    
    [self.pages removeAllObjects];
    

    NSInteger c = self.count;
    if (c ==0) {
        return;
    }
    for (int i = 0; i < c; i++)
    {
        [self.pages addObject:[NSNull null]];
    }

    
    //重新设置里面的内容的长度。。
    if (c > 1 && self.cycle)
    {
        CGSize size = CGSizeMake((c + 2)* __SCREEN_SIZE.width, self.scrollView.frame.size.height);
        self.scrollView.contentSize = size;
        //self.scrollView.contentOffset = CGPointMake(self.scrollView.frame.size.width, 0);
    }
    else
    {
        CGSize size = CGSizeMake(c * __SCREEN_SIZE.width, self.scrollView.frame.size.height);
        self.scrollView.contentSize = size;
        //self.scrollView.contentOffset = CGPointMake(0, 0);
    }
    
    
    if (_currentPageIndex >= c)
        _currentPageIndex = c - 1;
    
    if (c > 0 && _currentPageIndex == -1)
        _currentPageIndex = 0;
    
    if ( c != 0)
    {
        for (int i =0;  i < c; i++) {
            UIView *vv = [self.delegate pageView:self pageFromIndex:i];
            vv.frame = CGRectMake(self.cycle && c >1 ?  (i + 1) * __SCREEN_SIZE.width : i * __SCREEN_SIZE.width, 0, __SCREEN_SIZE.width, self.scrollView.bounds.size.height);
            [self.scrollView addSubview:vv];
            [self.pages replaceObjectAtIndex:i withObject:vv];
        }
        
        //填充当前的视图。
        if (c > 1 && self.cycle)
        {
            self.isScroll = NO;
            self.scrollView.contentOffset = CGPointMake((_currentPageIndex + 1)*__SCREEN_SIZE.width, 0);
            
            UIView *vv = self.pages[_currentPageIndex];// [self.delegate pageView:self pageFromIndex:_currentPageIndex];
            //把视图加入到指定的内容中去。
            vv.frame = CGRectMake((_currentPageIndex + 1) * self.scrollView.bounds.size.width, 0, self.scrollView.bounds.size.width, self.scrollView.bounds.size.height);
            self.isScroll = YES;
            [self.scrollView addSubview:vv];
            
            [self.pages replaceObjectAtIndex:_currentPageIndex withObject:vv];

        }
        else
        {
        
            self.scrollView.contentOffset = CGPointMake(_currentPageIndex*__SCREEN_SIZE.width, 0);
            
            UIView *vv = self.pages[_currentPageIndex];// [self.delegate pageView:self pageFromIndex:_currentPageIndex];
            //把视图加入到指定的内容中去。
            vv.frame = CGRectMake(_currentPageIndex * __SCREEN_SIZE.width, 0, __SCREEN_SIZE.width, self.scrollView.bounds.size.height);
            [self.scrollView addSubview:vv];
            
            [self.pages replaceObjectAtIndex:_currentPageIndex withObject:vv];
        }
        
    }

}

//下一页
-(void)nextPage:(BOOL)animated
{
    //获取当前的偏移。。然后加一个宽度
    if (self.count <= 1 || self.scrollView.isDragging)
        return;
    
    CGFloat curx = (_currentPageIndex + ((int)self.cycle)) * self.scrollView.bounds.size.width;
    curx += self.scrollView.bounds.size.width;
    if (curx < self.scrollView.contentSize.width)
    {
        if (self.cycle)
        {
            if (!animated)
            {
                _currentPageIndex +=1;
                if (_currentPageIndex >= self.count)
                    _currentPageIndex = 0;
            }
            
            
            [self.scrollView setContentOffset:CGPointMake(curx, 0) animated:animated];
        }
        else
        {
        
            if (_currentPageIndex + 1 < self.count)
            {
                if (!animated)
                    _currentPageIndex +=1;
        
                [self.scrollView setContentOffset:CGPointMake(curx, 0) animated:animated];
            }
        }
        
    }
    if (self.showPageController && self.pageController != NULL) {
        self.pageController.currentPage = _currentPageIndex;
    }
        
}

//前一页
-(void)prevPage:(BOOL)animated
{
    if (self.count <= 1 || self.scrollView.isDragging)
        return;
    
    
     CGFloat curx = (_currentPageIndex + ((int)self.cycle)) * self.scrollView.bounds.size.width;
     curx -= self.scrollView.bounds.size.width;
     if (curx >= 0)
     {
         if (self.cycle)
         {
             if (!animated)
             {
                 _currentPageIndex -=1;
                 if (_currentPageIndex < 0)
                     _currentPageIndex = self.count - 1;
             }

            [ self.scrollView setContentOffset:CGPointMake(curx, 0) animated:animated];
         }
         else
         {
         
         if (_currentPageIndex - 1 >= 0)
         {
             if (!animated)
                 _currentPageIndex -= 1;
         
             [self.scrollView setContentOffset:CGPointMake(curx, 0) animated:animated];
         }
         }
         
     }
    if (self.showPageController && self.pageController != NULL) {
        self.pageController.currentPage = _currentPageIndex;
    }
}


-(void)setCurrentPageIndex:(NSInteger)index animated:(BOOL)animated
{
    _currentPageIndex = index;
    if (index >= self.count)
        return;
    if (index >= self.pages.count) {
        return;
    }
    
    
    [self.scrollView setContentOffset:CGPointMake((_currentPageIndex + ((int)(self.cycle && self.count > 1))) *self.scrollView.bounds.size.width, 0) animated:animated];
    
    if (self.showPageController && self.pageController != NULL) {
        self.pageController.currentPage = _currentPageIndex;
    }
    
}

-(UIView*)pageFromIndex:(NSInteger)index
{
    if (index >= self.count)
        return nil;
    if (index < 0)
        return nil;
    
    UIView *vv = [self.pages objectAtIndex:index];
    if (vv != (UIView*)[NSNull null])
        return vv;
    
    return nil;
}


#pragma mark -- 

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (self.pages.count ==0) return;
    //是否是下一个位置。。。
    
    //如果在边缘拖动则什么也不做。。。
    if (scrollView.contentOffset.x <= 0 || scrollView.contentOffset.x + scrollView.bounds.size.width >= scrollView.contentSize.width)
    {
        //如果超过这里要调整
        if (self.count > 1 && self.cycle)
        {
            //如果是小于0则
            if (scrollView.contentOffset.x <= 0)
            {
                //取最后一个
                 UIView *vv = [self.pages objectAtIndex:self.count - 2];
                if (vv == (UIView*)[NSNull null])
                {
                    UIView *vv = [self.delegate pageView:self pageFromIndex:self.count - 2];
                    vv.frame = CGRectMake(-1 * scrollView.bounds.size.width, 0, scrollView.bounds.size.width, scrollView.bounds.size.height);
                    [scrollView addSubview:vv];
                    
                    [self.pages replaceObjectAtIndex:self.count - 2 withObject:vv];

                }
                else
                {
                    vv.frame = CGRectMake(-1 * scrollView.bounds.size.width, 0, scrollView.bounds.size.width, scrollView.bounds.size.height);

                }
            }
            else
            {
                //取最后一个
                UIView *vv = [self.pages objectAtIndex:1];
                if (vv == (UIView*)[NSNull null])
                {
                    UIView *vv = [self.delegate pageView:self pageFromIndex:1];
                    vv.frame = CGRectMake((self.count + 2) * scrollView.bounds.size.width, 0, scrollView.bounds.size.width, scrollView.bounds.size.height);
                    [scrollView addSubview:vv];
                    
                    [self.pages replaceObjectAtIndex:1 withObject:vv];
                    
                }
                else
                {
                    vv.frame = CGRectMake((self.count + 2) * scrollView.bounds.size.width, 0, scrollView.bounds.size.width, scrollView.bounds.size.height);
                    
                }

                
            }
        }
        
        return;
    }
    
    if (!self.isScroll)
        return;
    
    //计算要显示的视图。1 - size.width 为0页和1页。
    
    // size.width+ 1 --- 2*size.width 为1和2页
    
    //计算当前将要显示的索引页，如果没有就建立，如果有就不管。。
    
    //计算当前显示在屏幕上的页面。
    NSInteger tempindex1 = (NSInteger)(scrollView.contentOffset.x / scrollView.bounds.size.width);
    NSInteger tempindex2;
    
    NSInteger orgIndex1 = tempindex1;
    NSInteger orgIndex2 = orgIndex1 + 1;
    
    
    if (self.count > 1 && self.cycle)
    {
        if (tempindex1 == 0)
        {
            tempindex1 = self.count - 1;
            tempindex2 = 0;
        }
        else if (tempindex1 == self.count + 1)
        {
            tempindex1 = 0;
            tempindex2 = self.count - 1;
        }
        else
        {
            tempindex1 = tempindex1 - 1;
            tempindex2 = tempindex1 + 1;
            if (tempindex2 == self.count)
                tempindex2 = 0;
        }
    }
    else
    {
        tempindex2 = tempindex1 + 1;
    }
    
    NSInteger tempWillShowIndex = 0;
    NSInteger tempWillShowOrgIndex = 0;
    
    //计算那个是将要显示的视图。
    if (tempindex1 == _currentPageIndex)
    {
        tempWillShowIndex = tempindex2;
        tempWillShowOrgIndex = orgIndex2;
    }
    else
    {
        tempWillShowIndex  = tempindex1;
        tempWillShowOrgIndex = orgIndex1;
    }
    
    if (tempWillShowIndex >= self.count)
        return;
    
    //NSLog(@"tempWillShowIndex = %ld,count = %ld",tempWillShowIndex,self.pages.count);
    UIView *vv = [self.pages objectAtIndex:tempWillShowIndex];
    if (vv == (UIView*)[NSNull null])
    {
        UIView *vv = [self.delegate pageView:self pageFromIndex:tempWillShowIndex];
        vv.frame = CGRectMake(tempWillShowOrgIndex * scrollView.bounds.size.width, 0, scrollView.bounds.size.width, scrollView.bounds.size.height);
        [scrollView addSubview:vv];
        [scrollView sendSubviewToBack:vv];
        
        [self.pages replaceObjectAtIndex:tempWillShowIndex withObject:vv];
        
    }
    else
    {
        if (self.count > 1 && self.cycle)
        {
            //调整指定视图的位置。
            vv.frame = CGRectMake(tempWillShowOrgIndex * scrollView.bounds.size.width, 0, scrollView.bounds.size.width, scrollView.bounds.size.height);
            
        }
    }
    
    //如果位置和当前的偏移很小时激发。
    if (fabs(_currentPageIndex *self.scrollView.bounds.size.width - self.scrollView.contentOffset.x) < 20.0)
    {
        from = _currentPageIndex;
        to = tempWillShowIndex;
        if ([self.delegate respondsToSelector:@selector(pageView:willDismissAtIndex:wilDisplayAtIndex:)])
            [self.delegate pageView:self willDismissAtIndex:_currentPageIndex  wilDisplayAtIndex:tempWillShowIndex];
    }
//    if ([self.delegate respondsToSelector:@selector(pageView:fromDisplayAtIndex:didDisplayAtIndex:)])
//        [self.delegate pageView:self fromDisplayAtIndex:from didDisplayAtIndex:to];
//    if (self.showPageController && self.pageController != NULL) {
//        self.pageController.currentPage = _currentPageIndex;
//    }

    
}


// called on start of dragging (may require some time and or distance to move)
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    //self.lastOffsetX = scrollView.contentOffset.x;
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    UIScrollView* scrollView = self.scrollView;
    //重新设置里面的内容的长度。。
    if (self.pages.count > 1 && self.cycle)
    {
        CGSize size = CGSizeMake((self.pages.count + 2)* __SCREEN_SIZE.width, self.scrollView.frame.size.height);
        self.scrollView.contentSize = size;
    }
    else
    {
        CGSize size = CGSizeMake(self.pages.count * __SCREEN_SIZE.width, self.scrollView.frame.size.height);
        self.scrollView.contentSize = size;
    }
    //_currentPageIndex = 0;
    if (_currentPageIndex < self.pages.count) {
        for (int i =0; i < self.pages.count; i++) {
            UIView *vv = [self.pages objectAtIndex:i] == [NSNull null] ? [self.delegate pageView:self pageFromIndex:i] : [self.pages objectAtIndex:i];
            vv.frame = CGRectMake((self.count > 1 && self.cycle ? ( 1 +i) : i) * __SCREEN_SIZE.width, 0, __SCREEN_SIZE.width, scrollView.bounds.size.height);
        }
        
    }
    if (self.count > 1 && self.cycle){
         scrollView.contentOffset = CGPointMake((_currentPageIndex + 1)*__SCREEN_SIZE.width, 0);
    }
    else scrollView.contentOffset = CGPointMake((_currentPageIndex)*__SCREEN_SIZE.width, 0);
   
    
    
}

-(void)reLayout:(UIScrollView*)scrollView
{
    //计算当前的偏移得到当前的视图。
    _currentPageIndex = scrollView.contentOffset.x / scrollView.bounds.size.width;
    
    if (self.count > 1 && self.cycle)
    {
        //调整当前的位置。
        if (_currentPageIndex == 0)
        {
            //移动到
            _currentPageIndex = self.count - 1;
            
             UIView *vv = [self.pages objectAtIndex:_currentPageIndex];
             vv.frame = CGRectMake((_currentPageIndex + 1) * scrollView.bounds.size.width, 0, scrollView.bounds.size.width, scrollView.bounds.size.height);
            self.isScroll = NO;
            scrollView.contentOffset = CGPointMake((_currentPageIndex + 1)*scrollView.bounds.size.width, 0);
            self.isScroll = YES;
            
        }
        else if (_currentPageIndex == self.count + 1)
        {
            _currentPageIndex = 0;
           
            UIView *vv = [self.pages objectAtIndex:_currentPageIndex];
            vv.frame = CGRectMake((_currentPageIndex + 1) * scrollView.bounds.size.width, 0, scrollView.bounds.size.width, scrollView.bounds.size.height);
            self.isScroll = NO;
            scrollView.contentOffset = CGPointMake((_currentPageIndex + 1) + self.scrollView.bounds.size.width, 0);
            self.isScroll = YES;
           
        }
        else
        {
            _currentPageIndex -= 1;
        }
        
    }
    
    if ([self.delegate respondsToSelector:@selector(pageView:fromDisplayAtIndex:didDisplayAtIndex:)])
        [self.delegate pageView:self fromDisplayAtIndex:from didDisplayAtIndex:to];
    if (self.showPageController && self.pageController != NULL) {
        self.pageController.currentPage = _currentPageIndex;
    }
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    //根据当前的位置和
    if (!decelerate)
    {
        [self reLayout:scrollView];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self reLayout:scrollView];
}

-(void)scrollViewDidEndScrollingAnimation:(UIScrollView*)scrollView
{
    [self reLayout:scrollView];
}

-(void)setShowPageController:(BOOL)showPageController
{
    if (self.pageController != NULL) {
        self.pageController.hidden = !showPageController;
    }
    _showPageController = showPageController;
}

@end
