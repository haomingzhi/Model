//
//  AddImgTableViewCell.m
//  ChaoLiu
//
//  Created by air on 15/7/16.
//  Copyright (c) 2015年 ORANLLC_IOS1. All rights reserved.
//

#import "AddImgTableViewCell.h"
#import "AddImgCollectionViewCell.h"

@implementation AddImgTableViewCell
{
    NSMutableArray *_dataArr;
    IBOutlet UICollectionView *_collectionView;
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
    [_collectionView registerNib:[UINib nibWithNibName:@"AddImgCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"AddImgCollectionViewCell"];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    // CGFloat height = (__SCREEN_SIZE.width/2.0) * (258/160.0);
    
    
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat width = AddImgListCellWidth;
    CGFloat height = width * AddImgListScale;
    CGSize size =  CGSizeMake(width, height);
    //     self.height = height;
    _collectionView.height = height + 20;
    return size;
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
    if ((_limitCount == 0 || _limitCount > _dataArr.count + 1) && indexPath.row == 0) {
        [cell setCellData:@{@"img":@"icon_add-picture",@"row":@(indexPath.row),@"hiddenDeleteBtn":@(YES)}];
        
    }
    else
    {
        if (_limitCount < _dataArr.count + 1 || _limitCount == _dataArr.count) {
            row = indexPath.row;
          id  img = _dataArr[row];
            [cell setCellData:@{@"img":img,@"row":@(row)}];
//            cell.deleteHandle = ^(NSInteger item){
//                [_dataArr removeObjectAtIndex:item];
//                [_collectionView reloadData];
////                if (_deleteItem) {
////                    _deleteItem(item);
////                }
//                if (self.handleAction) {
//                    self.handleAction(@{@"row":@(indexPath.row),@"method":@(2)});
//                }
//            };
        }
        else
        {
            if (indexPath.row == 0) {
                [cell setCellData:@{@"img":@"icon_add-picture",@"row":@(indexPath.row),@"hiddenDeleteBtn":@(YES)}];
            }
            else
            {
          
                row = indexPath.row - 1;
               id img = _dataArr[row];
                [cell setCellData:@{@"img":img,@"row":@(row)}];
//                cell.deleteHandle = ^(NSInteger item){
//                    [_dataArr removeObjectAtIndex:item];
//                    [_collectionView reloadData];
////                    if (_deleteItem) {
////                        _deleteItem(item);
////                    }
//                    if (self.handleAction) {
//                       self.handleAction(@{@"row":@(indexPath.row),@"method":@(2)});
//                    }
//                };

            }
        }
//        if (_dataArr.count == 0) {
//               [cell setCellData:@{@"img":@"addImg",@"row":@(indexPath.row),@"hiddenDeleteBtn":@(YES)}];
//        }
//        else
//        {
//            BUImageRes *img = _dataArr[row];
//            [cell setCellData:@{@"img":img,@"row":@(row)}];
//            cell.deleteHandle = ^(NSInteger item){
//                [_dataArr removeObjectAtIndex:item];
//                [_collectionView reloadData];
//            };
//        }
    }


    //    BUAction *action = busiSystem.actionManager.actions[row];
    //    if (action.img.isCached) {
    //        cell.imgView.image =  [UIImage imageWithContentsOfFile:action.img.cacheFile];
    //    }
    //    else {
    //        [action.img download:self callback:@selector(getImgNotification:) extraInfo:@{@"index":indexPath}];
    //    }
    
    return cell;
}

-(void)setCellData:(NSDictionary *)dataArr
{
    //    _pageCount = busiSystem.actionManager.actions.count;
    //    _pageCl.numberOfPages = _pageCount;
    _limitCount = [dataArr[@"limitCount"] integerValue];
    _dataArr = [NSMutableArray arrayWithArray:dataArr[@"arr"]];
     [_dataArr addObject:@"icon_add-picture"];
    [_collectionView reloadData];
    [super setCellData:dataArr];
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
         if (  _dataArr.count - 1 == indexPath.row) {
            self.handleAction(@{@"row":@(indexPath.row),@"method":@(1)});
        }
        else
        {
         self.handleAction(@{@"row":@(indexPath.row),@"method":@(2)});
        }
        
    }
}
@end
