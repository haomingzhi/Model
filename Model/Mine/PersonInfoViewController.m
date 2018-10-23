//
//  PersonInfoViewController.m
//  taihe
//
//  Created by air on 2016/11/7.
//  Copyright © 2016年 ORANLLC_IOS1. All rights reserved.
//

#import "PersonInfoViewController.h"
#import "TitleDetailTableViewCell.h"
#import "TitleAndImageTableViewCell.h"
//#import "ZLPhotoPickerViewController.h"
//#import "ZLPhotoPickerBrowserViewController.h"
//#import "ZLPhotoPickerBrowserPhoto.h"
//#import "ZLPhotoAssets.h"
#import "TitleAndTwoBtnTableViewCell.h"
#import "TitleAndTextfieldTableViewCell.h"
#import "BUSystem.h"
//#import "SingleSelectionViewController.h"
#import "TwoSelectionViewController.h"
#import "OnlyTitleTableViewCell.h"
//#import "SelectAddressViewController.h"
#import "JYDatePickViewController.h"
//#import "ModifiersPwdViewController.h"
//#import "PayPwdViewController.h"
#import "BtnsTableViewCell.h"
#import "JYCommonTool.h"

@interface PersonInfoViewController ()
{

    TitleAndTextfieldTableViewCell *_nickNameCell;
    TitleAndTwoBtnTableViewCell *_sexCell;
    TitleDetailTableViewCell *_userCell;
    TitleDetailTableViewCell *_birthDayCell;
    TitleDetailTableViewCell *_cityCell;
    
    TitleAndTextfieldTableViewCell *_workCell;
    TitleAndTextfieldTableViewCell *_personSignCell;
    
    OnlyTitleTableViewCell *_likeTipCell;
     BtnsTableViewCell *_btnsCell;
    NSInteger _requestCount;
    BOOL _needSave;
    NSInteger _sex;
  
}
@property (strong, nonatomic) IBOutlet MyTableView *tableView;
 @property (strong, nonatomic)   TitleAndImageTableViewCell *headCell;
 @property (strong, nonatomic) UIImage *img;
 @property (strong, nonatomic) NSString *headImg;
@property (strong, nonatomic) NSString *birthday;
@end

@implementation PersonInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"个人信息";
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.shadowImage = nil;
     _headImg = busiSystem.agent.userInfo.headImage.Image;
     _birthday = busiSystem.agent.userInfo.birthday;
     _sex = busiSystem.agent.userInfo.sex == 0?1:0;

    [self initTableView];
    [self setRightNav];
     HUDSHOW(@"加载中");
     [self getUserInfo];
}
-(void)getUserInfo
{

     [busiSystem.agent getUserInfo:busiSystem.agent.userId observer:self callback:@selector(getUserInfoNotification:)];
}

-(void)getUserInfoNotification:(BSNotification *)noti
{
     if (noti.error.code == 0) {
     HUDDISMISS;
          [_headCell setCellData:@{@"title":@"点击修改头像",@"default":@"defaultHead",@"img":busiSystem.agent.userInfo.headImage?:[NSNull new],@"changeImg":@(YES)}];
          [_headCell fitPersonInfoMode];
}
else
{

     HUDCRY(noti.error.domain, 1);
}
}
//-(void)handleReturnBack:(id)sender
//{
//    if (!_needSave) {
//        [super handleReturnBack:sender];
//    }
//    else
//    {
//    [[CommonAPI managerWithVC:self] showAlert:@selector(returnBack:) withTitle:nil withMessage:@"确定放弃本次编辑?" withObj:@{}];
//    }
//}

-(void)returnBack:(NSDictionary*)dic
{
      if ([dic[@"code"] integerValue] == 0) {
     [super handleReturnBack:nil];
      }
}

-(void)setRightNav
{
    [self setNavigateRightButton:@"保存" font:[UIFont systemFontOfSize:15] color:kUIColorFromRGB(color_3)];
}
-(void)handleDidRightButton:(id)sender
{
     [self.view endEditing:YES];
    HUDSHOW(@"加载中");
    [self submit];
}

-(void)submit
{
    
        _requestCount++;
    busiSystem.agent.userInfo.nickName = _nickNameCell.textField.text;
     busiSystem.agent.userInfo.sex = _sex == 0 ? 1:0;
     [busiSystem.agent updateUserInfo:busiSystem.agent.userId withNickName:busiSystem.agent.userInfo.nickName withHeadImg:_headImg withSex:[NSString stringWithFormat:@"%d",(_sex == 0?1:0)] withBirthDay:_birthday observer:self callback:@selector(updateUserInfoNotification:)];
//    if (_img) {
//          _requestCount++;
//        [busiSystem.agent changeHeadImage:busiSystem.agent.tel withImage:_img observer:self callback:@selector(changeHeadImageNotification:)];
//    }
}

-(void)saveHeadImg:(UIImage*)img
{
    HUDSHOW(@"上传中");
    [busiSystem.agent uploadImgs:@[img] observer:self callback:@selector(chageLogoNotification:)];
}

-(void)chageLogoNotification:(BSNotification*)noti
{
    if (noti.error.code == 0) {
        HUDSMILE(@"头像修改成功", 1);
          busiSystem.agent.isNeedRefreshTabD = YES;
         _headImg =  busiSystem.agent.imgsList;
         BUImageRes *img = [BUImageRes new];
         img.Image = _headImg;
         busiSystem.agent.userInfo.headImage = img;
    }
    else
    {
        HUDCRY(noti.error.domain, 2);
    }
}

-(void)updateUserInfoNotification:(BSNotification *)noti
{
    _requestCount--;
    if (noti.error.code == 0) {
        if(_requestCount == 0)
        {
            HUDSMILE(@"保存成功", 1);
             
            busiSystem.agent.isNeedRefreshTabD = YES;
             [self.navigationController popViewControllerAnimated:YES];
        }
    }
    else
    {
        HUDCRY(noti.error.domain, 1);
        
    }
}

-(void)changeHeadImageNotification:(BSNotification *)noti
{
    _requestCount --;
    if (noti.error.code == 0) {
        if(_requestCount == 0)
        {
            HUDSMILE(@"保存成功", 1);
              busiSystem.agent.isNeedRefreshTabC = YES;
            [self.navigationController popViewControllerAnimated:YES];
        }
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

-(void)viewWillAppear:(BOOL)animated
{
        [super viewWillAppear:animated];
//   [_nickNameCell setCellData:@{@"title":@"昵称",@"textField":busiSystem.agent.userInfo.nickName?:@""}];
//     [_nickNameCell fitPersonInfoMode];
//    [_tableView reloadData];
}

-(void)initTableView
{
    __weak PersonInfoViewController *weakSelf = self;
    _tableView.refreshHeaderView = nil;
   _headCell = (TitleAndImageTableViewCell *)[TitleAndImageTableViewCell createTableViewCell];
    [_headCell setCellData:@{@"title":@"点击修改头像",@"default":@"defaultHead",@"img":busiSystem.agent.userInfo.headImage?:[NSNull new],@"changeImg":@(YES)}];
     [_headCell fitPersonInfoMode];
     
    [_headCell initAddPhotoManager:1 withImgArr:[NSMutableArray arrayWithArray:@[]] withVC:self withTableView:self.tableView];
    [_headCell.addPhotoManager setCheckDoneCallBack:^(NSDictionary *dic){
        NSArray *arr = dic[@"arr"];
        weakSelf.img = arr[0];
//         UIImage *image1 =  [JYCommonTool getSubImage:weakSelf.img mCGRect:CGRectMake(0, 0, 300, 300) centerBool:YES];
        [weakSelf saveHeadImg:weakSelf.img];
                _needSave = YES;
                  [weakSelf.headCell setCellData:@{@"title":@"头像",@"default":@"defaultHead",@"img":weakSelf.img}];

    }];
    [_headCell setHandleAction:^(id o) {
         [weakSelf.view endEditing:YES];
        [weakSelf.headCell toPhoto];

    }];
    
   _nickNameCell = [TitleAndTextfieldTableViewCell createTableViewCell];
    [_nickNameCell setCellData:@{@"title":@"昵称",@"textField":busiSystem.agent.userInfo.nickName?:@""}];
  [_nickNameCell fitPersonInfoMode];
      _sexCell = [TitleAndTwoBtnTableViewCell createTableViewCell];
    [_sexCell setCellData:@{@"title":@"性别",@"btnA":@"男",@"btnB":@"女",@"sex":@(_sex)}];
     [_sexCell fitPersonInfoMode];
     
     __weak TitleAndTwoBtnTableViewCell *wwws = _sexCell;
     [_sexCell setHandleAction:^(NSDictionary *dic){
          UIButton *btn = dic[@"obj"];
          NSInteger tag = btn.tag - 100;
          _sex = tag;
            [wwws setCellData:@{@"title":@"性别",@"btnA":@"男",@"btnB":@"女",@"sex":@(tag)}];
          [wwws fitPersonInfoMode];
     }];
     
     _userCell = [TitleDetailTableViewCell createTableViewCell];
     [_userCell setCellData:@{@"title":@"用户ID",@"detail":busiSystem.agent.userId?:@""}];
      [_userCell fitPersonInfoModeB];
     
     _birthDayCell = [TitleDetailTableViewCell createTableViewCell];
     [_birthDayCell setCellData:@{@"title":@"生日",@"detail":_birthday?: @"选择生日"}];
       [_birthDayCell fitPersonInfoMode];
     
     _cityCell  = [TitleDetailTableViewCell createTableViewCell];
     [_cityCell setCellData:@{@"title":@"城市",@"detail":@"选择城市"}];
     [_cityCell fitPersonInfoMode];
     
     _workCell = [TitleAndTextfieldTableViewCell createTableViewCell];
     [_workCell setCellData:@{@"title":@"职业",@"placeholder":@"填写职业"}];
     [_workCell fitPersonInfoMode];
     
     _personSignCell = [TitleAndTextfieldTableViewCell createTableViewCell];
     [_personSignCell setCellData:@{@"title":@"个性签名",@"placeholder":@"填写你的个性签名"}];
     [_personSignCell fitPersonInfoMode];
    _tableView.delegate = self;
    _tableView.dataSource = self;
     
     _likeTipCell = [OnlyTitleTableViewCell createTableViewCell];
     [_likeTipCell setCellData:@{@"title":@"喜欢的分类"}];
     [_likeTipCell fitPersonInfoMode];
     [_likeTipCell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(24.5, 0, 0, 0)];
   
     _btnsCell = [BtnsTableViewCell createTableViewCell];
     [_btnsCell setCellData:@{@"arr":@[@{@"title":@"服装"},@{@"title":@"餐具"},@{@"title":@"餐具"},@{@"title":@"餐具"},@{@"title":@"餐具"},@{@"title":@"餐具"},@{@"title":@"餐具"},@{@"title":@"餐具"},@{@"title":@"餐具"}]}];
     [_btnsCell initPersonInfoMode];
     _tableView.backgroundColor = kUIColorFromRGB(color_0xf0f0f0);
}

//-(void)nickeChange:(UITextField*)textTf
//{
//    if (![textTf.text isEqualToString:busiSystem.agent.userInfo.nikeName] &&) {
//        _needSave = YES;
//    }
//    else
//    {
//        _needSave = NO;
//    }
//}

-(void)textChange:(UITextField*)textTf
{
//    NSInteger sex = -1;
//    if (textTf == [_sexCell getTextTf]) {
//        if([textTf.text isEqualToString:@"男"])
//        {
//            sex =0;
//        }
//        else if([textTf.text isEqualToString:@"女"])
//        {
//            sex = 1;
//        }
//    }
//    else
//    {
//        sex = _sex;
//    }
   
//    if ( ![[_nickNameCell getTextTf].text isEqualToString:busiSystem.agent.userInfo.nickName]) {
//        _needSave = YES;
//    }
//    else
//    {
//        _needSave = NO;
//    }
//    if ( [_nickNameCell getTextTf] == textTf) {
//         NSInteger c = [BSUtility textCount:[_nickNameCell getTextTf].text];
//        if (c > 16) {
//            [textTf.text substringToIndex:16];
//        }
//    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
     return 0.001;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
     if (section == 1) {
          return 25;
     }
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 45;
   
    if (indexPath.section == 0) {
        height = 118;
    }
    else if (indexPath.section == 1)
    {
        height = 45;
    }
     else
     {
          height = _btnsCell.height;
     }
    return height;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger row = 1;
    if(section == 1)
    {
        return 4;
    }
     else if (section == 2)
     {
          return 1;
     }
    return row;
}

-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
     if (section == 1) {
          return nil ;
     }
     else if(section == 2)
     {
          return nil;
     }
    return [self createSectionFootView];
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
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    if (indexPath.section == 0) {
    
        cell = _headCell;
//        [_headCell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(81, 0, 0, 0)];
   
    }
    else  if (indexPath.section == 1)
    {
        if (indexPath.row == 0) {
            cell = _userCell;
            [_userCell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(45, 0, 0, 0)];
        }
        else if(indexPath.row == 1)
        {
            cell = _nickNameCell;
            [_nickNameCell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(45, 0, 0, 0)];
        }
        else if(indexPath.row == 2)
        {
            cell= _sexCell;
            [_sexCell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(45, 0, 0, 0)];
        }
        else if(indexPath.row == 3)
        {
             cell= _birthDayCell;
             [_birthDayCell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(45, 0, 0, 0)];
        }
        else if(indexPath.row == 4)
        {
             cell= _cityCell;
             [_cityCell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(44, 0, 0, 0)];
        }
        else if(indexPath.row == 5)
        {
             cell= _workCell;
             [_workCell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(44, 0, 0, 0)];
        }
        else if(indexPath.row == 6)
        {
             cell= _personSignCell;
             [_personSignCell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(44, 0, 0, 0)];
        }
    }
     else
     {
          cell = _btnsCell;
     }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

//#pragma mark --相册的选取照片
//-(void)toPhoto
//{
//     [self.view endEditing:YES];
//    __weak PersonInfoViewController *weakSelf = self;
//    
//    [[CommonAPI managerWithVC:weakSelf] showPhotoOption:nil withUserInfo:@{@"count":@(1)}];//限定只能选取一张照片
//}
//
//
//
//#pragma mark -- 选取照片确定
//- (void)pickerViewControllerDoneAsstes:(NSArray *)assets{
//    //        _imgArr = [NSMutableArray array];
//    [assets enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
//        ZLPhotoAssets *asset = (ZLPhotoAssets *)obj;
//        UIImage *img = [asset originImage];
//        _img = img;
//        UIImage *image1 =  [JYCommonTool getSubImage:img mCGRect:CGRectMake(0, 0, 300, 300) centerBool:YES];
//        [self saveHeadImg:_img];
//        _needSave = YES;
//          [_headCell setCellData:@{@"title":@"头像",@"default":@"defaultHead",@"img":image1}];
////        [busiSystem.agent addHeadImage:img observer:self callback:@selector(uploadHeadImg:)];
//        
//    }];
//    //    [_tableView reloadData];
//        [self dismissViewControllerAnimated:YES completion:nil];
//}
//
////拍照:
//- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
//    
//    UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
//    _img = image;
//    UIImage *image1 = [JYCommonTool getSubImage:image mCGRect:CGRectMake(0, 0, 300, 300) centerBool:YES];;
//    [self saveHeadImg:_img];
//    _needSave = YES;
//      [_headCell setCellData:@{@"title":@"头像",@"default":@"defaultHead",@"img":image1}];
////    [busiSystem.agent addHeadImage:image observer:self callback:@selector(uploadHeadImg:)];
//    
//       [self dismissViewControllerAnimated:YES completion:nil];
//}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0)
    {
          if (indexPath.row == 1)
          {
           [self.headCell toPhoto];
          }
         
    }
    else   if(indexPath.section == 1)
    {
          if(indexPath.row == 3)
         {
              JYDatePickViewController *vc = [JYDatePickViewController createLimitVC];
              [vc fitDateMode];
              [vc setCallBack:^(NSDate *date) {
                   NSString *bt =  [BSUtility getDateTimeWithFormat:date Format:@"yyyy-MM-dd"];
                   _birthday = bt;
                   [_birthDayCell setCellData:@{@"title":@"生日",@"detail":_birthday?: @"选择生日"}];
                   [_birthDayCell fitPersonInfoMode];
              }];
//              [self.navigationController pushViewController:vc animated:YES];
         }
         else
              if (indexPath.row == 4) {
                   [TwoSelectionViewController toSingleSelectionVC:@[@{@"title":@"广东省",@"arr":@[@"深圳市",@"珠海市",@"云浮市",@"广州市"]},@{@"title":@"福建省",@"arr":@[@"福州市",@"厦门市",@"南平市"]}]];

                   
              }
        if (indexPath.row == 1) {
//            ModifiersPwdViewController *vc = [[ModifiersPwdViewController alloc] initWithNibName:@"RegisterViewController" bundle:nil];
//            [self.navigationController pushViewController:vc animated:YES];
        }
        else if (indexPath.row == 2)
        {
//            PayPwdViewController *vc = [PayPwdViewController new];
//            vc.mode = busiSystem.agent.userInfo.hasPayPassword == 0 ? 0:1;
//            [self.navigationController pushViewController:vc animated:YES];
        }
    }
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
//    if(![BSUtility isRightNameStyle:[_nickNameCell getTextTf].text withMax:15 withMin:0]&& ![string isEqualToString:@""])
//    {
//        return NO;
//    }
//    NSInteger c = [BSUtility textCount:[_nickNameCell getTextTf].text];
//    NSInteger cc = [BSUtility textCount:string];
//    if (c + cc > 16) {
//        [_nickNameCell getTextTf].text = [[_nickNameCell getTextTf].text stringByAppendingString:[string substringToIndex:MIN(16 - c, string.length)]] ;
//    }
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    NSLog(@"ssccaa:%@",textField.text);
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
