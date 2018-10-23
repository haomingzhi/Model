//
//  ConditionsforscreeningViewController.m
//  oranllcshoping
//
//  Created by Steve on 2017/8/9.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import "ConditionsforscreeningViewController.h"
//#import "SelectBtnCollectionViewCell.h"
#import "TitleCollectionReusableView.h"
#import "ImgTitleAndDetailCollectionViewCell.h"

@interface ConditionsforscreeningViewController ()

@end

@implementation ConditionsforscreeningViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
     [self initCollectionView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initCollectionView{
     self.view.height = __SCREEN_SIZE.height - 64 - 30;
     self.view.width = __SCREEN_SIZE.width;
     _collectionView.height = __SCREEN_SIZE.height - 64 - 30-44;
     _collectionView.width = __SCREEN_SIZE.width;
     _collectionView.x =0;
     _collectionView.layer.borderColor = kUIColorFromRGB(color_lineColor).CGColor;
     _collectionView.layer.borderWidth = 0.5;
     
     
     _resetBtn.width = __SCREEN_SIZE.width/2.0;
     _resetBtn.y = _collectionView.y + _collectionView.height;
     
     _confirmBtn.x = __SCREEN_SIZE.width/2.0;
     _confirmBtn.width = _resetBtn.width;
     _confirmBtn.y = _resetBtn.y;
     
     
     
     [self.collectionView registerClass:[TitleCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"TitleCollectionReusableView"];
     
     [_collectionView registerNib:[UINib nibWithNibName:@"ImgTitleAndDetailCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
     _collectionView.dataSource = self;
     _collectionView.delegate = self;
     _dataArr  = [NSMutableArray new];
     _selectedArr = [NSMutableArray new];
     
     
}

#pragma mark collectionView datasource

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
     return _dataArr.count;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
     NSDictionary *dic = _dataArr[section];
     NSArray *arr = dic[@"arr"];
     return arr.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
     ImgTitleAndDetailCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
     NSDictionary *dic = _dataArr[indexPath.section];
     NSArray *arr = dic[@"arr"];
     [cell setCellData:arr[indexPath.row]];
     __block BOOL isSelected = NO;
     [_selectedArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
          NSIndexPath *path = obj;
          if ([indexPath isEqual: path]) {
               [cell fitTypeModeA];
               isSelected = YES;
          }
     }];
     if (!isSelected) {
          [cell fitTypeMode];
     }
     return cell;
}

#pragma mark collectionView delegatte


//创建头视图
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind
                                 atIndexPath:(NSIndexPath *)indexPath {
     
     TitleCollectionReusableView *headView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                                                                             withReuseIdentifier:@"TitleCollectionReusableView"
                                                                                    forIndexPath:indexPath];
     NSDictionary *dic = _dataArr[indexPath.section];
     [headView fitCellMode];
     [headView setCellData:@{@"title":dic[@"title"]}];
     
     
     return headView;
}


//返回头headerView的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
     CGSize size={__SCREEN_SIZE.width,45};
     return size;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
     CGFloat width = 70;
     CGFloat height = 25;
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
     return 15;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
     return 15;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
     __block BOOL isSelected = NO;
     ImgTitleAndDetailCollectionViewCell *cell = (ImgTitleAndDetailCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
     [_selectedArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
          NSIndexPath *path = obj;
          if ([indexPath isEqual: path]) {
               [cell fitTypeMode];
               [_selectedArr removeObjectAtIndex:idx];
               isSelected = YES;
          }
     }];
     if (!isSelected) {
          [cell fitTypeModeA];
          [_selectedArr addObject:indexPath];
     }
     
}

- (IBAction)resetAction:(UIButton *)sender {
     [_selectedArr removeAllObjects];
     [_collectionView reloadData];
}
- (IBAction)confirmAction:(UIButton *)sender {
     [self.parentDialog dismiss];
}


static  ConditionsforscreeningViewController *dealvc;
+(ConditionsforscreeningViewController *)createVC:(NSArray *)arr
{
     static dispatch_once_t onceToken;
     dispatch_once(&onceToken, ^{
          dealvc = [[ConditionsforscreeningViewController alloc] init];
     });
     
     //   DealPasswordViewController *dealvc = [DealPasswordViewController new];
     MyDialog *myDialog = [[MyDialog alloc] initWithViewController:dealvc];
     [dealvc initCollectionView];
     dealvc.dataArr = [arr mutableCopy];
     [dealvc.collectionView reloadData];
     myDialog.mydelegate = dealvc;
     myDialog.bgColor = [UIColor clearColor];
     myDialog.isDownAnimate = NO;
     //     [myDialog show];
     [myDialog showAtPosition:CGPointMake(0,64+30) animated:NO];
     myDialog.dismissOnTouchOutside = YES;
     
     
     return dealvc;
     
}


@end
