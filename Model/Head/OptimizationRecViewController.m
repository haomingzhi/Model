//
//  OptimizationRecViewController.m
//  oranllcshoping
//
//  Created by air on 2017/8/2.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import "OptimizationRecViewController.h"
#import "ImgTableViewCell.h"
#import "ImgAndThreeTitleTableViewCell.h"
#import "ScrollerTableViewCell.h"
#import "CartViewController.h"
#import "JYShareManager.h"
#import "GoodsInfoViewController.h"
#import "SecKillTableViewCell.h"
#import "BUSystem.h"
#import "LoginViewController.h"


@interface OptimizationRecViewController ()
{
     NSInteger _requestCount;
  
}
@end

@implementation OptimizationRecViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
     self.title = _optimization.title;//@"优选标题";
//     [self setRightNavBtn];
       [self initTableView];
     
     HUDSHOW(@"加载中");
     [self upCount];
     
     if (_optimization == nil) {
         [self getData];
     }
     
}
-(void)getData
{
       _requestCount++;
     [busiSystem.headManager getOptimiInfo:_ID observer:self callback:@selector(getListNotificaiton:)];

}

-(void)getListNotificaiton:(BSNotification*)noti
{
     _requestCount--;
     if (_requestCount == 0) {
          HUDDISMISS;
     }
     if (noti.error.code == 0) {
     //          _tableView.dataArr = [NSMutableArray arrayWithArray:busiSystem.productManager.actionYXProductPageListManager.dataArr];
     //          _tableView.hasMore = busiSystem.productManager.actionYXProductPageListManager.pageInfo.hasMore;
          _optimization = busiSystem.headManager.optimization;
          self.title = _optimization.title;
          [(ImgTableViewCell *)_imgCell setCellData:@{@"img":_optimization.img?:@"",@"default":@"default"}];
          [(ImgTableViewCell *)_imgCell fitOddsRecMode];
          [_tableView reloadData];
//          [[JYNoDataManager manager] addNodataView:_tableView withTip:@"暂无信息" withImg:@"nodata" withCount:_tableView.dataArr.count withTag:[NSString stringWithFormat:@"favc%d",0]];
//          [[JYNoDataManager manager] fitModeY:130 withImgVWidth:130 withViewY:140/360.0 *__SCREEN_SIZE.width];
     }
     else
     {

          HUDCRY(noti.error.domain, 1);
     }
}

-(void)upCount
{
     _requestCount++;
     NSString *ID = _optimization.optimizationId?:_ID;
     [busiSystem.agent upCount:@"3" withDataId:ID observer:self callback:@selector(upCountNotification:)];
}

-(void)upCountNotification:(BSNotification*)noti
{
     _requestCount--;
     if (_requestCount == 0) {
          HUDDISMISS;
     }
//     if (noti.error.code == 0) {
//
//     }
//     else
//     {
//
//          HUDCRY(noti.error.domain, 1);
//     }
}

-(void)setRightNavBtn
{
     //    [self setNavigateRightButton:btnStr font:[UIFont systemFontOfSize:15] color:[UIColor whiteColor]];
     //    [self setNavigateRightButton:@"nav_msg"];
     
     UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 60, 30)];
     
     UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
     btn1.frame = CGRectMake(0, 3, 22, 22);
     btn1.tag = 200;
     btn1.titleLabel.font = [UIFont systemFontOfSize:14];
     [btn1 setTitleColor:kUIColorFromRGB(color_3) forState:UIControlStateNormal];
     btn1.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
     [btn1 setImage:[UIImage imageContentWithFileName:@"icon_share_nav"] forState:UIControlStateNormal];
     
     [btn1 addTarget:self action:@selector(handleShare:) forControlEvents:UIControlEventTouchUpInside];
     
     UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
     btn2.frame = CGRectMake(37, 3, 22, 22);
     btn2.tag = 300;
     btn2.titleLabel.font = [UIFont systemFontOfSize:14];
     [btn2 setTitleColor:kUIColorFromRGB(color_3) forState:UIControlStateNormal];
     btn2.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
     [btn2 setImage:[UIImage imageContentWithFileName:@"nav_buyCar"] forState:UIControlStateNormal];
     
     [ v addSubview:btn1];
     [v addSubview:btn2];
          [btn2 addTarget:self action:@selector(handleBuyCar:) forControlEvents:UIControlEventTouchUpInside];
     
     [self setNavigateRightView:v];
}
-(void)handleBuyCar:(UIButton *)btn
{
     CartViewController *vc = [CartViewController new];
     vc.hidesBottomBarWhenPushed  = YES;
     [self.navigationController pushViewController:vc animated:YES];
}

-(void)handleShare:(UIButton *)btn
{
     NSString *imagePath;
     
     NSString *url = @"";
     [[JYShareManager manager] showSheetView:self withShareTitle:@"" withShareContent:@"" withShareImgUrl:imagePath withUrl:url];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)initTableView
{
     _tableView.refreshHeaderView = nil;
     _imgCell = [ImgTableViewCell createTableViewCell];
     [(ImgTableViewCell *)_imgCell setCellData:@{@"img":_optimization.img?:@"",@"default":@"defaultBanner"}];
     [(ImgTableViewCell *)_imgCell fitOddsRecMode];
     [ImgAndThreeTitleTableViewCell registerTableViewCell:_tableView];
     _tableView.backgroundColor = kUIColorFromRGB(color_f8f8f8);
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return  _optimization.proList.count +1;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section;
{
    
    return  nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
     if (section == 0) {
          return 15;
     }
    return 0.001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 15;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 44;
     if (indexPath.section == 0) {
          height = 135/330.0 *(__SCREEN_SIZE.width-30);
     }
     else
     {
           height = 135;
//          height = __SCREEN_SIZE.height - 64 -  140/360.0 *__SCREEN_SIZE.width;
     }
    return height;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger row = 1;
    return row;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
     
    UITableViewCell *cell;
     if (indexPath.section == 0) {
          cell = _imgCell;
     }
     else
     {
          cell = [ImgAndThreeTitleTableViewCell dequeueReusableCell:tableView];
          BUHeadGoods *g = _optimization.proList[indexPath.section-1];
          NSDictionary *dic = [g getDic];
          //@{@"title":@"iPhone X 全新国行",@"source":[NSString stringWithFormat:@"%.2f",200.0],@"time":[NSString stringWithFormat:@"元/%@",@"月"],@"default":@"default",@"img":@"orderEx",@"isPost":@(YES),@"isSecondHand":@(YES)};
          [(JYAbstractTableViewCell *)cell setCellData:dic];
          [(ImgAndThreeTitleTableViewCell *)cell fitOptimizationMode];
          
//          [(JYAbstractTableViewCell*)cell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(135, 15, 0, 15)];
     }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  if(indexPath.section != 0)
  {
        BUHeadGoods *g = _optimization.proList[indexPath.section-1];
       GoodsInfoViewController *vc = [GoodsInfoViewController new];
       vc.ID = g.productId;
       [self.navigationController pushViewController:vc animated:YES];
  }
}

-(void)addShoppingCart:(NSString *)productId{
     if (!busiSystem.agent.isLogin) {
          [LoginViewController toLogin:self];
          return;
     }
     HUDSHOW(@"提交中");
     [busiSystem.orderManager addShoppingCart:productId storeId:busiSystem.agent.storeId withProCount:1 userId:busiSystem.agent.userId?:@"" observer:self callback:@selector(addShoppingCartNotification:)];
}

-(void)addShoppingCartNotification:(BSNotification *)noti{

     if (noti.error.code == 0) {
          HUDSMILE(@"添加成功", 1);
     }else{
          HUDCRY(noti.error.domain, 2);
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
