//
//  SendInfoViewController.m
//  taihe
//
//  Created by air on 2016/11/14.
//  Copyright © 2016年 ORANLLC_IOS1. All rights reserved.
//

#import "SendInfoViewController.h"
#import "AddImgTableViewCell.h"
#import "OnlyTitleTableViewCell.h"
#import "OnlyBottomBtnTableViewCell.h"
#import "TitleDetailTableViewCell.h"
#import "ZLPhotoPickerViewController.h"
#import "ZLPhotoPickerBrowserViewController.h"
#import "ZLPhotoPickerBrowserPhoto.h"
#import "ZLPhotoAssets.h"
#import "ShowRecordViewController.h"
#import "BUSystem.h"
#import <AVFoundation/AVFoundation.h>
@interface SendInfoViewController ()
{
    OnlyTitleTableViewCell *_imgTipCell;
    AddImgTableViewCell *_imgsCell;
    
    OnlyTitleTableViewCell *_contentTipCell;
    OnlyTitleTableViewCell *_contentCell;
    OnlyBottomBtnTableViewCell *_soundBtnCell;
    
    TitleDetailTableViewCell *_phoneCell;
     TitleDetailTableViewCell *_sapCell;
    OnlyTitleTableViewCell *_kefuTipCell;
    OnlyTitleTableViewCell *_kefuCell;
    NSInteger _initTime;
    NSInteger _pTime;
      ShowRecordViewController *_bVC;
    
    NSTimer *_timer;
}

@property (strong, nonatomic) IBOutlet MyTableView *tableView;
 @property (strong, nonatomic)  BUShoot *shoot;
 @property (strong, nonatomic)AVPlayerItem * songItem;
  @property (strong, nonatomic)  AVPlayer * player;
@end

@implementation SendInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"随手发详情";
   
//    if ([_userInfo isKindOfClass:[BUShoot class]]) {
        _shoot = _userInfo;
//    }
//    else
//    {
//        [self getData];
//    }
    if (_shoot.voicePath&&![_shoot.voicePath isEqualToString:@""]) {
        [self intPlayer];
    }
    
     [self initTableView];
     [self iniTellView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(endSound) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
}

-(void)intPlayer
{
    NSURL * url  = [NSURL URLWithString:_shoot.voicePath];
    _songItem = [[AVPlayerItem alloc]initWithURL:url];
//    [_songItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    _pTime = [[NSString stringWithFormat:@"%.0f",CMTimeGetSeconds(_songItem.duration)] integerValue];
    [self setPlaye:_songItem];
    NSLog(@"sssx  %ld",_pTime);
}

-(void)endSound
{
//    if ([keyPath isEqualToString:@"status"]) {
        NSLog(@"jjjj");
//    }
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
//    [_songItem removeObserver:self forKeyPath:@"status"];
}
-(void)setPlaye:( AVPlayerItem *)songItem
{
  _player = [[AVPlayer alloc]initWithPlayerItem:songItem];
   
}

-(void)showTellView
{
  
     _pTime = [[NSString stringWithFormat:@"%lld",_player.currentItem.duration.value/_player.currentItem.duration.timescale] integerValue];
    NSLog(@"sss333  %ld",_pTime);
    if (_pTime == 0) {
        HUDCRY(@"语音无效", 1);
        return;
    }
    if (_pTime > 60) {
        _pTime = 60;
    }
    _pTime ++;
      _bVC.view.hidden = NO;
     [_bVC beginCustomView];
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeHandle) userInfo:nil repeats:YES];
    [self timeHandle];
  
    self.navigationController.view.userInteractionEnabled = NO;
}

- (void)audioPlayerBeginInterruption:(AVAudioPlayer *)player
{
   
}
-(void)hiddenTellView
{
    _bVC.view.hidden = YES;
    [_bVC stopCustomView];
   
//    [self.player.currentItem cancelPendingSeeks];
//    [self.player.currentItem.asset cancelLoading];
    
}

-(void)getData
{
//busiSystem
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

-(void)timeHandle
{
    _pTime--;
    NSString *p = [NSString stringWithFormat:@"%lld",[_player currentTime].value/[_player currentTime].timescale];
    NSLog(@"ddpp:%@",p);
//    UILabel *txtLb = [_btn viewWithTag:8211];
    if (_pTime == 0) {
        [_soundBtnCell setCellData:@{@"title":@"播放语音记录"}];
        [_soundBtnCell fitSendInfoMode];
//        _pTime = _initTime + 1;
        [_timer invalidate];
        [self hiddenTellView];
         self.navigationController.view.userInteractionEnabled = YES;
        return;
    }
    [_soundBtnCell setCellData:@{@"title":[NSString stringWithFormat:@"%lds",_pTime]}];
    [_soundBtnCell fitSendInfoMode];

}
-(void)initTableView
{
    _tableView.refreshHeaderView = nil;
    __weak SendInfoViewController *weakSelf = self;
    _imgTipCell = [OnlyTitleTableViewCell createTableViewCell];
    [_imgTipCell setCellData:@{@"title":@"照片"}];
    [_imgTipCell fitImgTipMode];
    _sapCell = [TitleDetailTableViewCell createTableViewCell];
    
    _imgsCell = [AddImgTableViewCell createTableViewCell];
  _imgsCell.mode = AddImgModeMutable;
    [_imgsCell setCellData:@{@"default":@"defaultServer",@"limitCount":@(_shoot.imagePath.count),@"arr":[_shoot getImgArr]?:@[],@"colCount":@3,@"hiddenDelBtn":@YES}];
    [_imgsCell fitSendInfoMode];
    [_imgsCell setHandleAction:^(NSDictionary *ddic) {
     if([ddic[@"method"] integerValue] == 2)
        {
            [weakSelf setupPhotoBrowser:@{@"arr":[weakSelf.shoot getImgArr]?:@[],@"row":ddic[@"row"],@"imgArr":ddic[@"imgvs"]}];
        }
        
    }];
    
    _contentTipCell = [OnlyTitleTableViewCell createTableViewCell];
    [_contentTipCell setCellData:@{@"title":@"描述"}];
    [_contentTipCell fitSendInfoMode];
    
    _contentCell = [OnlyTitleTableViewCell createTableViewCell];

    
    _soundBtnCell = [OnlyBottomBtnTableViewCell createTableViewCell];
    [_soundBtnCell setCellData:@{@"title":@"播放语音记录"}];
    [_soundBtnCell fitSendInfoMode];
    [_soundBtnCell setHandleAction:^(id o) {
        if (weakSelf.songItem.status == AVPlayerItemStatusReadyToPlay) {
            [weakSelf.songItem seekToTime:CMTimeMake(0,weakSelf.player.currentItem.duration.timescale)];
            [weakSelf.player play];
            [weakSelf showTellView];
        }
        else if(AVPlayerItemStatusFailed == weakSelf.songItem.status)
        {
        [weakSelf showTip:@"播放失败"];
        }
        else
        {
            [weakSelf showTip:@"录音准备中,请稍后"];
        }
        
       
    }];
    
    _phoneCell = [TitleDetailTableViewCell createTableViewCell];
  
    [_phoneCell fitServerInfoMode];
    
    _kefuTipCell = [OnlyTitleTableViewCell createTableViewCell];
    [_kefuTipCell setCellData:@{@"title":@"客服回复"}];
    [_kefuTipCell fitSendInfoMode];
    
    _kefuCell = [OnlyTitleTableViewCell createTableViewCell];
    [_kefuCell setCellData:@{@"title":_shoot.replyContent?:@""}];
    [_kefuCell fitSendInfoModeC];
    
    [_sapCell setCellData:@{@"title":@"归属园区",@"detail":_shoot.pakName?:@""}];
    [_sapCell fitSendInfoModeB];
    
    [_contentCell setCellData:@{@"title":_shoot.content?:@""}];
    [_contentCell fitSendInfoModeB];
    
}

-(void)showTip:(NSString *)str
{
    HUDCRY(str, 2);
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
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
    else if (section == 2)
    {
        row = 1;
    }
    else
    {
        row = 3;
    }
    
    return row;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    
    return 10;
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == 0 ||section == 1|| section == 2) {
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
    return 0.001;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 35;
    if(indexPath.section == 0)
    {
        if (indexPath.row == 0) {
            height = 35;
        }
        else
        {
            height = _imgsCell.height;
        }
        
        
    }
    else if (indexPath.section == 1)
    {
        if (indexPath.row == 0) {
            height = 34;
        }
        else if (indexPath.row == 1)
        {
            height = 110;
        }
        else
        {
            if (_shoot.voicePath && ![_shoot.voicePath isEqualToString:@""]) {
            height = 40;
                _soundBtnCell.hidden = NO;
            }
            else
            {
                _soundBtnCell.hidden = YES;
                height = 0;
            }
        }
        
    }
    else if (indexPath.section == 2)
    {
        height = 44;
    }
    else
    {
        if (indexPath.row == 0) {
           height = 44;
        }
        else if (indexPath.row == 1)
        {
              [_kefuCell fitSendInfoModeC];
           height = _kefuCell.height;
        }
        else
        {
            height = 44;
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
            cell = _imgTipCell;
            [_imgTipCell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(35, 0, 0, 0)];
        }
        else
        {
            cell = _imgsCell;
          
             [_imgsCell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(_imgsCell.height, 0, 0, 0)];
          
        }
    }
    else if (indexPath.section == 1)
    {
        if (indexPath.row == 0) {
            cell = _contentTipCell;
            [_contentTipCell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(44, 0, 0, 0)];
        }
        else if (indexPath.row == 1)
        {
            cell = _contentCell;
            
//             [_contentCell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(110, 0, 0, 0)];
        }
        else
        {
            cell = _soundBtnCell;
            [_soundBtnCell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(40, 0, 0, 0)];
        }
    }
    else if (indexPath.section == 2)
    {
        cell = _phoneCell;
          [_phoneCell setCellData:@{@"title":@"联系电话",@"detail":_shoot.susId?:@""}];
          [_phoneCell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(44, 0, 0, 0)];
    }
    else
    {
        if (indexPath.row == 0) {
            cell = _kefuTipCell;
            [_kefuTipCell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(44, 0, 0, 0)];
        }
        else if (indexPath.row == 1)
        {
            cell = _kefuCell;
            
             [_kefuCell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(_kefuCell.height, 0, 0, 0)];
        }
        else
        {
            cell = _sapCell;
          [_sapCell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(44, 0, 0, 0)];
        }
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
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
                photo.thumbImage = [UIImage imageContentWithFileName:@"defaultServer"];
                photo.photoImage = [UIImage imageContentWithFileName:@"defaultServer"];
            }
        }
        photo.aspectRatioImage = ii;
        photo.toView = imgArr[i];
        [mArr addObject:photo];
    }
    return mArr;
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary*)change context:(void *)context {
    
    if ([keyPath isEqualToString:@"status"]) {
        switch (self.player.status) {
            case AVPlayerStatusUnknown:
                HUDCRY(@"KVO：未知状态，此时不能播放",1);
                break;
            case AVPlayerStatusReadyToPlay:
//                self.status = SUPlayStatusReadyToPlay;
                HUDSMILE(@"KVO：准备完毕，可以播放",1);
                break;
            case AVPlayerStatusFailed:
                HUDCRY(@"KVO：加载失败，网络或者服务器出现问题",1);
                break;
            default:
                break;
        }
    }
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
