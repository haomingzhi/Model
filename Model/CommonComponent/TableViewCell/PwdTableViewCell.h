//
//  PwdTableViewCell.h
//  compassionpark
//
//  Created by air on 2017/2/3.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JYAbstractTableViewCell.h"
@interface PwdTableViewCell : JYAbstractTableViewCell
@property(nonatomic,strong) MyPwdTextField *passwordTf;
-(void)fitMode;
@end
