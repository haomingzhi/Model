//
//  ContactPersonTableViewCell.m
//  yihui
//
//  Created by air on 15/8/28.
//  Copyright (c) 2015年 ORANLLC_IOS1. All rights reserved.
//

#import "ContactPersonTableViewCell.h"
#import "BUImageRes.h"
@implementation ContactPersonTableViewCell
{
    BUImageRes *_curImgRes;
    IBOutlet UIButton *_btn;
    IBOutlet UIImageView *_headImgV;
    UIView *_deleteView;
    UIButton *_deleteBtn;
    IBOutlet UILabel *_timeLb;
    IBOutlet UILabel *_userNameLb;
    IBOutlet UIImageView *_markImgV;
}

- (void)awakeFromNib {
    // Initialization code
    _headImgV.layer.cornerRadius = _headImgV.height/2.0;
    _headImgV.layer.masksToBounds = YES;
    _markImgV.layer.cornerRadius = _markImgV.height/2.0;
    _markImgV.hidden = YES;
    _deleteView = [[UIView alloc] initWithFrame:CGRectMake(__SCREEN_SIZE.width, 0, 200, self.height)];
    _deleteView.backgroundColor = [UIColor whiteColor];
    _deleteBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 81, self.height - 1)];
    _deleteBtn.backgroundColor = kUIColorFromRGB(color_main_bottom_default);//[UIColor lightGrayColor];
    _deleteBtn.titleLabel.font = [UIFont systemFontOfSize:16];
//    [_deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
    [_deleteBtn setImage:[UIImage imageNamed:@"icon_the-trash"] forState:UIControlStateNormal];
    [_deleteView addSubview:_deleteBtn];
    [self.contentView addSubview:_deleteView];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setCellData:(NSDictionary *)dataDic
{
    _markImgV.hidden = ![dataDic[@"isChecked"] boolValue];
    _timeLb.text = dataDic[@"time"];
    _btn.hidden = [dataDic[@"isHiddenBtn"] boolValue];
    _userNameLb.text = dataDic[@"userName"];

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
   
//    _headImgV.image = 
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
        self.handleAction(sender);
    }
}

//-(id)heightOfCell
//{
//    return @(self.height);
//}

@end
