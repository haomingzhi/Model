//
//  DDTitleTextviewTableViewCell.h
//  DDZX_js
//
//  Created by apple on 2018/9/18.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DDTitleTextviewTableViewCell : UITableViewCell
@property(nonatomic,strong)void (^textChangeallBack)(NSDictionary *dic);
-(void)refresh:(NSDictionary *)dic;
@end
