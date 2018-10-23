//
//  FindPersonTableViewCell.m
//  yihui
//
//  Created by air on 15/9/14.
//  Copyright (c) 2015年 ORANLLC_IOS1. All rights reserved.
//

#import "FindPersonTableViewCell.h"
#import "BUImageRes.h"
@implementation FindPersonTableViewCell
{
    IBOutlet UIImageView *_btnMarkImgV;
    IBOutlet UIImageView *_headImgV;
    IBOutlet UIButton *_btn;
    BUImageRes *_curImgRes;
    IBOutlet UILabel *_statusLb;
    IBOutlet UILabel *_detailLb;
    IBOutlet UILabel *_titleLb;
    IBOutlet UIImageView *_markImgV;
    NSIndexPath *_indexPath;
    id userData;
}
- (void)awakeFromNib {
    // Initialization code
    _headImgV.layer.cornerRadius = _headImgV.height/2.0;
    _headImgV.layer.masksToBounds = YES;
    _btn.backgroundColor = kUIColorFromRGB(color_mainTheme);
    _btnMarkImgV.x = 8;
    _btnMarkImgV.y = 8;
    _btnMarkImgV.image = [UIImage imageNamed:@"icon_invite"];
    [_btn addSubview:_btnMarkImgV];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setCellData:(NSDictionary *)dataDic
{
    _btn.hidden = NO;
    _titleLb.text = dataDic[@"title"];
    _detailLb.text = dataDic[@"detail"];
    _markImgV.hidden = ![dataDic[@"isChecked"] boolValue];
    if (dataDic[@"indexPath"]) {
        _indexPath = dataDic[@"indexPath"];
    }
    if([dataDic[@"hiddenbtnAndStatusLb"]boolValue])
    {
        _statusLb.hidden = YES;
        _btn.hidden = YES;
    }
    else
    {
        _statusLb.hidden = [dataDic[@"status"] boolValue];
        _statusLb.text = dataDic[@"statusDescript"];
        if (![_statusLb.text isEqualToString:@"邀请"]) {
            _btnMarkImgV.hidden = YES;
            _btn.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
        }
        else
        {
            _btnMarkImgV.hidden = NO;
            _btn.contentEdgeInsets = UIEdgeInsetsMake(0, 16, 0, 0);
        }
        [_btn setTitle:dataDic[@"statusDescript"] forState:UIControlStateNormal];
        if (!_statusLb.hidden) {
            _btn.hidden = YES;
        }
    }
    
    userData = dataDic[@"userData"];
    BUImageRes *img = dataDic[@"img"];
    _curImgRes = img;
    _headImgV.image = [UIImage imageNamed:@"bg_logo_default"];
    if (img.isCached) {
        _headImgV.image =  [UIImage imageWithContentsOfFile:img.cacheThumbFile];
        //         self.height = [self heightOfCellWithImg:_imgV.image];
    }
    else {
        [img download:self callback:@selector(getImgNotification:) extraInfo:nil];
    }
    [super setCellData:dataDic];
//    _headImgV.image
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
            _headImgV.image =  [UIImage imageWithContentsOfFile:res.cacheThumbFile];
            //             self.height = [self heightOfCellWithImg:_imgV.image];
        }
    }
}
- (IBAction)handleAction:(id)sender {
    if (self.handleAction) {
        self.handleAction(userData);
    }
}

@end
