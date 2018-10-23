//
//  ImgAndTitleListTableViewCell.m
//  lovecommunity
//
//  Created by air on 16/6/14.
//  Copyright © 2016年 ORANLLC_IOS1. All rights reserved.
//

#import "ImgAndTitleListTableViewCell.h"
#import "ImgAndTitleCollectionViewCell.h"
@implementation ImgAndTitleListTableViewCell
{
    NSMutableArray *_dataArr;
     CGFloat _cheight;
     CGFloat _cwidth;
    IBOutlet UICollectionView *_collectionView;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _dataArr = [NSMutableArray array];
 
    [self initCollectionView];
}

-(void)setCellData:(NSDictionary *)dataDic
{
    [_dataArr removeAllObjects];
    NSArray *arr = dataDic[@"arr"];
    [_dataArr addObjectsFromArray:arr];
    [_collectionView reloadData];
    
}
-(void)initCollectionView
{
    [_collectionView registerNib:[UINib nibWithNibName:@"ImgAndTitleCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"cnid"];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.pagingEnabled = YES;
    
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
     return 6;
}
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
//     return 0.001;
//}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 70;
    if (__SCREEN_SIZE.width == 375) {
        height = 92;
    }
    else if(__SCREEN_SIZE.width == 320)
    {
        height = 92;

    }else
    {

    }
     CGSize size =  CGSizeMake(_cwidth == 0?__SCREEN_SIZE.width/4.0:_cwidth,_cheight == 0? height:_cheight);
    return size;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return   _dataArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //    UICollectionViewCell *cell;
    ImgAndTitleCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cnid" forIndexPath:indexPath];
    NSDictionary *dic = _dataArr[indexPath.row];
    NSMutableDictionary *mdic = [NSMutableDictionary dictionaryWithDictionary:dic];
    mdic[@"row"] = indexPath;
      [cell setCellData:mdic];
     if (_fitCellMode) {
          _fitCellMode(cell);
     }
     else
    [cell fitFourMode];

    if (_delCallback) {
        cell.delCallback = _delCallback;
    }
     cell.layer.cornerRadius = 6.0;
     cell.layer.masksToBounds = YES;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.handleAction) {
        self.handleAction(@{@"row":indexPath});
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)fitHeadMode
{
     _collectionView.bounces = NO;
     _cheight = 80;
     [self setFitCellMode:^(ImgAndTitleCollectionViewCell *o) {
          [o fitHeadMode];
     }];
}
-(void)fitHeadModeB
{
     
     _collectionView.bounces = NO;
     _collectionView.scrollEnabled = NO;
     _collectionView.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleRightMargin;
     
     _collectionView.width = __SCREEN_SIZE.width-30;
     _collectionView.y = 10;
     _collectionView.x = 15;
     
     _cwidth = __SCREEN_SIZE.width/2.0 - 15-3;
     _cheight = 70/164.0*_cwidth;
     if (_dataArr.count == 0 ) {
          _collectionView.height = 0.001;
          self.height = 0.001;
     }
     else if(_dataArr.count < 3)
     {
          _collectionView.height = _cheight;
            self.height = _cheight+20;
     }else{
          self.height = _cheight*2+30;
          _collectionView.height = _cheight*2+10;
     }
     [self setFitCellMode:^(ImgAndTitleCollectionViewCell *o) {
          [o fitTwoMode];
     }];
     
//     [self addVHLine];
}

-(void)addVHLine
{
     UIView *line = [self.contentView viewWithTag:9113];

     if (!line) {
          line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, __SCREEN_SIZE.width, 6)];
          line.tag = 9113;
     }
     line.backgroundColor = kUIColorFromRGB(color_2);
     line.y = 75;
     [self.contentView addSubview:line];

     UIView *line2 = [self.contentView viewWithTag:9115];

     if (!line2) {
          line2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 6, 158)];
          line2.tag = 9115;
     }
     line2.x = __SCREEN_SIZE.width/2.0;
     line2.backgroundColor = kUIColorFromRGB(color_2);

     [self.contentView addSubview:line2];


}
@end
