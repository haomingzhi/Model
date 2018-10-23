//
//  SelectAddressViewController.m
//  chenxiaoer
//
//  Created by air on 16/3/10.
//  Copyright © 2016年 ORANLLC_IOS1. All rights reserved.
//

#import "SelectAddressViewController.h"
#import "BUSystem.h"
#import "AddressTableViewCell.h"
//#import "AddNewAddressViewController.h"
#import "JYNoDataManager.h"
//#import "TwoTabsTableViewCell.h"
#import "ThreeBtnTableViewCell.h"
#import "EditAddressViewController.h"
@interface SelectAddressViewController ()
{
    

    IBOutlet UIButton *_addBtn;
    NSIndexPath *_checkIndexPath;
}
@property(nonatomic,strong) IBOutlet MyTableView *tableView;
@end

@implementation SelectAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    _addBtn.layer.cornerRadius = 8;
//    _addBtn.layer.masksToBounds = YES;
//    _addBtn.backgroundColor = kUIColorFromRGB(color_3);
//     _addBtn.x = 55;
//     _addBtn.width = __SCREEN_SIZE.width - 110;
//     _addBtn.height = 35;
//    [_addBtn setTitleColor:kUIColorFromRGB(color_2) forState:UIControlStateNormal];
//     _addBtn.hidden = YES;
    self.title = @"地址管理";
      _checkIndexPath = [NSIndexPath indexPathForRow:1 inSection:0];
    [self initTableView];
//    [self getDataFromList];
//    self.view.backgroundColor = kUIColorFromRGB(color_4);
    //    JYWAITSHOW(@"正在加载",self.view);
    HUDSHOW(@"加载中");
    [self getData];
    //    [self initFpsLb];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshAddressList) name:@"RefreshAddressList" object:nil];
     
     [self addBottomView];
//     [self setNavigateRightButton:@"新增" font:[UIFont systemFontOfSize:15] color:kUIColorFromRGB(color_1)];
}


-(void)addBottomView{

//     UIImageView *lineView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, __SCREEN_SIZE.width, 4)];
//     lineView.image = [UIImage imageNamed:@"icon_line_address"];
//     [self.view addSubview:lineView];
//
     UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, __SCREEN_SIZE.height -NAVBARHEIGHT- 52-TABBARNONEHEIGHT, __SCREEN_SIZE.width, 52)];
     view.backgroundColor = kUIColorFromRGB(color_2);
     [self.view addSubview:view];
     view.height = TABHEIGHT + 8;
     
     self.view.backgroundColor = kUIColorFromRGB(color_2);
//
//
//     UIButton *addAddressBtn = [[UIButton alloc]initWithFrame:CGRectMake(55, 7.5, __SCREEN_SIZE.width-55*2, 30)];
     _addBtn.y = 9;
     _addBtn.backgroundColor = kUIColorFromRGB(color_0xf82D45);
     [_addBtn setTitle:@"添加新收货地址" forState:UIControlStateNormal];
     [_addBtn setTitleColor:kUIColorFromRGB(color_2) forState:UIControlStateNormal];
     _addBtn.titleLabel.font = [UIFont systemFontOfSize:16];
//     [addAddressBtn addTarget:self action:@selector(addAddressAction) forControlEvents:UIControlEventTouchUpInside];
     //     addAddressBtn.layer.borderColor = kUIColorFromRGB(color_lineColor).CGColor;
     //     addAddressBtn.layer.borderWidth = 0.5;
     _addBtn.width = __SCREEN_SIZE.width - 30;
     _addBtn.backgroundColor = kUIColorFromRGB(color_0xf82D45);
     _addBtn.layer.shadowRadius = 8.0;
     _addBtn.layer.shadowOpacity = 0.43;
     _addBtn.layer.shadowOffset = CGSizeMake(0,0);
     _addBtn.layer.shadowColor = kUIColorFromRGB(color_0xf82D45).CGColor;
     _addBtn.height = 36;
     _addBtn.x = 15;
     _addBtn.layer.cornerRadius = _addBtn.height/2.0;
     [view addSubview:_addBtn];

//     _addBtn.y = __SCREEN_SIZE.height - NAVBARHEIGHT - TABBARNONEHEIGHT - _addBtn.height;

}

-(void)viewDidLayoutSubviews
{
//     NSInteger idd = NAVBARHEIGHT;
//     if ([busiSystem.agent.userId isEqualToString:_secondHandGoods.userId]) {
//          _tableView.height = __SCREEN_SIZE.height - idd;
//          _tableView.width = __SCREEN_SIZE.width;
//     }
//     else
//     {
          _tableView.height = __SCREEN_SIZE.height   - NAVBARHEIGHT;
          _tableView.width = __SCREEN_SIZE.width;
//     }
}
-(void)viewWillAppear:(BOOL)animated
{
     self.panGesture.enabled = NO;
}

-(void)viewWillDisappear:(BOOL)animated
{
     self.panGesture.enabled = YES;
}


-(void)handleDidRightButton:(id)sender{
     EditAddressViewController *vc = [[EditAddressViewController alloc] initWithNibName:@"JYEditNickNameViewController" bundle:nil];
     vc.mode = 1;
     [self.navigationController pushViewController:vc animated:YES];
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


-(void)refreshAddressList
{
    [self getData];
}

-(void)getData
{
    [busiSystem.agent getUserAddress:busiSystem.agent.userId?:@"" observer:self callback:@selector(getUserAddressNotification:)];
//     [busiSystem.userManager getDeliveryAddressList:busiSystem.agent.userId observer:self callback:@selector(getUserAddressNotification:)];
}


-(void)getUserAddressNotification:(BSNotification *)noti
{
    if (noti.error.code ==0) {
        
        HUDDISMISS;
       NSMutableArray *arr = [NSMutableArray arrayWithArray:busiSystem.agent.userAddresses];
        _tableView.dataArr = arr;
//        [[JYNoDataManager manager] addNodataView:_tableView withTip:@"暂无数据" withImg:@"" withCount:arr.count];
        [_tableView reloadData];
             if (_tableView.dataArr.count == 0) {
                 [[JYNoDataManager manager] addNodataView:_tableView withTip:@"暂无信息" withImg:@"nodata" withCount:_tableView.dataArr.count withTag:[NSString stringWithFormat:@"ssavc%d",0]];
                 [[JYNoDataManager manager] fitModeY:150];
             }
             else
             {
                 [[JYNoDataManager manager] dismiss];
                 
             }
        }
    else
    {
         HUDCRY(noti.error.domain, 2);
       
    }
    
}


-(MyTableView *)myTableView
{
    return _tableView;
}



-(void)initTableView
{
    //    _tableView.refreshFooterView = nil;
    _tableView.refreshHeaderView = nil;
    [self initTableViewCell];
    
    _tableView.backgroundColor = kUIColorFromRGB(color_0xf0f0f0);
    _tableView.delegate = self;
    _tableView.dataSource = self;
     _tableView.height  = __SCREEN_SIZE.height - NAVBARHEIGHT - TABBARNONEHEIGHT-52;
     _tableView.width = __SCREEN_SIZE.width;
     
//    _tableView.backgroundColor = kUIColorFromRGB(color_4);
//    _tableView.separatorColor = [UIColor lightGrayColor];
}

//-(void)viewDidLayoutSubviews
//{
//    _tableView.width = __SCREEN_SIZE.width;
//    _tableView.height = __SCREEN_SIZE.height - 64;
//}

-(void)initTableViewCell
{
    [self.myTableView registerNib:[UINib nibWithNibName:@"AddressTableViewCell" bundle:nil] forCellReuseIdentifier:@"AddressTableViewCell"];
    [ThreeBtnTableViewCell registerTableViewCell:_tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
     return _tableView.dataArr.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
     CGFloat height = 81;
    return height;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{

    return 10;
}

//-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
//{
////    UIView *v = [UIView new];
////    v.backgroundColor = kUIColorFromRGB(color_9);
//            return  [self createSectionFootView];;
//
//}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
     if (section == 0) {
          return 4;
     }
    return 0.01;
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

-(UIView *)createSectionHeadView
{
     UIView *v = [UIView new];
     v.height = 4;
     UIImageView *iv = [UIImageView new];
     iv.height = 4;
     iv.width = __SCREEN_SIZE.width;
     iv.image = [UIImage imageContentWithFileName:@"addressLine"];
     [v addSubview:iv];
     return v;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
     if (section == 0) {
          return   [self createSectionHeadView];
     }
     return nil;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    cell  = [self createTableCellArr:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


-(void)didSelectCell:(NSIndexPath *)indexPath
{
      BUUserAddress *adr = _tableView.dataArr[indexPath.section];
    EditAddressViewController *vc = [[EditAddressViewController alloc] initWithNibName:@"JYEditNickNameViewController" bundle:nil];
     vc.userInfo = @{@"id":adr.addressId,@"isDefault":[NSString stringWithFormat:@"%ld",adr.isDefault],@"phone":adr.tel?:@"",@"address":adr.address?:@"",@"area":[NSString stringWithFormat:@"%@ %@ %@",adr.provinceName?:@"",adr.cityName?:@"",adr.areaName?:@""],@"name":adr.userName?:@"" ,@"provinceName":adr.provinceName?:@"",@"cityName":adr.cityName?:@"",@"areaName":adr.areaName?:@"",@"provinceId":[NSString stringWithFormat:@"%@",adr.provinceId],@"cityId":[NSString stringWithFormat:@"%ld",adr.cityId],@"areaId":[NSString stringWithFormat:@"%ld",adr.areaId] };
    [self.navigationController pushViewController:vc animated:YES];
}

-(UITableViewCell *)createTableCellArr:(NSIndexPath *)indexPath
{
    UITableViewCell * cell;
    cell = [self createTableViewCellData:indexPath];
    return cell;
}



-(UITableViewCell *)createTableViewCellData:(NSIndexPath *)indexPath
{
    __weak SelectAddressViewController *weakSelf = self;
     BUUserAddress *adr = _tableView.dataArr[indexPath.section];
    UITableViewCell *cell;
//    if(indexPath.row == 0)
//    {
    cell = [_tableView dequeueReusableCellWithIdentifier:@"AddressTableViewCell"];
     NSDictionary *dic = [adr getDic:0];//@{@"name":[NSString stringWithFormat:@"%@",@"大力 180****1849"],@"phone":@"",@"address":@"福建省福州市世纪百联702"};
         [(AddressTableViewCell*)cell setCellData:dic];
         BOOL isc = adr.isDefault == 1?YES:NO;
       [(AddressTableViewCell*)cell fitAddressMode:isc];
         [(AddressTableViewCell*)cell setHandleAction:^(NSDictionary *dic) {
              if ([dic[@"index"] integerValue]==2) {
                   //编辑地址
                   EditAddressViewController *vc = [EditAddressViewController new];
                   vc.mode = 0;
                   vc.address = adr;
                   [self.navigationController pushViewController:vc animated:YES];
                   
              }else{
                   //设置默认
                   [weakSelf setDefaultAddress:adr];
              }
         }];
//       [(AddressTableViewCell*)cell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(100, 0, 0, 0)];

//    }
//    else
//    {
//         cell =  [ThreeBtnTableViewCell dequeueReusableCell:_tableView];
//        [(ThreeBtnTableViewCell*)cell setCellData:@{@"oneTitle":@"设为默认",@"twoTitle":@"编辑",@"row":@(indexPath.section),@"threeTitle":@"删除",@"aimg":@"unCheck2",@"bimg":@"adr_edit",@"cimg":@"adr_del",@"checkImg":@"check"}];
//        if (indexPath.section == _checkIndexPath.section) {
//           [(ThreeBtnTableViewCell*)cell fitCheckAddressMode:YES];
//
//        }
//        else
//        {
//            [(ThreeBtnTableViewCell*)cell fitCheckAddressMode:NO];
//        }
//        [(ThreeBtnTableViewCell*)cell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(35, 0, 0, 0)];
//
//         __weak ThreeBtnTableViewCell*wcc = cell;
//         [(ThreeBtnTableViewCell*)cell setHandleAction:^(NSDictionary *dic){
//              UIButton *btn = dic[@"sender"];
//              NSInteger index = btn.tag - 101;
//              if (index == 0) {
//                   [weakSelf selectCell:indexPath];
//              }
//              else if (index == 1)
//              {
//                   EditAddressViewController *vc = [EditAddressViewController new];
//                   vc.mode = 1;
//                   [self.navigationController pushViewController:vc animated:YES];
//              }
//         }];
//
//    }

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//     [self selectCell:indexPath];
     if (_canSelect) {
          if (self.handleGoBack) {
//               BUUserAddress *address = _tableView.dataArr[indexPath.section];
//               self.handleGoBack(@{@"address":address});
          }
          [self.navigationController popViewControllerAnimated:YES];
     }
}
-(void)selectCell:(NSIndexPath *)indexPath
{
       ThreeBtnTableViewCell *fcell = [self.tableView cellForRowAtIndexPath:indexPath];
     UIButton *btn = [fcell viewWithTag:101];
     BOOL b = btn.isSelected;
     [fcell fitCheckAddressMode:!b];
     
     ThreeBtnTableViewCell *ffcell = [self.tableView cellForRowAtIndexPath:_checkIndexPath];
     UIButton *bbtn = [ffcell viewWithTag:101];
     BOOL bc = bbtn.isSelected;
     [ffcell fitCheckAddressMode:!bc];
     
     
     UITableViewCell *cscell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:_checkIndexPath.section]];
//     [(AddressTableViewCell*)cscell setCellData:@{@"name":[NSString stringWithFormat:@"%@",@"大力"],@"phone":@"180****1849",@"address":@"福建省福州市世纪百联702"}];
     BOOL issc = NO;
     [(AddressTableViewCell*)cscell fitCheckAddressMode:issc];
     _checkIndexPath = indexPath;
     UITableViewCell *scell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:indexPath.section]];
//     [(AddressTableViewCell*)scell setCellData:@{@"name":[NSString stringWithFormat:@"%@",@"大力"],@"phone":@"180****1849",@"address":@"福建省福州市世纪百联702"}];
     BOOL isc = YES;
     [(AddressTableViewCell*)scell fitCheckAddressMode:isc];
}

-(void)setDefaultAddress:(BUUserAddress *)addre
{
     if (addre.isDefault == 1) {
          return;
     }
    HUDSHOW(@"加载中");
    [busiSystem.agent setDefaultUserAddress:addre.addressId observer:self callback:@selector(setDefaultUserAddressNotification:)];
}

-(void)setDefaultUserAddressNotification:(BSNotification*)noti
{
    if (noti.error.code == 0) {
        
//        HUDDISMISS;
         [self getData];
    }
    else
    {
        HUDCRY(noti.error.domain, 2);
        
    }
}






-(void)delAddress:(BUUserAddress *)addre
{
    HUDSHOW(@"加载中");
//    [busiSystem.agent delUserAddress:addre.addressId observer:self callback:@selector(delUserAddressNotification:) extraInfo:@{@"addres":addre}];
     [busiSystem.myPathManager deleAddress:busiSystem.agent.userId withAddressid:addre.addressId  observer:self callback:@selector(delUserAddressNotification:) extraInfo:@{@"addres":addre}];
}

-(void)delUserAddressNotification:(BSNotification*)noti
{
    if (noti.error.code ==0) {
        
        
        BUUserAddress *addres = noti.extraInfo[@"addres"];
        if (addres.isDefault == YES) {
            [self getData];
        }
        else
        {
            HUDDISMISS;
            [(NSMutableArray *)busiSystem.agent.userAddresses removeObject:addres];
            NSMutableArray *arr = [NSMutableArray arrayWithArray:busiSystem.agent.userAddresses];
            _tableView.dataArr = arr;
            if (_tableView.dataArr.count == 0) {
                [[JYNoDataManager manager] addNodataView:_tableView withTip:@"暂无信息" withImg:@"nodata" withCount:_tableView.dataArr.count withTag:[NSString stringWithFormat:@"ssavc%d",0]];
                [[JYNoDataManager manager] fitModeY:150];
            }
            else
            {
                [[JYNoDataManager manager] dismiss];
                
            }
            [_tableView reloadData];
        }
    }
    else
    {
        HUDCRY(noti.error.domain, 2);
        
    }
}

//-(NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
//     
//     UITableViewRowAction *layTopRowAction2 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
//          NSLog(@"点击了删除");
//          [tableView setEditing:NO animated:YES];
//          BUUserAddress *address = _tableView.dataArr[indexPath.row];
//          [self delAddress:address];
//     }];
//     
//     
//     NSArray *arr = @[layTopRowAction2];
//     return arr;
//}
//-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//     
//}

- (IBAction)addAddressHandle:(id)sender {
    EditAddressViewController *vc = [[EditAddressViewController alloc] initWithNibName:@"JYEditNickNameViewController" bundle:nil];
     vc.mode = 1;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
