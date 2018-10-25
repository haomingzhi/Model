//
//  DDMyIntroTableViewCell.h
//  DDZX_js
//
//  Created by apple on 2018/8/23.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DDMyIntroTableViewCell : UITableViewCell
@property(nonatomic,strong)void (^goodAtCallBack)(void);
@property(nonatomic,strong)void (^myPointCallBack)(void);
-(void)refresh:(NSDictionary *)dic;
@end
