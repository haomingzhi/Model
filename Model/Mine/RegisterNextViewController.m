//
//  RegisterNextViewController.m
//  taihe
//
//  Created by air on 2016/11/9.
//  Copyright © 2016年 ORANLLC_IOS1. All rights reserved.
//

#import "RegisterNextViewController.h"
#import "OnlyBottomBtnTableViewCell.h"
#import "TextFieldTableViewCell.h"
#import "TitleAndImageTableViewCell.h"
#import "ZLPhotoPickerViewController.h"
#import "ZLPhotoPickerBrowserViewController.h"
#import "ZLPhotoPickerBrowserPhoto.h"
#import "ZLPhotoAssets.h"
#import "BUSystem.h"
@interface RegisterNextViewController ()
{
//    TitleAndImageTableViewCell *_headCell;
    TextFieldTableViewCell *_nickCell;
    OnlyBottomBtnTableViewCell *_submitCell;
    UIImage *_img;
}
@property (strong, nonatomic) IBOutlet MyTableView *tableView;

@end

@implementation RegisterNextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
        self.title = @"注册";
    [self initTableView];
}

-(void)initTableView
{
    
    __weak RegisterNextViewController *weakSelf = self;
//    _headCell = [TitleAndImageTableViewCell createTableViewCell];
//    [_headCell setCellData:@{@"title":@"头像",@"img":@"defaultHead",@"default":@"defaultHead"}];
//    [_headCell fitRegNextMode];
//    [_headCell setHandleAction:^(id o) {
//        [weakSelf toPhoto];
//    }];
    
    _nickCell = [TextFieldTableViewCell createTableViewCell];
    [_nickCell setCellData:@{@"placeholder":@"昵称"}];
    [_nickCell fitRegNextMode];
    [_nickCell.textTf addTarget:self action:@selector(btnChange:) forControlEvents:UIControlEventEditingChanged];
    
    _submitCell = [OnlyBottomBtnTableViewCell createTableViewCell];
    [_submitCell setCellData:@{@"title":@"完成注册"}];
    [_submitCell fitRegNextMode];
    [_submitCell setHandleAction:^(id o) {
       
        [weakSelf submit];
    }];
    [_submitCell  setBtnBackgroundColor:kUIColorFromRGB(color_5)];
    [_submitCell  setBtnEnabled:NO];

    self.tableView.backgroundColor = kUIColorFromRGB(color_2);
}

-(void)submit
{
    UIImage *img = _img;
    [self.view endEditing:YES];
//    HUDSHOW(@"提交中");
    [busiSystem.agent registerUser:_userInfo[@"tel"] withPwd:_userInfo[@"pwd"] withCode:_userInfo[@"code"]  observer:self callback:@selector(registerUserNotification:)];
}

-(void)registerUserNotification:(BSNotification *)noti
{
    if (noti.error.code == 0) {
        [busiSystem.agent login:_userInfo[@"tel"] password:_userInfo[@"pwd"] observer:self callback:@selector(loginNotification:)];
    }
    else
    {
//          HUDCRY(noti.error.domain, 1);
    }
}

-(void)loginNotification:(BSNotification *)noti
{
    if (noti.error.code == 0) {
//        HUDDISMISS;
        [self finishReg];
    }
    else
    {
//        HUDCRY(noti.error.domain, 1);
    }
}

-(void)finishReg
{
    busiSystem.agent.isNeedRefreshTabC = YES;
    busiSystem.agent.isNeedRefreshTabB = YES;
    busiSystem.agent.isNeedRefreshTabA = YES;
    UITabBarController *tbVc = (UITabBarController *)self.view.window.rootViewController;
    tbVc.selectedIndex = 0;
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 80;
    if (indexPath.row == 1) {
        height = 44;
    }
    else if (indexPath.row == 2)
    {
        height = 100;
    }
    return height;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger row = 3;
    
    return row;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
//    if (indexPath.row == 0) {
//        cell = _headCell;
//        [_headCell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(80, 0, 0, 0)];
//    }
//    else
        if (indexPath.row == 0)
    {
        cell = _nickCell;
        [_nickCell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(50, 0, 0, 0)];
    }
   else
    {
        cell = _submitCell;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.001;
}

-(void)btnChange:(id)obj
{
    if (_nickCell.textTf.text.length > 0) {
        [_submitCell  setBtnBackgroundColor:kUIColorFromRGB(color_3)];
        [_submitCell  setBtnEnabled:YES];
    }
    else
    {
        [_submitCell  setBtnBackgroundColor:kUIColorFromRGB(color_5)];
        [_submitCell  setBtnEnabled:NO];
    }
}

//#pragma mark --相册的选取照片
//-(void)toPhoto
//{
//    __weak RegisterNextViewController *weakSelf = self;
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
//          [_headCell setCellData:@{@"title":@"头像",@"img":img,@"default":@"defaultHead"}];
//        //        [busiSystem.agent addHeadImage:img observer:self callback:@selector(uploadHeadImg:)];
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
//      [_headCell setCellData:@{@"title":@"头像",@"img":image,@"default":@"defaultHead"}];
//    //    [busiSystem.agent addHeadImage:image observer:self callback:@selector(uploadHeadImg:)];
//    
//    
//}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
