//
//  ImgTitleAndImgTableViewCell.m
//  lovecommunity
//
//  Created by air on 16/6/22.
//  Copyright © 2016年 ORANLLC_IOS1. All rights reserved.
//

#import "ImgTitleAndImgTableViewCell.h"

@implementation ImgTitleAndImgTableViewCell
{

    IBOutlet UIView *_containerView;
    IBOutlet UILabel *_titleLb;
    IBOutlet UIButton *_imgBtn;
    IBOutlet UIImageView *_imgV;
    NSString *_phone;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)btnHandle:(id)sender {
    if (self.handleAction) {
        self.handleAction(@{@"phone":_phone});
    }
}

-(void)setCellData:(NSDictionary *)dataDic
{
    _titleLb.text = dataDic[@"title"];
    _phone = dataDic[@"phone"];
    if (dataDic[@"textColor"]) {
        _titleLb.textColor = dataDic[@"textColor"];
    }
    if (dataDic[@"textFont"]) {
        _titleLb.font = dataDic[@"textFont"];
    }
    if (dataDic[@"backgroundColor"]) {
        self.backgroundColor = dataDic[@"backgroundColor"];
    }
    if (dataDic[@"img"]) {
        _imgV.image = [UIImage imageContentWithFileName:dataDic[@"img"]];
    }
    if (dataDic[@"btnImg"]) {
        [_imgBtn setImage:[UIImage imageContentWithFileName:dataDic[@"btnImg"]] forState:UIControlStateNormal];
    }
}



-(void)mutableLineCountMode
{
    _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _titleLb.numberOfLines = 0;
    CGSize size = [_titleLb.text size:_titleLb.font constrainedToSize:CGSizeMake(__SCREEN_SIZE.width - 90, MAXFLOAT)];
    _titleLb.width = size.width;
    _titleLb.height = size.height;
    if (44 > _titleLb.height + 14) {
        return;
    }
     _titleLb.y = 6;
    self.height =  _titleLb.height + 14;
    _imgV.y = self.height/2.0 - _imgV.height/2.0;
    _imgBtn.y = self.height/2.0 - _imgBtn.height/2.0;
}

-(void)fitMode
{
    self.height = 56;
    _containerView.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _containerView.y = 10;
    _containerView.x = 15;
    _containerView.height = 35;
    _containerView.width = __SCREEN_SIZE.width - 30;
    _containerView.layer.cornerRadius = 6;
    _containerView.layer.borderColor = kUIColorFromRGB(color_lineColor).CGColor;
    _containerView.layer.borderWidth = 1;
    _containerView.layer.masksToBounds = YES;
    
    _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _titleLb.width = 160;
    _titleLb.height = 21;
    _titleLb.y = 6;
    _imgV.width = 18;
    _imgV.height = 18;
    _imgV.y = _containerView.height/2.0 - _imgV.height/2.0;
    _imgBtn.enabled = NO;
    _imgBtn.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _imgBtn.y = _containerView.height/2.0 - _imgBtn.height/2.0;
    _imgBtn.x = _containerView.width - 10 - 20;
}

-(void)fitSelledSeverMode
{
     self.height = 45;
     _containerView.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _containerView.y = 0;
     _containerView.x = 0;
     _containerView.height = 45;
     _containerView.width = __SCREEN_SIZE.width;
//     _containerView.layer.cornerRadius = 6;
//     _containerView.layer.borderColor = kUIColorFromRGB(color_lineColor).CGColor;
//     _containerView.layer.borderWidth = 1;
//     _containerView.layer.masksToBounds = YES;
     
     _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
 
     _imgV.width = 15;
     _imgV.height = 15;
     _imgV.y = 15;
     _imgV.x = 15;
     
     _titleLb.width = 200;
     _titleLb.height = 13;
     _titleLb.y = 17;
     _titleLb.x = _imgV.x + _imgV.width + 15;
     _titleLb.font = [UIFont systemFontOfSize:13];
     _titleLb.textColor = kUIColorFromRGB(color_0xb0b0b0);
     
     _imgBtn.userInteractionEnabled = NO;
     _imgBtn.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _imgBtn.width = 10;
     _imgBtn.height = 18;
     _imgBtn.y = _containerView.height/2.0 - _imgBtn.height/2.0;
     _imgBtn.x = _containerView.width - 15 -  _imgBtn.width;
}
@end
