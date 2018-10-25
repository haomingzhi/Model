//
//  FourTabsTableViewCell.m
//  rentingshop
//
//  Created by Steve on 2018/4/26.
//  Copyright © 2018年 ORANLLC_IOS1. All rights reserved.
//

#import "FourTabsTableViewCell.h"
#import "TitleDetailTableViewCell.h"
#import "ImgsTableViewCell.h"
#import "ImgAndThreeTitleTableViewCell.h"

@implementation FourTabsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
     [self initScrollView];
     [self setTableViews];
}

-(void)initScrollView{
     _scrollView.pagingEnabled = YES;
     _scrollView.x= 0;
     _scrollView.y = 45;
     _scrollView.width = __SCREEN_SIZE.width;
     _scrollView.height = __SCREEN_SIZE.height - NAVBARHEIGHT - TABBARNONEHEIGHT -54 - 45;
     _scrollView.bounces = NO;
     _scrollView.contentSize = CGSizeMake(__SCREEN_SIZE.width*4, _scrollView.height);
     _scrollView.showsHorizontalScrollIndicator = NO;
     _scrollView.delegate = self;
     
     [self  initTableView];
     
     
     
     _menuView = [[ZJMenuView alloc]initWithFrame:CGRectMake(0, 0, __SCREEN_SIZE.width, 45)];
     [_menuView setData:@[@"图文详情",@"商品参数",@"租赁规则",@"用户评价"]];
     _menuView.layer.borderColor = kUIColorFromRGB(color_lineColor).CGColor;
     _menuView.layer.borderWidth = 0.5;
     [self addSubview:_menuView];
     __weak FourTabsTableViewCell *weakSelf = self;
     [_menuView setHandle:^(UIButton *btn) {
          weakSelf.state = btn.tag;
          [_scrollView scrollRectToVisible:CGRectMake(__SCREEN_SIZE.width*btn.tag, 0, __SCREEN_SIZE.width, _scrollView.height) animated:YES];
     }];
     
}



-(void)initTableView{
     
     _tableViewA.x= 0 ;
     _tableViewA.width = __SCREEN_SIZE.width;
     _tableViewA.y = 0;
     _tableViewA.height = _scrollView.height;
     
     
     _tableViewB.x= __SCREEN_SIZE.width  ;
     _tableViewB.width = __SCREEN_SIZE.width;
     _tableViewB.y = 0;
     _tableViewB.height = _scrollView.height;
     
     _tableViewC.x= __SCREEN_SIZE.width *2 ;
     _tableViewC.width = __SCREEN_SIZE.width;
     _tableViewC.y = 0;
     _tableViewC.height = _scrollView.height;
     
     _tableViewD.x= __SCREEN_SIZE.width *3 ;
     _tableViewD.width = __SCREEN_SIZE.width;
     _tableViewD.y = 0;
     _tableViewD.height = _scrollView.height;
     
     _noEvaCell = [NoDataTableViewCell createTableViewCell];
     [_noEvaCell setCellData:@{@"title":@"暂无评价",@"img":@"noEva"}];
     [_noEvaCell fitCellMode];

     _intruduceCell = [OnlyTitleTableViewCell createTableViewCell];
     [_intruduceCell setCellData:@{@"title":@""}];
     [_intruduceCell fitHtmlMode];
     
     
     _rentRegularCell = [OnlyTitleTableViewCell createTableViewCell];
     [_rentRegularCell setCellData:@{@"title":@""}];
     [_rentRegularCell fitHtmlMode];
     
     
     [ImgAndThreeTitleTableViewCell registerTableViewCell:_tableViewD];
     [ImgsTableViewCell registerTableViewCell:_tableViewD];

     
     [TitleDetailTableViewCell registerTableViewCell:_tableViewB];
     
     _tableViewA.delegate = self;
     _tableViewA.dataSource = self;
     _tableViewB.delegate = self;
     _tableViewB.dataSource = self;
     _tableViewC.delegate = self;
     _tableViewC.dataSource = self;
     _tableViewD.delegate = self;
     _tableViewD.dataSource = self;
     
     
     _tableViewA.refreshHeaderView = nil;
     _tableViewA.backgroundColor = kUIColorFromRGB(color_f8f8f8);
     _tableViewA.showsVerticalScrollIndicator = NO;
//     _tableViewA.bounces = NO;
//     _tableViewB.bounces = NO;
//     _tableViewC.bounces = NO;
//     _tableViewD.bounces = NO;
     
     
     _tableViewB.refreshHeaderView = nil;
     _tableViewB.backgroundColor = kUIColorFromRGB(color_f8f8f8);
     _tableViewB.showsVerticalScrollIndicator = NO;
     
     _tableViewC.refreshHeaderView = nil;
     _tableViewC.backgroundColor = kUIColorFromRGB(color_f8f8f8);
     _tableViewC.showsVerticalScrollIndicator = NO;
     
     _tableViewD.refreshHeaderView = nil;
     _tableViewD.backgroundColor = kUIColorFromRGB(color_f8f8f8);
     _tableViewD.showsVerticalScrollIndicator = NO;
     
     
     self.backgroundColor = kUIColorFromRGB(color_f8f8f8);
     
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
     if (scrollView == _scrollView) {
         NSInteger index =  _scrollView.contentOffset.x/__SCREEN_SIZE.width;
          [_menuView setCurrenItem:index];
     }
}

//-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
//     if ([scrollView isKindOfClass:[MyTableView class]]) {
//          if (<#condition#>) {
//               <#statements#>
//          }
//     }
//}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
     
     if ([scrollView isKindOfClass:[MyTableView class]]) {
           CGFloat contentOffsetY = scrollView.contentOffset.y;
          if (contentOffsetY <=0) {
               [self changeTableViewScroll:NO];
               if (self.handleAction) {
                    self.handleAction(@{@"index":@(0),@"y":@(contentOffsetY)});
               }
          }
          
          if (_tableViewD == scrollView) {
               //判断是否滑动到底部
               CGFloat height = scrollView.frame.size.height;
               CGFloat contentOffsetY = scrollView.contentOffset.y;
               CGFloat bottomOffset = scrollView.contentSize.height - contentOffsetY;
               if (bottomOffset <= height && contentOffsetY >height)
               {
                    _tableViewD.scrollEnabled = NO;
                    self.handleAction(@{@"index":@(0),@"y":@(0)});
               }
          }
     }
     
    
}


-(void)changeTableViewScroll:(BOOL)canScroll{
     _tableViewA.scrollEnabled = canScroll;
     _tableViewB.scrollEnabled = canScroll;
     _tableViewC.scrollEnabled = canScroll;
     _tableViewD.scrollEnabled = canScroll;
     
}

#pragma mark - tableView delegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
     
     NSInteger section = 1;
     if (_tableViewD == tableView) {
          section =  _tableViewD.extroDataArr.count?:1;
     }
     return section;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
     NSInteger row = 2;

     if (_tableViewA == tableView){//图文详情
          row = 1;
     }
     else if (_tableViewB == tableView){//商品参数
//          row = _goodsInfo.productParamterList.count;
     }
     else if (_tableViewC == tableView){//租赁规则
          row = 1;
     }
     else{//用户评价
          if (_tableViewD.extroDataArr.count == 0) {//无评价
               row = 1;
          }else
               row = 2;
     }

     
     return row;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
     UITableViewCell *cell;
     //    cell = [UITableViewCell new];
     
     if (_tableViewA == tableView){//图文详情
          cell = _intruduceCell;
     }
     else if (_tableViewB == tableView){//商品参数
          cell = [self createParameterCell:indexPath];
     }
     else if (_tableViewC == tableView){//租赁规则
          cell = _rentRegularCell;
     }
     else{//用户评价
          cell = [self createEvaInfoCell:indexPath];
     }

     cell.selectionStyle = UITableViewCellSelectionStyleNone;
     return cell;
}



-(UITableViewCell *)createParameterCell:(NSIndexPath *)indexPath{
     TitleDetailTableViewCell *cell ;
     
     cell = [TitleDetailTableViewCell createTableViewCell];
//     BUProductParamter *p = _goodsInfo.productParamterList[indexPath.row];
     NSDictionary *dic;// = [p getDic];
     [cell setCellData:dic];
     if (indexPath.row == 0) {
          [cell fitGoodsInfoMode:20];
     }else{
          [cell fitGoodsInfoMode:13];
     }
     
     
     return cell;
}



-(UITableViewCell *)createEvaInfoCell:(NSIndexPath *)indexPath{
     UITableViewCell *cell ;
     
     if (_tableViewD.extroDataArr.count == 0) {
          cell = _noEvaCell;
     }
     else{
//          BUGetComment *comment = _tableViewD.extroDataArr[indexPath.section];
          if (indexPath.row == 0) {
               cell = [ImgAndThreeTitleTableViewCell dequeueReusableCell:_tableViewD];
               NSDictionary *dic;// = [comment getDic:0];;
               [(ImgAndThreeTitleTableViewCell *)cell setCellData:dic];
               [(ImgAndThreeTitleTableViewCell *)cell fitEvaMode];
               //          if (comment.imageList.count == 0) {
               //               [(JYAbstractTableViewCell *)cell showSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(cell.height, 0, 0, 0)];
               //          }else{
               [(JYAbstractTableViewCell *)cell hiddenSeparatorView];
               //          }
          }else{
               cell = [ImgsTableViewCell dequeueReusableCell:_tableViewD];
               
               
               //          if (comment.imageList.count == 0) {
               //               cell.hidden = YES;
               //               [(JYAbstractTableViewCell *)cell hiddenSeparatorView];
               //          }else{
               NSDictionary *dic;// = [comment getDic:1];
               [(ImgsTableViewCell *)cell setCellData:dic];
               [(ImgsTableViewCell *)cell fitTopicMode];
               [(JYAbstractTableViewCell *)cell showSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(cell.height, 0, 0, 0)];
               //          }
               __weak FourTabsTableViewCell *weakSelf = self;
               [(ImgsTableViewCell *)cell setHandleAction:^(NSDictionary *dic) {
                    NSInteger row = [dic[@"row"] integerValue];
                    NSMutableArray *imgArr = [NSMutableArray new];
                    NSArray *arr;// = comment.picList;
                    if (arr.count !=0) {
                         for (int i =0;i<arr.count;i++) {
                              UIImageView *myImageView = [[UIImageView alloc]init];
                              [imgArr addObject:myImageView];
                         }
                         if (weakSelf.handleAction) {
                              weakSelf.handleAction(@{@"index":@(1),@"arr":arr?:@[],@"row":@(row),@"imgArr":imgArr});
                         }
//                         [weakSelf setupPhotoBrowser:@{@"arr":arr?:@[],@"row":@(row),@"imgArr":imgArr}];
                    }
               }];
               
          }
     }
     
     
     
     return cell;
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
     CGFloat height = 35;
          if (_tableViewA == tableView) {
               height = _intruduceCellHeight;
//               height = __SCREEN_SIZE.height;
          }
          else if (_tableViewB == tableView){
               TitleDetailTableViewCell *cell;
               cell = [TitleDetailTableViewCell createTableViewCell];
//               BUProductParamter *p = _goodsInfo.productParamterList[indexPath.row];
               NSDictionary *dic;// = [p getDic];
               [cell setCellData:dic];
               if (indexPath.row == 0) {
                    [cell fitGoodsInfoMode:20];
               }else{
                    [cell fitGoodsInfoMode:13];
               }
               if (indexPath.row) {
                    height = cell.height+20;
               }else{
                    height = cell.height;
               }
               
               
          }
          else if (_tableViewC == tableView){
               height = _rentRegularCellHeight;
          }else if (_tableViewD == tableView){
               if (_tableViewD.extroDataArr.count == 0) {
                    height = 250;
               }else{
                    UITableViewCell *cell;
//                    BUGetComment *comment = _tableViewD.extroDataArr[indexPath.section];
                    if (indexPath.row == 0) {
                         cell = [ImgAndThreeTitleTableViewCell dequeueReusableCell:_tableViewD];
                         NSDictionary *dic;// = [comment getDic:0];
                         [(ImgAndThreeTitleTableViewCell *)cell setCellData:dic];
                         [(ImgAndThreeTitleTableViewCell *)cell fitEvaMode];
                         height = cell.height;
                    }else{
                         cell = [ImgsTableViewCell dequeueReusableCell:_tableViewD];
                         
                         NSDictionary *dic;// = [comment getDic:1];
                         [(ImgsTableViewCell *)cell setCellData:dic];
                         [(ImgsTableViewCell *)cell fitTopicMode];
                         height = cell.height;
                         
                    }
               }
               
               
               
          }
     return height;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
     CGFloat height = 0.001;
     return height;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
     return 0.01;
}


-(void)setCellData:(NSDictionary *)dataDic
{
//     _goodsInfo = dataDic[@"goods"];
//     [_intruduceCell setCellData:[_goodsInfo getDic:3]];
     [_intruduceCell fitHtmlMode];
     _intruduceCellHeight = _intruduceCell.height;
     [_tableViewA reloadData];
     [_tableViewB reloadData];
     [_tableViewC reloadData];
}


-(void)setEvaData:(NSDictionary *)dataDic
{
//     _goodsInfo = dataDic[@"goods"];
     _tableViewD.extroDataArr = [NSMutableArray arrayWithArray:dataDic[@"eva"]];
     [_tableViewD reloadData];
//     _tableViewD.hasMore = busiSystem.getCommentListManager.pageInfo.hasMore;
//     [[JYNoDataManager manager] addNodataView:_tableViewD withTip:@"暂无评价" withImg:@"noEva" withCount:_tableViewD.extroDataArr.count withTag:@"eva"];
//     [[JYNoDataManager manager] fitModeY:100];

}



-(void) setTableViews
{
     [BSUtility loopView:self condition:^BOOL(UIView * tableView) {
          return [tableView isKindOfClass:[UITableView class]];
     } finded:^BOOL(UIView *findedView) {
          UITableView *tableView = (UITableView *) findedView;
          tableView.delegate = self;
          tableView.dataSource = self;
          tableView.backgroundColor = kUIColorFromRGB(0xf5f5f5);
          tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, 1)];
          if ([tableView isKindOfClass:[MyTableView class]]) {
               MyTableView *myTableView = (MyTableView *) findedView;
               myTableView.refreshHeaderView =  [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0, 0, 1, 1)];
               myTableView.refreshHeaderView.delegate = self;
               myTableView.refreshFooterView = [[EGORefreshTableFooterView alloc] initWithFrame:CGRectMake(0, 0, 1, 40)];
               myTableView.refreshFooterView.showLoading = YES;
               myTableView.refreshFooterView.delegate = self;
               myTableView.headHasMore = YES;
               //myTableView.backgroundColor = kUIColorFromRGB(color_backgroundView);
          }
          return NO;
     }];
     
}


-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
     if ([tableView respondsToSelector:@selector(setSeparatorInset:)]) {
          [tableView setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
     }
     if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
          [cell setLayoutMargins:UIEdgeInsetsZero];
     }
}

-(void)viewDidLayoutSubviews
{
     [BSUtility loopView:self condition:^BOOL(UIView * tableView) {
          return [tableView isKindOfClass:[UITableView class]];
     } finded:^BOOL(UIView *findedView) {
          UITableView *tableView = (UITableView *) findedView;
          if ([tableView respondsToSelector:@selector(setSeparatorInset:)]) {
               [tableView setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
          }
          if ([tableView respondsToSelector:@selector(setLayoutMargins:)]) {
               [tableView setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
          }
          return NO;
     }];
}

-(void) refreshTableHeaderNotification:(BSNotification *) noti myTableView:(MyTableView*) tableView
{
     [tableView.refreshHeaderView resetState:YES];
     [tableView.refreshFooterView setStatusText:@""];
     [tableView.refreshFooterView resetState:YES];
}

#pragma mark -- EGORefreshTableHeaderDelegate
//todo 调用网络层，然后在回调中执行[self.tableView.refreshHeaderView resetState:YES];
- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view
{
     [self refreshCurentPage];
}

- (NSString*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view
{
     //    return [BSUtility getSystemTime];
     return @"";
}

#pragma mark -- EGORefreshTableFooterDelegate

- (void)egoRefreshTableFooterDidTriggerRefresh:(EGORefreshTableFooterView*)view
{
     MyTableView *tableView = (MyTableView*) view.superview;
     //这里控制显示loading和控制显示的文字。。。并且进行网络调用
     view.showLoading = YES;
     if (tableView.hasMore) {
          [view setStatusText:@"加载更多..."];
          [self loadNextPage];
     }
     else{
          [view setStatusText:@"没有更多数据了"];
          [view resetState:false];
     }
     
}


-(void) refreshCurentPage
{
     NSLog(@"%@",@"没实现");
}

-(void) loadNextPage
{
//     [busiSystem.getCommentListManager getCommentListNextPage:self callback:@selector(getCommentListNotification:)];
}


-(void)getCommentListNotification:(BSNotification *)noti
{
   
//     HUDDISMISS;
    
     
     if (noti.error.code == 0) {
          
//          _tableViewD.extroDataArr = [NSMutableArray arrayWithArray:busiSystem.getCommentListManager.getCommentList];

          [_tableViewD reloadData];

     }
     else
     {
//          HUDCRY( noti.error.domain , 1);
     }
     
}


@end
