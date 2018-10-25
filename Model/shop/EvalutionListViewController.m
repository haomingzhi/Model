//
//  EvalutionListViewController.m
//  intelligentgarbagecollection
//
//  Created by Steve on 2017/12/6.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import "EvalutionListViewController.h"
#import "ImgsTableViewCell.h"
#import "ImgAndThreeTitleTableViewCell.h"
#import "BUSystem.h"
#import "ZLPhotoPickerViewController.h"
#import "ZLPhotoPickerBrowserViewController.h"
#import "ZLPhotoPickerBrowserPhoto.h"
#import "ZLPhotoAssets.h"

@interface EvalutionListViewController ()

@end

@implementation EvalutionListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
     self.title = @"评价";
     [self initTableView];
     HUDSHOW(@"加载中");
     [self getData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)getData{
//     [busiSystem.getCommentListManager getCommentList:@"" orderId:@"" orderType:@"0" goodsId:_goodsId?:@"" courierId:@"" observer:self callback:@selector(getCommentListNotification:)];
}


-(void)getCommentListNotification:(BSNotification *)noti
{
     HUDDISMISS;
     if (noti.error.code == 0) {
//          _tableView.dataArr = [NSMutableArray arrayWithArray:busiSystem.getCommentListManager.getCommentList];
//          _tableView.hasMore = busiSystem.getCommentListManager.pageInfo.hasMore;
          [_tableView reloadData];
          [[JYNoDataManager manager] addNodataView:_tableView withTip:@"暂无信息" withImg:@"nodata" withCount:_tableView.dataArr.count withTag:@"nodata"];
          [[JYNoDataManager manager] fitModeY:100];
          [ImgAndThreeTitleTableViewCell registerTableViewCell:_tableView];
     }
     else
     {
          HUDCRY( noti.error.domain , 1);
     }
}

-(void)initTableView{
     
     
     
     
     [ImgAndThreeTitleTableViewCell registerTableViewCell:_tableView];
     [ImgsTableViewCell registerTableViewCell:_tableView];
     
     _tableView.x=0;
     _tableView.y = 0;//- __NAVBAR_HEIGHT -__STATUSBAR_HEIGHT;
     _tableView.width = __SCREEN_SIZE.width;
     _tableView.height = __SCREEN_SIZE.height-64;
     _tableView.refreshHeaderView = nil;
     _tableView.delegate = self;
     _tableView.dataSource = self;
     _tableView.backgroundColor = kUIColorFromRGB(color_4);
     _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
     
     
}



#pragma mark - tableView delegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
     NSInteger section = _tableView.dataArr.count;
     return section;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
     NSInteger row = 2;
     return row;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
     UITableViewCell *cell;
     //    cell = [UITableViewCell new];
     cell = [self createEvaInfoCell:indexPath];
     
     cell.selectionStyle = UITableViewCellSelectionStyleNone;
     return cell;
}

-(UITableViewCell *)createEvaInfoCell:(NSIndexPath *)indexPath{
     UITableViewCell *cell ;
//     BUGetComment *comment = _tableView.dataArr[indexPath.section];
     
     if (indexPath.row == 0) {
          cell = [ImgAndThreeTitleTableViewCell dequeueReusableCell:_tableView];
//          [(ImgAndThreeTitleTableViewCell *)cell setCellData:[comment getDic:0]];
          [(ImgAndThreeTitleTableViewCell *)cell fitEvaMode];
          if (0) {
               [(JYAbstractTableViewCell *)cell showSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(cell.height, 0, 0, 0)];
          }else{
               [(JYAbstractTableViewCell *)cell hiddenSeparatorView];
          }
     }else{
          cell = [ImgsTableViewCell dequeueReusableCell:_tableView];
          
          
          if ( 0) {
               cell.hidden = YES;
               [(JYAbstractTableViewCell *)cell hiddenSeparatorView];
          }else{
//               [(ImgsTableViewCell *)cell setCellData:[comment getDic:1]];
               [(ImgsTableViewCell *)cell fitMode];
               [(JYAbstractTableViewCell *)cell showSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(cell.height, 0, 0, 0)];
          }
          __weak EvalutionListViewController *weakSelf = self;
          [(ImgsTableViewCell *)cell setHandleAction:^(NSDictionary *dic) {
               NSInteger row = [dic[@"row"] integerValue];
               NSMutableArray *imgArr = [NSMutableArray new];
//               NSArray *arr = comment.picList;
//               if (arr.count !=0) {
//                    for (int i =0;i<arr.count;i++) {
//                         UIImageView *myImageView = [[UIImageView alloc]init];
//                         [imgArr addObject:myImageView];
//                    }
//                    [weakSelf setupPhotoBrowser:@{@"arr":arr?:@[],@"row":@(row),@"imgArr":imgArr}];
//               }
          }];
          
     }
     cell.selectionStyle = UITableViewCellSelectionStyleNone;
     return cell;
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
     CGFloat height = 35;
//     BUGetComment *comment = _tableView.dataArr[indexPath.section];
     if (indexPath.row == 0) {
          ImgAndThreeTitleTableViewCell *cell = [ImgAndThreeTitleTableViewCell dequeueReusableCell:_tableView];
          
//          [cell setCellData:[comment getDic:0]];
          [cell fitEvaMode];
          height = cell.height;
     }else{
//          if (comment.picList.count == 0) {
//               height = 0.001;
//          }else{
//               ImgsTableViewCell *cell = [ImgsTableViewCell dequeueReusableCell:_tableView];
//               NSMutableArray *arr = [NSMutableArray new];
//               [(ImgsTableViewCell *)cell setCellData:[comment getDic:1]];
//               [(ImgsTableViewCell *)cell fitMode];
//               [(ImgsTableViewCell *)cell fitMode];
//               height = cell.height;
//          }
          
     }
     
     
     return height;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
  
     return 0.001;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

     return 0.001;
}


-(void)loadNextPage{
//     [busiSystem.getCommentListManager getCommentListNextPage:self callback:@selector(getCommentListNotification:)];
}



#pragma mark - photo

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
                    photo.thumbImage = [UIImage imageContentWithFileName:@"default"];
                    photo.photoImage = [UIImage imageContentWithFileName:@"default"];
               }
          }
          photo.aspectRatioImage = ii;
          photo.toView = imgArr[i];
          [mArr addObject:photo];
     }
     return mArr;
}

@end
