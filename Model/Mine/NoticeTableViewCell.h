//
//  NoticeTableViewCell.h
//  ulife
//
//  Created by sunmax on 15/12/15.
//  Copyright © 2015年 ORANLLC_IOS1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NoticeTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *noticeContent;//内容
@property (weak, nonatomic) IBOutlet UILabel *noticeMonth;//月份
@property (weak, nonatomic) IBOutlet UILabel *noticeTime;//时间
@property (nonatomic, assign)NSInteger pitchOnCount;//是否选中
@property (nonatomic, strong)void (^click)();

- (void)pitchOn;

- (void)editNoticeCell;//开始编辑

- (void)cancelEditNoticeCell;//取消编辑

- (void)setCellTitle:(NSString *)Title AddTime:(NSString *)AddTime IsRead:(NSInteger)IsRead;
@end
