//
//  JYDatePickViewController.m
//  yihui
//
//  Created by air on 15/9/24.
//  Copyright (c) 2015年 ORANLLC_IOS1. All rights reserved.
//

#import "JYDatePickViewController.h"

@interface JYDatePickViewController ()
{
    IBOutlet UIDatePicker *_datePk;
    IBOutlet UIView *_aView;

    IBOutlet UIView *_bView;
}
@end

@implementation JYDatePickViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    if(_dateInfo&&![_dateInfo isEqualToString:@""])
    {
     [_datePk setDate:[BSUtility StrToDate:@"yyyy-MM-dd HH:mm" DateStr:_dateInfo]];
    }
    
    [_cancelBtn addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
//    _datePk.minimumDate = [NSDate date];
    [self fitVcMode];
   [_datePk setValue:kUIColorFromRGB(color_3) forKey:@"textColor"];
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//-(void)viewDidLayoutSubviews
//{
//    [_datePk.subviews objectAtIndex:1].layer.borderWidth = 0.5f;
//    
//    [_datePk.subviews objectAtIndex:2].layer.borderWidth = 0.5f;
//    
//    [_datePk.subviews objectAtIndex:1].layer.borderColor = kUIColorFromRGB(color_3).CGColor;
//    
//    [_datePk.subviews objectAtIndex:2].layer.borderColor = kUIColorFromRGB(color_3).CGColor;
//}


+(JYDatePickViewController*)createLimitVC
{
    
    
    JYDatePickViewController *dealvc = [JYDatePickViewController new];
    MyDialog *myDialog = [[MyDialog alloc] initWithViewController:dealvc];
    dealvc.view.width = __SCREEN_SIZE.width;
    dealvc.view.y = __SCREEN_SIZE.height - 198-64;
    //    vc.doneCallBack = ^(NSString *pwd){
    //        [weakSelf toAddwithdraw:pwd];
    //    };
    //    dealvc.view.layer.cornerRadius = 3;
    //    dealvc.view.layer.masksToBounds = YES;
    //    dealvc.userInfo = dic;
    //    dealvc.p = parentVC;
//    dealvc.view.alpha = 1.0;
    [myDialog showAtPosition:CGPointMake(0,__SCREEN_SIZE.height-198) animated:YES];
        myDialog.dismissOnTouchOutside = NO;
    //    myDialog.isDownAnimate = YES;
    return dealvc;
}

-(void)setMinDate:(NSDate *)minDate{
//    _datePk.date = minDate;
    _datePk.minimumDate = minDate;
}


-(void)setDate:(NSDate *)date{
     _datePk.date = date;
}

-(void)setMaxDate:(NSDate *)maxDate{
//    _datePk.date = minDate;
    _datePk.maximumDate = maxDate;
}

-(void)fitVcMode{
    _cancelBtn.x = 0;
    _finishBtn.x = __SCREEN_SIZE.width - _finishBtn.width;
    [_cancelBtn setTitleColor:kUIColorFromRGB(color_6) forState:UIControlStateNormal];
    _cancelBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [_finishBtn setTitleColor:kUIColorFromRGB(color_3) forState:UIControlStateNormal];
    _finishBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    _backView.x = (__SCREEN_SIZE.width - _backView.width)/2.0;
    UIView *lineV = [self.view viewWithTag:9734];
    if (!lineV) {
        lineV = [[UIView alloc] initWithFrame:CGRectMake(0, 44, __SCREEN_SIZE.width, 0.5)];
        lineV.backgroundColor = kUIColorFromRGB(color_lineColor);
        lineV.tag = 9734;
    }
    [self.view addSubview:lineV];
}

-(void)fitTimeMode
{
    _datePk.x = 0;
    _backView.x = 22;
    _aView.hidden = YES;
    _bView.hidden = YES;
    _datePk.width = __SCREEN_SIZE.width;
//    _datePk.date = [BSUtility StrToDate:@"yyyy-MM-dd HH:mm:ss" DateStr:@"2016-12-11 16:05:00"];
    _datePk.minimumDate = [NSDate date];
    _datePk.datePickerMode = UIDatePickerModeCountDownTimer;
    _datePk.minuteInterval = 5;
     [_datePk setDate: [BSUtility StrToDate:@"yyyy-MM-dd HH:mm:ss" DateStr:@"2016-12-11 16:05:00"]];
    [[_datePk subviews] enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       if([obj isKindOfClass:NSClassFromString(@"_UIDatePickerView")])
       {
           UIView *v = obj;
           [[v subviews] enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
               if([obj isKindOfClass:[UILabel class]])
               {
                   obj.hidden = YES;
               }
           }];
               [v.subviews objectAtIndex:1].layer.borderWidth = 0.5f;
           
               [v.subviews objectAtIndex:2].layer.borderWidth = 0.5f;
           
               [v.subviews objectAtIndex:1].layer.borderColor = kUIColorFromRGB(color_3).CGColor;
           CGRect r = [v convertRect:v.frame toView:_backView];
               [v.subviews objectAtIndex:2].layer.borderColor = kUIColorFromRGB(color_3).CGColor;
       }
    }];
    
    UIView *l1 = [_backView viewWithTag:7456];
    if (!l1) {
        l1 = [[UIView alloc] initWithFrame:CGRectMake(-30, 54.5, 100, 0.5)];
        l1.tag = 7456;
        l1.layer.borderColor = kUIColorFromRGB(color_3).CGColor;
        l1.layer.borderWidth = 0.5f;

    }
    UIView *l2 = [_backView viewWithTag:7134];
    if (!l2) {
        l2 = [[UIView alloc] initWithFrame:CGRectMake(-30, 89, 100, 0.5)];
        l2.layer.borderColor = kUIColorFromRGB(color_3).CGColor;
        l2.layer.borderWidth = 0.5f;
        l2.tag = 7134;
    }
    
    [_backView addSubview:l1];
      [_backView addSubview:l2];
}
-(void)fitDateTimeMode
{
     _datePk.x = 0;
     _backView.x = 0;
     _datePk.datePickerMode = UIDatePickerModeDateAndTime;
     _datePk.width = __SCREEN_SIZE.width;
//     _datePk.minimumDate = [NSDate new];
     _datePk.minuteInterval = 10;
     _aView.hidden = YES;
     _bView.hidden = YES;
//     NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
//     _datePk.locale = locale;
}
-(void)fitDateMode
{
    _datePk.x = 0;
    _backView.x = 0;
       _datePk.datePickerMode = UIDatePickerModeDate;
    _datePk.width = __SCREEN_SIZE.width;
    _aView.hidden = YES;
    _bView.hidden = YES;
}

-(void)cancelAction:(UIButton *)sender{
//    if (_callBack) {
//        //       _dateInfo = [BSUtility getDateTimeWithFormat:_datePk.date Format:@"yyyy-MM-dd HH:mm"];
//        _callBack(_datePk.date);
//    }
    [self.parentDialog dismiss];
}

- (IBAction)handleAction:(id)sender {
    if (_callBack) {
//       _dateInfo = [BSUtility getDateTimeWithFormat:_datePk.date Format:@"yyyy-MM-dd HH:mm"];
        _callBack(_datePk.date);
    }
     [self.parentDialog dismiss];
}

@end
