//
//  SelectBtnCollectionViewCell.m
//  yihui
//
//  Created by air on 15/9/16.
//  Copyright (c) 2015年 ORANLLC_IOS1. All rights reserved.
//

#import "SelectBtnCollectionViewCell.h"

@implementation SelectBtnCollectionViewCell
{
    IBOutlet UILabel *_titleLb;
    NSInteger _row;
     NSDictionary *_dataDic;
}
- (void)awakeFromNib {
    // Initialization code
//    _titleLb.borderColor = kUIColorFromRGB(color_0xcccccc);
    _titleLb.borderWidth = 0.5;
}

-(void)setCellData:(NSDictionary *)dataDic
{
     _dataDic = dataDic;
//    self.width = (__SCREEN_SIZE.width - 30 - 14)/3.0;
    _titleLb.text = dataDic[@"title"];
//    _titleLb.width = self.width - 2;
//    if (dataDic[@"isChecked"]) {
//        if ([dataDic[@"isChecked"] boolValue]) {
//            _titleLb.borderColor = kUIColorFromRGB(color_3);
//            //        _titleLb.textColor = kUIColorFromRGB(color_3);
//        }
//        else
//        {
//            _titleLb.borderColor = kUIColorFromRGB(color_16);
//            //        _titleLb.textColor = kUIColorFromRGB(color_5);
//        }
//    }
//    if (dataDic[@"isFull"]) {
//        if ([dataDic[@"isFull"] integerValue] == 1) {
//            self.backgroundColor = kUIColorFromRGB(color_9);
//            self.userInteractionEnabled = NO;
//        }
//        else
//        {
//            self.userInteractionEnabled = YES;
//            self.backgroundColor = kUIColorFromRGB(color_4);
//        }
//    }
    
    
    
    
}

-(void)fitRowShowMode{
     _titleLb.width = (__SCREEN_SIZE.width-78 - 30 - 14)/3.0;
     _titleLb.font = [UIFont systemFontOfSize:14];
     _titleLb.y = 15;
     _titleLb.height = 25;
    _titleLb.backgroundColor = kUIColorFromRGB(color_0xfdf2ea);
     _titleLb.textColor = kUIColorFromRGB(color_3);
     _titleLb.layer.cornerRadius = 6.0;
     _titleLb.layer.masksToBounds = YES;
     _titleLb.layer.borderColor = kUIColorFromRGB(color_0xec7e3b).CGColor;
     _titleLb.layer.borderWidth = 0.5;
}

-(void)fitRowShowModeA{
     _titleLb.width = (__SCREEN_SIZE.width-78 - 30 - 14)/3.0;
     _titleLb.font = [UIFont systemFontOfSize:14];
     _titleLb.y = 15;
     _titleLb.height = 25;
     _titleLb.backgroundColor = kUIColorFromRGB(color_2);
     _titleLb.textColor = kUIColorFromRGB(color_3);
     _titleLb.layer.cornerRadius = 6.0;
     _titleLb.layer.masksToBounds = YES;
     _titleLb.layer.borderColor = kUIColorFromRGB(color_0xec7e3b).CGColor;
     _titleLb.layer.borderWidth = 0.5;
}

-(void)fitNormalMode{

     _titleLb.width = (__SCREEN_SIZE.width-78 - 30 - 14)/3.0;
     _titleLb.font = [UIFont systemFontOfSize:14];
     _titleLb.y = 15;
     _titleLb.height = 25;
     _titleLb.backgroundColor = kUIColorFromRGB(color_4);
     _titleLb.textColor = kUIColorFromRGB(color_7);
     _titleLb.layer.cornerRadius = 6.0;
     _titleLb.layer.masksToBounds = YES;
     _titleLb.layer.borderColor = kUIColorFromRGB(color_lineColor).CGColor;
     _titleLb.layer.borderWidth = 0.5;
}

-(void)fitDateMode{
    self.width = __SCREEN_SIZE.width/7.0;
    _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleLeftMargin;
    _titleLb.width = __SCREEN_SIZE.width/7.0;
    _titleLb.font = [UIFont systemFontOfSize:15];
    _titleLb.textColor = kUIColorFromRGB(color_1);
//    _titleLb.borderColor = kUIColorFromRGB(color_16);
    _titleLb.backgroundColor = [UIColor clearColor];
}

-(void)fitCellMode{
     self.width = (__SCREEN_SIZE.width - 30 - 14)/3.0;
     _titleLb.text = _dataDic[@"title"];
     _titleLb.font = [UIFont systemFontOfSize:15];
     _titleLb.width = self.width - 2;
     if ([_dataDic[@"isChecked"] boolValue]) {
          _titleLb.borderColor = kUIColorFromRGB(color_3);
          _titleLb.textColor = kUIColorFromRGB(color_3);
     }
     else
     {
          _titleLb.borderColor = kUIColorFromRGB(color_lineColor);
          _titleLb.textColor = kUIColorFromRGB(color_6);
     }
}


-(void)fitNoDateMode{
    self.width = __SCREEN_SIZE.width;
    _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleLeftMargin;
    _titleLb.width = __SCREEN_SIZE.width;
    _titleLb.text = @"无考试日";
    _titleLb.font = [UIFont systemFontOfSize:15];
    _titleLb.textColor = kUIColorFromRGB(color_8);
    _titleLb.backgroundColor = [UIColor clearColor];
    _titleLb.layer.borderColor = [UIColor clearColor].CGColor;
}

-(void)fitTimeMode{
    self.width = __SCREEN_SIZE.width/4.0;
    _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleLeftMargin;
    _titleLb.width = __SCREEN_SIZE.width;
    _titleLb.layer.cornerRadius = 6.0;
    _titleLb.layer.masksToBounds = YES;
}


-(void)fitTypeMode{
     self.width = 70;
     _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleLeftMargin;
     _titleLb.width = self.width;
     _titleLb.font = [UIFont systemFontOfSize:15];
     _titleLb.textColor = kUIColorFromRGB(color_7);
     //    _titleLb.borderColor = kUIColorFromRGB(color_16);
     _titleLb.backgroundColor = kUIColorFromRGB(color_8);
     _titleLb.layer.cornerRadius = 6.0;
     _titleLb.layer.masksToBounds = YES;
     _titleLb.layer.borderColor = [UIColor redColor].CGColor;
     self.contentView.backgroundColor = [UIColor whiteColor];
}


-(void)fitTypeModeA{
     self.width = 70;
     _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleLeftMargin;
     _titleLb.width = self.width;
     _titleLb.font = [UIFont systemFontOfSize:15];
     _titleLb.textColor = kUIColorFromRGB(color_2);
     //    _titleLb.borderColor = kUIColorFromRGB(color_16);
     _titleLb.backgroundColor = kUIColorFromRGB(color_3);
     _titleLb.layer.cornerRadius = 6.0;
     _titleLb.layer.masksToBounds = YES;
     
}
@end
