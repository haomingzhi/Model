//
//  SelectBtnsTableViewCell.m
//  yihui
//
//  Created by air on 15/9/16.
//  Copyright (c) 2015年 ORANLLC_IOS1. All rights reserved.
//

#import "SelectBtnsTableViewCell.h"
#import "SelectBtnCollectionViewCell.h"
@implementation SelectBtnsTableViewCell
{
    NSMutableArray *_dataArr;
    IBOutlet UICollectionView *_collectionView;

    NSInteger _selectRow;
}
- (void)awakeFromNib {
    // Initialization code
    [self initCollectionView];
//    self.backgroundColor = kUIColorFromRGB(color_0xebf0f1);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

-(void)initCollectionView
{
    _selectRow = 0;
    [_collectionView registerNib:[UINib nibWithNibName:@"SelectBtnCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"SelectBtnCollectionViewCell"];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    // CGFloat height = (__SCREEN_SIZE.width/2.0) * (258/160.0);
//    _collectionView.backgroundColor = kUIColorFromRGB(color_0xebf0f1);
    
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat width = TitleAndSelectBtnCellWidth;
    CGFloat height = width * TitleAndSelectBtnScale;
    CGSize size =  CGSizeMake(width, height);
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
    SelectBtnCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SelectBtnCollectionViewCell" forIndexPath:indexPath];
    NSInteger row = indexPath.row;
//    BUProductAttr *att = _dataArr[row ];
    NSString *title =  _dataArr[row ];
    [cell setCellData:@{@"title":title,@"isChecked":@(indexPath.row == _selectRow)}];
    
    return cell;
}

-(void) fitCell:(NSMutableArray *)arr
{
    _dataArr = arr;
    //    [_collectionView reloadData];
    //   _collectionView.height = _collectionView.contentSize.height;
    CGFloat width = TitleAndSelectBtnCellWidth;
    CGFloat height = width * TitleAndSelectBtnScale;
    _collectionView.height = ((arr.count + 3)/4) * height + 22;
    
    self.height = _collectionView.y + _collectionView.height + 12;
}

-(CGFloat)heightOfCell:(NSMutableArray *)attrs
{
    [self fitCell:attrs];
    return  self.height;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    _selectRow = indexPath.row;
    [_collectionView reloadData];
    if (self.handleAction) {
        
        self.handleAction(@(indexPath.row));
    }
}
-(void)setCellData:(NSDictionary *)dataDic
{

    //    NSArray *attrs = dataDic[@"attrs"];
    //     _dataArr = dataDic[@"attrs"];
    //    [_collectionView reloadData];
    [self fitCell:dataDic[@"arrs"]];
}


@end
