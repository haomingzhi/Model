//
//  DDZxTextViewTableViewCell.h
//  DDZX_js
//
//  Created by apple on 2018/8/27.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DDZxTextViewTableViewCell : UITableViewCell
@property(nonatomic,strong)NSString *text;
@property(nonatomic,strong)void (^textChangeCallBack)(NSDictionary *dic);
-(void)refresh:(NSDictionary *)dic;
@end
