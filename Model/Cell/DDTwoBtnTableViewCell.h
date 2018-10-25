//
//  DDTwoBtnTableViewCell.h
//  DDZX_js
//
//  Created by apple on 2018/8/21.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DDTwoBtnTableViewCell : UITableViewCell
@property(nonatomic,strong)void (^btnClickCallBack)(NSDictionary *dic);
-(void)refresh:(NSDictionary *)dic;
@end
