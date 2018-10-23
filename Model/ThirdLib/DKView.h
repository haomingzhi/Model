//
//  DKView.h
//  chier
//
//  Created by sunmax on 15/12/25.
//  Copyright © 2015年 sunmax. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DKFilterView.h"
#import "DKFilterModel.h"
#import "CitycChoiceView.h"
#define IS_IOS8 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8)
@interface DKView : UIView<DKFilterViewDelegate,CLLocationManagerDelegate>
@property (nonatomic,strong) DKFilterView *filterView;
@property (nonatomic,strong) DKFilterModel *clickModel;
@property (nonatomic,strong) CitycChoiceView *citycChoiceView;
@property (nonatomic,strong) UIView *backgroundView;
@property (nonatomic,strong) void (^data)(DKFilterModel *data,NSMutableArray *mArr);
@property (nonatomic,strong) void (^switchCity)();
@property (nonatomic,strong) void (^push)();
@property (nonatomic,strong) NSArray *filterData;
-(instancetype)initWithFrame:(CGRect)frame city:(NSString *)city;

-(instancetype)initWithFrame:(CGRect)frame cityArr:(NSArray *)cityArr;

-(NSArray *)currentCountyArrCity:(NSString *)city;

- (void)locate;
@end
