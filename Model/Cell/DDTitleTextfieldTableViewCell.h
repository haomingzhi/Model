//
//  DDTitleTextfieldTableViewCell.h
//  DDZX_js
//
//  Created by apple on 2018/8/27.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DDTitleTextfieldTableViewCell : UITableViewCell
@property(nonatomic,strong)void (^textChangeallBack)(NSDictionary *dic);
@property(nonatomic,strong)UITextField *textTf;
-(void)refresh:(NSDictionary *)dic;
@end
