//
//  IconAndTitleTableViewCell.m
//  ulife
//
//  Created by air on 15/12/10.
//  Copyright © 2015年 ORANLLC_IOS1. All rights reserved.
//

#import "IconAndTitleTableViewCell.h"
#import "JYQueueView.h"
#import "BUImageRes.h"
@implementation IconAndTitleTableViewCell
{
    IBOutlet UILabel *_bageNumLb;
    IBOutlet UIButton *_btn;
    BUImageRes *_curImgRes;
     JYQueueView *_queueView;
    IBOutlet UILabel *_titleLb;
    IBOutlet UIImageView *_imgV;
    NSInteger _objRow;
    NSDictionary *_dataDic;
}
- (void)awakeFromNib {
    // Initialization code
    _bageNumLb.layer.cornerRadius = _bageNumLb.height/2.0;
    _bageNumLb.backgroundColor = [UIColor redColor];
    _bageNumLb.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setCellData:(NSDictionary *)dataDic
{
    _dataDic = dataDic;
    _titleLb.text = dataDic[@"title"];
    _objRow = [dataDic[@"row"] integerValue];
    if ([dataDic[@"mode"] integerValue] == 1) {
        [self attentionModeView];
    }
    [_titleLb sizeToFit];
    if (dataDic[@"hiddenBtn"]&&![dataDic[@"hiddenBtn"] boolValue]) {
        _btn.hidden = NO;
        [_btn setImage:[UIImage imageContentWithFileName:@"Arrow_right@2x"] forState:UIControlStateNormal];
    }
    else
    {
        _btn.hidden = YES;
    }
    
    if(dataDic[@"hiddenNumLb"]&&![dataDic[@"hiddenNumLb"] boolValue])
    {
        NSInteger d = [dataDic[@"num"] integerValue];
        if (d > 0) {
            _bageNumLb.hidden = NO;
            _bageNumLb.text = [NSString stringWithFormat:@"%ld",d];
        }
        else
        {
         _bageNumLb.hidden = YES;
        }
        
    }
    else
    {
    _bageNumLb.hidden = YES;
    }
    if (dataDic[@"limitInfo"]) {
        [self addIconViews:dataDic[@"limitInfo"] withX:__SCREEN_SIZE.width - 110];
    }
    else
    {
        [self removeIconViews];
    }
    _curImgRes.isValid = NO;
    id img = dataDic[@"img"];
    if (img&&[img isKindOfClass:[BUImageRes class]]) {
        BUImageRes *imgRes = img;
        imgRes.isValid = YES;
        _curImgRes = imgRes;
        _imgV.backgroundColor = [UIColor blueColor];
        [imgRes displayRemoteImage:_imgV imageName:@"defaultHead1@2x" thumb:YES];
    }
    else if (img&&[img isKindOfClass:[NSString class]])
    {
//        NSString *filePath = [[NSBundle mainBundle] pathForResource:img ofType:@"png"];
//        if(!filePath)
//        {
//            filePath = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@",img] ofType:@"png"];
//        }
//        
        _imgV.image = [UIImage imageContentWithFileName:img];
    }

}

-(void)attentionModeView
{
    _imgV.width = 36;
    _imgV.height = 36;
    _imgV.center = self.contentView.center;
    _imgV.x = 10;
   
    _titleLb.center = self.contentView.center;
     _titleLb.x = 60;
    _titleLb.width = 200;
}

- (IBAction)handleAction:(id)sender {
    if (self.handleAction) {
        self.handleAction(@(_objRow));
    }
}
- (IBAction)imgBtnAction:(id)sender {
    if (_imgBtnAction) {
        _imgBtnAction(@(_objRow));
    }
}

-(void)addIconViews:(NSArray *)arr withX:(float)x//加入权限限制的图标标志
{
    [_queueView removeAllView];
    if (!_queueView) {
        _queueView = [[JYQueueView alloc] init];
        _queueView.paddingLeft = 10;
         _queueView.isToRight = YES;
       _queueView.frame = CGRectMake(x, 15, 100, 26);
        [self.contentView addSubview:_queueView];
    }
    [arr enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [_queueView addViewToListView:990 + idx withImgName:obj];
    }];
    
}

-(void)removeIconView:(NSInteger)index
{
    [_queueView removeViewFromListViewWithTag:index + 990];
}

-(void)removeIconViews//删除所有权限限制的图标标志
{
    if (_queueView) {
        [_queueView removeAllView];
        [_queueView removeFromSuperview];
        _queueView = nil;
    }
}

-(void)fitHeadMode
{
    self.height = 90;
    _bageNumLb.hidden = YES;
    _imgV.width = 102;
    _imgV.height = 70;
    _imgV.y = 10;
    _imgV.x = 15;
    
    UIImageView *img3 = [self viewWithTag:4424];
    if (!img3) {
        img3 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, _imgV.width, _imgV.height)];
        img3.tag = 4424;
        img3.x = 0;
        img3.y = 0;
    }
    img3.image =  [UIImage imageContentWithFileName:@"dborder"];
    
    [_imgV addSubview:img3];
    if (!_imgV.image) {
        _imgV.image = [UIImage imageContentWithFileName:@"actDefault"];
    }
    _titleLb.textColor = kUIColorFromRGB(color_5);
    _titleLb.x = 127;
    _titleLb.numberOfLines = 0;
    _titleLb.width = __SCREEN_SIZE.width - 15 - _titleLb.x;
    _titleLb.font = [UIFont systemFontOfSize:15];
    _titleLb.height = 40;
    _titleLb.y = 12;
   
    self.backgroundColor = kUIColorFromRGB(color_4);
    
    _bageNumLb.textColor = kUIColorFromRGB(color_5);
    _bageNumLb.font = [UIFont systemFontOfSize:13];
    _bageNumLb.textAlignment = NSTextAlignmentRight;
    _bageNumLb.width = 160;
    _bageNumLb.height = 14;
    _bageNumLb.y = self.height - 15 - 14;
    _bageNumLb.x = __SCREEN_SIZE.width - 15 - _bageNumLb.width;
    _bageNumLb.hidden = NO;
    _bageNumLb.layer.cornerRadius = 0;
    _bageNumLb.backgroundColor = [UIColor clearColor];
    _bageNumLb.layer.masksToBounds = NO;
    _bageNumLb.text = _dataDic[@"num"];
}

-(void)fitFavMode
{
    self.height = 88;
    _bageNumLb.hidden = YES;
    _imgV.width = 80;
    _imgV.height = 68;
    _imgV.y = 10;
    _imgV.x = 15;
    

    if (!_imgV.image) {
        _imgV.image = [UIImage imageContentWithFileName:@"default"];
    }
    _titleLb.textColor = kUIColorFromRGB(color_1);
    _titleLb.x = 105;
    _titleLb.numberOfLines = 2;
    _titleLb.width = __SCREEN_SIZE.width - 15 - _titleLb.x;
    _titleLb.font = [UIFont systemFontOfSize:14];
    _titleLb.height = 40;
    _titleLb.y = 12;
    [_titleLb sizeToFit];
    
    self.backgroundColor = kUIColorFromRGB(color_4);
    _bageNumLb.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleRightMargin;

    _bageNumLb.textColor = kUIColorFromRGB(color_mainTheme);
    _bageNumLb.font = [UIFont systemFontOfSize:15];
    _bageNumLb.textAlignment = NSTextAlignmentRight;
    _bageNumLb.width = 160;
    _bageNumLb.height = 14;
    _bageNumLb.y = _titleLb.y + _titleLb.height + 7;
    _bageNumLb.x = _titleLb.x;
    _bageNumLb.hidden = NO;
    _bageNumLb.layer.cornerRadius = 0;
    _bageNumLb.backgroundColor = [UIColor clearColor];
    _bageNumLb.layer.masksToBounds = NO;
    _bageNumLb.text = _dataDic[@"num"];
    _bageNumLb.textAlignment = NSTextAlignmentLeft;
}

-(void)fitMsgMode
{
    self.height = 50;
//    _bageNumLb.hidden = YES;
    _imgV.width = 25;
    _imgV.height = 24;
    _imgV.y = 14;
    _imgV.x = 15;
    
    
//    if (!_imgV.image) {
//        _imgV.image = [UIImage imageContentWithFileName:@"default"];
//    }
    _titleLb.textColor = kUIColorFromRGB(color_5);
    _titleLb.x = _imgV.x + _imgV.width + 10;
    _titleLb.numberOfLines = 2;
    _titleLb.width = __SCREEN_SIZE.width - 50 - _titleLb.x;
    _titleLb.font = [UIFont systemFontOfSize:14];
    _titleLb.height = 14;
    _titleLb.y = 8;
//    [_titleLb sizeToFit];
    
    self.backgroundColor = kUIColorFromRGB(color_2);
    _bageNumLb.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleRightMargin;
    
    _bageNumLb.textColor = kUIColorFromRGB(color_mainTheme);
    _bageNumLb.font = [UIFont systemFontOfSize:14];
    _bageNumLb.textAlignment = NSTextAlignmentRight;
    _bageNumLb.width = 20;
    _bageNumLb.height = 14;
    _bageNumLb.y = self.height/2.0 - _bageNumLb.height/2.0;
    _bageNumLb.x = __SCREEN_SIZE.width - 30 - _bageNumLb.width;
    _bageNumLb.layer.cornerRadius = 0;
    _bageNumLb.backgroundColor = [UIColor clearColor];
    _bageNumLb.layer.masksToBounds = NO;
    _bageNumLb.text = _dataDic[@"num"];
     _bageNumLb.textAlignment = NSTextAlignmentCenter;
     
     UILabel *lb = [self.contentView viewWithTag:12113];
     if (!lb) {
          lb = [UILabel new];
          lb.width = __SCREEN_SIZE.width - 90;
          lb.height = 12;
          lb.tag = 12113;
     }
     lb.textAlignment = NSTextAlignmentLeft;
     lb.text = _dataDic[@"detail"];
     lb.textColor = kUIColorFromRGB(color_5);
     lb.font =  [UIFont systemFontOfSize:12];
     lb.x = _titleLb.x;
     lb.y = _titleLb.y + _titleLb.height + 8;
     [self.contentView addSubview:lb];

     UIImageView *imgv = [self.contentView viewWithTag:9222];
     if (!imgv) {
          imgv = [UIImageView new];
          imgv.width = 10;
          imgv.height = 18;
          imgv.y = 16;
          imgv.x = __SCREEN_SIZE.width - 15 - imgv.width;
          imgv.tag = 9222;
          imgv.image = [UIImage imageContentWithFileName:@"rightArrow2"];
     }
     [self.contentView addSubview:imgv];
     
}

-(void)fitTopicMode
{
     self.height = 41;
     _bageNumLb.hidden = YES;
     _imgV.width = 31;
     _imgV.height = 31;
     _imgV.y = 6;
     _imgV.x = 15;

     _titleLb.textColor = kUIColorFromRGB(color_7);
     _titleLb.x = _imgV.x + _imgV.width + 8;
     _titleLb.numberOfLines = 1;
     _titleLb.width = __SCREEN_SIZE.width - 15 - _titleLb.x;
     _titleLb.font = [UIFont systemFontOfSize:15];
     _titleLb.height = 15;
     _titleLb.y = 13;
}

-(void)fitSearchModeA
{
     self.height = 45;
     _bageNumLb.hidden = YES;
     _imgV.width = 46;
     _imgV.height = 29;
     _imgV.y = 8;
     _imgV.x = 15;
     
//     
//     if (!_imgV.image) {
//          _imgV.image = [UIImage imageContentWithFileName:@"default"];
//     }
     _titleLb.textColor = kUIColorFromRGB(color_0xb0b0b0);
     _titleLb.x = 76;
     _titleLb.numberOfLines = 1;
     _titleLb.width = __SCREEN_SIZE.width - 15 - _titleLb.x;
     _titleLb.font = [UIFont systemFontOfSize:15];
     _titleLb.height = 15;
     _titleLb.y = 16;
   
 
 

}

-(void)fitSearchModeB
{
     self.height = 45;
     _bageNumLb.hidden = YES;
     _imgV.width = 30;
     _imgV.height = 30;
     _imgV.y = 8;
     _imgV.x = 15;
     
     //
     //     if (!_imgV.image) {
     //          _imgV.image = [UIImage imageContentWithFileName:@"default"];
     //     }
     _titleLb.textColor = kUIColorFromRGB(color_0xb0b0b0);
     _titleLb.x = 60;
     _titleLb.numberOfLines = 1;
     _titleLb.width = __SCREEN_SIZE.width - 15 - _titleLb.x;
     _titleLb.font = [UIFont systemFontOfSize:15];
     _titleLb.height = 15;
     _titleLb.y = 16;
}

-(void)fitPayMode:(BOOL)b
{
     self.height = 41;
     _imgV.width = 31;
     _imgV.height = 31;
     _imgV.y = 4;
     _imgV.x = 15;
     _imgV.image = [UIImage imageNamed:_dataDic[@"img"]];
//     _imgV.hidden = YES;
     _imgV.backgroundColor = [UIColor clearColor];
     _titleLb.height = 15;
     _titleLb.font = [UIFont systemFontOfSize:15];
     _titleLb.textColor = kUIColorFromRGB(color_1);
     _titleLb.x = 15 + _imgV.width + _imgV.x;
     _titleLb.width = 100;
     _titleLb.y = self.height/2.0 - _titleLb.height/2.0;
     UIImageView *imgv = [self.contentView viewWithTag:9222];
     if (!imgv) {
          imgv = [UIImageView new];
          imgv.width = 15;
          imgv.height = 15;
          imgv.y = 15;
          imgv.x = __SCREEN_SIZE.width - imgv.width - 15;
          imgv.tag = 9222;
          imgv.image = [UIImage imageContentWithFileName:@"unCheck2"];
          imgv.highlightedImage = [UIImage imageContentWithFileName:@"check"];
     }

     imgv.highlighted = b;
     [self.contentView addSubview:imgv];

}

@end
