//
//  ImgTitleDetailFiveBtnTableViewCell.m
//  chenxiaoer
//
//  Created by air on 2017/2/15.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import "ImgTitleDetailFiveBtnTableViewCell.h"
#import "BUImageRes.h"
@implementation ImgTitleDetailFiveBtnTableViewCell
{
    IBOutlet UILabel *_titleLb;

    
    CWStarRateView *_starView;
    IBOutlet UIImageView *_imgV;
    BUImageRes *_curImgRes;
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
    _detailLb.text = dataDic[@"detail"];
    _titleLb.text = dataDic[@"title"];
    _imgV.image = [UIImage imageContentWithFileName:dataDic[@"default"]];
    id imgr = dataDic[@"img"];
    if ([imgr isKindOfClass:[NSString class]]) {
          _imgV.image = [UIImage imageContentWithFileName:imgr];
    }
    else if ([imgr isKindOfClass:[BUImageRes class]])
    {
        _curImgRes.isValid = NO;
        BUImageRes *imgRes = imgr;
        imgRes.isValid = YES;
        _curImgRes = imgRes;
        [imgRes displayRemoteImage:_imgV imageName:dataDic[@"default"] thumb:YES size:CGSizeMake(150, 150)];
    }
    
    
}

- (void)starRateView:(CWStarRateView *)starRateView scroePercentDidChange:(CGFloat)newScorePercent
{
      NSInteger num = newScorePercent * 5;
    if (self.handleAction) {
        self.handleAction(@{@"score":@(num)});
    }
}

-(void)fitCommentMode
{
    _titleLb.x = 100;
    _titleLb.textColor = kUIColorFromRGB(color_1);
    _titleLb.font = [UIFont systemFontOfSize:15];
      _titleLb.y = 31;
    
    if (!_starView) {
        _starView = [[CWStarRateView alloc]initWithFrame:CGRectMake(145, 26, 140, 20) numberOfStars:5];
        _starView.scorePercent = 1.0;
        _starView.delegate = self;
        [self.contentView addSubview:_starView];
    }
//    _starView.x = 145;
//    _starView.y = 26;
//    _starView.width = 180;
//    _starView.height = 20;
    
    
    _detailLb.textColor = kUIColorFromRGB(color_5);
    _detailLb.font = [UIFont systemFontOfSize:15];;
    _detailLb.y = _starView.y + _starView.height + 10;
    [_detailLb sizeToFit];
    _detailLb.width = 100;
    
    _imgV.x = 15;
    _imgV.y = 8;
    _imgV.width = 75;
    _imgV.height = 75;
    
   
    self.height = 91;
    _starView.backgroundColor = kUIColorFromRGB(color_4);
}
@end
