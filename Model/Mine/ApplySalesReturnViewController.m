//
//  ApplySalesReturnViewController.m
//  oranllcshoping
//
//  Created by air on 2017/7/26.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import "ApplySalesReturnViewController.h"
#import "SubmitSuccessViewController.h"
#import "SingleSelectionViewController.h"
#import "OnlyTitleTableViewCell.h"
#import "TextViewCanChangeTableViewCell.h"
#import "TextFieldTableViewCell.h"
#import "OnlyBottomBtnTableViewCell.h"
#import "AddImgTableViewCell.h"
//#import "HuanxinKefuManager.h"
#import "LoginViewController.h"
#import "BUSystem.h"
@interface ApplySalesReturnViewController ()
{
     OnlyTitleTableViewCell *_caseTipCell;
         OnlyTitleTableViewCell *_queDisCell;
     OnlyTitleTableViewCell *_typeChoseCell;
     TextViewCanChangeTableViewCell *_textViewCell;
     TextFieldTableViewCell *_textTfCell;
     OnlyTitleTableViewCell *_tipCell;
     
     OnlyBottomBtnTableViewCell *_submitCell;
     
     OnlyTitleTableViewCell *_contactWayTipCell;
       TextFieldTableViewCell *_contactTfCell;
      TextFieldTableViewCell *_phoneTfCell;
     
     OnlyTitleTableViewCell *_alertCell;
}

@property (strong, nonatomic)    AddImgTableViewCell *imgsCell;
@property(nonatomic,strong)  NSMutableArray *imgArr;
@property(nonatomic,strong)  NSMutableArray *upImgArr;
//@property (nonatomic,strong) BUBackType *backType;
@property (nonatomic,strong)NSString *reasonid;
@property (nonatomic,strong)BUSaleType *reason;
@property (strong, nonatomic) IBOutlet MyTableView *tableView;

@end

@implementation ApplySalesReturnViewController


- (void)viewDidLoad {
     [super viewDidLoad];
     // Do any additional setup after loading the view from its nib.
     self.title = @"申请售后";
     _imgArr = [NSMutableArray new];
     _upImgArr = [NSMutableArray new];
     [self initTableView];
//  [self setNavigateRightButton:@"nav_kefu"];
     HUDSHOW(@"加载中");
     [self getData];

}

-(void)getData{
//     [busiSystem.indexManager getReasonList:self callback:@selector(getReasonListNotification:)];
     [busiSystem.myPathManager saleType:self callback:@selector(saleTypeNotification:)];
}


-(void) saleTypeNotification:(BSNotification *) noti
{
     if (noti.error.code == 0) {
          HUDDISMISS;
          _tableView.dataArr = [NSMutableArray arrayWithArray:busiSystem.myPathManager.saleTypeArr];

     }else{
          HUDCRY(noti.error.domain, 2);
     }
     
}


-(void)initTableView
{
     _tableView.refreshHeaderView = nil;
     __weak ApplySalesReturnViewController *weakSelf = self;

     _caseTipCell = [OnlyTitleTableViewCell createTableViewCell];
     [_caseTipCell setCellData:@{@"title":@"售后类型"}];
     [_caseTipCell fitApplySalesReturnMode];
     
     _typeChoseCell = [OnlyTitleTableViewCell createTableViewCell];
     [_typeChoseCell setCellData:@{@"title":@"请选择售后原因"}];
     [_typeChoseCell fitApplySalesReturnModeC];
//
//     _typeChoseCell = [OnlyTitleTableViewCell createTableViewCell];
//     [_typeChoseCell setCellData:@{@"title":@"请选择反馈类型"}];
//     [_typeChoseCell fitFeedbackMode];

     _queDisCell = [OnlyTitleTableViewCell createTableViewCell];
     [_queDisCell setCellData:@{@"title":@"问题描述"}];
     [_queDisCell fitApplySalesReturnMode];
     
     _textViewCell = [TextViewCanChangeTableViewCell createTableViewCell];
     [_textViewCell setCellData:@{@"placeholder":@"请输入退货的问题描述"}];
     [_textViewCell fitApplySalesReturnMode];
     
     _textTfCell = [TextFieldTableViewCell createTableViewCell];
     [_textTfCell setCellData:@{@"placeholder":@"手机/邮箱/QQ"}];
     [_textTfCell fitFeedbackMode];
     
     _tipCell = [OnlyTitleTableViewCell createTableViewCell];
     [_tipCell setCellData:@{@"title":@"上传图片(最多3张)"}];
     [_tipCell fitApplySalesReturnModeB];
     
     _imgsCell = [AddImgTableViewCell createTableViewCell];
     [_imgsCell setCellData:@{@"arr":@[],@"limitCount":@3,@"default":@"",@"colCount":@3,@"hiddenDelBtn":@NO}];
     [_imgsCell fitFeedbackMode];
     [_imgsCell initAddPhotoManager:3 withImgArr:self.imgArr withVC:self withTableView:self.tableView];
     [_imgsCell.addPhotoManager setCheckDoneCallBack:^(NSDictionary *dic){
          NSMutableArray *arr = dic[@"arr"];
          //        if(weakSelf.imgArr.count > 3)
          //        {
          //            [weakSelf.imgArr removeObjectsInRange:NSMakeRange(3, weakSelf.imgArr.count - 3)];
          //        }
//                  [weakSelf.imgsCell setCellData:@{@"limitCount":@3,@"arr":arr,@"colCount":@3}];
          //          [self uploadImg:@"0" withImgArr:arr];
//          [weakSelf upimgs:arr];
           [weakSelf.upImgArr addObjectsFromArray:arr];
          [weakSelf.imgsCell fitFeedbackMode];
//          [weakSelf.tableView reloadData];
     }];
     [_imgsCell setHandleAction:^(NSDictionary *ddic) {
          if([ddic[@"method"] integerValue] == 1)
          {
               [weakSelf.imgsCell  toCheckOption:@{@"count":@(3 - weakSelf.imgArr.count)}];
          }
          else if([ddic[@"method"] integerValue] == 2)
          {
               [weakSelf.imgsCell setupPhotoBrowser:@{@"arr":weakSelf.imgArr,@"row":ddic[@"row"],@"imgArr":ddic[@"imgvs"]}];
          }
          else
          {
               [weakSelf.imgsCell delImg:[ddic[@"row"] integerValue]];
               [weakSelf.upImgArr removeObjectAtIndex:[ddic[@"row"] integerValue]];
               [weakSelf.imgsCell fitFeedbackMode];
               [weakSelf.tableView reloadData];
          }
     }];
     
     _contactTfCell = [TextFieldTableViewCell createTableViewCell];
     
     [_contactTfCell fitApplyReturnModeB:@"联系人："];
     _contactTfCell.textTf.kbMovingView = self.tableView;
     _contactTfCell.textTf.placeholder = @"请输入联系人姓名";
     
     _phoneTfCell = [TextFieldTableViewCell createTableViewCell];
       [_phoneTfCell fitApplyReturnModeB:@"联系电话："];
     _phoneTfCell.textTf.kbMovingView = self.tableView;
     _phoneTfCell.textTf.placeholder = @"请输入联系电话";
     _phoneTfCell.textTf.keyboardType = UIKeyboardTypeNumberPad;
     _phoneTfCell.textTf.text = busiSystem.agent.tel?:@"";
     
     _submitCell = [OnlyBottomBtnTableViewCell createTableViewCell];
     [_submitCell setCellData:@{@"title":@"提交"}];
     [_submitCell fitFeedbackMode];
     [_submitCell setHandleAction:^(id o){
          [weakSelf toSubmit];
     }];
     
     _contactWayTipCell = [OnlyTitleTableViewCell createTableViewCell];
     [_contactWayTipCell setCellData:@{@"title":@"联系方式"}];
     [_contactWayTipCell fitApplyReturnModeB];
     
     _alertCell = [OnlyTitleTableViewCell createTableViewCell];
     [_alertCell setCellData:@{@"title":@"温馨提示：\n • 商品寄回地址将在审核通过后以短信形式告知，或在申请记 录中查询。\n • 提交服务单后，售后专员可能与您电话沟通，请保持手机畅 通。\n • 退货处理成功后退款金额将原路返回到您的支持账户中；"}];
     [_alertCell fitApplyReturnMode];
}

-(void)toSubmit{
//     SubmitSuccessViewController *vc = [SubmitSuccessViewController new];
//     //          vc.orderBackID = busiSystem.orderManager.orderBackID;//
//     [self.navigationController pushViewController:vc animated:YES];
//     return;
     if (!_reason) {
          HUDCRY(@"请选择售后原因", 2);
          return;
     }

     if (_textViewCell.textView.text.length == 0) {
          HUDCRY(@"请输入售后的问题描述", 2);
          return;
     }

     if (_upImgArr.count == 0) {
          HUDCRY(@"请上传凭证图片", 2);
          return;
     }


     if (_contactTfCell.textTf.text.length == 0) {
          HUDCRY(@"请输入联系人姓名", 2);
          return;
     }

     if (_phoneTfCell.textTf.text.length == 0) {
          HUDCRY(@"请输入联系电话", 2);
          return;
     }

     HUDSHOW(@"提交中");

     [self toBackOrder];

}


-(void) uploadImgsNotification:(BSNotification *) noti
{
     if (noti.error.code == 0) {
//          [self toBackOrder];
          HUDDISMISS;
          [_upImgArr addObjectsFromArray:busiSystem.agent.imgsList];
            [self.tableView reloadData];
     }else{
          HUDCRY(noti.error.domain, 2);
     }
     
}

-(void)upimgs:(NSArray*)arr
{
     HUDSHOW(@"加载中");
      [busiSystem.agent uploadImgs:arr observer:self callback:@selector(uploadImgsNotification:)];
}
-(void)toBackOrder{
//     NSString *uploadPic = busiSystem.agent.imgsList;
//     [busiSystem.orderManager toBackOrder:busiSystem.agent.userId orderId:_orderId rsId:_backType.rsId rsTitle:_backType.rsTitle backContent:_textViewCell.textView.text userName:_contactTfCell.textTf.text userTel:_phoneTfCell.textTf.text uploadPic:uploadPic observer:self callback:@selector(toBackOrderNotification:)];
//     [busiSystem.getAfterSaleListManager orderBack:busiSystem.agent.userId withOrderid:_orderId?:@"" withContent:_textViewCell.textView.text withGoodsid:@"" withContacts:_contactTfCell.textTf.text withImagelist:_upImgArr withTelephone:_phoneTfCell.textTf.text withReasonid:_reasonid observer:self callback:@selector(toBackOrderNotification:)];
//     SubmitSuccessViewController *vc = [SubmitSuccessViewController new];
//     vc.orderBackID = busiSystem.orderManager.orderBackID;
//     [self.navigationController pushViewController:vc animated:YES];
     [busiSystem.myPathManager addSale:busiSystem.agent.userId withUsername:_contactTfCell.textTf.text withMsg:_textViewCell.textView.text withOrderid:_orderId withTel:_phoneTfCell.textTf.text withImgs:_upImgArr withAftertypeid:_reasonid?:@"" observer:self callback:@selector(toBackOrderNotification:)];
}


-(void) toBackOrderNotification:(BSNotification *) noti
{
     if (noti.error.code == 0) {
          HUDDISMISS;
          if (self.handleGoBack) {
               self.handleGoBack(@{});
          }
          SubmitSuccessViewController *vc = [SubmitSuccessViewController new];
          vc.orderBackID = busiSystem.myPathManager.addSaleId; //busiSystem.orderManager.orderBackID;//
          [self.navigationController pushViewController:vc animated:YES];
     }else{
          HUDCRY(noti.error.domain, 2);
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
     if (indexPath.row == 0) {
          height = 32;
     }
     else
     if (indexPath.row == 1) {
          height = 36;
     }
     else if (indexPath.row == 2)
     {
          height = 32;
     }
     else if (indexPath.row == 3)
     {
          height = 130;
     }
     else if (indexPath.row == 4)
     {
          height = 33;
     }
     else if (indexPath.row == 5)
     {
          height = MIN(_imgsCell.height, 123);//230;
     }
     else if (indexPath.row == 6)
     {
          height = 43;
     }
     else if (indexPath.row == 7)
     {
          height = 40;
     }
     else if (indexPath.row == 8)
     {
          height = 40;//230;
     }
     else if (indexPath.row == 9)
     {
          height = 82;
     }
     else
     {
          height = 120;
     }
     return height;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
     NSInteger row = 11;
     
     return row;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
     UITableViewCell *cell;
     if (indexPath.row == 0) {
          cell = _caseTipCell;
     }
     else
     if (indexPath.row == 1) {
          cell = _typeChoseCell;
     }
     else if (indexPath.row == 2)
     {
          cell = _queDisCell;
     }
     else if (indexPath.row == 3)
     {
        cell = _textViewCell;
     }
     else if (indexPath.row == 4)
     {
          cell = _tipCell;
     }
     else if (indexPath.row == 5)
     {
          cell = _imgsCell;
     }
     else if (indexPath.row == 6)
     {
          cell = _contactWayTipCell;
     }
     else if (indexPath.row == 7)
     {
          cell = _contactTfCell;
          [_contactTfCell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(40, 0, 0, 0)];
     }
     else if (indexPath.row == 8)
     {
          cell = _phoneTfCell;
     }
     
     else if (indexPath.row == 9)
     {
          cell = _submitCell;
     }
     else
     
     {
          cell = _alertCell;
     }
     
     cell.selectionStyle = UITableViewCellSelectionStyleNone;
     return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     if (indexPath.row == 1) {
          NSMutableArray *arr = [NSMutableArray new];
          [_tableView.dataArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
               BUSaleType *type = obj;
               [arr addObject:type.name];
          }];
          SingleSelectionViewController *vc = [SingleSelectionViewController toSingleSelectionVC:arr];
          //          vc.curRow = busiSystem.getAreaParkListManager.curRow;
          __weak ApplySalesReturnViewController *weakSelf = self;
          [vc setHandleAction:^(NSDictionary *dic){
               BUSaleType *pk = _tableView.dataArr[[dic[@"title"] integerValue]];
                              weakSelf.reasonid = pk.afterTypeId;
               weakSelf.reason = pk;
               [_typeChoseCell setCellData:@{@"title":dic[@"title"]}];
//               NSInteger index = [dic[@"row"] integerValue];
//               weakSelf.backType = weakSelf.tableView.dataArr[index];
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
