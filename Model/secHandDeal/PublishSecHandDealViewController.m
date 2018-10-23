//
//  PublishSecHandDealViewController.m
//  intelligentgarbagecollection
//
//  Created by air on 2017/12/5.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import "PublishSecHandDealViewController.h"
#import "AddImgTableViewCell.h"
#import "OnlyTitleTableViewCell.h"
#import "TitleAndImageTableViewCell.h"
#import "TextViewCanChangeTableViewCell.h"
#import "TextFieldTableViewCell.h"
#import "TwoTabsTableViewCell.h"
#import "OnlyBottomBtnTableViewCell.h"
#import "BUSystem.h"
#import "JYCommonTool.h"
#import "SelectAddressViewController.h"
//#import "ReplacementViewController.h"
@interface PublishSecHandDealViewController ()
{
     TextFieldTableViewCell *_titleCell;

      TextViewCanChangeTableViewCell *_textViewCell;
     TextFieldTableViewCell *_posCell;
     OnlyTitleTableViewCell *_imgTipCell;
     TwoTabsTableViewCell *_setPriceCell;
      OnlyTitleTableViewCell *_tipCell;
        OnlyBottomBtnTableViewCell *_submitCell;
     
}
@property(nonatomic,strong)  NSMutableArray *imgArr;
@property(nonatomic,strong)  NSMutableArray *upimgArr;
@property (strong, nonatomic) IBOutlet MyTableView *tableView;
@property (strong, nonatomic) AddImgTableViewCell *imgsCell;
@property ( nonatomic)CGFloat price;
@property (strong, nonatomic)NSString *goodsId;
@property (strong, nonatomic)NSString *content;
@property (strong, nonatomic)NSString *address;
@property (strong, nonatomic)NSString *lon;
@property (strong, nonatomic)NSString *lat;
@property (strong, nonatomic)NSString *cityName;
@property (strong, nonatomic)NSString *goodsName;
@end

@implementation PublishSecHandDealViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
     self.title = @"发布二手物品";
     _imgArr = [NSMutableArray new];
     _upimgArr = [NSMutableArray new];


     _goodsId = @"";
     if (_mySec) {
          _goodsId = _mySec.goodsId?:@"";
          _goodsName = _mySec.name?:@"";
          _price = _mySec.price;
          _imgArr = [NSMutableArray arrayWithArray:_mySec.imageList];
          _upimgArr = [NSMutableArray arrayWithArray:_mySec.imageList];
          _content = [JYCommonTool unescape:_mySec.content];
     }
     _lat = busiSystem.agent.lat;
     _lon = busiSystem.agent.log;
//     _address = busiSystem.agent.address;
     _cityName = busiSystem.agent.cityName;
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshAddressData) name:@"refreshAddressData" object:nil];
        [self initTableView];
         [self addBottomView];
     HUDSHOW(@"加载中");
     [self getUserDefaultAddressData];
}
-(void)refreshAddressData
{
     HUDSHOW(@"加载中");
     [self getUserDefaultAddressData];
}
-(void)dealloc
{
     [[NSNotificationCenter defaultCenter] removeObserver:self];
}
-(BOOL)prefersStatusBarHidden
{
     return NO;
}
-(void)viewDidLayoutSubviews
{
     _tableView.width = __SCREEN_SIZE.width;
     _tableView.height = __SCREEN_SIZE.height - 64 - 44;
}
-(void)getUserDefaultAddressData
{
     [busiSystem.agent getUserDefaultAddress:busiSystem.agent.userId observer:self callback:@selector(getUserDefaultAddressNotification:)];
}

-(void)getUserDefaultAddressNotification:(BSNotification*)noti
{
     if (noti.error.code == 0) {
          HUDDISMISS;
          NSString * _addrId = busiSystem.agent.userDefaultAddress.addrId;
          if (!_addrId||[_addrId isEqualToString:@""]) {
               HUDDISMISS;
               [_posCell setCellData:@{@"title":@"请新增服务地址",@"detail":@""}];
               [_posCell fitPublishSecHandModeC];
               return;
          }
          _lat = busiSystem.agent.userDefaultAddress.latitude;
          _lon = busiSystem.agent.userDefaultAddress.longitude;
          NSString *addr = busiSystem.agent.userDefaultAddress.address;
          NSString *detail = busiSystem.agent.userDefaultAddress.detail;
          _cityName = busiSystem.agent.userDefaultAddress.cityName;
           _address = [NSString stringWithFormat:@"%@%@",addr,detail] ;
          [_posCell setCellData:@{@"title":addr?:@""}];
          [_posCell fitPublishSecHandModeB];
          [_tableView reloadData];
     }
     else
     {

        NSString * _addrId = busiSystem.agent.userDefaultAddress.addrId;
          if (!_addrId||[_addrId isEqualToString:@""]) {
               HUDDISMISS;
               [_posCell setCellData:@{@"title":@"请新增服务地址",@"detail":@""}];
               [_posCell fitPublishSecHandModeC];
               return;
          }
          HUDCRY(noti.error.domain, 1);
     }
}

-(void)submit
{
     [self.view endEditing:YES];
     _content = _textViewCell.textView.text;
    _goodsName = _titleCell.textTf.text;
     _mySec.content = _content;
     _mySec.imageList = [NSMutableArray arrayWithArray:_upimgArr];
     _mySec.price = _price;
     _mySec.latitude = _lat;
     _mySec.longitude = _lon;
     _mySec.address = _address;
//     _mySec.integral = _jf
     HUDSHOW(@"加载中");
     [busiSystem.secondhandManager saveSecondhandGoods:busiSystem.agent.userId?:@"" withContent:_content withAddress:_address withLongitude:_lon withGoodsid:_goodsId withPrice:[NSString stringWithFormat:@"%.2f",_price] withLatitude:_lat withImagelist:_upimgArr withName:_goodsName withCityname:_cityName observer:self callback:@selector(saveSecondhandGoodsNotification:)];
}

-(void)saveSecondhandGoodsNotification:(BSNotification*)noti
{
     if (noti.error.code == 0) {
          [[NSNotificationCenter defaultCenter] postNotificationName:@"refresSecHandData" object:nil];
           [[NSNotificationCenter defaultCenter] postNotificationName:@"refresMySecHandData" object:nil];
          HUDSMILE(@"发布成功", 1);
          [self.navigationController popViewControllerAnimated:YES];
//          if (self.parentVC&& [self.parentVC isKindOfClass:[ReplacementViewController class]]) {
//               [(ReplacementViewController*)self.parentVC setSecondHandGoods:_mySec];
//          }
     }
     else
     {

          HUDCRY(noti.error.domain, 1);
     }
}

-(void)addBottomView
{
     _submitCell.width = __SCREEN_SIZE.width;
     _submitCell.y = __SCREEN_SIZE.height - 64 - 44;
     _submitCell.x = 0;
     [self.view addSubview:_submitCell];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)initTableView
{
    self.tableView.refreshHeaderView = nil;
     __weak PublishSecHandDealViewController *weakSelf = self;

     _titleCell = [TextFieldTableViewCell createTableViewCell];
     [_titleCell setCellData:@{@"placeholder":@"请输入发布二手物品的名称/标题",@"detail":[NSString stringWithFormat:@"%ld/15",_goodsName.length],@"title":_goodsName?:@""}];
     [_titleCell fitPublishSecHandMode];
     [_titleCell.textTf addTarget:self action:@selector(titleChange:) forControlEvents:UIControlEventEditingChanged];
     _titleCell.textTf.kbMovingView = self.view;
     _titleCell.textTf.delegate = self;
     _posCell = [TextFieldTableViewCell createTableViewCell];
     [_posCell setCellData:@{@"title":@"所在地址"}];
     [_posCell fitPublishSecHandModeB];
     _posCell.textTf.userInteractionEnabled = NO;

     _imgTipCell = [OnlyTitleTableViewCell createTableViewCell];
     [_imgTipCell setCellData:@{@"title":@"请上传二手置换物品照片"}];
       [_imgTipCell fitPublishSecHandMode];

     _setPriceCell = [TwoTabsTableViewCell createTableViewCell];
     [_setPriceCell setCellData:@{@"title":@"设置卖价（单价：元）",@"value":[NSString stringWithFormat:@"%.0f",self.price],@"tab1":@"",@"tab2":@""}];
     [_setPriceCell fitPublishSecHandMode];
     __weak TwoTabsTableViewCell *ssw = _setPriceCell;
     [_setPriceCell setTabOneCallBack:^(id o) {
          if (weakSelf.price == 0) {
               return ;
          }
          weakSelf.price --;
          [ssw setCellData:@{@"title":@"设置卖价（单价：元）",@"value":[NSString stringWithFormat:@"%.0f",weakSelf.price],@"tab1":@"",@"tab2":@""}];
          [ssw fitPublishSecHandMode];
     }];
     [_setPriceCell setTabTwoCallBack:^(id o) {
            weakSelf.price ++;
          [ssw setCellData:@{@"title":@"设置卖价（单价：元）",@"value":[NSString stringWithFormat:@"%.0f",weakSelf.price],@"tab1":@"",@"tab2":@""}];
          [ssw fitPublishSecHandMode];
     }];

     _tipCell = [OnlyTitleTableViewCell createTableViewCell];
//     [_tipCell setCellData:@{@"title":[NSString stringWithFormat:@"注：每成功发布一次二手置换信息收取%ld积分。",busiSystem.agent.config.secondaryIntegral]}];
       [_tipCell fitPublishSecHandModeB];
     
     _imgsCell = [AddImgTableViewCell createTableViewCell];

     [_imgsCell setCellData:@{@"arr":_upimgArr,@"limitCount":@9,@"default":@"",@"colCount":@3,@"hiddenDelBtn":@NO}];
     [_imgsCell fitPublishSecHandDealMode];
     [_imgsCell initAddPhotoManager:9 withImgArr:self.imgArr withVC:self withTableView:self.tableView];
     [_imgsCell.addPhotoManager setCheckDoneCallBack:^(NSDictionary *dic){
          NSMutableArray *arr = dic[@"arr"];
          //        if(weakSelf.imgArr.count > 3)
          //        {
          //            [weakSelf.imgArr removeObjectsInRange:NSMakeRange(3, weakSelf.imgArr.count - 3)];
          //        }
//                  [weakSelf.imgsCell setCellData:@{@"limitCount":@(9),@"arr":arr,@"colCount":@3}];
          //        [self uploadImg:@"0" withImgArr:arr];
          [weakSelf.imgsCell fitPublishSecHandDealMode];
          [weakSelf upImg:arr];

          [weakSelf.tableView reloadData];
     }];
     [_imgsCell setHandleAction:^(NSDictionary *ddic) {
          if([ddic[@"method"] integerValue] == 1)
          {
               [weakSelf.imgsCell  toCheckOption:@{@"count":@(9 -weakSelf.imgArr.count)}];
          }
          else if([ddic[@"method"] integerValue] == 2)
          {
               [weakSelf.imgsCell setupPhotoBrowser:@{@"arr":weakSelf.imgArr,@"row":ddic[@"row"],@"imgArr":ddic[@"imgvs"]}];
          }
          else
          {
               [weakSelf.imgsCell delImg:[ddic[@"row"] integerValue]];
               [weakSelf.upimgArr removeObjectAtIndex:[ddic[@"row"] integerValue]];
               [weakSelf.imgsCell fitPublishSecHandDealMode];
               [weakSelf.tableView reloadData];
          }
     }];
     _textViewCell = [TextViewCanChangeTableViewCell createTableViewCell];
     [_textViewCell setCellData:@{@"placeholder":@"请输入二手物品置换内容",@"text":_content?:@""}];
     [_textViewCell fitPublishSecHandDealMode];

     _submitCell = [OnlyBottomBtnTableViewCell createTableViewCell];
     [_submitCell setCellData:@{@"title":@"发布"}];
     [_submitCell fitEditNickMode];

     [_submitCell setHandleAction:^(id sender) {
          [weakSelf submit];
     }];
     [_tableView reloadData];
}

-(void)titleChange:(UITextField *)tf
{
     NSInteger cc = tf.text.length;
//     NSString *tt = [tf.text substringWithRange:NSMakeRange(0, MIN(cc, 15))];
////     [_titleCell setCellData:@{@"title":tt?:@"",@"detail":[NSString stringWithFormat:@"%ld/15",MIN(cc, 15)]}];
////     [_titleCell fitPublishSecHandMode];
//     _titleCell.textTf.text = tt;
     UILabel *lb = (UILabel *)_titleCell.textTf.rightView;
     lb.text = [NSString stringWithFormat:@"%ld/15",MIN(cc, 15)];
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
          height = 45;
     }
     else if (indexPath.row == 1)
     {
          height = 130;
     }
     else if (indexPath.row == 2)
     {
          height = 46;
     }
     else if (indexPath.row == 3)
     {
          height = 34;
     }
     else if (indexPath.row == 4)
     {
//           NSInteger row = (_upimgArr.count + 3 - 1)/3;
//         NSInteger  _ccHeight = 95;
//          if (__SCREEN_SIZE.width == 320) {
////               _ccWidth = __SCREEN_SIZE.width/3 - 18;
//               _ccHeight = (105 - 5 ) * 0.85 + 10;
//          }
//           height = row * (_ccHeight + 8)+ 5;
//          row * (_ccHeight + 8);
          height = MAX(_imgsCell.height, 100);
     }
     else if (indexPath.row == 5)
     {
          height = 46;
     }
     else
     {
          height = 46;
     }
    return height;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger row = 7;

    return row;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
     if (indexPath.row == 0) {
          cell = _titleCell;
          [_titleCell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(45, 0, 0, 0)];
     }
     else if (indexPath.row == 1)
     {
          cell = _textViewCell;
                 [_textViewCell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(130, 0, 0, 0)];
     }
     else if (indexPath.row == 2)
     {
          cell = _posCell;
                 [_posCell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(46, 0, 0, 0)];
     }
     else if (indexPath.row == 3)
     {
          cell = _imgTipCell;
     }
     else if (indexPath.row == 4)
     {
          cell = _imgsCell;
                 [_imgsCell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(MAX(_imgsCell.height, 100), 0, 0, 0)];
     }
     else if (indexPath.row == 5)
     {
          cell = _setPriceCell;
                 [_setPriceCell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(46, 0, 0, 0)];
     }
     else
     {
          cell = _tipCell;
     }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     if (indexPath.row == 2) {
          SelectAddressViewController *vc = [SelectAddressViewController new];
          vc.canSelect = YES;
          [vc setHandleGoBack:^(NSDictionary *userData) {
                BUUserAddress   *adr = userData[@"address"];
               _address = [NSString stringWithFormat:@"%@%@",adr.address,adr.detail];
               _lat = adr.latitude;
               _lon = adr.longitude;

               _cityName = adr.cityName;
               [_posCell setCellData:@{@"title":_address?:@""}];
               [_posCell fitPublishSecHandModeB];
          }];
          [self.navigationController pushViewController:vc animated:YES];
     }
}

-(void)upImg:(NSArray *)arr
{
     HUDSHOW(@"加载中");
     [busiSystem.agent uploadImgs:arr observer:self callback:@selector(uploadImgsNotification:)];
}

-(void)uploadImgsNotification:(BSNotification *)noti
{
     if (noti.error.code == 0) {
          HUDDISMISS;
          [_upimgArr addObjectsFromArray: busiSystem.agent.imgsList];
          [_tableView reloadData];
     }
     else
     {

          HUDCRY(noti.error.domain, 1);
     }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
     NSLog(@"string:%@ textfield:%@",string,textField.text);


     UILabel *lb = (UILabel *)_titleCell.textTf.rightView;

     if (textField.text.length + string.length > 15 && ![string isEqualToString:@""]) {
          textField.text = [NSString stringWithFormat:@"%@%@",textField.text,[string substringToIndex:MIN(string.length - 1, MAX(15 - textField.text.length - 1, 0))]];
          NSInteger cc = textField.text.length;
          lb.text = [NSString stringWithFormat:@"%ld/15",MIN(cc, 15)];
          return NO;
     }
     return YES;
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
