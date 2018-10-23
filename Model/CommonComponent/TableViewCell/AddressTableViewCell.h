//
//  AddressTableViewCell.h
//  chenxiaoer
//
//  Created by air on 16/3/10.
//  Copyright © 2016年 ORANLLC_IOS1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JYAbstractTableViewCell.h"
@interface AddressTableViewCell : JYAbstractTableViewCell
-(void)fitCellMode;
-(void)fitConfirmOrderMode;
-(void)fitCheckAddressMode:(BOOL)isChecke;
-(void)fitAddressMode:(BOOL)isCheck;
@end
