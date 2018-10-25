//
//  DDPasswordTableViewCell.h
//  DDZX_js
//
//  Created by apple on 2018/8/23.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DDPasswordTableViewCell : UITableViewCell
@property(nonatomic,strong)NSString *text;
-(void)refresh:(NSDictionary *)dic;
@end
