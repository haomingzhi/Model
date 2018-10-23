//
//  BURegisterModel.h
//  ulife
//
//  Created by sunmax on 15/12/28.
//  Copyright © 2015年 ORANLLC_IOS1. All rights reserved.
//

#import <UniversalFramework/UniversalFramework.h>

@interface BURegisterModel : BUBase
@property (nonatomic,strong)NSString *Phone;
@property (nonatomic,strong)NSString *Pwd;
@property (nonatomic,strong)NSString *RePwd;
@property (nonatomic,strong)NSString *Name;
@property (nonatomic,strong)UIImage *Img;
@property (nonatomic,strong)NSString *registrationID;
@end
