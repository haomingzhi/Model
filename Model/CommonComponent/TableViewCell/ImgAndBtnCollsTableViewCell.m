//
//  ImgAndBtnCollsTableViewCell.m
//  taihe
//
//  Created by air on 2016/11/14.
//  Copyright © 2016年 ORANLLC_IOS1. All rights reserved.
//

#import "ImgAndBtnCollsTableViewCell.h"
#import "ImgAndBtnCollectionViewCell.h"
@implementation ImgAndBtnCollsTableViewCell
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
    _ccHeight = _ccWidth;
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
    [_collectionView registerNib:[UINib nibWithNibName:@"ImgAndBtnCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"ImgAndBtnCollectionViewCell"];
    _collectionView.width = __SCREEN_SIZE.width;
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _imgVArr = [NSMutableArray array];
    // CGFloat height = (__SCREEN_SIZE.width/2.0) * (258/160.0);
    
    
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat width = _ccWidth;
    CGFloat height = _ccHeight;//width * AddImgListScale;
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
    ImgAndBtnCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ImgAndBtnCollectionViewCell" forIndexPath:indexPath];
    NSInteger row = indexPath.row;
    NSDictionary * dic = _dataArr[row];
   NSString *str = dic[@"title"];
    id img = dic[@"img"];
    [cell setCellData:@{@"img":img,@"row":@(row),@"title":@"上传",@"default":_defaultImg?:@"default"}];
    if ([str isEqualToString:@""]) {
           [cell fitModeB];
    }
    else
    {
      [cell fitMode];
    }
    if (self.handleAction) {
        cell.handleAction = self.handleAction;
    }
    
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

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.handleAction) {
       UIImageView *imgv = _imgVArr[indexPath.row];
        self.handleAction(@{@"row":@(indexPath.row),@"method":@(2),@"imgvs":_imgVArr,@"img":imgv.image});
        
    }
}

-(void)setCellData:(NSDictionary *)dataArr
{
    
    //    NSInteger colCount = 2;
    _defaultImg = dataArr[@"default"];
    
    _dataArr = [NSMutableArray arrayWithArray:dataArr[@"arr"]];
 
    [_collectionView reloadData];
    //    [super setCellData:dataArr];
}

-(void)fitUpPersonInfoMode
{
    _collectionView.contentInset = UIEdgeInsetsMake(0, 15, 0, 15);
}

-(void)fitPersonCerInfoMode
{
    _collectionView.contentInset = UIEdgeInsetsMake(0, 15, 0, 15);
}

-(void)fitCompanyCerMode
{
    CGFloat width = _ccWidth;
    CGFloat w = (__SCREEN_SIZE.width - _ccWidth)/2.0 - 4;
    _collectionView.contentInset = UIEdgeInsetsMake(0, w, 0, w);
    
//    CGFloat height = width * 350/320.0;
//    _collectionView.height = height + 1;
//    self.height = _collectionView.height + 1;
}

-(void)fitCerInfoMode
{
//    _ccWidth = 145;
//    CGFloat width = _ccWidth;
     _ccWidth = (__SCREEN_SIZE.width)/2.0;
    CGFloat w = (__SCREEN_SIZE.width - _ccWidth)/2.0 - 4;
    _collectionView.contentInset = UIEdgeInsetsMake(0, w, 0, w);
    _collectionView.y = 0;
    _collectionView.backgroundColor = kUIColorFromRGB(color_4);
    //    CGFloat height = width * 350/320.0;
    //    _collectionView.height = height + 1;
    self.height = 188;//_collectionView.height + 26;
}

-(void)fitCerInfoModeB
{
    _ccWidth = 155;
    _ccHeight = 120;
    //    CGFloat width = _ccWidth;
    CGFloat w = (__SCREEN_SIZE.width - _ccWidth)/2.0 - 4;
    _collectionView.contentInset = UIEdgeInsetsMake(0, w, 0, w);
    _collectionView.y = 0;
    _collectionView.backgroundColor = kUIColorFromRGB(color_4);
    //    CGFloat height = width * 350/320.0;
    //    _collectionView.height = height + 1;
    _collectionView.height = 120;
    self.height = _collectionView.height ;
}

-(void)toPhoto
{
    [self.addPhotoManager toPhoto];
}
-(void)initAddPhotoManager:(NSInteger)count withImgArr:(NSMutableArray *)aimgArr withVC:(UIViewController *)vc withTableView:(UITableView*)tableView
{
//    __weak id weakSelf = vc;
    _addPhotoManager = [[AddPhotoManager alloc] initWith:vc withImgArr:aimgArr withCell:self withTableView:tableView];
    _addPhotoManager.count = count;
}

-(void)toCheckOption:(id)userInfo
{
    [_addPhotoManager toCheckOption:userInfo];
}

-(void)delImg:(NSInteger )indexPath
{
   [self delImg:indexPath withImgArr:nil];
}

-(void)delImg:(NSInteger )indexPath withImgArr:(NSArray *)arr
{
    [_addPhotoManager delImg:indexPath withImgArr:arr];
}

- (void) setupPhotoBrowser:(NSDictionary *)dic
{
    [_addPhotoManager setupPhotoBrowser:dic];
}
@end
