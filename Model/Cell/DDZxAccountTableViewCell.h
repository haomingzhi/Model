//
//  DDZxAccountTableViewCell.h
//  NIM
//
//  Created by apple on 2018/7/26.
//  Copyright © 2018年 Netease. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DDZxAccountTableViewCell : UITableViewCell
@property(nonatomic,strong)NSString *text;
- (void)refresh:(NSDictionary *)dic;
@end
