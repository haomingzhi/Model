//
//  ImgTableViewCell.m
//  ChaoLiu
//
//  Created by air on 15/7/16.
//  Copyright (c) 2015年 ORANLLC_IOS1. All rights reserved.
//

#import "ImgTableViewCell.h"
#import "BUSystem.h"
@implementation ImgTableViewCell
{
    IBOutlet UIImageView *_imgV;
    BUImageRes *_curImgRes;
     NSDictionary *_dataDic;
}
- (void)awakeFromNib {
    // Initialization code
//    self.height = __SCREEN_SIZE.width - 20;
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(imgChangeHandle:) name:@"imgChange" object:self];
     _imgV.contentMode = UIViewContentModeCenter;
}

-(void)imgChangeHandle:(NSNotification *)noti
{
     if (self.imgChangeHandle) {
          self.imgChangeHandle(nil);
     }
     else
     {

     }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)dealloc
{
     [[NSNotificationCenter defaultCenter] removeObserver:self];
}
-(void)setCellData:(NSDictionary *)dataDic
{
     _dataDic = dataDic;
    id imgObjc = dataDic[@"img"];
    _imgV.image = [UIImage imageContentWithFileName:dataDic[@"default"]];
     _imgV.contentMode = UIViewContentModeCenter;
     _imgV.backgroundColor = kUIColorFromRGB(color_f8f8f8);
    if ([imgObjc isKindOfClass:[BUImageRes class]]) {
        BUImageRes *img = (BUImageRes *)imgObjc;
        _curImgRes = img;
        if (img.isCached) {
//            UIImage *im =  [[UIImage imageWithContentsOfFile:img.cacheFile] getSubImage:CGRectMake(0, 0, __SCREEN_SIZE.width, 400/720.0 * __SCREEN_SIZE.width) centerBool:YES];
             UIImage *im =  [UIImage imageWithContentsOfFile:img.cacheFile];
            if (im) {
                _imgV.image = im;
               _imgV.contentMode = UIViewContentModeScaleToFill;
            }
            
        }
        else {
            [img download:self callback:@selector(getImgNotification:) extraInfo:nil];
        }
    }
    else if([imgObjc isKindOfClass:[NSString class]])
    {
        if ([imgObjc isEqualToString:@""]) {
            return;
        }
         UIImage *im = [UIImage imageNamed:imgObjc];//[[UIImage imageNamed:imgObjc] getSubImage:CGRectMake(0, 0, __SCREEN_SIZE.width - 30, 105/330.0 * (__SCREEN_SIZE.width - 30)) centerBool:YES];;
        if (im) {
             _imgV.contentMode = UIViewContentModeScaleToFill;
            _imgV.image = im;
        }
        
    }
    else if([imgObjc isKindOfClass:[UIImage class]])
    {
         _imgV.contentMode = UIViewContentModeCenter;
         _imgV.image = imgObjc;//[imgObjc getSubImage:CGRectMake(0, 0, __SCREEN_SIZE.width, 400/720.0 * __SCREEN_SIZE.width) centerBool:YES];;
    }
}

-(void)getImgNotification:(BSNotification *) noti
{
    if(noti.error.code ==0)
    {
        BUImageRes *res =(BUImageRes *) noti.target;
        if (_curImgRes != res) {
            return;
        }
        if (res.isCached) {
             UIImage *im =  [UIImage imageWithContentsOfFile:res.cacheFile];//[[UIImage imageWithContentsOfFile:res.cacheFile] getSubImage:CGRectMake(0, 0, __SCREEN_SIZE.width, 400/720.0 * __SCREEN_SIZE.width) centerBool:YES];
            if (im) {
                _imgV.image = im;
                    _imgV.contentMode = UIViewContentModeScaleToFill;
                  [[NSNotificationCenter defaultCenter] postNotificationName:@"imgChange" object:self];
            }
            
        }
    }
}

-(CGFloat)heightOfCell:(BUImageRes *)img
{
    UIImage *imm;
    if (img.isCached) {
        imm =  [UIImage imageWithContentsOfFile:img.cacheFile];
        self.height = [self heightOfCellWithImg:_imgV.image];
    }
//    else {
//        [img download:self callback:@selector(getImgNotification:) extraInfo:nil];
//    }
    return 100;
}
-(CGFloat)heightOfCellWithImg:(UIImage *)img
{
   CGFloat scale = (img.size.height * 1.0)/img.size.width;
    _imgV.height = scale * _imgV.width;
    return _imgV.height;
}

//-(void)getImgNotification:(BSNotification *)noti
//{
//    if(noti.error.code ==0)
//    {
//        BUImageRes *res =(BUImageRes *) noti.target;
//        if (_curImgRes != res) {
//            return;
//        }
//        if (res.isCached) {
//               _imgV.image =  [UIImage imageWithContentsOfFile:res.cacheFile];
////             self.height = [self heightOfCellWithImg:_imgV.image];
//        }
//    }
//}

//-(id)heightOfCell
//{
//return self.h
//}

-(void)fitMyActivityMode:(NSString *)imgName
{
    _imgV.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _imgV.x = 0;
    _imgV.y = 0;
    _imgV.width = __SCREEN_SIZE.width;
    _imgV.height = 400/720.0 *__SCREEN_SIZE.width;
    self.height = 400/720.0 *__SCREEN_SIZE.width;
    UIImageView *img = [self.contentView viewWithTag:374];
    if (!img) {
        img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
       img.y = self.height - 50;
        img.x = __SCREEN_SIZE.width - 15 - img.width;
        img.tag = 374;
    }
    img.hidden = NO;
    img.image = [UIImage imageContentWithFileName:imgName];
    [self.contentView addSubview:img];
}
-(void)fitDiscoveMode
{
     _imgV.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _imgV.x = 15;
     _imgV.y = 0;

     _imgV.width = __SCREEN_SIZE.width - 30;
     _imgV.height = 268/660.0 *__SCREEN_SIZE.width;
     self.height = 268/660.0 *__SCREEN_SIZE.width;
     _imgV.layer.cornerRadius = 8;
     _imgV.layer.masksToBounds = YES;
}
-(void)fitActivityListMode
{
    _imgV.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _imgV.x = 0;
    _imgV.y = 0;
    _imgV.width = __SCREEN_SIZE.width;
    _imgV.height = 400/720.0 *__SCREEN_SIZE.width;
    self.height = 400/720.0 *__SCREEN_SIZE.width;
    
}
-(void)fitSeverCenterMode
{
     _imgV.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _imgV.x = 0;
     _imgV.y = 0;
     _imgV.width = __SCREEN_SIZE.width;
     _imgV.height = 280/720.0 *__SCREEN_SIZE.width;
     self.height = 280/720.0 *__SCREEN_SIZE.width;
}
-(void)fitTeacherMode
{
    _imgV.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _imgV.x = 15;
    _imgV.y = 0;
    _imgV.width = __SCREEN_SIZE.width-30;
    _imgV.height = 300/660.0 *_imgV.width;
    self.height = 300/660.0 *_imgV.width;
    [self.contentView setBackgroundColor:kUIColorFromRGB(color_4)];
    
}


-(void)fitMyActivityMode
{
    _imgV.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _imgV.x = 0;
    _imgV.y = 0;
    _imgV.width = __SCREEN_SIZE.width;
    _imgV.height = 400/720.0 *__SCREEN_SIZE.width;
    self.height = 400/720.0 *__SCREEN_SIZE.width;
    UIImageView *img = [self.contentView viewWithTag:374];
    img.hidden = YES;
}

-(void)fitRepairsMode:(BUImageRes *)image{
     _imgV.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _imgV.width = __SCREEN_SIZE.width -30;
    _imgV.height = _imgV.width/660.0 * 400;
    self.height = _imgV.width/660.0 * 400+10;
    _imgV.x = 15;
    _imgV.y = 0;
    _imgV.contentMode = UIViewContentModeScaleAspectFill ;
    _imgV.clipsToBounds = YES;
    _imgV.image = [UIImage imageNamed:@"defaultServer2"];
    [image download:self callback:@selector(getImageNotification:) extraInfo:nil];
    _imgV.backgroundColor = [UIColor redColor];
}

-(void)getImageNotification:(BSNotification *) noti
{
    if(noti.error.code ==0)
    {
        BUImageRes *res =(BUImageRes *) noti.target;
        if (res.isCached) {
            UIImage *im =  [UIImage imageWithContentsOfFile:res.cacheFile];
            if (im) {
                _imgV.image = im;
            }
            
        }
    }
}

-(void)fitMyInviteMode{
    _imgV.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _imgV.width = __SCREEN_SIZE.width -30;
    _imgV.height = _imgV.width/660.0 * 330;
    self.height = _imgV.width/660.0 * 330+15;
    _imgV.x = 15;
    _imgV.y = 15;
    _imgV.contentMode = UIViewContentModeScaleAspectFill ;
    _imgV.clipsToBounds = YES;
    _imgV.image = [UIImage imageNamed:@"myInvite"];
//    [image download:self callback:@selector(getImageNotification:) extraInfo:nil];
    self.backgroundColor = kUIColorFromRGB(color_9);
    self.contentView.backgroundColor = kUIColorFromRGB(color_9);
}

-(void)fitExamTicketMode
{
    _imgV.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _imgV.width = 110;
    _imgV.height = 145;
    self.height = 160;
    _imgV.x = 15;
    _imgV.y = 0;
    _imgV.contentMode = UIViewContentModeScaleAspectFill ;
    _imgV.clipsToBounds = YES;
    _imgV.image = [UIImage imageNamed:@"myInvite"];
    //    [image download:self callback:@selector(getImageNotification:) extraInfo:nil];
    _imgV.contentMode = UIViewContentModeScaleToFill;
    self.backgroundColor = kUIColorFromRGB(color_4);
    self.contentView.backgroundColor = kUIColorFromRGB(color_4);
}


-(void)fitHeadMode
{
     _imgV.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _imgV.width = __SCREEN_SIZE.width-30;
     _imgV.height = 126/330.0 * (__SCREEN_SIZE.width-30);
     self.height = _imgV.height;
     _imgV.x = 15;
     _imgV.y = 0;
//     _imgV.contentMode = UIViewContentModeScaleAspectFill ;
//     _imgV.clipsToBounds = YES;
//     _imgV.image = [UIImage imageNamed:@"s"];
     //    [image download:self callback:@selector(getImageNotification:) extraInfo:nil];
//     _imgV.contentMode = UIViewContentModeScaleToFill;
     _imgV.layer.cornerRadius = 6.0;
     _imgV.layer.masksToBounds = YES;
     self.backgroundColor = kUIColorFromRGB(color_2);
     self.contentView.backgroundColor = kUIColorFromRGB(color_2);
}
-(void)fitAboutUsMode
{
     _imgV.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _imgV.width = 103;
     _imgV.height = 95;
     _imgV.y = 16;
     _imgV.x = __SCREEN_SIZE.width/2.0 - _imgV.width/2.0;
     self.height = 126;
  self.contentView.backgroundColor = kUIColorFromRGB(color_0xf5f5f5);

}
-(void)fitReplacementMode
{
     _imgV.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _imgV.width = __SCREEN_SIZE.width - 30;
     _imgV.height = (__SCREEN_SIZE.width -30) * (700/660.0);
     _imgV.y = 0;
     _imgV.x = 15;
     self.height =  (__SCREEN_SIZE.width -30) * (700/660.0);
     UIImage *img = _imgV.image;
     if (img.size.height/(img.size.width*1.0) == 245/360.0) {

     }
     else
          _imgV.image = [img getSubImage:CGRectMake(0, 0, _imgV.width, _imgV.height) centerBool:YES];

     __weak ImgTableViewCell *weakSelf = self;
     [self setImgChangeHandle:^(id sender) {
          UIImage *img = weakSelf.imgV.image;
          if (img.size.height/(img.size.width * 0.1 )== 245/(360* 0.1 )) {

          }
          else
               weakSelf.imgV.image = [img getSubImage:CGRectMake(0, 0, weakSelf.imgV.width, weakSelf.imgV.height) centerBool:YES];
     }];

     UIButton *btn = [self.contentView viewWithTag:9010];
     if (!btn) {
          btn = [UIButton new];
          btn.width = _imgV.width;
          btn.height = _imgV.height;
          btn.tag = 9010;
          [btn addTarget:self action:@selector(imgBtnHandle:) forControlEvents:UIControlEventTouchUpInside];
     }
     [self.contentView addSubview:btn];
}

-(void)imgBtnHandle:(UIButton *)btn
{
     //     UIImageView *imgv = _imgV;
     //     NSMutableArray *adr = [NSMutableArray new];
     //     [_imgVArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
     //          UIImageView *imv = obj;
     //          [adr addObject:imv.image];
     //     }];
     id imgob = _dataDic[@"img"];
     if ([_dataDic[@"img"] isKindOfClass:[NSString class]]) {
          imgob = [UIImage imageContentWithFileName:_dataDic[@"img"]];
     }
     [self setupPhotoBrowser:@{@"row":@(0),@"imgArr":@[_imgV],@"arr":@[imgob]}];
     //     self.handleAction(@{@"method":@(1),@"row":@(0),@"imgvArr":@[_imgV],@"arr":@[imgob]});//浏览图片
}
-(void)fitActMsgMode
{
     _imgV.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _imgV.width = __SCREEN_SIZE.width - 30;
     _imgV.height = 105/330.0 * (__SCREEN_SIZE.width - 30);
     self.height = _imgV.height;
     _imgV.x = 15;
     _imgV.y = 0;

}

-(void)fitEvaInfoMode
{
     _imgV.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _imgV.width = __SCREEN_SIZE.width - 30;
     _imgV.height = 100/330.0 * (__SCREEN_SIZE.width - 30);
     self.height = _imgV.height+15;
     _imgV.x = 15;
     _imgV.y = 0;
     
}

-(void)fitOddsRecMode
{
     _imgV.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _imgV.width = __SCREEN_SIZE.width-30;
     _imgV.height = 135/330.0 * (__SCREEN_SIZE.width-30);
     self.height = _imgV.height;
     _imgV.x = 15;
     _imgV.y = 0;
//     _imgV.contentMode = UIViewContentModeScaleToFill;
     _imgV.layer.cornerRadius = 6.0;
     _imgV.layer.masksToBounds = YES;
     self.contentView.backgroundColor = kUIColorFromRGB(color_f8f8f8);
}
-(void)fitZhiMaAuthMode
{
     _imgV.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _imgV.width = __SCREEN_SIZE.width;
     _imgV.height = 123;
     self.height = _imgV.height;
     _imgV.x = 0;
     _imgV.y = 0;
          _imgV.contentMode = UIViewContentModeCenter;
_imgV.backgroundColor = kUIColorFromRGB(color_F2F2F2);
self.contentView.backgroundColor = kUIColorFromRGB(color_F2F2F2);
}

-(void)fitshopMode
{
     _imgV.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _imgV.width = __SCREEN_SIZE.width;
     _imgV.height = 145/360.0 * (__SCREEN_SIZE.width);
     self.height = _imgV.height;
     _imgV.x = 0;
     _imgV.y = 15;
     
     UIImageView *imgV = [self.contentView viewWithTag:10956];
     if (!imgV) {
          imgV = [[UIImageView alloc]initWithFrame:CGRectMake(__SCREEN_SIZE.width-55, 0, 55, 55)];
          imgV.tag = 10956;
          [self.contentView addSubview:imgV];
     }
     NSInteger type = [_dataDic[@"type"] integerValue];
     if (type == 2) {
          imgV.image = [UIImage imageNamed:@"icon_coupon"];
     }
     else  if (type == 1) {
          imgV.image = [UIImage imageNamed:@"icon_bargainPrice"];
     }
     else {
          imgV.image = [UIImage imageNamed:@"icon_promotion"];
     }
}

-(void)fitTopicMode
{
     _imgV.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _imgV.width = __SCREEN_SIZE.width - 30;
     _imgV.height = 100/330.0 * (__SCREEN_SIZE.width - 30);
     self.height = _imgV.height + 30;
     _imgV.x = 15;
     _imgV.y = 15;
}

-(void)fitBrandMakeShopMode
{
     _imgV.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _imgV.width = __SCREEN_SIZE.width;
     _imgV.height = 125/360.0 * (__SCREEN_SIZE.width);
     self.height = _imgV.height;
     _imgV.x = 0;
     _imgV.y = 0;
}

-(void)fitYouBiRuleMode
{
     _imgV.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _imgV.width = __SCREEN_SIZE.width;
     _imgV.height = 2395/720.0 * (__SCREEN_SIZE.width);
     self.height = _imgV.height;
     _imgV.x = 0;
     _imgV.y = 0;
}


-(void)toPhoto
{
     [self.addPhotoManager toPhoto];
}
-(void)initAddPhotoManager:(NSInteger)count withImgArr:(NSMutableArray *)aimgArr withVC:(UIViewController *)vc withTableView:(UITableView*)tableView
{
     //    __weak id weakSelf = vc;
     _addPhotoManager = [[AddPhotoManager alloc] initWith:vc withImgArr:aimgArr withCell:self withTableView:tableView];
     _addPhotoManager.count = count;
}

-(void)toCheckOption:(id)userInfo
{
     [_addPhotoManager toCheckOption:userInfo];
}

-(void)delImg:(NSInteger )indexPath
{
     [self delImg:indexPath withImgArr:nil];
}

-(void)delImg:(NSInteger )indexPath withImgArr:(NSArray *)arr
{
     [_addPhotoManager delImg:indexPath withImgArr:arr];
}

- (void) setupPhotoBrowser:(NSDictionary *)dic
{
     [_addPhotoManager setupPhotoBrowser:dic];
}
@end
