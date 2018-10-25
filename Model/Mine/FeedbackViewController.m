//
//  FeedbackViewController.m
//  oranllcshoping
//
//  Created by air on 2017/7/21.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import "FeedbackViewController.h"
#import "OnlyTitleTableViewCell.h"
#import "TextViewCanChangeTableViewCell.h"
#import "TextFieldTableViewCell.h"
#import "AddImgTableViewCell.h"
#import "OnlyBottomBtnTableViewCell.h"
#import "SingleSelectionViewController.h"
#import "BUSystem.h"
@interface FeedbackViewController ()
{
     OnlyTitleTableViewCell *_typeChoseCell;
     TextViewCanChangeTableViewCell *_textViewCell;
     TextFieldTableViewCell *_textTfCell;
     OnlyTitleTableViewCell *_tipCell;
 
     OnlyBottomBtnTableViewCell *_submitCell;
}
@property (strong, nonatomic) IBOutlet MyTableView *tableView;
@property (strong, nonatomic)    AddImgTableViewCell *imgsCell;
@property(nonatomic,strong)  NSMutableArray *imgArr;
@property(nonatomic)NSInteger type;
@end

@implementation FeedbackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"意见反馈";
           _imgArr = [NSMutableArray new];
     _type = -1;
    [self initTableView];
     _textTfCell.textTf.text = busiSystem.agent.tel;
}

-(void)initTableView
{
     _tableView.refreshHeaderView = nil;
     __weak FeedbackViewController *weakSelf = self;
     _typeChoseCell = [OnlyTitleTableViewCell createTableViewCell];
     [_typeChoseCell setCellData:@{@"title":@"请选择反馈类型"}];
     [_typeChoseCell fitFeedbackMode];
     
     _textViewCell = [TextViewCanChangeTableViewCell createTableViewCell];
     [_textViewCell setCellData:@{@"placeholder":@"请写下您对的感受，倾斜性质意见反馈"}];
     [_textViewCell fitFeedbackMode];
     
     _textTfCell = [TextFieldTableViewCell createTableViewCell];
         [_textTfCell setCellData:@{@"placeholder":@"手机/邮箱/QQ"}];
     [_textTfCell fitFeedbackMode];
     
     _tipCell = [OnlyTitleTableViewCell createTableViewCell];
        [_tipCell setCellData:@{@"title":@"上传图片(最多6张)"}];
     [_tipCell fitFeedbackModeB];
     
     _imgsCell = [AddImgTableViewCell createTableViewCell];
     [_imgsCell setCellData:@{@"arr":@[],@"limitCount":@6,@"default":@"",@"colCount":@3,@"hiddenDelBtn":@NO}];
     _imgsCell.mode = AddImgModeMutable;
     [_imgsCell fitFeedbackMode];
     [_imgsCell initAddPhotoManager:6 withImgArr:self.imgArr withVC:self withTableView:self.tableView];
     [_imgsCell.addPhotoManager setCheckDoneCallBack:^(NSDictionary *dic){
//          NSMutableArray *arr = dic[@"arr"];
          //        if(weakSelf.imgArr.count > 3)
          //        {
          //            [weakSelf.imgArr removeObjectsInRange:NSMakeRange(3, weakSelf.imgArr.count - 3)];
          //        }
          //        [weakSelf.imgsCell setCellData:@{@"limitCount":@3,@"arr":weakSelf.imgArr,@"colCount":@3}];
//          [self uploadImg:@"0" withImgArr:arr];
          [weakSelf.imgsCell fitFeedbackMode];
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
               [weakSelf.imgsCell fitFeedbackMode];
               [weakSelf.tableView reloadData];
          }
     }];
     
     _submitCell = [OnlyBottomBtnTableViewCell createTableViewCell];
     [_submitCell setCellData:@{@"title":@"提交"}];
     [_submitCell setHandleAction:^(id sender) {
          [weakSelf submit];
     }];
     [_submitCell fitFeedbackMode];

}

-(void)submit
{
     [self.view endEditing:YES];
     if ([_textViewCell.textView.text isEqualToString:@""]) {
//          HUDCRY(@"请填写反馈内容", 1);
          return;
     }
//     HUDSHOW(@"加载中");
//     [busiSystem.agent feedBack:_textTfCell.textTf.text withContent:_textViewCell.textView.text withType:[NSString stringWithFormat:@"%ld",_type] observer:self callback:@selector(feedBackNotification:)];
     [busiSystem.agent addFeed:_textViewCell.textView.text withUserid:busiSystem.agent.userId?:@"" observer:self callback:@selector(feedBackNotification:)];
}

-(void)feedBackNotification:(BSNotification*)noti
{
     if (noti.error.code == 0) {
//          HUDSMILE(@"反馈成功", 2);
          [self.navigationController popViewControllerAnimated:YES];
     }
     else
     {

//          HUDCRY(noti.error.domain, 1);
     }
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
     
     return 0.0001;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 44;
//     if (indexPath.row == 0) {
//          height = 46;
//     }
//     else
          if (indexPath.row == 0)
     {
          height = 136;
     }
//     else if (indexPath.row == 2)
//     {
//          height = 45;
//     }
//     else if (indexPath.row == 3)
//     {
//          height = 33;
//     }
//     else if (indexPath.row == 4)
//     {
//          height = _imgsCell.height;//230;
//     }
     else
     {
          height = 91;
     }
    return height;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger row = 2;
    
    return row;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
//     if (indexPath.row == 0) {
//          cell = _typeChoseCell;
//     }
//     else
          if (indexPath.row == 0)
     {
          cell = _textViewCell;
     }
//     else if (indexPath.row == 2)
//     {
//          cell = _textTfCell;
//     }
//     else if (indexPath.row == 3)
//     {
//          cell = _tipCell;
//     }
//     else if (indexPath.row == 4)
//     {
//          cell = _imgsCell;
//     }
     else
     {
          cell = _submitCell;
     }
     
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     if (indexPath.row == 0) {
          SingleSelectionViewController *vc = [SingleSelectionViewController toSingleSelectionVC:@[@"商品质量",@"门店服务",@"配送服务",@"客服服务",@"支付问题",@"退货退款",@"商品缺货",@"其他"]];
//          vc.curRow = busiSystem.getAreaParkListManager.curRow;
          [vc setHandleAction:^(NSDictionary *dic){
//               BUAreaPark *pk = busiSystem.getAreaParkListManager.data[[dic[@"row"] integerValue]];
//               
//               
//               _auth.sapid = pk.sapId;
               [_typeChoseCell setCellData:@{@"title":dic[@"title"]}];
             NSInteger row =  [dic[@"row"] integerValue];
               _type = row;
          }];
     }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
