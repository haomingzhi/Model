//
//  ComentSoOnInfoTableViewCell.m
//  yihui
//
//  Created by air on 15/8/28.
//  Copyright (c) 2015年 ORANLLC_IOS1. All rights reserved.
//

#import "ComentSoOnInfoTableViewCell.h"

@implementation ComentSoOnInfoTableViewCell
{

    IBOutlet UIButton *_btn1;
    IBOutlet UIImageView *_imgV1;
    IBOutlet UILabel *_textLb1;
    
    IBOutlet UILabel *_vLineLb1;
    
    IBOutlet UIButton *_btn2;
    IBOutlet UIImageView *_imgV2;
    IBOutlet UILabel *_textLb2;
    
    IBOutlet UILabel *_vLineLb2;
    
    IBOutlet UIButton *_btn3;
    IBOutlet UIImageView *_imgV3;
    IBOutlet UILabel *_textLb3;
    
    IBOutlet UILabel *_vLineLb3;
    IBOutlet UIButton *_btn4;
    IBOutlet UIImageView *_imgV4;
    IBOutlet UILabel *_textLb4;
    
    
}


- (void)awakeFromNib {
    // Initialization code
//    _btn1.borderWidth = 1;
//    _btn3.borderWidth = 1;
    [self layoutBtn:_btn1 withImgV:_imgV1 withTextLb:_textLb1];
    [self layoutBtn:_btn2 withImgV:_imgV2 withTextLb:_textLb2];
      [self layoutBtn:_btn3 withImgV:_imgV3 withTextLb:_textLb3];
     [self layoutBtn:_btn4 withImgV:_imgV4 withTextLb:_textLb4];
    _vLineLb1.width = 0.5;
      _vLineLb1.backgroundColor = kUIColorFromRGB(color_unSelColor);
      _vLineLb2.width = 0.5;
    _vLineLb2.backgroundColor = kUIColorFromRGB(color_unSelColor);
      _vLineLb3.width = 0.5;
    _vLineLb3.backgroundColor = kUIColorFromRGB(color_unSelColor);
}

-(void)layoutBtn:(UIButton *)btn withImgV:(UIImageView *)imgV withTextLb:(UILabel *)textLb
{
    [btn addSubview:imgV];
    [btn addSubview:textLb];
    
    [imgV addWidthConstraint:JYLayoutRelationEqual width:14];
    [imgV addHeightConstraint:JYLayoutRelationEqual width:14];
//    [imgV alignViewCenter];
    [imgV addVerticalConstraint];
    [imgV toRightOnConstraint:textLb withEx:-2];
//    [imgV alignViewHCenter:0];
    [textLb addWidthConstraint:JYLayoutRelationGreaterThanOrEqual width:14];
    [textLb addHeightConstraint:JYLayoutRelationGreaterThanOrEqual width:14];
    [textLb addVerticalConstraint];
    [textLb addHorizontalConstraint:10];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setCellData:(NSDictionary *)dataDic
{
    
    _textLb1.text = dataDic[@"one"];//[NSString stringWithFormat:@"%ld",[dataDic[@"one"] integerValue]];
   _imgV1.image = [UIImage imageNamed:[dataDic[@"oneSelect"] boolValue]?@"icon_zang_sel":@"icon_zang_nor"];
    _textLb2.text = dataDic[@"two"];//[NSString stringWithFormat:@"%ld",[dataDic[@"two"] integerValue]];
    _imgV2.image = [UIImage imageNamed: [dataDic[@"twoSelect"] boolValue]?@"icon_dao_sel":@"icon_dao_nor"];;
    _textLb3.text = dataDic[@"three"];//[NSString stringWithFormat:@"%ld",[dataDic[@"three"] integerValue]];
   _imgV3.image = [UIImage imageNamed: [dataDic[@"threeSelect"] boolValue]?@"icon_shoucang_sel":@"icon_shoucang_nor"];
    _textLb4.text = dataDic[@"four"];//[NSString stringWithFormat:@"%ld",[dataDic[@"four"] integerValue]];
    _imgV4.image = [UIImage imageNamed:@"icon_pinglun_nor"];
    [super setCellData:dataDic];
}
- (IBAction)handleAction:(UIButton *)btn {
    if (self.handleAction) {
        self.handleAction(btn);
    }
}



@end
