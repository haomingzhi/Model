//
//  CancelOrderViewController.m
//  oranllcshoping
//
//  Created by air on 2017/8/16.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import "CancelOrderViewController.h"
#import "OnlyTitleTableViewCell.h"
#import "OnlyBottomBtnTableViewCell.h"
@interface CancelOrderViewController ()
{
     OnlyTitleTableViewCell *_titleCell;
     OnlyTitleTableViewCell *_tipCell;
     OnlyTitleTableViewCell *_checkTipCell;
     OnlyBottomBtnTableViewCell *_checkACell;
     OnlyBottomBtnTableViewCell *_checkBCell;
     OnlyBottomBtnTableViewCell *_checkCCell;
     OnlyBottomBtnTableViewCell *_submitCell;
}

@property (strong, nonatomic) IBOutlet MyTableView *tableView;

@end

@implementation CancelOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
     [self initTableView];
     [self fitMode];
}

-(void)fitMode
{

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)initTableView{
     
     _tableView.bounces = NO;
     __weak CancelOrderViewController *weakSelf = self;
     _titleCell = [OnlyTitleTableViewCell createTableViewCell];
     [_titleCell setCellData:@{@"title":@"取消订单"}];
     [_titleCell fitCancelOrderModeA];
     [_titleCell setHandleAction:^(id o){
          [weakSelf.parentDialog cancel];
     }];
     
     _tipCell = [OnlyTitleTableViewCell createTableViewCell];
     [_tipCell setCellData:@{@"title":@"取消订单后，本单享有的优惠可能会一并取消，是 否继续？"}];
      [_tipCell fitCancelOrderModeB];
     
     _checkTipCell = [OnlyTitleTableViewCell createTableViewCell];
     [_checkTipCell setCellData:@{@"title":@"请选择取消订单的原因（必选)"}];
      [_checkTipCell fitCancelOrderModeC];
     
     _checkACell = [OnlyBottomBtnTableViewCell createTableViewCell];
       [_checkACell setCellData:@{@"title":@"配送信息有误"}];
      [_checkACell fitCancelOrderInfoA:NO];
     [_checkACell setHandleAction:^(NSDictionary *dic){
          UIButton *btn = dic[@"obj"];
          btn.customImgV.highlighted =  !btn.customImgV.highlighted;
     }];
     _checkBCell = [OnlyBottomBtnTableViewCell createTableViewCell];
       [_checkBCell setCellData:@{@"title":@"发票信息有误"}];
      [_checkBCell fitCancelOrderInfoA:NO];
     [_checkBCell setHandleAction:^(NSDictionary *dic){
          UIButton *btn = dic[@"obj"];
          btn.customImgV.highlighted =  !btn.customImgV.highlighted;
     }];
      _checkCCell = [OnlyBottomBtnTableViewCell createTableViewCell];
       [_checkCCell setCellData:@{@"title":@"发票信息有误"}];
     [_checkCCell fitCancelOrderInfoA:NO];
     [_checkCCell setHandleAction:^(NSDictionary *dic){
          UIButton *btn = dic[@"obj"];
          btn.customImgV.highlighted =  !btn.customImgV.highlighted;
     }];
     
      _submitCell = [OnlyBottomBtnTableViewCell createTableViewCell];
       [_submitCell setCellData:@{@"title":@"确定"}];
     [_submitCell fitCancelOrderInfoB];
}

-(void)viewDidLayoutSubviews
{
     self.view.height = 28 * 3 + 41 + 44 + 48 + 28 + 10;
     _tableView.height = 28 * 3 + 41 + 44 + 48 + 30 + 10;
}

#pragma mark - tableView delegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
     return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
     return 7;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
     UITableViewCell *cell;
     if (indexPath.row == 0) {
          cell = _titleCell;
          [_titleCell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(41, 0, 0, 0)];
     }
     else  if (indexPath.row == 1) {
          cell = _tipCell;
     }
     else  if (indexPath.row == 2) {
          cell = _checkTipCell;
     }
     
     else  if (indexPath.row == 3) {
         cell = _checkACell;
     }
     
     else  if (indexPath.row == 4) {
          cell = _checkBCell;
     }
     
     else  if (indexPath.row == 5) {
          cell = _checkCCell;
     }
     
     else   {
          cell = _submitCell;
     }

     cell.selectionStyle = UITableViewCellSelectionStyleNone;
     return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
     CGFloat height = 40;
     if (indexPath.row == 0) {
          height = 41;
     }
     else  if (indexPath.row == 1) {
          height = 48;
     }
     else  if (indexPath.row == 2) {
          height = 28;
     }

     else  if (indexPath.row == 3) {
          height = 28;
     }

     else  if (indexPath.row == 4) {
          height = 28;
     }

     else  if (indexPath.row == 5) {
          height = 38;
     }

     else   {
          height = 44;
     }

     return height;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
     UIView *v = [[UIView alloc] init];
     v.backgroundColor = kUIColorFromRGB(color_0xf0f0f0);
     if (section == 1) {
          return nil;
     }
     return v;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
     if (section == 1) {
          return 0.001;
     }
     return 0.001;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
     return 0.01;
}

//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//     if (_callback) {
//          _callback(@{@"row":@(indexPath.row),@"isCancel":@(indexPath.section == 1)});
//     }
//     else
//     {
//          [self.parentDialog cancel];
//     }
//}

static CancelOrderViewController *cvc;
+(CancelOrderViewController *)toVC:(NSArray*)dataArr
{
     static dispatch_once_t onceToken;
     dispatch_once(&onceToken, ^{
          cvc = [[CancelOrderViewController alloc] init];
          
     });
     
     //   DealPasswordViewController *dealvc = [DealPasswordViewController new];
     MyDialog *myDialog = [[MyDialog alloc] initWithViewController:cvc];
     cvc.view.width = __SCREEN_SIZE.width;
     //    vc.doneCallBack = ^(NSString *pwd){
     //        [weakSelf toAddwithdraw:pwd];
     //    };
//     cvc.dataArr = dataArr;
     
     myDialog.mydelegate = cvc;
     CGFloat h =  28 * 3 + 41 + 44 + 48 + 28 + 10;
     //    myDialog.bgColor = [UIColor clearColor];
     myDialog.isDownAnimate = YES;
     [myDialog showAtPosition:CGPointMake(0, __SCREEN_SIZE.height - h) animated:YES];
     myDialog.dismissOnTouchOutside = NO;
     [cvc.tableView reloadData];
     
     return cvc;
     
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
