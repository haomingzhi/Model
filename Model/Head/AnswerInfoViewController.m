//
//  AnswerInfoViewController.m
//  oranllcshoping
//
//  Created by air on 2017/8/8.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import "AnswerInfoViewController.h"
#import "ImgAndThreeTitleTableViewCell.h"
#import "ThreeTitleAndImgTableViewCell.h"
#import "ImgsTableViewCell.h"
@interface AnswerInfoViewController ()
{
  ImgAndThreeTitleTableViewCell *_infoCell;
     
     UITextField *_textField;
     UIView *bottomView;
}
@property (strong, nonatomic) IBOutlet MyTableView *tableView;
@property(nonatomic,strong)  NSMutableArray *imgArr;
@property(nonatomic,strong) ImgsTableViewCell *imgsCell;
@end

@implementation AnswerInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
     self.title = @"回答详情";
         _imgArr = [NSMutableArray new];
     [self initTableView];
     [self addBtn];
     [self initNotificationCenter];
}

-(void)initNotificationCenter{
     //监听键盘出现和消失
     [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
     [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

#pragma mark 键盘出现
-(void)keyboardWillShow:(NSNotification *)note
{
     CGRect keyBoardRect=[note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
     //    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, keyBoardRect.size.height, 0);
     bottomView.y = __SCREEN_SIZE.height - 64-44 - keyBoardRect.size.height;
}
#pragma mark 键盘消失
-(void)keyboardWillHide:(NSNotification *)note
{
     bottomView.y = __SCREEN_SIZE.height - 64-44;
}

-(void)addBtn{
     bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, __SCREEN_SIZE.height - 64-44, __SCREEN_SIZE.width, 44)];
     bottomView.backgroundColor = kUIColorFromRGB(color_2);
     bottomView.layer.borderColor = kUIColorFromRGB(color_lineColor).CGColor;
     bottomView.layer.borderWidth = 0.5;
     [self.view addSubview:bottomView];
     
     _textField = [[UITextField alloc]initWithFrame:CGRectMake(15, 7, __SCREEN_SIZE.width - 60-15, 30)];
     _textField.layer.borderWidth = 0.5;
     _textField.layer.borderColor = kUIColorFromRGB(color_lineColor).CGColor;
     _textField.layer.cornerRadius = 6.0;
     _textField.layer.masksToBounds = YES;
     _textField.placeholder = @"  输入评论内容";
     _textField.backgroundColor = kUIColorFromRGB(color_0xf0f0f0);
     _textField.font = [UIFont systemFontOfSize:13];
     _textField.textColor = kUIColorFromRGB(color_1);
     [bottomView addSubview:_textField];
     
     UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(__SCREEN_SIZE.width - 60 , 0 , 60, 44)];
     [btn setTitle:@"发表" forState:UIControlStateNormal];
     [btn setTitleColor:kUIColorFromRGB(color_3) forState:UIControlStateNormal];
     btn.backgroundColor = kUIColorFromRGB(color_2);
     btn.titleLabel.font = [UIFont systemFontOfSize:16];
     [bottomView  addSubview:btn];
     
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initTableView
{
     __weak AnswerInfoViewController *weakSelf = self;
     self.tableView.refreshHeaderView = nil;
     _infoCell =[ImgAndThreeTitleTableViewCell createTableViewCell];
     [_infoCell setCellData:@{@"title":@"winder",@"source":@"这个榜单我服，因为榜首的果冻实在太出类拔萃了…… 太好吃了，强推菠萝和青梅。脆虾和芒果也是远好于市 场水平的。香菇酱和肉燥酱简直是懒人福音……"}];
     [_infoCell fitAnswerInfoMode];
     
     
     _imgsCell = [ImgsTableViewCell createTableViewCell];
     [_imgsCell setCellData:@{@"arr":@[@"dog",@"dog",@"dog",@"dog",@"dog",@"dog",@"dog",@"dog",@"dog"]}];
        [_imgsCell fitMode];
     [_imgsCell initAddPhotoManager:9 withImgArr:self.imgArr withVC:self withTableView:self.tableView];
   [_imgsCell setHandleAction:^(NSDictionary *ddic) {
         
               [weakSelf.imgsCell setupPhotoBrowser:@{@"arr":ddic[@"arr"],@"row":ddic[@"row"],@"imgArr":ddic[@"imgvs"]}];
          
     }];

     
     [ImgAndThreeTitleTableViewCell registerTableViewCell:_tableView];
     [ThreeTitleAndImgTableViewCell registerTableViewCell:_tableView];
//     _tableView.contentInset = UIEdgeInsetsMake(0, 0, 47, 0);
}

-(void)viewDidLayoutSubviews
{
     _tableView.height = __SCREEN_SIZE.height - 64 - 44;
     _tableView.width = __SCREEN_SIZE.width;
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
          if (indexPath.row == 0) {
               height = _infoCell.height;
          }
          else if (indexPath.row == 1)
          {
               height = _imgsCell.height;
          }
          else
          {
            height = 30;   
          }
     }
     else {
          NSString *str = @"回复windir：看来大家都是懒人呀！";
          CGSize s = [str size:[UIFont systemFontOfSize:13] constrainedToSize:CGSizeMake(__SCREEN_SIZE.width-60-15, __SCREEN_SIZE.height*3)];
          height = s.height +70;
     }
     return height;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
     NSInteger row = 1;
     switch (section) {
          case 0:
               row = 3;
               break;
          case 1:
               row = 3;
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
          if (indexPath.row == 0) {
               cell = _infoCell;
          }
          else if (indexPath.row == 1)
          {
               cell = _imgsCell;
          }
          else{
               cell = [ThreeTitleAndImgTableViewCell dequeueReusableCell:_tableView];
               [(ThreeTitleAndImgTableViewCell *)cell setCellData:@{@"titleA":@"1000",@"titleB":@"一周前",@"titleC":@"1000"}];
               [(ThreeTitleAndImgTableViewCell *)cell fitEvaMode];
               [(JYAbstractTableViewCell *)cell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(cell.height, 0, 0, 0)];
          }

     }
     else
     {
         
               cell = [ImgAndThreeTitleTableViewCell dequeueReusableCell:_tableView];
               [(ImgAndThreeTitleTableViewCell *)cell setCellData:@{@"title":@"winder",@"source":@"回复winder：看来大家都是懒人呀！",@"time":@"一周前",@"img":@"icon_header_eva",@"text":@"winder"}];
               [(ImgAndThreeTitleTableViewCell *)cell fitEvaluationInfoMode];
               //               if (indexPath.row == 3) {
               //                    [(JYAbstractTableViewCell *)cell showSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(cell.height, 0, 0, 0)];
               //               }else{
               //                    [(JYAbstractTableViewCell *)cell hiddenSeparatorView];
               //               }
          
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
