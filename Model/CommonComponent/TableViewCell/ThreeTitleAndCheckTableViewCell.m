//
//  ThreeTitleAndCheckTableViewCell.m
//  compassionpark
//
//  Created by air on 2017/2/8.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import "ThreeTitleAndCheckTableViewCell.h"

@implementation ThreeTitleAndCheckTableViewCell
{
    IBOutlet UILabel *_titleALb;

    IBOutlet UILabel *_titleCLb;
    IBOutlet UILabel *_titleBLb;
    IBOutlet UIButton *_checkBtn;
    NSDictionary *_dataDic;
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
    _titleALb.text = dataDic[@"titleA"];
    _titleBLb.text = dataDic[@"titleB"];
    _titleCLb.text = dataDic[@"titleC"];
    [_checkBtn setImage:[UIImage imageContentWithFileName:dataDic[@"unCheckImg"]] forState:UIControlStateNormal];
    [_checkBtn setImage:[UIImage imageContentWithFileName:dataDic[@"checkImg"]] forState:UIControlStateSelected];
    _checkBtn.selected = [dataDic[@"isCheck"] boolValue];
    _dataDic =dataDic;
}

-(void)fitGiftMode
{

}

-(void)fitUserCardRechargeMode
{
    self.height = 54;
    _checkBtn.width = 15;
    _checkBtn.height = 15;
    _checkBtn.x = __SCREEN_SIZE.width - 30;
    _checkBtn.y = self.height/2.0 - _checkBtn.height/2.0;
    _titleALb.font = [UIFont systemFontOfSize:15];
    _titleALb.textColor = kUIColorFromRGB(color_1);
    _titleALb.width = 160;
    _titleALb.height = 17;
    [_titleALb sizeToFit];
    _titleALb.x = 15;
    _titleALb.y = 7;
    
    _titleBLb.font = [UIFont systemFontOfSize:15];
    _titleBLb.textColor = kUIColorFromRGB(color_mainTheme);
    _titleBLb.width = 160;
    _titleBLb.height = 17;
    [_titleBLb sizeToFit];
    _titleBLb.x = 15;
    _titleBLb.y = 7 + _titleALb.y + _titleALb.height;
    _titleBLb.attributedText = [_titleBLb richText:@"卡号" color:kUIColorFromRGB(color_1)];
    
    _titleCLb.font = [UIFont systemFontOfSize:15];
    _titleCLb.textColor = kUIColorFromRGB(color_mainTheme);
    _titleCLb.width = 160;
    _titleCLb.height = 17;
    [_titleCLb sizeToFit];
    _titleCLb.x = __SCREEN_SIZE.width - 55 - _titleCLb.width;
    _titleCLb.y = 7 + _titleALb.y + _titleALb.height;
  _titleCLb.attributedText = [_titleCLb richText:@"密码" color:kUIColorFromRGB(color_1)];
    self.contentView.backgroundColor = kUIColorFromRGB(color_4);
        self.backgroundColor = kUIColorFromRGB(color_4);
}

-(void)fitOrderInfoMode
{
    self.height = 82;
    _checkBtn.hidden = YES;
    _titleALb.font = [UIFont systemFontOfSize:15];
    _titleALb.textColor = kUIColorFromRGB(color_1);
    _titleALb.width = __SCREEN_SIZE.width - 30;
    _titleALb.height = 40;
    _titleALb.numberOfLines = 0;
    [_titleALb sizeToFit];
    _titleALb.x = 15;
    _titleALb.y = 7;
    
    _titleBLb.font = [UIFont systemFontOfSize:15];
    _titleBLb.textColor = kUIColorFromRGB(color_1);
    _titleBLb.width = 160;
    _titleBLb.height = 17;
    [_titleBLb sizeToFit];
    _titleBLb.x = 15;
    _titleBLb.y = 7 + _titleALb.y + _titleALb.height;
    
    
    _titleCLb.font = [UIFont systemFontOfSize:15];
    _titleCLb.textColor = kUIColorFromRGB(color_mainTheme);
    _titleCLb.width = 160;
    _titleCLb.height = 17;
    [_titleCLb sizeToFit];
    _titleCLb.x = __SCREEN_SIZE.width - 15 - _titleCLb.width;
    _titleCLb.y = 7 + _titleALb.y + _titleALb.height;
    _titleCLb.textAlignment = NSTextAlignmentRight;
    
    UILabel *titleD = [self.contentView viewWithTag:1119];
    if (_dataDic[@"titleD"]) {
        if (!titleD) {
            titleD = [[UILabel alloc]init];
            titleD.text = _dataDic[@"titleD"];
            titleD.font = [UIFont systemFontOfSize:14];
            titleD.textColor = kUIColorFromRGB(color_8);
            titleD.tag = 1119;
            [titleD sizeToFit];
            titleD.y = _titleCLb.y;
            titleD.x = _titleCLb.x - 5 -titleD.width;
            [self.contentView addSubview:titleD];
        }
        NSString *str = _dataDic[@"titleD"];
//        NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
//        NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:str attributes:attribtDic];
//        NSString *market = [NSString stringWithFormat:@"¥%@",@"500"];
//        NSMutableAttributedString *attributeMarket = [[NSMutableAttributedString alloc] initWithString:str];
//        [attributeMarket setAttributes:@{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]} range:NSMakeRange(0,str.length)];
        NSMutableAttributedString *attributeMarket = [[NSMutableAttributedString alloc] initWithString:str];
        [attributeMarket setAttributes:@{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle], NSBaselineOffsetAttributeName : @(NSUnderlineStyleSingle)} range:NSMakeRange(0,str.length)];

//        _marketLabel.attributedText = attributeMarket;
        titleD.attributedText = attributeMarket;
        titleD.hidden = NO;
    }else{
        titleD.hidden = YES;
    }
    
    
    self.contentView.backgroundColor = kUIColorFromRGB(color_4);
    self.backgroundColor = kUIColorFromRGB(color_4);
}

@end
