//
//  DDCommentTipTableViewCell.h
//  NIM
//
//  Created by apple on 2018/7/31.
//  Copyright © 2018年 Netease. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DDCommentTipTableViewCell : UITableViewCell
@property(nonatomic,strong)void (^onClickCallBack)(void);
- (void)refresh:(NSDictionary *)dic;
@end
