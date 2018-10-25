//
//  DDZxRegAndForgetPwdTableViewCell.h
//  NIM
//
//  Created by apple on 2018/7/26.
//  Copyright © 2018年 Netease. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DDZxRegAndForgetPwdTableViewCell : UITableViewCell
@property(nonatomic,strong)void (^regCallBack)(NSDictionary *dic);
@property(nonatomic,strong)void (^forgetCallBack)(NSDictionary *dic);
- (void)refresh:(NSDictionary *)dic;
@end
