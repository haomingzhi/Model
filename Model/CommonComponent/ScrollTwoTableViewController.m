//
//  ScrollTwoTableViewController.m
//  lovecommunity
//
//  Created by air on 16/6/23.
//  Copyright © 2016年 ORANLLC_IOS1. All rights reserved.
//

#import "ScrollTwoTableViewController.h"

@interface ScrollTwoTableViewController ()
@property (strong, nonatomic) IBOutlet MyTableView *tableViewA;
@property (strong, nonatomic) IBOutlet MyTableView *tableViewB;

@end

@implementation ScrollTwoTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initScroll];
    _tableViewA.delegate = nil;
    _tableViewA.dataSource = nil;
    
    _tableViewB.delegate = nil;
    _tableViewB.dataSource = nil;
    [self initTableView];
    [self.tDelegate getData:_tableViewA];
    [self.tDelegate getData:_tableViewB];
}

-(void)initTableView
{
    [self.tDelegate initTableView:_tableViewA];
    [self.tDelegate initTableView:_tableViewB];
}

-(void)setTableViewsScrollEnabled:(BOOL)b
{
    
    _tableViewB.scrollEnabled = b;
    _tableViewA.scrollEnabled = b;
}

-(void)tableViewToTop
{
    if (_tableViewB.scrollEnabled && _tableViewB.delegate && _tableViewB.dataSource) {
        
        [_tableViewB setContentOffset:CGPointMake(0, 0)];
    }
    if (_tableViewA.scrollEnabled && _tableViewA.delegate && _tableViewA.dataSource) {
        [_tableViewA setContentOffset:CGPointMake(0, 0)];
    }
}

-(MyTableView *)getTableView
{
      CGFloat pageWidth = ((UIScrollView *)self.view).frame.size.width;
 int currentPage = floor((((UIScrollView *)self.view).contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    if (currentPage == 0) {
        return _tableViewA;
    }
    return _tableViewB;
}

-(void)initScroll
{
    [(UIScrollView *)self.view setContentSize:CGSizeMake(__SCREEN_SIZE.width * 2, __SCREEN_SIZE.height - 64 - 44)];
    _tableViewA.x = 0;
    _tableViewB.x = __SCREEN_SIZE.width;
//    _tableViewC.x = __SCREEN_SIZE.width * 2;
    [self.view addObserver:self forKeyPath:@"height" options:NSKeyValueObservingOptionNew context:nil];
}

-(void)dealloc
{
    [self.view removeObserver:self forKeyPath:@"height"];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"height"]) {
        [(UIScrollView *)self.view setContentSize:CGSizeMake(__SCREEN_SIZE.width * 2, self.view.height)];
    }
}

-(void)selectCurIndex:(NSInteger)index
{
    [(UIScrollView *)self.view setContentOffset:CGPointMake(index * __SCREEN_SIZE.width, 0) animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    _tableViewA.delegate = _tDelegate;
    _tableViewA.dataSource = _tDelegate;
    
    _tableViewB.delegate = _tDelegate;
    _tableViewB.dataSource = _tDelegate;
    
    [_tableViewA reloadData];
    [_tableViewB reloadData];
//
//    _tableViewC.delegate = self;
//    _tableViewC.dataSource = self;
    [(UIScrollView *)self.view setDelegate:self];
}

-(void)viewDidDisappear:(BOOL)animated
{
    [(UIScrollView *)self.view setDelegate:nil];
    _tableViewA.delegate = nil;
    _tableViewA.dataSource = nil;
    
    _tableViewB.delegate = nil;
    _tableViewB.dataSource = nil;
 
}

//-(void)deallocDelegate
//{
//    
//    
////        _tableViewC.delegate = nil;
////        _tableViewC.dataSource = nil;
//}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)sender{
    // 得到每页宽度
    if (sender != self.view) {
        return;
    }
    CGFloat pageWidth = sender.frame.size.width;
    // 根据当前的x坐标和页宽度计算出当前页数
    int currentPage = floor((sender.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    if (_scrollHandle) {
        _scrollHandle(currentPage);
    }
    //    _curPage = currentPage + 1;
    //    if(currentPage == _pageCount)
    //    {
    //        //        _curPage = 1;
    //        currentPage = 0;
    //        //        [_collectionView setContentOffset:CGPointMake(0, 0)];
    //    }
    //    _pageCl.currentPage= currentPage;
    
}

-(void)refreshData
{
    [self.tDelegate refreshData:_tableViewA];
      [self.tDelegate refreshData:_tableViewB];
}

-(void)refreshData:(NSInteger )index
{
    if (index == 0) {
         [self.tDelegate refreshData:_tableViewA];
    }
    else
    {
      [self.tDelegate refreshData:_tableViewB];
    }
   
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
