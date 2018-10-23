//
//  HeadImgAndInfoTableViewCell.m
//  yihui
//
//  Created by air on 15/8/31.
//  Copyright (c) 2015年 ORANLLC_IOS1. All rights reserved.
//

#import "HeadImgAndInfoTableViewCell.h"
#import "BUImageRes.h"
@implementation HeadImgAndInfoTableViewCell
{
    IBOutlet UILabel *_personPositionLb;
    IBOutlet UIButton *_moreBtn;
  BUImageRes *_curImgRes;
    IBOutlet UIImageView *_markImgV;
    IBOutlet UILabel *_timeLb;
    IBOutlet UILabel *_personNameLb;
    IBOutlet UIImageView *_headImgV;
    NSInteger _objRow;
}
- (void)awakeFromNib {
    // Initialization code
    _markImgV.hidden = YES;
    _headImgV.layer.cornerRadius = _headImgV.height/2.0;
    _headImgV.layer.masksToBounds = YES;
    [_personNameLb addHeightConstraint:JYLayoutRelationGreaterThanOrEqual width:18];
    [_personNameLb addWidthConstraint:JYLayoutRelationGreaterThanOrEqual width:18];
    [_personNameLb addTopConstraint:14];
    [_personNameLb addLeftConstraint:62];
    [_personPositionLb addHeightConstraint:JYLayoutRelationGreaterThanOrEqual width:18];
     [_personPositionLb addWidthConstraint:JYLayoutRelationGreaterThanOrEqual width:18];
    [_personPositionLb addTopConstraint:14];
    [_personPositionLb toLeftOnConstraint:_personNameLb withEx:10];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setCellData:(NSDictionary *)dataDic
{
    _timeLb.text = dataDic[@"time"];
    _personNameLb.text = dataDic[@"name"];
    _personPositionLb.text = dataDic[@"position"];
    _markImgV.hidden = ![dataDic[@"isChecked"] boolValue];
    _moreBtn.hidden = ![dataDic[@"isHiddenMore"] boolValue];
    BUImageRes *img = dataDic[@"img"];
   _objRow = [dataDic[@"objRow"] integerValue];
    _curImgRes.isValid = NO;
    _curImgRes = img;
    [_curImgRes displayRemoteImage:_headImgV imageName:@"bg_logo_default" thumb:YES];
    
//    _headImgV.image = [UIImage imageNamed:@"bg_logo_default"];
//    if (img.isCached) {
//        _headImgV.image =  [UIImage imageWithContentsOfFile:img.cacheThumbFile];
//        //         self.height = [self heightOfCellWithImg:_imgV.image];
//    }
//    else {
//        [img download:self callback:@selector(getImgNotification:) extraInfo:nil];
//    }
    [super setCellData:dataDic];
}

- (IBAction)handleAction:(id)sender {
    if (self.handleAction) {
        self.handleAction(@{@"objRow":@(_objRow),@"sender":sender});
    }
}


//-(void)getImgNotification:(BSNotification *)noti
//{
//    if(noti.error.code ==0)
//    {
//        BUImageRes *res =(BUImageRes *) noti.target;
//        if (_curImgRes != res) {
//            return;
//        }
//        if (res.isCached) {
//            _headImgV.image =  [UIImage imageWithContentsOfFile:res.cacheThumbFile];
//            //             self.height = [self heightOfCellWithImg:_imgV.image];
//        }
//    }
//}
@end
