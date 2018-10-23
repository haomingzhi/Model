//
//  FindActivityTableViewCell.m
//  yihui
//
//  Created by air on 15/9/15.
//  Copyright (c) 2015年 ORANLLC_IOS1. All rights reserved.
//

#import "FindActivityTableViewCell.h"
#import "BUImageRes.h"
@implementation FindActivityTableViewCell
{
    IBOutlet UIButton *_btn;
  BUImageRes *_curImgRes;
    IBOutlet UILabel *_detail4Lb;
    IBOutlet UILabel *_detail3Lb;
    IBOutlet UILabel *_detail2Lb;
    IBOutlet UILabel *_detail1Lb;
    IBOutlet UIImageView *_logoImgV;
    IBOutlet UIImageView *_statusImgV;
    IBOutlet UILabel *_titleLb;
    id userData;
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
    userData = dataDic[@"userData"];
    _titleLb.text = dataDic[@"title"];
    _detail1Lb.text = dataDic[@"detail1"];
    _detail2Lb.text = dataDic[@"detail2"];
    _detail3Lb.text = dataDic[@"detail3"];
    _detail4Lb.text = dataDic[@"detail4"];
    _statusImgV.image = [UIImage imageNamed:dataDic[@"statusImg"]];
    _btn.selected = [dataDic[@"isChecked"] boolValue];
    BUImageRes *img = dataDic[@"img"];
    _curImgRes = img;
    _logoImgV.image = [UIImage imageNamed:@"bg_logo_default"];
    if (img.isCached) {
        _logoImgV.image =  [UIImage imageWithContentsOfFile:img.cacheThumbFile];
        //         self.height = [self heightOfCellWithImg:_imgV.image];
    }
    else {
        [img download:self callback:@selector(getImgNotification:) extraInfo:nil];
    }

    [super setCellData:dataDic];
}
-(void)getImgNotification:(BSNotification *)noti
{
    ISTOLOGIN;
    if(noti.error.code ==0)
    {
        BUImageRes *res =(BUImageRes *) noti.target;
        if (_curImgRes != res) {
            return;
        }
        if (res.isCached) {
            _logoImgV.image =  [UIImage imageWithContentsOfFile:res.cacheThumbFile];
            //             self.height = [self heightOfCellWithImg:_imgV.image];
        }
    }
}
- (IBAction)handleAction:(id)sender {
    //_btn.selected = !_btn.selected;
    if (self.handleAction) {
        self.handleAction(userData);
    }
}

@end
