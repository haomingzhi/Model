//
//  ReviewingViewController.m
//  compassionpark
//
//  Created by air on 2017/2/15.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import "ReviewingViewController.h"
#import "OnlyTextViewTableViewCell.h"
#import "OnlyTitleTableViewCell.h"
#import "AddImgTableViewCell.h"
#import "TextViewCanChangeTableViewCell.h"
#import "ImgTitleDetailFiveBtnTableViewCell.h"
#import "ZLPhotoPickerViewController.h"
#import "ZLPhotoPickerBrowserViewController.h"
#import "ZLPhotoPickerBrowserPhoto.h"
#import "ZLPhotoAssets.h"
#import "BUSystem.h"

@interface ReviewingViewController ()
{
   
    OnlyTitleTableViewCell *_imgTipCell;
    ImgTitleDetailFiveBtnTableViewCell *_commentCell;
    TextViewCanChangeTableViewCell *_textViewCell;
    NSString *_orderId;
     NSString *_goodsId;
    NSString *_content;
    NSString *_type;
    NSString *_imgs;
    NSString *_star;
    NSMutableArray *_imgUrlArr;
}
@property(nonatomic,strong)  NSMutableArray *imgArr;
@property (strong, nonatomic) IBOutlet MyTableView *tableView;
@property (strong, nonatomic) AddImgTableViewCell *imgsCell;
@end

@implementation ReviewingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"写评价";
      _imgArr = [NSMutableArray new];
    _imgUrlArr = [NSMutableArray new];
    [self setRightNav];
    [self initTableView];
}

-(void)setRightNav
{
    [self setNavigateRightButton:@"提交" font:[UIFont systemFontOfSize:15] color:kUIColorFromRGB(color_5)];
}

-(void)handleDidRightButton:(id)sender
{
    [self submit];
}

-(void)submit
{
    _orderId = _userInfo[@"id"];
    _goodsId = _userInfo[@"goodsId"]?:@"";
    _type = _userInfo[@"type"]?:@"1";
    _content = _textViewCell.textView.text;
    HUDSHOW(@"提交中");
//    [busiSystem.getCommentListManager addComment:_content?:@"" withStar:_star?:@"5" withOrderid:_orderId?:@"" withGoodsid:_goodsId?:@"" withType:_type?:@"" withImgArr:_imgUrlArr  observer:self callback:@selector(addCommentNotification:)];
}

-(void)addCommentNotification:(BSNotification*)noti
{
    if (noti.error.code == 0) {
        HUDSMILE(@"评价完成", 2);
        [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshOrderList" object:nil];
        [self performSelector:@selector(toNextVC) withObject:nil afterDelay:2];
    }
    else
    {
        HUDCRY(noti.error.domain, 2);
    }
}

-(void)toNextVC
{
      [self.navigationController popViewControllerAnimated:YES];
}

-(void)initTableView
{
     __weak ReviewingViewController *weakSelf = self;
    _commentCell = [ImgTitleDetailFiveBtnTableViewCell createTableViewCell];
    [_commentCell setCellData:@{@"title":@"评分",@"detail":@"满意",@"img":_userInfo[@"img"],@"default":@"default"}];
     [_commentCell fitCommentMode];
    [_commentCell setHandleAction:^(NSDictionary *dic) {
        NSInteger sc = [dic[@"score"] integerValue];
        [weakSelf fitScore:sc];
    }];
    _textViewCell = [TextViewCanChangeTableViewCell createTableViewCell];
    [_textViewCell setCellData:@{@"placeholder":@"请输入您的评价内容.."}];
    [_textViewCell fitCommentMode];
    
    _imgTipCell = [OnlyTitleTableViewCell createTableViewCell];
    [_imgTipCell setCellData:@{@"title":@"有图有真相,上图晒一晒~"}];
    [_imgTipCell fitCommentMode];
    _imgsCell = [AddImgTableViewCell createTableViewCell];
    [_imgsCell setCellData:@{@"arr":@[],@"limitCount":@3,@"default":@"",@"colCount":@3,@"hiddenDelBtn":@NO}];
    [_imgsCell fitCommentMode];
    [_imgsCell initAddPhotoManager:3 withImgArr:self.imgArr withVC:self withTableView:self.tableView];
    [_imgsCell.addPhotoManager setCheckDoneCallBack:^(NSDictionary *dic){
        NSMutableArray *arr = dic[@"arr"];
//        if(weakSelf.imgArr.count > 3)
//        {
//            [weakSelf.imgArr removeObjectsInRange:NSMakeRange(3, weakSelf.imgArr.count - 3)];
//        }
//        [weakSelf.imgsCell setCellData:@{@"limitCount":@3,@"arr":weakSelf.imgArr,@"colCount":@3}];
//        [self uploadImg:@"0" withImgArr:arr];
         [weakSelf.imgsCell fitCommentMode];
         [weakSelf.tableView reloadData];
    }];
    [_imgsCell setHandleAction:^(NSDictionary *ddic) {
        if([ddic[@"method"] integerValue] == 1)
        {
            [weakSelf.imgsCell  toCheckOption:@{@"count":@(3 -weakSelf.imgArr.count)}];
        }
        else if([ddic[@"method"] integerValue] == 2)
        {
            [weakSelf.imgsCell setupPhotoBrowser:@{@"arr":weakSelf.imgArr,@"row":ddic[@"row"],@"imgArr":ddic[@"imgvs"]}];
        }
        else
        {
            [weakSelf.imgsCell delImg:[ddic[@"row"] integerValue]];
             [weakSelf.imgsCell fitCommentMode];
             [weakSelf.tableView reloadData];
        }
    }];
    
    
    _tableView.backgroundColor = kUIColorFromRGB(color_4);
    _tableView.refreshHeaderView = nil;
}

-(void)fitScore :(NSInteger)sc
{
    NSString *scStr = @"满意";
    switch (sc) {
        case 1:
        {
        scStr = @"极不满意";
            _star = @"1";
        }
            break;
        case 2:
        {
            scStr = @"不满意";
              _star = @"2";
        }
            break;
        case 3:
        {
         scStr = @"一般";
              _star = @"3";
        }
            break;
        case 4:
        {
         scStr = @"较满意";
              _star = @"4";
        }
            break;
        case 5:
        {
         scStr = @"满意";
              _star = @"5";
        }
            break;
        default:
            break;
    }
    _commentCell.detailLb.text = scStr;
    
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
    NSInteger height = 44;
    if (indexPath.row == 0) {
        height = 91;
    }
    else if (indexPath.row == 1)
    {
        height = 150;
    }
    else if (indexPath.row == 2)
    {
        height = 50;
    }
    else
    {
        height = _imgsCell.height;
    }
    return height;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    if (indexPath.row == 0) {
        cell = _commentCell;
        [_commentCell showCustomSeparatorView:kUIColorFromRGB(color_mainTheme) withInsets:UIEdgeInsetsMake(91, 0, 0, 0)];
    }
    else if (indexPath.row == 1)
    {
        cell = _textViewCell;
        [_textViewCell showCustomSeparatorView:kUIColorFromRGB(color_mainTheme) withInsets:UIEdgeInsetsMake(150, 0, 0, 0)];
    }
    else if (indexPath.row == 2)
    {
        cell = _imgTipCell;
    }
    else
    {
        cell = _imgsCell;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


#pragma mark --相册的选取照片
-(void)toPhoto
{
    __weak ReviewingViewController *weakSelf = self;
    
    [[CommonAPI managerWithVC:weakSelf] showPhotoOption:nil withUserInfo:@{@"count":@(3)}];//限定只能选取一张照片
}



#pragma mark -- 选取照片确定
- (void)pickerViewControllerDoneAsstes:(NSArray *)assets{
   NSMutableArray        *iArr = [NSMutableArray array];
    [assets enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        ZLPhotoAssets *asset = (ZLPhotoAssets *)obj;
        UIImage *img = [asset originImage];
        //        UIImage *image =  [img getSubImage:CGRectMake(0, 0, __SCREEN_SIZE.width, 108*2) centerBool:YES];
        [_imgArr addObject:img];
        [iArr addObject:img];
    }];
    if(_imgArr.count > 3)
    {
        [_imgArr removeObjectsInRange:NSMakeRange(3, _imgArr.count - 3)];
    }
    [_imgsCell setCellData:@{@"limitCount":@3,@"arr":_imgArr,@"colCount":@3}];
  [self uploadImg:@"0" withImgArr:iArr];
    [self dismissViewControllerAnimated:YES completion:nil];
}

//拍照:
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    UIImage *img = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    //    UIImage *image = [img getSubImage:CGRectMake(0, 0,img.size.width, img.size.width * (106/320.0)*2) centerBool:YES];
    [_imgArr addObject:img];
    [_imgsCell setCellData:@{@"limitCount":@3,@"arr":_imgArr,@"colCount":@3}];
       [self uploadImg:@"0" withImgArr:@[img]];
//    _imgsCell.height = 105;
    [picker dismissViewControllerAnimated:YES completion:nil];
}

//点击cancel 调用的方法
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
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
    [_imgsCell setCellData:@{@"limitCount":@3,@"arr":_imgArr,@"colCount":@3}];
    [_tableView reloadData];
    [self delImg:@"" withImgUrl:_imgUrlArr[indexPath]];
    [_imgUrlArr removeObjectAtIndex:indexPath];
}

-(void)uploadImg:(NSString *)type withImgArr:(NSArray *)imgArr
{
    //    for (NSInteger i = 0; i < imgArr.count; i++) {
    //        UIImage *im = imgArr[i];
    HUDSHOW(@"上传中");
//    [busiSystem.agent uploadImgs:imgArr withType:type withId:_userInfo[@"goodsId"] observer:self callback:@selector(uploadImgNotification:)];
    
    //    }
}

-(void)uploadImgNotification:(BSNotification *)noti
{
    if (noti.error.code  == 0) {
        HUDSMILE(@"上传成功", 1);
        [busiSystem.agent.imgCerArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            BUImageRes *im = obj;
          [_imgUrlArr addObject:im.Image];
        }];
       
    }
    else
    {
        HUDCRY(noti.error.domain, 2);
    }
}

-(void)delImg:(NSString *)aid withImgUrl:(NSString *)url
{
//    HUDSHOW(@"删除中");

//    [busiSystem.agent delImageFile:_userInfo[@"goodsId"]  withImagepath:url observer:self callback:@selector(delImageFileNotification:) extraInfo:nil];
}

-(void)delImageFileNotification:(BSNotification*)noti
{
    if (noti.error.code  == 0) {
        HUDDISMISS
    }
    else
    {
        HUDCRY(noti.error.domain, 2);
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
