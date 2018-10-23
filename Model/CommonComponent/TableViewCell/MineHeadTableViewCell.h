//
//  MineHeadTableViewCell.h
//  lovecommunity
//
//  Created by air on 16/6/17.
//  Copyright © 2016年 ORANLLC_IOS1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JYAbstractTableViewCell.h"
@interface MineHeadTableViewCell : JYAbstractTableViewCell
@property (strong, nonatomic) IBOutlet UIButton *loginBtn;
@property (strong, nonatomic) IBOutlet UIImageView *imgV;
@property (nonatomic,strong)NSString *numberLb;
@property(nonatomic,strong) void (^imgChangeHandle)(id sender);
-(void)fitMineMode;
-(void)fitMineModeB;
@end
