//
//  EGORefreshTableFooterView.m
//  MiniClient
//
//  Created by apple on 14-7-13.
//  Copyright (c) 2014年 SunnadaSoft. All rights reserved.
//

#import "EGORefreshTableFooterView.h"

@interface EGORefreshTableFooterView (Private)
- (void)setState:(EGOPushRefreshState)aState;
@end


@implementation EGORefreshTableFooterView
{
    EGOPushRefreshState _state;
    UILabel *_statusLabel;
    UIActivityIndicatorView *_activityView;  //居中显示
}
- (id)initWithFrame:(CGRect)frame textColor:(UIColor *)textColor
{
    self = [super initWithFrame:frame];
    if (self != nil)
    {
        self.showLoading = TRUE;
        //创建一个视图
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        UIActivityIndicatorView *view = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
		view.frame = CGRectMake(0.0f, 0.0f, 20.0f, 20.0f);
		[self addSubview:view];
		_activityView = view;
        _activityView.hidesWhenStopped = YES;
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 160, 20.0f)];
		label.font = [UIFont boldSystemFontOfSize:13.0f];
		label.textColor = textColor;
		label.shadowColor = [UIColor colorWithWhite:0.9f alpha:1.0f];
		label.shadowOffset = CGSizeMake(0.0f, 1.0f);
		label.backgroundColor = [UIColor clearColor];
		label.textAlignment = NSTextAlignmentCenter;
		[self addSubview:label];
		_statusLabel=label;
        
        [self setState:EGOOPushRefreshNormal];

    }
    
    return self;
    
}

- (id)initWithFrame:(CGRect)frame
{
    self = [self initWithFrame:frame textColor:FOOTER_TEXT_COLOR];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)layoutSubviews
{
    //居中显示
    if (_activityView.isAnimating)
    {
        _activityView.frame = CGRectMake(CGRectGetMidX(self.bounds) - _activityView.frame.size.width - 40,
                                         CGRectGetMidY(self.bounds) - _activityView.frame.size.height / 2,
                                         _activityView.frame.size.width,
                                         _activityView.frame.size.height);
        _statusLabel.frame = CGRectMake(CGRectGetMidX(self.bounds) - _activityView.frame.size.width - 38,
                                        CGRectGetMidY(self.bounds) - _statusLabel.frame.size.height / 2,
                                        _statusLabel.frame.size.width,
                                        _statusLabel.frame.size.height);
        
    }
    else
    {
        _statusLabel.center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    }
}

-(void)setStatusText:(NSString*)text
{
    _statusLabel.text = text;
    [self setNeedsLayout];
}

-(void)resetState:(BOOL)canRetry
{
    [self setState:EGOOPushRefreshNormal];
    
     if (canRetry)
     {
         if (self.superview != nil)
         {
             UIScrollView *s = (UIScrollView*)self.superview;
             
             UIEdgeInsets inset = s.contentInset;
             s.contentInset = UIEdgeInsetsMake(inset.top, inset.left, self.bounds.size.height, inset.right);
         }

     }
    
}

//- (void)refreshLastUpdatedDate;
- (void)egoRefreshScrollViewDidScroll:(UIScrollView *)scrollView
{
    if ([scrollView isKindOfClass:NSClassFromString(@"UITableViewWrapperView")]) {
        return;
    }
    
    //如果滚动到指定的位置就开始装入软件了。。。
    if (_state == EGOPushRefreshLoading) {
        
	} else if (scrollView.isDragging) {
        
        //如果快到结尾时并且没有调用，结束后要设置状态。。。
        if (scrollView.contentOffset.y <0) {
            return;
        }
        
        //如果当前的偏移超出大于容量时则
        if (scrollView.contentSize.height - scrollView.contentOffset.y - scrollView.bounds.size.height < 40 &&
            _state == EGOOPushRefreshNormal)
        {
            [self setState:EGOPushRefreshLoading];
            
            if (self.delegate != nil &&
                [self.delegate respondsToSelector:@selector(egoRefreshTableFooterDidTriggerRefresh:)])
            {
                [self.delegate egoRefreshTableFooterDidTriggerRefresh:self];
            }
            
            
            UIEdgeInsets inset = scrollView.contentInset;
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationDuration:0.2];
            scrollView.contentInset = UIEdgeInsetsMake(inset.top, inset.left, self.bounds.size.height, inset.right);
            [UIView commitAnimations];
            

        }
        
    }

}

- (void)egoRefreshScrollViewDidEndDragging:(UIScrollView *)scrollView
{
    //如果当前是装载状态并且往上回滚还原时给用户一个机会看是否取消请求。
    if (_state == EGOPushRefreshLoading && scrollView.contentOffset.y + scrollView.bounds.size.height < self.frame.origin.y)
    {
        BOOL isLoading = YES;   //给一个机会给用户结束
        if (self.delegate != nil &&
            [self.delegate respondsToSelector:@selector(egoRefreshTableFooterDataSourceIsLoading:)])
        {
           isLoading = [self.delegate egoRefreshTableFooterDataSourceIsLoading:self];
        }
        
        if (!isLoading)
        {
            //还原状态。。
            [self setState:EGOOPushRefreshNormal];
            
            //恢复缩进
      
            UIEdgeInsets inset = scrollView.contentInset;
            scrollView.contentInset = UIEdgeInsetsMake(inset.top, inset.left, inset.bottom, inset.right);
        }

    }
}



- (void)setState:(EGOPushRefreshState)aState{
    if (self.showLoading) {
        switch (aState) {
            case EGOOPushRefreshNormal:
            {
                [_activityView stopAnimating];
            }
                break;
            case EGOPushRefreshLoading:
            {
                [_activityView startAnimating];
                
            }
                break;
            default:
                break;
        }
    }
   	_state = aState;
}

@end
