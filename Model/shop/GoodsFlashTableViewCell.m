//
//  FlashTableViewCell.m
//  JiXie
//
//  Created by air on 15/5/25.
//  Copyright (c) 2015年 ORANLLC_IOS1. All rights reserved.
//

#import "GoodsFlashTableViewCell.h"
#import "GoodsFlashCollectionViewCell.h"
#import "GrayPageControl.h"

@interface GoodsFlashTableViewCell()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIScrollViewDelegate>
{
    IBOutlet UICollectionView *_collectionView;
    NSInteger _curPage;
     GrayPageControl *_pageCl;
    NSInteger _pageCount;
        BOOL _isContiniue;
    NSMutableArray *_dataArr;
    UIButton *showMoreBtn;//更多表演
}
@end
@implementation GoodsFlashTableViewCell

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
    [self initCollectionView];
    _curPage = 1;
    _isContiniue = NO;
    [self autoScroll];
     _pageCl.pageIndicatorTintColor = kUIColorFromRGB(color_686868);
        _pageCl.currentPageIndicatorTintColor = kUIColorFromRGB(color_3);
}

-(void)autoScroll
{
    [self performSelector:@selector(scroll) withObject:nil afterDelay:5];
}

-(void)scroll
{
    if (_dataArr.count > 1) {
         [_collectionView setContentOffset:CGPointMake(_curPage*_collectionView.frame.size.width, 0) animated:YES];
    }
   
        _curPage++;
    if (_isContiniue) {
        [self  autoScroll];
    }
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    if (_curPage >= _pageCount + 1) {
        _curPage = 1;
        [_collectionView setContentOffset:CGPointMake(0,0)];
    }
}
-(void)initCollectionView
{
    [_collectionView registerNib:[UINib nibWithNibName:@"GoodsFlashCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"cnid"];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.pagingEnabled = YES;
    
}
 -(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize size =  CGSizeMake(__SCREEN_SIZE.width,__SCREEN_SIZE.width * self.cellHeight/360.0);
    return size;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return   _pageCount == 0?0 : _pageCount == 1 ?1:_pageCount + 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
     GoodsFlashCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cnid" forIndexPath:indexPath];
    NSInteger row = indexPath.row;
    if (row == _pageCount) {
        row = 0;
    }
    NSDictionary *dic = _dataArr[row];
     cell.imgView.image = [UIImage imageNamed:@"defaultBanner"];
     cell.imgView.backgroundColor = kUIColorFromRGB(color_f8f8f8);
     cell.imgView.contentMode = UIViewContentModeCenter;
//     cell.layer.cornerRadius = 0;
    BUImageRes *img = dic[@"img"];
    if ([img isKindOfClass:[NSString class]]) {
         if ([img length] >0) {
              cell.imgView.contentMode = UIViewContentModeScaleToFill;
               cell.imgView.image = [UIImage imageContentWithFileName:dic[@"img"]];
         }
        
    }
    else
    {
//    cell.imgView.image = [UIImage imageContentWithFileName:@"defaultServer2"];
    if (img.isCached) {
        UIImage *im = [UIImage imageWithContentsOfFile:img.cacheFile];
        if (im) {
             cell.imgView.contentMode = UIViewContentModeScaleToFill;
            cell.imgView.image = im;
        }
        
    }
    else {
        [img download:self callback:@selector(getImgNotification:) extraInfo:@{@"index":indexPath}];
    }
    }
//    if (dic[@"isVideo"]) {
//        UIImageView *imv = [cell.imgView viewWithTag:1807];
//        if ([dic[@"isVideo"] boolValue]) {
//            if (!imv) {
//                imv = [[UIImageView alloc]initWithFrame:CGRectMake(__SCREEN_SIZE.width/2.0-55/2.0, cell.height/2.0 - 55/2.0, 55, 55)];
//                imv.tag = 1807;
//                imv.image = [UIImage imageNamed:@"vodio"];
//                [cell.imgView addSubview:imv];
//            }
//            imv.hidden = NO;
//        }else{
//            imv.hidden = YES;
//        }
//
//    }else{
//        UIImageView *imv = [cell.imgView viewWithTag:1807];
//        imv.hidden = YES;
//    }
//    轮播图文字
//   if([[dic allKeys] containsObject:@"text"]) {
//        [cell.textLbl setText:dic[@"text"]];
//        int colorRGB = [[self convertHexStrToString:dic[@"textColor"]] intValue] ;
//        [cell.textLbl setTextColor:kUIColorFromRGB(colorRGB)];
//    }

    return cell;
}

-(void)setCellData:(NSDictionary *)dataDic
{
    _dataArr = [dataDic[@"arr"] mutableCopy];
    if (_dataArr.count == 0) {
        [_dataArr addObject:@{@"img":[BUImageRes new]}];
    }
    _pageCount = _dataArr.count;
//    _pageCl.numberOfPages = _pageCount;
//    if (_pageCount <=1 ) {
//        _isContiniue = NO;
//         _pageCl.numberOfPages = 0;
//    }
//    else
//    {
//        _isContiniue = YES;
//    }
     
     
     _pageCl = [self.contentView viewWithTag:5444];
     if (!_pageCl) {
          _pageCl = [[GrayPageControl alloc] initWithFrame:CGRectMake(0, 0, __SCREEN_SIZE.width-30, 20)];
          _pageCl.tag = 5444;
          _pageCl.userInteractionEnabled = NO;
          _pageCl.backgroundColor = [UIColor clearColor];
          
     }
     
     _pageCl.autoresizingMask = UIViewAutoresizingFlexibleRightMargin| UIViewAutoresizingFlexibleBottomMargin;
     _pageCl.numberOfPages =_dataArr.count;
     
     _pageCl.width = __SCREEN_SIZE.width-30;
     _pageCl.height = 20;
     _pageCl.x = __SCREEN_SIZE.width/2.0 - _pageCl.width/2.0;
     _pageCl.y = self.height-20;
     [self.contentView addSubview:_pageCl];
     [_pageCl setCurrentPage:0];
     [_pageCl updateDots];
     
     if(_dataArr.count <= 1)
     {
          _pageCl.hidden = YES;
          _isContiniue = NO;
          
     }
     else
     {
          _pageCl.hidden = NO;
          _isContiniue = YES;
     }
     
     
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    [_collectionView reloadData];
}


//将十六进制的字符串转换成NSString则可使用如下方式:
- (NSString *)convertHexStrToString:(NSString *)str {
    unsigned int value = 0;
    NSScanner *scanner = [NSScanner scannerWithString:str];
    [scanner setScanLocation:1];
    [scanner scanHexInt:&value];
    
    NSLog(@"%d",value);
    
    NSString *intStr=[NSString stringWithFormat:@"%d",value];
    NSLog(@"int str %@",intStr);
    return intStr;
}

#pragma mark --Notification
static NSString *errorDomain;
-(void)getImgNotification:(BSNotification *) noti
{
    if(noti.error.code ==0)
    {
        BUImageRes *res =(BUImageRes *) noti.target;
        if (res.isCached) {
            NSIndexPath * path = (NSIndexPath *)noti.extraInfo[@"index"];
            GoodsFlashCollectionViewCell *cell = (GoodsFlashCollectionViewCell *)[_collectionView cellForItemAtIndexPath:path];
            UIImage *im = [UIImage imageWithContentsOfFile:res.cacheFile] ;
            if (im) {
                 cell.imgView.contentMode = UIViewContentModeScaleToFill;
                cell.imgView.image = im;
            }
        }
    }
}

-(void)reloadData
{
    [_collectionView reloadData];
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    if (row == _pageCount) {
        row = 0;
    }
    if (_selecedtItem) {
        _selecedtItem(@{@"row":@(row)});
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)sender
{
    _isContiniue = NO;
      CGFloat pageWidth = sender.frame.size.width;
    int currentPage = floor((sender.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    if(currentPage == _pageCount)
    {
        [_collectionView setContentOffset:CGPointMake(0, 0)];
    }

}
- (void) scrollViewDidScroll:(UIScrollView *)sender {
    // 得到每页宽度
    CGFloat pageWidth = sender.frame.size.width;
    // 根据当前的x坐标和页宽度计算出当前页数
    int currentPage = floor((sender.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    if(currentPage == _pageCount)
    {
        currentPage = 0;
    }
    _pageCl.currentPage= currentPage;
    
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (!_isContiniue) {
        _isContiniue = YES;
        _curPage = _pageCl.currentPage + 1;
    }
    
}

-(void)fitHeadMode
{
    self.height = __SCREEN_SIZE.width * 153/360.0;
   _cellHeight = 153;
    [_collectionView reloadData];
    _pageCl.pageIndicatorTintColor = kUIColorFromRGBWithAlpha(color_2, 0.7);
     if(__IOS9)
    _pageCl.currentPageIndicatorTintColor = kUIColorFromRGB(color_3);
//    self.backgroundColor = kUIColorFromRGB(color_3);
//    _collectionView.backgroundColor = [UIColor blueColor];
}

-(void)fitClassifyMode
{
     self.height = __SCREEN_SIZE.width * 115/360.0;
     _cellHeight = 115;
     [_collectionView reloadData];
     _pageCl.pageIndicatorTintColor = kUIColorFromRGBWithAlpha(color_2, 0.7);
     if(__IOS9)
          _pageCl.currentPageIndicatorTintColor = kUIColorFromRGB(color_13);
     //    self.backgroundColor = kUIColorFromRGB(color_3);
     //    _collectionView.backgroundColor = [UIColor blueColor];
}


-(void)fitSpecialInfoMode
{
     self.height = __SCREEN_SIZE.width * 200/360.0;
     _cellHeight = 200;
     [_collectionView reloadData];
     _pageCl.pageIndicatorTintColor = kUIColorFromRGBWithAlpha(color_2, 0.7);
      if(__IOS9)
     _pageCl.currentPageIndicatorTintColor = kUIColorFromRGB(color_13);
     //    self.backgroundColor = kUIColorFromRGB(color_3);
     //    _collectionView.backgroundColor = [UIColor blueColor];
}

-(void)fitParkingInfoMode
{
    _pageCl.tintColor = kUIColorFromRGB(color_3);
     self.height = __SCREEN_SIZE.width * 464/720.0;
    _cellHeight = 464;
     [_collectionView reloadData];
}

-(void)fitHeadMode_head{
//    _pageCl.tintColor = kUIColorFromRGB(color_8);
    _pageCl.currentPageIndicatorTintColor = kUIColorFromRGB(color_8);
    _pageCl.pageIndicatorTintColor = kUIColorFromRGB(color_5);
    self.height = __SCREEN_SIZE.width * 302/720.0;
    _cellHeight = 302;
    [_collectionView reloadData];
}

-(void)fitHeadMode_Second{
//    _pageCl.tintColor = kUIColorFromRGB(color_8);
    _pageCl.currentPageIndicatorTintColor = kUIColorFromRGB(color_8);
    _pageCl.pageIndicatorTintColor = kUIColorFromRGB(color_5);
    self.height = __SCREEN_SIZE.width * 150/720.0;
    _cellHeight = 150;
    [_collectionView reloadData];
}

-(void)fitCompanyInfoMode{
    _pageCl.currentPageIndicatorTintColor = kUIColorFromRGB(color_3);
    _pageCl.pageIndicatorTintColor = kUIColorFromRGBWithAlpha(0x686868, 0.8);
    self.height = __SCREEN_SIZE.width * 400/720.0;
    _cellHeight = 400;
    [_collectionView reloadData];
}

-(void)fitGoodsInfoMode{
     _pageCl.currentPageIndicatorTintColor = kUIColorFromRGB(color_3);
     _pageCl.pageIndicatorTintColor = kUIColorFromRGBWithAlpha(0x686868, 0.8);
     self.height = __SCREEN_SIZE.width * 720/720.0;
     _cellHeight = 360;
     [_collectionView reloadData];
}

-(void)fitExclusiveAppointmentMode{
    
    _pageCl.currentPageIndicatorTintColor = kUIColorFromRGB(color_3);
    _pageCl.pageIndicatorTintColor = kUIColorFromRGBWithAlpha(0x686868, 0.8);
    self.height = __SCREEN_SIZE.width * 400/720.0;
    _cellHeight = 400;
    [_collectionView reloadData];
    if (showMoreBtn == nil) {
        showMoreBtn = [[UIButton alloc]init];
        [showMoreBtn setTitle:@"更多表演 >" forState:UIControlStateNormal];
        [showMoreBtn setTitleColor:kUIColorFromRGB(color_2) forState:UIControlStateNormal];
        showMoreBtn.backgroundColor = kUIColorFromRGBWithAlpha(color_1, 0.7);
        showMoreBtn.width = 50;
        showMoreBtn.height = 12;
        showMoreBtn.x = __SCREEN_SIZE.width -showMoreBtn.width -15;
        showMoreBtn.y = self.height - showMoreBtn.height-10;
        showMoreBtn.titleLabel.font = [UIFont systemFontOfSize:9];
        [showMoreBtn addTarget:self action:@selector(showMoreAction) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:showMoreBtn];
    }
}

-(void)showMoreAction{
    if (_showMore) {
        _showMore(@{});
    }
}

-(void)setNull
{
    _isContiniue = NO;
    _collectionView.dataSource = nil;
    _collectionView.delegate = nil;
// _collectionView = nil;
    
//    _dataArr = Nil;
//    _pageCl = nil;;
//    _textLbl = nil;
//    _showMore = nil;
//    _selecedtItem = nil;
//    showMoreBtn = nil;
}

-(void)dealloc
{
   
    _collectionView = nil;
}
@end
