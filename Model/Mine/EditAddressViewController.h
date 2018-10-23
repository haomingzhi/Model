//
//  EditAddressViewController.h
//  compassionpark
//
//  Created by air on 2017/3/29.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import "JYEditNickNameViewController.h"
#import "TitleDetailTableViewCell.h"
#import "BUSystem.h"

@interface EditAddressViewController : JYEditNickNameViewController
@property(nonatomic)NSInteger mode;
 @property(nonatomic,strong)TitleDetailTableViewCell *areaCell;
// @property(nonatomic,strong)NSString *provinceId;
// @property(nonatomic,strong)NSString *provinceName;
// @property(nonatomic,strong)NSString *cityId;
// @property(nonatomic,strong)NSString *cityName;
// @property(nonatomic,strong)NSString *areaId;
// @property(nonatomic,strong)NSString *areaName;
@property (nonatomic,strong) BUUserAddress *address;

@end
