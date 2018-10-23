//
//  ThreeTitleDetailAndImgTableViewCell.m
//  taihe
//
//  Created by air on 2016/11/14.
//  Copyright © 2016年 ORANLLC_IOS1. All rights reserved.
//

#import "ThreeTitleDetailAndImgTableViewCell.h"

@implementation ThreeTitleDetailAndImgTableViewCell
{
    IBOutlet UILabel *_titleLbA;

    IBOutlet UILabel *_detailLbD;
    IBOutlet UILabel *_titleLbD;
    IBOutlet UIImageView *_arrowImgV;
    IBOutlet UIImageView *_imgV;
    IBOutlet UILabel *_titleLbB;
    IBOutlet UILabel *_detailLbA;
    IBOutlet UILabel *_detailLbB;
    IBOutlet UILabel *_titleLbC;
    IBOutlet UILabel *_detailLbC;
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
    _titleLbA.text = dataDic[@"titleA"];
     _titleLbB.text = dataDic[@"titleB"];
     _titleLbC.text = dataDic[@"titleC"];
    _titleLbD.text = dataDic[@"titleD"];
     _detailLbA.text = dataDic[@"detailA"];
     _detailLbB.text = dataDic[@"detailB"];
    _detailLbC.text = dataDic[@"detailC"];
    _detailLbD.text = dataDic[@"detailD"];
    _imgV.image = [UIImage imageContentWithFileName:dataDic[@"img"]];
}

-(void)fitCerMode
{
    _arrowImgV.x = __SCREEN_SIZE.width - 12 - _arrowImgV.width;
    
    _imgV.x = _arrowImgV.x - 6 - _imgV.width;
    _detailLbA.x = _imgV.x - 14 - _detailLbA.width;
    _detailLbB.x = _detailLbA.x;
    _detailLbC.x = _detailLbA.x;
    _detailLbD.x = _detailLbA.x;
    _titleLbA.textColor = kUIColorFromRGB(color_6);
    _titleLbB.textColor = kUIColorFromRGB(color_6);
    _titleLbC.textColor = kUIColorFromRGB(color_6);
     _titleLbD.textColor = kUIColorFromRGB(color_6);
    
    _detailLbA.textColor = kUIColorFromRGB(color_7);
    _detailLbB.textColor = kUIColorFromRGB(color_7);
    _detailLbC.textColor = kUIColorFromRGB(color_7);
     _detailLbD.textColor = kUIColorFromRGB(color_7);
}

-(void)fitChoseUnitMode{
    _detailLbA.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _detailLbB.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _detailLbC.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _detailLbD.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _arrowImgV.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    
    _titleLbA.textColor = kUIColorFromRGB(color_6);
    _titleLbB.textColor = kUIColorFromRGB(color_6);
    _titleLbC.textColor = kUIColorFromRGB(color_6);
    _titleLbD.textColor = kUIColorFromRGB(color_6);
    
    _detailLbA.textColor = kUIColorFromRGB(color_7);
    _detailLbB.textColor = kUIColorFromRGB(color_7);
    _detailLbC.textColor = kUIColorFromRGB(color_7);
    _detailLbD.textColor = kUIColorFromRGB(color_7);
    
    _arrowImgV.x = __SCREEN_SIZE.width - 12 - _arrowImgV.width;
    
     _detailLbA.width = 200;
    _detailLbB.width = 200;
    _detailLbC.width = 200;
    _detailLbD.width = 200;
    _detailLbA.x = _arrowImgV.x - 15 - _detailLbA.width;
    _detailLbB.x = _detailLbA.x;
    _detailLbC.x = _detailLbA.x;
    _detailLbD.x = _detailLbA.x;
    
   
    
    _imgV.hidden = YES;
    
    self.height = 130;
}

-(NSDictionary *)getDic{
    return @{@"name":_detailLbA.text,@"house":_detailLbB.text,@"floor":_detailLbC.text,@"unit":_detailLbD.text,};
}


@end
