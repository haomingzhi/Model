//
//  LookOrEditRantInfoViewController.m
//  taihe
//
//  Created by air on 2016/11/14.
//  Copyright © 2016年 ORANLLC_IOS1. All rights reserved.
//

#import "LookOrEditRantInfoViewController.h"
#import "OnlyTitleTableViewCell.h"
#import "TextFieldTableViewCell.h"
#import "TextViewCanChangeTableViewCell.h"
#import "TitleAndTextBtnTableViewCell.h"
#import "TitleAndTwoTextfieldTableViewCell.h"
#import "TitleAndThreeTextFieldTableViewCell.h"
#import "SingleSelectionViewController.h"
#import "BUSystem.h"
@interface LookOrEditRantInfoViewController ()
{
    OnlyTitleTableViewCell *_tipCell;
    OnlyTitleTableViewCell *_titleTipCell;
    TextViewCanChangeTableViewCell *_titleCell;
    TitleAndThreeTextFieldTableViewCell *_forCell;
    TitleAndTwoTextfieldTableViewCell *_rantMoneyCell;
    TitleAndTwoTextfieldTableViewCell *_rantAreaCell;
   
    OnlyTitleTableViewCell *_demoTipCell;
    TextViewCanChangeTableViewCell *_demoCell;
}

@property (strong, nonatomic) IBOutlet MyTableView *tableView;
@property (strong, nonatomic)BUGetMyRent *rent;
 @property (strong, nonatomic) TitleAndTextBtnTableViewCell *functionCell;
@end

@implementation LookOrEditRantInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"查看/修改求租信息";
    [self initTableView];
    [self initData];
    [self setRightNav];
   
}
-(void)initData
{
    if ([self.userInfo isKindOfClass:[BUGetMyRent class]]) {
        _rent = _userInfo;
        //        [_tableView reloadData];
    }
    else
    {
        HUDSHOW(@"加载中");
        [self getData];
    }
}

-(void)getData
{

}

-(void)setRightNav
{
    [self setNavigateRightButton:@"保存" font:[UIFont systemFontOfSize:15] color:kUIColorFromRGB(color_3)];
}

-(void)handleDidRightButton:(id)sender
{
    [self.view endEditing:YES];
    HUDSHOW(@"提交中");
    [self submit];
}

-(void)submit
{
   _rent.title = _titleCell.textView.text;
    _rent.explain = _demoCell.textView.text;
    _rent.door = [_forCell getData];
    _rent.purpose = [_functionCell getData:@"detail"];
    _rent.rentMax = [[_rantMoneyCell getData:@"b"] floatValue];
    _rent.rentMin = [[_rantMoneyCell getData:@"a"] floatValue];
    _rent.acreageMax = [[_rantAreaCell getData:@"b"] floatValue];
    _rent.acreageMin = [[_rantAreaCell getData:@"a"] floatValue];
    [busiSystem.getMyRentManager updateMyRent:_rent observer:self callback:@selector(updateMyRentNotification:)];
}

-(void)updateMyRentNotification:(BSNotification *)noti
{
    if (noti.error.code == 0) {
//        HUDDISMISS;
        HUDSMILE(@"修改成功", 1);
        [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshMyRant" object:nil];
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

-(void)initTableView
{
    _tableView.refreshFooterView = nil;
    _tableView.refreshHeaderView = nil;
    
    __weak LookOrEditRantInfoViewController *weakSelf = self;
    _tipCell = [OnlyTitleTableViewCell createTableViewCell];
    
    _titleTipCell = [OnlyTitleTableViewCell createTableViewCell];
    [_titleTipCell setCellData:@{@"title":@"标题（10-25字）"}];
    [_titleTipCell fitRantInfoMode];
    
    
    _titleCell = [TextViewCanChangeTableViewCell createTableViewCell];
    [_titleCell setCellData:@{@"minHeight":@(40)}];
    _titleCell.textView.kbMovingView = self.view;
    
    _forCell = [TitleAndThreeTextFieldTableViewCell createTableViewCell];
    [_forCell setCellData:@{@"title":@"厅室要求(非必填)"}];
    [_forCell fitRantInfoMode];
    
    _rantMoneyCell = [TitleAndTwoTextfieldTableViewCell createTableViewCell];
    [_rantMoneyCell setCellData:@{@"title":@"租金范围（元）"}];
    [_rantMoneyCell fitRantInfoMode];
    
    _rantAreaCell = [TitleAndTwoTextfieldTableViewCell createTableViewCell];
    [_rantAreaCell setCellData:@{@"title":@"面积范围（㎡）"}];
    [_rantAreaCell fitRantInfoMode];
    
    _functionCell  = [TitleAndTextBtnTableViewCell createTableViewCell];
    [_functionCell setCellData:@{@"title":@"用途（非必填）",@"detail":@"普通住宅"}];
    [_functionCell fitRantInfoMode:NO];
    [_functionCell setHandleAction:^(id o) {
        SingleSelectionViewController *vc = [SingleSelectionViewController toSingleSelectionVC:[NSMutableArray arrayWithArray:@[@"商用",@"住宅"]]];
        if ([[weakSelf.functionCell getData:@"detail"] isEqualToString:@"住宅"]) {
            vc.curRow = 1;
        }
        else
        {
        vc.curRow = 0;
        }
        
        [vc setHandleAction:^(NSDictionary *dic){
            [weakSelf.functionCell setCellData:@{@"title":@"用途（非必填）",@"detail":dic[@"title"]}];
            [weakSelf.functionCell fitRantInfoMode:NO];
        }];
    }];
    _demoTipCell = [OnlyTitleTableViewCell createTableViewCell];
    [_demoTipCell setCellData:@{@"title":@"文字说明"}];
    [_demoTipCell fitRantInfoMode];

    _demoCell = [TextViewCanChangeTableViewCell createTableViewCell];
     [_demoCell setCellData:@{@"minHeight":@(40)}];
     _demoCell.textView.kbMovingView = self.view;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger row = 2;
    if (section == 0) {
        row = 2;
    }
 
    else
    {
        row = 6;
    }
    
    return row;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
   
    return 10;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    if(section == 0)
    {
        _tipCell.backgroundColor = kUIColorFromRGB(color_4);
        UIView *line = [_tipCell viewWithTag:3221];
        if (!line) {
            line = [UIView new];
            line.tag = 3221;
        }
        
        line.y = 79.5;
        line.height = 0.5;
        line.backgroundColor = kUIColorFromRGB(color_lineColor);
        line.width = __SCREEN_SIZE.width;
        [_tipCell addSubview:line];
        [_tipCell setCellData:@{@"title":[NSString stringWithFormat:@"提示：请确认您此次发起是针对%@",_rent.sapname],@"detail":@"您所发布的求租信息仅客服人员可见，APP上不显示，若有合适房源客服人员会联系您。"}];
        [_tipCell fitTipModeB];
        return _tipCell;
    }
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return  80;
    }
    return 0.001;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 35;
    if(indexPath.section == 0)
    {
        if (indexPath.row == 0) {
            height = 44;
        }
        else
        {
            height = 70;
        }
        
        
    }

    else
    {
        if (indexPath.row != 5) {
            height = 44;
        }
        else
        {
            height = 150;
        }
    }
    return height;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell;
    if(indexPath.section == 0)
    {
        if (indexPath.row == 0) {
            cell = _titleTipCell;
            [_titleTipCell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(44, 0, 0, 0)];
            [_titleTipCell setCellData:@{@"title":@"标题（10-25字）"}];
            [_titleTipCell fitRantInfoMode];
        }
        else
        {
            cell = _titleCell;
            [_titleCell setCellData:@{@"minHeight":@(40),@"text":_rent.title?:@""}];
             [_titleCell fitRentModeB];
//             [_titleCell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(44, 0, 0, 0)];
        }
    }
   
    else
    {
        if (indexPath.row == 0) {
            cell = _forCell;
            NSString *a,*b,*c;
            if (_rent.door&&![_rent.door isEqualToString:@""]) {
                NSArray *arr = [_rent.door componentsSeparatedByString:@"室"];
                if (arr.count > 0) {
                    a = arr[0];
                }
                if (arr.count > 1) {
                    b = arr[1];
                  arr = [b componentsSeparatedByString:@"厅"];
                    if (arr.count > 0) {
                        b = arr[0];
                    }
                    if (arr.count > 1) {
                        c = arr[1];
                        c = [c stringByReplacingOccurrencesOfString:@"卫" withString:@""];
                    }

                }
                
            }
           
            [_forCell setCellData:@{@"title":@"厅室要求(非必填)",@"a":a?:@"",@"b":b?:@"",@"c":c?:@""}];
            [_forCell fitRantInfoMode];
              [_forCell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(44, 0, 0, 0)];
        }
        else if(indexPath.row == 1)
        {
            cell = _rantMoneyCell;
            [_rantMoneyCell setCellData:@{@"title":@"租金范围（元）",@"textA":[NSString stringWithFormat:@"%.2f",_rent.rentMin],@"textB":[NSString stringWithFormat:@"%.2f",_rent.rentMax]}];
            [_rantMoneyCell fitRantInfoMode];
            [_rantMoneyCell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(44, 0, 0, 0)];
            
        }
        else if(indexPath.row == 2)
        {
           cell = _rantAreaCell;
            [_rantAreaCell setCellData:@{@"title":@"面积范围（㎡）",@"textA":[NSString stringWithFormat:@"%ld",_rent.acreageMin],@"textB":[NSString stringWithFormat:@"%ld",_rent.acreageMax]}];
            [_rantAreaCell fitRantInfoMode];
            [_rantAreaCell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(44, 0, 0, 0)];
        }
        else if(indexPath.row == 3)
        {
            cell = _functionCell;
            [_functionCell setCellData:@{@"title":@"用途（非必填）",@"detail":_rent.purpose?:@""}];
            [_functionCell fitRantInfoMode:NO];
            [_functionCell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(44, 0, 0, 0)];
        }
        else if(indexPath.row == 4)
        {
            cell = _demoTipCell;
            [_demoTipCell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(44, 0, 0, 0)];
        }
        else
        {
            cell = _demoCell;
            [_demoCell setCellData:@{@"minHeight":@(40),@"text":_rent.explain?:@""}];
            [_demoCell fitRentMode];
        }
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
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
