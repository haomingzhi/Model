//
//  ShowImgTableViewCell.m
//  yihui
//
//  Created by orange on 15/9/25.
//  Copyright (c) 2015年 ORANLLC_IOS1. All rights reserved.
//

#import "ShowImgTableViewCell.h"
#import "CollectionViewCell.h"
@implementation ShowImgTableViewCell{
    
    IBOutlet UICollectionView *_collectionView;
    NSInteger numberOfCell;
    NSMutableArray *imgList;
}

- (void)awakeFromNib {
    // Initialization code
    self.backgroundColor=[UIColor whiteColor];
    UICollectionViewFlowLayout *horizontalScrollLayout = [UICollectionViewFlowLayout new];
    horizontalScrollLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
     numberOfCell=(__SCREEN_SIZE.width)/90;
    horizontalScrollLayout.minimumLineSpacing=(__SCREEN_SIZE.width-numberOfCell*80)*1.0/(numberOfCell-1);
    horizontalScrollLayout.sectionInset = UIEdgeInsetsMake(5, 10, 5, 10);
    [horizontalScrollLayout setItemSize:CGSizeMake(80, 80)];
    _collectionView.collectionViewLayout = horizontalScrollLayout;
   
    [_collectionView registerNib:[UINib nibWithNibName:@"CollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"CollectionViewCell"];
    _collectionView.backgroundColor = [UIColor clearColor];;
    _collectionView.scrollEnabled=NO;
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
}
-(void)setCellData:(NSDictionary *)dataDic{
    imgList=dataDic[@"imgList"];
    [_collectionView reloadData];
}
-(void)heightOfCell:(NSDictionary *)dataDic
{
    NSArray *  list=dataDic[@"imgList"];
    self.height=list.count==0?0:ceilf((list.count*1.0+1)/numberOfCell)*90;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
   // NSLog(@"ccccc%ld",numberOfCell);
    return (imgList.count+1-section*numberOfCell)>numberOfCell?numberOfCell:imgList.count+1-section*numberOfCell;
    
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    // NSLog(@"sssss%f",ceilf(imgList.count*1.0/numberOfCell));
    return ceilf((imgList.count*1.0+1)/numberOfCell);
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * identifier = @"CollectionViewCell";
    UICollectionViewCell *cell;
    cell= [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
   
    CollectionViewCell *imgCell=(CollectionViewCell *)cell;
    if (indexPath.section*numberOfCell+indexPath.row==imgList.count) {
        imgCell.imgCell.image=[UIImage imageNamed:@"icon_add-picture"];
        imgCell.deletadeBtn.hidden=YES;
    }
    else {
        imgCell.deletadeBtn.hidden=NO;
    imgCell.imgCell.image=imgList[indexPath.section*numberOfCell+indexPath.row];
    }
    imgCell.deletadeBtn.tag=indexPath.section*numberOfCell+indexPath.row;
    imgCell.deleBlock=^(NSInteger item){
            [imgList removeObjectAtIndex:item];
            if (_reloadCellBlock) {
                _reloadCellBlock(imgList);
            }
    };
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section*numberOfCell+indexPath.row==imgList.count) {
        if (_addImgBlock) {
            _addImgBlock();
        }
    }
   
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
