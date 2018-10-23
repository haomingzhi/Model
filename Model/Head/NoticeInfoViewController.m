//
//  NoticeInfoViewController.m
//  taihe
//
//  Created by air on 2016/11/16.
//  Copyright © 2016年 ORANLLC_IOS1. All rights reserved.
//

#import "NoticeInfoViewController.h"
#import "ZLPhotoPickerViewController.h"
#import "ZLPhotoPickerBrowserViewController.h"
#import "ZLPhotoPickerBrowserPhoto.h"
#import "ZLPhotoAssets.h"
#import "BUSystem.h"
#import "JYShareManager.h"
@interface NoticeInfoViewController ()
{
  
}


@property (strong, nonatomic)BUGetNotice *notice;
@end

@implementation NoticeInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"公告详情";
    [self setRightNavBtn];
    [self initData];
    [self initTableView];
    self.view.backgroundColor = kUIColorFromRGB(color_2);
}

-(void)puv:(NSString *)stId
{
    [busiSystem.agent updatePUV:stId observer:self callback:@selector(updatePUVNotification:)];
}

-(void)updatePUVNotification:(BSNotification*)noti
{

}

-(void)handleDidRightButton:(id)sender
{
    [self getShareData];
}

-(void)getShareData
{
    [busiSystem.agent getShare:busiSystem.agent.sapid withEntityid:_notice.stoId withType:@"1" observer:self callback:@selector(getShareNotification:)];
}

-(void)getShareNotification:(BSNotification *)noti
{
    if (noti.error.code == 0) {
        HUDDISMISS;
        [self showShareView:busiSystem.agent.shareData];
    }
    else
    {
        HUDCRY(noti.error.domain, 1);
    }
}

-(void)showShareView:(NSString*)dt
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"taihelogo@2x" ofType:@"png"];
    [[JYShareManager manager] showSheetView:self withShareTitle:@"分享了来自\"泰禾云海\"的公告" withShareContent:_notice.title?:@"" withShareImgUrl:path   withUrl:dt];
}

-(void)initData
{
    if ([_userInfo isKindOfClass:[BUGetNotice class]]) {
        _notice = _userInfo;
        [self puv:_notice.stoId];
    }
    else
    {
        HUDSHOW(@"加载中");
        [self getData];
          [self puv:_userInfo];
    }
}

-(void)getData
{
    [busiSystem.getNoticeManager getNotice:busiSystem.agent.sapid withStcid:_userInfo observer:self callback:@selector(getNoticeNotification:)];
}

-(void)getNoticeNotification:(BSNotification*)noti
{
    if(noti.error.code == 0)
    {
             HUDDISMISS;
        _notice = busiSystem.getNoticeManager.notice;
        [_tableView reloadData];
    }
    else
    {
        HUDCRY(noti.error.domain, 1);
    }

}
-(void)initTableView
{
    _tableView.refreshFooterView = nil;
    _tableView.refreshHeaderView = nil;
    _flashCell = [FlashTableViewCell createTableViewCell];
   
    [_flashCell fitHeadMode];
    _flashCell.handleAction = ^(NSDictionary *didc){
        NSIndexPath *indexPath = didc[@"row"];
//          [weakSelf setupPhotoBrowser:@{@"arr":[weakSelf.shoot getImgArr]?:@[],@"row":ddic[@"row"],@"imgArr":ddic[@"imgvs"]}];
    };
    
    _titleCell = [OnlyTitleTableViewCell createTableViewCell];
    
    _infoCell = [TitleDetailTableViewCell createTableViewCell];
    
    _contentCell = [OnlyTitleTableViewCell createTableViewCell];
}

-(void)setRightNavBtn
{
    //    [self setNavigateRightButton:btnStr font:[UIFont systemFontOfSize:15] color:[UIColor whiteColor]];
    [self setNavigateRightButton:@"nav_share"];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger row = 4;
    
    return row;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    
    return 0.001;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.001;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 90;
    if (indexPath.row == 0) {
        height = __SCREEN_SIZE.width * 400/720.0;
    }
    else if(indexPath.row == 1)
    {
        [_titleCell fitNoticeInfoMode];
        height = _titleCell.height;
    }
    else if (indexPath.row == 2)
    {
        height = 24;
    }
    else
    {
         [_contentCell fitNoticeInfoModeB];
        height = _contentCell.height;
    }

    return height;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    if (indexPath.row == 0) {
        cell = _flashCell;
        [_flashCell setCellData:@{@"arr":[_notice getImgArr]?:[NSMutableArray new]}];
    }
    else if(indexPath.row == 1)
    {
        cell = _titleCell;
        [_titleCell setCellData:@{@"title":_notice.title?:@""}];
        [_titleCell fitNoticeInfoMode];
    }
    else if (indexPath.row == 2)
    {
        cell = _infoCell;
        [_infoCell setCellData:@{@"title":[NSString stringWithFormat:@"浏览 %ld",_notice.pv],@"detail":[NSString stringWithFormat:@"发布时间 %@",[_notice.createTime substringToIndex:MIN(10, _notice.createTime.length)]]}];
        [_infoCell fitNoticeInfoMode];
    }
    else
    {
        cell = _contentCell;
        [_contentCell setCellData:@{@"title":_notice.content?:@""}];
        [_contentCell fitNoticeInfoModeB];
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
