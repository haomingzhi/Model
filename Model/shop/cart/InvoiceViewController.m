//
//  InvoiceViewController.m
//  oranllcshoping
//
//  Created by Steve on 2017/7/26.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import "InvoiceViewController.h"
#import "TitleAndTwoBtnTableViewCell.h"
#import "TitleAndTextfieldTableViewCell.h"
#import "TitleAndDetailAndImageTableViewCell.h"
#import "SingleSelectionViewController.h"
#import "InvoiceExplainViewController.h"
#import "TitleAndTwoBtnTableViewCell.h"
#import "OnlyTitleTableViewCell.h"
#import "JYCommonTool.h"

@interface InvoiceViewController (){
     TitleAndTwoBtnTableViewCell *_choseTypeCell;
     TitleAndTextfieldTableViewCell *_headerCell;
     TitleAndTextfieldTableViewCell *_tellCell;
     TitleAndTextfieldTableViewCell *_emailCell;
     TitleAndTextfieldTableViewCell *_identifyCell;
     TitleAndTextfieldTableViewCell *_nameCell;
     TitleAndTextfieldTableViewCell *_addressCell;
     TitleAndDetailAndImageTableViewCell *_contentCell;
     TitleAndTextfieldTableViewCell *_remarkCell;
     TitleAndTwoBtnTableViewCell *_typeSelectCell;
     OnlyTitleTableViewCell *_titleCell;
     UIView *_footerView;
}
@property (nonatomic,assign) NSInteger invoiceType;//0:电子发票 1:纸质发票
@property (nonatomic,assign) BOOL isPerson;//yes:个人发票 no:企业发票
@end

@implementation InvoiceViewController

- (void)viewDidLoad {
     _isPerson = [[_json objectForKey:@"topType"] integerValue] == 0 ?NO:YES;
     _invoiceType = [[_json objectForKey:@"iType"] integerValue];
     [super viewDidLoad];
     [self initTableView];
     [self setRightNav];
     [self initNotificationCenter];
     self.title = @"发票信息";
}

- (void)didReceiveMemoryWarning {
     [super didReceiveMemoryWarning];
     // Dispose of any resources that can be recreated.
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
//     self.view.y = -keyBoardRect.size.height+64;
     _tableView.height = __SCREEN_SIZE.height - 64- keyBoardRect.size.height;
}
#pragma mark 键盘消失
-(void)keyboardWillHide:(NSNotification *)note
{
     _tableView.height = __SCREEN_SIZE.height - 64;
}


-(void)setRightNav{
     [self setNavigateRightButton:[UIImage imageNamed:@"nav_que"] observer:self callBack:@selector(rightNavAction)];
//     UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
//     [btn setBackgroundImage:[UIImage imageWithContentsOfFile:@"icon_question.png"] forState:UIControlStateNormal];
//     [btn addTarget:self action:@selector(rightNavAction) forControlEvents:UIControlEventTouchUpInside];
//     [self setNavigateRightView:btn];
     
//     [self setNavigateRightButton:[UIImage imageWithContentsOfFile:@"icon_question.png"] frame:CGRectMake(0, 0, 20, 20) observer:self callBack:@selector(rightNavAction)];
}

-(void)rightNavAction{
     InvoiceExplainViewController *vc = [InvoiceExplainViewController new];
     [self.navigationController pushViewController:vc animated:YES];
}


-(void)initTableView{
     
     __weak InvoiceViewController *weakSelf = self;
     
     
     _contentCell = [TitleAndDetailAndImageTableViewCell createTableViewCell];
     [_contentCell setCellData:@{@"title":@"*发票内容",@"detail":@"商品明细"}];
     [_contentCell fitInvoicerMode];

     _headerCell = [TitleAndTextfieldTableViewCell createTableViewCell];
     [_headerCell setCellData:@{@"title":@"*公司名称",@"placeholder":@"请输入发票抬头",@"textField":[_json objectForKey:@"companyName"]?:@""}];
     [_headerCell fitInvoiceMode];
     
     _tellCell = [TitleAndTextfieldTableViewCell createTableViewCell];
     [_tellCell setCellData:@{@"title":@"*收票人手机",@"placeholder":@"请输入收票人手机",@"textField":[_json objectForKey:@"companyName"]?:@""}];
     [_tellCell fitInvoiceMode];
     
     _emailCell = [TitleAndTextfieldTableViewCell createTableViewCell];
     [_emailCell setCellData:@{@"title":@"*收票人邮箱",@"placeholder":@"请输入收票人邮箱",@"textField":[_json objectForKey:@"checkTakerEmail"]?:@""}];
     [_emailCell fitInvoiceMode];
     
     
     _identifyCell = [TitleAndTextfieldTableViewCell createTableViewCell];
     [_identifyCell setCellData:@{@"title":@"*纳税人识别号",@"placeholder":@"请输入纳税人识别号",@"textField":[_json objectForKey:@"taxFileNumber"]?:@""}];
     [_identifyCell fitInvoiceMode];
     
     
     _nameCell = [TitleAndTextfieldTableViewCell createTableViewCell];
     [_nameCell setCellData:@{@"title":@"*收件人",@"placeholder":@"请输入收件人姓名",@"textField":[_json objectForKey:@"checkTaker"]?:@""}];
     [_nameCell fitInvoiceMode];
     
     _addressCell = [TitleAndTextfieldTableViewCell createTableViewCell];
     [_addressCell setCellData:@{@"title":@"*详细地址",@"placeholder":@"请输入详细地址",@"textField":[_json objectForKey:@"checkTakerAddress"]?:@""}];
     [_addressCell fitInvoiceMode];
     
     
     _remarkCell = [TitleAndTextfieldTableViewCell createTableViewCell];
     [_remarkCell setCellData:@{@"title":@"备注",@"placeholder":@"填写备注",@"textField":[_json objectForKey:@"iRemark"]?:@""}];
     [_remarkCell fitInvoiceMode];
     
     _choseTypeCell = [TitleAndTwoBtnTableViewCell createTableViewCell];
     [_choseTypeCell setCellData:@{@"title":@"发票类型",@"btnA":@"电子发票",@"btnB":@"纸质发票",@"type":@(_invoiceType)}];
     [_choseTypeCell fitInvoiceMode];
     [_choseTypeCell setHandleAction:^(NSDictionary *dic){
          weakSelf.invoiceType = [dic[@"index"] integerValue];
          [weakSelf.tableView reloadData];
     }];
     
     
     _typeSelectCell = [TitleAndTwoBtnTableViewCell createTableViewCell];
     [_typeSelectCell setCellData:@{@"title":@"*发票抬头",@"btnA":@"企业抬头",@"btnB":@"个人",@"isPerson":@(_isPerson)}];
     [_typeSelectCell fitInvoiceModeA];
     [_typeSelectCell setHandleAction:^(NSDictionary *dataDic) {
          UIButton *btn = dataDic[@"obj"];
          if (btn.tag == 100) {
               _isPerson = NO;
          }else{
               _isPerson = YES;
          }
          [_typeSelectCell setCellData:@{@"title":@"*发票抬头",@"btnA":@"企业抬头",@"btnB":@"个人",@"isPerson":@(_isPerson)}];
          [_typeSelectCell fitInvoiceModeA];
          [_tableView reloadData];
     }];
     
     _titleCell = [OnlyTitleTableViewCell createTableViewCell];
     [_titleCell setCellData:@{@"title":@"收件信息"}];
     [_titleCell fitPersonInfoSettingMode];
     
     _tableView.delegate = self;
     _tableView.dataSource = self;
     _tableView.width = __SCREEN_SIZE.width;
     _tableView.height = __SCREEN_SIZE.height - 64;
     _tableView.x = 0;
     _tableView.y = 0;
     _tableView.refreshHeaderView = nil;
     _tableView.tableFooterView.userInteractionEnabled = YES;
     _tableView.backgroundColor = kUIColorFromRGB(color_4);
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
     return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
     NSInteger row = 1;
     if (section == 1){
          if (_isPerson) {
               row = 3;
          }else
               row = 5;
     }
     else if (section == 2){
          if (_invoiceType == 1) {
               row = 4;
          }else
               row = 1;
     }
     return row;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
     UITableViewCell *cell;
     if (indexPath.section == 0) {
          cell = _choseTypeCell;
     }
     else if (indexPath.section == 1) {
          if (_isPerson) {
               if (indexPath.row == 0) {
                    cell = _typeSelectCell;
               }else if (indexPath.row == 1) {
                    cell = _contentCell;
               }else if (indexPath.row == 2) {
                    cell = _remarkCell;
               }
          }else{
               if (indexPath.row == 0) {
                    cell = _typeSelectCell;
               }else if (indexPath.row == 1) {
                    cell = _headerCell;
               }else if (indexPath.row == 2) {
                    cell = _identifyCell;
               }else if (indexPath.row == 3) {
                    cell = _contentCell;
               }else{
                    cell = _remarkCell;
               }
          }
          
     }else{
          if (_invoiceType == 1) {
               if (indexPath.row == 0) {
                    cell = _nameCell;
               }else if (indexPath.row == 1) {
                    cell = _tellCell;
               }else if (indexPath.row == 2) {
                    cell = _addressCell;
               }else if (indexPath.row == 3) {
                    cell = _emailCell;
               }
          }else{
               cell = _emailCell;
          }
     }
     cell.selectionStyle = UITableViewCellSelectionStyleNone;
     return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
     if (section == 1 && _invoiceType == 1) {
          return 0.001;
     }
     return section == 2 ? 120:10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
     if (section == 2 && _invoiceType == 1) {
          return 40;
     }
     return  0.001;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
     if (section == 2 && _invoiceType == 1) {
          return _titleCell;
     }
     return nil;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
     if (section ==2) {
          if (!_footerView) {
               _footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, __SCREEN_SIZE.width, 120)];
               UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(15, 45, __SCREEN_SIZE.width-30, 40)];
               [btn setTitle:@"保存" forState:UIControlStateNormal];
               [btn setTitleColor:kUIColorFromRGB(color_2) forState:UIControlStateNormal];
               btn.backgroundColor = kUIColorFromRGB(color_3);
               btn.layer.cornerRadius = 6.0;
               btn.layer.masksToBounds = YES;
               [btn addTarget:self action:@selector(saveAction) forControlEvents:UIControlEventTouchUpInside];
               [_footerView addSubview:btn];
               
//               UILabel *warnLb = [UILabel new];
//               warnLb.x = 15;
//               warnLb.y = 98;
//               warnLb.width = __SCREEN_SIZE.width -30;
//               warnLb.numberOfLines = 0;
//               warnLb.font = [UIFont systemFontOfSize:13];
//               warnLb.textColor = kUIColorFromRGB(color_7);
//               warnLb.text = @"发票须知： \n1.开票金额为用户实际支付金额(不含礼品卡) \n2.电子发票可在确认收货后，在“订单详情“查看 \n3.未随箱寄出的纸质发票会在发货后15-30个工作日单独寄出\n 4.单笔订单只支持开具一种发票类型，如需增值税专用发票请联 系客服处理\n 5.年购订单发票随每期子单寄出";
//               [warnLb sizeToFit];
//               [_footerView addSubview:warnLb];
          }
          return _footerView;
     }
     return nil;
}

-(void)saveAction{
     if (!_isPerson) {
          if (_headerCell.textField.text.length == 0) {
               HUDCRY(@"请输入公司名称", 2);
               return;
          }
          if (!(_identifyCell.textField.text.length == 13 || _identifyCell.textField.text.length == 18 ||_identifyCell.textField.text.length == 20) || ![JYCommonTool isNumberAndLetters:_identifyCell.textField.text]) {
               HUDCRY(@"公司税号需为15或18或20位数字或大写", 2);
               return;
          }
          
     }
     
     if (_invoiceType == 1) {
          if (_nameCell.textField.text.length == 0) {
               HUDCRY(@"请输入收件人姓名", 2);
               return;
          }
          if (![JYCommonTool isMobileNum:_tellCell.textField.text]) {
               HUDCRY(@"请填写正确手机号", 2);
               return;
          }
          if (_addressCell.textField.text == 0) {
               HUDCRY(@"请输入详细地址", 2);
               return;
          }
          if (_emailCell.textField.text != 0 && ![JYCommonTool validateEmail:_emailCell.textField.text] ) {
               HUDCRY(@"请填写正确邮箱地址", 2);
               return;
          }
     }else{
          if (![JYCommonTool validateEmail:_emailCell.textField.text] ) {
               HUDCRY(@"请填写正确邮箱地址", 2);
               return;
          }
     }
     if (self.handleGoBack) {
          /*
           {
           iType (integer, optional): 发票类型:0电子发票，1纸质发票 ,
           topType (integer, optional): 抬头类型：0企业抬头，1个人/非企业单位 ,
           companyName (string, optional): 公司名称 ,
           taxFileNumber (string, optional): 纳税人识别号 ,
           orderType (integer, optional): 发票内容类别：0默认商品明细 ,
           orderId (string, optional): 发票内容:默认商品明细,订单ID ,
           iRemark (string, optional): 备注 ,
           checkTaker (string, optional): 收票人 ,
           checkTakerMobile (string, optional): 收票人手机号 ,
           checkTakerAddress (string, optional): 详细地址 ,
           checkTakerEmail (string, optional): 收票人邮箱 ,
           iHelpRemark (string, optional): 帮助
           }
           */
          
          BSJSON *json = [BSJSON new];
          [json setObject:@(_invoiceType) forKey:@"iType"];
          [json setObject:@(_isPerson?1:0) forKey:@"topType"];
          [json setObject:_headerCell.textField.text forKey:@"companyName"];
          [json setObject:[_identifyCell.textField.text uppercaseString] forKey:@"taxFileNumber"];
          [json setObject:@(0) forKey:@"orderType"];
          [json setObject:@"" forKey:@"orderId"];
          [json setObject:_remarkCell.textField.text forKey:@"iRemark"];
          [json setObject:_nameCell.textField.text forKey:@"checkTaker"];
          [json setObject:@"" forKey:@"iHelpRemark"];
          [json setObject:_tellCell.textField.text forKey:@"checkTakerMobile"];
          [json setObject:_addressCell.textField.text forKey:@"checkTakerAddress"];
          [json setObject:_emailCell.textField.text forKey:@"checkTakerEmail"];
          self.handleGoBack(@{@"obj":json});
     }
     [self.navigationController popViewControllerAnimated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
     CGFloat height = 40;
     if (indexPath.section == 0 ) {
          if (_invoiceType == 0) {
                height = 120;
          }else
               height = 85;
         
     }
     return height;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
     [self.view endEditing:YES];
//     if (indexPath.section == 1 && indexPath.row == 1) {
//          //发票内容
//          SingleSelectionViewController *vc = [SingleSelectionViewController toSingleSelectionVC:@[@"日用品",@"家居用品",@"食品",@"客户服务",@"酒/饮料",@"服饰",@"化妆品"]];
//          [vc setHandleAction:^(NSDictionary *dic){
//               [_contentCell setCellData:@{@"title":@"*发票内容",@"detail":dic[@"title"]}];
//          }];
//     }
}

//-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
//     [self.view endEditing:YES];
//}

@end
