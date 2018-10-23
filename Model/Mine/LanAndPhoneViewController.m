//
//  LanAndPhoneViewController.m
//  taihe
//
//  Created by air on 2016/11/10.
//  Copyright © 2016年 ORANLLC_IOS1. All rights reserved.
//

#import "LanAndPhoneViewController.h"
#import "BUSystem.h"
@interface LanAndPhoneViewController ()
@property(nonatomic,strong)BUGetMyNetInfo *netInfo;
@end

@implementation LanAndPhoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"新装宽带电话申请详情";
    [self fitMode];
}

-(void)fitMode
{
    self.infoCell = [TitleDetailTableViewCell createTableViewCell];
    [self.infoCell setCellData:@{@"title":@"楼栋  ",@"detail":@"楼层  ",@"detail2":@"单元  "}];
    [self.infoCell fitThreeTitleMode];
    
    self.stateCell = [TitleDetailTableViewCell createTableViewCell];
    [self.stateCell setCellData:@{@"title":@"已提交",@"detail":@""}];
    [self.stateCell fitServerInfoStateMode];
    
    self.typeCell = [TitleDetailTableViewCell createTableViewCell];
    [self.typeCell setCellData:@{@"title":@"申请业务手机号",@"detail":@""}];
    [self.typeCell fitServerInfoMode];
    
    self.priceCell = [TitleDetailTableViewCell createTableViewCell];
    [self.priceCell setCellData:@{@"title":@"服务类型",@"detail":@""}];
    [self.priceCell fitServerInfoMode];
    
//    self.submitCell = [OnlyBottomBtnTableViewCell createTableViewCell];
//        [self.submitCell fitWaterInfoMode];
    
//    self.stateTipCell = [OnlyTitleTableViewCell createTableViewCell];
//    [self.stateTipCell setCellData:@{@"title":@"当前状态",@"detail":@""}];
//    [self.stateTipCell fitServerInfoStateMode];
    
    self.countCell = [TitleDetailTableViewCell createTableViewCell];
    [self.countCell setCellData:@{@"title":@"价格",@"detail":@""}];
    [self.countCell fitServerInfoMode];
    
    self.sendTimeCell = [TitleDetailTableViewCell createTableViewCell];
    [self.sendTimeCell setCellData:@{@"title":@"办理时间",@"detail":@""}];
    [self.sendTimeCell fitServerInfoMode];

}

-(void)getData
{
    [busiSystem.getMyNetInfoManager getMyNetInfo:self.userInfo observer:self callback:@selector(getDataNotification:)];
}

-(void)getDataNotification:(BSNotification *)noti
{
    if (noti.error.code == 0) {
        HUDDISMISS;
        if (busiSystem.getMyNetInfoManager.myNetInfos.count > 0) {
          _netInfo = busiSystem.getMyNetInfoManager.myNetInfos[0];
        }
        
        [self.infoCell setCellData:@{@"title":[NSString stringWithFormat:@"楼栋  %@",_netInfo.house],@"detail":[NSString stringWithFormat:@"楼层  %@",_netInfo.floor],@"detail2":[NSString stringWithFormat:@"单元  %@",_netInfo.unit]}];
        [self.infoCell fitThreeTitleMode];
        
        NSString *st;
        if (_netInfo.state == 0) {
            st = @"已提交";
        }
        else if (_netInfo.state == 1)
        {
            st = @"已完成";
        }
        else if (_netInfo.state == 2)
        {
            st = @"受理失败";
            [self addTipView];
        }
        else
        {
            st = @"受理失败";
            [self addTipView];
        }
        [self.stateCell setCellData:@{@"title":st,@"detail":_netInfo.createTime?:@""}];
        [self.stateCell fitServerInfoStateModeB];
        
      
        [self.typeCell setCellData:@{@"title":@"申请业务手机号",@"detail":_netInfo.tell?:@""}];
        [self.typeCell fitServerInfoMode];
        
     
        [self.priceCell setCellData:@{@"title":@"服务类型",@"detail":_netInfo.serName?:@""}];
        [self.priceCell fitServerInfoMode];
        
//    self.stateTipCell = [OnlyTitleTableViewCell createTableViewCell];
//        [self.stateTipCell setCellData:@{@"title":@"当前状态",@"detail":@""}];
//        [self.stateTipCell fitServerInfoStateMode];
        

        [self.countCell setCellData:@{@"title":@"价格",@"detail":[NSString stringWithFormat:@"￥%@",_netInfo.price]}];
        [self.countCell fitServerInfoMode];
        
 
        [self.sendTimeCell setCellData:@{@"title":@"办理时间",@"detail":[_netInfo.handleTime substringToIndex:MIN(10, _netInfo.handleTime.length)]}];
        [self.sendTimeCell fitServerInfoMode];
        
        [self.areaCell setCellData:@{@"title":@"归属园区",@"detail":_netInfo.sapId?:@""}];
        [self.areaCell fitServerInfoModeG];
        if (_netInfo.state == 0) {
            self.mode = 1;
        }
        else
        {
         self.mode = 2;
        }
        
        [self addBottomMenuView];
    }
    else
    {
        HUDCRY(noti.error.domain, 1);
    }
}

-(void)confirm
{
    [[CommonAPI managerWithVC:self] showAlert:@selector(sureRequest:) withTitle:nil withMessage:@"确认该服务已完成？" withObj:@{}];
}

-(void)sureRequest:(NSDictionary *)dic
{
    if ([dic[@"code"] integerValue] == 0) {
        HUDSHOW(@"确认中");
        [busiSystem.getMyNetInfoManager sureMyNetInfo:_netInfo.nboId observer:self callback:@selector(confirmMyNetInfoNotification:)];
    }
    
}

-(void)confirmMyNetInfoNotification:(BSNotification *)noti
{
    if(noti.error.code == 0)
    {
        HUDSMILE(@"确认成功", 1);
        //刷新界面
        self.mode = 2;
          [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshMyServer" object:nil];
        [self addBottomMenuView];
         [self.stateCell setCellData:@{@"title":@"已完成",@"detail":_netInfo.createTime?:@""}];
          [self.stateCell fitServerInfoStateModeB];
//        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        HUDCRY(noti.error.domain, 1);
    }
}
-(void)deleteOption
{
    
    [[CommonAPI managerWithVC:self] showAlert:@selector(deleteRequest:) withTitle:nil withMessage:@"确认删除该订单？" withObj:@{}];
}

-(void)deleteRequest:(NSDictionary *)dic
{
    if ([dic[@"code"] integerValue] == 0) {
        HUDSHOW(@"删除中");
        [busiSystem.getMyNetInfoManager deleteMyNetInfo:_netInfo.nboId observer:self callback:@selector(deleteMyNetInfoNotification:)];
    }

    
}
-(void)deleteMyNetInfoNotification:(BSNotification *)noti
{
    if(noti.error.code == 0)
    {
        HUDSMILE(@"删除成功", 1);
        //刷新界面
         [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshMyServer" object:nil];
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        HUDCRY(noti.error.domain, 1);
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)addTipView
{
    if (!self.tipCell) {
        self.tipCell = [OnlyTitleTableViewCell createTableViewCell];
    }
    [self.tipCell setCellData:@{@"title":_netInfo.failCause?:@""}];
    [self.tipCell fitCerFailTipMode];
    self.tipCell.backgroundColor = kUIColorFromRGB(color_4);
    UIView *line = [self.tipCell viewWithTag:3221];
    if (!line) {
        line = [UIView new];
        line.tag = 3221;
    }
    
    line.y = 109.5;
    line.height = 0.5;
    line.backgroundColor = kUIColorFromRGB(color_lineColor);
    line.width = __SCREEN_SIZE.width;
    [self.tipCell addSubview:line];
    self.tableView.tableHeaderView = self.tipCell;
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
