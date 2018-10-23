//
//  ScrollerTableViewCell.m
//  deliciousfood
//
//  Created by air on 2017/2/16.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import "ScrollerTableViewCell.h"
#import "BUImageRes.h"
#import "GrayPageControl.h"
#import "SeckillView.h"
#import "WaveProgressView.h"
@implementation ScrollerTableViewCell
{
    IBOutlet UIScrollView *_scrollView;
    NSDictionary *_dataDic;
    NSInteger _pageCount;
     NSMutableArray *_viewsArr;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setCellData:(NSDictionary *)dataDic
{
    _dataDic = dataDic;
    
}


-(void)fitHeadModeA
{
    self.height = 180;
    _scrollView.pagingEnabled = YES;
    NSArray *arr = _dataDic[@"arr"];
    NSInteger c = (arr.count + 9)/10;
     _scrollView.contentSize = CGSizeMake(__SCREEN_SIZE.width * c, self.height);
    for (NSInteger i = 0; i < arr.count; i ++) {
        NSDictionary *dic = arr[i];
        NSString *title = dic[@"title"];
        BUImageRes *img = dic[@"img"];
        UIButton *btn = [_scrollView viewWithTag:200 + i];
        if (!btn) {
            btn = [UIButton new];
            btn.tag = 200 + i;
        }
        btn.width = __SCREEN_SIZE.width/5.0;
        btn.height = (self.height - 16)/2.0;
        [btn setTitle:title forState:UIControlStateNormal];
        [btn fitImgAndTitleMode];
//        [btn setImage:[UIImage imageContentWithFileName:img.cacheFile] forState:UIControlStateNormal];
        btn.customTitleLb.textColor = kUIColorFromRGB(color_1);
        btn.customTitleLb.font = [UIFont systemFontOfSize:12];
        btn.customTitleLb.y = 58;
        btn.customTitleLb.x = 0;
        btn.customTitleLb.width = btn.width;
//        btn.customImgV.image = [UIImage imageContentWithFileName:@"qqLogin"];
        BUImageRes *curImgRes = btn.userInfo;
        curImgRes.isValid = NO;
        curImgRes = img;
        btn.userInfo = img;
        curImgRes.isValid = YES;
        [curImgRes displayRemoteImage:btn.customImgV imageName:@"" thumb:YES];

        [btn addTarget:self action:@selector(btnHandleAction:) forControlEvents:UIControlEventTouchUpInside];
        btn.customImgV.width = 44;
        btn.customImgV.height = 44;
        btn.customImgV.x = btn.width/2.0 -  btn.customImgV.width/2.0;
        btn.customImgV.y = 10;
        
        
        NSInteger n = i/10;//页数
        NSInteger h = (i - n * 10)/5;//行数
        NSInteger r = (i - n * 10)%5;//列数
        btn.x = btn.width * r + n * __SCREEN_SIZE.width;
        btn.y = btn.height * h;
        [_scrollView addSubview:btn];
    }
      _scrollView.delegate = self;
    
    GrayPageControl *pageCl = [self.contentView viewWithTag:5444];
    if (!pageCl) {
        pageCl = [[GrayPageControl alloc] initWithFrame:CGRectMake(0, 0, 90, 20)];
        pageCl.tag = 5444;
    }

    pageCl.autoresizingMask = UIViewAutoresizingFlexibleRightMargin| UIViewAutoresizingFlexibleBottomMargin;
   pageCl.numberOfPages = c;
    pageCl.width = 90;
    pageCl.height = 20;
    pageCl.x = __SCREEN_SIZE.width/2.0 - pageCl.width/2.0;
    pageCl.y = self.height - 24;
    pageCl.currentPageIndicatorTintColor = kUIColorFromRGB(color_2);
    pageCl.pageIndicatorTintColor = kUIColorFromRGBWithAlpha(color_9, 0.8);
    [self.contentView addSubview:pageCl];
    
    _pageCount = c;
    if(c == 0)
    {
        pageCl.hidden = YES;
    }
    else
    {
    pageCl.hidden = NO;
    }
//    [pageCl.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        obj.layer.borderWidth = 1;
//        obj.layer.borderColor = [UIColor redColor].CGColor;//kUIColorFromRGBWithAlpha(color_9, 0.8).CGColor;
//    }];
//    pageCl.layer.borderWidth = 0.5;
    _scrollView.showsHorizontalScrollIndicator = NO;

}

-(void)btnHandleAction:(UIButton *)btn
{
    if (self.handleAction) {
        self.handleAction(btn);
    }
}
-(void)fitRecycleInfoMode
{
     _scrollView.backgroundColor = [UIColor clearColor];
     _scrollView.pagingEnabled = YES;
     _scrollView.showsHorizontalScrollIndicator = NO;
     _scrollView.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _scrollView.width = __SCREEN_SIZE.width;
     UIImageView *imgv = [self.contentView viewWithTag:2020];
     if (!imgv) {
          imgv = [UIImageView new];
          imgv.tag = 2020;
          imgv.width = __SCREEN_SIZE.width;
          imgv.height = 275;
          imgv.image = [UIImage imageContentWithFileName:_dataDic[@"bgImg"]];
          [self.contentView insertSubview:imgv atIndex:0];
     }
     UIButton *aBtn = [self.contentView viewWithTag:2999];
     if(!aBtn)
     {
          aBtn = [UIButton new];
          aBtn.width = __SCREEN_SIZE.width/2.0;
          aBtn.height = 46;
          aBtn.x = 0;
          aBtn.y = 230;
          aBtn.tag = 2999;
     }
     [self.contentView addSubview:aBtn];
     [aBtn fitImgAndTitleMode];
     [self setBtnFitMode:aBtn withText: _dataDic[@"aDetail"] withTitle:_dataDic[@"aTitle"]];

       UIButton *bBtn = [self.contentView viewWithTag:3000];
       if(!bBtn)
       {
            bBtn = [UIButton new];
            bBtn.width = aBtn.width;
            bBtn.height = aBtn.height;
            bBtn.x = aBtn.width;
            bBtn.y = aBtn.y;
            bBtn.tag = 3000;
       }
       [self.contentView addSubview:bBtn];
       [bBtn fitImgAndTitleMode];
     [self setBtnFitMode:bBtn withText:_dataDic[@"bDetail"] withTitle:_dataDic[@"bTitle"]];

       UIButton *cBtn = [self.contentView viewWithTag:3001];
       if(!cBtn)
       {
            cBtn = [UIButton new];
            cBtn.width = 130;
            cBtn.height = 30;
            cBtn.x = 15;
            cBtn.y = 0;
            cBtn.tag = 3001;
       }

      [cBtn fitImgAndTitleMode];
      cBtn.customImgV.width = 20;
      cBtn.customImgV.height = 20;
     cBtn.customImgV.contentMode = UIViewContentModeCenter;
     cBtn.customImgV.image = [UIImage imageContentWithFileName:_dataDic[@"img"]];
      cBtn.customImgV.x = 0;
      cBtn.customImgV.y = 5;
      cBtn.customTitleLb.x = 30;
      cBtn.customTitleLb.width = 100;
      cBtn.customTitleLb.height = 15;
      cBtn.customTitleLb.y = 7;
     cBtn.customTitleLb.textAlignment = NSTextAlignmentLeft;
      cBtn.customTitleLb.textColor = kUIColorFromRGB(color_2);
      cBtn.customTitleLb.font = [UIFont systemFontOfSize:15];
     cBtn.customTitleLb.text = _dataDic[@"title"];
     [cBtn addTarget:self action:@selector(btnHandleAction:) forControlEvents:UIControlEventTouchUpInside];
     [self.contentView addSubview:cBtn];
     UIView *line = [self.contentView viewWithTag:999];
     if (!line) {
          line  = [[UIView alloc] initWithFrame:CGRectMake(__SCREEN_SIZE.width/2.0, 230, 0.5, 46)];
          line.tag = 999;
     }
     line.backgroundColor = kUIColorFromRGBWithAlpha(color_2, 0.1);
     [self.contentView addSubview:line];

     UIButton *lBtn = [self.contentView viewWithTag:3002];
     if(!lBtn)
     {
          lBtn = [UIButton new];
          lBtn.width = 10;
          lBtn.height = 18;
          lBtn.x = 15;
          lBtn.y = 107;
          lBtn.tag = 3002;

     }
       [lBtn setImage:[UIImage imageContentWithFileName:_dataDic[@"leftImg"]] forState:UIControlStateNormal];
     [self.contentView addSubview:lBtn];


     UIButton *rBtn = [self.contentView viewWithTag:3003];
     if(!rBtn)
     {
          rBtn = [UIButton new];
          rBtn.width = 10;
          rBtn.height = 18;
          rBtn.x = __SCREEN_SIZE.width - rBtn.width - 15;
          rBtn.y = 107;
          rBtn.tag = 3003;

     }
      [rBtn setImage:[UIImage imageContentWithFileName:_dataDic[@"rightImg"]] forState:UIControlStateNormal];
     [self.contentView addSubview:rBtn];

     NSArray *arr =  _dataDic[@"recycleInfo"];
      for (NSInteger i = 0; i< arr.count; i++)
      {
           NSDictionary *dic = arr[i];
           UIView *v = [_scrollView viewWithTag:1100+ i];

           if(!v)
           {
                v = [UILabel new];
                v.tag = 1100 + i;
                v.width = 131;
                v.height = 131;
                v.backgroundColor = kUIColorFromRGB(color_2);
                v.y = 50;
                v.x = __SCREEN_SIZE.width / 2.0 - v.width/2.0 + i * (__SCREEN_SIZE.width);
                v.layer.masksToBounds = YES;
                v.layer.cornerRadius = v.height/2.0;
//                v.layer.borderWidth = 5;
//                v.layer.borderColor = kUIColorFromRGBWithAlpha(color_2, 0.1).CGColor;
           }
           [_scrollView addSubview:v];

           UIView *v2 = [_scrollView viewWithTag:1600+ i];

           if(!v2)
           {
                v2 = [UILabel new];
                v2.tag = 1600 + i;
                v2.width = 141;
                v2.height = 141;
//                v2.backgroundColor = kUIColorFromRGB(color_2);
                v2.y = 45;
                v2.x = __SCREEN_SIZE.width / 2.0 - v2.width/2.0 + i * (__SCREEN_SIZE.width);
                v2.layer.masksToBounds = YES;
                v2.layer.cornerRadius = v2.height/2.0;
                v2.layer.borderWidth = 5;
                v2.layer.borderColor = kUIColorFromRGBWithAlpha(color_2, 0.1).CGColor;
           }
           [_scrollView addSubview:v2];

           WaveProgressView *wav = [_scrollView viewWithTag:1000 +i];
           if(!wav)
           {
                wav = [WaveProgressView new];
                wav.tag = 1000 + i;
                wav.width = 131;
                wav.height = 131;
                wav.backgroundColor = kUIColorFromRGB(color_2);
                wav.y = 50;
                wav.isCircle = YES;
                wav.x = __SCREEN_SIZE.width / 2.0 - wav.width/2.0 + i * (__SCREEN_SIZE.width);
                //                v.layer.masksToBounds = YES;
                //                v.layer.cornerRadius = v.height/2.0;
           }
           wav.showPercent = NO;
           wav.percent = [dic[@"value"] floatValue];
           wav.firstWaveColor = kUIColorFromRGB(color_0x1fb2f4);
           wav.secondWaveColor = kUIColorFromRGB(color_0x04a2ea);
           [_scrollView addSubview:wav];

           UILabel *titleLb = [_scrollView viewWithTag:1200+ i];
           if(!titleLb)
           {
                titleLb = [UILabel new];
                titleLb.tag = 1200 + i;
                titleLb.width = 120;
                titleLb.height = 13;
                titleLb.font = [UIFont systemFontOfSize:13];
                titleLb.textColor = kUIColorFromRGB(color_3);
                titleLb.textAlignment = NSTextAlignmentCenter;
                titleLb.y = 81;
                titleLb.x = __SCREEN_SIZE.width / 2.0 - titleLb.width/2.0 + i * (__SCREEN_SIZE.width);

           }
           titleLb.text = dic[@"title"];
           [_scrollView addSubview:titleLb];
           UILabel *countLb = [_scrollView viewWithTag:1300+ i];
           if(!countLb)
           {
                countLb = [UILabel new];
                countLb.tag = 1300 + i;
                countLb.width = 120;
                countLb.height = 24;
                countLb.font = [UIFont systemFontOfSize:24];
                countLb.textColor = kUIColorFromRGB(color_3);
                countLb.textAlignment = NSTextAlignmentCenter;
                countLb.y = titleLb.y + titleLb.height + 14;
                countLb.x = __SCREEN_SIZE.width /2.0 - countLb.width/2.0 + i * (__SCREEN_SIZE.width);

           }
           countLb.text = dic[@"count"];
           [_scrollView addSubview:countLb];


           UILabel *detail1Lb = [_scrollView viewWithTag:1400+ i];
           if(!detail1Lb)
           {
                detail1Lb = [UILabel new];
                detail1Lb.tag = 1400 + i;
                detail1Lb.width = 120;
                detail1Lb.height = 12;
                detail1Lb.font = [UIFont systemFontOfSize:12];
                detail1Lb.textColor = kUIColorFromRGB(color_3);
                detail1Lb.textAlignment = NSTextAlignmentCenter;
                detail1Lb.y = countLb.y + countLb.height + 13;
                detail1Lb.x = __SCREEN_SIZE.width /2.0 - detail1Lb.width/2.0 + i * (__SCREEN_SIZE.width);

           }
           detail1Lb.text = dic[@"detail1"];
           [_scrollView addSubview:detail1Lb];

           UILabel *detail2Lb = [_scrollView viewWithTag:1500+ i];
           if(!detail2Lb)
           {
                detail2Lb = [UILabel new];
                detail2Lb.tag = 1500 + i;
                detail2Lb.width = 120;
                detail2Lb.height = 12;
                detail2Lb.font = [UIFont systemFontOfSize:12];
                detail2Lb.textColor = kUIColorFromRGB(color_3);
                detail2Lb.textAlignment = NSTextAlignmentCenter;
                detail2Lb.y = detail1Lb.y + detail1Lb.height + 4;
                detail2Lb.x = __SCREEN_SIZE.width /2.0 - detail2Lb.width/2.0 + i * (__SCREEN_SIZE.width);

           }
             detail2Lb.text = dic[@"detail2"];
           [_scrollView addSubview:detail2Lb];
      }
       _scrollView.contentSize = CGSizeMake(__SCREEN_SIZE.width * arr.count, 275);
       _scrollView.height = 275;
       self.height = 275;
}
-(void)fitRecycleInfoModeB
{
     _scrollView.backgroundColor = [UIColor clearColor];
     _scrollView.pagingEnabled = YES;
     _scrollView.showsHorizontalScrollIndicator = NO;
     _scrollView.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _scrollView.width = __SCREEN_SIZE.width;
     UIImageView *imgv = [self.contentView viewWithTag:2020];
     if (!imgv) {
          imgv = [UIImageView new];
          imgv.tag = 2020;
          imgv.width = __SCREEN_SIZE.width;
          imgv.height = 275;
          imgv.image = [UIImage imageContentWithFileName:_dataDic[@"bgImg"]];
          [self.contentView insertSubview:imgv atIndex:0];
     }
_scrollView.delegate = self;


     UIView *line = [self.contentView viewWithTag:999];
     if (!line) {
          line  = [[UIView alloc] initWithFrame:CGRectMake(__SCREEN_SIZE.width/2.0, 230, 0.5, 46)];
          line.tag = 999;
     }
     line.backgroundColor = kUIColorFromRGBWithAlpha(color_2, 0.1);
     [self.contentView addSubview:line];

     UIButton *lBtn = [self.contentView viewWithTag:3002];
     if(!lBtn)
     {
          lBtn = [UIButton new];
          lBtn.width = 40;
          lBtn.height = 48;
          lBtn.x = 0;
          lBtn.y = 122;
          lBtn.tag = 3002;
//  lBtn.userInfo = @{@"index":@(0)};
     }
     [lBtn setImage:[UIImage imageContentWithFileName:_dataDic[@"leftImg"]] forState:UIControlStateNormal];
     [self.contentView addSubview:lBtn];
     [lBtn addTarget:self action:@selector(leftHandle:) forControlEvents:UIControlEventTouchUpInside];

     UIButton *rBtn = [self.contentView viewWithTag:3003];
     if(!rBtn)
     {
          rBtn = [UIButton new];
          rBtn.width = 40;
          rBtn.height = 48;
          rBtn.x = __SCREEN_SIZE.width - rBtn.width ;
          rBtn.y = 122;
          rBtn.tag = 3003;
//          rBtn.userInfo = @{@"index":@(0)};
     }
     [rBtn setImage:[UIImage imageContentWithFileName:_dataDic[@"rightImg"]] forState:UIControlStateNormal];
     [self.contentView addSubview:rBtn];
[rBtn addTarget:self action:@selector(rightHandle:) forControlEvents:UIControlEventTouchUpInside];
     NSArray *arr =  _dataDic[@"recycleInfo"];
     for (NSInteger i = 0; i< arr.count; i++)
     {
          NSDictionary *dic = arr[i];


          UIButton *aBtn = [_scrollView viewWithTag:2900 +i];
          if(!aBtn)
          {
               aBtn = [UIButton new];
               aBtn.width = __SCREEN_SIZE.width/2.0;
               aBtn.height = 46;
               aBtn.x = 0 + __SCREEN_SIZE.width * i;
               aBtn.y = 230;
               aBtn.tag = 2900 + i;
          }
          [_scrollView addSubview:aBtn];
          [aBtn fitImgAndTitleMode];
          [self setBtnFitMode:aBtn withText: dic[@"aDetail"] withTitle:dic[@"aTitle"]];

          UIButton *bBtn = [_scrollView viewWithTag:3000 + i];
          if(!bBtn)
          {
               bBtn = [UIButton new];
               bBtn.width = aBtn.width;
               bBtn.height = aBtn.height;
               bBtn.x = aBtn.width + __SCREEN_SIZE.width * i;
               bBtn.y = aBtn.y;
               bBtn.tag = 3000 + i;
          }
          [_scrollView addSubview:bBtn];
          [bBtn fitImgAndTitleMode];
          [self setBtnFitMode:bBtn withText:dic[@"bDetail"] withTitle:dic[@"bTitle"]];


          UIButton *cBtn = [_scrollView viewWithTag:3101 +i];
          if(!cBtn)
          {
               cBtn = [UIButton new];
               cBtn.width = 130;
               cBtn.height = 30;
               cBtn.x = 15 + __SCREEN_SIZE.width * i;
               cBtn.y = 0;
               cBtn.tag = 3101 +i;
          }

          [cBtn fitImgAndTitleMode];
//          cBtn.customImgV.width = 20;
//          cBtn.customImgV.height = 20;
//          cBtn.customImgV.contentMode = UIViewContentModeCenter;
//          if([dic[@"img"] isKindOfClass:[BUImageRes class]])
//          {
//               BUImageRes *im = dic[@"img"];
//               im.isValid = YES;
//               [im displayRemoteImage:cBtn.customImgV imageName:nil];
//          }
//          else if([dic[@"img"] isEqualToString:@""])
//          {
//               cBtn.customImgV.image = nil;
//          }
//               else
//          cBtn.customImgV.image = [UIImage imageContentWithFileName:dic[@"img"]];
//          cBtn.customImgV.x = 0 + __SCREEN_SIZE.width * i;
//          cBtn.customImgV.y = 5;
          cBtn.customImgV.hidden = YES;
          cBtn.customTitleLb.x = 0;
          cBtn.customTitleLb.width = 130;
          cBtn.customTitleLb.height = 16;
          cBtn.customTitleLb.y = 7;
          cBtn.customTitleLb.textAlignment = NSTextAlignmentLeft;
          cBtn.customTitleLb.textColor = kUIColorFromRGB(color_2);
          cBtn.customTitleLb.font = [UIFont systemFontOfSize:15];
          cBtn.customTitleLb.text = dic[@"titleA"];
          [cBtn addTarget:self action:@selector(btnHandleAction:) forControlEvents:UIControlEventTouchUpInside];
          [_scrollView addSubview:cBtn];


          UIView *v = [_scrollView viewWithTag:1100+ i];

          if(!v)
          {
               v = [UILabel new];
               v.tag = 1100 + i;
               v.width = 131;
               v.height = 131;
               v.backgroundColor = kUIColorFromRGB(color_2);
               v.y = 50;
               v.x = __SCREEN_SIZE.width / 2.0 - v.width/2.0 + i * (__SCREEN_SIZE.width);
               v.layer.masksToBounds = YES;
               v.layer.cornerRadius = v.height/2.0;
               //                v.layer.borderWidth = 5;
               //                v.layer.borderColor = kUIColorFromRGBWithAlpha(color_2, 0.1).CGColor;
          }
          [_scrollView addSubview:v];

          UIView *v2 = [_scrollView viewWithTag:1600+ i];

          if(!v2)
          {
               v2 = [UILabel new];
               v2.tag = 1600 + i;
               v2.width = 141;
               v2.height = 141;
               //                v2.backgroundColor = kUIColorFromRGB(color_2);
               v2.y = 45;
               v2.x = __SCREEN_SIZE.width / 2.0 - v2.width/2.0 + i * (__SCREEN_SIZE.width);
               v2.layer.masksToBounds = YES;
               v2.layer.cornerRadius = v2.height/2.0;
               v2.layer.borderWidth = 5;
               v2.layer.borderColor = kUIColorFromRGBWithAlpha(color_2, 0.1).CGColor;
          }
          [_scrollView addSubview:v2];

          WaveProgressView *wav = [_scrollView viewWithTag:1000 +i];
          if(!wav)
          {
               wav = [WaveProgressView new];
               wav.tag = 1000 + i;
               wav.width = 131;
               wav.height = 131;
               wav.backgroundColor = kUIColorFromRGB(color_2);
               wav.y = 50;
               wav.isCircle = YES;
               wav.x = __SCREEN_SIZE.width / 2.0 - wav.width/2.0 + i * (__SCREEN_SIZE.width);
               //                v.layer.masksToBounds = YES;
               //                v.layer.cornerRadius = v.height/2.0;
          }
          wav.showPercent = NO;
          wav.percent = MIN([dic[@"value"] floatValue]/100.0, 1.0);
          wav.firstWaveColor = kUIColorFromRGB(color_0x1fb2f4);
          wav.secondWaveColor = kUIColorFromRGB(color_0x04a2ea);
          [_scrollView addSubview:wav];

          UILabel *titleLb = [_scrollView viewWithTag:1200+ i];
          if(!titleLb)
          {
               titleLb = [UILabel new];
               titleLb.tag = 1200 + i;
               titleLb.width = 120;
               titleLb.height = 13;
               titleLb.font = [UIFont systemFontOfSize:13];
               titleLb.textColor = kUIColorFromRGB(color_3);
               titleLb.textAlignment = NSTextAlignmentCenter;
               titleLb.y = 81;
               titleLb.x = __SCREEN_SIZE.width / 2.0 - titleLb.width/2.0 + i * (__SCREEN_SIZE.width);

          }
          titleLb.text = dic[@"title"];
          [_scrollView addSubview:titleLb];
          UILabel *countLb = [_scrollView viewWithTag:1300+ i];
          if(!countLb)
          {
               countLb = [UILabel new];
               countLb.tag = 1300 + i;
               countLb.width = 120;
               countLb.height = 24;
               countLb.font = [UIFont systemFontOfSize:24];
               countLb.textColor = kUIColorFromRGB(color_3);
               countLb.textAlignment = NSTextAlignmentCenter;
               countLb.y = titleLb.y + titleLb.height + 14;
               countLb.x = __SCREEN_SIZE.width /2.0 - countLb.width/2.0 + i * (__SCREEN_SIZE.width);

          }
          countLb.text = dic[@"count"];
          [_scrollView addSubview:countLb];


          UILabel *detail1Lb = [_scrollView viewWithTag:1400+ i];
          if(!detail1Lb)
          {
               detail1Lb = [UILabel new];
               detail1Lb.tag = 1400 + i;
               detail1Lb.width = 120;
               detail1Lb.height = 12;
               detail1Lb.font = [UIFont systemFontOfSize:12];
               detail1Lb.textColor = kUIColorFromRGB(color_3);
               detail1Lb.textAlignment = NSTextAlignmentCenter;
               detail1Lb.y = countLb.y + countLb.height + 13;
               detail1Lb.x = __SCREEN_SIZE.width /2.0 - detail1Lb.width/2.0 + i * (__SCREEN_SIZE.width);

          }
          detail1Lb.text = dic[@"detail1"];
          [_scrollView addSubview:detail1Lb];

          UILabel *detail2Lb = [_scrollView viewWithTag:1500+ i];
          if(!detail2Lb)
          {
               detail2Lb = [UILabel new];
               detail2Lb.tag = 1500 + i;
               detail2Lb.width = 120;
               detail2Lb.height = 12;
               detail2Lb.font = [UIFont systemFontOfSize:12];
               detail2Lb.textColor = kUIColorFromRGB(color_3);
               detail2Lb.textAlignment = NSTextAlignmentCenter;
               detail2Lb.y = detail1Lb.y + detail1Lb.height + 4;
               detail2Lb.x = __SCREEN_SIZE.width /2.0 - detail2Lb.width/2.0 + i * (__SCREEN_SIZE.width);

          }
          detail2Lb.text = dic[@"detail2"];
          [_scrollView addSubview:detail2Lb];
     }
      GrayPageControl *pageCl = [self.contentView viewWithTag:5444];
     pageCl.hidden = YES;
     _scrollView.contentSize = CGSizeMake(__SCREEN_SIZE.width * arr.count, 275);
     _scrollView.height = 275;
     self.height = 275;
}

-(void)leftHandle:(UIButton*)btn
{

     GrayPageControl *pageCl = [self.contentView viewWithTag:5444];
     NSInteger index = pageCl.currentPage;
     if (index == 0) {
          return;
     }
     index--;
//     pageCl.currentPage = index;
//     btn.userInfo = @{@"index":@(index)};
     [_scrollView scrollRectToVisible:CGRectMake(__SCREEN_SIZE.width * index, 0, _scrollView.width, _scrollView.height) animated:YES];
}

-(void)rightHandle:(UIButton*)btn
{
     NSArray *arr =  _dataDic[@"recycleInfo"];
     GrayPageControl *pageCl = [self.contentView viewWithTag:5444];
    NSInteger index = pageCl.currentPage;
     if (index == arr.count - 1) {
          return;
     }
     index++;
//      pageCl.currentPage = index;
//     btn.userInfo = @{@"index":@(index)};
     [_scrollView scrollRectToVisible:CGRectMake(__SCREEN_SIZE.width * index, 0, _scrollView.width, _scrollView.height) animated:YES];
}

-(void)setBtnFitMode:(UIButton *)btn withText:(NSString *)txt withTitle:(NSString*)title
{
     btn.customTitleLb.text = title;
     btn.customTitleLb.textColor = kUIColorFromRGB(color_2);
     btn.customTitleLb.font = [UIFont systemFontOfSize:15];
     btn.customTitleLb.y = 9;
     btn.customTitleLb.height = 17;
     btn.customDetailLb.y = 27;
     btn.customDetailLb.font = [UIFont systemFontOfSize:12];
     btn.customDetailLb.height = 12;
     btn.customDetailLb.textColor = kUIColorFromRGB(color_2);
     btn.customDetailLb.text = txt;
     btn.customImgV.hidden = YES;
     btn.backgroundColor = kUIColorFromRGBWithAlpha(color_2, 0.07);
}


-(void)fitHeadModeB
{
     self.height = 190;
    _scrollView.pagingEnabled = YES;
    NSArray *arr = _dataDic[@"arr"];
    NSInteger c = (arr.count + 5)/6;
    _scrollView.contentSize = CGSizeMake(__SCREEN_SIZE.width * c, self.height);
    for (NSInteger i = 0; i < arr.count; i ++) {
        NSDictionary *dic = arr[i];
        NSString *title = dic[@"title"];
        BUImageRes *img = dic[@"img"];
        UIButton *btn = [_scrollView viewWithTag:200 + i];
        if (!btn) {
            btn = [UIButton new];
            btn.tag = 200 + i;
        }
        btn.width = (__SCREEN_SIZE.width - 15)/3.0;
        btn.height = (self.height - 16)/2.0;
        [btn setTitle:title forState:UIControlStateNormal];
        [btn fitImgAndTitleMode];
        //        [btn setImage:[UIImage imageContentWithFileName:img.cacheFile] forState:UIControlStateNormal];
        btn.customTitleLb.textColor = kUIColorFromRGB(color_1);
        btn.customTitleLb.font = [UIFont systemFontOfSize:12];
        
        btn.customTitleLb.x = 7.5;
        btn.customTitleLb.textAlignment = NSTextAlignmentLeft;
        btn.customTitleLb.width = btn.width - 15;
        //        btn.customImgV.image = [UIImage imageContentWithFileName:@"qqLogin"];
        BUImageRes *curImgRes = btn.userInfo;
        curImgRes.isValid = NO;
        curImgRes = img;
        btn.userInfo = img;
        curImgRes.isValid = YES;
        [curImgRes displayRemoteImage:btn.customImgV imageName:@"" thumb:YES];
        btn.customImgV.width = MIN(btn.width - 15, 100);
        btn.customImgV.height = 3/5.0 *btn.customImgV.width;
         btn.customImgV.x = 7.5;
        btn.customImgV.y = 0;
        btn.customTitleLb.y = btn.customImgV.y + btn.customImgV.height + 6;
        NSInteger n = i/6;//页数
        NSInteger h = (i - n * 6)/3;//行数
        NSInteger r = (i - n * 6)%3;//列数
        btn.x = btn.width * r + n * (__SCREEN_SIZE.width - 15);
        btn.y = btn.height * h;
        [_scrollView addSubview:btn];
         [btn addTarget:self action:@selector(btnHandleAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    _scrollView.delegate = self;
    
     GrayPageControl *pageCl = [self.contentView viewWithTag:5444];
    if (!pageCl) {
       pageCl = [[GrayPageControl alloc] initWithFrame:CGRectMake(0, 0, 90, 20)];
            pageCl.tag = 5444;
    }
   
    pageCl.autoresizingMask = UIViewAutoresizingFlexibleRightMargin| UIViewAutoresizingFlexibleBottomMargin;
    pageCl.numberOfPages = c;
    
    pageCl.width = 90;
    pageCl.height = 20;
    pageCl.x = __SCREEN_SIZE.width/2.0 - pageCl.width/2.0;
    pageCl.y = self.height - 24;
    pageCl.currentPageIndicatorTintColor = kUIColorFromRGB(color_2);
    pageCl.pageIndicatorTintColor = kUIColorFromRGBWithAlpha(color_9, 0.8);
    [self.contentView addSubview:pageCl];
   
    _pageCount = c;
    if(c == 0)
    {
        pageCl.hidden = YES;
    }
    else
    {
        pageCl.hidden = NO;
    }
//    [pageCl.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        obj.layer.borderWidth = 0.5;
//        obj.layer.borderColor = kUIColorFromRGBWithAlpha(color_9, 0.8).CGColor;
//    }];
//    pageCl.layer.borderWidth = 0.5;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.x = 7.5;
    _scrollView.width = __SCREEN_SIZE.width - 15;
}


-(void)fitClassityMode
{
    self.height = 150;
    _scrollView.pagingEnabled = YES;
    NSArray *arr = _dataDic[@"arr"];
    NSInteger c = (arr.count + 7)/8;
    _scrollView.contentSize = CGSizeMake(__SCREEN_SIZE.width * c, self.height);
    for (NSInteger i = 0; i < arr.count; i ++) {
        NSDictionary *dic = arr[i];
        NSString *title = dic[@"title"];
        NSString *img = dic[@"img"];
        UIButton *btn = [_scrollView viewWithTag:200 + i];
        if (!btn) {
            btn = [UIButton new];
            btn.tag = 200 + i;
        }
        btn.width = __SCREEN_SIZE.width/4.0;
        btn.height = (self.height - 16)/2.0;
        [btn setTitle:title forState:UIControlStateNormal];
        [btn fitImgAndTitleMode];
        //        [btn setImage:[UIImage imageContentWithFileName:img.cacheFile] forState:UIControlStateNormal];
        btn.customTitleLb.textColor = kUIColorFromRGB(color_1);
        btn.customTitleLb.font = [UIFont systemFontOfSize:12];
        btn.customTitleLb.y = 56;
        btn.customTitleLb.x = 0;
        btn.customTitleLb.width = btn.width;
        //        btn.customImgV.image = [UIImage imageContentWithFileName:@"qqLogin"];
//        BUImageRes *curImgRes = btn.userInfo;
//        curImgRes.isValid = NO;
//        curImgRes = img;
//        btn.userInfo = img;
//        curImgRes.isValid = YES;
//        [curImgRes displayRemoteImage:btn.customImgV imageName:@"" thumb:YES];
        
        [btn addTarget:self action:@selector(btnHandleAction:) forControlEvents:UIControlEventTouchUpInside];
        btn.customImgV.width = 35;
        btn.customImgV.height = 35;   
        btn.customImgV.x = btn.width/2.0 -  btn.customImgV.width/2.0;
        btn.customImgV.y = 16;
         btn.customImgV.image = [UIImage imageNamed:img];
        
        NSInteger n = i/8;//页数
        NSInteger h = (i - n * 8)/4;//行数
        NSInteger r = (i - n * 8)%4;//列数
        btn.x = btn.width * r + n * __SCREEN_SIZE.width;
        btn.y = btn.height * h;
        [_scrollView addSubview:btn];
    }
    _scrollView.delegate = self;
    if (arr.count <=4) {
        self.height = 90;
        _scrollView.contentSize = CGSizeMake(__SCREEN_SIZE.width * c, self.height);
    }
    
    GrayPageControl *pageCl = [self.contentView viewWithTag:5444];
    if (!pageCl) {
        pageCl = [[GrayPageControl alloc] initWithFrame:CGRectMake(0, 0, 90, 20)];
        pageCl.tag = 5444;
    }
    
    pageCl.autoresizingMask = UIViewAutoresizingFlexibleRightMargin| UIViewAutoresizingFlexibleBottomMargin;
    pageCl.numberOfPages = c;
    pageCl.width = 90;
    pageCl.height = 20;
    pageCl.x = __SCREEN_SIZE.width/2.0 - pageCl.width/2.0;
    pageCl.y = self.height - 24;
    pageCl.currentPageIndicatorTintColor = kUIColorFromRGB(color_2);
    pageCl.pageIndicatorTintColor = kUIColorFromRGBWithAlpha(color_9, 0.8);
    [self.contentView addSubview:pageCl];
    
    _pageCount = c;
    if(c == 1)
    {
        pageCl.hidden = YES;
    }
    else
    {
        pageCl.hidden = NO;
    }
    //    [pageCl.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
    //        obj.layer.borderWidth = 1;
    //        obj.layer.borderColor = [UIColor redColor].CGColor;//kUIColorFromRGBWithAlpha(color_9, 0.8).CGColor;
    //    }];
    //    pageCl.layer.borderWidth = 0.5;
    _scrollView.showsHorizontalScrollIndicator = NO;
    
}



-(void)fitEvaluationMode:(BOOL)isAllShow
{
     self.height = 150;
     _scrollView.pagingEnabled = YES;
     NSArray *arr = _dataDic[@"arr"];
     if (!isAllShow) {
          if (arr.count>8) {
               arr = [arr subarrayWithRange:NSMakeRange(0, 8)];
          }
     }
     CGFloat height = (arr.count + 3)/4 *75.0;
     
     NSInteger c = (arr.count + 7)/8;
     _scrollView.contentSize = CGSizeMake(__SCREEN_SIZE.width, self.height);
     for (NSInteger i = 0; i < arr.count; i ++) {
          NSDictionary *dic = arr[i];
          NSString *title = dic[@"title"];
          id img = dic[@"img"];
          UIButton *btn = [_scrollView viewWithTag:200 + i];
          if (!btn) {
               btn = [UIButton new];
               btn.tag = 200 + i;
          }
          btn.width = __SCREEN_SIZE.width/4.0;
          btn.height = (self.height - 16)/2.0;
          [btn setTitle:title forState:UIControlStateNormal];
          [btn fitImgAndTitleMode];
          //        [btn setImage:[UIImage imageContentWithFileName:img.cacheFile] forState:UIControlStateNormal];
          btn.customTitleLb.textColor = kUIColorFromRGB(color_1);
          btn.customTitleLb.font = [UIFont systemFontOfSize:12];
          btn.customTitleLb.y = 56;
          btn.customTitleLb.x = 0;
          btn.customTitleLb.width = btn.width;
          
//             btn.customImgV.image = [UIImage imageContentWithFileName:@"default"];
          if ([img isKindOfClass:[BUImageRes class]]) {
               BUImageRes *curImgRes = img;
               curImgRes.isValid = NO;
               curImgRes = img;
               btn.userInfo = img;
               curImgRes.isValid = YES;
               [curImgRes displayRemoteImage:btn.customImgV imageName:@"default" thumb:YES];
          }else if ([img isKindOfClass:[NSString class]]){
               btn.customImgV.image = [UIImage imageNamed:img];
          }
          
          
          [btn addTarget:self action:@selector(btnHandleAction:) forControlEvents:UIControlEventTouchUpInside];
          btn.customImgV.width = 35;
          btn.customImgV.height = 35;
          btn.customImgV.x = btn.width/2.0 -  btn.customImgV.width/2.0;
          btn.customImgV.y = 16;
//
          
          NSInteger n = 0;//i/8;//页数
          NSInteger h = (i - n * 8)/4;//行数
          NSInteger r = (i - n * 8)%4;//列数
          btn.x = btn.width * r + n * __SCREEN_SIZE.width;
          btn.y = btn.height * h;
          [_scrollView addSubview:btn];
     }
     _scrollView.delegate = self;
     if (arr.count <=4) {
          self.height = 90;
          _scrollView.contentSize = CGSizeMake(__SCREEN_SIZE.width * c, self.height);
     }
     
     GrayPageControl *pageCl = [self.contentView viewWithTag:5444];
     pageCl.hidden = YES;
//     if (!pageCl) {
//          pageCl = [[GrayPageControl alloc] initWithFrame:CGRectMake(0, 0, 90, 20)];
//          pageCl.tag = 5444;
//     }
//     
//     pageCl.autoresizingMask = UIViewAutoresizingFlexibleRightMargin| UIViewAutoresizingFlexibleBottomMargin;
//     pageCl.numberOfPages = c;
//     pageCl.width = 90;
//     pageCl.height = 20;
//     pageCl.x = __SCREEN_SIZE.width/2.0 - pageCl.width/2.0;
//     pageCl.y = self.height - 24;
//     pageCl.currentPageIndicatorTintColor = kUIColorFromRGB(color_2);
//     pageCl.pageIndicatorTintColor = kUIColorFromRGBWithAlpha(color_9, 0.8);
//     [self.contentView addSubview:pageCl];
//     
//     _pageCount = c;
//     if(c == 1)
//     {
//          pageCl.hidden = YES;
//     }
//     else
//     {
//          pageCl.hidden = NO;
//     }
     //    [pageCl.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
     //        obj.layer.borderWidth = 1;
     //        obj.layer.borderColor = [UIColor redColor].CGColor;//kUIColorFromRGBWithAlpha(color_9, 0.8).CGColor;
     //    }];
     //    pageCl.layer.borderWidth = 0.5;
     _scrollView.showsHorizontalScrollIndicator = NO;
     
     
     self.height = height;
}

- (void) scrollViewDidScroll:(UIScrollView *)sender {
    // 得到每页宽度
    CGFloat pageWidth = sender.frame.size.width;
    // 根据当前的x坐标和页宽度计算出当前页数
    int currentPage = floor((sender.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
//    if(currentPage == _pageCount)
//    {
//        currentPage = 0;
//    }
    GrayPageControl *pageCl = [self.contentView viewWithTag:5444];
    pageCl.currentPage= currentPage;
    
}

-(void)fitHeadMode
{
     self.height = 184;
     _scrollView.pagingEnabled = YES;
     NSArray *arr = _dataDic[@"arr"];
     NSInteger c = (arr.count + 9)/10;
     CGFloat w;
     for (NSInteger i = 0; i < arr.count; i ++) {
          NSDictionary *dic = arr[i];
          NSString *title = dic[@"title"];
           NSString *detail = dic[@"detail"];
           NSString *content = dic[@"content"];
          BUImageRes *img = dic[@"img"];
          SeckillView *sv = [_scrollView viewWithTag:900 + i];
          if (!sv) {
               sv = [SeckillView createView];
               sv.tag = 900 + i;
          }
          sv.titleLb.text = title;
          sv.detailLb.text = detail;
          sv.contentLb.text = content;
          [sv fitHeadMode];
          sv.x = 15 + i * (sv.width + 17);
          sv.y = 10;
          w = sv.width;
          [_scrollView addSubview:sv];
//          UIButton *btn = [_scrollView viewWithTag:200 + i];
//          if (!btn) {
//               btn = [UIButton new];
               sv.btn.tag = 200 + i;
//          }
//          btn.width = sv.width;
//          btn.height = sv.height;

          if ([img isKindOfClass:[BUImageRes class]]) {
             
          BUImageRes *curImgRes = sv.btn.userInfo;
          curImgRes.isValid = NO;
          curImgRes = img;
          sv.btn.userInfo = img;
          curImgRes.isValid = YES;
          [curImgRes displayRemoteImage:sv.imgV imageName:@"pinpaiA" thumb:YES];
          }
          else if([img isKindOfClass:[NSString class]])
          {
               sv.imgV.image = [UIImage imageContentWithFileName:img];
          }
//          [btn addTarget:self action:@selector(btnHandleAction:) forControlEvents:UIControlEventTouchUpInside];
          [sv setHandleAction:^(UIButton *sender) {
               if (self.handleAction) {
                    self.handleAction(sender);
               }
          }];
//          btn.x = sv.x;
//          btn.y = sv.y;
//          [_scrollView addSubview:btn];
     }
     _scrollView.delegate = self;
     _scrollView.contentSize = CGSizeMake(15 + arr.count * (w + 17), self.height);
  
     _pageCount = c;
     GrayPageControl *pageCl = [self.contentView viewWithTag:5444];
     pageCl.hidden = YES;
     _scrollView.showsHorizontalScrollIndicator = NO;
     
}

-(void)fitShopMode
{
     self.height = 180;
     _scrollView.pagingEnabled = YES;
     NSArray *arr = _dataDic[@"arr"];
     NSInteger c = (arr.count + 9)/10;
     
     [_viewsArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
          UIView *v = obj;
          [v removeFromSuperview];
     }];
     _viewsArr = [NSMutableArray new];
     _scrollView.contentSize = CGSizeMake(__SCREEN_SIZE.width * c, self.height);
     for (NSInteger i = 0; i < arr.count; i ++) {
          NSDictionary *dic = arr[i];
          NSString *title = dic[@"title"];
          id img = dic[@"img"];
          UIButton *btn = [_scrollView viewWithTag:200 + i];
          if (!btn) {
               btn = [UIButton new];
               btn.tag = 200 + i;
          }
          btn.width = __SCREEN_SIZE.width/5.0;
          btn.height = (self.height - 16)/2.0;
          [btn setTitle:title forState:UIControlStateNormal];
          [btn fitImgAndTitleMode];
          //        [btn setImage:[UIImage imageContentWithFileName:img.cacheFile] forState:UIControlStateNormal];
          btn.customTitleLb.textColor = kUIColorFromRGB(color_1);
          btn.customTitleLb.font = [UIFont systemFontOfSize:12];
          btn.customTitleLb.y = 60;
          btn.customTitleLb.x = 0;
          btn.customTitleLb.width = btn.width;
//             btn.customImgV.image = [UIImage imageContentWithFileName:@"default"];
//          btn.customImgV.contentMode = UIViewContentModeCenter;
          if ([img isKindOfClass:[BUImageRes class]]) {
               BUImageRes *curImgRes = btn.userInfo;
               curImgRes.isValid = NO;
               curImgRes = img;
               btn.userInfo = img;
               curImgRes.isValid = YES;
//               btn.customImgV.image = [UIImage imageNamed:@"default"];
               if (curImgRes.Image.length != 0) {
//                    [curImgRes displayRemoteImage:btn.imageView imageName:@""];
                    [curImgRes download:self callback:@selector(getImgNotification:) extraInfo:@{@"img":btn.customImgV}];
               }
               
          }else if ([img isKindOfClass:[NSString class]]){
               btn.customImgV.contentMode = UIViewContentModeScaleToFill;
               btn.customImgV.image = [UIImage imageNamed:img];
          }
          
          
          [btn addTarget:self action:@selector(btnHandleAction:) forControlEvents:UIControlEventTouchUpInside];
          btn.customImgV.width = 40;
          btn.customImgV.height = 40;
          btn.customImgV.x = btn.width/2.0 -  btn.customImgV.width/2.0;
          btn.customImgV.y = 13;
          
          if ([_dataDic[@"hidden"] boolValue]) {
               btn.hidden = YES;
               btn.userInteractionEnabled = NO;
          }else{
               btn.hidden = NO;
               btn.userInteractionEnabled = YES;
          }
          
          NSInteger n = i/10;//页数
          NSInteger h = (i - n * 10)/5;//行数
          NSInteger r = (i - n * 10)%5;//列数
          btn.x = btn.width * r + n * __SCREEN_SIZE.width;
          btn.y = btn.height * h;
          [_scrollView addSubview:btn];
          [_viewsArr addObject:btn];
     }
     _scrollView.delegate = self;
     if (arr.count == 0) {
          self.height = 0.01;
          _scrollView.contentSize = CGSizeMake(__SCREEN_SIZE.width * c, self.height);
     }
     else if (arr.count <=5) {
          self.height = 90;
          _scrollView.contentSize = CGSizeMake(__SCREEN_SIZE.width * c, self.height);
     }
     
     GrayPageControl *pageCl = [self.contentView viewWithTag:5444];
     if (!pageCl) {
          pageCl = [[GrayPageControl alloc] initWithFrame:CGRectMake(0, 0, __SCREEN_SIZE.width-30, 20)];
          pageCl.tag = 5444;
          pageCl.userInteractionEnabled = NO;
          
     }
     
     pageCl.autoresizingMask = UIViewAutoresizingFlexibleRightMargin| UIViewAutoresizingFlexibleBottomMargin;
     pageCl.numberOfPages = c;
     
     pageCl.width = __SCREEN_SIZE.width-30;
     pageCl.height = 20;
     pageCl.x = __SCREEN_SIZE.width/2.0 - pageCl.width/2.0;
     pageCl.y = self.height - 18;
//     pageCl.currentPageIndicatorTintColor = kUIColorFromRGB(color_3);
//     pageCl.pageIndicatorTintColor = kUIColorFromRGB(color_8);
     [self.contentView addSubview:pageCl];
     [pageCl setCurrentPage:0];
     [pageCl updateDots];
     
     _pageCount = c;
     if(c == 1)
     {
          pageCl.hidden = YES;
     }
     else
     {
          pageCl.hidden = NO;
     }
     //    [pageCl.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
     //        obj.layer.borderWidth = 1;
     //        obj.layer.borderColor = [UIColor redColor].CGColor;//kUIColorFromRGBWithAlpha(color_9, 0.8).CGColor;
     //    }];
     //    pageCl.layer.borderWidth = 0.5;
     _scrollView.showsHorizontalScrollIndicator = NO;
}

-(void)getImgNotification:(BSNotification *) noti
{
     if(noti.error.code ==0)
     {
          BUImageRes *res =(BUImageRes *) noti.target;
          if (res.isCached) {
               UIImageView * imgV = noti.extraInfo[@"img"];
               UIImage *im = [UIImage imageWithContentsOfFile:res.cacheFile];
               if (im) {
                    imgV.contentMode = UIViewContentModeScaleToFill;
                    imgV.image = im;
               }
          }
     }
}


-(void)fitSearchMode
{
     self.height = 96;
     _scrollView.pagingEnabled = YES;
     NSArray *arr = _dataDic[@"arr"];
//     NSInteger c = (arr.count + 9)/10;
     CGFloat w = 0.0;
     CGFloat x = 15.0;
     CGFloat y = 15.0;
     for (NSInteger i = 0; i < arr.count; i ++) {
//          NSDictionary *dic = arr[i];
          NSString *title = arr[i];
         
          UIButton *btn = [_scrollView viewWithTag:200 + i];
          if (!btn) {
               btn = [UIButton new];
               btn.tag = 200 + i;
          }
          [btn setTitle:title forState:UIControlStateNormal];
          
          
          [btn setTitleColor:kUIColorFromRGB(color_0xf82D45) forState:UIControlStateNormal];
          [btn addTarget:self action:@selector(btnHandleAction:) forControlEvents:UIControlEventTouchUpInside];
          btn.titleLabel.font = [UIFont systemFontOfSize:14];
//          btn.backgroundColor = kUIColorFromRGB(color_0xf5f5f5);
          [btn sizeToFit];
          if (btn.width >__SCREEN_SIZE.width-30) {
               btn.width = __SCREEN_SIZE.width-30;
          }else{
               btn.width +=30;
          }
          btn.height = 25;
           btn.x = x;
          x = x + btn.width + 15;
          if (x>__SCREEN_SIZE.width) {
               x= 15 +btn.width + 15;
               y = btn.height +y +15;
               btn.x = 15;
          }
          btn.y = y;
         
          w = btn.width;
          btn.layer.cornerRadius = btn.height/2.0;
          btn.layer.borderColor = kUIColorFromRGB(color_0xf82D45).CGColor;
          btn.layer.masksToBounds = YES;
          btn.layer.borderWidth = 0.5;
          [_scrollView addSubview:btn];
     }
     self.height = y +25 +15;
     _scrollView.delegate = self;
     _scrollView.contentSize = CGSizeMake(__SCREEN_SIZE.width, self.height);
     
//     _pageCount = c;
      GrayPageControl *pageCl = [self.contentView viewWithTag:5444];
     pageCl.hidden = YES;
     _scrollView.showsHorizontalScrollIndicator = NO;
}

-(void)fitOptimizationRecMode
{
     self.height = 185;
     _scrollView.pagingEnabled = YES;
     NSArray *arr = _dataDic[@"arr"];
     NSInteger c = (arr.count + 9)/10;
     CGFloat w;
     for (NSInteger i = 0; i < arr.count; i ++) {
          NSDictionary *dic = arr[i];
          NSString *title = dic[@"title"];
          NSString *detail = dic[@"detail"];
          NSString *content = dic[@"content"];
          BUImageRes *img = dic[@"img"];
          SeckillView *sv = [_scrollView viewWithTag:900 + i];
          if (!sv) {
               sv = [SeckillView createView];
               sv.tag = 900 + i;
          }
          sv.titleLb.text = title;
          sv.detailLb.text = detail;
          sv.contentLb.text = content;
          [sv fitFreshMode];
          sv.y = 3;
          sv.x = 15 + i * (sv.width + 17);
          w = sv.width;
          [_scrollView addSubview:sv];
          UIButton *btn = [_scrollView viewWithTag:200 + i];
          if (!btn) {
               btn = [UIButton new];
               btn.tag = 200 + i;
          }
          btn.width = sv.width;
          btn.height = sv.height;
          
          if ([img isKindOfClass:[BUImageRes class]]) {
               
               BUImageRes *curImgRes = btn.userInfo;
               curImgRes.isValid = NO;
               curImgRes = img;
               btn.userInfo = img;
               curImgRes.isValid = YES;
               [curImgRes displayRemoteImage:sv.imgV imageName:@"pinpaiA" thumb:YES];
          }
          else if([img isKindOfClass:[NSString class]])
          {
               sv.imgV.image = [UIImage imageContentWithFileName:img];
          }
          [btn addTarget:self action:@selector(btnHandleAction:) forControlEvents:UIControlEventTouchUpInside];
          
          btn.x = sv.x;
          btn.y = sv.y;
          [_scrollView addSubview:btn];
     }
     _scrollView.delegate = self;
     _scrollView.contentSize = CGSizeMake(15 + arr.count * (w + 17), self.height);
     
     _pageCount = c;
     
     _scrollView.showsHorizontalScrollIndicator = NO;
     
}

-(void)fitSecondKillMode
{
     self.height = 51;
     _scrollView.pagingEnabled = YES;
     NSArray *arr = _dataDic[@"arr"];
     //     NSInteger c = (arr.count + 9)/10;
     CGFloat w = 0.0;
     for (NSInteger i = 0; i < arr.count; i ++) {
                    NSDictionary *dic = arr[i];
          NSString *title = dic[@"title"];
          NSString *detail = dic[@"detail"];
          UIButton *btn = [_scrollView viewWithTag:200 + i];
          if (!btn) {
               btn = [UIButton new];
               btn.tag = 200 + i;
          }
          [btn setTitle:@"" forState:UIControlStateNormal];
          btn.width = 110;
          btn.height = 46;
          btn.customTitleLb.width = btn.width;
          btn.customTitleLb.height = 16;
          btn.customTitleLb.font = [UIFont systemFontOfSize:16];
          btn.customTitleLb.x = 0;
          btn.customTitleLb.y = 7;
          btn.customTitleLb.text = title;
          btn.customTitleLb.textColor = kUIColorFromRGB(color_2);
          
          btn.customDetailLb.width = btn.width;
          btn.customDetailLb.height = 16;
          btn.customDetailLb.font = [UIFont systemFontOfSize:16];
          btn.customDetailLb.x = 0;
          btn.customDetailLb.y = 24;
          btn.customDetailLb.text = detail;
          btn.customDetailLb.textColor = kUIColorFromRGB(color_2);
          btn.backgroundColor = kUIColorFromRGB(color_0xb0b0b0);
          
          btn.customImgV.x = 0;
          btn.customImgV.y = 0;
          btn.customImgV.width = btn.width;
          btn.customImgV.height = btn.height + 6;
          btn.customImgV.image = nil;
          btn.customImgV.highlightedImage = [UIImage imageContentWithFileName:@"secKillBg@3x"];
          [btn sendSubviewToBack:btn.customImgV];
          
          [btn addTarget:self action:@selector(btnHandleAction:) forControlEvents:UIControlEventTouchUpInside];
          
          btn.x = 0 + i * (btn.width);
          btn.y = 0;
          w = btn.width;
          [_scrollView addSubview:btn];
     }
     _scrollView.delegate = self;
     _scrollView.contentSize = CGSizeMake(0 + arr.count * (w ), self.height);
      UIButton *btn = [_scrollView viewWithTag:203 ];
     btn.customImgV.highlighted = YES;
     //     _pageCount = c;
     _scrollView.pagingEnabled = NO;
     GrayPageControl *pageCl = [self.contentView viewWithTag:5444];
     pageCl.hidden = YES;
     _scrollView.showsHorizontalScrollIndicator = NO;
}
@end
