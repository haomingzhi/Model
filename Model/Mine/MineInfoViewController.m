//
//  MineInfoViewController.m
//  JiXie
//
//  Created by ORANLLC_IOS1 on 15/5/25.
//  Copyright (c) 2015年 ORANLLC_IOS1. All rights reserved.
//

#import "MineInfoViewController.h"
#import "BUSystem.h"
//#import "RealNameViewController.h"
#import "ReceiverAddressViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "modifyUserNameViewController.h"
//#import "genderViewController.h"
//#import "RegisterViewController.h"
//#import "DatePickViewController.h"
#import "ZLPhotoPickerViewController.h"
#import "ZLPhotoPickerBrowserPhoto.h"
#import "ZLPhotoPickerBrowserViewController.h"
//#import "BURelease.h"
@interface MineInfoViewController ()< UINavigationControllerDelegate, UIImagePickerControllerDelegate,UIActionSheetDelegate,ZLPhotoPickerViewControllerDelegate,ZLPhotoPickerBrowserViewControllerDelegate>

@end

@implementation MineInfoViewController
{
    NSArray * tableTitles;//文字
    NSArray * tableValues;
    ZLPhotoPickerViewController *_pickerVC;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"基本资料";
    [self showDetail];
    self.tableViewMine.backgroundColor = kUIColorFromRGB(color_0xf5f5f5);
//    [self.imageUserLogo corner:[UIColor clearColor] radius:self.imageUserLogo.frame.size.width/2];
    tableTitles = @[@"用户名",@"性别",@"手机号",@"当前定位地址"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void) viewWillAppear:(BOOL)animated
{
    [self showDetail];
    tableValues =@[busiSystem.agent.Name,busiSystem.agent.sex==0?@"男":@"女",busiSystem.agent.Phone,busiSystem.agent.cityName];
//    tableValues = @[@"",busiSystem.agent.username.length ==0 ? @"请设置昵称" : busiSystem.agent.username,busiSystem.agent.gender.length ==0 ? @"请设置性别" : busiSystem.agent.gender,busiSystem.agent.birthday.length ==0 ? @"请设置出生日期" :busiSystem.agent.birthday ,busiSystem.agent.mobile.length ==0 ? @"绑定手机" :busiSystem.agent.mobile ,busiSystem.agent.fullAddress.length ==0 ? @"请填写收货地址" :busiSystem.agent.fullAddress];
    [self.tableViewMine reloadData];
}

#pragma mark -- UITableViewDataSource


//绑定 tableview 的数据源
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSInteger startTag = 8453;
    static NSString * identify = @"Tableidentify";
    if (indexPath.section == 0) {
//        self.cellUserLogo.accessoryType = UITableViewCellAccessoryNone;
//        [self.imageUserLogo corner:kUIColorFromRGB(color_black) radius:5 borderWidth:1];
        if (![busiSystem.agent.Image.Image isEqualToString:@""]) {
//            self.imageUserLogo 
        }
        self.cellUserLogo.separatorInset =UIEdgeInsetsMake(0, 13, 0, 13);
        return self.cellUserLogo;
    }
    else
    {
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell==nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
        UILabel * lable = [[UILabel alloc]initWithFrame:CGRectMake(14,8,200, 40)];//标题
        lable.center =cell.center;
        lable.frame =CGRectMake(14,lable.frame.origin.y,200, 40);
        lable.backgroundColor = [UIColor clearColor];
        lable.font = [UIFont fontWithName:FONT_NAME_BODY size:FONTS_H4];
        lable.textColor = [UIColor blackColor];
        lable.tag = startTag;
        [cell.contentView addSubview:lable];
        
        lable = [[UILabel alloc]initWithFrame:CGRectMake(120,8,__SCREEN_SIZE.width - 120 -40, 40)]; //属性值
        lable.center =cell.center;
        lable.frame =CGRectMake(120,lable.frame.origin.y,__SCREEN_SIZE.width - 120 -40, 40);
        lable.backgroundColor = [UIColor clearColor];
        lable.font = [UIFont fontWithName:FONT_NAME_BODY size:FONTS_H4];
        lable.textColor = kUIColorFromRGB(color_unSelColor);
        lable.textAlignment = NSTextAlignmentRight;
        lable.tag = startTag +1;
        [cell.contentView addSubview:lable];
        
    }
    
    UILabel *labelTitle = (UILabel *)[cell.contentView viewWithTag:startTag];
    labelTitle.text = tableTitles[indexPath.row];
    
    UILabel *labelValue = (UILabel *)[cell.contentView viewWithTag:startTag +1];
    labelValue.text = tableValues[indexPath.row];
    

    
    if (indexPath.row<2)
    {
        //向右箭头样式
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    
    
    //自定义cell 被选中的颜色
    cell.backgroundView = [[UIView alloc] initWithFrame:cell.frame];
    cell.backgroundView.backgroundColor = [UIColor clearColor];
    
    cell.detailTextLabel.text =@"111";
    cell.tag =100+indexPath.row;
    cell.separatorInset =UIEdgeInsetsMake(0, 13, 0, 13);
    return cell;
    }
}

//行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return section==0?1:4;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

//委托解决行高问题
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  indexPath.section ==0 ? 88: 44;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return section==0?0:13;
}

#pragma  mark --UITableViewDelegate
-(void)pressTitleButton:(UIButton *)btn
{
    [_pickerVC  popView];
}


- (void)pickerViewControllerDoneAsstes:(NSArray *)assets{
    [assets enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        ZLPhotoAssets *asset = (ZLPhotoAssets *)obj;
        UIImage *img = [asset originImage];
//        img =[self getPartOfImage:img rect:CGRectMake(img.size.width<img.size.height?0:(img.size.width-img.size.height)/2,img.size.width<img.size.height?(img.size.height -img.size.width)/2:0,img.size.width<img.size.height?img.size.width:img.size.height,img.size.width<img.size.height?img.size.width:img.size.height)];
//        [busiSystem.releases uploadImg:@[img] observer:self action:@selector(uploadImgNotification:)];
    }];
    [_pickerVC dismissViewControllerAnimated:YES completion:nil];
}

- (void)setHeadImage:(NSArray*)imageArr
{
//    [busiSystem.releases uploadImg:imageArr observer:self action:@selector(uploadImgNotification:)];
}

-(void)uploadImgNotification:(BSNotification*)noti
{
    BASENOTIFICATION(noti);
//    [busiSystem.agent chageLogo:busiSystem.releases.Images[0] observer:self callback:@selector(chageLogoNofification:)];
}

//-(void)chageLogoNofification:(BSNotification*)noti
//{
//    BASENOTIFICATION(noti);
//    [_tableViewMine reloadData];
//}

//行的选择
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (indexPath.section==0) {
        _pickerVC = [[ZLPhotoPickerViewController alloc]init];
        _pickerVC.delegate = self;
        _pickerVC.topShowPhotoPicker = YES;
        _pickerVC.isCanAutoChangeCheck = YES;
        _pickerVC.isHeadPortraitScreenshot = YES;
        _pickerVC.maxCount = 1;
        _pickerVC.status = PickerViewShowStatusCameraRoll;
        [_pickerVC showPickerVc:self];
    }else{
        switch (indexPath.row) {
            case 0:
            {
                modifyUserNameViewController *vc = [[modifyUserNameViewController alloc] init];
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 1:
            {
                UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil  delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"男",@"女", nil];
                sheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
                [sheet showInView:self.view];
            }
                break;
            default:
                break;
        }

    }
}


static NSString *prebirthday;
//在对话框销毁前会调用此方法,也就是手动调用dismiss,或者点击对话框外的区域时会调用。注意这个方法内部不能再调用对话框的dismiss
//isCanceled表明是用户点击对话框外被销毁的还是调用dismiss，如果是点击对话框外则为YES, 否则为NO
-(void) dismissBy:(MyDialog*)dialog withViewController:(UIViewController*)vc isCanceled:(BOOL)isCanceled
{
//    if (!isCanceled) {
//        if ([vc isKindOfClass:[DatePickViewController class]]) {
//            prebirthday = busiSystem.agent.birthday;
//            busiSystem.agent.birthday = [BSUtility getDateTimeWithFormat:((DatePickViewController *)vc).selectedDate Format:@"yyyy-MM-dd"];
//            HUDSHOW(SubmitHintString);
//            [busiSystem.agent changeUserInfo:self callback:@selector(changeUserInfoNotification:)];
//        }
//        tableValues = @[@"",busiSystem.agent.username.length ==0 ? @"请设置昵称" : busiSystem.agent.username,busiSystem.agent.gender.length ==0 ? @"请设置性别" : busiSystem.agent.gender,busiSystem.agent.birthday.length ==0 ? @"请设置出生日期" :busiSystem.agent.birthday ,busiSystem.agent.mobile.length ==0 ? @"绑定手机" :busiSystem.agent.mobile ,busiSystem.agent.address.length ==0 ? @"请填写收货地址" :busiSystem.agent.address];
//        [self.tableViewMine reloadData];
//    }
}

//#pragma mark ---ActionSheetDelegate
//-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
//{
//    UITableViewCell *cell =(UITableViewCell *)[self.view viewWithTag:102];
//    if(buttonIndex ==2) return;
//    cell.detailTextLabel.text = @[@"男",@"女"][buttonIndex];
//    busiSystem.agent.Sex = buttonIndex==0?0:1;
//    [busiSystem.agent changeUserInfoType:2 observer:self callback:@selector(changeUserNofification:)];
//}
//
//#pragma mark --TSAssetsViewControllerDelegate
//- (void)assetsViewController:(TSAssetsViewController *)assetsVC didFinishPickingAssets:(NSArray *)assets
//{
//    if (assets == NULL || assets.count ==0) {
//        //tod 拍照
//        [self takeImage];
//    }
//    else
//    {
//        NSLog(@"count = %ld",(unsigned long)assets.count);
//        ALAsset *asset = assets[0];
//        CGImageRef ref = [[asset  defaultRepresentation]fullScreenImage];
//        UIImage *img =[UIImage imageWithCGImage:ref];
//        self.imageUserLogo.image  = img;
//        [self handleUpload];
//    }
//}
//
//
//- (UIImage *)getPartOfImage:(UIImage *)img rect:(CGRect)partRect
//{
//    CGImageRef imageRef = img.CGImage;
//    CGImageRef imagePartRef = CGImageCreateWithImageInRect(imageRef, partRect);
//    UIImage *retImg = [UIImage imageWithCGImage:imagePartRef];
//    CGImageRelease(imagePartRef);
//    return retImg;
//}
//-(void)assetsViewController:(TSAssetsViewController *)albumsVC failedWithError:(NSError *)error{
//
//}


#pragma mark --handle


-(void)handleUpload
{
    NSData *logoData = NULL;
    UIImage *img = self.imageUserLogo.image;
//    UIImage *image =[self getPartOfImage:img rect:CGRectMake(img.size.width<img.size.height?0:(img.size.width-img.size.height)/2,img.size.width<img.size.height?(img.size.height -img.size.width)/2:0,img.size.width<img.size.height?img.size.width:img.size.height,img.size.width<img.size.height?img.size.width:img.size.height)];
    CGFloat scaleRadio = img.size.width > img.size.height ? 500.0 / img.size.height :  500.0 / img.size.width;
//    self.imageUserLogo.image =image;
    img = [img scaleToSize:scaleRadio];
    if (UIImagePNGRepresentation(img) == nil) {
        logoData =UIImageJPEGRepresentation(img, 1);
    } else {
        logoData =UIImagePNGRepresentation(img);
    }
//    HUDSHOW(@"正在上传用户头像...");
//    [busiSystem.agent chageLogo:[NSString stringWithFormat:@"%@.png",[[[BSUtility getUUIDString] dataUsingEncoding:NSUTF8StringEncoding] md5Data].hexStr ] logoData:logoData observer:self callback:@selector(chageLogoNofification:)];
}


#pragma mark --notification

-(void)changeUserNofification:(BSNotification*)noti
{
    BASENOTIFICATION(noti);
    tableValues =@[busiSystem.agent.Name,busiSystem.agent.sex==0?@"男":@"女",busiSystem.agent.Phone,busiSystem.agent.cityName];
    [self.tableViewMine reloadData];
}

//上传成功以后，修改用户信息
-(void)chageLogoNofification:(BSNotification*)noti
{
    if (noti.error.code ==0) {
//        BURelease *rel =[BURelease new];
//        rel.Imagess.Path.Path.Image =busiSystem.releases.Images[0];
//        busiSystem.agent.Image.Image =rel.Imagess.Path.Path.Image;
//        [self displayRemoteImage:busiSystem.agent.Image imgView:self.imageUserLogo imageName:@"defaultHead1"];
//        [self showDetail];
//        [busiSystem.agent changeUserInfo:self callback:@selector(changeUserInfoNotification:)];
    }
    else {
        if ([self isKindOfClass:NSClassFromString(@"BaseViewController")] && [busiSystem.errorMonitors indexOfObject:@(noti.error.code)] != NSNotFound)
        {
            BSNetworkCommand *cmd = noti.cmd;
            [self performSelector:@selector(addToHistoryCommand:) withObject:cmd];
            [self performSelector:@selector(showLoadingFailureCoverView:) withObject:@"加载失败,请点击屏幕重试"];
            HUDDISMISS;
        }
        else
            HUDCRY(noti.error.domain, TOAST_LONGERTIMER);
        return;
    }
}


-(void) changeUserInfoNotification:(BSNotification *) noti
{
    
}

#pragma mark --

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:^{}];
    self.imageUserLogo.image  = [info objectForKey:UIImagePickerControllerOriginalImage];
    [self handleUpload];
    [self.navigationController popViewControllerAnimated:YES];
    
}
//用户取消拍照
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark --private


-(void)takeImage
{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        if (status != AVAuthorizationStatusAuthorized && status != AVAuthorizationStatusNotDetermined) {
            
            
            [[MyMessageBox msgBox] show:@"温馨提示" message:@"                            使用提示\n            请在【设置->隐私->相机】下\n              允许“工程器械”访问相机" cancelButtonTitle:@"确定" otherButtonTitles:nil completion:nil];
            
            return;
        }
    }
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        UIImagePickerController *imagePickerController  = [[UIImagePickerController alloc] init];
        imagePickerController.delegate = self;
        imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        //imagePickerController.showsCameraControls = NO;
        
        //CMCameraView *cameraView = [[CMCameraView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        //cameraView.picker = imagePickerController;
        //[imagePickerController.cameraOverlayView addSubview:cameraView];
        [self presentViewController:imagePickerController animated:YES completion:nil];
    }
}

-(void) showDetail
{
    [self displayRemoteImage:busiSystem.agent.Image imgView:self.imageUserLogo imageName:@"userLogoDefault"];
}

@end
