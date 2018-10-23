//
//  DatePickViewController.h
//  ZhongGengGroup
//
//  Created by ORANLLC_IOS1 on 15/4/3.
//  Copyright (c) 2015年 SunnadaSoft. All rights reserved.
//



typedef enum __datePickerStyle
{
    datePickerStyle_date,
    datePickerStyle_dateTime,
    datePickerStyle_custom
}DATEPICKERSTYLE;

@interface DatePickViewController : BaseViewController

-(id) initWithHourRange:(NSString *)hourRange;

-(id)initWithStyle:(DATEPICKERSTYLE)datePickerStyle;

@property (nonatomic) DATEPICKERSTYLE pickerStyle;
@property (nonatomic) NSDate *selectedDate;
@property (nonatomic) NSString *selectedStr;


@property (weak, nonatomic) IBOutlet UIDatePicker *datetimePicker;

@property (weak, nonatomic) IBOutlet UILabel *labelCurrentTime;

@property (weak, nonatomic) IBOutlet UIPickerView *customPicker;

- (IBAction)handleOk:(id)sender;

@end
