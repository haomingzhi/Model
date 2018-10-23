//
//  FiveTitleTableViewCell.h
//  taihe
//
//  Created by LinFeng on 2016/11/22.
//  Copyright © 2016年 ORANLLC_IOS1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JYAbstractTableViewCell.h"
@interface FiveTitleTableViewCell : JYAbstractTableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLb;
@property (weak, nonatomic) IBOutlet UILabel *addressTitleLb;
@property (weak, nonatomic) IBOutlet UILabel *addressLb;
@property (weak, nonatomic) IBOutlet UILabel *tellTitleLb;
@property (weak, nonatomic) IBOutlet UILabel *tellLb;
@property (nonatomic,strong) NSDictionary *dataDic;
@property (nonatomic,strong) UIButton *starBtn;
@property (nonatomic,strong) UIButton *collectionBtn;
-(void)setNull;
-(void)fitCellMode;
-(void)fitLawMode;
-(void)fitMoneyUserMode;
-(void)fitOrderMode;
-(void)fitMyAccountMode;
-(void)fitConfirmOrderMode;
-(void)fitTeacherMode;
-(void)fitOrderInfoMode;
-(void)changeCollectionBtnState:(BOOL)isCollection;
-(void)fitMyGiftMode;
-(void)fitWithdrawMode:(UIColor*)color;
@end
