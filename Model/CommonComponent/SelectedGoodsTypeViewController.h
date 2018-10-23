//
//  SelectedGoodsTypeViewController.h
//  oranllcshoping
//
//  Created by Steve on 2017/7/25.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import <UniversalFramework/UniversalFramework.h>

@interface SelectedGoodsTypeViewController : JYBaseViewController
@property (weak, nonatomic) IBOutlet UIImageView *imgV;
@property (weak, nonatomic) IBOutlet UIImageView *lineImgV;

@property (weak, nonatomic) IBOutlet UILabel *sumPriceLb;//首付
@property (weak, nonatomic) IBOutlet UILabel *sumPriceTitleLb;
@property (weak, nonatomic) IBOutlet UILabel *priceTitlleLb;
@property (weak, nonatomic) IBOutlet UILabel *priceLb;//单期
@property (weak, nonatomic) IBOutlet UILabel *insurancePriceLb;//保险
@property (weak, nonatomic) IBOutlet UILabel *insuranceTitleLb;//保险标题

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
//选择时间
@property (weak, nonatomic) IBOutlet UIView *selectDateView;
@property (weak, nonatomic) IBOutlet UILabel *titleLb;
- (IBAction)selectBeginDateAction:(UIButton *)sender;
- (IBAction)selectEndDateAction:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *startDateBtn;
@property (weak, nonatomic) IBOutlet UIButton *endDateBtn;

//增值服务
@property (weak, nonatomic) IBOutlet UIView *serverView;
@property (weak, nonatomic) IBOutlet UILabel *insuranceWarnLb;
//用户租赁及服务协议
- (IBAction)showAgreementAction:(UIButton *)sender;

//下单
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UILabel *depositLb;//押金
@property (weak, nonatomic) IBOutlet UILabel *typeLb;//选择类型

@property (weak, nonatomic) IBOutlet UIButton *confirmBtn;
- (IBAction)confirmAction:(UIButton *)sender;
-(void)setData:(NSDictionary*)dic;
-(void)fitCellMode;
-(void)setStartAndEndDate:(NSDictionary*)dic;
@property (nonatomic,strong) NSMutableArray *dataArr;
@property (nonatomic,strong) NSMutableArray *curBtnsArr;
@property (nonatomic,strong) NSMutableArray *viewsArr;
@property (nonatomic,strong) NSDictionary *dataDic;
+(SelectedGoodsTypeViewController *)createVC:(NSDictionary *)dic;

@end
