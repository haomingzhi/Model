//
//  TitleAndTextBtnTableViewCell.h
//  lovecommunity
//
//  Created by air on 16/6/24.
//  Copyright © 2016年 ORANLLC_IOS1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JYAbstractTableViewCell.h"
@interface TitleAndTextBtnTableViewCell : JYAbstractTableViewCell
-(void)fitMode;
-(UIButton *)getBtn;
@property(nonatomic,strong)BOOL (^extroHandle)(id o);
@property(nonatomic) NSInteger initTime;
-(void)fitModeB;
-(void)fitRegMode;
-(void)fitRantInfoMode:(BOOL)upDown;
-(NSString *)getData:(NSString *)key;
-(void)fitPublishMode:(NSInteger)state;
-(void)refreshMode;
-(void)fitMyAccountMode;
//-(void)fitCerManagerNextMode;
-(void)fitMyAccountMode:(BOOL)isShowUnBind;
//-(void)fitCerManagerNextMode:(BOOL)show;

-(void)fitRegMode:(BOOL)b withTarget:(id)obj withSEL:(SEL)sel;
-(void)fitModiPhoneMode;
@end
