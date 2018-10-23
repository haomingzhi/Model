//
//  PublishActivityViewController.m
//  taihe
//
//  Created by air on 2016/11/16.
//  Copyright © 2016年 ORANLLC_IOS1. All rights reserved.
//

#import "PublishActivityViewController.h"
#import "OnlyTitleTableViewCell.h"
#import "TextFieldTableViewCell.h"
#import "AddImgTableViewCell.h"
#import "TextViewCanChangeTableViewCell.h"
#import "ZLPhotoPickerViewController.h"
#import "ZLPhotoPickerBrowserViewController.h"
#import "ZLPhotoPickerBrowserPhoto.h"
#import "ZLPhotoAssets.h"
#import "TitleAndImageTableViewCell.h"
#import "TitleAndImageTableViewCell.h"
#import "JYDatePickViewController.h"
#import "BUSystem.h"
@interface PublishActivityViewController ()
{
     BOOL _hasEdit;
        OnlyTitleTableViewCell *_tipCell;
}
@property (strong, nonatomic) IBOutlet MyTableView *tableView;
@property(nonatomic,strong)  NSMutableArray *imgArr;
@property(nonatomic,strong)TextViewCanChangeTableViewCell *titleCell;
@property(nonatomic,strong)TitleAndImageTableViewCell *actStartDateCell;
@property(nonatomic,strong)TitleAndImageTableViewCell *actEndDateCell;
@property(nonatomic,strong)TitleAndImageTableViewCell *actStartTimeCell;
@property(nonatomic,strong)TitleAndImageTableViewCell *actEndTimeCell;
@property(nonatomic,strong)TitleAndImageTableViewCell *regStartDateCell;
@property(nonatomic,strong)TitleAndImageTableViewCell *regEndDateCell;
@property(nonatomic,strong)TextFieldTableViewCell *actPlaceCell;
@property(nonatomic,strong)OnlyTitleTableViewCell *imgTipCell;
@property(nonatomic,strong)AddImgTableViewCell *imgsCell;
@property(nonatomic,strong)OnlyTitleTableViewCell *contentTipCell;
@property(nonatomic,strong)TextViewCanChangeTableViewCell *contentCell;
@property(nonatomic,strong)BUPublishActivity *pa;
@end

@implementation PublishActivityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"发布活动";
     _imgArr = [NSMutableArray array];
    _pa = [BUPublishActivity new];
    [self setRightNav];
    [self initTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setRightNav
{
    [self setNavigateRightButton:@"确认发布" font:[UIFont systemFontOfSize:15] color:kUIColorFromRGB(color_3)];
}

-(void)handleDidRightButton:(id)sender
{
    [self.view endEditing:YES];
    HUDSHOW(@"提交中");
    [self submit];
}
-(void)isNeedTip
{
    if (![_actPlaceCell.textTf.text isEqualToString:@""]||![_contentCell.textView.text isEqualToString:@""]||![_titleCell.textView.text isEqualToString:@""] || _pa.acenddate ||_pa.acstartdate||_pa.enenddate ||_pa.enstartdate||_pa.acendtime||_pa.acstarttime) {
        _hasEdit = YES;
    }
    else
    {
        _hasEdit = NO;
    }
}
-(void)submit
{
    _pa.tel = busiSystem.agent.tel;
    _pa.sapid = busiSystem.agent.sapid;
    _pa.title = _titleCell.textView.text;
    _pa.content = _contentCell.textView.text;
    _pa.address = _actPlaceCell.textTf.text;
    if(_imgArr.count >0)
    {
        _pa.imgArr = _imgArr;
    }
        
    if(_titleCell.textView.text.length < 5)
    {
     HUDCRY(@"标题限制5--25字符", 1);
        return;
    }
    if (![_pa isReady]) {
        HUDCRY(@"有必填项未填", 1);
        return;
    }
    [busiSystem.publishActivityManager publishActivity:_pa observer:self callback:@selector(publishActivityNotification:)];
}

-(void)handleReturnBack:(id)sender
{
    [self isNeedTip];
    if (_hasEdit) {
        [[CommonAPI managerWithVC:self] showAlert:@selector(returnBack:) withTitle:nil withMessage:@"确定放弃本次编辑?" withObj:@{}];
    }
    else
    {
        [super handleReturnBack:nil];
    }
//   [[CommonAPI managerWithVC:self] showAlert:@selector(returnBack:) withTitle:nil withMessage:@"确定放弃本次编辑?" withObj:@{}];

}

-(void)returnBack:(NSDictionary*)dic
{
    if ([dic[@"code"] integerValue] == 0) {
        [super handleReturnBack:nil];
    }
}


-(void)publishActivityNotification:(BSNotification *)noti
{
    if (noti.error.code == 0) {
        HUDSMILE(@"发布成功,等待平台审核", 2);
        [[NSNotificationCenter defaultCenter] postNotificationName:@"RefreshMyActivity" object:nil];
        [self performSelector:@selector(toNextVC) withObject:nil afterDelay:2];
    }
    else
    {
        HUDCRY(noti.error.domain, 1);
    }
}

-(void)toNextVC
{
    
  [self.navigationController popViewControllerAnimated:YES];
}

-(void)initTableView
{
    _tableView.refreshHeaderView = nil;
    _tipCell = [OnlyTitleTableViewCell createTableViewCell];
    __weak PublishActivityViewController *weakSelf = self;
    _titleCell = [TextViewCanChangeTableViewCell createTableViewCell];
    [_titleCell fitPublishActMode];
    _titleCell.textView.delegate = self;
    _titleCell.textView.kbMovingView = self.view;
    _actStartDateCell = [TitleAndImageTableViewCell createTableViewCell];
    [_actStartDateCell setCellData:@{@"title":@"活动开始日期",@"img":@"p_down"}];
    [_actStartDateCell fitPublishActMode];
//    [_actStartDateCell setHandleAction:^(NSDictionary *dic) {
//          [weakSelf.view endEditing:YES];
//        JYDatePickViewController *vc = [JYDatePickViewController createLimitVC];
//        [vc fitDateMode];
//        [vc setCallBack:^(NSDate *date) {
//            
//            NSString *st = [BSUtility getDateTimeWithFormat:date Format:@"yyyy-MM-dd"];
//            weakSelf.pa.acstartdate = st;
//            [weakSelf.actStartDateCell setCellData:@{@"title":@"活动开始日期",@"img":@"p_down",@"detail":st}];
//             [weakSelf.actStartDateCell fitPublishActMode];
//        }];
//        
//    }];
    
      _actEndDateCell = [TitleAndImageTableViewCell createTableViewCell];
    [_actEndDateCell setCellData:@{@"title":@"活动结束日期",@"img":@"p_down"}];
    [_actEndDateCell fitPublishActMode];
//    [_actEndDateCell setHandleAction:^(NSDictionary *dic) {
//        
//        
//    }];
    
      _actStartTimeCell = [TitleAndImageTableViewCell createTableViewCell];
    [_actStartTimeCell setCellData:@{@"title":@"活动开始时间",@"img":@"p_down"}];
    [_actStartTimeCell fitPublishActMode];
//    [_actStartTimeCell setHandleAction:^(NSDictionary *dic) {
//         [weakSelf.view endEditing:YES];
//        JYDatePickViewController *vc = [JYDatePickViewController createLimitVC];
//        [vc fitTimeMode];
//        [vc setCallBack:^(NSDate *date) {
//           
//            NSString *st = [BSUtility getDateTimeWithFormat:date Format:@"HH:mm"];
//              weakSelf.pa.acstarttime = st;
//            [weakSelf.actStartTimeCell setCellData:@{@"title":@"活动开始时间",@"img":@"p_down",@"detail":st}];
//            [weakSelf.actStartTimeCell fitPublishActMode];
//        }];    }];
    
      _actEndTimeCell = [TitleAndImageTableViewCell createTableViewCell];
      [_actEndTimeCell setCellData:@{@"title":@"活动结束时间",@"img":@"p_down"}];
    [_actEndTimeCell fitPublishActMode];
//    [_actEndTimeCell setHandleAction:^(NSDictionary *dic) {
//          [weakSelf.view endEditing:YES];
//        JYDatePickViewController *vc = [JYDatePickViewController createLimitVC];
//        [vc fitTimeMode];
//        [vc setCallBack:^(NSDate *date) {
//            
//            NSString *st = [BSUtility getDateTimeWithFormat:date Format:@"HH:mm"];
//              weakSelf.pa.acendtime = st;
//            [weakSelf.actEndTimeCell setCellData:@{@"title":@"活动结束时间",@"img":@"p_down",@"detail":st}];
//            [weakSelf.actEndTimeCell fitPublishActMode];
//        }];
//
//        
//    }];
    
      _regStartDateCell = [TitleAndImageTableViewCell createTableViewCell];
    [_regStartDateCell setCellData:@{@"title":@"报名开始日期",@"img":@"p_down"}];
    [_regStartDateCell fitPublishActMode];
//    [_regStartDateCell setHandleAction:^(NSDictionary *dic) {
//          [weakSelf.view endEditing:YES];
//        JYDatePickViewController *vc = [JYDatePickViewController createLimitVC];
//        [vc fitDateMode];
//        [vc setCallBack:^(NSDate *date) {
//            
//           NSString *st = [BSUtility getDateTimeWithFormat:date Format:@"yyyy-MM-dd"];
//              weakSelf.pa.enstartdate = st;
//             [weakSelf.regStartDateCell setCellData:@{@"title":@"报名开始日期",@"img":@"p_down",@"detail":st}];
//            [weakSelf.regStartDateCell fitPublishActMode];
//        }];
//        
//    }];
//    
    
      _regEndDateCell = [TitleAndImageTableViewCell createTableViewCell];
    [_regEndDateCell setCellData:@{@"title":@"报名结束日期",@"img":@"p_down"}];
    [_regEndDateCell fitPublishActMode];
//    [_regEndDateCell setHandleAction:^(NSDictionary *dic) {
//          [weakSelf.view endEditing:YES];
//        JYDatePickViewController *vc = [JYDatePickViewController createLimitVC];
//        [vc fitDateMode];
//        [vc setCallBack:^(NSDate *date) {
//            
//            NSString *st = [BSUtility getDateTimeWithFormat:date Format:@"yyyy-MM-dd"];
//              weakSelf.pa.enenddate = st;
//            [weakSelf.regEndDateCell setCellData:@{@"title":@"报名结束日期",@"img":@"p_down",@"detail":st}];
//            [weakSelf.regEndDateCell fitPublishActMode];
//        }];
//        
//    }];
    _actPlaceCell = [TextFieldTableViewCell createTableViewCell];
    [_actPlaceCell setCellData:@{@"placeholder":@"活动地点"}];
    [_actPlaceCell fitPublishActMode];
    _actPlaceCell.textTf.kbMovingView  = self.tableView;
    
    _imgTipCell = [OnlyTitleTableViewCell createTableViewCell];
    [_imgTipCell setCellData:@{@"title":@"图片上传"}];
    [_imgTipCell fitPublishActMode];
    
    _imgsCell = [AddImgTableViewCell createTableViewCell];
    _imgsCell.mode = AddImgModeMutable;
    [_imgsCell setCellData:@{@"limitCount":@3,@"arr":@[],@"colCount":@4}];
    [_imgsCell setHandleAction:^(NSDictionary *ddic) {
        if([ddic[@"method"] integerValue] == 1)
        {
            [[CommonAPI managerWithVC:weakSelf] showPhotoOption:nil withUserInfo:@{@"count":@(5-_imgArr.count)}];
        }
        else if([ddic[@"method"] integerValue] == 2)
        {
            [weakSelf setupPhotoBrowser:@{@"arr":weakSelf.imgArr,@"row":ddic[@"row"],@"imgArr":ddic[@"imgvs"]}];
        }
        else
        {
            [weakSelf delImg:[ddic[@"row"] integerValue]];
        }
    }];
    [_imgsCell fitMode:0];
    
    
    _contentTipCell = [OnlyTitleTableViewCell createTableViewCell];
    [_contentTipCell setCellData:@{@"title":@"活动说明(不少于20个字)"}];
    [_contentTipCell fitPublishActMode];
    _contentCell = [TextViewCanChangeTableViewCell createTableViewCell];
    [_contentCell fitMode];
    _contentCell.textView.kbMovingView = self.tableView;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger row = 1;
    if(section == 0)
        row = 10;
    else
    {
        row = 2;
    }
    return row;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    
    return 0.001;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return  44;
    }
    return 0.001;
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
        
        line.y = 43.5;
        line.height = 0.5;
        line.backgroundColor = kUIColorFromRGB(color_lineColor);
        line.width = __SCREEN_SIZE.width;
        [_tipCell addSubview:line];
        [_tipCell setCellData:@{@"title":[NSString stringWithFormat:@"提示：请确认您此次发起是针对%@",busiSystem.agent.sap]}];
        [_tipCell fitTipMode];
        return _tipCell;
    }
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 90;
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            height = 44;
        }
        else
        {
            height = 120;
        }
    }
    else
    {
        if (indexPath.row == 0) {
            height = 80;
        }
        else if(indexPath.row == 1)
        {
            height = 44;
        }
        else if (indexPath.row == 2)
        {
            height = 44;
        }
        else if (indexPath.row == 3)
        {
            height = 44;
        }
        else if (indexPath.row == 4)
        {
            height = 44;
        }
        else if (indexPath.row == 5)
        {
            height = 44;
        }
        else if (indexPath.row == 6)
        {
            height = 44;
        }
        else if (indexPath.row == 7)
        {
            height = 44;
        } else if (indexPath.row == 8)
        {
            height = 44;
        }
               else
        {
            height = _imgsCell.height;
        }
    }
    
    return height;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            cell = _contentTipCell;
            [_contentTipCell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(44, 0, 0, 0)];
        }
        else
        {
            cell = _contentCell;
        }
    }
    else
    {
        if (indexPath.row == 0) {
            cell = _titleCell;
               [_titleCell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(80, 0, 0, 0)];
        }
        else if(indexPath.row == 1)
        {
            cell = _actStartDateCell;
               [_actStartDateCell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(44, 0, 0, 0)];
        }
        else if (indexPath.row == 2)
        {
            cell = _actEndDateCell;
               [_actEndDateCell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(44, 0, 0, 0)];
        }
        else if (indexPath.row == 3)
        {
            cell = _actStartTimeCell;
               [_actStartTimeCell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(44, 0, 0, 0)];
        }
        else if (indexPath.row == 4)
        {
            cell = _actEndTimeCell;
               [_actEndTimeCell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(44, 0, 0, 0)];
        }
        else if (indexPath.row == 5)
        {
            cell = _regStartDateCell;
               [_regStartDateCell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(44, 0, 0, 0)];
        }
        else if (indexPath.row == 6)
        {
            cell = _regEndDateCell;
               [_regEndDateCell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(44, 0, 0, 0)];
        }
        else if (indexPath.row == 7)
        {
            cell = _actPlaceCell;
               [_actPlaceCell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(44, 0, 0, 0)];
        }
        else if(indexPath.row == 8)
        {
            cell = _imgTipCell;
        }
        else
        {
            cell = _imgsCell;
               [_imgsCell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(_imgsCell.height, 0, 0, 0)];
        }
    }
    
         cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark --相册的选取照片
-(void)toPhoto
{
    __weak PublishActivityViewController *weakSelf = self;
    
    [[CommonAPI managerWithVC:weakSelf] showPhotoOption:nil withUserInfo:@{@"count":@(1)}];//限定只能选取一张照片
}



#pragma mark -- 选取照片确定
- (void)pickerViewControllerDoneAsstes:(NSArray *)assets{
    //        _imgArr = [NSMutableArray array];
    [assets enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        ZLPhotoAssets *asset = (ZLPhotoAssets *)obj;
        UIImage *img = [asset originImage];
        UIImage *image =  [img getSubImage:CGRectMake(0, 0, __SCREEN_SIZE.width, 108*2) centerBool:YES];
       [_imgArr addObject:img];
        
    }];
    if(_imgArr.count > 5)
    {
        [_imgArr removeObjectsInRange:NSMakeRange(5, _imgArr.count - 5)];
    }
    [_imgsCell setCellData:@{@"limitCount":@5,@"arr":_imgArr,@"colCount":@4}];
    [self dismissViewControllerAnimated:YES completion:nil];
    [_tableView reloadData];
}

//拍照:
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    UIImage *img = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
//    UIImage *image = [img getSubImage:CGRectMake(0, 0,img.size.width, img.size.width * (106/320.0)*2) centerBool:YES];
    [_imgArr addObject:img];
     [_imgsCell setCellData:@{@"limitCount":@5,@"arr":_imgArr,@"colCount":@4}];
    [picker dismissViewControllerAnimated:YES completion:nil];
     [_tableView reloadData];
}

//点击cancel 调用的方法
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    __weak PublishActivityViewController *weakSelf = self;
    if (indexPath.row == 1) {
        [self.view endEditing:YES];
        JYDatePickViewController *vc = [JYDatePickViewController createLimitVC];
        NSDate *dt;
        if (self.pa.acenddate && ![self.pa.acenddate isEqualToString:@""]) {
            dt = [BSUtility StrToDate:@"yyyy-MM-dd" DateStr:weakSelf.pa.acenddate?:@""];
        }
        else
        {
            dt = [NSDate new];
        }
        [vc setMaxDate:dt];
        [vc fitDateMode];
        [vc setCallBack:^(NSDate *date) {
            
            NSString *st = [BSUtility getDateTimeWithFormat:date Format:@"yyyy-MM-dd"];
            self.pa.acstartdate = st;
            [self.actStartDateCell setCellData:@{@"title":@"活动开始日期",@"img":@"p_down",@"detail":st}];
            [self.actStartDateCell fitPublishActMode];
        }];

    }
    else if (indexPath.row == 2)
    {
        [self.view endEditing:YES];
        JYDatePickViewController *vc = [JYDatePickViewController createLimitVC];
        NSDate *dt;
        if (self.pa.acstartdate && ![self.pa.acstartdate isEqualToString:@""]) {
            dt = [BSUtility StrToDate:@"yyyy-MM-dd" DateStr:weakSelf.pa.acstartdate?:@""];
        }
        else
        {
            dt = [NSDate new];
        }
        [vc setMinDate:dt];
        [vc fitDateMode];
        [vc setCallBack:^(NSDate *date) {
            
            NSString *st = [BSUtility getDateTimeWithFormat:date Format:@"yyyy-MM-dd"];
            self.pa.acenddate = st;
            [self.actEndDateCell setCellData:@{@"title":@"活动结束日期",@"img":@"p_down",@"detail":st}];
            [self.actEndDateCell fitPublishActMode];
        }];
    }
    else if (indexPath.row == 3)
    {
        [self.view endEditing:YES];
        JYDatePickViewController *vc = [JYDatePickViewController createLimitVC];
        [vc fitTimeMode];
        [vc setCallBack:^(NSDate *date) {
            
            NSString *st = [BSUtility getDateTimeWithFormat:date Format:@"HH:mm"];
            self.pa.acstarttime = st;
           [self.actStartTimeCell setCellData:@{@"title":@"活动开始时间",@"img":@"p_down",@"detail":st}];
            [self.actStartTimeCell fitPublishActMode];
        }];
    }
    else if (indexPath.row == 4)
    {
        [self.view endEditing:YES];
        JYDatePickViewController *vc = [JYDatePickViewController createLimitVC];
        [vc fitTimeMode];
        [vc setCallBack:^(NSDate *date) {
            
            NSString *st = [BSUtility getDateTimeWithFormat:date Format:@"HH:mm"];
            self.pa.acendtime = st;
          [self.actEndTimeCell setCellData:@{@"title":@"活动结束时间",@"img":@"p_down",@"detail":st}];
            [self.actEndTimeCell fitPublishActMode];
        }];

    }
    else if (indexPath.row == 5)
    {
        [self.view endEditing:YES];
        JYDatePickViewController *vc = [JYDatePickViewController createLimitVC];
        NSDate *dt;
        if (self.pa.enenddate && ![self.pa.enenddate isEqualToString:@""]) {
            dt = [BSUtility StrToDate:@"yyyy-MM-dd" DateStr:weakSelf.pa.enenddate?:@""];
        }
        else
        {
            dt = [NSDate new];
        }
        [vc setMaxDate:dt];
        [vc fitDateMode];
        [vc setCallBack:^(NSDate *date) {
            
            NSString *st = [BSUtility getDateTimeWithFormat:date Format:@"yyyy-MM-dd"];
            self.pa.enstartdate = st;
             [self.regStartDateCell setCellData:@{@"title":@"报名开始日期",@"img":@"p_down",@"detail":st}];
            [self.regStartDateCell fitPublishActMode];
        }];
    }
    else
    {
        [self.view endEditing:YES];
        JYDatePickViewController *vc = [JYDatePickViewController createLimitVC];
        NSDate *dt;
        if (self.pa.enstartdate && ![self.pa.enstartdate isEqualToString:@""]) {
            dt = [BSUtility StrToDate:@"yyyy-MM-dd" DateStr:weakSelf.pa.enstartdate?:@""];
        }
        else
        {
            dt = [NSDate new];
        }
        [vc setMinDate:dt];
        [vc fitDateMode];
        [vc setCallBack:^(NSDate *date) {
            
            NSString *st = [BSUtility getDateTimeWithFormat:date Format:@"yyyy-MM-dd"];
            self.pa.enenddate = st;
             [self.regEndDateCell setCellData:@{@"title":@"报名结束日期",@"img":@"p_down",@"detail":st}];
            [self.regEndDateCell fitPublishActMode];
        }];
    }
}

- (void) setupPhotoBrowser:(NSDictionary *)dic{
    // 图片游览器
    ZLPhotoPickerBrowserViewController *pickerBrowser  = [[ZLPhotoPickerBrowserViewController alloc] init];
    // 数据源/delegate
    //    pickerBrowser.delegate = self;
    // 数据源可以不传，传photos数组 photos<里面是ZLPhotoPickerBrowserPhoto>
    pickerBrowser.photos = [self addZLPhotoPickerBrowserPhotoArr:dic[@"arr"] withImgVArr:dic[@"imgArr"]];
    // 是否可以删除照片
    //    pickerBrowser.editing = YES;
    // 当前选中的值
    pickerBrowser.currentIndexPath = [NSIndexPath indexPathForRow:[dic[@"row"] integerValue] inSection:0];
    // 展示控制器
    [pickerBrowser showPickerVc:self];
    //    [self.navigationController pushViewController:pickerBrowser animated:NO ];
}

- (NSMutableArray *)addZLPhotoPickerBrowserPhotoArr:(NSArray *)arr withImgVArr:(NSArray *)imgArr;
{
    NSMutableArray * mArr =[NSMutableArray new];
    for (int i=0; i<arr.count; i++)
    {
        ZLPhotoPickerBrowserPhoto *photo =[ZLPhotoPickerBrowserPhoto new];
        BUImageRes *im = arr[i];
        UIImage *d;
        UIImage *ii;
        if ([im isKindOfClass:[UIImage class]]) {
            d = (UIImage *)im;
            ii = (UIImage *)im;
            photo.thumbImage = d;
            photo.photoImage = ii;
        }
        else
        {
            if(im.isCached)
            {
                d= [UIImage imageWithContentsOfFile:im.cacheThumbFile];
                ii = [UIImage imageWithContentsOfFile:im.cacheFile];
                photo.thumbImage = d;
                photo.photoImage = ii;
            }
            else
            {
                photo.thumbImage = [UIImage imageContentWithFileName:@"defaultPhoto"];
                photo.photoImage = [UIImage imageContentWithFileName:@"defaultPhoto"];
            }
        }
        photo.aspectRatioImage = ii;
        photo.toView = imgArr[i];
        [mArr addObject:photo];
    }
    return mArr;
}

-(void)delImg:(NSInteger )indexPath
{
    [_imgArr removeObjectAtIndex:indexPath];
    [_imgsCell setCellData:@{@"limitCount":@5,@"arr":_imgArr,@"colCount":@4}];
    [_tableView reloadData];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if(![BSUtility isRightNameStyle:_titleCell.textView.text withMax:49 withMin:0] && ![text isEqualToString:@""])
    {
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
