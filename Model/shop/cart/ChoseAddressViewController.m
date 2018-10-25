//
//  ChoseAddressViewController.m
//  oranllcshoping
//
//  Created by Steve on 2017/7/26.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import "ChoseAddressViewController.h"
#import "ImgAndThreeTitleTableViewCell.h"
#import "EditAddressViewController.h"
#import "BUSystem.h"


@interface ChoseAddressViewController ()
@property (nonatomic,strong) NSIndexPath *selectedIndexPath;
@end

@implementation ChoseAddressViewController

- (void)viewDidLoad {
     [super viewDidLoad];
     // Do any additional setup after loading the view from its nib.
     [self initTableView];
     [self addBottomView];
     self.title = @"选择收货人";
     _selectedIndexPath = [NSIndexPath indexPathForRow:0 inSection:0 ];
     _tableView.dataArr = [NSMutableArray arrayWithArray:busiSystem.agent.userAddresses];
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshAddressList) name:@"RefreshAddressList" object:nil];

}

- (void)didReceiveMemoryWarning {
     [super didReceiveMemoryWarning];
     // Dispose of any resources that can be recreated.
}


-(void)refreshAddressList
{
     [self getAddressList];
}

-(void)getAddressList{
     [busiSystem.agent getUserAddress:busiSystem.agent.userId observer:self callback: @selector(getDeliveryAddressNotification:)];
}



-(void)getDeliveryAddressNotification:(BSNotification *)noti{

     
     if (noti.error.code == 0) {
          _tableView.dataArr = [NSMutableArray arrayWithArray:busiSystem.agent.userAddresses];
          [_tableView reloadData];
     }else{
//          HUDCRY(noti.error.domain, 2);
     }
     
}


-(void)addBottomView{
     
     UIImageView *lineView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, __SCREEN_SIZE.width, 4)];
     lineView.image = [UIImage imageNamed:@"icon_line_address"];
     [self.view addSubview:lineView];
     
     UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, __SCREEN_SIZE.height -NAVBARHEIGHT - TABBARNONEHEIGHT- 52, __SCREEN_SIZE.width, 52)];
     view.backgroundColor = kUIColorFromRGB(color_2);
     [self.view addSubview:view];
     
     
     UIButton *addAddressBtn = [[UIButton alloc]initWithFrame:CGRectMake(15, 9, __SCREEN_SIZE.width-30, 35)];
     addAddressBtn.backgroundColor = kUIColorFromRGB(color_0xf74056);
     [addAddressBtn setTitle:@"添加新收货地址" forState:UIControlStateNormal];
     [addAddressBtn setTitleColor:kUIColorFromRGB(color_2) forState:UIControlStateNormal];
     addAddressBtn.titleLabel.font = [UIFont systemFontOfSize:15];
     [addAddressBtn addTarget:self action:@selector(addAddressAction) forControlEvents:UIControlEventTouchUpInside];
//     addAddressBtn.layer.borderColor = kUIColorFromRGB(color_lineColor).CGColor;
//     addAddressBtn.layer.borderWidth = 0.5;
     addAddressBtn.layer.cornerRadius = addAddressBtn.height/2.0;
//     addAddressBtn.layer.masksToBounds = YES;
     addAddressBtn.layer.shadowColor = kUIColorFromRGB(color_0xf74056).CGColor;
     addAddressBtn.layer.shadowOffset = CGSizeMake(0, 0);
     addAddressBtn.layer.shadowRadius = 8;
     addAddressBtn.layer.shadowOpacity = 0.43;
     [view addSubview:addAddressBtn];
     
    
     
}


-(void)addAddressAction{
//     if (_sumPrice == 0) {
//          TOASTSHOW(@"请选择商品");
//          return;
//     }
     EditAddressViewController *vc = [[EditAddressViewController alloc] initWithNibName:@"JYEditNickNameViewController" bundle:nil];
     vc.mode = 1;
     [self.navigationController pushViewController:vc animated:YES];
//     [vc setHandleGoBack:^(id userData) {
//          HUDSHOW(@"加载中");
//          [self getAddressList];
//     }];
}


-(void)initTableView{
     [ImgAndThreeTitleTableViewCell registerTableViewCell:_tableView];
     
     _tableView.delegate = self;
     _tableView.dataSource = self;
     _tableView.width = __SCREEN_SIZE.width;
     _tableView.height = __SCREEN_SIZE.height - NAVBARHEIGHT  -52 -TABBARNONEHEIGHT - 4;
     _tableView.x = 0;
     _tableView.y = 4;
     _tableView.refreshHeaderView = nil;
     _tableView.backgroundColor = kUIColorFromRGB(color_f8f8f8);
     _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
     return _tableView.dataArr.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
     return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
     ImgAndThreeTitleTableViewCell *cell = [ImgAndThreeTitleTableViewCell dequeueReusableCell:tableView];
     
//     if (indexPath.section == 0) {
//          [cell setCellData:@{@"title":@"大力 180****1849",@"source":@"默认",@"time":@"福建省福州市世纪百联702福建省福州市世纪百联702福建省福州市世纪百联702"}];
//
//     }else{
//          [cell setCellData:@{@"title":@"大力 180****1849",@"time":@"福建省福州市世纪百联702"}];
//
//     }
     BUUserAddress *a = _tableView.dataArr[indexPath.section];
     [cell setCellData:[a getDic:1]];
     if ([_address.addressId isEqualToString:a.addressId]) {
          [cell fitChoseAddressMode:YES];
     }else{
         [cell fitChoseAddressMode:NO];
     }
     
     __weak ChoseAddressViewController *weakSelf = self;
     [cell setHandleAction:^(NSDictionary *dic){
          //编辑地址
          EditAddressViewController *vc = [EditAddressViewController new];
          vc.mode = 0;
          vc.address = a;
          [self.navigationController pushViewController:vc animated:YES];
     }];
     cell.selectionStyle = UITableViewCellSelectionStyleNone;
     return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
     return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
     return 0.001;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
     return 80;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
      BUUserAddress *a = _tableView.dataArr[indexPath.section];
     if (self.handleGoBack) {
          self.handleGoBack(@{@"address":a?:[BUUserAddress new]});
          [self.navigationController popViewControllerAnimated:YES];
     }
}


@end
