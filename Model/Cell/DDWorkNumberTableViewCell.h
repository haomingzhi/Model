//
//  DDWorkNumberTableViewCell.h
//  DDZX_js
//
//  Created by apple on 2018/9/19.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import "DDTitleTextfieldTableViewCell.h"

@interface DDWorkNumberTableViewCell : DDTitleTextfieldTableViewCell
@property(nonatomic,strong)void (^callBack)(NSDictionary *dic);
@end
