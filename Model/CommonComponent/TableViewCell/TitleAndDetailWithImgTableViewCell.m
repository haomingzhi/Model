//
//  TitleAndDetailWithImgTableViewCell.m
//  yihui
//
//  Created by air on 15/9/1.
//  Copyright (c) 2015年 ORANLLC_IOS1. All rights reserved.
//

#import "TitleAndDetailWithImgTableViewCell.h"
#import "BUSystem.h"
@implementation TitleAndDetailWithImgTableViewCell
{
   BUImageRes *_curImgRes;
    IBOutlet UILabel *_detailLb;
    IBOutlet UIImageView *_tipImgV;
    IBOutlet UILabel *_titleLb;
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setCellData:(NSDictionary *)dataDic
{
     id imgObjc = dataDic[@"img"];
     _tipImgV.image = [UIImage imageContentWithFileName:dataDic[@"default"]];
     if ([imgObjc isKindOfClass:[BUImageRes class]]) {
          BUImageRes *img = (BUImageRes *)imgObjc;
          _curImgRes = img;
          if (img.isCached) {
               UIImage *im =   [UIImage imageWithContentsOfFile:img.cacheFile];// getSubImage:CGRectMake(0, 0, __SCREEN_SIZE.width, 400/720.0 * __SCREEN_SIZE.width) centerBool:YES];
               if (im) {
                    _tipImgV.image = im;
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
          UIImage *im = [UIImage imageContentWithFileName:imgObjc];//[[UIImage imageNamed:imgObjc] getSubImage:CGRectMake(0, 0, __SCREEN_SIZE.width - 30, 105/330.0 * (__SCREEN_SIZE.width - 30)) centerBool:YES];;
          if (im) {
               _tipImgV.image = im;
          }

     }
     else if([imgObjc isKindOfClass:[UIImage class]])
     {
          _tipImgV.image =  imgObjc;
     }
    _detailLb.text = dataDic[@"detail"];
    _titleLb.text = dataDic[@"title"];
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
               UIImage *im =  [UIImage imageWithContentsOfFile:res.cacheFile] ;
               if (im) {
                    _tipImgV.image = im;
               }

          }
     }
}

-(void)fitTaskCenterMode
{
     self.height = 131;
     _tipImgV.width = 75;
     _tipImgV.height = _tipImgV.width;
     _tipImgV.y = 15;
     _tipImgV.x = __SCREEN_SIZE.width/2.0 - _tipImgV.width/2.0;
     
     _titleLb.width = 200;
     _titleLb.height = 15;
     _titleLb.font = [UIFont systemFontOfSize:15];
     _titleLb.textColor = kUIColorFromRGB(color_0xf6f6f6);
     _titleLb.y = 101;
     _titleLb.textAlignment = NSTextAlignmentCenter;
     _titleLb.x = __SCREEN_SIZE.width / 2.0 - _titleLb.width/2.0;
     
     _detailLb.textColor = kUIColorFromRGB(color_2);
     _detailLb.font = [UIFont systemFontOfSize:12];
     _detailLb.width = 100;
     _detailLb.height = 12;
     _detailLb.textAlignment = NSTextAlignmentRight;
     _detailLb.x = __SCREEN_SIZE.width - 15 - _detailLb.width;
     _detailLb.y = 15;
     
     self.contentView.backgroundColor = kUIColorFromRGB(color_0xf4b228);
}

-(void)fitMyYoubiMode
{
     self.height = 146;
     _tipImgV.width = 84;
     _tipImgV.height = 70;
     _tipImgV.y = 15;
     _tipImgV.x = __SCREEN_SIZE.width/2.0 - _tipImgV.width/2.0;
     
     _titleLb.width = 200;
     _titleLb.height = 13;
     _titleLb.font = [UIFont systemFontOfSize:13];
     _titleLb.textColor = kUIColorFromRGB(color_2);
     _titleLb.y = 94;
     _titleLb.textAlignment = NSTextAlignmentCenter;
     _titleLb.x = __SCREEN_SIZE.width / 2.0 - _titleLb.width/2.0;
     
     _detailLb.textColor = kUIColorFromRGB(color_2);
     _detailLb.font = [UIFont systemFontOfSize:14];
     _detailLb.width = 100;
     _detailLb.height = 14;
     _detailLb.x = __SCREEN_SIZE.width / 2.0 - _detailLb.width/2.0;
     _detailLb.y = 116;
     _detailLb.textAlignment = NSTextAlignmentCenter;
     UIButton *btn = [self.contentView viewWithTag:12113];
     if (!btn) {
          btn = [UIButton new];
          btn.width = 110;
          btn.height = 12;
          btn.tag = 12113;
     }
//     btn.textAlignment = NSTextAlignmentRight;
     [btn setTitle:@"做任务挣优币" forState:UIControlStateNormal] ;
     [btn setTitleColor:kUIColorFromRGB(color_2) forState:UIControlStateNormal] ;
     btn.titleLabel.font =  [UIFont systemFontOfSize:12];
//     btn.contentMode = UIViewContentModeRight;
     btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
     btn.x = __SCREEN_SIZE.width - 15 - btn.width;
     btn.y = 15;
     [self.contentView addSubview:btn];
     [btn addTarget:self action:@selector(handleAction:) forControlEvents:UIControlEventTouchUpInside];
     self.contentView.backgroundColor = kUIColorFromRGB(color_0xf4b228);
}

-(void)handleAction:(UIButton *)btn
{
     if (self.handleAction) {
          self.handleAction(@{});
     }
}

-(void)fitPersonCenterMode
{
     self.height = 60;
     _tipImgV.width = 50;
     _tipImgV.height = 50;
     _tipImgV.layer.cornerRadius = _tipImgV.height/2.0;
     _tipImgV.layer.masksToBounds = YES;
     _tipImgV.y = 5;
     _tipImgV.x = __SCREEN_SIZE.width - 35 - _tipImgV.width;
     UIImage *img = _tipImgV.image;
     if (img.size.height/(img.size.width*1.0) == 1.0) {

     }
     else
          _tipImgV.image = [img getSubImage:CGRectMake(0, 0, _tipImgV.width, _tipImgV.height) centerBool:YES canScale:YES];
     _titleLb.width = 200;
     _titleLb.height = 15;
     _titleLb.font = [UIFont systemFontOfSize:15];
     _titleLb.textColor = kUIColorFromRGB(color_1);
     _titleLb.y = 23;
     _titleLb.textAlignment = NSTextAlignmentLeft;
     _titleLb.x = 15;
     
     _detailLb.textColor = kUIColorFromRGB(color_0xb0b0b0);
     _detailLb.font = [UIFont systemFontOfSize:13];
     _detailLb.width = 100;
     _detailLb.height = 13;
     _detailLb.textAlignment = NSTextAlignmentRight;
     _detailLb.x = __SCREEN_SIZE.width -36 - _detailLb.width;
     _detailLb.y = 35;

     UIImageView *imgv = [self.contentView viewWithTag:973];
     if (!imgv) {
          imgv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 9, 17)];
          imgv.tag = 973;
          
          imgv.y = 22;
          
          
     }
     imgv.x = __SCREEN_SIZE.width - 15 - 9;
     //    if (upDown) {
     imgv.image = [UIImage imageContentWithFileName:@"rightArrow2"];
     [self.contentView addSubview:imgv];

}

-(id)heightOfCell
{
    return @(self.height);
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
