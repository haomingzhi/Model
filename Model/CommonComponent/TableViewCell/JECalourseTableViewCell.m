//
//  JECalourseTableViewCell.m
//  rentingshop
//
//  Created by air on 2018/3/8.
//  Copyright © 2018年 ORANLLC_IOS1. All rights reserved.
//

#import "JECalourseTableViewCell.h"
#import "GrayPageControl.h"

@implementation JECalourseTableViewCell
{
   NSMutableArray * _dataArr;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
     _dataArr = [NSMutableArray new];
     JECalourseView* calourse = [[JECalourseView alloc]initWithFrame:CGRectMake(25, 5,__SCREEN_SIZE.width-50, (__SCREEN_SIZE.width-50) * 150/326.0)];

     [self addSubview:calourse];
     [calourse setDataSource:self];
     _calourse=calourse;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setCellData:(NSDictionary *)dataDic
{
       _dataArr = [dataDic[@"arr"] mutableCopy];
}
-(NSInteger)JE3DCalourseNumber
{
     return _dataArr.count;
}

-(void)clickCellHandle:(JECalourseCell *)cell{
     if (self.selecedtItem) {
          self.selecedtItem(@{@"row":@(cell.sectionTag%_dataArr.count)});
     }
}



-(void)JE3DCalourseViewWith:(JECalourseCell *)cell andIndex:(NSInteger)index
{
     if(_dataArr.count == 0)
          return;
     GrayPageControl *pageCl = [self.contentView viewWithTag:5444];
//     NSLog(@"%lu",index%_dataArr.count);
     NSInteger pageCount = index%_dataArr.count-1;
     if (pageCount <0) {
          pageCount = _dataArr.count -1;
     }
     [pageCl setCurrentPage:pageCount];
     NSDictionary *dic = _dataArr[index%_dataArr.count];
     cell.imageView.image = [UIImage imageNamed:@"defaultBanner"];
     cell.imageView.backgroundColor = kUIColorFromRGB(color_f8f8f8);
     cell.imageView.contentMode = UIViewContentModeCenter;
     BUImageRes *img = dic[@"img"];
     if ([img isKindOfClass:[NSString class]]) {
          cell.imageView.contentMode = UIViewContentModeScaleToFill;
          cell.imageView.image = [UIImage imageContentWithFileName:dic[@"img"]];
     }
     else
     {
          if (img.isCached) {
               UIImage *im = [UIImage imageWithContentsOfFile:img.cacheFile];
               
               if (im) {
                    cell.imageView.contentMode = UIViewContentModeScaleToFill;
                    cell.imageView.image = im;
               }

          }
          else {
               [img download:self callback:@selector(getImgNotification:) extraInfo:@{@"index":@(index),@"img":cell.imageView}];
          }
     }
     NSInteger nextIndex = index%_dataArr.count +1;
     
     if (nextIndex >= _dataArr.count) {
          nextIndex = 0;
     }
     NSDictionary *nextDic = _dataArr[nextIndex];
      BUImageRes *nextimg = nextDic[@"img"];
     if ([nextimg isKindOfClass:[BUImageRes class] ]) {
          if (!nextimg.isCached) {
               [nextimg download:self callback:@selector(getImgNotification:) extraInfo:@{}];
          }
     }
}
-(void)getImgNotification:(BSNotification *) noti
{
     if(noti.error.code ==0)
     {
          BUImageRes *res =(BUImageRes *) noti.target;
          if (res.isCached) {
               UIImageView * imgV = noti.extraInfo[@"img"];
               UIImage *im = [UIImage imageWithContentsOfFile:res.cacheFile];
               if (im) {
                    imgV.contentMode = UIViewContentModeScaleToFill;
                    imgV.image = im;
               }
          }
     }
}
-(void)fitHeadMode
{
     
     if (_dataArr.count == 0) {
          self.height = 0.01;
          self.hidden = YES;
          self.userInteractionEnabled = NO;
     }else{
          self.hidden = NO;
          self.userInteractionEnabled = YES;
          self.height = (__SCREEN_SIZE.width-50) * 150/325.0+30;
     }
     
     
     _calourse.height = self.height;
//     _calourse.width =
     [_calourse timerChange];
     [_calourse timerChange];
     [_calourse timerChange];
     
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
     pageCl.y = self.height-20;
     //     pageCl.currentPageIndicatorTintColor = kUIColorFromRGB(color_3);
     //     pageCl.pageIndicatorTintColor = kUIColorFromRGB(color_8);
     [self.contentView addSubview:pageCl];
     [pageCl setCurrentPage:0];
     [pageCl updateDots];
     
//     _pageCount = c;
     if(_dataArr.count == 1)
     {
          pageCl.hidden = YES;
     }
     else
     {
          pageCl.hidden = NO;
     }
     
}
@end
