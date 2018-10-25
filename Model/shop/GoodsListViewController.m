//
//  GoodsListViewController.m
//  compassionpark
//
//  Created by Steve on 2017/1/22.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import "GoodsListViewController.h"
#import "ImgTitleAndDetailCollectionViewCell.h"
#import "ImageBtn.h"
#import "ZJMenuWithImgView.h"
#import "TypeChoseViewController.h"
#import "MenuSelectionViewController.h"
//#import "GoodsInfoViewController.h"
#import "BUSystem.h"
//#import "MJRefresh.h"

@interface GoodsListViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>{
//    NSArray *_dataArr;
    UIButton *_sortBtn;
    UIButton *_goodKindBtn;
    ZJMenuWithImgView *_topView;
    UIButton *_backBtn;
    NSInteger _requestCount;
}
@property (strong, nonatomic) TypeChoseViewController *typeVC;
@property (strong, nonatomic) TypeChoseViewController *sortVC;
@property (strong, nonatomic) MenuSelectionViewController *menuSelectionVC;
@property (assign,nonatomic) NSInteger index;
@property (strong,nonatomic) NSMutableArray *dataArr;
@property (strong,nonatomic) NSMutableArray *typeArr;
@property (strong,nonatomic) NSString *goodTypeId;
@property (strong,nonatomic) NSString *orderByType;
@end

@implementation GoodsListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"商品";
//    [self initCollectionView];
//    [self initMenuView];
    _orderByType = @"0";
    _goodTypeId = @"";
    [self getData];
    
   
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)getData{
    [self getGoodsListData];
    _requestCount++;
//    [busiSystem.goodsListManager GetGoodsTypeList:self callback:@selector(GetGoodsTypeListNotification:) extraInfo:nil];
}

-(void)getGoodsListData{
    _requestCount++;
//    [busiSystem.goodsListManager getGoodsList:_goodTypeId withName:@"" withIsTop:@"-1" withIsRecommend:@"-1" withOrderByType:_orderByType  observer:self callback:@selector(getGoodsListNotification:)];
}

-(void)GetGoodsTypeListNotification:(BSNotification *)noti
{
    _requestCount--;
    if (_requestCount == 0) {
//        BASENOTIFICATION(noti);
    }
    else
    {
//        BASENOTIFICATIONWITHCANMISS(noti, NO);
    }
    if (noti.error.code == 0) {
        //        HUDDISMISS;
//        _typeArr = [NSMutableArray arrayWithArray:busiSystem.goodsListManager.goodsTypeList];
//        [_collectionView reloadData];
    }
    else
    {
//        HUDCRY( noti.error.domain , 1);
    }
}


//-(void)getGoodsListNotification:(BSNotification *)noti
//{
//    _requestCount--;
//    if (_requestCount == 0) {
//        BASENOTIFICATION(noti);
//    }
//    else
//    {
//        BASENOTIFICATIONWITHCANMISS(noti, NO);
//    }
//    if (noti.error.code == 0) {
//        //        HUDDISMISS;
////        _dataArr = [NSMutableArray arrayWithArray:busiSystem.goodsListManager.goodsList];
////        [_collectionView reloadData];
//        // 结束刷新
//
////        if (busiSystem.goodsListManager.pageInfo.hasMore) {
////            [self.collectionView.mj_footer endRefreshing];
////        }else{
////            [_collectionView.mj_footer endRefreshingWithNoMoreData];
////        }
//        [[JYNoDataManager manager] addNodataView:_collectionView withTip:@"暂无信息" withImg:@"icon_noData@2x" withCount:_dataArr.count withTag:[NSString stringWithFormat:@"myac%d",0]];
//        [[JYNoDataManager manager] fitModeY:55];
////        if (_dataArr.count == 0) {
////            _topView.hidden = YES;
////        }else{
////            _topView.hidden = NO;
////        }
//    }
//    else
//    {
//        HUDCRY( noti.error.domain , 1);
//    }
//}


//-(void)addBackBtn{
//    _backBtn = [[UIButton alloc]initWithFrame:CGRectMake(15, 5.5, 10, 18)];
//    [_backBtn setBackgroundImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateNormal];
//    [_backBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
//    _backBtn.backgroundColor = [UIColor grayColor];
//    [self.view addSubview:_backBtn];
//
//}

//-(void)backAction{
//    [self.navigationController popViewControllerAnimated:YES];
//}

-(void)initMenuView{
//    UIView *menuView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, __SCREEN_SIZE.width, 44)];
//    [self.view addSubview:menuView];
    /*
    _sortBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, __SCREEN_SIZE.width/2.0, 44)];
    [_sortBtn setTitle:@"最新上架" forState:UIControlStateNormal];
    [_sortBtn setTitleColor:kUIColorFromRGB(color_3) forState:UIControlStateNormal];
    [_sortBtn setImage:[UIImage imageNamed:@"up"] forState:UIControlStateNormal];
    [_sortBtn addTarget:self action:@selector(sortAction:) forControlEvents:UIControlEventTouchUpInside];
    _sortBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    _sortBtn.layer.borderWidth = 0.5;
    _sortBtn.layer.borderColor = kUIColorFromRGB(color_lineColor).CGColor;
    _sortBtn.titleEdgeInsets =UIEdgeInsetsMake(0, 0, 0, 10);
    [self.view addSubview:_sortBtn];
    
    _goodKindBtn = [[UIButton alloc]initWithFrame:CGRectMake(__SCREEN_SIZE.width/2.0, 0, __SCREEN_SIZE.width/2.0, 44)];
    [_goodKindBtn setTitle:@"全部商品" forState:UIControlStateNormal];
    [_goodKindBtn setTitleColor:kUIColorFromRGB(color_3) forState:UIControlStateNormal];
    [_goodKindBtn setImage:[UIImage imageNamed:@"up"] forState:UIControlStateNormal];
    [_goodKindBtn addTarget:self action:@selector(goodKindAction:) forControlEvents:UIControlEventTouchUpInside];
    _goodKindBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    _goodKindBtn.layer.borderWidth = 0.5;
    _goodKindBtn.layer.borderColor = kUIColorFromRGB(color_lineColor).CGColor;
    [self.view addSubview:_goodKindBtn];
    */
    
    _topView = [[ZJMenuWithImgView alloc]initWithFrame:CGRectMake(0, 0, __SCREEN_SIZE.width, 44)];
    _topView.normalColor = kUIColorFromRGB(color_1);
    _topView.selectedColor = kUIColorFromRGB(color_3);
    _topView.selectedImage = [UIImage imageNamed:@"up"];
    _topView.NormalImage = [UIImage imageNamed:@"down"];
    [_topView setMenuData:@[@"最新上架",@"全部商品"]];
    __weak GoodsListViewController *weakSelf = self;
    [_topView setCallBack:^(NSDictionary *dic) {
        NSInteger index = [dic[@"index"] integerValue] -10000;
        [_topView setTitle:@"" index:index isSelect:YES];
        switch (index) {
            case 0:
            {
                
                NSArray *arr = @[@"最新上架",@"价格由高到低",@"价格由低到高"];
                weakSelf.menuSelectionVC = [MenuSelectionViewController toMenuSelectionVC:arr withIndex:weakSelf.index];
                [weakSelf.menuSelectionVC setCallBack:^(NSDictionary *dic) {
                    weakSelf.index = [dic[@"index"] integerValue];
                    weakSelf.orderByType = dic[@"index"];
                    [_topView setTitle:arr[weakSelf.index] index:0 isSelect:NO];
//                    HUDSHOW(@"加载中");
                    [weakSelf getGoodsListData];
                }];
                
//                [weakSelf toSortVC];
            }
                break;
            case 1:
            {
                [weakSelf toTypeVC];
            }
                break;
            default:
                break;
        }
    }];
    [self.view addSubview:_topView];
}


-(void)toSortVC
{
    __weak GoodsListViewController *weakSelf = self;
    NSMutableArray *arr = [NSMutableArray new];
    for (int i = 0; i<3; i++) {
        [arr addObject:[NSString stringWithFormat:@"商品%d",i]];
    }
    //    CGRect frame = [_tableView rectForRowAtIndexPath:[NSIndexPath indexPathForRow:4 inSection:0]];
    _sortVC = [TypeChoseViewController toSortVC:arr withHeight:44+64];
    _sortVC.cancelAction = ^(){
        //        weakSelf.clickEnable = YES;
    };
    _sortVC.handleAction = ^(NSDictionary *dic){
        [weakSelf.sortVC.parentDialog dismiss];
        //        [weakSelf loadNewData:dic];
        //       weakSelf.clickEnable = YES;
    };
}

-(void)toTypeVC
{
    __weak GoodsListViewController *weakSelf = self;
    NSMutableArray *arr = [NSMutableArray new];
    [arr addObject:@"全部"];
//    for (BUGoodsType *type in _typeArr) {
//        [arr addObject:type.name];
//    }
    //    CGRect frame = [_tableView rectForRowAtIndexPath:[NSIndexPath indexPathForRow:4 inSection:0]];
    _typeVC = [TypeChoseViewController toTypeVC:arr withHeight:44+64];
    
    
    _typeVC.cancelAction = ^(){
//        [weakSelf.menuView fitMyServerApplyMode:NO];
//        weakSelf.clickEnable = YES;
    };
    _typeVC.handleAction = ^(NSDictionary *dic){
        [weakSelf.typeVC.parentDialog dismiss];
        NSInteger index = [dic[@"index"] integerValue];
        if (index == 0) {
            weakSelf.goodTypeId = @"";
        }else{
//            BUGoodsType *type= [weakSelf.typeArr objectAtIndex:index-1];
//            _goodTypeId = type.id;
        }
        [_topView setTitle:dic[@"title"] index:1 isSelect:NO];

//        HUDSHOW(@"加载中");
        [weakSelf getGoodsListData];
    };
}



-(void)sortAction:(UIButton *)sender{

}

-(void)goodKindAction:(UIButton *) sender{
    
}


-(void)initCollectionView{
    
    // Register nib file for the cell
    UINib *nib = [UINib nibWithNibName:@"ImgTitleAndDetailCollectionViewCell"
                                bundle: [NSBundle mainBundle]];
    [_collectionView registerNib:nib forCellWithReuseIdentifier:@"ImgTitleAndDetailCollectionViewCell"];
    
    //    [_collectionView registerNib:[UINib nibWithNibName:@"ShopHeaderCollectionReusableView"
    //                                                bundle: [NSBundle mainBundle]] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ShopHeaderCollectionReusableView"];
    
    _collectionView.x = 0;
    _collectionView.y = 44;
    _collectionView.height = __SCREEN_SIZE.height - 64-44;
    _collectionView.width = __SCREEN_SIZE.width;
    //    _collectionView.minimumZoomScale = 15;
    self.view.backgroundColor = kUIColorFromRGB(color_9);
    _collectionView.backgroundColor = kUIColorFromRGB(color_9);
    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    
    // 上拉刷新
//    self.collectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        _requestCount++;
//        [busiSystem.goodsListManager getGoodsListNextPage:self callback:@selector(getGoodsListNotification:)];

//    }];
    // 默认先隐藏footer
//    self.collectionView.mj_footer.hidden = NO;

}

#pragma mark - collectionView

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _dataArr.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    ImgTitleAndDetailCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier: @"ImgTitleAndDetailCollectionViewCell"
                                                                                          forIndexPath:indexPath];
    //    [cell setBackgroundColor:[UIColor grayColor]];
//    BUGoods *goods = [_dataArr objectAtIndex:indexPath.row];
//    [cell setCellData:[goods getDic]];
//    [cell fitShopMode:indexPath];
    //    cell.contentView.backgroundColor = [UIColor yellowColor];
    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(__SCREEN_SIZE.width/2.0, (__SCREEN_SIZE.width/2.0 - 25)/310.0 *290+70);
}

////定义每个Section 的 margin
//-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
//{
//    return UIEdgeInsetsMake(15, 15, 5, 15);//分别为上、左、下、右
//}

//-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
//    ShopHeaderCollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ShopHeaderCollectionReusableView" forIndexPath:indexPath];
//    if (indexPath.section == 0) {
//        [header setCellData:@{@"title":@"推荐礼品卡",@"detail":@"更多礼品卡"}];
//
//    }else{
//        [header setCellData:@{@"title":@"推荐商品",@"detail":@"更多商品"}];
//    }
//    return header;
//}

////返回头headerView的大小
//-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
//    CGSize size={__SCREEN_SIZE.width,45};
//    return size;
//}
////返回头footerView的大小
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
//{
//    CGSize size={__SCREEN_SIZE.width,10};
//    return size;
//}

//每个item之间的间距
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
//{
//    return 100;
//}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"CLICK %ld-%ld",(long)indexPath.section,(long)indexPath.row);
//    GoodsInfoViewController *vc = [GoodsInfoViewController new];
////    vc.isPresentCard = NO;
////    BUGoods *goods = [_dataArr objectAtIndex:indexPath.row];
////    vc.ID = goods.goodsId;
//    [self.navigationController pushViewController:vc animated:YES];
}



@end
