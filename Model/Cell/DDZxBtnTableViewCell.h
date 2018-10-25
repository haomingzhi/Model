//
//  DDZxBtnTableViewCell.h
//  NIM
//
//  Created by apple on 2018/7/26.
//  Copyright © 2018年 Netease. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DDZxBtnTableViewCell : UITableViewCell
@property(nonatomic,strong)void (^callBack)(NSDictionary *dic);
- (void)refresh:(NSDictionary *)dic;
@end
