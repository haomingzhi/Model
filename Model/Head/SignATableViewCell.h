//
//  SignATableViewCell.h
//  rentingshop
//
//  Created by Steve on 2018/3/22.
//  Copyright © 2018年 ORANLLC_IOS1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JYAbstractTableViewCell.h"




@interface SignATableViewCell : JYAbstractTableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLb;
@property (weak, nonatomic) IBOutlet UIView *warnView;
@property (weak, nonatomic) IBOutlet UILabel *warnLbA;
@property (weak, nonatomic) IBOutlet UILabel *warnLbB;
@property (weak, nonatomic) IBOutlet UILabel *warnLbC;
@property (weak, nonatomic) IBOutlet UILabel *warnLbD;
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (nonatomic,strong) NSDictionary *dataDic;
@property (nonatomic,strong) NSMutableArray *viewsArr;
-(void)fitCellMode;
@end
