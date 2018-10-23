//
//  AddImgTableViewCell.m
//  ChaoLiu
//
//  Created by air on 15/7/16.
//  Copyright (c) 2015年 ORANLLC_IOS1. All rights reserved.
//

#import "AddImgTableViewCell.h"
#import "AddImgCollectionViewCell.h"
#import "BUImageRes.h"
@implementation AddImgTableViewCell
{
    NSMutableArray *_dataArr;
    NSMutableArray *_imgVArr;
    IBOutlet UICollectionView *_collectionView;
    BOOL _isHiddenDelBtn;
    NSString *_defaultImg;
    NSInteger _ccWidth;
     NSInteger _ccHeight;
    CGFloat _minimumInteritemSpacing;
    CGFloat _minimumLineSpacing;
}
- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
    _ccWidth = AddImgListCellWidth;
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
    [_collectionView registerNib:[UINib nibWithNibName:@"AddImgCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"AddImgCollectionViewCell"];
    _collectionView.width = __SCREEN_SIZE.width;
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _imgVArr = [NSMutableArray array];
    // CGFloat height = (__SCREEN_SIZE.width/2.0) * (258/160.0);
    
    
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat width = _ccWidth;
      CGFloat height = _ccHeight;
    if (height == 0) {
         height = width;
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
    if (_limitCount == 0) {
        return  _dataArr.count ;
    }
    else
    {
        
        return  _dataArr.count;//MIN(_limitCount, _dataArr.count + 1);
    }
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    AddImgCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"AddImgCollectionViewCell" forIndexPath:indexPath];
    NSInteger row = indexPath.row;
    if ((_limitCount == 0 || _limitCount > _dataArr.count + 1) && indexPath.row == _dataArr.count - 1) {
        [cell setCellData:@{@"img":@"addImg",@"row":@(indexPath.row),@"hiddenDeleteBtn":@(YES),@"default":@"default"}];
        if (_fitCellMode) {
            _fitCellMode(cell);
        }
    }
    else
    {
       
        if (indexPath.row == _dataArr.count - 1 && (_dataArr.count != _limitCount || ([_dataArr[indexPath.row] isKindOfClass:[NSString class]] &&[_dataArr[indexPath.row] isEqualToString:@"addImg"]))) {
            [cell setCellData:@{@"img":@"addImg",@"row":@(indexPath.row),@"hiddenDeleteBtn":@(YES),@"default":@"default"}];
            if (_fitCellMode) {
                _fitCellMode(cell);
            }
        }
        else
        {
            
            row = indexPath.row;
            id img = _dataArr[row];
            [cell setCellData:@{@"img":img,@"row":@(row),@"hiddenDeleteBtn":@(_isHiddenDelBtn),@"default":_defaultImg?:@"default"}];
            if (_fitCellMode) {
                _fitCellMode(cell);
            }
            UIImageView *iv = [cell imageView];
            if (_imgVArr.count <= indexPath.row) {
                [_imgVArr addObject:iv];
            }
            else
            {
                _imgVArr[indexPath.row] = iv;
            }
            cell.deleteHandle = ^(NSInteger item){
                [_dataArr removeObjectAtIndex:item];
                [_collectionView reloadData];
               
                if (self.handleAction) {
                    self.handleAction(@{@"row":@(item),@"method":@(3)});
                }
            };
            
        }
    }
      return cell;
}

-(void)setCellData:(NSDictionary *)dataArr
{
    //    _pageCount = busiSystem.actionManager.actions.count;
    //    _pageCl.numberOfPages = _pageCount;
    NSInteger colCount = [dataArr[@"colCount"] integerValue];
    _defaultImg = dataArr[@"default"];
    _limitCount = [dataArr[@"limitCount"] integerValue];
    _dataArr = [NSMutableArray arrayWithArray:dataArr[@"arr"]];
    if(_dataArr.count < _limitCount && _limitCount !=0)
    {
        [_dataArr addObject:@"addImg"];
    }
    else if(_dataArr.count > _limitCount)
    {
        [_dataArr removeObjectsInRange:NSMakeRange(_limitCount, _dataArr.count - _limitCount)];
    }
    if (_mode == AddImgModeMutable) {
        NSInteger row = (_dataArr.count + colCount - 1)/colCount;
        _collectionView.height = row * (AddImgListCellWidth + 5 + 4);
        self.height = _collectionView.height + 1;
    }
    if (dataArr[@"hiddenDelBtn"]) {
        _isHiddenDelBtn = [dataArr[@"hiddenDelBtn"] boolValue];
    }
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [_collectionView reloadData];
    //    [super setCellData:dataArr];
}



-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //    if (_selecedtItem) {
    //        if (_limitCount > _dataArr.count && indexPath.row == 0) {
    //             _selecedtItem(indexPath.row);
    //        }
    //
    //    }
    if (self.handleAction) {
        //        if (_limitCount > _dataArr.count && indexPath.row == 0) {
        if (  _dataArr.count - 1 == indexPath.row && (_dataArr.count != _limitCount ||([_dataArr[indexPath.row] isKindOfClass:[NSString class]] &&[_dataArr[indexPath.row] isEqualToString:@"addImg"]))) {
            self.handleAction(@{@"row":@(indexPath.row),@"method":@(1)});//添加图片
        }
        else
        {
             UIImageView *imgv = _imgVArr[indexPath.row];
            NSMutableArray *adr = [NSMutableArray new];
            [_imgVArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                UIImageView *imv = obj;
                [adr addObject:imv.image];
            }];
            self.handleAction(@{@"row":@(indexPath.row),@"method":@(2),@"imgvs":_imgVArr,@"img":imgv.image,@"arr":adr?:@[]});//浏览图片
        }
        
    }
}



-(void)fitMode:(CGFloat)y
{
    _collectionView.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    if (_dataArr.count == 0) {
        self.height = 0;
    }
    else
    {
        NSInteger colCount = 4;
        NSInteger cwith = 75;
        NSInteger row = (_dataArr.count + colCount - 1)/colCount;
        _ccWidth = cwith;
        _collectionView.height = row * (cwith ) + 5 + 4;
        self.height = _collectionView.height + 1;
        _collectionView.x = 12;
        _collectionView.y = y;
        _minimumLineSpacing = 8;
        _collectionView.width = __SCREEN_SIZE.width - 30;
        [_collectionView reloadData];
    }
}

-(void)fitRepairServerMode
{
      _collectionView.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    NSInteger colCount = 3;
    NSInteger cwith = 85;
    if(__SCREEN_SIZE.width > 320)
    {
        cwith = 104;
    }
    NSInteger row = (_dataArr.count + colCount - 1)/colCount;
    _ccWidth = cwith;
    _collectionView.height = row * (cwith + 5 + 4);
    self.height = MAX(_collectionView.height + 11, 100);
    if(__SCREEN_SIZE.width > 320)
    {
        self.height = MAX(_collectionView.height + 11, 124);
    }
    
    _collectionView.x = 15;
    _collectionView.y = 0;
    _minimumLineSpacing = 8;
    _collectionView.width = __SCREEN_SIZE.width - 15 - 15;
    [_collectionView reloadData];
}

-(void)fitSendInfoMode
{
     _collectionView.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    NSInteger colCount = 3;
    NSInteger cwith = 85;
    if(__SCREEN_SIZE.width > 320)
    {
        cwith = 106;
    }
    NSInteger row = (_dataArr.count + colCount - 1)/colCount;
    _ccWidth = cwith;
    _collectionView.height = row * (cwith + 5 + 4);
//     self.height = MAX(_collectionView.height + 11, 109);
//    if(__SCREEN_SIZE.width > 320)
//    {
//       self.height = MAX(_collectionView.height + 11, 134);
//    }
     self.height = 110;
    _collectionView.x = 15;
    _collectionView.y = 15;
    _minimumLineSpacing = 5;
    _collectionView.width = __SCREEN_SIZE.width - 15 - 15;
    [_collectionView reloadData];
     
    
}
-(void)fitCommentMode
{
     _mode = AddImgModeMutable;
    _collectionView.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    NSInteger colCount = 3;
    NSInteger cwith = 105;
//    if(__SCREEN_SIZE.width > 320)
//    {
//        cwith = 104;
//    }
    NSInteger row = (_dataArr.count + colCount - 1)/colCount;
    _ccWidth = cwith;
    _ccHeight = 95;
    _collectionView.height = row * (_ccHeight + 5 + 4);
    self.height = MAX(_collectionView.height + 11, 109);
    if(__SCREEN_SIZE.width > 320)
    {
        self.height = MAX(_collectionView.height + 11, 134);
    }
    else
    {
        _ccWidth = __SCREEN_SIZE.width/3 - 18;
        _ccHeight = (_ccWidth - 5 ) * 0.85 + 10;
    }
    _collectionView.x = 15;
    _collectionView.y = 0;
    _minimumLineSpacing = 8;
    _collectionView.width = __SCREEN_SIZE.width - 15 - 15;
    _fitCellMode = ^(AddImgCollectionViewCell *cell){
        [cell fitCommentMode];
    };
    [_collectionView reloadData];
    _collectionView.backgroundColor = kUIColorFromRGB(color_4);
    self.backgroundColor = kUIColorFromRGB(color_4);
    
}

-(void)fitPersonInfoSettingMode
{
    _collectionView.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    NSInteger colCount = 3;
    NSInteger cwith = 105;
    //    if(__SCREEN_SIZE.width > 320)
    //    {
    //        cwith = 104;
    //    }
    NSInteger row = (_dataArr.count + colCount - 1)/colCount;
    _ccWidth = cwith;
    _ccHeight = 95;
    _collectionView.height = row * (_ccHeight + 5 + 4);
    self.height = MAX(_collectionView.height + 11, 115);
    if(__SCREEN_SIZE.width > 320)
    {
        self.height = MAX(_collectionView.height + 11, 115);
    }
    else
    {
        _ccWidth = __SCREEN_SIZE.width/3 - 18;
        _ccHeight = (_ccWidth - 5 ) * 0.85 + 10;
    }
    _collectionView.x = 15;
    _collectionView.y = 9;
    _minimumLineSpacing = 8;
    _collectionView.width = __SCREEN_SIZE.width - 15 - 15;
    _fitCellMode = ^(AddImgCollectionViewCell *cell){
        [cell fitCommentMode];
    };
    [_collectionView reloadData];
    _collectionView.backgroundColor = kUIColorFromRGB(color_4);
    self.backgroundColor = kUIColorFromRGB(color_4);
}

-(void)fitPublishEvaMode
{
     _mode = AddImgModeMutable;
     _collectionView.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     NSInteger colCount = 3;
     NSInteger cwith = 85;
     if(__SCREEN_SIZE.width > 320)
     {
          cwith = 105;
     }
     NSInteger row = (_dataArr.count + colCount - 1)/colCount;
     _ccWidth = cwith;
     _collectionView.height = row * (cwith + 8);


     _collectionView.x = 15;
     _collectionView.y = 2;
     _minimumLineSpacing = 8;
     _collectionView.width = __SCREEN_SIZE.width - 15 - 15;
     [_collectionView reloadData];
     _collectionView.backgroundColor = kUIColorFromRGB(color_0xf0f0f0);
     self.backgroundColor = kUIColorFromRGB(color_0xf0f0f0);
     self.height =  MAX(_collectionView.height + _collectionView.y, 115);
     if(__SCREEN_SIZE.width > 320)
     {
          self.height = MAX(_collectionView.y + _collectionView.height , 115);
     }

}

-(void)fitPublishAnswerMode
{
     [self fitFeedbackMode];
     _collectionView.backgroundColor = kUIColorFromRGB(color_2);
        self.backgroundColor = kUIColorFromRGB(color_2);
}
 -(void)fitFeedbackMode
{
     _mode = AddImgModeMutable;
     _collectionView.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     NSInteger colCount = 3;
     NSInteger cwith = 85;
     if(__SCREEN_SIZE.width > 320)
     {
          cwith = 105;
     }
     NSInteger row = (_dataArr.count + colCount - 1)/colCount;
     _ccWidth = cwith;
     _collectionView.height = row * (cwith + 8);
    
    
     _collectionView.x = 15;
     _collectionView.y = 10;
     _minimumLineSpacing = 8;
     _collectionView.width = __SCREEN_SIZE.width - 15 - 15;
     [_collectionView reloadData];
     _collectionView.backgroundColor = kUIColorFromRGB(color_0xf0f0f0);
        self.backgroundColor = kUIColorFromRGB(color_0xf0f0f0);
      self.height = MAX(_collectionView.height + _collectionView.y, 95);
     if(__SCREEN_SIZE.width > 320)
     {
          self.height = MAX(_collectionView.y + _collectionView.height , 115);
     }
}
-(void)fitPublishSecHandDealMode
{
     _mode = AddImgModeMutable;
     _collectionView.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     NSInteger colCount = 3;
     NSInteger cwith = 105;
     //    if(__SCREEN_SIZE.width > 320)
     //    {
     //        cwith = 104;
     //    }
     NSInteger row = (_dataArr.count + colCount - 1)/colCount;
     _ccWidth = cwith;
     _ccHeight = 95;

  _collectionView.height = row * (_ccHeight + 8);


     _collectionView.x = 15;
     _collectionView.y = 0;
     _minimumLineSpacing = 8;
     _collectionView.width = __SCREEN_SIZE.width - 15 - 15;

     _fitCellMode = ^(AddImgCollectionViewCell *cell){
          [cell fitCommentMode];
     };

     if(__SCREEN_SIZE.width > 320)
     {
             [_collectionView reloadData];
          self.height = MAX(_collectionView.height + 11, 100);
     }
     else
     {
          _ccWidth = __SCREEN_SIZE.width/3 - 18;
          _ccHeight = (_ccWidth - 5 ) * 0.85 + 10;
             [_collectionView reloadData];
            self.height = MAX(_collectionView.height + 5, 100);
     }

     _collectionView.backgroundColor = kUIColorFromRGB(color_2);
     self.backgroundColor = kUIColorFromRGB(color_2);

}
-(void)fitHeadPromoteMode{
    
    NSInteger colCount = 3;
    NSInteger cwith = 75;
//    NSInteger row = (_dataArr.count + colCount - 1)/colCount;
    _ccWidth = cwith;
    _collectionView.height = 85;
    self.height = _collectionView.height + 10;
    
    _head = YES;
    _collectionView.x = 15;
    _collectionView.y = 0;
    _collectionView.width = __SCREEN_SIZE.width  - 30;
    [_collectionView reloadData];
//    _collectionView.userInteractionEnabled = NO;
    
    _collectionView.backgroundColor = kUIColorFromRGB(color_4);
    self.contentView.backgroundColor = kUIColorFromRGB(color_4);
}

-(void)layoutSubviews
{

}

-(void)dealloc
{
    _collectionView = nil;
}
-(void)setNull
{
    _collectionView.delegate = nil;
    _collectionView.dataSource = nil;
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
