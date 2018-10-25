//
//  HeadSelectAddressViewController.m
//  supermarket
//
//  Created by Steve on 2017/11/23.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import "HeadSelectAddressViewController.h"
#import "ImgAndThreeTitleTableViewCell.h"
#import "BUSystem.h"
#import "OnlyTitleTableViewCell.h"
#import "EditAddressViewController.h"
#import "SelectStreetViewController.h"
#import "LoginViewController.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapSearchKit/AMapSearchKit.h>
#import <AMapLocationKit/AMapLocationKit.h>

@interface HeadSelectAddressViewController ()<UISearchBarDelegate,AMapLocationManagerDelegate,CLLocationManagerDelegate,MAMapViewDelegate>
{
     ImgAndThreeTitleTableViewCell *_addressCell;
     OnlyTitleTableViewCell *_titleCell;
     UIView *_footView;
     UIButton *_addAddressBtn;
     NSInteger _requestCount;
}
@property (nonatomic,strong) BUMapAddress *address;
@end

@implementation HeadSelectAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
     self.title = @"选择收货地址";
     [self initTableView];
     _searBar.delegate = self;
//     HUDSHOW(@"加载中");
      [self locate];
     if (busiSystem.agent.isLogin) {
          [self addAddressBtn];
          [self getData];
         
     }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
     
}



- (void)locate{
     _requestCount++;
     AMapLocationManager *locationManager = [AMapLocationManager new];
     // 带逆地理信息的一次定位（返回坐标和地址信息）
     [locationManager setDesiredAccuracy:kCLLocationAccuracyHundredMeters];
     //   定位超时时间，最低2s，此处设置为10s
     locationManager.locationTimeout = 10;
     //   逆地理请求超时时间，最低2s，此处设置为10s
     locationManager.reGeocodeTimeout = 10;
     
     // 带逆地理（返;回坐标和地址信息）。将下面代码中的 YES 改成 NO ，则不会返回地址信息。
     [locationManager requestLocationWithReGeocode:YES completionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
          _requestCount--;
          if (error)
          {
               NSLog(@"locError:{%ld - %@};", (long)error.code, error.localizedDescription);
//               HUDCRY(@"定位失败", 2);
               return;
//               if (error.code == AMapLocationErrorLocateFailed)
//               {
//                    HUDCRY(error.localizedDescription, 2);
//                    return;
//               }
          }
          if (_requestCount == 0) {
//               HUDDISMISS;
          }
          
          if (regeocode)
          {
               NSLog(@"reGeocode:%@", regeocode);
               _address.Lon = [NSString stringWithFormat:@"%f",location.coordinate.longitude];
               _address.lat = [NSString stringWithFormat:@"%f",location.coordinate.latitude];
               _address.city = regeocode.city;
               _address.province = regeocode.province;
               _address.district = regeocode.district;
               _address.street = regeocode.street;
               _address.address = regeocode.formattedAddress;
               [_addressCell setCellData:@{@"title":@"当前位置",@"source":self.address.street?:@"",@"time":@"重新定位",@"img":@"location"}];
               [_addressCell fitSelectAddressMode];
          }
     }];
}

-(BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
     SelectStreetViewController *vc = [SelectStreetViewController new];
     vc.isCheck = YES;
     [self.navigationController pushViewController:vc animated:YES];
     __weak HeadSelectAddressViewController *weakSelf = self;
     [vc setHandleGoBack:^(NSDictionary *dic) {
          weakSelf.address = dic[@"address"];
          [_addressCell setCellData:@{@"title":@"当前位置",@"source":weakSelf.address.street?:@"",@"time":@"重新定位",@"img":@"location"}];
          [_addressCell fitSelectAddressMode];
     }];
     return NO;
}

-(void)getData{
//     HUDSHOW(@"加载中");
     _requestCount ++;
//     [busiSystem.userManager getDeliveryAddressList:busiSystem.agent.userId observer:self callback:@selector(getDeliveryAddressNotification:)];
}

-(void)getDeliveryAddressNotification:(BSNotification *)noti
{
     _requestCount -- ;
     if (noti.error.code == 0) {
          if (_requestCount == 0) {
//               HUDDISMISS;
          }
          
//          _tableView.dataArr = [NSMutableArray arrayWithArray:busiSystem.userManager.addressList];
          [_tableView reloadData];
     }
     else
     {
//          HUDCRY(noti.error.domain, 2);
     }
}


-(void)addAddressBtn{
     _addAddressBtn = [[UIButton alloc]initWithFrame:CGRectMake(55, __SCREEN_SIZE.height-64-45+8, __SCREEN_SIZE.width-55*2, 30)];
     _addAddressBtn.layer.cornerRadius = 6.0;
     _addAddressBtn.layer.masksToBounds = YES;
     [_addAddressBtn setTitle:@"新建地址" forState:UIControlStateNormal];
     [_addAddressBtn setTitleColor:kUIColorFromRGB(color_2) forState:UIControlStateNormal];
     _addAddressBtn.backgroundColor = kUIColorFromRGB(color_3);
     [_addAddressBtn addTarget:self action:@selector(addAddressBtnAction:) forControlEvents:UIControlEventTouchUpInside];
     [self.view addSubview:_addAddressBtn];
}

-(void)addAddressBtnAction:(UIButton *)sender{
     EditAddressViewController *vc = [EditAddressViewController new];
     vc.mode = 1;
     [self.navigationController pushViewController:vc animated:YES];
     __weak HeadSelectAddressViewController *weakSelf = self;
     [vc setHandleGoBack:^(id userData) {
          [weakSelf getData];
     }];
}

-(void)initTableView{
     
     __weak HeadSelectAddressViewController *weakSelf = self;
     
     
    
     _addressCell = [ImgAndThreeTitleTableViewCell createTableViewCell];
     [_addressCell setCellData:@{@"title":@"当前位置",@"source":@"",@"time":@"重新定位",@"img":@"location"}];
     [_addressCell fitSelectAddressMode];
     [_addressCell setHandleAction:^(id sender) {
          SelectStreetViewController *vc = [SelectStreetViewController new];
          vc.isCheck = YES;
          [weakSelf.navigationController pushViewController:vc animated:YES];
          [vc setHandleGoBack:^(NSDictionary *dic) {
               weakSelf.address = dic[@"address"];
               [_addressCell setCellData:@{@"title":@"当前位置",@"source":weakSelf.address.address?:@"",@"time":@"重新定位",@"img":@"location"}];
               [_addressCell fitSelectAddressMode];
          }];
     }];
     
     _titleCell = [OnlyTitleTableViewCell createTableViewCell];
     [_titleCell setCellData:@{@"title":@"我的收货地址"}];
     [_titleCell fitSelectAddressMode];
     
     [ImgAndThreeTitleTableViewCell registerTableViewCell:_tableView];
     
     _tableView.delegate = self;
     _tableView.dataSource = self;
     _tableView.width = __SCREEN_SIZE.width;
     if (busiSystem.agent.isLogin) {
          _tableView.height = __SCREEN_SIZE.height - 64-56-45;
     }else
          _tableView.height = __SCREEN_SIZE.height - 64-56;
     
     _tableView.x = 0;
     _tableView.y = 56;
     _tableView.refreshHeaderView = nil;
     _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
     _tableView.backgroundColor = kUIColorFromRGB(color_4);
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
     if (!busiSystem.agent.isLogin) {
          return 1;
     }
     return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
     NSInteger row = 1;
     if (section == 1){
          row = _tableView.dataArr.count+1;
     }
     return row;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
     UITableViewCell *cell;
     if (indexPath.section == 0) {
          cell = _addressCell;
          [(JYAbstractTableViewCell *)cell showSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(55, 0, 0, 0)];
     }
     else if (indexPath.section == 1) {

          if (indexPath.row == 0) {
               cell = _titleCell;
          }else{
               cell = [ImgAndThreeTitleTableViewCell dequeueReusableCell:tableView];
               BUAddress *address = _tableView.dataArr[indexPath.row-1];
               [(ImgAndThreeTitleTableViewCell *)cell setCellData:[address getDic:1]];
               [(ImgAndThreeTitleTableViewCell *)cell fitSelectAddressModeA];
               [(ImgAndThreeTitleTableViewCell *)cell setHandleAction:^(id sender) {
                    EditAddressViewController *vc = [EditAddressViewController new];
                    vc.mode = 0;
                    vc.address = address;
                    [self.navigationController pushViewController:vc animated:YES];
                    __weak HeadSelectAddressViewController *weakSelf = self;
                    [vc setHandleGoBack:^(id userData) {
//                         HUDSHOW(@"加载中");
                         [weakSelf getData];
                    }];
               }];
                [(JYAbstractTableViewCell *)cell showSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(55, 0, 0, 0)];
          }

     }
     cell.selectionStyle = UITableViewCellSelectionStyleNone;
     return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{

     if (!busiSystem.agent.isLogin && section == 0) {
          return 250;
     }
     return 10;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
     if (!busiSystem.agent.isLogin && section == 0) {
          if (!_footView) {
               _footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, __SCREEN_SIZE.width, 250)];
               _footView.backgroundColor = kUIColorFromRGB(color_4);
               
               UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(__SCREEN_SIZE.width/2.0 - 64/2.0, 80, 64, 64)];
               img.image = [UIImage imageNamed:@"icon_lock"];
               [_footView addSubview:img];
               
               UILabel *label = [UILabel new];
               label.x = 15;
               label.y = img.y + img.height +15;
               label.height = 13;
               label.width = __SCREEN_SIZE.width - 30;
               label.text = @"登录后可查看收货地址";
               label.font = [UIFont systemFontOfSize:12];
               label.textColor = kUIColorFromRGB(color_1);
               label.textAlignment = NSTextAlignmentCenter;
               [_footView addSubview:label];
               
               UIButton *btn = [UIButton new];
               btn.y = label.y + label.height +20;
               btn.height = 30;
               btn.width = 155;
               btn.x = __SCREEN_SIZE.width/2.0 - btn.width/2.0;
               [btn setTitleColor:kUIColorFromRGB(color_2) forState:UIControlStateNormal];
               [btn setTitle:@"去登录" forState:UIControlStateNormal];
               btn.titleLabel.font = [UIFont systemFontOfSize:16];
               btn.backgroundColor = kUIColorFromRGB(color_3);
               btn.layer.cornerRadius = 6.0;
               btn.layer.masksToBounds = YES;
               [btn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
               [_footView addSubview:btn];
          }
          return _footView;
     }
     return nil;
}

-(void)btnAction{
     [LoginViewController toLogin:self];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
     return  0.001;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
     CGFloat height = 55;
     if (indexPath.section == 1) {
          if (indexPath.row == 0) {
               height = 22;
          }else
               height = 55;
          
     }
     return height;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
     [self.view endEditing:YES];
     BUAddress *address;
     if (indexPath.section == 0) {
          address = [BUAddress new];
          address.delCity = _address.city;
          address.delAddress = _address.street;
          address.latitude = [_address.lat floatValue];
          address.longitude = [_address.Lon floatValue];
          busiSystem.agent.log = _address.Lon;
          busiSystem.agent.lat = _address.lat;
          [self.navigationController popViewControllerAnimated:YES];
          busiSystem.agent.address = address;
          if (self.handleGoBack) {
               self.handleGoBack(@{@"obj":address?:[BUAddress new]});
          }
     }else{
          if (indexPath.row == 0) {
               address = _tableView.dataArr[0];
          }else{
               address = _tableView.dataArr[indexPath.row - 1];
          }
          [self validateAddress:address];
     }
     
}


-(void)validateAddress:(BUAddress *)address{
//     HUDSHOW(@"加载中");
     NSString *log = [NSString stringWithFormat:@"%f",address.longitude];
     NSString *lat = [NSString stringWithFormat:@"%f",address.latitude];
//     [busiSystem.userManager validateAddress:busiSystem.agent.storeId log:log lat:lat observer:self callback:@selector(validateAddressNotification:) extraInfo:@{@"obj":address?:[BUAddress new]}];
}


-(void)validateAddressNotification:(BSNotification *)noti
{

     if (noti.error.code == 0) {
//          HUDDISMISS;
          [self.navigationController popViewControllerAnimated:YES];
          BUAddress *address = noti.extraInfo[@"obj"];
          NSString *log = [NSString stringWithFormat:@"%f",address.longitude];
          NSString *lat = [NSString stringWithFormat:@"%f",address.latitude];
          busiSystem.agent.log = log;
          busiSystem.agent.lat = lat;
          busiSystem.agent.address = address;
          if (self.handleGoBack) {
               self.handleGoBack(@{@"obj":address?:[BUAddress new]});
          }
     }
     else
     {
//          HUDCRY(noti.error.domain, 2);
     }
}


@end
