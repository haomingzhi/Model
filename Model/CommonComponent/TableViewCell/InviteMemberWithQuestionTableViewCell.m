//
//  InviteMemberWithQuestionTableViewCell.m
//  yihui
//
//  Created by air on 15/9/14.
//  Copyright (c) 2015年 ORANLLC_IOS1. All rights reserved.
//

#import "InviteMemberWithQuestionTableViewCell.h"
#import "BUImageRes.h"
@implementation InviteMemberWithQuestionTableViewCell
{
        BUImageRes *_curImgRes;
    IBOutlet UIImageView *_markImgV;
    IBOutlet UIImageView *_headImgV;
    IBOutlet UILabel *_nameLb;
    NSIndexPath *_indexPath;
    IBOutlet UILabel *_answer2Lb;
    IBOutlet UILabel *_answerLb;
    IBOutlet UILabel *_questionLb;
    IBOutlet UILabel *_question2Lb;
    IBOutlet UILabel *_detailLb;
    IBOutlet UIButton *_btn;
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

-(void)setCellData:(NSDictionary *)dataDic
{
    _btn.selected = [dataDic[@"isChecked"] boolValue];
    _nameLb.text = dataDic[@"title"];
    _detailLb.text = dataDic[@"detail"];
    _answerLb.text = dataDic[@"answer1"];
    _answer2Lb.text = dataDic[@"answer2"];
    _question2Lb.text = dataDic[@"ask2"];
    _questionLb.text = dataDic[@"ask1"];
    
    if ([_question2Lb.text isEqualToString:@""]) {
        self.height = 76;
    }
    BUImageRes *img = dataDic[@"img"];
    _curImgRes = img;
    _headImgV.image = [UIImage imageNamed:@"bg_logo_default"];
    if (img.isCached) {
        _headImgV.image =  [UIImage imageWithContentsOfFile:img.cacheFile];
        //         self.height = [self heightOfCellWithImg:_imgV.image];
    }
    else {
        [img download:self callback:@selector(getImgNotification:) extraInfo:nil];
    }
    [super setCellData:dataDic];

}

-(void)getImgNotification:(BSNotification *)noti
{
    if(noti.error.code ==0)
    {ISTOLOGIN;
        BUImageRes *res =(BUImageRes *) noti.target;
        if (_curImgRes != res) {
            return;
        }
        if (res.isCached) {
            _headImgV.image =  [UIImage imageWithContentsOfFile:res.cacheFile];
            //             self.height = [self heightOfCellWithImg:_imgV.image];
        }
    }
}
- (IBAction)handleAction:(id)sender {
    _indexPath = [(UITableView *)self.superview.superview indexPathForCell:self];
    if (self.handleAction) {
self.handleAction(@{@"obj":sender,@"indexPath":_indexPath});
    }
}

@end
