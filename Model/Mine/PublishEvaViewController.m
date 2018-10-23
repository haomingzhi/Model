//
//  WriteEvaluationViewController.m
//  oranllcshoping
//
//  Created by Steve on 2017/7/31.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import "PublishEvaViewController.h"
#import "TitleDetailTableViewCell.h"
#import "AddImgTableViewCell.h"
#import "OnlyTitleTableViewCell.h"
#import "OnlyBottomBtnTableViewCell.h"
#import "TitleAndImageTableViewCell.h"
#import "TextViewCanChangeTableViewCell.h"
#import "BUSystem.h"

@interface ImgInfo:NSObject
@property(nonatomic,strong)  NSMutableArray *imgArr;
@property(nonatomic,strong)  NSMutableArray *upimgArr;
@property(nonatomic,strong) NSString *name;
@property(nonatomic,strong) NSString *goodsId;
@property(nonatomic,strong) NSString *comment;
@property(nonatomic,strong) BUImageRes *imagePath;
@property(nonatomic)CGFloat height;
@end

@implementation ImgInfo
@end

@interface PublishEvaViewController (){


     TextViewCanChangeTableViewCell *_textViewCell;

     OnlyTitleTableViewCell *_tipCell;
     OnlyBottomBtnTableViewCell *_submitCell;
     
}
@property (strong, nonatomic) IBOutlet MyTableView *tableView;
@property(nonatomic,strong)  AddImgTableViewCell *imgsCell;
@property(nonatomic,strong)  NSMutableArray *imgArr;
@property(nonatomic,strong)  NSMutableArray *upimgArr;
//@property(nonatomic,strong) NSIndexPath *curCommentIndexPath;
//@property (nonatomic,assign) NSInteger disScore;
//@property (nonatomic,assign) NSInteger evaScore;
//@property (nonatomic,assign) NSInteger goodsCount;//商品个数
@end

@implementation PublishEvaViewController

- (void)viewDidLoad {
     [super viewDidLoad];
//     _evaScore = 5;
//     _disScore = 5;
     _imgArr = [NSMutableArray new];
     _upimgArr = [NSMutableArray new];
     self.goodsCount = 1;//_order.goodsList.count;

     [self initTableView];
     self.title = @"发布评价";
//     [self addBottomView];
}



-(void)setGoodsCount:(NSInteger)goodsCount
{
//     _goodsCount = goodsCount;
//     for (NSInteger i = 0; i < _goodsCount; i++) {
//          ImgInfo *im = [ImgInfo new];
//          im.upimgArr = [NSMutableArray new];
//          im.imgArr = [NSMutableArray new];
//          [_imgInfoArr addObject:im];
//        BUGoods *gd = _order.goodsList[i];
//          im.goodsId = gd.goodsId;
//          im.name = gd.goodsName;
//          im.imagePath = gd.goodsImage;
//          im.height = 115;
//     }
}
//-(void)addBottomView
//{
//     _submitCell.width = __SCREEN_SIZE.width;
//     _submitCell.y = __SCREEN_SIZE.height - 64 - 44;
//     _submitCell.x = 0;
//     [self.view addSubview:_submitCell];
//}
//-(void)viewDidLayoutSubviews
//{
//     _tableView.height = __SCREEN_SIZE.height - 64 - 46;
//     _tableView.width = __SCREEN_SIZE.width;
//}
- (void)didReceiveMemoryWarning {
     [super didReceiveMemoryWarning];
     // Dispose of any resources that can be recreated.
}

-(void)initTableView
{
     _tableView.refreshHeaderView = nil;
     __weak PublishEvaViewController *weakSelf = self;
//     [TitleAndImageTableViewCell registerTableViewCell:_tableView];
//     [AddImgTableViewCell registerTableViewCell:_tableView];
//     [TextViewCanChangeTableViewCell registerTableViewCell:_tableView];

//     _evaCell = [TitleDetailTableViewCell createTableViewCell];
//     [_evaCell setCellData:@{@"title":@"商品评分",@"detail":@"非常好"}];
//     [_evaCell fitPublishEvaMode];
//     [_evaCell setHandleAction:^(NSDictionary *dic){
//          NSInteger sc = [dic[@"score"] integerValue];
//          weakSelf.evaScore = sc;
//          [weakSelf fitScoreEvaMode:sc type:0];
//     }];


     
     _textViewCell = [TextViewCanChangeTableViewCell createTableViewCell];
     [_textViewCell setCellData:@{@"placeholder":@"宝贝是否满足了你的期待？"}];
     [_textViewCell fitPublishEvaMode];
     _textViewCell.textView.kbMovingView = self.view;

     _tipCell = [OnlyTitleTableViewCell createTableViewCell];
     [_tipCell setCellData:@{@"title":@"上传图片(最多9张)"}];
     [_tipCell fitPublishEvaMode];

     _imgsCell = [AddImgTableViewCell createTableViewCell];
     [_imgsCell setCellData:@{@"arr":@[],@"limitCount":@9,@"default":@"",@"colCount":@3,@"hiddenDelBtn":@NO}];
     _imgsCell.mode = AddImgModeMutable;
     [_imgsCell fitPublishEvaMode];
     __weak AddImgTableViewCell *wcc =  (AddImgTableViewCell*)_imgsCell;
     [(AddImgTableViewCell*)_imgsCell initAddPhotoManager:9 withImgArr:self.imgArr withVC:self withTableView:self.tableView];
     [_imgsCell.addPhotoManager setCheckDoneCallBack:^(NSDictionary *dic){
          NSMutableArray *arr = dic[@"arr"];
          //        if(weakSelf.imgArr.count > 3)
          //        {
          //            [weakSelf.imgArr removeObjectsInRange:NSMakeRange(3, weakSelf.imgArr.count - 3)];
          //        }
//                    [self uploadImg:@"0" withImgArr:arr];
//          ImgInfo *imginfo =  self.imgInfoArr[indexPath.section];
          //                     NSMutableArray *darr = [NSMutableArray arrayWithArray:imginfo.imgArr];
          //                     [darr addObjectsFromArray:arr];
          //                     [wcc setCellData:@{@"limitCount":@9,@"arr":darr,@"colCount":@3}];
 [weakSelf.upimgArr addObjectsFromArray: arr];
//          [self upImg:arr withIndexPath:indexPath];
          [wcc fitPublishEvaMode];
//          imginfo.height = wcc.height;
          [weakSelf.tableView reloadData];
     }];
     [(AddImgTableViewCell*)_imgsCell setHandleAction:^(NSDictionary *ddic) {
          if([ddic[@"method"] integerValue] == 1)
          {
               [wcc  toCheckOption:@{@"count":@(9 - _imgArr.count)}];
          }
          else if([ddic[@"method"] integerValue] == 2)
          {
               [wcc setupPhotoBrowser:@{@"arr":_imgArr,@"row":ddic[@"row"],@"imgArr":ddic[@"imgvs"]}];
          }
          else
          {
               [wcc delImg:[ddic[@"row"] integerValue]];
               [_upimgArr removeObjectAtIndex:[ddic[@"row"] integerValue]];
               [wcc fitPublishEvaMode];
               [weakSelf.tableView reloadData];
          }
     }];

     _submitCell = [OnlyBottomBtnTableViewCell createTableViewCell];
     [_submitCell setCellData:@{@"title":@"提交"}];
        [_submitCell fitPublishEvaMode];
     [_submitCell setHandleAction:^(id sender) {
          [weakSelf submit];
     }];
     
}

-(void)submit{
     if (_textViewCell.textView.text.length == 0) {
          HUDCRY(@"请输入商品评价", 2);
          return;
     }
//     if (_disTextViewCell.textView.text.length == 0) {
//          HUDCRY(@"请输入配送评价", 2);
//          return;
//     }
     HUDSHOW(@"提交中");
//     NSString *evaScoreStr = [NSString stringWithFormat:@"%d",_evaScore];
//     NSString *disScoreStr = [NSString stringWithFormat:@"%d",_disScore];
//     NSMutableArray *commentList = [NSMutableArray new];
//     [_imgInfoArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//          ImgInfo *io = obj;
//BUGetComment *cn = [BUGetComment new];
//          cn.type = 1;
//          cn.goodsId = io.goodsId;
//          cn.content = io.comment;
//          cn.imageList = io.upimgArr;
//          if ((!cn.content||[cn.content isEqualToString:@""])&&(!cn.imageList||cn.imageList.count == 0)) {
//
//          }
//          else
//          {
//               [commentList addObject:cn];
//          }
//     }];
//     BUGetComment *cn = [BUGetComment new];
//     cn.content = _textViewCell.textView.text;
//     cn.type = 2;
////     cn.orderId = _order.orderId;
////     cn.goodsId =
//     cn.courierId = _order.courierId?:@"";
//     [commentList addObject:cn];
//     [busiSystem.getCommentListManager addComment:@"" withOrderid:_order.orderId withCommentList:commentList observer:self callback:@selector(addCommentNotification:)];
     if(_imgArr.count == 0)
     {
          [busiSystem.myPathManager addOrderMsg:_textViewCell.textView.text withOrderid:_order.orderID withUserid:busiSystem.agent.userId observer:self callback:@selector(addCommentNotification:)];
     }
     else
     {
          [busiSystem.myPathManager addOrderMsg:_textViewCell.textView.text withImg:_imgArr withOrderid:_order.orderID withUserid:busiSystem.agent.userId observer:self callback:@selector(addCommentNotification:)];
     }
}


-(void) addCommentNotification:(BSNotification *) noti
{

     if (noti.error.code == 0) {
          HUDSMILE(@"评价成功", 2);
          [self performSelector:@selector(goback) withObject:nil afterDelay:2];
          busiSystem.agent.isNeedRefreshTabD = YES;
     }else{
          HUDCRY(noti.error.domain, 2);
     }
     
}

-(void)goback{
     if (self.handleGoBack) {
          self.handleGoBack(@{});
     }
     [self.navigationController popViewControllerAnimated:YES];
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
     return  1;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section;
{
     
     return  nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
     
     return 0.001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
     return 10;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
     return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
     CGFloat height = 44;

     if (indexPath.row == 0) {
          height = 150;
     }
     else if (indexPath.row == 1)
     {
          height = 32;
     }

     else  if (indexPath.row == 2)
     {
          height = _imgsCell.height;
     }

     else
     {
          height = 85;
     }
     return height;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
     NSInteger row = 4;

     return row;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//     __weak PublishEvaViewController *weakSelf = self;
     UITableViewCell *cell;

          if (indexPath.row == 0) {

               cell = _textViewCell;

          }
     else if(indexPath.row == 1)
     {
          cell = _tipCell;
     }
     else if(indexPath.row == 2)
     {
          cell= _imgsCell;
     }
     else
     {
          cell = _submitCell;
     }

     cell.selectionStyle = UITableViewCellSelectionStyleNone;
     return cell;
}
//- (void)textViewDidChange:(UITextView *)textView
//{
//
//}
-(void)upImg:(NSArray *)arr withIndexPath:(NSIndexPath *)indexPath
{
//     HUDSHOW(@"加载中");
//     _curCommentIndexPath = indexPath;
//     [busiSystem.agent uploadImgs:arr observer:self callback:@selector(uploadImgsNotification:)];
}

-(void)uploadImgsNotification:(BSNotification *)noti
{
     if (noti.error.code == 0) {
//           NSIndexPath *indexPath = _curCommentIndexPath;//noti.extraInfo[@"row"];
//          _curCommentIndexPath = nil;
//          HUDDISMISS;
//
//      ImgInfo *imginfo =  self.imgInfoArr[indexPath.section];
//          [imginfo.upimgArr addObjectsFromArray: busiSystem.agent.imgsList];
//             [_tableView reloadData];
     }
     else
     {

          HUDCRY(noti.error.domain, 1);
     }
}
@end
