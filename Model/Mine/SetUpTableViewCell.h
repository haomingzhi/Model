//
//  SetUpTableViewCell.h
//  ulife
//
//  Created by sunmax on 15/12/10.
//  Copyright © 2015年 ORANLLC_IOS1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JYAbstractTableViewCell.h"
@interface SetUpTableViewCell : JYAbstractTableViewCell
@property (weak, nonatomic) IBOutlet UILabel *cellName;
@property (weak, nonatomic) IBOutlet UILabel *prompt;
@property (weak, nonatomic) IBOutlet UILabel *cache;
@property(weak,nonatomic)UISwitch *pushSw;
-(void)setCell:(NSString *)cellName;//普通

-(void)setCacheCell:(NSString *)cellName;//缓存

-(void)setPromptCell:(NSString *)cellName;//推送提示

-(void)set_switchCell:(NSString *)cellName;

-(void)setVersionCell:(NSString *)cellName withVersion:(NSString *)ver;
@end
