//
//  MineHeadTableViewCell.m
//  lovecommunity
//
//  Created by air on 16/6/17.
//  Copyright © 2016年 ORANLLC_IOS1. All rights reserved.
//

#import "MineHeadTableViewCell.h"
#import "BUImageRes.h"
#import "JYCommonTool.h"
@implementation MineHeadTableViewCell
{
    IBOutlet UIButton *_handleBtn;

    IBOutlet UIImageView *_rMarkImgV;
    IBOutlet UIImageView *_markImgV;
    IBOutlet UIImageView *_sexImgV;
    IBOutlet UIImageView *_mineBackgroundImgV;
    IBOutlet UILabel *_titleLb;
    IBOutlet UILabel *_moneyLb;
    IBOutlet UIButton *_moneyBtn;
   
    BUImageRes *_curImgRes;
     NSDictionary *_dataDic;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
      [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(imgChangeHandle:) name:@"imgChange" object:self];
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

-(void)dealloc
{
     [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
 
    // Configure the view for the selected state
}

-(void)setCellData:(NSDictionary *)dataDic
{
     _dataDic = dataDic;
    if(dataDic[@"sex"] && ![dataDic[@"sex"] isEqualToString:@""])
    {
        _sexImgV.hidden = NO;
    _sexImgV.image = [UIImage imageContentWithFileName:dataDic[@"sex"]];
    }
    else
    {
      _sexImgV.hidden = YES;
    }
    if ([dataDic[@"isHiddenVip"] boolValue]) {
        _markImgV.hidden = YES;
        [_loginBtn setTitle:@"前往认证" forState:UIControlStateNormal];
          _loginBtn.enabled = YES;
    }
    else
    {
        _markImgV.hidden = NO;
            [_loginBtn setTitle:@"认证用户" forState:UIControlStateNormal];
        _loginBtn.enabled = NO;
    }
    
    if ([dataDic[@"isHiddenR"] boolValue]) {
        _rMarkImgV.hidden = YES;
    }
    else
    {
    _rMarkImgV.hidden = NO;
    }
    _imgV.image = [UIImage imageContentWithFileName:dataDic[@"default"]];
//    _moneyLb.text = dataDic[@"money"];
    _titleLb.text = dataDic[@"title"];
    
//    [_loginBtn setTitle:dataDic[@"title"] forState:UIControlStateNormal];
    id imgObjc = dataDic[@"img"];
    if ([imgObjc isKindOfClass:[BUImageRes class]]) {
        BUImageRes *img = (BUImageRes *)imgObjc;
        _curImgRes = img;
        if (img.isCached) {
            id im = [UIImage imageWithContentsOfFile:img.cacheFile];
            
            if (im) {
                 _imgV.image = im;//[JYCommonTool getSubImage:im mCGRect:CGRectMake(0, 0, 300, 300) centerBool:YES];
            }
           
        }
        else {
            [img download:self callback:@selector(getImgNotification:) extraInfo:nil];
        }
    }
    else if([imgObjc isKindOfClass:[NSString class]])
    {
        if([UIImage imageContentWithFileName:imgObjc])
             _imgV.image = [UIImage imageContentWithFileName:imgObjc];//[JYCommonTool getSubImage:[UIImage imageNamed:imgObjc] mCGRect:CGRectMake(0, 0, 300, 300) centerBool:YES];
    }
    else if([imgObjc isKindOfClass:[UIImage class]])
    {
        if (imgObjc) {
             _imgV.image = imgObjc;//[JYCommonTool getSubImage:imgObjc mCGRect:CGRectMake(0, 0, 300, 300) centerBool:YES];
        }
       
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
            id im =  [UIImage imageWithContentsOfFile:res.cacheFile];
            if (im) {
                 _imgV.image = im;//[JYCommonTool getSubImage:im mCGRect:CGRectMake(0, 0, 300, 300) centerBool:YES ];
                  [[NSNotificationCenter defaultCenter] postNotificationName:@"imgChange" object:self];
            }
            
        }
    }
}


- (IBAction)loginHandle:(id)sender {
    if(self.handleAction)
    {
        self.handleAction(@{@"obj":sender});
    }
}

- (IBAction)moneyHandle:(id)sender {
    if(self.handleAction)
    {
         self.handleAction(@{@"obj":sender});
    }
}
- (IBAction)userInfo:(id)sender {
    if(self.handleAction)
    {
        self.handleAction(@{@"obj":sender});
    }
}
-(void)fitMineModeB
{
    [self fitMineMode];
    _rMarkImgV.hidden = YES;
}

-(void)fitMineMode
{
     __weak MineHeadTableViewCell *weakSelf = self;
     _titleLb.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleRightMargin;
     _imgV.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleRightMargin;
     self.height = (150/360.0 * __SCREEN_SIZE.width);

     _mineBackgroundImgV.y = 0;
    _mineBackgroundImgV.height = (150/360.0 * __SCREEN_SIZE.width);
    _titleLb.font = [UIFont systemFontOfSize:12];
    [_titleLb sizeToFit];
//     if(__SCREEN_SIZE.width == 320)

    _titleLb.textColor = kUIColorFromRGB(color_0xf6f6f6);
    _sexImgV.x = _titleLb.x + _titleLb.width + 5;
    _rMarkImgV.x = _sexImgV.x + _rMarkImgV.width + 5;
//    _titleLb.y = 75;//self.height - 57 - _titleLb.height;
     _titleLb.textAlignment = NSTextAlignmentCenter;
     _imgV.height = 67;
     _imgV.width = 67;
     _imgV.x = __SCREEN_SIZE.width/2.0 - _imgV.width/2.0;
      _imgV.y = self.height/2.0 - _imgV.height/2.0 ;
    UIImage *img = _imgV.image;
     if (img.size.height/(img.size.width*1.0) == 1.0) {

     }
     else
          _imgV.image = [img getSubImage:CGRectMake(0, 0, weakSelf.imgV.width, weakSelf.imgV.height) centerBool:YES canScale:YES];

     [self setImgChangeHandle:^(id sender) {
          UIImage *img = weakSelf.imgV.image;
          if (img.size.height/(img.size.width*1.0) == 1.0) {

          }
          else
               weakSelf.imgV.image = [img getSubImage:CGRectMake(0, 0, weakSelf.imgV.width, weakSelf.imgV.height) centerBool:YES canScale:YES];
     }];


    [self.contentView bringSubviewToFront:_markImgV];
    [self.contentView bringSubviewToFront:_handleBtn];
     if([_titleLb.text isEqualToString:@"登录/注册"])
     {
          _titleLb.width = 70;
          _titleLb.height = 21;
          _titleLb.layer.borderColor = kUIColorFromRGB(color_2).CGColor;
          _titleLb.layer.cornerRadius = 6;
          _titleLb.layer.borderWidth = 0.5;
     }
     else
     {
 _titleLb.layer.borderWidth = 0;
     }
     _titleLb.x = __SCREEN_SIZE.width/2.0 - _titleLb.width/2.0;
     _titleLb.y = _imgV.y + _imgV.height + 8;
     _titleLb.textAlignment = NSTextAlignmentCenter;


        _loginBtn.hidden = NO;
     _handleBtn.width = __SCREEN_SIZE.width;
     _handleBtn.height = self.height;
     _handleBtn.x = 0;
     _handleBtn.y = 0;
    _loginBtn.tag = 9111;
    [_loginBtn setTitleColor:kUIColorFromRGB(color_3) forState:UIControlStateNormal];
     _imgV.layer.cornerRadius = _imgV.height/2.0;
     _moneyBtn.layer.cornerRadius = 6;
     _imgV.layer.masksToBounds = YES;
     _moneyBtn.layer.masksToBounds = YES;

     _numberLb = _moneyBtn.titleLabel.text;

     UIView *lvv = [self.contentView viewWithTag:1006];
     if (!lvv) {
          lvv = [[UIView alloc] initWithFrame:CGRectMake(_imgV.width + _imgV.x + 15, self.height/2.0 - 13, 164, 25)];
          lvv.tag = 1006;

//          if (__SCREEN_SIZE.width == 320) {
//                     lvv.y = self.height/2.0 + 12;
//          }
//          else
//                    lvv.y = self.height/2.0 + 7;
               lvv.layer.cornerRadius = 3;
                    lvv.layer.masksToBounds = YES;
                    lvv.backgroundColor = kUIColorFromRGBWithAlpha(color_1, 0.4);

//          lvv.textAlignment = NSTextAlignmentCenter;
//          lvv.font = [UIFont systemFontOfSize:12];
//          lvv.textColor = kUIColorFromRGB(color_2);
     }
     lvv.x = __SCREEN_SIZE.width - lvv.width + 3;
     lvv.y = self.height/2.0 - lvv.height/2.0;
//     lvv.text = _dataDic[@"vip"];
     [self.contentView addSubview:lvv];

     _loginBtn.width = lvv.width + 10;
     _loginBtn.height = lvv.height + 10;
    [_loginBtn setTitle:@"" forState:UIControlStateNormal];
     _loginBtn.x = __SCREEN_SIZE.width/2.0 - _loginBtn.width/2.0;
     _loginBtn.y = _imgV.y + _imgV.height + 8;
     UILabel *lvs = [lvv viewWithTag:1008];
     if (!lvs) {
          lvs = [[UILabel alloc] initWithFrame:CGRectMake(_imgV.width + _imgV.x + 15, 85, 100, 13)];
          lvs.tag = 1008;
          lvs.x = 31;
          lvs.y = 6;
//          lvs.layer.cornerRadius = lvv.height/2.0;
//          lvs.layer.masksToBounds = YES;
//          lvs.backgroundColor = kUIColorFromRGB(color_F5E852);

          lvs.textAlignment = NSTextAlignmentLeft;
          lvs.font = [UIFont systemFontOfSize:13];
          lvs.textColor = kUIColorFromRGB(color_2);
     }
      lvs.text = _dataDic[@"vip"];
//     if (!_dataDic[@"vipJF"]||[_dataDic[@"vipJF"] isEqualToString:@""]) {
//          lvs.hidden = YES;
//     }
//     else
//     {
//      lvs.text = _dataDic[@"vipJF"];
//          lvs.hidden = NO;
//     }
     [lvv addSubview:lvs];
     if ([lvs.text isEqualToString:@""]) {
          lvv.hidden = YES;
     }
     else
     {
   lvv.hidden = NO;
     }


     UIImageView *bvv = [lvv viewWithTag:1090];
     if (!bvv) {
          bvv = [[UIImageView alloc] initWithFrame:CGRectMake(8, 6, 16, 14)];
          bvv.tag = 1090;

          bvv.image = [UIImage imageContentWithFileName:@"vip_jf"];
     }
     [lvv addSubview:bvv];

     UIImageView *vv = [lvv viewWithTag:1091];
     if (!vv) {
          vv = [[UIImageView alloc] initWithFrame:CGRectMake(140, 8, 6, 10)];
          vv.tag = 1091;

          vv.image = [UIImage imageContentWithFileName:@"rightArrow"];
     }
     [lvv addSubview:vv];
     [self.contentView bringSubviewToFront:_loginBtn];
}

//-(void)setCellData:()
//{
//
//}

@end
