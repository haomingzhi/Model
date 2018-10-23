//
//  TitleAndTwoTextfieldTableViewCell.h
//  taihe
//
//  Created by air on 2016/11/14.
//  Copyright © 2016年 ORANLLC_IOS1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JYAbstractTableViewCell.h"
@interface TitleAndTwoTextfieldTableViewCell : JYAbstractTableViewCell
//-(void)fitRantInfoMode;
@property(nonatomic,strong) IBOutlet UITextField *textTfB;
@property(nonatomic,strong)    IBOutlet UITextField *textTfA;
-(NSString *)getData:(NSString *)key;
-(void)fitPersonInfoSettingMode:(id)obj withSel:(SEL)sel;
@end
