//
//  TipImgAndImgsTableViewCell.m
//  yihui
//
//  Created by air on 15/9/16.
//  Copyright (c) 2015年 ORANLLC_IOS1. All rights reserved.
//

#import "TipImgAndImgsTableViewCell.h"
//#import "TipImgAndTitleTableViewCell.h"
#import "TipImgAndImgsCollectionViewCell.h"
@implementation TipImgAndImgsTableViewCell
{
    IBOutlet UICollectionView *_collectionView;
    NSMutableArray *_dataArr;
    IBOutlet UIImageView *_tipImgV;
}
- (void)awakeFromNib {
    // Initialization code
      [self initCollectionView];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)initCollectionView
{
//    _selectRow = 0;
    [_collectionView registerNib:[UINib nibWithNibName:@"TipImgAndImgsCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"TipImgAndImgsCollectionViewCell"];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    // CGFloat height = (__SCREEN_SIZE.width/2.0) * (258/160.0);
    
    
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
//    CGFloat width = TitleAndSelectBtnCellWidth;
//    CGFloat height = width * TitleAndSelectBtnScale;
    CGSize size =  CGSizeMake(30, 30);
    //     self.height = height;
    //    _collectionView.height = height;
    return size;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    //    if (_limitCount == 0) {
    return  _dataArr.count;
    //    }
    //    else
    //    {
    //
    //        return  MIN(_limitCount, _dataArr.count);
    //    }
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    TipImgAndImgsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TipImgAndImgsCollectionViewCell" forIndexPath:indexPath];
    NSInteger row = indexPath.row;
    //    BUProductAttr *att = _dataArr[row ];
//    NSString *title =  ;
    
    [cell setCellData:_dataArr[row]];
    
    return cell;
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
//    _selectRow = indexPath.row;
    [_collectionView reloadData];
    if (self.handleAction) {
        
        self.handleAction(@(indexPath.row));
    }
}

-(void)setCellData:(NSDictionary *)dataDic
{
   _dataArr = dataDic[@"arr"];
    [super setCellData:dataDic];
}
@end
