//
//  SimilarityGoodsViewController.m
//  oranllcshoping
//
//  Created by air on 2017/8/3.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import "SimilarityGoodsViewController.h"
#import "ImgAndThreeTitleTableViewCell.h"
#import "SecKillTableViewCell.h"
#import "OnlyTitleTableViewCell.h"
#import "GoodsInfoViewController.h"
@interface SimilarityGoodsViewController ()
{
     OnlyTitleTableViewCell *_tipCell;
     ImgAndThreeTitleTableViewCell *_sCell;
}
@property (strong, nonatomic) IBOutlet MyTableView *tableView;

@end

@implementation SimilarityGoodsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
     self.title = @"相似商品";
     [self initTableView];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)initTableView
{
     self.tableView.refreshHeaderView = nil;
     [SecKillTableViewCell registerTableViewCell:_tableView];
     _sCell = [ImgAndThreeTitleTableViewCell createTableViewCell];
     [_sCell setCellData:@{@"title":@"银色银色进行奖学金",@"source":@"肤色/M",@"time":@"已好评，供货50优币",@"img":@"dog"}];
     [_sCell fitSimilarityGoodsMode];
     _tipCell  = [OnlyTitleTableViewCell createTableViewCell];
     [_tipCell setCellData:@{@"title":@"相似商品 为你推选"}];
     [_tipCell fitSimilarityGoodsMode];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
     return  2;
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
     if (section == 0) {
          return 10;
     }
     return 0.01;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
     if (section == 0) {
          return [self createSectionFootView];
     }
     return nil;
}
-(UIView *)createSectionFootView
{
     UIView *v = [UIView new];
     v.height = 10;
     UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 9.5, __SCREEN_SIZE.width, 0.5)];
     line.backgroundColor = kUIColorFromRGB(color_lineColor);
     v.backgroundColor = kUIColorFromRGB(color_0xf0f0f0);
     line.tag = 9887;
     [v addSubview:line];
     return v;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
     CGFloat height = 44;
     if (indexPath.section == 0) {
          height = 101;
     }
     else
     {
          if (indexPath.row == 0) {
               height = 39;
          }
          else
          {
               height = 176;
          }
     }
     return height;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
     NSInteger row = 1;
     switch (section) {
          case 0:
               row = 1;
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
     if (indexPath.section == 0) {
          cell = _sCell;
       [_sCell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(101, 0, 0, 0)];
     }
     else
     {
          if (indexPath.row == 0) {
               cell = _tipCell;
               
          }
          else  {
               cell =  [SecKillTableViewCell dequeueReusableCell:_tableView];
               [(SecKillTableViewCell *)cell setCellData:@{@"aContent":@"秒杀价 ¥99",@"aTitle":@"银色星芒刺绣网纱底裤",@"aDetail":@"薄如蝉翼，丝滑如肌肤",@"aimg":@"secKillA",@"bContent":@"秒杀价 ¥99",@"bTitle":@"银色星芒刺绣网纱底裤",@"bDetail":@"薄如蝉翼，丝滑如肌肤",@"bimg":@"secKillB"}];
               [(SecKillTableViewCell *)cell fitYouLikeMode];
               if(indexPath.row == 6)
               {
                    [(SecKillTableViewCell *)cell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(176, 0, 0, 0)];
               }
               else
               {
                    [(SecKillTableViewCell *)cell hiddenCustomSeparatorView];
               }
                [(SecKillTableViewCell *)cell setHandleAction:^(NSDictionary *dic){
                     GoodsInfoViewController *vc = [GoodsInfoViewController new];
                     [self.navigationController pushViewController:vc animated:YES];
                }];
          }

     }
     cell.selectionStyle = UITableViewCellSelectionStyleNone;
     return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     if (indexPath.section == 0) {
          GoodsInfoViewController *vc = [GoodsInfoViewController new];
          [self.navigationController pushViewController:vc animated:YES];
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
