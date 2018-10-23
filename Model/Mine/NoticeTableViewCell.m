//
//  NoticeTableViewCell.m
//  ulife
//
//  Created by sunmax on 15/12/15.
//  Copyright © 2015年 ORANLLC_IOS1. All rights reserved.
//

#import "NoticeTableViewCell.h"

@implementation NoticeTableViewCell
{
    __weak IBOutlet UIButton *editBtn;//编辑按钮
    __weak IBOutlet UILabel *redDor;
    UIView *_deleteView;
    UIButton *_deleteBtn;
}

- (void)awakeFromNib {
    [redDor corner:kUIColorFromRGB(color_red) radius:4 borderWidth:1];
    _pitchOnCount =0;
//    [self addDeleteView];
    // Initialization code
}
#pragma mark --- DeleteView
-(void)addDeleteView
{
    _deleteView = [[UIView alloc] initWithFrame:CGRectMake(__SCREEN_SIZE.width, 0, 200, 78 )];
    _deleteView.backgroundColor = [UIColor whiteColor];
    _deleteBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 78)];
    //    _deleteBtn.backgroundColor = kUIColorFromRGB(mainColor);//[UIColor lightGrayColor];
    _deleteBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    //    [_deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
    [_deleteBtn setImage:[UIImage imageNamed:@"Delete.png"] forState:UIControlStateNormal];
    [_deleteView addSubview:_deleteBtn];
    [self.contentView addSubview:_deleteView];
}

- (void)setCellTitle:(NSString *)Title AddTime:(NSString *)AddTime IsRead:(NSInteger)IsRead
{
    _noticeContent.text =Title;
    _noticeMonth.text =AddTime;
    if (IsRead==0) {
        redDor.hidden =NO;
    }
    else{
        redDor.hidden=YES;
    }
}

#pragma mark --- Action
- (IBAction)pitchOnAction:(id)sender {
    [self pitchOnCount1];
    [self pitchOn];
    _click();
}

- (void)pitchOn
{
    if (_pitchOnCount !=0)
    {
        [editBtn setBackgroundImage:[UIImage imageNamed:@"pitchOn---Assistor@2x"] forState:0];
    }
    else
    {
        [editBtn setBackgroundImage:[UIImage imageNamed:@"NoPitchOn---Assistor@2x"] forState:0];
    }
}

- (void)pitchOnCount1
{
    if (_pitchOnCount ==0)
    {
        _pitchOnCount =1;
    }
    else
    {
        _pitchOnCount =0;
    }
}

- (void)viewsX:(NSInteger)x;
{
    [self viewFrame:_noticeContent x:x];
    [self viewFrame:_noticeMonth x:x];
//    [self viewFrame:_noticeTime x:x];
}

- (void)viewFrame:(UIView *)view x:(NSInteger)x
{
    if (view == _noticeContent)
    {
//        [UIView animateWithDuration:0.2 animations:^{
//            view.frame =CGRectMake(x, view.y, self.width-(x+26), view.height);
            view.x =x;
            view.width =self.width -(x+26);
//        }];
    }
    else
    {
//        [UIView animateWithDuration:0.2 animations:^{
            if (editBtn.hidden !=NO)
            {
                view.x =x;
//                view.frame =CGRectMake(x, view.y, view.width, view.height);
            }
//        }];
    }
}

- (void)editNoticeCell
{
    [self viewsX:46];
    editBtn.hidden =NO;
    redDor.hidden=YES;
}

- (void)cancelEditNoticeCell
{
    editBtn.hidden =YES;
    [self viewsX:26];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
