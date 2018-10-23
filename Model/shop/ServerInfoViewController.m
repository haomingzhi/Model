//
//  GoodsInfoViewController.m
//  compassionpark
//
//  Created by Steve on 2017/1/22.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import "ServerInfoViewController.h"
#import "FlashTableViewCell.h"
#import "FiveTitleTableViewCell.h"
#import "OnlyTitleTableViewCell.h"
#import "AddImgTableViewCell.h"
#import "PromoteTableViewCell.h"
#import "AddGoodsNumberViewController.h"
//#import "ConfirmPresentCardOrderViewController.h"
#import "ConfirmOrderOfGoodsViewController.h"
#import "TitleDetailTableViewCell.h"
#import "ImgAndThreeTitleTableViewCell.h"
//#import "ConfirmActivityOrderViewController.h"
#import "LoginViewController.h"
//#import "BindGiftCardViewController.h"
//#import "HuanxinKefuManager.h"
#import "JYCommonTool.h"
#import "TitleDetailTableViewCell.h"
#import "ShopInfoViewController.h"
#import "OnlyBottomBtnTableViewCell.h"
#import "ImgsTableViewCell.h"
#import "ZJMenuView.h"
#import "EvalutionListViewController.h"
#import "JYShareManager.h"
#import "NoDataTableViewCell.h"
#import "FillInServiceOrderInfoViewController.h"
#import "ZLPhotoPickerViewController.h"
#import "ZLPhotoPickerBrowserViewController.h"
#import "ZLPhotoPickerBrowserPhoto.h"
#import "ZLPhotoAssets.h"

@interface ServerInfoViewController (){
    CGFloat alp;
    FlashTableViewCell *_flashCell;
//    FiveTitleTableViewCell *_priceCell;
//    OnlyTitleTableViewCell *_intruducrTitleCell;
    OnlyTitleTableViewCell *_intruduceCell;
    TitleDetailTableViewCell *_promotionTitleCell;

    UIButton *_backBtn;
    NSInteger _requestCount;
    BOOL _isCollection;//是否收藏
    BOOL _needReloadData;
     BOOL _isEva;
     
     ImgAndThreeTitleTableViewCell *_priceCell;
     OnlyTitleTableViewCell *_commitmentCell;
     OnlyBottomBtnTableViewCell *_showAllEvaCell;
     ZJMenuView *_menuView;
     NoDataTableViewCell *_noEvaCell;
     
}
@property (nonatomic,strong) BUServiceInfo *serviceInfo;

@property (nonatomic,assign) NSInteger number;
@end

@implementation ServerInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
     self.title = @"商品详情";
     [self initMenu];
    [self initTableView];
    [self initBottomView];
//    [self addBackBtn];
    HUDSHOW(@"加载中");
    [self getData];
    
}


-(void)viewWillAppear:(BOOL)animated{
     [super viewWillAppear:animated];
     [self.navigationController setNavigationBarHidden:YES];
}

-(void)viewWillDisappear:(BOOL)animated{
     [super viewWillDisappear:animated];
     [self.navigationController setNavigationBarHidden:NO];
}

-(void)initMenu{
     _menuView = [[ZJMenuView alloc]initWithFrame:CGRectMake(0, 0, __SCREEN_SIZE.width, 40)];;
     [_menuView setData:@[@"服务介绍",@"用户评价"]];
     [_menuView setHandle:^(UIButton *btn) {
          if (btn.tag == 0) {
               _isEva = NO;
          }else{
               _isEva = YES;
          }
          [_tableView reloadData];
     }];
}

-(void)setTableViews
{}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)getData{
  
     [busiSystem.shopManager getServiceInfo:_ID observer:self callback:@selector(getServiceInfoNotification:)];


}

-(void)getServiceInfoNotification:(BSNotification *)noti
{

    if (noti.error.code == 0) {
         HUDDISMISS;
         _serviceInfo = busiSystem.shopManager.serviceInfo;
         
         [_flashCell setCellData:[_serviceInfo getDic:1]];
         [_flashCell fitGoodsMode];
         [_priceCell setCellData:[_serviceInfo getDic:2]];
         [_priceCell fitGoodsMode];
         [_commitmentCell setCellData:[_serviceInfo getDic:3]];
         [_commitmentCell fitServerInfoMode];
         _serviceInfo.intro = [JYCommonTool unescape:_serviceInfo.intro];
         [_intruduceCell setCellData:@{@"title":_serviceInfo.intro?:@""}];
         [_intruduceCell fitHtmlMode];
         [_tableView reloadData];
    }
    else
    {
        HUDCRY( noti.error.domain , 1);
    }
}




-(void)addBackBtn{
//    _backBtn = [[UIButton alloc]initWithFrame:CGRectMake(15, 34, 10, 18)];
    _backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 32, 40, 18)];
    [_backBtn setImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateNormal];
    [_backBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
//    _backBtn.backgroundColor = [UIColor grayColor];
    [self.view addSubview:_backBtn];
    
}

-(void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)initBottomView{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, __SCREEN_SIZE.height-45, __SCREEN_SIZE.width, 45)];
    view.backgroundColor = kUIColorFromRGB(color_2);
    view.layer.borderWidth = 0.5;
    view.layer.borderColor = kUIColorFromRGB(color_lineColor).CGColor;
    [self.view addSubview:view];
     
//     UIButton *cartBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 90, view.height)];
//     [cartBtn setImage:[UIImage imageNamed:@"icon_cart"] forState:UIControlStateNormal];
//     cartBtn.backgroundColor = kUIColorFromRGB(color_2);
//     [cartBtn addTarget:self action:@selector(showCartAction:) forControlEvents:UIControlEventTouchUpInside];
//     [view addSubview:cartBtn];
//
//     CGFloat width = __SCREEN_SIZE.width/2.0 - 45;
//    UIButton *addCartBtn = [[UIButton alloc]initWithFrame:CGRectMake(90, 0, width, view.height)];
//    [addCartBtn setTitle:@"加入购物车" forState:UIControlStateNormal];
//    [addCartBtn setTitleColor:kUIColorFromRGB(color_2) forState:UIControlStateNormal];
//    addCartBtn.titleLabel.font = [UIFont systemFontOfSize:16];
//    addCartBtn.backgroundColor = kUIColorFromRGB(color_3);
//    [addCartBtn addTarget:self action:@selector(addCartAction:) forControlEvents:UIControlEventTouchUpInside];
//    [view addSubview:addCartBtn];

    
    UIButton *buyBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, __SCREEN_SIZE.width, view.height)];
    [buyBtn setTitle:@"立即预约" forState:UIControlStateNormal];
    [buyBtn setTitleColor:kUIColorFromRGB(color_2) forState:UIControlStateNormal];
    buyBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [buyBtn addTarget:self action:@selector(buyAction:) forControlEvents:UIControlEventTouchUpInside];
    buyBtn.backgroundColor = kUIColorFromRGB(color_3);
    [view addSubview:buyBtn];
    
//    UIImageView *line1 = [[UIImageView alloc]initWithFrame:CGRectMake(__SCREEN_SIZE.width/2.0, 0, 0.5, view.height)];
//    [line1 setBackgroundColor:kUIColorFromRGB(color_5)];
//    [view addSubview:line1];
    
}



//-(void)showCartAction:(UIButton *)sender{
//     //   [HuanxinKefuManager kefuHandle:self];
//     NSLog(@"购物车");
//}
//
//-(void)addCartAction:(UIButton *)sender{
////   [HuanxinKefuManager kefuHandle:self];
//     NSLog(@"加入购物车");
//}



-(void)buyAction:(UIButton *)sender{
    if (!busiSystem.agent.isLogin) {
        [LoginViewController toLogin:self];
        _needReloadData = YES;
        return;
    }
     FillInServiceOrderInfoViewController *vc = [FillInServiceOrderInfoViewController new];
     vc.serviceInfo = _serviceInfo;
     [self.navigationController pushViewController:vc animated:YES];
}




-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        if (alertView.tag == 1) {
//            BindGiftCardViewController *vc = [BindGiftCardViewController new];
//            [self.navigationController pushViewController:vc animated:YES];
        }
//     SelectAddressViewController *vc = [SelectAddressViewController new];
//       [self.navigationController pushViewController:vc animated:YES];
    }
}

-(void)alertAction{
    NSLog(@"alert");
}


-(void)collectionAction{
//     [self.navigationController popViewControllerAnimated:YES];
     if (!busiSystem.agent.isLogin) {
          [LoginViewController toLogin:self];
          return;
     }
     NSLog(@"collect");
     [self addGoodsCollect];
}

-(void)shareAction{
//     [self.navigationController popViewControllerAnimated:YES];
//     NSLog(@"share");
//     NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"shareLogo@2x" ofType:@"png"];
//     
//     NSString *url = busiSystem.agent.config.shareUrl;
//     [[JYShareManager manager] showSheetView:self withShareTitle:@"尚享生活" withShareContent:@"尚享生活,每天与你相遇" withShareImgUrl:imagePath withUrl:url];
}


-(void)addGoodsCollect{
     HUDSHOW(@"加载中");
     [busiSystem.userManager addGoodsCollect:_ID productType:@"2" observer:self callback:@selector(addGoodsCollectNotification:)];
}


-(void)addGoodsCollectNotification:(BSNotification *)noti
{
     if (noti.error.code == 0) {
          HUDSMILE(@"收藏成功", 2);
          busiSystem.agent.isNeedRefreshTabD = YES;
     }
     else
     {
          HUDCRY( noti.error.domain , 1);
     }
}


-(void)initTableView{
    
     __weak ServerInfoViewController *weakSelf = self;
     _noEvaCell = [NoDataTableViewCell createTableViewCell];
     [_noEvaCell setCellData:@{@"title":@"暂无评价",@"img":@"nodata"}];
     [_noEvaCell fitCellMode];
     
     
    _flashCell = [FlashTableViewCell createTableViewCell];
     [_flashCell setCellData:@{@"arr":@[]}];
    [_flashCell fitGoodsMode];
     [_flashCell setSelecedtItem:^(NSDictionary *dic) {
          NSInteger row = [dic[@"row"] integerValue];
          NSMutableArray *imgArr = [NSMutableArray new];
          NSArray *arr = weakSelf.serviceInfo.imageList;
          if (arr.count !=0) {
               for (int i =0;i<arr.count;i++) {
                    UIImageView *myImageView = [[UIImageView alloc]init];
                    [imgArr addObject:myImageView];
               }
               [weakSelf setupPhotoBrowser:@{@"arr":arr?:@[],@"row":@(row),@"imgArr":imgArr}];
          }
     }];
     
     UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 13, 56, 50)];
     [backBtn setImage:[UIImage imageNamed:@"arrow_left_gray"] forState:UIControlStateNormal];
     [backBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
     [_flashCell.contentView addSubview:backBtn];
     
     UIButton *shareBtn = [[UIButton alloc]initWithFrame:CGRectMake(__SCREEN_SIZE.width-47.5, 13, 40, 50)];
     [shareBtn setImage:[UIImage imageNamed:@"share_gray"] forState:UIControlStateNormal];
     [shareBtn addTarget:self action:@selector(shareAction) forControlEvents:UIControlEventTouchUpInside];
     [_flashCell.contentView addSubview:shareBtn];
     
     UIButton *collectionBtn = [[UIButton alloc]initWithFrame:CGRectMake(__SCREEN_SIZE.width - 90, 13, 40, 50)];
     [collectionBtn setImage:[UIImage imageNamed:@"collection_gray"] forState:UIControlStateNormal];
     [collectionBtn addTarget:self action:@selector(collectionAction) forControlEvents:UIControlEventTouchUpInside];
     [_flashCell.contentView addSubview:collectionBtn];
     
    
//    __weak ServerInfoViewController *weakSelf = self;
    _priceCell = [ImgAndThreeTitleTableViewCell createTableViewCell];
    [_priceCell setCellData:@{@"title":@"",@"source":@"",@"time":@""}];
    [_priceCell fitGoodsMode];
     
     
     _showAllEvaCell = [OnlyBottomBtnTableViewCell createTableViewCell];
     [_showAllEvaCell setCellData:@{@"title":@"查看全部评价"}];
     [_showAllEvaCell fitGoodsInfoMode];
     [_showAllEvaCell setHandleAction:^(id sender) {
          EvalutionListViewController *vc = [EvalutionListViewController new];
          [weakSelf.navigationController pushViewController:vc animated:YES];
     }];
     
     _commitmentCell = [OnlyTitleTableViewCell createTableViewCell];
     NSMutableArray *arr = [NSMutableArray new];
//     [arr addObject:@"7×24h全天候服务"];
//     [arr addObject:@"不满意重做"];
//     [arr addObject:@"专业技术"];
//     [arr addObject:@"投诉即退款"];
     [_commitmentCell setCellData:@{@"title":@"服务承诺",@"arr":arr}];
     [_commitmentCell fitServerInfoMode];
     
    
     _promotionTitleCell = [TitleDetailTableViewCell createTableViewCell];
     [_promotionTitleCell setCellData:@{@"title":@"相关推荐",@"detail":@""}];
     [_promotionTitleCell fitShopInfoMode];
    
    _intruduceCell = [OnlyTitleTableViewCell createTableViewCell];
    [_intruduceCell setCellData:@{@"title":@""}];
    [_intruduceCell fitHtmlMode];
    
    
    
    [ImgAndThreeTitleTableViewCell registerTableViewCell:_tableView];
    [ImgsTableViewCell registerTableViewCell:_tableView];
     [_tableView registerNib:[UINib nibWithNibName:@"ImgAndThreeTitleTableViewCell" bundle:nil] forCellReuseIdentifier:@"promotion"];
    
    _tableView.x=0;
    
    _tableView.width = __SCREEN_SIZE.width;
     if (__IOS11) {
          _tableView.y =  -__STATUSBAR_HEIGHT;
           _tableView.height = __SCREEN_SIZE.height -45+__STATUSBAR_HEIGHT;
     }else{
          _tableView.y =  0;
           _tableView.height = __SCREEN_SIZE.height -45;
     }
   
    _tableView.refreshHeaderView = nil;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = kUIColorFromRGB(color_4);

     
    
}

-(void)addUserFavorite{
    HUDSHOW(@"提交中");
    _requestCount++;
    NSString *type = @"1";
     NSString *artId = @"";
//    if (_isPresentCard) {
//        type = @"2";
//    }else{
//        if (_isActivity) {
////            artId = _goodsDetail.actId;
//        }
//    }
   
    
//    [busiSystem.getUserFavoriteManager addUserFavorite:type withId:_ID withArtId:artId withType:@"1"  observer:self callback:@selector(addUserFavoriteNotification:)];
}

-(void)addUserFavoriteNotification:(BSNotification *)noti
{
    _requestCount--;
    if (_requestCount == 0) {
        BASENOTIFICATION(noti);
    }
    else
    {
        BASENOTIFICATIONWITHCANMISS(noti, NO);
    }
    if (noti.error.code == 0) {
        _isCollection = YES;
        TOASTSHOW(@"收藏成功!");
        [_tableView reloadData];
    }
    else
    {
        HUDCRY( noti.error.domain , 1);
    }
}

-(void)delUserFavorite{
    HUDSHOW(@"提交中");
    _requestCount++;
//    [busiSystem.getUserFavoriteManager delUserFavorite:_ID observer:self callback:@selector(delUserFavoriteNotification:)];
}

-(void)delUserFavoriteNotification:(BSNotification *)noti
{
    _requestCount--;
    if (_requestCount == 0) {
        BASENOTIFICATION(noti);
    }
    else
    {
        BASENOTIFICATIONWITHCANMISS(noti, NO);
    }
    if (noti.error.code == 0) {
        _isCollection = NO;
        TOASTSHOW(@"取消收藏成功!");
        [_tableView reloadData];
    }
    else
    {
        HUDCRY( noti.error.domain , 1);
    }
}

/*
-(void)viewWillDisappear:(BOOL)animated
{

    CGSize navBarSize = CGSizeMake(__SCREEN_SIZE.width, __NAVBAR_HEIGHT + __STATUSBAR_HEIGHT);
    [self.navigationController.navigationBar  setBackgroundImage:[UIImage imageWithColor: kUIColorFromRGB(color_mainTheme) withBounds:CGRectMake(0, 0, navBarSize.width,navBarSize.height)] forBarPosition:UIBarPositionTopAttached barMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.translucent = NO;

    self.navigationController.navigationBar.alpha = 1;

    _tableView.scrollEnabled = NO;
    if (__IOS9) {
        _tableView.delegate = nil;
    }
    
}

-(void)viewWillAppear:(BOOL)animated
{
    _tableView.delegate = self;
//    _tableView.dataSource = self;
//    [_tableView reloadData];
//    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeTop;
    CGSize navBarSize = CGSizeMake(__SCREEN_SIZE.width, __NAVBAR_HEIGHT + __STATUSBAR_HEIGHT);
    //   if (_tableView.contentOffset.y >= _tableView.contentInset.top && _tableView.contentOffset.y <= _tableView.contentInset.top + 3) {
    [self.navigationController.navigationBar  setBackgroundImage:[UIImage imageWithColor:kUIColorFromRGBWithAlpha(color_mainTheme,alp) withBounds:CGRectMake(0, 0, navBarSize.width,navBarSize.height)] forBarPosition:UIBarPositionTopAttached barMetrics:UIBarMetricsDefault];
    //    }
    
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
    [super viewWillAppear:animated];
//    busiSystem.agent.selectedIndex =0;
//    if (busiSystem.agent.gotoOder==YES) {
//        self.tabBarController.selectedIndex=1;
//        busiSystem.agent.gotoOder=NO;
//    }
    if (_needReloadData) {
        _needReloadData = NO;
        if (busiSystem.agent.isLogin) {
            HUDSHOW(@"加载中");
            [self getData];
        }
        
        
    }
    
    
}
 
*/

#pragma mark - tableView delegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
     NSInteger section = 2;
     if (_isEva) {
          section = _serviceInfo.commentList.count?:1;
          section ++;
     }
    return section;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger row = 2;
    if (section == 0) {
        row = 3;
    }else if(_isEva){//用户评价
         if(section <= _serviceInfo.commentList.count){
              row = 2;
         }else if(section == _serviceInfo.commentList.count+1){//显示全部评价
              row = 1;
         }
         
    }else{
         if (section == 1) {//服务介绍
              row = 1;
         }
    }
         
     
    return row;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell;
//    cell = [UITableViewCell new];
    if (indexPath.section == 0) {
         cell = [self creatFirstSectionCell:indexPath];
    }else{
         if (_isEva){//用户评价
              cell = [self createEvaCell:indexPath];
         }else{//商品介绍
              cell = [self createIntruduceCell:indexPath];
         }
        
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}



-(UITableViewCell *)createIntruduceCell:(NSIndexPath *)indexPath{
     UITableViewCell *cell ;
     if (indexPath.section == 1) {
          cell = _intruduceCell;
          [(JYAbstractTableViewCell *)cell showSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(cell.height, 0, 0, 0)];
     }
     
     return cell;
}




-(UITableViewCell *)createEvaCell:(NSIndexPath *)indexPath{
     UITableViewCell *cell ;
     if (indexPath.section == _serviceInfo.commentList.count+1) {//显示全部评价
          if (_serviceInfo.commentList.count == 0) {
               cell = _noEvaCell;
          }else
               cell = _showAllEvaCell;
            [(JYAbstractTableViewCell *)cell showSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(cell.height, 0, 0, 0)];
          
     }
     else{
          cell =  [self createEvaInfoCell:indexPath];
          
     }
   
     return cell;
}

-(UITableViewCell *)createEvaInfoCell:(NSIndexPath *)indexPath{
     UITableViewCell *cell ;
     BUGetComment *comment = _serviceInfo.commentList[indexPath.section - 1];
     
     if (indexPath.row == 0) {
          cell = [ImgAndThreeTitleTableViewCell dequeueReusableCell:_tableView];
          [(ImgAndThreeTitleTableViewCell *)cell setCellData:[comment getDic:0]];
          [(ImgAndThreeTitleTableViewCell *)cell fitEvaMode];
          if (comment.picList.count == 0) {
               [(JYAbstractTableViewCell *)cell showSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(cell.height, 0, 0, 0)];
          }else{
               [(JYAbstractTableViewCell *)cell hiddenSeparatorView];
          }
     }else{
          cell = [ImgsTableViewCell dequeueReusableCell:_tableView];
          
          
          if (comment.picList.count == 0) {
               cell.hidden = YES;
               [(JYAbstractTableViewCell *)cell hiddenSeparatorView];
          }else{
               [(ImgsTableViewCell *)cell setCellData:[comment getDic:1]];
               [(ImgsTableViewCell *)cell fitMode];
               [(JYAbstractTableViewCell *)cell showSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(cell.height, 0, 0, 0)];
          }
          __weak ServerInfoViewController *weakSelf = self;
          [(ImgsTableViewCell *)cell setHandleAction:^(NSDictionary *dic) {
               NSInteger row = [dic[@"row"] integerValue];
               NSMutableArray *imgArr = [NSMutableArray new];
               NSArray *arr = comment.picList;
               if (arr.count !=0) {
                    for (int i =0;i<arr.count;i++) {
                         UIImageView *myImageView = [[UIImageView alloc]init];
                         [imgArr addObject:myImageView];
                    }
                    [weakSelf setupPhotoBrowser:@{@"arr":arr?:@[],@"row":@(row),@"imgArr":imgArr}];
               }
          }];
     }
     
     return cell;
}


-(UITableViewCell *)creatFirstSectionCell:(NSIndexPath *)indexPath{
     UITableViewCell *cell ;
     if (indexPath.row == 0) {
          cell = _flashCell;
          
     }else if (indexPath.row == 1){
          cell =_priceCell;
     }else{
          cell = _commitmentCell;
          
     }
     [(JYAbstractTableViewCell *)cell showSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(cell.height, 0, 0, 0)];
     return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height = 35;

     if (indexPath.section == 0) {
          height = indexPath.row == 0 ?_flashCell.height: indexPath.row == 1? 50:_commitmentCell.height;
     }else if(_isEva){//用户评价
          if(indexPath.section <= _serviceInfo.commentList.count){
               BUGetComment *comment = _serviceInfo.commentList[indexPath.section - 1];
               if (indexPath.row == 0) {
                    ImgAndThreeTitleTableViewCell *cell = [ImgAndThreeTitleTableViewCell dequeueReusableCell:_tableView];
                    [(ImgAndThreeTitleTableViewCell *)cell setCellData:[comment getDic:0]];
                    [(ImgAndThreeTitleTableViewCell *)cell fitEvaMode];
                    height = cell.height;
               }else{
                    if (comment.picList.count == 0) {
                         height = 0.001;
                    }else{
                         ImgsTableViewCell *cell = [ImgsTableViewCell dequeueReusableCell:_tableView];
                         [(ImgsTableViewCell *)cell setCellData:[comment getDic:1]];
                         [(ImgsTableViewCell *)cell fitMode];
                         height = cell.height;
                    }
                    
               }
          }else if(indexPath.section == _serviceInfo.commentList.count+1){//显示全部评价
               if (_serviceInfo.commentList.count == 0) {
                    height = 250;
               }else
                    height = 40;
          }
          
     }else{
          if (indexPath.section == 1) {//商品介绍
               height = _intruduceCell.height;
          }
     }
    
    return height;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
     if (section == 0) {
          return 10;
     }
    return 0.01;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
     if (section == 1) {
          return 40;
     }
    return 0.01;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
     if (section == 1) {
          return _menuView;
     }
     return nil;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
     if (_isEva) {
          if (indexPath.section == _serviceInfo.commentList.count+1 && _serviceInfo.commentList.count != 0 ) {
               EvalutionListViewController *vc = [EvalutionListViewController new];
               vc.goodsId = _ID;
               [self.navigationController pushViewController:vc animated:YES];
          }
     }
}

/*
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if(scrollView != _tableView)
    {
        return;
    }
    if (scrollView.contentOffset.y >= 0 && scrollView.contentOffset.y <= 3) {
        self.navigationController.navigationBar.alpha = 1;
        alp = 0.1;
        CGSize navBarSize = CGSizeMake(__SCREEN_SIZE.width, __NAVBAR_HEIGHT + __STATUSBAR_HEIGHT);
        [self.navigationController.navigationBar  setBackgroundImage:[UIImage imageWithColor:kUIColorFromRGBWithAlpha(color_mainTheme,0.1) withBounds:CGRectMake(0, 0, navBarSize.width,navBarSize.height)] forBarPosition:UIBarPositionTopAttached barMetrics:UIBarMetricsDefault];
        
    }
    
    else
    {
        CGFloat d = 1 + scrollView.contentOffset.y/32.0;
        if (d > 1) {
            d = 1;
        }else if (d < 0)
        {
            d = 0;
        }
        self.navigationController.navigationBar.alpha = d;
        _backBtn.alpha = 1-d;
        if (scrollView.contentOffset.y > 5) {
            CGFloat c = scrollView.contentOffset.y/124.0 + 0.1;
            if (c > 1) {
                c = 1;
            }
            else if (c < 0)
            {
                c = 0.1;
            }
            alp = c;
            CGSize navBarSize = CGSizeMake(__SCREEN_SIZE.width, __NAVBAR_HEIGHT + __STATUSBAR_HEIGHT);
            [self.navigationController.navigationBar  setBackgroundImage:[UIImage imageWithColor:kUIColorFromRGBWithAlpha(color_mainTheme,c) withBounds:CGRectMake(0, 0, navBarSize.width,navBarSize.height)] forBarPosition:UIBarPositionTopAttached barMetrics:UIBarMetricsDefault];
        }
        
    }
}
-(void)viewDidLayoutSubviews
{
    //    self.navigationController.view.y = 0;
    _tableView.width = __SCREEN_SIZE.width;
    _tableView.height = __SCREEN_SIZE.height - 50;
    _tableView.y = 0;
    if (!self.hasInit) {
        if (!_tableView.isRefreshing) {
            [_tableView setContentInset:UIEdgeInsetsMake(0, 0, 0, 0)];
        }
        
        self.hasInit = YES;
    }
}
-(void)handleReturnBack:(id)sender
{
    [_tableView setContentOffset:CGPointMake(0, 0)];
    _tableView.scrollEnabled = NO;
    if (__IOS9) {
        _tableView.delegate = nil;
    }
    
    _tableView.scrollEnabled = NO;
    _tableView  = nil;
    _ID = nil;
    [_flashCell setNull];
    [super handleReturnBack:sender];

}
*/


#pragma mark - photo

- (void) setupPhotoBrowser:(NSDictionary *)dic{
     // 图片游览器
     ZLPhotoPickerBrowserViewController *pickerBrowser  = [[ZLPhotoPickerBrowserViewController alloc] init];
     // 数据源/delegate
     //    pickerBrowser.delegate = self;
     // 数据源可以不传，传photos数组 photos<里面是ZLPhotoPickerBrowserPhoto>
     pickerBrowser.photos = [self addZLPhotoPickerBrowserPhotoArr:dic[@"arr"] withImgVArr:dic[@"imgArr"]];
     // 是否可以删除照片
     //    pickerBrowser.editing = YES;
     // 当前选中的值
     pickerBrowser.currentIndexPath = [NSIndexPath indexPathForRow:[dic[@"row"] integerValue] inSection:0];
     // 展示控制器
     [pickerBrowser showPickerVc:self];
     //    [self.navigationController pushViewController:pickerBrowser animated:NO ];
}

- (NSMutableArray *)addZLPhotoPickerBrowserPhotoArr:(NSArray *)arr withImgVArr:(NSArray *)imgArr;
{
     NSMutableArray * mArr =[NSMutableArray new];
     for (int i=0; i<arr.count; i++)
     {
          ZLPhotoPickerBrowserPhoto *photo =[ZLPhotoPickerBrowserPhoto new];
          BUImageRes *im = arr[i];
          UIImage *d;
          UIImage *ii;
          if ([im isKindOfClass:[UIImage class]]) {
               d = (UIImage *)im;
               ii = (UIImage *)im;
               photo.thumbImage = d;
               photo.photoImage = ii;
          }
          else
          {
               if(im.isCached)
               {
                    d= [UIImage imageWithContentsOfFile:im.cacheThumbFile];
                    ii = [UIImage imageWithContentsOfFile:im.cacheFile];
                    photo.thumbImage = d;
                    photo.photoImage = ii;
               }
               else
               {
                    photo.thumbImage = [UIImage imageContentWithFileName:@"default"];
                    photo.photoImage = [UIImage imageContentWithFileName:@"default"];
               }
          }
          photo.aspectRatioImage = ii;
          photo.toView = imgArr[i];
          [mArr addObject:photo];
     }
     return mArr;
}


@end
