//
//  MyHistoryViewController.m
//  oranllcshoping
//
//  Created by air on 2017/7/26.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import "MyHistoryViewController.h"
#import "ImgAndThreeTitleTableViewCell.h"
#import "OnlyBottomBtnTableViewCell.h"
#import "MenuOneBtnView.h"
#import "GoodsInfoViewController.h"
#import "SimilarityGoodsViewController.h"
@interface MyHistoryViewController ()
{
     BOOL _isEdit;
     OnlyBottomBtnTableViewCell *_bottomView;
     NSMutableDictionary *_selectSectionDic;
     NSMutableArray *_sectionArr;
}
@property (strong, nonatomic) IBOutlet MyTableView *tableView;
 @property (strong, nonatomic) NSMutableArray *selectArr;
@end

@implementation MyHistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"我的足迹";
     _selectArr = [NSMutableArray new];
     _selectSectionDic = [NSMutableDictionary new];
     _sectionArr = [NSMutableArray new];
    [self initTableView];
     [self setNavigateRightButton:@"编辑" font:[UIFont systemFontOfSize:15] color:kUIColorFromRGB(color_2)];
}

-(void)addBottomView
{
     __weak MyHistoryViewController *weakSelf = self;
     _bottomView = [OnlyBottomBtnTableViewCell createTableViewCell];
     _bottomView.height = 45;
     _bottomView.width = __SCREEN_SIZE.width;
     [_bottomView setCellData:@{@"title":@"删除"}];
     [_bottomView fitMyHisMode];
     _bottomView.y = __SCREEN_SIZE.height - 64 - 45;
     [self.view addSubview:_bottomView];
     __weak OnlyBottomBtnTableViewCell *wb = _bottomView;
     [_bottomView setExtrHandleAction2:^(id o){
          UIButton *btn = [wb viewWithTag:8726];
          if (btn.customImgV.isHighlighted) {
               btn.customImgV.highlighted = NO;
               [weakSelf.selectArr removeAllObjects];
               [weakSelf.tableView reloadData];
                [weakSelf setAllSectionV:NO];
          }
          else
          {
          btn.customImgV.highlighted = YES;
                [weakSelf.selectArr removeAllObjects];
               [weakSelf selectAllData];
                [weakSelf.tableView reloadData];
               [weakSelf setAllSectionV:YES];
               
          }
     }];
}

-(void)setAllSectionV:(BOOL)isCheck
{
     for (NSInteger i = 0;i < _sectionArr.count; i ++) {
         MenuOneBtnView * o = _sectionArr[i];
          o.btn.customImgV.highlighted = isCheck;
     }
}

-(void)selectAllData
{
     [_selectArr addObjectsFromArray:@[@0,@1,@2,@3,@4,@5]];
}

-(void)handleDidRightButton:(UIButton *)btn

{
     if ([btn.titleLabel.text isEqualToString:@"编辑"]) {
            [self setNavigateRightButton:@"完成" font:[UIFont systemFontOfSize:15] color:kUIColorFromRGB(color_2)];
          _isEdit = YES;
          [_tableView reloadData];
          [self addBottomView ];
     }
     else
     {
         [self setNavigateRightButton:@"编辑" font:[UIFont systemFontOfSize:15] color:kUIColorFromRGB(color_2)];
          _isEdit = NO;
           [_tableView reloadData];
          [_bottomView removeFromSuperview];
     }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)initTableView
{
     _tableView.refreshHeaderView = nil;
     [ImgAndThreeTitleTableViewCell registerTableViewCell:_tableView];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
     [self createHeadSection:1];
    return  1;
}

-(void)createHeadSection:(NSInteger )count
{
     for (NSInteger i = 0; i < count; i++) {
            MenuOneBtnView *o = [[MenuOneBtnView alloc] initWithFrame:CGRectMake(0, 0, __SCREEN_SIZE.width, 36)];
          o.btn.width = 90;
          o.btn.height = 36;
          o.btn.customImgV.image = [UIImage imageContentWithFileName:@"unCheck2"];
          o.btn.customImgV.highlightedImage = [UIImage imageContentWithFileName:@"check"];
          o.btn.customImgV.height = 16;
           o.btn.customImgV.width = 16;
          o.btn.customImgV.x = 15;
          o.btn.customImgV.y = 10;
          o.btn.x = 0;
          o.btn.y = 0;
          o.btn.customTitleLb.width = 32;
          o.btn.customTitleLb.height = 15;
          o.btn.customTitleLb.font = [UIFont systemFontOfSize:15];
          o.btn.customTitleLb.textColor = kUIColorFromRGB(color_1);
          o.btn.customTitleLb.x = 47;
          o.btn.customTitleLb.y = 11;
          
          o.btn.tag = 900 + i;
          [o.btn addTarget:self action:@selector(handleSection:) forControlEvents:UIControlEventTouchUpInside];
          [_sectionArr addObject:o];
          if(_selectSectionDic[@(i)])
          {
               
          }
          else
          {
               NSMutableArray *s = [NSMutableArray new];
               [s addObjectsFromArray:@[@0,@1,@2,@3,@4,@5]];
               _selectSectionDic[@(i)] = s;
          }
     }
  
     
}

-(void)handleSection:(UIButton *)btn
{
     NSInteger tag = btn.tag - 900;
     
     
     if (btn.customImgV.isHighlighted) {
          btn.customImgV.highlighted = NO;
        NSMutableArray *sel = _selectSectionDic[@(tag)];
          [_selectArr removeObjectsInArray:sel];
           [self isCheckAll];
          [_tableView reloadData];
     }
     else
     {
        btn.customImgV.highlighted = YES;
          NSMutableArray *sel = _selectSectionDic[@(tag)];
          [_selectArr addObjectsFromArray:sel];
           [self isCheckAll];
            [_tableView reloadData];
     }
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section;
{
   MenuOneBtnView *o =  _sectionArr[section];
        o.btn.customTitleLb.text = @"今天";
     [o fitMode:_isEdit];
     return o;
}



-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 36;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
     if(section == 0)
          return 50;
    return 10;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 112;
    return height;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger row = 1;
    switch (section) {
        case 0:
            row = 6;
            break;
        case 1:
            row = 7;
            break;
        default:
            break;
    }
    return row;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     if (_isEdit) {
       
        if([_selectArr containsObject:@(indexPath.row)])
        {
             [_selectArr removeObject:@(indexPath.row)];
        }
          else
          {
            [_selectArr addObject:@(indexPath.row)];
              
              
          }
          [self isCheckAll];
           [self isCheckSection:indexPath.section];
          [_tableView reloadData];
     }
     else
     {
          GoodsInfoViewController *vc = [GoodsInfoViewController new];
          [self.navigationController pushViewController:vc animated:YES];
     }
}

-(void)isCheckSection:(NSInteger)section
{
   MenuOneBtnView *o =  _sectionArr[section];
     NSMutableArray *sel = _selectSectionDic[@(section)];
     if (sel.count == _selectArr.count) {
          o.btn.customImgV.highlighted = YES;
     }
     else
     {
     o.btn.customImgV.highlighted = NO;
     }
}

-(void)isCheckAll
{
       UIButton *btn = [_bottomView viewWithTag:8726];
     if (_selectArr.count == 6) {

          btn.customImgV.highlighted = YES;
     }
     else  {
        
          
          btn.customImgV.highlighted = NO;
     }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
     BOOL isCheck = NO;
     if([_selectArr containsObject:@(indexPath.row)])
     {
          isCheck = YES;
     }
     else
     {
          isCheck = NO;
     }
       cell = [ImgAndThreeTitleTableViewCell dequeueReusableCell:_tableView];
     NSDictionary *dic = @{@"title":@"日式色织水洗棉床笠",@"source":[NSString stringWithFormat:@"肤色/M"],@"time":[NSString stringWithFormat:@"¥99"],@"default":@"default",@"img":@"orderEx",@"isCheck":@(isCheck)};//[o getDicB];
     [(JYAbstractTableViewCell *)cell setCellData:dic];
     BOOL isEidt = _isEdit;
     [(ImgAndThreeTitleTableViewCell *)cell fitMyHisMode:isEidt];
      [(ImgAndThreeTitleTableViewCell *)cell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(112, 0, 0, 0)];
     [(ImgAndThreeTitleTableViewCell *)cell setHandleAction:^(id o){
          SimilarityGoodsViewController *vc = [SimilarityGoodsViewController new];
          [self.navigationController pushViewController:vc animated:YES];
     }];
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
