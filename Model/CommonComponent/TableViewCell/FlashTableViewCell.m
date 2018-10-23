//
//  FlashTableViewCell.m
//  JiXie
//
//  Created by air on 15/5/25.
//  Copyright (c) 2015年 ORANLLC_IOS1. All rights reserved.
//

#import "FlashTableViewCell.h"
#import "FlashCollectionViewCell.h"
#import "GrayPageControl.h"
@interface FlashTableViewCell()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIScrollViewDelegate>
{
    IBOutlet UICollectionView *_collectionView;
    NSInteger _curPage;
    IBOutlet GrayPageControl *_pageCl;
    NSInteger _pageCount;
        BOOL _isContiniue;
    NSMutableArray *_dataArr;
    UIButton *showMoreBtn;//更多表演

}
@end
@implementation FlashTableViewCell

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
    [self performSelector:@selector(scroll) withObject:nil afterDelay:3];
}

-(void)scroll
{
    if (_dataArr.count > 1) {
         [_collectionView setContentOffset:CGPointMake(_curPage*_collectionView.frame.size.width, 0) animated:YES];
//         FlashCollectionViewCell *cl = (FlashCollectionViewCell *)[_collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:_curPage inSection:0]];
//         cl.imgView.transform = CGAffineTransformConcat(CGAffineTransformMakeScale(1, 1), CGAffineTransformMakeTranslation(0, 0));
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
//         FlashCollectionViewCell *cl = (FlashCollectionViewCell *)[_collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]];
//         cl.imgView.transform = CGAffineTransformConcat(CGAffineTransformMakeScale(1, 1), CGAffineTransformMakeTranslation(0, 0));
    }
}
-(void)initCollectionView
{
    [_collectionView registerNib:[UINib nibWithNibName:@"FlashCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"cnid"];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.pagingEnabled = YES;
    
}
 -(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize size =  CGSizeMake(__SCREEN_SIZE.width - 30,(__SCREEN_SIZE.width - 30) * self.cellHeight/330.0);
    return size;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return   _pageCount == 0?0 : _pageCount == 1 ?1:_pageCount + 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    FlashCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cnid" forIndexPath:indexPath];
    NSInteger row = indexPath.row;
    if (row == _pageCount) {
        row = 0;
    }
//       cell.imgView.transform = CGAffineTransformConcat(CGAffineTransformMakeScale(0.85, 0.85), CGAffineTransformMakeTranslation(0, 0));
//     cell.imgView.layer.cornerRadius = 6;
//     cell.imgView.layer.masksToBounds = YES;
    NSDictionary *dic = _dataArr[row];
     cell.imgView.image = [UIImage imageNamed:@"defaultBanner"];
    BUImageRes *img = dic[@"img"];
    if ([img isKindOfClass:[NSString class]]) {
         cell.imgView.image = [UIImage imageContentWithFileName:dic[@"img"]];
         
    }
    else
    {
//    cell.imgView.image = [UIImage imageContentWithFileName:@"defaultServer2"];
    if (img.isCached) {
        UIImage *im = [[UIImage imageWithContentsOfFile:img.cacheFile] getSubImage:CGRectMake(0, 0, __SCREEN_SIZE.width, 126/330.0 *(__SCREEN_SIZE.width - 30)) centerBool:YES];
        if (im) {
            cell.imgView.image = im;
                cell.imgView.contentMode = UIViewContentModeScaleToFill;
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
//    if (_dataArr.count == 0) {
//        [_dataArr addObject:@{@"img":[BUImageRes new]}];
//    }
    _pageCount = _dataArr.count;
    _pageCl.numberOfPages = _pageCount;
    if (_pageCount <=1 ) {
        _isContiniue = NO;
         _pageCl.numberOfPages = 0;
    }
    else
    {
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
            FlashCollectionViewCell *cell = (FlashCollectionViewCell *)[_collectionView cellForItemAtIndexPath:path];
            UIImage *im = [[UIImage imageWithContentsOfFile:res.cacheFile] getSubImage:CGRectMake(0, 0, __SCREEN_SIZE.width, 126/330.0 *( __SCREEN_SIZE.width - 30)) centerBool:YES];
            if (im) {
                cell.imgView.image = im;
                    cell.imgView.contentMode = UIViewContentModeScaleToFill;
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
//         FlashCollectionViewCell *cl = (FlashCollectionViewCell *)[_collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:_pageCount inSection:0]];
//         cl.imgView.transform = CGAffineTransformConcat(CGAffineTransformMakeScale(1, 1), CGAffineTransformMakeTranslation(0, 0));
    }

}
- (void) scrollViewDidScroll:(UIScrollView *)sender {
    // 得到每页宽度
    CGFloat pageWidth = sender.frame.size.width;
    // 根据当前的x坐标和页宽度计算出当前页数
    int currentPage = floor((sender.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
     UICollectionView *cv = (UICollectionView *)sender;

     if (currentPage > 0 && currentPage != _pageCount) {
          CGFloat sc = 0.65;//MIN(2 * ( (sender.contentOffset.x  -  __SCREEN_SIZE.width * (currentPage - 1))/(__SCREEN_SIZE.width * 1.0)), 1);
//          sc =  (sender.contentOffset.x  -  __SCREEN_SIZE.width * (currentPage))/(__SCREEN_SIZE.width * 1.0);
//          if ( sender.contentOffset.x  -  __SCREEN_SIZE.width * (currentPage - 1 ) > -30 && sender.contentOffset.x  -  __SCREEN_SIZE.width * (currentPage - 1 ) < 30) {
//               sc = 1;
//          }
//           FlashCollectionViewCell *pl = (FlashCollectionViewCell *)[cv cellForItemAtIndexPath:[NSIndexPath indexPathForItem:currentPage - 1 inSection:0]];
//          pl.imgView.layer.transform = CATransform3DConcat(CATransform3DMakeScale(sc, sc,1), CATransform3DMakeTranslation(__SCREEN_SIZE.width *(1- sc), 0,0));//CGAffineTransformConcat(CGAffineTransformMakeScale(sc, sc), CGAffineTransformMakeTranslation(__SCREEN_SIZE.width *(1- sc), 0));
//         pl.imgView.transform = CGAffineTransformConcat(CGAffineTransformMakeScale(sc, sc), CGAffineTransformMakeTranslation(__SCREEN_SIZE.width *(1- sc), 0));
//                    pl.imgView.layer.cornerRadius = 8;
//                    pl.imgView.layer.masksToBounds = YES;
     }
//if(currentPage == 0)
//{
//     FlashCollectionViewCell *cl = (FlashCollectionViewCell *)[cv cellForItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]];
//     cl.imgView.transform = CGAffineTransformConcat(CGAffineTransformMakeScale(1, 1), CGAffineTransformMakeTranslation(0, 0));
//}
//     else
//     {
     CGFloat csc = 0.85;//MIN(MAX(2 * ( (sender.contentOffset.x  -  __SCREEN_SIZE.width * (currentPage))/(__SCREEN_SIZE.width * 1.0)), 0.6), 1);
//     if ( sender.contentOffset.x  -  __SCREEN_SIZE.width * (currentPage ) > -30 && sender.contentOffset.x  -  __SCREEN_SIZE.width * (currentPage ) < 30) {
//          csc = 1;
//     }

//   FlashCollectionViewCell *cl = (FlashCollectionViewCell *)[cv cellForItemAtIndexPath:[NSIndexPath indexPathForItem:currentPage inSection:0]];
//     cl.imgView.transform = CGAffineTransformConcat(CGAffineTransformMakeScale(csc, csc), CGAffineTransformMakeTranslation(0, 0));
//     cl.imgView.layer.cornerRadius = 6;
//     cl.imgView.layer.masksToBounds = YES;
//     }
     if (currentPage < _pageCount) {
          CGFloat sc =0.65;// MIN(2 * ( (sender.contentOffset.x  -  __SCREEN_SIZE.width * (currentPage ))/(__SCREEN_SIZE.width * 1.0)), 1);
//          if ( sender.contentOffset.x  -  __SCREEN_SIZE.width * (currentPage) > -30 && sender.contentOffset.x  -  __SCREEN_SIZE.width * (currentPage ) < 30) {
//               sc = 1;
//          }
//          FlashCollectionViewCell *nl = (FlashCollectionViewCell *)[cv cellForItemAtIndexPath:[NSIndexPath indexPathForItem:currentPage + 1 inSection:0]];
////          nl.imgView.layer.cornerRadius = 6;
////          nl.imgView.layer.masksToBounds = YES;
//          nl.imgView.transform = CGAffineTransformConcat(CGAffineTransformMakeScale(sc, sc), CGAffineTransformMakeTranslation(-__SCREEN_SIZE.width * (1 - sc), 0));

     }

//     cl.imgView.transform = ;
    if(currentPage == _pageCount)
    {
        currentPage = 0;
//         FlashCollectionViewCell *cl = (FlashCollectionViewCell *)[_collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:_pageCount inSection:0]];
//         cl.imgView.transform = CGAffineTransformConcat(CGAffineTransformMakeScale(1, 1), CGAffineTransformMakeTranslation(0, 0));
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
     _pageCl.pageIndicatorTintColor = kUIColorFromRGB(color_8);
     if(__IOS9)
          _pageCl.currentPageIndicatorTintColor = kUIColorFromRGB(color_3);
     //    self.backgroundColor = kUIColorFromRGB(color_3);
     //    _collectionView.backgroundColor = [UIColor blueColor];
}

-(void)fitDealMode
{

     _collectionView.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _collectionView.x = 15;
     _collectionView.y = 15;
     _collectionView.layer.cornerRadius = 6;
     _collectionView.clipsToBounds = YES;
     _collectionView.width = __SCREEN_SIZE.width - 30;
     _collectionView.height =  (__SCREEN_SIZE.width - 30) * 126/330.0;
    self.height = _collectionView.height  + 36;
   _cellHeight = 126;
    [_collectionView reloadData];
    _pageCl.pageIndicatorTintColor = kUIColorFromRGBWithAlpha(color_8, 0.5);
     if(__IOS9)
    _pageCl.currentPageIndicatorTintColor = kUIColorFromRGB(color_8);
    self.contentView.backgroundColor = kUIColorFromRGB(color_2);
     _collectionView.backgroundColor = kUIColorFromRGB(color_f8f8f8);

     GrayPageControl *pageCl = [self.contentView viewWithTag:5444];
     if (!pageCl) {
          pageCl = [[GrayPageControl alloc] initWithFrame:CGRectMake(0, 0, __SCREEN_SIZE.width-30, 20)];
          pageCl.tag = 5444;
          pageCl.userInteractionEnabled = NO;

     }

     pageCl.autoresizingMask = UIViewAutoresizingFlexibleRightMargin| UIViewAutoresizingFlexibleBottomMargin;
     pageCl.numberOfPages =_dataArr.count;

     pageCl.width = __SCREEN_SIZE.width-30;
     pageCl.height = 20;
     pageCl.x = __SCREEN_SIZE.width/2.0 - pageCl.width/2.0;
     pageCl.y = self.height-21;
     //     pageCl.currentPageIndicatorTintColor = kUIColorFromRGB(color_3);
     //     pageCl.pageIndicatorTintColor = kUIColorFromRGB(color_8);
     [self.contentView addSubview:pageCl];
     [pageCl setCurrentPage:0];
//     [pageCl updateDots];

     //     _pageCount = c;
//     if(_dataArr.count == 1)
//     {
//          pageCl.hidden = YES;
//     }
//     else
//     {
//          pageCl.hidden = NO;
//     }
     
     if (_dataArr.count == 0) {
          self.height = 0.01;
          self.hidden = YES;
          self.userInteractionEnabled = NO;
     }else{
          self.hidden = NO;
          self.userInteractionEnabled = YES;
     }
     
}


-(void)fitGoodsMode
{
     self.height = __SCREEN_SIZE.width * 250/360.0;
     _cellHeight = 250;
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
