//
//  PublishViewController.m
//  taihe
//
//  Created by air on 2016/11/15.
//  Copyright © 2016年 ORANLLC_IOS1. All rights reserved.
//
#import "lame.h"
#import "PublishViewController.h"
#import "OnlyTitleTableViewCell.h"
#import "AddImgTableViewCell.h"
#import "OnlyTextViewTableViewCell.h"
#import "TitleDetailTableViewCell.h"
#import "ZLPhotoPickerViewController.h"
#import "ZLPhotoPickerBrowserViewController.h"
#import "ZLPhotoPickerBrowserPhoto.h"
#import "ZLPhotoAssets.h"
#import "TextViewCanChangeTableViewCell.h"
#import "TitleAndTextBtnTableViewCell.h"
#import "ShowRecordViewController.h"
#import "JYCommonTool.h"
//#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>
#import "BUSystem.h"
@interface PublishViewController ()<AVAudioRecorderDelegate>
{
    OnlyTitleTableViewCell *_tipCell;
    OnlyTitleTableViewCell *_imgTipCell;
    AddImgTableViewCell *_imgsCell;
    OnlyTitleTableViewCell *_contentTipCell;
    TextViewCanChangeTableViewCell *_contentCell;
    TitleDetailTableViewCell *_phoneCell;
    ShowRecordViewController *_sVC;
     ShowRecordViewController *_bVC;
    NSTimeInterval _bTime;
    NSTimeInterval _eTime;
    
    BOOL _hasEdit;
    NSInteger _pTime;
    NSTimer *_timer;
    BOOL _isStop;
}
@property(nonatomic,strong)  NSMutableArray *imgArr;
@property (strong, nonatomic) IBOutlet MyTableView *tableView;
@property (strong, nonatomic) TitleAndTextBtnTableViewCell *recordCell;
@property (strong, nonatomic)   AVAudioRecorder *recorder;//录制
@property (strong, nonatomic)NSURL *recordedFile;//存放路径
@property (strong, nonatomic)AVAudioPlayer *player;//播放
@property (strong, nonatomic)NSData *recData;
@property (strong, nonatomic)NSString *recoderName;//文件名
@end

@implementation PublishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"随手发";
    _imgArr = [NSMutableArray new];
    self.navigationController.navigationBar.translucent = NO;
     self.navigationController.navigationBar.shadowImage = nil;
    [self setRightNav];
    [self initTableView];
    [self iniRecordView];
    [self iniTellView];
//    [self initFileStorePath];
    [self setAudio];
}

-(void)setRightNav
{
    [self setNavigateRightButton:@"确认发布" font:[UIFont systemFontOfSize:15] color:kUIColorFromRGB(color_3)];
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
    
}

-(void)isNeedTip
{
    if (![_contentCell.textView.text isEqualToString:@""]||_recordedFile||_imgArr.count > 0) {
        _hasEdit = YES;
    }
    else
    {
        _hasEdit = NO;
    }
}

-(void)returnBack:(NSDictionary*)dic
{
    if ([dic[@"code"] integerValue] == 0) {
        [super handleReturnBack:nil];
    }
}

-(void)handleDidRightButton:(id)sender
{
    [self.view endEditing:YES];
    if([_contentCell.textView.text isEqualToString:@""] && !_recordedFile)
    {
        HUDCRY(@"有必填项尚未填写", 1);
        return;
    }
    if ([[_phoneCell getTextTf].text isEqualToString:@""]) {
        HUDCRY(@"联系电话尚未填写", 1);
        return;
    }
    else if (![JYCommonTool isMobileNum:[_phoneCell getTextTf].text])
    {
        HUDCRY(@"联系电话无效", 1);
        return;
    }
    [self submit];
}

-(void)submit
{
    HUDSHOW(@"提交中");
        self.recorder = nil;
    self.player = nil;
    if (!_recordedFile) {
        [self goPublish];
        return;
    }
    [self transformCAFToMP3];
    
}

-(void)goPublish
{
    NSString *type = @"0";
    NSString *tel = [_phoneCell getTextTf].text;
    if (busiSystem.agent.isLogin) {
        type = @"1";
       
    }

[busiSystem.shootManager shoot:tel withType:type withContent:_contentCell.textView.text withSapid:busiSystem.agent.sapid withImgs:_imgArr withRec:_recData observer:self callback:@selector(shootNotification:)];
}

-(void)shootNotification:(BSNotification *)noti
{
    if (noti.error.code == 0) {
        HUDSMILE(@"发布成功", 2);
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
    _tableView.refreshFooterView = nil;
    _tableView.contentInset =UIEdgeInsetsMake(0, 0, 0, 0);
    _tipCell = [OnlyTitleTableViewCell createTableViewCell];
    __weak PublishViewController *weakSelf = self;
   _imgTipCell = [OnlyTitleTableViewCell createTableViewCell];
    [_imgTipCell setCellData:@{@"title":@"照片"}];
    [_imgTipCell fitPublishMode];
    
    _imgsCell = [AddImgTableViewCell createTableViewCell];
    _imgsCell.mode = AddImgModeMutable;
    [_imgsCell setCellData:@{@"limitCount":@3,@"arr":@[],@"colCount":@4}];
    [_imgsCell setHandleAction:^(NSDictionary *ddic) {
        if([ddic[@"method"] integerValue] == 1)
        {
            [[CommonAPI managerWithVC:weakSelf] showPhotoOption:nil withUserInfo:@{@"count":@(3-_imgArr.count)}];
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
    [_imgsCell fitMode:15];
    _imgsCell.height = 105;
    _contentTipCell = [OnlyTitleTableViewCell createTableViewCell];
    [_contentTipCell setCellData:@{@"title":@"描述"}];
    [_contentTipCell fitPublishActMode];
    
    _contentCell = [TextViewCanChangeTableViewCell createTableViewCell];
    [_contentCell fitPublishMode];
    
    _recordCell = [TitleAndTextBtnTableViewCell createTableViewCell];
    [_recordCell fitPublishMode:0];
    [_recordCell setExtroHandle:^(NSDictionary *dic) {
        if (dic[@"state"]&& [dic[@"state"] integerValue] == 0) {
            UIButton *btn = dic[@"obj"];
            if([dic[@"event"] integerValue] == 1)
            {
                 [weakSelf initFileStorePath];
               _bTime = [dic[@"time"] doubleValue];
                 [weakSelf.recordCell fitPublishMode:2];
                [weakSelf showRecordView];
                [weakSelf beginRecord];
//                [NSDate new].timeIntervalSinceNow;
            }
//            else
//            {
//                [weakSelf hiddenRecordView];
//               [weakSelf.recordCell fitPublishMode:1];
//            }
        }
        else  if (dic[@"state"]&& [dic[@"state"] integerValue] == 2)
    {
        if([dic[@"event"] integerValue] == 0)
        {
            _eTime = [dic[@"time"] doubleValue];
            if (_eTime -_bTime > 1) {
               
                 [weakSelf.recordCell fitPublishMode:1];
                [weakSelf stopRecord];
                AVURLAsset* audioAsset =  [[AVURLAsset alloc] initWithURL:weakSelf.recordedFile options:nil];//[AVURLAsset URLAssetWithURL:weakSelf.recordedFile options:nil];
//
                CMTime audioDuration = audioAsset.duration;
//
//                float audioDurationSeconds =CMTimeGetSeconds(audioDuration);
                weakSelf.recordCell.initTime =  [[NSString stringWithFormat:@"%.0f",weakSelf.player.duration] integerValue];
                NSLog(@"jjdddd:%@",[NSString stringWithFormat:@"%f",weakSelf.player.duration] );
//                _recData = [NSData dataWithContentsOfURL:self.recordedFile];
            }
            else
            {
                [weakSelf showTip:@"录音时间太短"];
             [weakSelf.recordCell fitPublishMode:0];
                 [weakSelf stopRecord];
            }
        [weakSelf hiddenRecordView];
        }
        else//移动到按钮外收手触发
        {
            
             [weakSelf.recordCell fitPublishMode:0];
         [weakSelf hiddenRecordView];
             [weakSelf stopRecord];
            weakSelf.recordedFile = nil;
        }
    }else if (dic[@"state"]&& [dic[@"state"] integerValue] == 1)
    {
        if([dic[@"event"] integerValue] == 0)
        {
            
        [weakSelf playRecord];
        [weakSelf showTellView];
    }
        else
        {
            [weakSelf stopPlay];
            [weakSelf hiddenTellView];
        }
    }
        else
        {
             [[CommonAPI managerWithVC:weakSelf] showAlert:@selector(deletRc:) withTitle:nil withMessage:@"确定删除该录音?" withObj:@{}];
//            return YES;
        }
        return NO;
    }];
    _phoneCell = [TitleDetailTableViewCell createTableViewCell];
    [_phoneCell setCellData:@{@"title":@"联系电话",@"detail":busiSystem.agent.tel?:@""}];
    [_phoneCell fitPublishMode];
    [_phoneCell getTextTf].keyboardType = UIKeyboardTypePhonePad;
    [_phoneCell getTextTf].kbMovingView = self.view;
}

-(void)showTip:(NSString *)str
{
    HUDCRY(str, 1);
}

-(void)deletRc:(NSDictionary *)dic
{
    if ([dic[@"code"] integerValue] == 0) {
         [[AVAudioSession sharedInstance] setActive:NO error:nil];
           [self hiddenTellView];
        [self.recordCell refreshMode];
        [self delFile];
//        _recData = nil;
    }
}

-(void)showRecordView
{
    _sVC.view.hidden = NO;
    [_sVC beginCustomView];
}

-(void)hiddenRecordView
{
    _sVC.view.hidden = YES;
    [_sVC stopCustomView];
}

-(void)showTellView
{
    _bVC.view.hidden = NO;
    [_bVC beginCustomView];
//    [_recordCell getBtn].enabled = NO;
    self.navigationController.view.userInteractionEnabled = NO;
}

-(void)hiddenTellView
{
    _bVC.view.hidden = YES;
    [_bVC stopCustomView];
//      [_recordCell getBtn].enabled = YES;
     self.navigationController.view.userInteractionEnabled = YES;
}


-(void)startTime
{
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeHandle) userInfo:nil repeats:YES];
//    [self timeHandle];
}

-(void)timeHandle
{
    _pTime ++;
//    NSString *p = [NSString stringWithFormat:@"%lld",[_player currentTime].value/[_player currentTime].timescale];
//    NSLog(@"ddpp:%@",p);
    //    UILabel *txtLb = [_btn viewWithTag:8211];
    if (_pTime == 60) {
          [_sVC setData:@{@"title":@"录音已达60秒",@"imgs":@[[UIImage imageContentWithFileName:@"v_anim1"],[UIImage imageContentWithFileName:@"v_anim2"],[UIImage imageContentWithFileName:@"v_anim3"]]}];
         [_sVC fitMode];
        _pTime = 0;
        [_timer invalidate];
//        [self hiddenTellView];
//        self.navigationController.view.userInteractionEnabled = YES;
        return;
    }
//    [_soundBtnCell setCellData:@{@"title":[NSString stringWithFormat:@"%lds",_pTime]}];
//    [_soundBtnCell fitSendInfoMode];
    
}

-(void)iniRecordView
{
    if (!_sVC) {
         _sVC = [ShowRecordViewController new];
        
    }

    [self.view addSubview:_sVC.view];
    [_sVC setData:@{@"title":@"正在录音",@"imgs":@[[UIImage imageContentWithFileName:@"v_anim1"],[UIImage imageContentWithFileName:@"v_anim2"],[UIImage imageContentWithFileName:@"v_anim3"]]}];
    [_sVC fitMode];
    _sVC.view.x = __SCREEN_SIZE.width/2.0 - 75;
    _sVC.view.y = __SCREEN_SIZE.height/2.0 - 140;
    _sVC.view.height = 100;
    _sVC.view.hidden = YES;
}
-(void)iniTellView
{
    if (!_bVC) {
        _bVC = [ShowRecordViewController new];
        
    }
    
    [self.view addSubview:_bVC.view];
    [_bVC setData:@{@"title":@"正在播放",@"imgs":@[[UIImage imageContentWithFileName:@"b_anim1"],[UIImage imageContentWithFileName:@"b_anim2"],[UIImage imageContentWithFileName:@"b_anim3"]]}];
    [_bVC fitMode];
    _bVC.view.x = __SCREEN_SIZE.width/2.0 - 75;
    _bVC.view.y = __SCREEN_SIZE.height/2.0 - 140;
    _bVC.view.height = 100;
    _bVC.view.hidden = YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger row = 2;
    if (section == 0) {
        row = 2;
    }
    else if (section == 1)
    {
    row = 3;
    }
    else
    {
      row = 1;
    }
    
    return row;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    
    return 10;
}

-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == 0 ||section == 1) {
        UIView *v = [UIView new];
        v.width = __SCREEN_SIZE.width;
        v.height = 10;
        UIView *line = [UIView new];
        line.y = 9.5;
        line.height = 0.5;
        line.backgroundColor = kUIColorFromRGB(color_lineColor);
        line.width = __SCREEN_SIZE.width;
        [v addSubview:line];
        v.backgroundColor = kUIColorFromRGB(color_4);
        return v;
    }
    return nil;
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
    CGFloat height = 44;
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            height = 35;
        }
        else
        {
            height = 105;
        }

    }
    else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            height = 44;
        }
        else   if (indexPath.row == 1)
        {
            height = 110;
        }
        else
        {
          height = 40;
        }
        
    }
    else{
          height = 44;
        }
    return height;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            cell = _imgTipCell;
            [_imgTipCell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(35, 0, 0, 0)];
        }
        else
        {
            cell = _imgsCell;
             [_imgsCell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(105, 0, 0, 0)];
        }
    }
    else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            cell = _contentTipCell;
              [_contentTipCell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(44, 0, 0, 0)];
        }
        else if (indexPath.row == 1)
        {
            cell = _contentCell;
//            [_contentCell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(150, 0, 0, 0)];
        }
        else
        {
            cell = _recordCell;
             [_recordCell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(40, 0, 0, 0)];
        }
    }
    else
    {
        cell = _phoneCell;
        [_phoneCell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(44, 0, 0, 0)];
    }
         cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark --相册的选取照片
-(void)toPhoto
{
    __weak PublishViewController *weakSelf = self;
    
    [[CommonAPI managerWithVC:weakSelf] showPhotoOption:nil withUserInfo:@{@"count":@(1)}];//限定只能选取一张照片
}



#pragma mark -- 选取照片确定
- (void)pickerViewControllerDoneAsstes:(NSArray *)assets{
    //        _imgArr = [NSMutableArray array];
    [assets enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        ZLPhotoAssets *asset = (ZLPhotoAssets *)obj;
        UIImage *img = [asset originImage];
//        UIImage *image =  [img getSubImage:CGRectMake(0, 0, __SCREEN_SIZE.width, 108*2) centerBool:YES];
         [_imgArr addObject:img];
    }];
    if(_imgArr.count > 3)
    {
        [_imgArr removeObjectsInRange:NSMakeRange(3, _imgArr.count - 3)];
    }
    [_imgsCell setCellData:@{@"limitCount":@3,@"arr":_imgArr,@"colCount":@3}];
    _imgsCell.height = 105;
    [self dismissViewControllerAnimated:YES completion:nil];
}

//拍照:
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    UIImage *img = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
//    UIImage *image = [img getSubImage:CGRectMake(0, 0,img.size.width, img.size.width * (106/320.0)*2) centerBool:YES];
    [_imgArr addObject:img];
    [_imgsCell setCellData:@{@"limitCount":@3,@"arr":_imgArr,@"colCount":@3}];
    _imgsCell.height = 105;
    [picker dismissViewControllerAnimated:YES completion:nil];
}

//点击cancel 调用的方法
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
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
    [_imgsCell setCellData:@{@"limitCount":@3,@"arr":_imgArr,@"colCount":@4}];
    [_tableView reloadData];
}

-(void)initFileStorePath
{
    NSDateFormatter *formater = [[NSDateFormatter alloc] init];
    [formater setDateFormat:@"yyyyMMddHHmmss"];
    NSString * dateStr = [formater stringFromDate:[NSDate date]];
//    NSString * path = [NSTemporaryDirectory() stringByAppendingString:[NSString stringWithFormat:@"%@.caf",dateStr]];//[[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.caf",dateStr]];
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *documentsDirectory = [paths objectAtIndex:0];
//    NSString *path = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.caf",dateStr]];
    self.recoderName = [NSString stringWithFormat:@"%@.caf",dateStr];
    self.recordedFile = [NSURL URLWithString:[NSTemporaryDirectory() stringByAppendingString:@"selfRecord.caf"]];//[NSURL fileURLWithPath:path];//
}

-(void)setAudio
{
    [[AVAudioSession sharedInstance] requestRecordPermission:^(BOOL granted) {
        
        if (granted) {
            
            // 用户同意获取麦克风
            AVAudioSession * session = [AVAudioSession sharedInstance];
            NSError * sessionError;
            [session setCategory:AVAudioSessionCategoryPlayAndRecord error:&sessionError];
            if(session == nil)
                NSLog(@"Error creating session: %@", [sessionError description]);
            else
                [session setActive:YES error:nil];
            
        } else {
            
            // 用户不同意获取麦克风
            
        }
        
    }];
    

   
}

-(void)beginRecord
{
    _isStop = NO;
    NSMutableDictionary *recordSetting = [[NSMutableDictionary alloc]init];
//    //设置录音格式
//    [recordSetting setValue:[NSNumber numberWithInt:kAudioFormatMPEGLayer3] forKey:AVFormatIDKey];
//    //设置录音采样率
//    [recordSetting setValue:[NSNumber numberWithFloat:44100.0] forKey:AVSampleRateKey];
//    //录音的质量
//    [recordSetting setValue:[NSNumber numberWithInt:AVAudioQualityMin] forKey:AVEncoderAudioQualityKey];
//    //线性采样位数  8、16、24、32
//    [recordSetting setValue:[NSNumber numberWithInt:16] forKey:AVLinearPCMBitDepthKey];
//    //录音通道数  1 或 2
//    [recordSetting setValue:[NSNumber numberWithInt:2] forKey:AVNumberOfChannelsKey];
//    [recordSetting setValue:[NSNumber numberWithBool:NO] forKey:AVLinearPCMIsBigEndianKey];
//    [recordSetting setValue:[NSNumber numberWithBool:NO] forKey:AVLinearPCMIsFloatKey];
//    [recordSetting setValue:[NSNumber numberWithInt:96] forKey:AVEncoderBitRateKey];
//    [recordSetting setValue:[NSNumber numberWithInt:16] forKey:AVEncoderBitDepthHintKey];
//    //设置录音格式
//    [recordSetting setValue:[NSNumber numberWithInt:kAudioFormatMPEG4AAC] forKey:AVFormatIDKey];
//    //设置录音采样率
//    [recordSetting setValue:[NSNumber numberWithFloat:8000] forKey:AVSampleRateKey];
//    //录音的质量
//    [recordSetting setValue:[NSNumber numberWithInt:AVAudioQualityHigh] forKey:AVEncoderAudioQualityKey];
//    //线性采样位数  8、16、24、32
//    [recordSetting setValue:[NSNumber numberWithInt:16] forKey:AVLinearPCMBitDepthKey];
//    //录音通道数  1 或 2
//    [recordSetting setValue:[NSNumber numberWithInt:1] forKey:AVNumberOfChannelsKey];
    
    
//    [recordSetting setValue:[NSNumber numberWithInt:kAudioFormatMPEGLayer3] forKey:AVFormatIDKey];   //PCM格式
//    
//    [recordSetting setValue:[NSNumber numberWithFloat:44100.0f] forKey:AVSampleRateKey];            //采样率
//    
//    [recordSetting setValue:[NSNumber numberWithInt:2] forKey:AVNumberOfChannelsKey];               //通道数目
//    
//    [recordSetting setValue:[NSNumber numberWithInt:16] forKey:AVLinearPCMBitDepthKey];             //采样位数，默认16.
//    
//    [recordSetting setValue:[NSNumber numberWithBool:NO] forKey:AVLinearPCMIsBigEndianKey];         //是大端口还是小端口还是内存的组织方式
//    
//    [recordSetting setValue:[NSNumber numberWithBool:NO] forKey:AVLinearPCMIsFloatKey];
    
//    [recordSetting setValue :[NSNumber numberWithInt:kAudioFormatLinearPCM] forKey:AVFormatIDKey];
//    [recordSetting setValue:[NSNumber numberWithFloat:44100.0] forKey:AVSampleRateKey];
//    [recordSetting setValue:[NSNumber numberWithInt: 2] forKey:AVNumberOfChannelsKey];
//    
//    [recordSetting setValue :[NSNumber numberWithInt:16] forKey:AVLinearPCMBitDepthKey];
//    [recordSetting setValue :[NSNumber numberWithBool:NO] forKey:AVLinearPCMIsBigEndianKey];
//    [recordSetting setValue :[NSNumber numberWithBool:NO] forKey:AVLinearPCMIsFloatKey];
    
    
    [recordSetting setValue:[NSNumber numberWithInt:kAudioFormatLinearPCM] forKey:AVFormatIDKey];
    //设置录音采样率(Hz) 如：AVSampleRateKey==8000/44100/96000（影响音频的质量）, 采样率必须要设为11025才能使转化成mp3格式后不会失真
    [recordSetting setValue:[NSNumber numberWithFloat:11025.0] forKey:AVSampleRateKey];
    //录音通道数  1 或 2 ，要转换成mp3格式必须为双通道
    [recordSetting setValue:[NSNumber numberWithInt:2] forKey:AVNumberOfChannelsKey];
    //线性采样位数  8、16、24、32
    [recordSetting setValue:[NSNumber numberWithInt:16] forKey:AVLinearPCMBitDepthKey];
    //录音的质量
    [recordSetting setValue:[NSNumber numberWithInt:AVAudioQualityHigh] forKey:AVEncoderAudioQualityKey];
    
    
//    NSMutableDictionary *dicM=[NSMutableDictionary dictionary];
//    //设置录音格式
//    [dicM setObject:@(kAudioFormatLinearPCM) forKey:AVFormatIDKey];
//    //设置录音采样率，8000是电话采样率，对于一般录音已经够了
//    [dicM setObject:@(8000) forKey:AVSampleRateKey];
//    //设置通道,这里采用单声道
//    [dicM setObject:@(1) forKey:AVNumberOfChannelsKey];
//    //每个采样点位数,分为8、16、24、32
//    [dicM setObject:@(8) forKey:AVLinearPCMBitDepthKey];
//    //是否使用浮点数采样
//    [dicM setObject:@(YES) forKey:AVLinearPCMIsFloatKey];
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    [audioSession setCategory:AVAudioSessionCategoryRecord error:nil];
    [audioSession setActive:YES error:nil];
    
     NSError * serror;
     self.recorder = nil;
    self.recorder = [[AVAudioRecorder alloc] initWithURL:self.recordedFile settings:recordSetting error:&serror];
   
    [self.recorder recordForDuration:60];
    self.recorder.delegate = self;
    if( self.recorder == nil)
        NSLog(@"Error creating reccc: %@", [serror description]);
        //缓冲录音
    [self.recorder prepareToRecord];
    //开始录音
    [self.recorder record];
    //如果是反复录制需要置空
    self.player = nil;
}

- (void)audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder successfully:(BOOL)flag
{
    NSLog(@"%@ffff:%ld",flag?@"xx1":@"xx0",recorder.currentTime);
  if(!_isStop)
  {
      [_sVC setData:@{@"title":@"录音已达60秒",@"imgs":@[[UIImage imageContentWithFileName:@"v_anim1"],[UIImage imageContentWithFileName:@"v_anim2"],[UIImage imageContentWithFileName:@"v_anim3"]]}];
      [_sVC fitMode];
      _isStop = YES;
  }
}

-(void)stopRecord
{
    _isStop = YES;
    //停止录制
    [self.recorder stop];
//    [[AVAudioSession sharedInstance] setActive:NO error:nil];
    NSError *playerError;
    NSData *data = [[NSData alloc]initWithContentsOfFile:self.recordedFile.absoluteString];
//    NSData *data = [[NSFileManager defaultManager] contentsAtPath:self.recordedFile.absoluteString];
    self.player = [[AVAudioPlayer alloc] initWithData:data error:&playerError];
//    self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:self.recordedFile error:&playerError];
    if( self.player == nil)
        NSLog(@"Error creating payeccc: %@", [playerError description]);
}

-(void)playRecord
{
    //初始化播放器的时候如下设置
    UInt32 sessionCategory = kAudioSessionCategory_MediaPlayback;
    AudioSessionSetProperty(kAudioSessionProperty_AudioCategory,
                            sizeof(sessionCategory),
                            &sessionCategory);
    UInt32 audioRouteOverride = kAudioSessionOverrideAudioRoute_Speaker;
    AudioSessionSetProperty (kAudioSessionProperty_OverrideAudioRoute,
                             sizeof (audioRouteOverride),
                             &audioRouteOverride);
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
//    默认情况下扬声器播放
    [audioSession setCategory:AVAudioSessionCategoryPlayback error:nil];
    [audioSession setActive:YES error:nil];
    //建议播放之前设置yes，播放结束设置no，这个功能是开启红外感应
//    [[UIDevice currentDevice] setProximityMonitoringEnabled:YES];
//    //添加监听
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(sensorStateChange:)
//                                                 name:@"UIDeviceProximityStateDidChangeNotification"
//                                               object:nil];
    //开始播放
    [self.player prepareToPlay];
    [self.player play];
}

-(void)sensorStateChange:(NSNotificationCenter *)notification;
{
    //如果此时手机靠近面部放在耳朵旁，那么声音将通过听筒输出，并将屏幕变暗（省电啊）
    if ([[UIDevice currentDevice] proximityState] == YES)
    {
        [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
    }
    else
    {
        [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
    }
}


-(void)stopPlay
{
    //关闭红外感应
    [[UIDevice currentDevice] setProximityMonitoringEnabled:NO];
    //暂停播放
    [self.player stop];
     [[AVAudioSession sharedInstance] setActive:NO error:nil];
}

-(void)delFile
{
    [self.recorder deleteRecording];
    self.recordedFile = nil;
//    NSError *error;
//    NSFileManager *fileMgr = [NSFileManager defaultManager];
//    if ([fileMgr removeItemAtPath:self.recordedFile.absoluteString error:&error] != YES)
//        NSLog(@"Unable to delete file: %@", [error localizedDescription]);
}

- (void)transformCAFToMP3 {
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *documentsDirectory = [paths objectAtIndex:0];
//    NSString *writableDBPath = [documentsDirectory stringByAppendingPathComponent:@"livefile.mp3"];
//  NSURL * mp3FilePath = [NSURL URLWithString:writableDBPath];
     NSURL * mp3FilePath = [NSURL URLWithString:[NSTemporaryDirectory() stringByAppendingString:@"myselfRecord.mp3"]];
    
    @try {
        int read, write;
        
        FILE *pcm = fopen([[self.recordedFile absoluteString] cStringUsingEncoding:1], "rb");   //source 被转换的音频文件位置
        fseek(pcm, 4*1024, SEEK_CUR);                                                   //skip file header
        FILE *mp3 = fopen([[mp3FilePath absoluteString] cStringUsingEncoding:1], "wb"); //output 输出生成的Mp3文件位置
        
        const int PCM_SIZE = 8192;
        const int MP3_SIZE = 8192;
        short int pcm_buffer[PCM_SIZE*2];
        unsigned char mp3_buffer[MP3_SIZE];
        
        lame_t lame = lame_init();
        lame_set_in_samplerate(lame, 11025.0);
        lame_set_VBR(lame, vbr_default);
        lame_init_params(lame);
        
        do {
            read = fread(pcm_buffer, 2*sizeof(short int), PCM_SIZE, pcm);
            if (read == 0)
                write = lame_encode_flush(lame, mp3_buffer, MP3_SIZE);
            else
                write = lame_encode_buffer_interleaved(lame, pcm_buffer, read, mp3_buffer, MP3_SIZE);
            
            fwrite(mp3_buffer, write, 1, mp3);
            
        } while (read != 0);
        
        lame_close(lame);
        fclose(mp3);
        fclose(pcm);
    }
    @catch (NSException *exception) {
        NSLog(@"%@",[exception description]);
    }
    @finally {
      NSURL * audioFileSavePath = mp3FilePath;
        NSLog(@"MP3生成成功: %@",audioFileSavePath);
        _recData = [[NSData alloc]initWithContentsOfFile:audioFileSavePath.absoluteString];//[NSData dataWithContentsOfURL:audioFileSavePath];
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"mp3转化成功！" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//        [alert show];
        [self goPublish];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if(![BSUtility isRightNameStyle:[_phoneCell getTextTf].text withMax:11 withMin:0] && ![string isEqualToString:@""])
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
