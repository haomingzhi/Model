 //
//  ImgsTableViewCell.m
//  yihui
//
//  Created by air on 15/8/31.
//  Copyright (c) 2015年 ORANLLC_IOS1. All rights reserved.
//

#import "ImgsTableViewCell.h"
#import "ImgListCollectionViewCell.h"
#import "BUImageRes.h"

@implementation ImgsTableViewCell
{
    IBOutlet UICollectionView *_collectionView;
    NSMutableArray *_dataArr;
    NSMutableArray *_imgVArr;
    CGFloat _width;
    CGFloat _height;
    IBOutlet UIView *_containerView;
    NSInteger _count;
     BUImageRes *_curImgRes;
}
- (void)awakeFromNib {
    // Initialization code
//    [self addObserver:self forKeyPath:@"height" options:NSKeyValueObservingOptionNew context:nil];
    [_collectionView registerNib:[UINib nibWithNibName:@"ImgListCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"ImgListCollectionViewCell"];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _imgVArr = [NSMutableArray array];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize size = CGSizeMake(_width , _height);
    return size;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
     return 10;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
//    UICollectionViewCell *cell;
    ImgListCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ImgListCollectionViewCell" forIndexPath:indexPath];
    NSInteger row = indexPath.row;
      BUImageRes *img = _dataArr[row ];
    [cell setCellData:@{@"img":img,@"row":@(row)}];
     UIImageView *iv = [cell imageView];
     if (_imgVArr.count <= indexPath.row) {
          [_imgVArr addObject:iv];
     }
     else
     {
          _imgVArr[indexPath.row] = iv;
     }
    
//    NSString *title = att.title;
//    [cell setCellData:@{@"title":title,@"isChecked":@(indexPath.row == _selectRow)}];
    
    return cell;
}

-(void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
//    ImgListCollectionViewCell *cell = (ImgListCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
//    if (!cell.imageView.userInteractionEnabled) {
//        return;
//    }
//    UITableView *tableView = (UITableView *)collectionView.superview.superview.superview.superview;
//    CGRect rect = [self.contentView convertRect:self.bounds toView:tableView.window];//坐标系统转换
    if (self.handleAction) {
         UIImageView *imgv = _imgVArr[indexPath.row];
         NSMutableArray *adr = [NSMutableArray new];
         [_imgVArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
              UIImageView *imv = obj;
              [adr addObject:imv.image];
         }];
         self.handleAction(@{@"row":@(indexPath.row),@"imgvs":_imgVArr,@"img":imgv.image,@"arr":adr?:@[]});//浏览图片
    }
}

-(void)setCellData:(NSDictionary *)dataDic
{
     
    _dataArr = dataDic[@"arr"];
    [_imgVArr removeAllObjects];
    _count = _dataArr.count;
//   NSValue *v = dataDic[@"separatorInset"];
//    UIEdgeInsets s;
//    [v getValue:&s];
//    if (v) {
//         self.separatorInset = s;
//    }
    if([dataDic[@"cellStatus"] integerValue]== 1)
    {
        _containerView.x = 44;
    }
    else
    {
        _containerView.x = 0;
    }
  //     self.height = (_height + 10) * ((_count + 2)/3);
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



-(void)fitMode
{
     _collectionView.x = 55;
     switch (_count) {
               //        case 1:
               //        {
               //            _collectionView.x = 56;
               //            BUImageRes *imgres = _dataArr[0];
               //            if (!imgres.isCached) {
               //                _width = 150 * FITWIDTHSCALE;
               //                _height = 150 * FITWIDTHSCALE;
               //                self.height = 154.5* FITWIDTHSCALE;
               //                _collectionView.width = 160 * FITWIDTHSCALE;
               //            }
               //            else
               //            {
               //                UIImage *img = [UIImage imageWithContentsOfFile:imgres.cacheFile];
               ////                if(img.size.width >= (320 - 56 - 20) * [UIScreen mainScreen].scale)//固定宽度
               ////                {
               //                   _width = (320 - 56 - 20)* FITWIDTHSCALE;
               //                    _height = _width * (img.size.height/(img.size.width*1.0))* FITWIDTHSCALE;
               //                    if (_height > 160) {
               //                        _height = (160)* FITWIDTHSCALE;
               //                        _width = _height * (img.size.width/(img.size.height*1.0))* FITWIDTHSCALE;
               //                        if(_width > (320 - 56 - 20)* FITWIDTHSCALE)
               //                        {
               //                        _width = (320 - 56 - 20)* FITWIDTHSCALE;
               //                        _height = _width * (img.size.height/(img.size.width*1.0))* FITWIDTHSCALE;
               //                        }
               ////                        else
               ////                        {
               //                        self.height = 4* FITWIDTHSCALE + _height;
               //                        _collectionView.width = 10 * FITWIDTHSCALE + _width;
               ////                        }
               //                    }
               //                    else
               //                    {
               //                    self.height = 4* FITWIDTHSCALE + _height;
               //                    _collectionView.width = 10 * FITWIDTHSCALE + _width;
               //                    }
               ////                }
               ////                else//固定高度
               ////                {
               ////                    _height = 160* FITWIDTHSCALE;
               ////                    _width = _height * (img.size.width/(img.size.height*1.0))* FITWIDTHSCALE;
               ////                    self.height = 4* FITWIDTHSCALE + _height;
               ////                    _collectionView.width = 10 * FITWIDTHSCALE + _width;
               ////                }
               //            }
               //
               //        }
               //            break;
               //        case 2:
               //        {
               //            _width = 80 * FITWIDTHSCALE;
               //            _height = 80 * FITWIDTHSCALE;
               //            self.height = 83* FITWIDTHSCALE;
               //             _collectionView.width = 163 * FITWIDTHSCALE;
               //        }
               //            break;
               //        case 3:
               //        {
               //            _width = 80 * FITWIDTHSCALE;
               //            _height = 80 * FITWIDTHSCALE;
               //            self.height = 83* FITWIDTHSCALE;
               //             _collectionView.width = 243 * FITWIDTHSCALE;
               //        }
               //            break;
               //        case 4: case 5: case 6:
               //        {
               //            _width = 80 * FITWIDTHSCALE;
               //            _height = 80 * FITWIDTHSCALE;
               //            self.height = 172* FITWIDTHSCALE;
               //             _collectionView.width = 243 * FITWIDTHSCALE;
               //        }
               //            break;
               
          default:
          {
               _width = (__SCREEN_SIZE.width - _collectionView.x - 15 - 20)/3.0;
               _height = _width;
               self.height = ((_height + 10) * ((_count + 2)/3));
               _collectionView.width = __SCREEN_SIZE.width - _collectionView.x - 15;//_width * 3 + 40;
          }
               break;
     }
     _collectionView.height = self.height;
     [_collectionView reloadData];
     _containerView.width = __SCREEN_SIZE.width;
     _containerView.height = self.height;
     if (_count == 0) {
          _containerView.height = 0;
          self.height = 0;
          self.contentView.clipsToBounds = YES;
     }
     else
     {
          self.contentView.clipsToBounds = NO;
     }
   
}

-(void)fitTopicMode
{
     [self fitMode];
     _collectionView.userInteractionEnabled = NO;
     _collectionView.x = 15;
     _width = (__SCREEN_SIZE.width - _collectionView.x - 15 - 20)/3.0;
//     _height = 100;
      _collectionView.width = __SCREEN_SIZE.width - _collectionView.x - 15;
     _height = 100;
     self.height = ((_height + 10) * ((_count + 2)/3));
     _collectionView.height = ((_height + 10) * ((_count + 2)/3));
}


-(void)fitEvaMode
{
     self.height = 110;
     _collectionView.x = 15;
     _width = (__SCREEN_SIZE.width - _collectionView.x - 15 - 20)/3.0;
     _height = 100;
     self.height = ((_height + 10) * ((_count + 2)/3));
     _collectionView.width = __SCREEN_SIZE.width - _collectionView.x - 15;//_width * 3 + 40;
}


//-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
//{
//    if ([keyPath isEqualToString:@"height"]) {
//        _collectionView.height = self.height;
//    }
//    
//}

//-(void)dealloc
//{
//    [self removeObserver:self forKeyPath:@"height" context:nil];
//}

-(id)heightOfCell
{
    return @(self.height);
}

@end
