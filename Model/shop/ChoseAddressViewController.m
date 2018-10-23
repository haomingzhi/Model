 //
//  ChoseAddressViewController.m
//  compassionpark
//
//  Created by Steve on 2017/2/14.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import "ChoseAddressViewController.h"
#import "AddressTableViewCell.h"
#import "BUSystem.h"
#import "SelectAddressViewController.h"

@interface ChoseAddressViewController ()

@end

@implementation ChoseAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    if (_state == 1 ) {
        self.title = @"选择自提点";
        HUDSHOW(@"加载中");
        [self getTakeSelfAddressList];
    }else if (_state == 0){
        self.title = @"选择收货地址";
//        [self getMyAddressData];
        _tableView.dataArr = [NSMutableArray arrayWithArray:busiSystem.agent.userAddresses];
        [self initBottomView];
    }else if (_state == 2){
        HUDSHOW(@"加载中");
        self.title = @"选择考试地址";
        [self getExamAddressList];
    }
    [self initTableView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)getTakeSelfAddressList{
    [busiSystem.agent getSinceAddressList:self callback:@selector(getSinceAddressListNotification:)];
}

-(void)getSinceAddressListNotification:(BSNotification *)noti
{
    HUDDISMISS;
    if (noti.error.code == 0) {
        _tableView.dataArr = [NSMutableArray arrayWithArray:busiSystem.agent.takeSelfAddressArr];
        [_tableView reloadData];
    }
    else
    {
        HUDCRY( noti.error.domain , 1);
    }
}

-(void)getExamAddressList{
//    [busiSystem.getBespokeListManager getExamAddressList:self callback:@selector(getExamAddressListNotification:) extraInfo:nil];
}

-(void)getExamAddressListNotification:(BSNotification *)noti
{
    
    if (noti.error.code == 0) {
        HUDDISMISS;
//        _tableView.dataArr = [NSMutableArray arrayWithArray:busiSystem.getBespokeListManager.examAddressArr];
//        [_tableView reloadData];
    }
    else
    {
        HUDCRY( noti.error.domain , 1);
    }
}


-(void)getMyAddressData{
   [busiSystem.agent getUserAddress:busiSystem.agent.userId?:@"" observer:self callback:@selector(getUserAddressNotification:)];
}

-(void)getUserAddressNotification:(BSNotification *)noti
{
    HUDDISMISS;
    if (noti.error.code == 0) {
        
    }
    else
    {
        HUDCRY( noti.error.domain , 1);
    }
}

-(void)initBottomView{
    
    UIButton *managerAddressBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, __SCREEN_SIZE.height - 64 - 44, __SCREEN_SIZE.width, 44)];
    [managerAddressBtn setTitle:@"管理收货地址" forState:UIControlStateNormal];
    [managerAddressBtn setTitleColor:kUIColorFromRGB(color_1) forState:UIControlStateNormal];
    managerAddressBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [managerAddressBtn addTarget:self action:@selector(managerAddressAction) forControlEvents:UIControlEventTouchUpInside];
//    managerAddressBtn.layer.borderColor = kUIColorFromRGB(color_lineColor).CGColor;
//    managerAddressBtn.layer.borderWidth = 0.5;
    managerAddressBtn.backgroundColor = kUIColorFromRGB(color_4);
    [self.view addSubview:managerAddressBtn];
    
}

-(void)managerAddressAction{
    NSLog(@"managerAddressAction");
    SelectAddressViewController *vc = [SelectAddressViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}



-(void)initTableView{
    
    

    [AddressTableViewCell registerTableViewCell:_tableView];
    
    _tableView.x = 0;
    _tableView.y = 0;
    _tableView.width = __SCREEN_SIZE.width;
    if (_state == 0) {
        _tableView.height = __SCREEN_SIZE.height -64 - 44;
    }else{
        _tableView.height = __SCREEN_SIZE.height -64;
    }
    
    _tableView.refreshHeaderView = nil;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorColor = kUIColorFromRGB(color_3);
    _tableView.backgroundColor = kUIColorFromRGB(color_9);
}



#pragma mark - tableView delegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _tableView.dataArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AddressTableViewCell *cell = [AddressTableViewCell dequeueReusableCell:_tableView];
   
    BUUserAddress *a = [_tableView.dataArr objectAtIndex:indexPath.row];
    NSMutableDictionary *dic;
    if (_state ==1 || _state == 2) {
        dic = [[a getDic:2] mutableCopy];
    }else{
        dic = [[a getDic:4] mutableCopy];
    }
    
    if ([a.addrId isEqualToString:_address.addrId]) {
        [dic setObject:@(YES) forKey:@"selected"];
    }else{
        [dic setObject:@(NO) forKey:@"selected"];
    }
    [dic setObject:indexPath forKey:@"row"];
    [cell setCellData:dic];
    [cell fitConfirmOrderMode];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.contentView.backgroundColor = kUIColorFromRGB(color_4);
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 75;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.callBack) {
        BUUserAddress *address = [_tableView.dataArr objectAtIndex:indexPath.row];
        self.callBack(@{@"address":address});
        [self.navigationController popViewControllerAnimated:YES];
    }

}

@end
