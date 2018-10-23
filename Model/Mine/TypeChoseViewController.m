//
//  TypeChoseViewController.m
//  taihe
//
//  Created by air on 2016/11/8.
//  Copyright © 2016年 ORANLLC_IOS1. All rights reserved.
//

#import "TypeChoseViewController.h"
#import "JYContainerView.h"
@interface TypeChoseViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
{
  
}

@end

@implementation TypeChoseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initCollectionView];
    [self setDataSource];
}

-(void)initCollectionView
{
    [_collectionView registerNib:[UINib nibWithNibName:@"SelectBtnCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"SelectBtnCollectionViewCell"];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.bounces = YES;
    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.backgroundColor = kUIColorFromRGB(color_2);
    
   
}
-(void)fitMode
{
    
    __weak TypeChoseViewController *weakSelf = self;
    _collectionView.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _collectionView.width = __SCREEN_SIZE.width;
    _collectionView.height = 105;
    self.view.width = __SCREEN_SIZE.width;
    self.view.height = __SCREEN_SIZE.height - 64;
    self.view.backgroundColor = kUIColorFromRGBWithAlpha(color_12, 0.5);
    [(JYContainerView *)self.view setClickRect:CGRectMake(0, 105, __SCREEN_SIZE.width, __SCREEN_SIZE.height - 64 - 105 - 40)];
   [(JYContainerView *)self.view  setClickHandle:^(id o) {
       [weakSelf.parentDialog cancel];
   }];
}

-(void)setDataSource
{
    if(!_dataArr)
    {
        _dataArr = [NSMutableArray array];
        [_dataArr addObject:@"全部"];
        [_dataArr addObject:@"公区报修"];
        [_dataArr addObject:@"单元报修"];
        [_dataArr addObject:@"饮用水"];
        [_dataArr addObject:@"新装宽带电话"];
          [_dataArr addObject:@"会议室预定"];
           [_dataArr addObject:@"办公商务"];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _dataArr.count;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize size = CGSizeMake((__SCREEN_SIZE.width - 30 - 14)/3.0 , 53);
    if (_isRowShow) {
        size = CGSizeMake(__SCREEN_SIZE.width, 35);
    }
    return size;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (!_curIndexPath) {
        _curIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    }
    SelectBtnCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SelectBtnCollectionViewCell" forIndexPath:indexPath];
    [cell setCellData:@{@"title":_dataArr[indexPath.row],@"isChecked":@(_curIndexPath.row == indexPath.row)}];
    if (_curIndexPath.row == indexPath.row) {
        [cell fitRowShowMode];
    }
    else
    {
        [cell fitNormalMode];
    }
    cell.backgroundColor = kUIColorFromRGB(color_4);
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
    _curIndexPath = indexPath;
    [_collectionView reloadData];
    if (self.handleAction) {
        self.handleAction(@{@"title":_dataArr[indexPath.row],@"index":@(indexPath.row)});
    }
}

static TypeChoseViewController *dealvc;
static TypeChoseViewController *typevc;
+(TypeChoseViewController *)toTypeVC
{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dealvc = [[TypeChoseViewController alloc] init];

    });
    
    //   DealPasswordViewController *dealvc = [DealPasswordViewController new];
    MyDialog *myDialog = [[MyDialog alloc] initWithViewController:dealvc];
        dealvc.view.width = __SCREEN_SIZE.width;
    //    vc.doneCallBack = ^(NSString *pwd){
    //        [weakSelf toAddwithdraw:pwd];
    //    };
    myDialog.mydelegate = dealvc;
    myDialog.bgColor = [UIColor clearColor];
    myDialog.isDownAnimate = NO;
    [myDialog showAtPosition:CGPointMake(0, 44 + 64) animated:NO];
    myDialog.dismissOnTouchOutside = NO;
    [dealvc.collectionView reloadData];
   
    return dealvc;
}

+(TypeChoseViewController *)toTypeVC:(NSMutableArray *)dataArr withHeight:(CGFloat)height
{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        typevc = [[TypeChoseViewController alloc] init];
        typevc.dataArr = dataArr;
        [typevc.collectionView reloadData];
    });
    
//    typevc.dataArr = dataArr;
//    [typevc.collectionView reloadData];
    //   DealPasswordViewController *dealvc = [DealPasswordViewController new];
    MyDialog *myDialog = [[MyDialog alloc] initWithViewController:typevc];
    typevc.view.width = __SCREEN_SIZE.width;
    //    vc.doneCallBack = ^(NSString *pwd){
    //        [weakSelf toAddwithdraw:pwd];
    //    };
    myDialog.mydelegate = typevc;
    myDialog.bgColor = [UIColor clearColor];
    myDialog.isDownAnimate = NO;
    [myDialog showAtPosition:CGPointMake(0,height) animated:NO];
    myDialog.dismissOnTouchOutside = YES;
    
    [typevc.collectionView reloadData];
    return typevc;
}

static TypeChoseViewController *rowShowvc;
+(TypeChoseViewController *)toSortVC:(NSMutableArray *)dataArr withHeight:(CGFloat)height{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        rowShowvc = [[TypeChoseViewController alloc] init];
        rowShowvc.dataArr = dataArr;
        rowShowvc.isRowShow = YES;
        [rowShowvc.collectionView reloadData];
    });
    
    //    typevc.dataArr = dataArr;
    //    [typevc.collectionView reloadData];
    //   DealPasswordViewController *dealvc = [DealPasswordViewController new];
    MyDialog *myDialog = [[MyDialog alloc] initWithViewController:rowShowvc];
    rowShowvc.view.width = __SCREEN_SIZE.width;
    rowShowvc.view.height = 35*3;
    rowShowvc.collectionView.minimumZoomScale = 0.0;
    //    vc.doneCallBack = ^(NSString *pwd){
    //        [weakSelf toAddwithdraw:pwd];
    //    };
    myDialog.mydelegate = rowShowvc;
    myDialog.bgColor = [UIColor clearColor];
    myDialog.isDownAnimate = NO;
    [myDialog showAtPosition:CGPointMake(0,height) animated:NO];
    myDialog.dismissOnTouchOutside = YES;
    
    [rowShowvc.collectionView reloadData];
    
    return rowShowvc;
}


-(void) dismissBy:(MyDialog*)dialog withViewController:(UIViewController*)vc isCanceled:(BOOL)isCanceled
{
    if (isCanceled) {
        if (self.cancelAction) {
            self.cancelAction();
        }
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
