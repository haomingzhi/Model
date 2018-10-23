//
//  MessageTableViewCell.m
//  ulife
//
//  Created by air on 15/12/22.
//  Copyright © 2015年 ORANLLC_IOS1. All rights reserved.
//

#import "MessageTableViewCell.h"
#import "BUImageRes.h"
#import "YYKit.h"
#import "WBStatusHelper.h"
#import "WBStatusLayout.h"
#import "WBStatusComposeTextParser.h"

@implementation MessageTableViewCell
{
    IBOutlet UILabel *_contentLb;

    IBOutlet UILabel *_infoContentLb;
    IBOutlet UILabel *_timeLb;
    IBOutlet UIImageView *_img2V;
    IBOutlet UILabel *_titleLb;
    IBOutlet UIImageView *_imgV;
    BUImageRes *_curImgRes;
    BUImageRes *_curImg2Res;
     YYLabel *_contentYYLb;
     YYLabel *_infoContentYYLb;
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
    [_contentYYLb removeFromSuperview];
    _contentYYLb = nil;
    [self initContentYYlable];
    _contentYYLb.numberOfLines = 2;
    
    [_infoContentYYLb removeFromSuperview];
    _infoContentYYLb = nil;
    [self initInfoContentYYlable];
    _infoContentYYLb.numberOfLines = 3;
    
    _contentLb.width = __SCREEN_SIZE.width - _contentLb.x - 76;
       _timeLb.text = dataDic[@"time"];
    _titleLb.text = dataDic[@"title"];
    if ([dataDic[@"content"] isKindOfClass:[NSString class]]) {
        _contentLb.text = dataDic[@"content"];
        
        _contentYYLb.text = dataDic[@"content"];
    }
    else if ([dataDic[@"content"] isKindOfClass:[BUImageRes class]])
    {
           NSMutableAttributedString *text = [NSMutableAttributedString new];
        UIImage *image = [UIImage imageContentWithFileName:@"news_attention@2x"];
//        image = [UIImage imageWithCGImage:image.CGImage scale:2 orientation:UIImageOrientationUp];
         UIFont *font = [UIFont systemFontOfSize:16];
        NSMutableAttributedString *attachText = [NSMutableAttributedString attachmentStringWithContent:image contentMode:UIViewContentModeCenter attachmentSize:image.size alignToFont:font alignment:YYTextVerticalAlignmentCenter];
        [text appendAttributedString:attachText];
        _contentYYLb.attributedText = text;
    }
    
    _contentYYLb.width = __SCREEN_SIZE.width - _contentYYLb.x - 78;
    

    _curImgRes.isValid = NO;
    id img = dataDic[@"img"];
    [_imgV imageWithContent:@"defaultHead1@2x"];
    if (img&&[img isKindOfClass:[BUImageRes class]]) {
        BUImageRes *imgRes = img;
        imgRes.isValid = YES;
        _curImgRes = imgRes;
        _imgV.backgroundColor = [UIColor blueColor];
        [imgRes displayRemoteImage:_imgV imageName:@"" thumb:YES];
    }
    if ([dataDic[@"hasImg"] boolValue]) {
        id img2 = dataDic[@"img2"];
        _img2V.hidden = NO;
        _infoContentLb.hidden = YES;
        _infoContentYYLb.hidden = YES;
        [_img2V imageWithContent:@"default@2x"];
        if (img2&&[img isKindOfClass:[BUImageRes class]]) {
            BUImageRes *imgRes = img2;
            imgRes.isValid = YES;
            _curImg2Res = imgRes;
            _img2V.backgroundColor = [UIColor blueColor];
            [imgRes displayRemoteImage:_img2V imageName:@"" thumb:YES];
        }
    }
    else
    {
       _img2V.hidden = YES;
        _infoContentYYLb.hidden = NO;
        _infoContentLb.text = dataDic[@"infoContent"];
        _infoContentYYLb.text = dataDic[@"infoContent"];
    }
    _infoContentYYLb.x = __SCREEN_SIZE.width - 68;
    _infoContentLb.hidden = YES;
    _contentLb.hidden = YES;
}

-(void)initContentYYlable
{
    _contentYYLb = [[YYLabel alloc] initWithFrame:CGRectMake(60, 31, 280, 46)];
    _contentYYLb.font = [UIFont systemFontOfSize:14];
    WBStatusComposeTextParser *parser = [WBStatusComposeTextParser new];
    parser.font = [UIFont systemFontOfSize:14];
    _contentYYLb.textParser = parser;
      _contentYYLb.textColor = kUIColorFromRGB(color_0x303030);
    WBTextLinePositionModifier *modifier = [WBTextLinePositionModifier new];
    modifier.font = [UIFont fontWithName:@"Heiti SC" size:14];
    //    modifier.paddingTop = 2;
    //    modifier.paddingBottom = 2;
    //    modifier.lineHeightMultiple = 1.5;
    _contentYYLb.linePositionModifier = modifier;
    _contentYYLb.textContainerInset = UIEdgeInsetsMake(0, 0, 0, 0);
//    _contentYYLb.width = __SCREEN_SIZE.width - 10 - _contentYYLb.x;
    [self.contentView addSubview:_contentYYLb];
}

-(void)initInfoContentYYlable
{
    _infoContentYYLb = [[YYLabel alloc] initWithFrame:CGRectMake(249, 16, 58, 64)];
    _infoContentYYLb.font = [UIFont systemFontOfSize:13];
    WBStatusComposeTextParser *parser = [WBStatusComposeTextParser new];
    parser.font = [UIFont systemFontOfSize:13];
    _infoContentYYLb.textParser = parser;
      _infoContentYYLb.textColor = kUIColorFromRGB(color_0x303030);
    WBTextLinePositionModifier *modifier = [WBTextLinePositionModifier new];
    modifier.font = [UIFont fontWithName:@"Heiti SC" size:13];
    //    modifier.paddingTop = 2;
    //    modifier.paddingBottom = 2;
    //    modifier.lineHeightMultiple = 1.5;
    _infoContentYYLb.linePositionModifier = modifier;
    _infoContentYYLb.textContainerInset = UIEdgeInsetsMake(0, 0, 0, 0);
//    _infoContentYYLb.width = __SCREEN_SIZE.width - 10 - _contentYYLb.x;
    [self.contentView addSubview:_infoContentYYLb];

}

@end
