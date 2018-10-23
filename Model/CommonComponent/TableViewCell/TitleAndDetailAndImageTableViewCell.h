//
//  TitleAndDetailAndImageTableViewCell.h
//  taihe
//
//  Created by LinFeng on 2016/11/23.
//  Copyright © 2016年 ORANLLC_IOS1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JYAbstractTableViewCell.h"

@interface TitleAndDetailAndImageTableViewCell : JYAbstractTableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLb;
@property (weak, nonatomic) IBOutlet UILabel *detailLb;
@property (weak, nonatomic) IBOutlet UIImageView *imgV;
@property (nonatomic,strong) NSDictionary *dataDic;
@property (nonatomic,strong) NSMutableArray *viewsArr;
-(void)fitCellMode;
-(void)fitWarnMode;
-(void)fitWaterMode;
-(void)fitNoImageMode;
-(void)fitUpPersonInfoMode;
-(NSString *)getData:(NSString *)title;

-(void)fitConfirmGoodsInfoMode;
-(void)fitAppointentMode;
-(void)fitFillInOrderMode;
-(void)fitFillInOrderModeA:(BOOL)isOpen;
-(void)fitFillInOrderModeB;
-(void)fitFillInOrderModeC:(BOOL)isSelected;
-(void)fitFillInOrderModeD;
-(void)fitFillInOrderModeE;
-(void)fitInvoicerMode;
-(void)fitPayOrderMode;
-(void)fitSpecialMode;
-(void)fitSpecialInfoMode;

-(void)fitSpecialInfoModeA;
-(void)fitWriteEvaluationMode:(BOOL)isOpen;
-(void)fitClasstifyInfoMode;
-(void)fitGoodsInfoModeC;

-(void)fitEvaluationMode;
-(void)fitEvaluationShowMoreMode:(BOOL)isShowMore;
-(void)fitEvaInfoMode;
-(void)fitEvaInfoModeA;
-(void)fitGoodsInfoMode;
-(void)fitGoodsInfoModeA;
-(void)fitGoodsInfoModeB;
-(void)fitBrandShowMoreMode:(BOOL)isShowMore;
-(void)fitHiddenMode;
-(void)fitServerMode;
@end
