

#import "BaseScrollViewController.h"
#import "XHMenu.h"
#import "XHScrollMenu.h"

@interface BaseScrollViewController () < UIScrollViewDelegate>

@property (nonatomic, assign) BOOL shouldObserving;

@end

@implementation BaseScrollViewController
{
    BOOL isFirstAppear;
}

-(void) myViewDidLoad
{
    self.shouldObserving = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.delegate = self;
    self.scrollView.pagingEnabled = YES;
    for (int i = 0; i < self.scrollViewList.count; i ++) {
        UIView *v = (UIView *)self.scrollViewList[i];
        v.frame = CGRectMake(i * CGRectGetWidth(self.scrollView.bounds), 0, CGRectGetWidth(self.scrollView.bounds), CGRectGetHeight(self.scrollView.bounds));
        if ([self.scrollView.subviews indexOfObject:v] == NSNotFound) {
            [self.scrollView addSubview:v];
        }
    }
    [self.scrollView setContentSize:CGSizeMake(self.scrollViewList.count * CGRectGetWidth(self.scrollView.bounds), CGRectGetHeight(self.scrollView.bounds))];
    [self startObservingContentOffsetForScrollView:self.scrollView];
    
}

- (void)viewDidLoad
{

    [super viewDidLoad];
    isFirstAppear = YES;
	// Do any additional setup after loading the view, typically from a nib.
    
}

-(void) viewWillAppear:(BOOL)animated
{
    if (isFirstAppear) {
        [self myViewDidLoad];
        isFirstAppear = NO;
    }
}

-(void) viewDidLayoutSubviews
{
    for (int i = 0; i < self.scrollViewList.count; i ++) {
        UIView *v = (UIView *)self.scrollViewList[i];
        v.frame = CGRectMake(i * CGRectGetWidth(self.scrollView.bounds), 0, CGRectGetWidth(self.scrollView.bounds), CGRectGetHeight(self.scrollView.bounds));
        if ([self.scrollView.subviews indexOfObject:v] == NSNotFound) {
            [self.scrollView addSubview:v];
        }
    }
    [self.scrollView setContentSize:CGSizeMake(self.scrollViewList.count * CGRectGetWidth(self.scrollView.bounds), CGRectGetHeight(self.scrollView.bounds))];
}

- (void)startObservingContentOffsetForScrollView:(UIScrollView *)scrollView
{
    [scrollView addObserver:self forKeyPath:@"contentOffset" options:0 context:nil];
}

- (void)stopObservingContentOffset
{
    if (self.scrollView) {
        [self.scrollView removeObserver:self forKeyPath:@"contentOffset"];
        self.scrollView = nil;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [self stopObservingContentOffset];
}


- (void)menuSelectedIndex:(NSUInteger)index {
    CGRect visibleRect = CGRectMake(index * CGRectGetWidth(self.scrollView.bounds), 0, CGRectGetWidth(self.scrollView.bounds), CGRectGetHeight(self.scrollView.bounds));
    CGFloat pageWidth = self.scrollView.frame.size.width;
    //根据当前的坐标与页宽计算当前页码
    NSInteger currentPage = floor((self.scrollView.contentOffset.x - pageWidth/2)/pageWidth) +1;
    int pageSpace = index - currentPage;
    if (currentPage == index || abs(pageSpace) ==1) {
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
            [self.scrollView scrollRectToVisible:visibleRect animated:NO];
        } completion:^(BOOL finished) {
            self.shouldObserving = YES;
        }];
    }
    else {
        [self.scrollView setContentOffset:visibleRect.origin animated:NO];
    }
    
    
}

#pragma mark - ScrollView delegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView == self.scrollView) {
        //每页宽度
        CGFloat pageWidth = scrollView.frame.size.width;
        //根据当前的坐标与页宽计算当前页码
        int currentPage = floor((scrollView.contentOffset.x - pageWidth/2)/pageWidth)+1;
        if (currentPage == self.scrollMenu.selectedIndex) {
            return;
        }
        [self.scrollMenu setSelectedIndex:currentPage animated:YES calledDelegate:YES];
    }
}

#pragma mark - KVO
//这里主要实现界面拖动跟随
- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context
{
    if ([keyPath isEqualToString:@"contentOffset"] && self.shouldObserving) {
        //每页宽度
        CGFloat pageWidth = self.scrollView.frame.size.width;
        //根据当前的坐标与页宽计算当前页码
        NSUInteger currentPage = floor((self.scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
        if (currentPage > self.scrollMenu.menus.count - 1)
            currentPage = self.scrollMenu.menus.count - 1;
        
        CGFloat oldX = currentPage * CGRectGetWidth(self.scrollView.frame);
        if (oldX != self.scrollView.contentOffset.x) {
            BOOL scrollingTowards = (self.scrollView.contentOffset.x > oldX);
            NSInteger targetIndex = (scrollingTowards) ? currentPage + 1 : currentPage - 1;
            if (targetIndex >= 0 && targetIndex < self.scrollMenu.menus.count) {
                CGFloat ratio = (self.scrollView.contentOffset.x - oldX) / CGRectGetWidth(self.scrollView.frame);
                CGRect previousMenuButtonRect = [self.scrollMenu rectForSelectedItemAtIndex:currentPage];
                CGRect nextMenuButtonRect = [self.scrollMenu rectForSelectedItemAtIndex:targetIndex];
                CGFloat previousItemPageIndicatorX = previousMenuButtonRect.origin.x;
                CGFloat nextItemPageIndicatorX = nextMenuButtonRect.origin.x;
                
                CGRect indicatorViewFrame = self.scrollMenu.indicatorView.frame;
                
                if (scrollingTowards) {
                    indicatorViewFrame.size.width = CGRectGetWidth(previousMenuButtonRect) + (CGRectGetWidth(nextMenuButtonRect) - CGRectGetWidth(previousMenuButtonRect)) * ratio;
                    indicatorViewFrame.origin.x = previousItemPageIndicatorX + (nextItemPageIndicatorX - previousItemPageIndicatorX) * ratio;
                } else {
                    indicatorViewFrame.size.width = CGRectGetWidth(previousMenuButtonRect) - (CGRectGetWidth(nextMenuButtonRect) - CGRectGetWidth(previousMenuButtonRect)) * ratio;
                    indicatorViewFrame.origin.x = previousItemPageIndicatorX - (nextItemPageIndicatorX - previousItemPageIndicatorX) * ratio;
                }
                
                self.scrollMenu.indicatorView.frame = indicatorViewFrame;
            }
        }
    }
}

@end
