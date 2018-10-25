//
//  DDTextFieldTableViewCell.h
//  DDZX_js
//
//  Created by apple on 2018/8/23.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DDTextFieldTableViewCell : UITableViewCell
@property(nonatomic,strong)NSString *text;
    @property(nonatomic,assign)NSInteger limitCount;
@property(nonatomic,strong)void (^textChangeCallBack)(NSDictionary *dic);
-(void)refresh:(NSDictionary *)dic;
@end
