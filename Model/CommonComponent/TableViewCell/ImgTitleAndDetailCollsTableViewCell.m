//
//  ImgTitleAndDetailCollsTableViewCell.m
//  taihe
//
//  Created by air on 2016/11/14.
//  Copyright © 2016年 ORANLLC_IOS1. All rights reserved.
//

#import "ImgTitleAndDetailCollsTableViewCell.h"
#import "ImgTitleAndDetailCollectionViewCell.h"
@implementation ImgTitleAndDetailCollsTableViewCell
{
    IBOutlet UICollectionView *_collectionView;
    BOOL _isHiddenDelBtn;
    NSString *_defaultImg;
    NSInteger _ccWidth;
     NSInteger _ccHeight;
    CGFloat _minimumInteritemSpacing;
    CGFloat _minimumLineSpacing;
    NSMutableArray *_dataArr;
    NSMutableArray *_imgVArr;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _ccWidth = (__SCREEN_SIZE.width - 36)/2.0;//AddImgListCellWidth;
    
    _minimumInteritemSpacing = 0;
    _minimumLineSpacing = 0;
    [self initCollectionView];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)initCollectionView
{
    [_collectionView registerNib:[UINib nibWithNibName:@"ImgTitleAndDetailCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"ImgTitleAndDetailCollectionViewCell"];
    _collectionView.width = __SCREEN_SIZE.width;
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _imgVArr = [NSMutableArray array];
    // CGFloat height = (__SCREEN_SIZE.width/2.0) * (258/160.0);
    
    
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat width = _ccWidth;
        CGFloat height = width * 280/320.0;
    if (_ccHeight != 0) {
        height = _ccHeight;
    }
    CGSize size =  CGSizeMake(width, height);
    //     self.height = height;
    //    _collectionView.height = height + 20;
    return size;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section;
{
    return _minimumInteritemSpacing;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return _minimumLineSpacing;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
   
        
        return  _dataArr.count;//MIN(_limitCount, _dataArr.count + 1);
  
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ImgTitleAndDetailCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ImgTitleAndDetailCollectionViewCell" forIndexPath:indexPath];
    NSInteger row = indexPath.row;
    NSDictionary *dic = _dataArr[row];
    id img = dic[@"img"];
    [cell setCellData:@{@"img":img,@"row":@(row),@"title":dic[@"title"]?:@"",@"detail":dic[@"detail"]?:@"",@"default":_defaultImg?:@"default"}];
    [cell fitMode];
    UIImageView *iv = [cell imageView];
        if (_imgVArr.count <= indexPath.row) {
            [_imgVArr addObject:iv];
        }
        else
        {
            _imgVArr[indexPath.row] = iv;
        }
            
    
    
         return cell;
}

-(void)setCellData:(NSDictionary *)dataArr
{
 
//    NSInteger colCount = 2;
    _defaultImg = dataArr[@"default"];
 
    _dataArr = [NSMutableArray arrayWithArray:dataArr[@"arr"]];
    
    
   
    [_collectionView reloadData];
    //    [super setCellData:dataArr];
}



-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
        if (self.handleAction) {
 
//        if (  _dataArr.count - 1 == indexPath.row && (_dataArr.count != _limitCount ||([_dataArr[indexPath.row] isKindOfClass:[NSString class]] &&[_dataArr[indexPath.row] isEqualToString:@"addImg"]))) {
//            self.handleAction(@{@"row":@(indexPath.row),@"method":@(1)});
//        }
//        else
//        {
            self.handleAction(@{@"row":@(indexPath.row),@"method":@(2),@"imgvs":_imgVArr});
//        }
        
    }
}

-(void)fitUpPersonInfoMode
{
    _collectionView.contentInset = UIEdgeInsetsMake(0, 15, 0, 15);
    CGFloat width = _ccWidth;
    CGFloat height = width * 350/320.0;
    _collectionView.height = height + 1;
     self.backgroundColor = kUIColorFromRGB(color_4);
     _collectionView.backgroundColor = kUIColorFromRGB(color_4);
    self.height = _collectionView.height + 1;
}

-(void)fitCompanyCerMode
{
    _ccWidth = 244;
    CGFloat width =  (__SCREEN_SIZE.width - 40)/2.0;
    CGFloat w = (__SCREEN_SIZE.width - _ccWidth)/2.0 - 4;
    _collectionView.contentInset = UIEdgeInsetsMake(0, w, 0, w);
    self.backgroundColor = kUIColorFromRGB(color_4);
    CGFloat height = width * 280/320.0;
    _ccHeight = height;
    _collectionView.height = height + 1;
    _collectionView.backgroundColor = kUIColorFromRGB(color_4);
    self.height = _collectionView.height + 1;
    self.clipsToBounds = YES;
}

-(void)fitCompanyStaffCerMode
{
    _collectionView.contentInset = UIEdgeInsetsMake(0, 15, 0, 15);
    CGFloat width = _ccWidth;
    CGFloat height = width * 350/320.0;
    _collectionView.height = height * 2 + 1;
    self.height = _collectionView.height + 1;
     self.backgroundColor = kUIColorFromRGB(color_4);
     _collectionView.backgroundColor = kUIColorFromRGB(color_4);
}
@end
