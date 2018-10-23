//
//  CouponInfoViewController.m
//  oranllcshoping
//
//  Created by air on 2017/8/1.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import "CouponInfoViewController.h"
#import "OnlyTitleTableViewCell.h"
#import "CouponRuleViewController.h"
#import "OnlyBottomBtnTableViewCell.h"
//#import "ClassifyGoodsViewController.h"
@interface CouponInfoViewController ()
{
     OnlyTitleTableViewCell *_titleCell;
     OnlyTitleTableViewCell *_priceCell;
     OnlyTitleTableViewCell *_priceTipCell;
     OnlyTitleTableViewCell *_tipCell;
     OnlyBottomBtnTableViewCell *_btnCell;
}
@property (strong, nonatomic) IBOutlet MyTableView *tableView;
@property (strong, nonatomic) IBOutlet UIImageView *bgImgV;

@end

@implementation CouponInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = kUIColorFromRGB(color_3);
    [self initTableView];
    [self initBgImgV];
    [self setNavigateRightButton:@"nav_que"];
}


-(void)handleDidRightButton:(id)sender
{
     CouponRuleViewController *vc = [CouponRuleViewController new];
     [self.navigationController pushViewController:vc animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initBgImgV
{
    _bgImgV.x = 15;
    _bgImgV.y = 0;
    _bgImgV.width = __SCREEN_SIZE.width - 30;
    _bgImgV.height = 475;
    
    _bgImgV.image = [UIImage imageContentWithFileName:@"couponInfo"];
     [self.tableView insertSubview:_bgImgV atIndex:0];
}

-(void)initTableView
{
     
     __weak CouponInfoViewController *weakSelf = self;
     _titleCell = [OnlyTitleTableViewCell createTableViewCell];
     [_titleCell setCellData:@{@"title":@"全品类通用券"}];
     [_titleCell fitCouponInfoModeA];
     
   _priceCell  = [OnlyTitleTableViewCell createTableViewCell];
     [_priceCell setCellData:@{@"title":@"满1000元可用"}];
      [_priceCell fitCouponInfoModeB];
     
    _priceTipCell = [OnlyTitleTableViewCell createTableViewCell];
      [_priceTipCell setCellData:@{@"title":@"满1000元可用"}];
      [_priceTipCell fitCouponInfoModeC];
     
   _tipCell  = [OnlyTitleTableViewCell createTableViewCell];
      [_tipCell setCellData:@{@"title":@"• 适用平台：全平台 \n• 有效期至：2017-08-01 \n• 详细说明：全场通用，不限条件，特殊商品除外。"}];
      [_tipCell fitCouponInfoModeD];
     
     _btnCell = [OnlyBottomBtnTableViewCell createTableViewCell];
      [_btnCell setCellData:@{@"title":@"立即使用"}];
     [_btnCell fitCouponInfoMode];
     [_btnCell setHandleAction:^(id o){
//          ClassifyGoodsViewController *vc = [ClassifyGoodsViewController new];
//          [weakSelf.navigationController pushViewController:vc animated:YES];
     }];
     _tableView.refreshHeaderView = nil;
     _tableView.backgroundColor = [UIColor clearColor];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return  0;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section;
{
    
    return  nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 0.001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 44;
     if (indexPath.row == 0) {
          height = 41;
     }
     else if (indexPath.row == 1)
     {
             height = 40;
     }
     else if (indexPath.row == 2)
     {
             height = 59;
     }
     else if (indexPath.row == 3)
     {
             height = 66;
     }
     else
     {
             height = 248;
     }
    return height;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger row = 1;
    switch (section) {
        case 0:
            row = 5;
            break;
        case 1:
            row = 7;
            break;
        default:
            break;
    }
    return row;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
     if (indexPath.row == 0) {
          cell = _titleCell;
     }
     else if (indexPath.row == 1)
     {
      cell = _priceCell;
     }
     else if (indexPath.row == 2)
     {
      cell = _priceTipCell;
     }
     else if (indexPath.row == 3)
     {
           cell = _tipCell;
     }
     else
     {
      cell = _btnCell;
     }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
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
