//
//  CommentHeadInfoTableViewCell.m
//  yihui
//
//  Created by wujiayuan on 15/9/23.
//  Copyright (c) 2015年 ORANLLC_IOS1. All rights reserved.
//

#import "CommentHeadInfoTableViewCell.h"
#import "BUImageRes.h"
@implementation CommentHeadInfoTableViewCell
{
    BUImageRes *_curImgRes;
    IBOutlet UIImageView *_headImgV;
    IBOutlet UILabel *_positionLb;
    NSInteger _objRow;
    IBOutlet UILabel *_timeLb;
    IBOutlet UIButton *_btn;
    IBOutlet UIImageView *_statusImgV;
    IBOutlet UILabel *_titleLb;
     UILongPressGestureRecognizer *_lPg;
}
- (void)awakeFromNib {
    // Initialization code
    _statusImgV.hidden = YES;
    _headImgV.layer.cornerRadius = _headImgV.height/2.0;
    _headImgV.layer.masksToBounds = YES;
}
-(void)longpressAction:(UILongPressGestureRecognizer *)lpg
{
    if (self.handleAction) {
        if(lpg.state == UIGestureRecognizerStateBegan)
        self.handleAction(lpg);
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setCellData:(NSDictionary *)dataDic
{
    if (!_lPg) {
        _lPg = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longpressAction:)];
        [self.contentView addGestureRecognizer:_lPg];
        
    }

    _statusImgV.hidden = ![dataDic[@"isChecked"] boolValue];
    _objRow = [dataDic[@"objRow"] integerValue];
    _titleLb.text = dataDic[@"name"];
    _positionLb.text = dataDic[@"position"];
    _timeLb.text = dataDic[@"time"];
    _btn.hidden = ![dataDic[@"hasCall"] boolValue];
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
}
- (IBAction)handleAction:(id)sender {
//    if (self.handleAction) {
//        self.handleAction(@(_objRow));
//    }
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
@end
