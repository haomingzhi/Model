//
//  FlashTableViewCell.h
//  JiXie
//
//  Created by air on 15/5/25.
//  Copyright (c) 2015年 ORANLLC_IOS1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BUSystem.h"
#import "JYAbstractTableViewCell.h"
@interface GoodsFlashTableViewCell : JYAbstractTableViewCell
@property(nonatomic,strong)void (^selecedtItem)(id o);
@property (strong, nonatomic) UILabel *textLbl;
@property (assign,nonatomic) float cellHeight;
@property (nonatomic,strong) void (^showMore) (id o);
-(void)reloadData;
-(void)fitHeadMode;
-(void)fitParkingInfoMode;
-(void)fitHeadMode_head;
-(void)fitHeadMode_Second;
-(void)setCellDataHeaadSecondAd:(NSDictionary *)dataDic;
-(void)fitCompanyInfoMode;
-(void)fitGoodsInfoMode;

-(void)setNull;
-(void)fitExclusiveAppointmentMode;
-(void)fitSpecialInfoMode;
-(void)fitClassifyMode;
@end
