//
//  EGORefreshTableHeaderView.m
//  Demo
//
//  Created by Devin Doty on 10/14/09October14.
//  Copyright 2009 enormego. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

#import "EGORefreshTableHeaderView.h"


#define HEADER_TEXT_COLOR	 [UIColor colorWithRed:87.0/255.0 green:108.0/255.0 blue:137.0/255.0 alpha:1.0]
#define FLIP_ANIMATION_DURATION 0.18f


@interface EGORefreshTableHeaderView (Private)
- (void)setState:(EGOPullRefreshState)aState;
@end

@implementation EGORefreshTableHeaderView

@synthesize delegate=_delegate;


- (id)initWithFrame:(CGRect)frame arrowImageName:(NSString *)arrow textColor:(UIColor *)textColor  {
    if((self = [super initWithFrame:frame])) {
        
		self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
		self.backgroundColor = [UIColor colorWithRed:226.0/255.0 green:231.0/255.0 blue:237.0/255.0 alpha:1.0];
        
		UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, frame.size.height - 30.0f, self.frame.size.width, 20.0f)];
		label.autoresizingMask = UIViewAutoresizingFlexibleWidth;
		label.font = [UIFont systemFontOfSize:12.0f];
		label.textColor = textColor;
		label.shadowColor = [UIColor colorWithWhite:0.9f alpha:1.0f];
		label.shadowOffset = CGSizeMake(0.0f, 1.0f);
		label.backgroundColor = [UIColor clearColor];
		label.textAlignment = NSTextAlignmentCenter;
		[self addSubview:label];
		_lastUpdatedLabel=label;
		
        
		label = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, frame.size.height - 48.0f, self.frame.size.width, 20.0f)];
		label.autoresizingMask = UIViewAutoresizingFlexibleWidth;
		label.font = [UIFont boldSystemFontOfSize:13.0f];
		label.textColor = textColor;
		label.shadowColor = [UIColor colorWithWhite:0.9f alpha:1.0f];
		label.shadowOffset = CGSizeMake(0.0f, 1.0f);
		label.backgroundColor = [UIColor clearColor];
		label.textAlignment = NSTextAlignmentCenter;
		[self addSubview:label];
		_statusLabel=label;
		
        
		CALayer *layer = [CALayer layer];
		layer.frame = CGRectMake(25.0f, frame.size.height - 65.0f, 30.0f, 55.0f);
		layer.contentsGravity = kCAGravityResizeAspect;
        layer.contents = (id)[UIImage readImageFromBundle:arrow bundleName:@"UniversalFramework.framework"].CGImage;   //[UIImage imageNamed:arrow].CGImage;
		
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 40000
		if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]) {
			layer.contentsScale = [[UIScreen mainScreen] scale];
		}
#endif
        
		[[self layer] addSublayer:layer];
		_arrowImage=layer;
        
		UIActivityIndicatorView *view = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
		view.frame = CGRectMake(25.0f, frame.size.height - 38.0f, 20.0f, 20.0f);
		[self addSubview:view];
		_activityView = view;
        
		 _customView = [[UIImageView alloc] init];
        _customView.frame = CGRectMake(25.0f, frame.size.height - 38.0f, 20.0f, 20.0f);
        [self addSubview:_customView];
        
		[self setState:EGOPullRefreshNormal];
        
    }
    [self fitStyle];
    return self;
    
}

-(void)fitStyle
{

}

-(void)layoutSubviews
{
      [super layoutSubviews];
    _lastUpdatedLabel.frame = CGRectMake(0.0f, self.bounds.size.height - 30.0f, self.bounds.size.width, 20.0f);
    _statusLabel.frame = CGRectMake(0.0f, self.bounds.size.height - 38.0f, self.bounds.size.width, 20.0f);
    _arrowImage.frame = CGRectMake(25.0f, self.bounds.size.height - 65.0f, 30.0f, 55.0f);
    _activityView.frame = CGRectMake(25.0f, self.bounds.size.height - 38.0f, 20.0f, 20.0f);
   _customView.frame = CGRectMake(25.0f, self.bounds.size.height - 38.0f, 46.0f, 46.0f);
}

- (id)initWithFrame:(CGRect)frame  {
    return [self initWithFrame:frame arrowImageName:@"blueArrow.png" textColor:HEADER_TEXT_COLOR];
}

#pragma mark -
#pragma mark Setters

- (void)refreshLastUpdatedDate {
    
	if ([_delegate respondsToSelector:@selector(egoRefreshTableHeaderDataSourceLastUpdated:)]) {
        
		NSString *strDate = [_delegate egoRefreshTableHeaderDataSourceLastUpdated:self];
        if(![strDate isEqualToString:@""])
        {
		_lastUpdatedLabel.text = [NSString stringWithFormat:@"最后更新: %@", strDate];
        }
        else
        {
        _lastUpdatedLabel.text = @"";
        }
       
	} else {
        
		_lastUpdatedLabel.text = nil;
//        _statusLabel.frame = CGRectMake(0.0f, self.bounds.size.height - 18.0f, self.bounds.size.width, 20.0f);
	}
    
}

-(UIActivityIndicatorView *)getActivityView
{
    return _activityView;
}
-(UILabel *)getStatusLabel
{
    return _statusLabel;
}
-(UILabel *)getLastUpdatedLabel
{
    return _lastUpdatedLabel;
}

- (void)setState:(EGOPullRefreshState)aState{
   
	switch (aState) {
		case EGOPullRefreshPulling:
            
            //			_statusLabel.text = NSLocalizedString(@"Release to refresh...", @"Release to refresh status");
            _statusLabel.text = @"松开即可刷新";
			[CATransaction begin];
			[CATransaction setAnimationDuration:FLIP_ANIMATION_DURATION];
			_arrowImage.transform = CATransform3DMakeRotation((M_PI / 180.0) * 180.0f, 0.0f, 0.0f, 1.0f);
			[CATransaction commit];
            
			break;
		case EGOPullRefreshNormal:
            
			if (_state == EGOPullRefreshPulling) {
				[CATransaction begin];
				[CATransaction setAnimationDuration:FLIP_ANIMATION_DURATION];
				_arrowImage.transform = CATransform3DIdentity;
				[CATransaction commit];
			}
            
            //			_statusLabel.text = NSLocalizedString(@"Pull down to refresh...", @"Pull down to refresh status");
            _statusLabel.text = @"下拉可以刷新";
			[_activityView stopAnimating];
			[CATransaction begin];
			[CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
			_arrowImage.hidden = NO;
			_arrowImage.transform = CATransform3DIdentity;
			[CATransaction commit];
            [self stopCustomView];
			[self refreshLastUpdatedDate];
            
			break;
		case EGOPullRefreshLoading:
            
            //			_statusLabel.text = NSLocalizedString(@"Loading...", @"Loading Status");
            _statusLabel.text = @"加载中";
			[_activityView startAnimating];
            _activityView.x = __SCREEN_SIZE.width/2.0 - 50;
			[CATransaction begin];
			[CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
			_arrowImage.hidden = YES;
			[CATransaction commit];
            [self beginCustomView];
			break;
		default:
			break;
	}
    
	_state = aState;
}
-(void)stopCustomView
{

}
-(void)beginCustomView
{
 
}
#pragma mark -
#pragma mark ScrollView Methods

- (void)egoRefreshScrollViewDidScroll:(UIScrollView *)scrollView {
    
    //如果当前是加载状态则不管如何总是设置缩进为60.
	if (_state == EGOPullRefreshLoading) {
        
		CGFloat offset = MAX(scrollView.contentOffset.y * -1, 0);
		offset = MIN(offset, 60);
        
        UIEdgeInsets inset = scrollView.contentInset;
		scrollView.contentInset = UIEdgeInsetsMake(offset, inset.left, inset.bottom, inset.right);
        
	} else if (scrollView.isDragging) {
        
        /*
		BOOL _loading = NO;
		if ([_delegate respondsToSelector:@selector(egoRefreshTableHeaderDataSourceIsLoading:)]) {
			_loading = [_delegate egoRefreshTableHeaderDataSourceIsLoading:self];
		}*/
        
        //如果当前在刷新状态并且滚动条在-65的基础上往回反弹则变为正常状态。
		if (_state == EGOPullRefreshPulling && scrollView.contentOffset.y > -65.0f && scrollView.contentOffset.y < 0.0f) {
			[self setState:EGOPullRefreshNormal];
            
            //如果当前是正常状态并且滚动条在-65的基础上再往下拉则变为刷新状态
		} else if (_state == EGOPullRefreshNormal && scrollView.contentOffset.y < -65.0f) {
			[self setState:EGOPullRefreshPulling];
		}
        
        //不管如何都要恢复缩进
		if (scrollView.contentInset.top != 0) {
            
            UIEdgeInsets inset = scrollView.contentInset;
			scrollView.contentInset = UIEdgeInsetsMake(0, inset.left, inset.bottom, inset.right);
		}
        
	}
    
}

- (void)egoRefreshScrollViewDidEndDragging:(UIScrollView *)scrollView {
    
   /*BOOL _loading = NO;
	if ([_delegate respondsToSelector:@selector(egoRefreshTableHeaderDataSourceIsLoading:)]) {
		_loading = [_delegate egoRefreshTableHeaderDataSourceIsLoading:self];
	}*/
    
    //只有在拉动的滚动条到一定程度时才激发数据加载。。。
	if (scrollView.contentOffset.y <= - 65.0f && _state != EGOPullRefreshLoading) {
        
		if ([_delegate respondsToSelector:@selector(egoRefreshTableHeaderDidTriggerRefresh:)]) {
			[_delegate egoRefreshTableHeaderDidTriggerRefresh:self];
		}
        
		[self setState:EGOPullRefreshLoading];
        UIEdgeInsets inset = scrollView.contentInset;
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:0.2];
		scrollView.contentInset = UIEdgeInsetsMake(60.0f, inset.left, inset.bottom, inset.right);
		[UIView commitAnimations];
        
	} else if (_state == EGOPullRefreshLoading && scrollView.contentOffset.y >=0)  //如果当前是在装入状态而且滚动超过65时则给一个机会是否通知处理。
    {
        BOOL loading = YES;
         if ([_delegate respondsToSelector:@selector(egoRefreshTableHeaderDataSourceIsLoading:)]) {
            loading = [_delegate egoRefreshTableHeaderDataSourceIsLoading:self];
         }
        
        if (!loading)
        {
            [self setState:EGOPullRefreshNormal];
            
            //恢复缩进。
            UIEdgeInsets inset = scrollView.contentInset;
            scrollView.contentInset = UIEdgeInsetsMake(0.0f, inset.left, inset.bottom, inset.right);
            
        }
        
    }
    
}

- (void)resetState:(BOOL)canRetry
{
    
    
    if (self.superview != nil)
    {
        UIScrollView *s = (UIScrollView*)self.superview;
        UIEdgeInsets inset = s.contentInset;
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:.3];
        [s setContentInset:UIEdgeInsetsMake(0.0f, inset.left,inset.bottom,inset.right)];
        [UIView commitAnimations];
    }

    [self setState:EGOPullRefreshNormal];
}


-(UIView *)getCustomView
{
//    [_customView removeFromSuperview];
//    _customView = view;
//    _customView.y =  self.bounds.size.height - 48.0f;
    return _customView;
}


@end
