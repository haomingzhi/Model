//
//  PublishAnswerViewController.m
//  oranllcshoping
//
//  Created by air on 2017/8/8.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import "PublishAnswerViewController.h"
#import "TitleAndImageTableViewCell.h"
#import "TextViewCanChangeTableViewCell.h"
#import "OnlyTitleTableViewCell.h"
#import "OnlyBottomBtnTableViewCell.h"
#import "AddImgTableViewCell.h"
@interface PublishAnswerViewController ()
{
     TitleAndImageTableViewCell *_isShowNameCell;
 
     TextViewCanChangeTableViewCell *_textViewCell;
     OnlyTitleTableViewCell *_tipCell;
     OnlyBottomBtnTableViewCell *_submitCell;
     
}

@property (strong, nonatomic) IBOutlet MyTableView *tableView;
@property(nonatomic,strong)  AddImgTableViewCell *imgsCell;
@property(nonatomic,strong)  NSMutableArray *imgArr;
@end

@implementation PublishAnswerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
     _imgArr = [NSMutableArray new];
     self.title = @"发布答案";
     [self initTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)initTableView
{
     _tableView.refreshHeaderView = nil;
     __weak PublishAnswerViewController *weakSelf = self;
    
     
     _isShowNameCell = [TitleAndImageTableViewCell createTableViewCell];
     [_isShowNameCell setCellData:@{@"title":@"孤独美食家的深夜食堂",@"img":@"eva_close",@"himg":@"eva_open",@"detail":@"匿名回答"}];
     [_isShowNameCell fitPublishAnswerMode];
     __weak TitleAndImageTableViewCell *ws = _isShowNameCell;
     [_isShowNameCell setHandleAction:^(UIButton *btn){
          if (!btn.isSelected) {
               [ws setCellData:@{@"title":@"孤独美食家的深夜食堂",@"img":@"eva_open",@"detail":@"匿名回答"}];
               btn.selected = YES;
          }else
          {
               [ws setCellData:@{@"title":@"孤独美食家的深夜食堂",@"img":@"eva_close",@"detail":@"匿名回答"}];
               btn.selected = NO;
          }
     }];
     
     _textViewCell = [TextViewCanChangeTableViewCell createTableViewCell];
     [_textViewCell setCellData:@{@"placeholder":@"请输入答案内容"}];
     [_textViewCell fitPublishAnswerMode];
     
     
     
     _tipCell = [OnlyTitleTableViewCell createTableViewCell];
     [_tipCell setCellData:@{@"title":@"上传图片(最多6张)"}];
     [_tipCell fitPublishAnswerMode];
     
     _imgsCell = [AddImgTableViewCell createTableViewCell];
     [_imgsCell setCellData:@{@"arr":@[],@"limitCount":@9,@"default":@"",@"colCount":@3,@"hiddenDelBtn":@NO}];
     [_imgsCell fitPublishAnswerMode];
     [_imgsCell initAddPhotoManager:9 withImgArr:self.imgArr withVC:self withTableView:self.tableView];
     [_imgsCell.addPhotoManager setCheckDoneCallBack:^(NSDictionary *dic){
          NSMutableArray *arr = dic[@"arr"];
          //        if(weakSelf.imgArr.count > 3)
          //        {
          //            [weakSelf.imgArr removeObjectsInRange:NSMakeRange(3, weakSelf.imgArr.count - 3)];
          //        }
          //        [weakSelf.imgsCell setCellData:@{@"limitCount":@3,@"arr":weakSelf.imgArr,@"colCount":@3}];
          //          [self uploadImg:@"0" withImgArr:arr];
          [weakSelf.imgsCell fitPublishAnswerMode];
          [weakSelf.tableView reloadData];
     }];
     [_imgsCell setHandleAction:^(NSDictionary *ddic) {
          if([ddic[@"method"] integerValue] == 1)
          {
               [weakSelf.imgsCell  toCheckOption:@{@"count":@(6 - weakSelf.imgArr.count)}];
          }
          else if([ddic[@"method"] integerValue] == 2)
          {
               [weakSelf.imgsCell setupPhotoBrowser:@{@"arr":weakSelf.imgArr,@"row":ddic[@"row"],@"imgArr":ddic[@"imgvs"]}];
          }
          else
          {
               [weakSelf.imgsCell delImg:[ddic[@"row"] integerValue]];
               [weakSelf.imgsCell fitPublishAnswerMode];
               [weakSelf.tableView reloadData];
          }
     }];
     
     _submitCell = [OnlyBottomBtnTableViewCell createTableViewCell];
     [_submitCell setCellData:@{@"title":@"发布答案"}];
     [_submitCell fitPublishAnswerMode];
     
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
     return  1;
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
          height = 121;
     }
     else if (indexPath.row == 2)
     {
          height = 37;
     }
     else if (indexPath.row == 3)
     {
          height = _imgsCell.height;
     }
     else if (indexPath.row == 4)
     {
          height = 85;
     }
     
     return height;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
     NSInteger row = 5;
     
     return row;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
     UITableViewCell *cell;
     if (indexPath.row == 0) {
         cell = _isShowNameCell;
     }
     else if (indexPath.row == 1)
     {
          cell = _textViewCell;
     }

     else if (indexPath.row == 2)
     {
          cell = _tipCell;
     }
     else if (indexPath.row == 3)
     {
          cell = _imgsCell;
     }
     else
     {
          cell = _submitCell;
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
