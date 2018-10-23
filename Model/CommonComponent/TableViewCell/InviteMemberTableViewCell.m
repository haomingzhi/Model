//
//  InviteMemberTableViewCell.m
//  yihui
//
//  Created by air on 15/9/14.
//  Copyright (c) 2015年 ORANLLC_IOS1. All rights reserved.
//

#import "InviteMemberTableViewCell.h"
#import "BUImageRes.h"
@implementation InviteMemberTableViewCell
{
    BUImageRes *_curImgRes;
    IBOutlet UILabel *_detailLb;
    IBOutlet UIButton *_btn;
    NSIndexPath *_indexPath;
    IBOutlet UILabel *_nameLb;
    IBOutlet UIImageView *_headImgV;
}

- (void)awakeFromNib {
    // Initialization code
    _headImgV.layer.cornerRadius = _headImgV.height/2.0;
    _headImgV.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)handleAction:(id)sender {
    _indexPath = [(UITableView *)self.superview.superview indexPathForCell:self];
    if (self.handleAction) {
        self.handleAction(@{@"obj":sender,@"indexPath":_indexPath});
    }
}


-(void)setCellData:(NSDictionary *)dataDic
{
    _nameLb.text = dataDic[@"title"];
    _detailLb.text = dataDic[@"detail"];
   _btn.selected = [dataDic[@"isChecked"] boolValue];
    BUImageRes *img = dataDic[@"img"];
    _curImgRes = img;
    if (img.isCached) {
        _headImgV.image =  [UIImage imageWithContentsOfFile:img.cacheThumbFile];
        //         self.height = [self heightOfCellWithImg:_imgV.image];
    }
    else {
        _headImgV.image = [UIImage imageNamed:@"bg_logo_default"];
        [img download:self callback:@selector(getImgNotification:) extraInfo:nil];
    }
    [super setCellData:dataDic];
}

-(void)getImgNotification:(BSNotification *)noti
{  ISTOLOGIN;
    if(noti.error.code ==0)
    {
      
        BUImageRes *res =(BUImageRes *) noti.target;
        if (_curImgRes != res) {
            return;
        }
        if (res.isCached) {
            _headImgV.image =  [UIImage imageWithContentsOfFile:res.cacheThumbFile];
//                         self.height = [self heightOfCellWithImg:_imgV.image];
        }
    }
}
@end
