//
//  TitleAndImageTableViewCell.m
//  yihui
//
//  Created by ORANLLC_IOS1 on 15/10/19.
//  Copyright (c) 2015年 ORANLLC_IOS1. All rights reserved.
//

#import "TitleAndImageTableViewCell.h"
#import "BUImageRes.h"
#import "JYCommonTool.h"

@interface TitleAndImageTableViewCell()
{
    BUImageRes *_curImgRes;
    IBOutlet UIButton *_imgVBtn;
    NSDictionary *_dataDic;
}

@property (nonatomic) NSDictionary *dataDic;

- (IBAction)handleDid:(id)sender;

@end


@implementation TitleAndImageTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}


-(void)setCellData:(NSDictionary *)dataDic
{
    self.dataDic = dataDic;
    self.labelTitle.text = dataDic[@"title"];
    _dataDic = dataDic;
    [_imgVBtn setImage:[UIImage imageContentWithFileName:dataDic[@"default"]] forState:UIControlStateNormal];
    id img = dataDic[@"img"];
    if ([img isKindOfClass:[BUImageRes class]]) {
        _curImgRes = img;
        if(_curImgRes.isCached)
        {
            UIImage *im = [UIImage imageWithContentsOfFile:_curImgRes.cacheFile];
            if (im) {
                if (self.dataDic[@"changeImg"]) {
//                    im = [JYCommonTool getSubImage:im mCGRect:CGRectMake(0, 0, 300, 300) centerBool:YES];
                    [_imgVBtn setImage:im forState:UIControlStateNormal];
                }else{
                    [_imgVBtn setImage:im forState:UIControlStateNormal];
                }
//                [_imgVBtn setImage:im forState:UIControlStateNormal];
            }
        }
        else
        {
            [_curImgRes download:self callback:@selector(imgNotification:) extraInfo:nil];
        }
    }
    else if([img isKindOfClass:[UIImage class]])
    {
       [_imgVBtn setImage:img forState:UIControlStateNormal];
    }
    else if([img isKindOfClass:[NSString class]])
    {
     [_imgVBtn setImage:[UIImage imageContentWithFileName:img] forState:UIControlStateNormal];
    }
}

-(void)imgNotification:(BSNotification *)noti
{
    if (noti.error.code == 0) {
        if (_curImgRes != noti.target) {
            return;
        }
        if (_curImgRes.isCached) {
            UIImage *im = [UIImage imageWithContentsOfFile:_curImgRes.cacheFile];
            if (im) {
                if (self.dataDic[@"changeImg"]) {
//                    im = [JYCommonTool getSubImage:im mCGRect:CGRectMake(0, 0, 300, 300) centerBool:YES];
                    [_imgVBtn setImage:im forState:UIControlStateNormal];
                }else{
                    [_imgVBtn setImage:im forState:UIControlStateNormal];
                }
                
            }

        }
    }
}

- (IBAction)handleDid:(id)sender {
    if (self.handleAction) {
        self.handleAction(self.dataDic[@"userData"] ?:sender);
    }
}

-(void)fitPersonMode
{
    self.height = 81;
    _imgVBtn.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _imgVBtn.x = __SCREEN_SIZE.width - 15 -  80;
    _imgVBtn.height = 60;
    _imgVBtn.width = 60;
    _imgVBtn.y = self.height/2.0 - _imgVBtn.height/2.0;
    _imgVBtn.layer.cornerRadius = _imgVBtn.height/2.0;
    _imgVBtn.layer.masksToBounds = YES;
    _imgVBtn.layer.borderColor = kUIColorFromRGB(color_8).CGColor;
    _imgVBtn.layer.borderWidth = 0.5;
    _imgVBtn.hidden = NO;
    _labelTitle.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _labelTitle.x = 15;
    _labelTitle.y = self.height/2.0 - _labelTitle.height/2.0;
    _labelTitle.textColor = kUIColorFromRGB(color_1);
    _labelTitle.font = [UIFont systemFontOfSize:15];
    UIImageView *imgv = [self.contentView viewWithTag:973];
    if (!imgv) {
        imgv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 9, 17)];
        imgv.tag = 973;
        
       
        
        
    }
     imgv.y = self.height/2.0 - imgv.height/2.0;
    imgv.x = __SCREEN_SIZE.width - 10 - 9;
    //    if (upDown) {
    imgv.image = [UIImage imageContentWithFileName:@"icon_arrow_right"];
    [self.contentView addSubview:imgv];
}

-(void)fitRegNextMode
{
    [self fitPersonMode];
    _labelTitle.textColor = kUIColorFromRGB(color_1);
    _labelTitle.font = [UIFont systemFontOfSize:15];
}

-(void)fitUserCerMode
{
    self.height = 44;
    _labelTitle.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _labelTitle.x = 15;
    _labelTitle.y = self.height/2.0 - _labelTitle.height/2.0;
    _labelTitle.textColor = kUIColorFromRGB(color_1);
    _labelTitle.font = [UIFont systemFontOfSize:15];
    
    _imgVBtn.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _imgVBtn.x = __SCREEN_SIZE.width - 15 -  40;
    _imgVBtn.height = 40;
    _imgVBtn.width = 40;
    _imgVBtn.y = self.height/2.0 - _imgVBtn.height/2.0;
    _imgVBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    _imgVBtn.hidden = NO;
}
-(void)fitPublishSecHandMode
{
     self.height = 46;
     _labelTitle.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _labelTitle.x = 45;
     _labelTitle.y = self.height/2.0 - _labelTitle.height/2.0;
     _labelTitle.textColor = kUIColorFromRGB(color_1);
     _labelTitle.font = [UIFont systemFontOfSize:15];

     _imgVBtn.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _imgVBtn.x = 15;
     _imgVBtn.height = 40;
     _imgVBtn.width = 40;
     _imgVBtn.y = self.height/2.0 - _imgVBtn.height/2.0;
     _imgVBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
     _imgVBtn.hidden = NO;
}
-(void)fitReplacementMode
{
     self.height = 38;
     _labelTitle.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _labelTitle.x = 45;
     _labelTitle.y = 13;
     _labelTitle.textColor = kUIColorFromRGB(color_7);
     _labelTitle.font = [UIFont systemFontOfSize:12];
     _labelTitle.height = 12;
     _labelTitle.width = __SCREEN_SIZE.width - _labelTitle.x - 100;

     _imgVBtn.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _imgVBtn.x = 15;
     _imgVBtn.height = 38;
     _imgVBtn.width = 38;
     _imgVBtn.y = 0;
     _imgVBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
     _imgVBtn.hidden = NO;
     
     UILabel *detailLb = [self.contentView viewWithTag:8733];
     if (!detailLb) {
          detailLb = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 14)];
          detailLb.tag = 8733;
     }
     detailLb.textColor = kUIColorFromRGB(color_7);
     detailLb.font = [UIFont systemFontOfSize:12];
     detailLb.text = _dataDic[@"detail"];
     detailLb.y = self.height/2.0 - detailLb.height/2.0;
     detailLb.x = __SCREEN_SIZE.width - 15 - detailLb.width;
     detailLb.textAlignment = NSTextAlignmentRight;
     [self.contentView addSubview:detailLb];
     
}
-(void)fitChoseUnitMode
{
    self.height = 44;
    _labelTitle.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _labelTitle.x = 15;
    _labelTitle.y = self.height/2.0 - _labelTitle.height/2.0;
    _labelTitle.textColor = kUIColorFromRGB(color_1);
    _labelTitle.font = [UIFont systemFontOfSize:15];
    
    _imgVBtn.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _imgVBtn.x = __SCREEN_SIZE.width - 15 -  40;
    _imgVBtn.height = 40;
    _imgVBtn.width = 40;
    _imgVBtn.y = self.height/2.0 - _imgVBtn.height/2.0;
    _imgVBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    _imgVBtn.hidden = YES;
}

-(void)fitCerTypeMode
{
    _imgVBtn.userInteractionEnabled = NO;
    _imgVBtn.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin;
    _imgVBtn.x = __SCREEN_SIZE.width - 5 - _imgVBtn.width;
    _imgVBtn.hidden = NO;
}
-(void)fitPublishActMode
{
    self.height = 44;
    _labelTitle.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _labelTitle.x = 15;
    _labelTitle.y = self.height/2.0 - _labelTitle.height/2.0;
    _labelTitle.textColor = kUIColorFromRGB(color_6);
    _labelTitle.font = [UIFont systemFontOfSize:15];
    
    _imgVBtn.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _imgVBtn.x = __SCREEN_SIZE.width - 15 -  40;
    _imgVBtn.height = 40;
    _imgVBtn.width = 40;
    _imgVBtn.y = self.height/2.0 - _imgVBtn.height/2.0;
    _imgVBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    _imgVBtn.hidden = NO;

    UILabel *detailLb = [self.contentView viewWithTag:8733];
    if (!detailLb) {
        detailLb = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 130, 16)];
        detailLb.tag = 8733;
    }
    detailLb.textColor = kUIColorFromRGB(color_6);
    detailLb.font = [UIFont systemFontOfSize:15];
    detailLb.text = _dataDic[@"detail"];
      detailLb.y = self.height/2.0 - detailLb.height/2.0;
    detailLb.x = 132;
    [self.contentView addSubview:detailLb];
    _imgVBtn.userInteractionEnabled = NO;
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

-(void)fitPersonInfoMode
{
     self.height = 118;
     _labelTitle.width = 200;
     _labelTitle.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _labelTitle.x = __SCREEN_SIZE.width/2.0 - _labelTitle.width/2.0;
     _labelTitle.y = 68;
     _labelTitle.textColor = kUIColorFromRGB(color_2);
     _labelTitle.font = [UIFont systemFontOfSize:12];
     _labelTitle.textAlignment = NSTextAlignmentCenter;
     _imgVBtn.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _imgVBtn.height = 48;
     _imgVBtn.width = 48;
     _imgVBtn.x = __SCREEN_SIZE.width/2.0 - _imgVBtn.width/2.0;
     _imgVBtn.layer.cornerRadius = _imgVBtn.height/2.0;
     _imgVBtn.layer.masksToBounds = YES;
     _imgVBtn.y = 20;
//     _imgVBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
     _imgVBtn.hidden = NO;
     UIImageView *imgv = [self.contentView viewWithTag:973];
     if (!imgv) {
          imgv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, __SCREEN_SIZE.width, 118)];
          imgv.tag = 973;    
     }

     imgv.image = [UIImage imageContentWithFileName:@"mineBackground"];
     [self.contentView insertSubview:imgv atIndex:0];
}

-(void)fitSeverCenterMode
{
     self.height = 45;
     _labelTitle.width = __SCREEN_SIZE.width - 50;
     _labelTitle.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _labelTitle.x = 15;
     _labelTitle.y = 16;
     _labelTitle.textColor = kUIColorFromRGB(color_1);
     _labelTitle.height = 15;
     
     _labelTitle.font = [UIFont systemFontOfSize:15];
     _labelTitle.textAlignment = NSTextAlignmentLeft;
     _imgVBtn.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _imgVBtn.height = 18;
     _imgVBtn.width = 10;
     _imgVBtn.x = __SCREEN_SIZE.width - _imgVBtn.width - 15;
     
     _imgVBtn.y = 12;
     //     _imgVBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
     _imgVBtn.hidden = NO;
     _imgVBtn.userInteractionEnabled = NO;
}

-(void)fitAuditProgressMode
{
     self.height = 36;
     _labelTitle.width = __SCREEN_SIZE.width - 60;
     _labelTitle.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _labelTitle.x = 45;
     _labelTitle.y = 10;
     _labelTitle.textColor = kUIColorFromRGB(color_5);
     _labelTitle.height = 15;
     
     _labelTitle.font = [UIFont systemFontOfSize:15];
     if(__SCREEN_SIZE.width == 320)
     {
 _labelTitle.font = [UIFont systemFontOfSize:13];
     }
     _labelTitle.textAlignment = NSTextAlignmentLeft;
     _imgVBtn.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _imgVBtn.height = 15;
     _imgVBtn.width = 15;
     _imgVBtn.x = 15;
     
     _imgVBtn.y = 10;
     //     _imgVBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
     _imgVBtn.hidden = NO;
     _imgVBtn.userInteractionEnabled = NO;
}

-(void)fitPublishEvaMode
{
     self.height = 55;
     _labelTitle.width = __SCREEN_SIZE.width - 50;
     _labelTitle.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _labelTitle.x = 42;
     _labelTitle.y = 20;
     _labelTitle.textColor = kUIColorFromRGB(color_1);
     _labelTitle.height = 15;
     
     _labelTitle.font = [UIFont systemFontOfSize:15];
     _labelTitle.textAlignment = NSTextAlignmentLeft;
     _imgVBtn.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _imgVBtn.height = 20;
     _imgVBtn.width = 17;
     _imgVBtn.x = 15;
     
     _imgVBtn.y = 18;
     //     _imgVBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
     _imgVBtn.hidden = NO;
     _imgVBtn.userInteractionEnabled = YES;

     self.contentView.backgroundColor = kUIColorFromRGB(color_2);
}
-(void)fitPublishEvaModeB
{
     self.height = 55;
     _labelTitle.width = __SCREEN_SIZE.width - 50;
     _labelTitle.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;

     _labelTitle.y = 20;
     _labelTitle.textColor = kUIColorFromRGB(color_1);
     _labelTitle.height = 15;

     _labelTitle.font = [UIFont systemFontOfSize:15];
     _labelTitle.textAlignment = NSTextAlignmentLeft;
     _imgVBtn.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _imgVBtn.height = 35;
     _imgVBtn.width = 36;
     _imgVBtn.x = 15;
 _labelTitle.x = _imgVBtn.x + _imgVBtn.width + 10;
     _imgVBtn.y = 10;
     //     _imgVBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
     _imgVBtn.hidden = NO;
     _imgVBtn.userInteractionEnabled = YES;

     self.contentView.backgroundColor = kUIColorFromRGB(color_2);
}
-(void)fitPublishAnswerMode
{
     
     self.height = 41;
     _labelTitle.width = 160;
     _labelTitle.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _labelTitle.x = 15;
     _labelTitle.y = 15;
     _labelTitle.textColor = kUIColorFromRGB(color_0xb0b0b0);
     _labelTitle.height = 15;
     
     _labelTitle.font = [UIFont systemFontOfSize:15];
     _labelTitle.textAlignment = NSTextAlignmentLeft;
     _imgVBtn.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _imgVBtn.height = 14;
     _imgVBtn.width = 33;
     _imgVBtn.x = __SCREEN_SIZE.width - 15 - _imgVBtn.width;
     
     _imgVBtn.y = 13;
     //     _imgVBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
     _imgVBtn.hidden = NO;
     _imgVBtn.userInteractionEnabled = YES;
//     UIView *v = [self.contentView viewWithTag:8211];
//     if (!v) {
//          v = [UIView new];
//          v.tag = 8211;
//     }
//     v.x = 15;
//     v.height = 36;
//     v.y = 9;
//     v.width = __SCREEN_SIZE.width - 30;
//     v.layer.borderColor = kUIColorFromRGB(color_lineColor).CGColor;
//     v.layer.borderWidth = 0.5;
//     v.backgroundColor = kUIColorFromRGB(color_2);
//     [self.contentView insertSubview:v atIndex:0];
//     self.contentView.backgroundColor = kUIColorFromRGB(color_0xf0f0f0);
     
     
     UILabel *detailLb = [self.contentView viewWithTag:8733];
     if (!detailLb) {
          detailLb = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 54, 13)];
          detailLb.tag = 8733;
     }
     detailLb.textColor = kUIColorFromRGB(color_7);
     detailLb.font = [UIFont systemFontOfSize:13];
     detailLb.text = _dataDic[@"detail"];
     detailLb.y = self.height/2.0 - detailLb.height/2.0;
     detailLb.x = __SCREEN_SIZE.width - 63 - detailLb.width;
     [self.contentView addSubview:detailLb];
     self.contentView.backgroundColor = kUIColorFromRGB(color_2);
}

-(void)fitSearchMode
{
     self.height = 45;
     _labelTitle.width = __SCREEN_SIZE.width - 66;
     _labelTitle.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _labelTitle.x = 15;
     _labelTitle.y = 16;
     _labelTitle.textColor = kUIColorFromRGB(color_0xb0b0b0);
     _labelTitle.height = 15;
     
     _labelTitle.font = [UIFont systemFontOfSize:15];
     _labelTitle.textAlignment = NSTextAlignmentLeft;
     _imgVBtn.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _imgVBtn.height = 14;
     _imgVBtn.width = 14;
     _imgVBtn.x = __SCREEN_SIZE.width - 15 - _imgVBtn.width;
     
     _imgVBtn.y = 16;
     //     _imgVBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
     _imgVBtn.hidden = YES;
     _imgVBtn.userInteractionEnabled = YES;
     
//     UIImageView *imgv = [self.contentView viewWithTag:9222];
//     if (!imgv) {
//          imgv = [UIImageView new];
//          imgv.width = 19;
//          imgv.height = 19;
//          imgv.y = 13;
//          imgv.x = 15;
//          imgv.tag = 9222;
//          imgv.image = [UIImage imageContentWithFileName:@"search_time"];
//     }
//     [self.contentView addSubview:imgv];
}

-(void)fitSexCheckMode
{
     self.height = 46;
     _labelTitle.width = __SCREEN_SIZE.width - 66;
     _labelTitle.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _labelTitle.x = 15;
     _labelTitle.y = 15;
     _labelTitle.textColor = kUIColorFromRGB(color_0xb0b0b0);
     _labelTitle.height = 15;

     _labelTitle.font = [UIFont systemFontOfSize:15];
     _labelTitle.textAlignment = NSTextAlignmentLeft;

     _imgVBtn.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _imgVBtn.height = 14;
     _imgVBtn.width = 19;
     _imgVBtn.x = __SCREEN_SIZE.width - 15 - _imgVBtn.width;
//     [];
     _imgVBtn.y = 16;
          _imgVBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
     _imgVBtn.hidden = ![_dataDic[@"isCheck"] boolValue];
     _imgVBtn.userInteractionEnabled = NO;
}
@end
