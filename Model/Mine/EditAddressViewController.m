//
//  EditAddressViewController.m
//  compassionpark
//
//  Created by air on 2017/3/29.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import "EditAddressViewController.h"
#import "OnlyBottomBtnTableViewCell.h"
#import "OnlyTextViewTableViewCell.h"
#import "TextViewCanChangeTableViewCell.h"
#import "EditAreaViewController.h"
#import "BUSystem.h"
#import "JYCommonTool.h"
//#import "SelectStreetViewController.h"
#import "AddressSelectionViewController.h"
@implementation EditAddressViewController
{
    TitleDetailTableViewCell *_contactCell;
    TitleDetailTableViewCell *_telCell;
    TitleDetailTableViewCell *_houseInfoCell;
    TitleDetailTableViewCell *_addressCell;
    EditAreaViewController *_editAreaVC;
     OnlyBottomBtnTableViewCell *_defaultBtnCell;
     OnlyBottomBtnTableViewCell *_submitCell;
     NSArray *_dataArr;
}


-(id)init
{
     self = [super initWithNibName:@"JYEditNickNameViewController" bundle:nil];
     return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    if (_mode == 0) {
         self.title = @"编辑收货人";
         [self setNavigateRightButton:@"删除" font:[UIFont systemFontOfSize:15] color:kUIColorFromRGB(color_3)];
    }
   else
   {
        self.title = @"新增收货人";
        _address = [BUUserAddress new];
   }
    [self setRightNavBtn];
    [self initTableView];

}


-(void)viewDidAppear:(BOOL)animated
{
    [[_contactCell getTextTf] becomeFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)setRightNavBtn
{
//    [self setNavigateRightButton:@"保存" font:[UIFont systemFontOfSize:15] color:kUIColorFromRGB(color_5)];
}

-(void)handleDidRightButton:(id)sender
{
    [self.view endEditing:YES];
        [[CommonAPI managerWithVC:self] showAlertView:@"删除地址" withMsg:@"是否确认删除该地址" withBtnTitle:@"确认"   withSel:@selector(toDelProcessResult:) withUserInfo:@{}];

     
}
-(void)toDelProcessResult:(NSDictionary *)dic
{
     NSInteger tag = [dic[@"tag"] integerValue];
     if (tag == 100) {
//          NSDictionary *userInfo = dic[@"userInfo"];
//          NSIndexPath *path = userInfo[@"path"];
           [self deleteAddress];
     }
}
-(void)deleteAddress{
     if (_address.addressId.length == 0) {
          return;
     }
//     HUDSHOW(@"提交中");
//     [busiSystem.agent delUserAddress:_address.addressId observer:self callback:@selector(deleteAddressNotification:)];
//     [busiSystem.myPathManager deleAddress:busiSystem.agent.userId withAddressid:_address.addressId  observer:self callback:@selector(deleteAddressNotification:)];
}


-(void)deleteAddressNotification:(BSNotification*)noti
{
     if(noti.error.code == 0)
     {
          
//          HUDSMILE(@"删除成功", 2);
//          [self.navigationController popViewControllerAnimated:YES];
//          if (self.handleGoBack) {
//               self.handleGoBack(@{});
//          }
          
          [[NSNotificationCenter defaultCenter] postNotificationName:@"RefreshAddressList" object:nil];
          [self.navigationController popViewControllerAnimated:YES];
     }
     else
     {
//          HUDCRY(noti.error.domain, 2);
     }
}

-(void)addAddressAction
{
     _address.userName = [_contactCell getTextTf].text;
     _address.tel = [_telCell getTextTf].text;
     _address.floor = [_houseInfoCell getTextTf].text;
     _address.address = [_addressCell getTextTf].text;
     if ([_contactCell getTextTf].text.length == 0) {
//          HUDCRY(@"请填写收货人", 2);
          return;
     }
     
     if (![JYCommonTool isMobileNum:[_telCell getTextTf].text]) {
//          HUDCRY(@"手机号码格式错误，请重新输入", 2);
          return;
     }
     
     if (_address.address.length == 0) {
//          HUDCRY(@"请选择详细地址", 2);
          return;
     }
     
     if ([_houseInfoCell getTextTf].text.length == 0) {
//          HUDCRY(@"请填写楼号-门牌号", 2);
          return;
     }
     NSString *isDefault = @"0";
     if (_address.isDefault == 1) {
          isDefault = @"1";
     }

//     HUDSHOW(@"提交中");
//     NSString *addressStr = [NSString stringWithFormat:@"%@",_address.address];
//     [busiSystem.agent updateUserAddress:_address.addressId?:@"" withContacts:[_contactCell getTextTf].text withTel:[_telCell getTextTf].text withProvinceName:_address.provinceName withCityName:_address.cityName withAreaName:_address.areaName withAddress:addressStr withIsDefault:isDefault withLongitude:_address.longitude withLatitude:_address.latitude detail:[_houseInfoCell getTextTf].text observer:self callback:@selector(updateUserAddressNotification:)];
     [busiSystem.agent addandUpAddress:busiSystem.agent.userId?:@"" withCityid:_address.cityId?:@"" withUsername:_address.userName?:@"" withAddressid:_address.addressId?:@"" withProvinceid:_address.provinceId?:@"" withAreaid:_address.areaId?:@"" withAddress:_address.address?:@"" withFloor:_address.floor?:@"" withIsdefault:isDefault withTel:_address.tel?:@"" observer:self  callback:@selector(updateUserAddressNotification:)];
//     if (self.mode == 0) {
//          [busiSystem.userManager updateDeliveryAddress:busiSystem.agent.userId delName:[_contactCell getTextTf].text mobile:[_telCell getTextTf].text delCity:_address.cityName delAddress:_address.delAddress delBuildingNo:[_houseInfoCell getTextTf].text longitude:[NSString stringWithFormat:@"%f",_address.longitude ] latitude:[NSString stringWithFormat:@"%f",_address.latitude ] isDefault:isDefault delId:_address.delId observer:self callback:@selector(updateUserAddressNotification:)];
//     }else{
////          [busiSystem.userManager addDeliveryAddress:busiSystem.agent.userId delName:[_contactCell getTextTf].text mobile:[_telCell getTextTf].text delCity:_address.delCity delAddress:_address.delAddress delBuildingNo:[_houseInfoCell getTextTf].text longitude:[NSString stringWithFormat:@"%f",_address.longitude ] latitude:[NSString stringWithFormat:@"%f",_address.latitude ] isDefault:isDefault observer:self callback:@selector(updateUserAddressNotification:)];
//     }
     
}

-(void)updateUserAddressNotification:(BSNotification*)noti
{
    if(noti.error.code == 0)
    {
        
        if(_mode == 0)
        {
//          HUDSMILE(@"编辑成功", 2);
        }
        else
        {
//            HUDSMILE(@"添加成功", 2);
        }
         
         if (self.handleGoBack) {
              self.handleGoBack(@{});
         }
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"RefreshAddressList" object:nil];
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
//        HUDCRY(noti.error.domain, 2);
    }
}

-(void)initTableView
{
    self.tableView.refreshHeaderView = nil;
    self.tableView.backgroundColor = kUIColorFromRGB(color_0xf0f0f0);
    _contactCell = [TitleDetailTableViewCell createTableViewCell];
    [_contactCell setCellData:@{@"title":@"联系人",@"detail":_address.userName?:@"",@"placeholder":@"输入联系人姓名"}];
     [_contactCell fitEditAddressMode];
//    _provinceId = self.userInfo[@"provinceId"];
//      _provinceName = self.userInfo[@"provinceName"];
//
//    _cityId = self.userInfo[@"cityId"];
//    _cityName = self.userInfo[@"cityName"];
//
//    _areaId = self.userInfo[@"areaId"];
//    _areaName = self.userInfo[@"areaName"];
//
    
    _telCell = [TitleDetailTableViewCell createTableViewCell];
    [_telCell setCellData:@{@"title":@"手机号码",@"detail":_address.tel?:@"",@"placeholder":@"输入手机号码"}];
    [_telCell fitEditAddressMode];
    [_telCell getTextTf].keyboardType = UIKeyboardTypePhonePad;
     
     _houseInfoCell = [TitleDetailTableViewCell createTableViewCell];
     [_houseInfoCell setCellData:@{@"title":@"楼号-门牌号",@"detail":_address.floor?:@"",@"placeholder":@"例：5号楼501室"}];
     [_houseInfoCell fitEditAddressMode];

    _areaCell = [TitleDetailTableViewCell createTableViewCell];
     NSString *city = @"选择所在城市";
     if (_mode == 0) {
          city  = [NSString stringWithFormat:@"%@%@%@",_address.provinceName,_address.cityName,_address.areaName];
     }
    
     [_areaCell setCellData:@{@"title":@"所在城市",@"detail":city,@"placeholder":@"小区、街道、写字楼"}];
    if (_mode == 1) {
        [_areaCell fitPersonModeEdit:kUIColorFromRGB(color_8)];
    }
    else
    {
        [_areaCell fitPersonModeEdit:kUIColorFromRGB(color_1)];
    }
    
    _addressCell = [TitleDetailTableViewCell createTableViewCell];
     [_addressCell setCellData:@{@"title":@"详细地址",@"detail":_address.address?:@""}];
    [_addressCell fitEditAddressMode];

//     if (_mode == 1) {
//          [_addressCell fitPersonModeEdit:kUIColorFromRGB(color_8)];
//     }
//     else
//     {
//          [_addressCell fitPersonModeEdit:kUIColorFromRGB(color_1)];
//     }
//     [_addressCell getTextTf].userInteractionEnabled = NO;

     
     _defaultBtnCell = [OnlyBottomBtnTableViewCell createTableViewCell];
       [_defaultBtnCell setCellData:@{@"title":@"设为默认收货地址"}];
     [_defaultBtnCell fitAddressManagerModeA:_address.isDefault];
     __weak EditAddressViewController *weakSelf = self;
     [_defaultBtnCell setHandleAction:^(NSDictionary *dic){
          UIButton *btn = dic[@"obj"];
          btn.customImgV.highlighted = !btn.customImgV.highlighted;
          weakSelf.address.isDefault = btn.customImgV.highlighted;
     }];
     _submitCell = [OnlyBottomBtnTableViewCell createTableViewCell];
     [_submitCell setCellData:@{@"title":@"保存收货地址"}];
      [_submitCell fitAddressManagerModeB];
     [_submitCell setHandleAction:^(id sender) {
          [weakSelf addAddressAction];
     }];
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger row = 7;
    
    
    return row;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    
    return 0.001;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.001;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 41;
    if (indexPath.row == 5) {
        height = 31;
    }
     else if (indexPath.row == 6)
     {
          height = 105;
     }
    return height;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    if (indexPath.row == 0) {
        cell = _contactCell;
          [_contactCell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(41, 0, 0, 0)];
    }
    else if (indexPath.row == 1)
    {
        cell = _telCell;
          [_telCell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(41, 0, 0, 0)];
    }
    else if (indexPath.row == 2)
    {
         cell = _areaCell;
         [_areaCell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(41, 0, 0, 0)];
    }
    else if (indexPath.row == 3)
    {
        cell = _addressCell;
          [_addressCell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(41, 0, 0, 0)];
    }
    else if (indexPath.row == 4)
    {
        cell = _houseInfoCell;
         [_houseInfoCell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(41, 0, 0, 0)];
    }
     else if(indexPath.row == 5)
     {
     
          cell = _defaultBtnCell;
     }
     else
     {
          cell = _submitCell;
     }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ( indexPath.row == 2) {
        __weak EditAddressViewController *weakSelf = self;
        [self.view endEditing:YES];
//         SelectStreetViewController *vc = [SelectStreetViewController new];
//         [self.navigationController pushViewController:vc animated:YES];
//        [vc setHandleGoBack:^(NSDictionary *dic) {
//             BUMapAddress *adr = dic[@"address"];
//             weakSelf.address.provinceName = adr.province;
//             weakSelf.address.areaName = adr.area;
//             weakSelf.address.cityName = adr.city;
//             weakSelf.address.address = adr.street;
//             weakSelf.address.latitude = adr.lat ;
//             weakSelf.address.longitude = adr.Lon ;
////             weakSelf.address.delCity = adr.city;
//             NSString *city  = [NSString stringWithFormat:@"%@%@%@",_address.provinceName,_address.cityName,_address.areaName];
//             [weakSelf.areaCell setCellData:@{@"title":@"所在地区",@"detail":city}];
//            [weakSelf.areaCell fitPersonModeEdit:kUIColorFromRGB(color_1)];
//             [_addressCell setCellData:@{@"title":@"详细地址",@"detail":_address.address?:@"小区、街道、写字楼"}];
//             [_addressCell fitPersonModeEdit:kUIColorFromRGB(color_1)];
//
//        }];
         if (1)
         {
//              HUDSHOW(@"加载中");
              [self getProvinlist];
         }
         else
         {
//              _dataArr = [NSArray arrayWithArray:busiSystem.myPathManager.getProvinlist];
//              _dataArr = [BUGetProvinlist getFitSelectionArr:_dataArr];
       AddressSelectionViewController *vc = [AddressSelectionViewController  toAddressSelectionVC:_dataArr];
              [vc setHandleAction:^(NSDictionary *dic) {
                   NSString *city = [NSString stringWithFormat:@"%@%@%@",dic[@"title1"],dic[@"title2"],dic[@"title3"]];
                   [_areaCell setCellData:@{@"title":@"所在城市",@"detail":city}];
              [_areaCell fitPersonModeEdit:kUIColorFromRGB(color_1)];
                   _address.cityId = dic[@"id2"];
                   _address.areaId = dic[@"id3"];
                   _address.provinceId = dic[@"id1"];
              }];
         }
    }
}

-(void)getAreaData
{
//busiSystem.agent get
}
-(void)getProvinlist
{
//     [busiSystem.myPathManager getProvinlist:self callback:@selector(getProvinlistNotification:)];
}

-(void)getProvinlistNotification:(BSNotification *)noti
{
     if (noti.error.code == 0) {
//          HUDDISMISS;
//          _dataArr = [NSArray arrayWithArray:busiSystem.myPathManager.getProvinlist];
//          _dataArr = [BUGetProvinlist getFitSelectionArr:_dataArr];
          AddressSelectionViewController *vc = [AddressSelectionViewController  toAddressSelectionVC:_dataArr];
          [vc setHandleAction:^(NSDictionary *dic) {
               NSString *city = [NSString stringWithFormat:@"%@%@%@",dic[@"title1"],dic[@"title2"],dic[@"title3"]];
               [_areaCell setCellData:@{@"title":@"所在城市",@"detail":city}];

                    [_areaCell fitPersonModeEdit:kUIColorFromRGB(color_1)];

               _address.cityId = dic[@"id2"];
               _address.areaId = dic[@"id3"];
               _address.provinceId = dic[@"id1"];
          }];
     }
     else
     {
          
//          HUDCRY(noti.error.domain, 1);
     }
}
@end
