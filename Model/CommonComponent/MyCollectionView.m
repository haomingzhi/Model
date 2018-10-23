//
//  MyCollectionView.m
//  chenxiaoerSv
//
//  Created by air on 16/5/30.
//  Copyright © 2016年 ORANLLC_IOS1. All rights reserved.
//

#import "MyCollectionView.h"
@interface MyCollectionViewDelegateProxy : NSProxy<UICollectionViewDelegate>

@property(nonatomic,weak) MyCollectionView *target;
@property(nonatomic, weak) id <UITableViewDelegate> mydelegate;

-(id)initWithTarget:(MyCollectionView*)target;



@end

@interface MyCollectionView ()
@property(nonatomic) MyCollectionViewDelegateProxy *delegateProxy;

@end

@implementation MyCollectionView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


-(void)setDelegate:(id<UITableViewDelegate>)delegate
{
    //  self.mydelegate = delegate;
    
    if (self.delegateProxy == nil && delegate)
        self.delegateProxy = [[MyCollectionViewDelegateProxy alloc] initWithTarget:self];
    
    self.delegateProxy.mydelegate = delegate;
    if (!delegate) {
        super.delegate = nil;
        self.delegateProxy = nil;
    }
    else
    {
        super.delegate = self.delegateProxy;
    }
}

-(id<UITableViewDelegate>)delegate
{
    return self.delegateProxy.mydelegate;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    if (self.refreshHeaderView != nil)
        self.refreshHeaderView.frame = CGRectMake(0, -1*self.bounds.size.height, self.bounds.size.width, self.bounds.size.height);
    
    
    if (self.refreshFooterView != nil)
    {
        if (self.hasMore)
        {
            self.refreshFooterView.frame = CGRectMake(0, self.contentSize.height, self.bounds.size.width, self.refreshFooterView.frame.size.height);
        }
        else
        {
            self.refreshFooterView.frame = CGRectMake(self.frame.origin.x, -1*self.bounds.size.height, self.refreshFooterView.frame.size.width, self.refreshFooterView.frame.size.height);
            //还原
            UIEdgeInsets inset = self.contentInset;
            self.contentInset = UIEdgeInsetsMake(inset.top, inset.left, 0, inset.right);
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
    
    if (_refreshHeaderView != nil)
    {
        [self addSubview:_refreshHeaderView];
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
        [self addSubview:_refreshFooterView];
        [self setNeedsLayout];
    }
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
        [self addSubview:self.refreshFooterView];
    }
    else
    {
        UIEdgeInsets inset = self.contentInset;
        self.contentInset = UIEdgeInsetsMake(inset.top, inset.left, 0, inset.right);
    }
    [self setNeedsLayout];
}

-(void)setHeadHasMore:(BOOL)hasMore
{
    _headHasMore = hasMore;
    
    if (self.refreshHeaderView != nil)
    {
        [self.refreshHeaderView resetState:NO];
        [self.refreshHeaderView removeFromSuperview];
    }
    
    if (_headHasMore)
    {
        //添加头部。
        [self addSubview:self.refreshHeaderView];
    }
    
    [self setNeedsLayout];
}


#pragma mark -- Private Method

-(void)construct
{
    _hasMore = NO;
}

#pragma mark -- UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (self.refreshHeaderView != nil)
        [self.refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
    
    if (self.refreshFooterView != nil && self.hasMore)
        [self.refreshFooterView egoRefreshScrollViewDidScroll:scrollView];
    
    
    //   if (self.mydelegate != nil && [self.mydelegate respondsToSelector:@selector(scrollViewDidScroll:)])
    //      [self.mydelegate scrollViewDidScroll:scrollView];
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (self.refreshHeaderView != nil && _headHasMore)
        [self.refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
    
    if (self.refreshFooterView != nil && self.hasMore)
        [self.refreshFooterView egoRefreshScrollViewDidEndDragging:scrollView];
    
    
    //   if (self.mydelegate != nil && [self.mydelegate respondsToSelector:@selector(scrollViewDidEndDragging:willDecelerate:)])
    //  {
    //      [self.mydelegate scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
    //  }
}
@end

@implementation MyCollectionViewDelegateProxy

-(id)initWithTarget:(MyCollectionView*)target
{
    _target = target;
    return self;
}

//这里启动代理的原因是MyTableView类想截获对一些委托函数的处理，也就是uitableview的委托实际上是一个代理
//而代理在处理委托请求时先把这个机会给MyTableView,然后再转交给真正的委托。
-(void)forwardInvocation:(NSInvocation *)anInvocation;
{
    
    // tell the invocation to retain arguments
    //如果是
    if (anInvocation.selector == @selector(scrollViewDidScroll:))
    {
        [anInvocation invokeWithTarget:self.target];    //先让myuitableview来处理scrollViewDidScroll。然后再转交给真正的代理
        
        if (![self.mydelegate  respondsToSelector:@selector(scrollViewDidScroll:)])
            return;
    }
    else if (anInvocation.selector == @selector(scrollViewDidEndDragging:willDecelerate:))
    {
        [anInvocation invokeWithTarget:self.target];
        
        if (![self.mydelegate  respondsToSelector:@selector(scrollViewDidEndDragging:willDecelerate:)])
            return;
    }
    else if (anInvocation.selector == @selector(respondsToSelector:))
    {
        //这里的原因是因为uitableview类在调用可选的方法时会先调用respondsToSelector函数来检测是否实现了对应的方法
        //因此需要在这里获取是否检测的是scrollViewDidScroll scrollViewDidEndDragging两个函数
        //如果是这两个函数则需要要直接调用mytableview的方法，同时忽略对真实委托的调用。
        SEL aa = NULL;
        [anInvocation getArgument:&aa atIndex:2];
        
        if (aa == @selector(scrollViewDidScroll:) || aa == @selector(scrollViewDidEndDragging:willDecelerate:))
        {
            //这时候肯定是YES的。
            [anInvocation invokeWithTarget:self.target];
            return;
        }
    }
    
    
    //这里是真正调用代理的地方。
    [anInvocation invokeWithTarget:self.mydelegate];
    
    // add the invocation to the array
    
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    return [[self.mydelegate class] instanceMethodSignatureForSelector:aSelector];
}
@end
