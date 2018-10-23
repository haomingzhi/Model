//
//  DatePickViewController.m
//  ZhongGengGroup
//
//  Created by ORANLLC_IOS1 on 15/4/3.
//  Copyright (c) 2015年 SunnadaSoft. All rights reserved.
//

#import "DatePickViewController.h"

@interface DatePickViewController ()<UIPickerViewDataSource,UIPickerViewDelegate>

@end

@implementation DatePickViewController
{
    NSMutableArray *yearArray;      //年
    NSArray *monthArray;            //月
    NSMutableArray *DaysArray;      //日
    NSArray *hoursArray;            //时
    NSMutableArray *minutesArray;   //分
    
    NSMutableArray *customtTodayArray;    //自定义范围
    NSMutableArray *customAllArray;
    
    
    int selectedYearRow;
    int selectedMonthRow;
    int selectedDayRow;
    NSString *myHourRange;
    NSString *nowDateStr;
    BOOL isToday;
}
-(id) initWithHourRange:(NSString *)hourRange
{
    self = [self initWithStyle:datePickerStyle_custom];
    if (self) {
        myHourRange = hourRange;
    }
    return self;
}

-(id)initWithStyle:(DATEPICKERSTYLE)datePickerStyle
{
    self = [super init];
    if (self) {
        self.pickerStyle = datePickerStyle;
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.selectedDate =[NSDate date];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if (self.pickerStyle == datePickerStyle_dateTime || self.pickerStyle ==datePickerStyle_date) {
        self.customPicker.hidden = TRUE;
        self.datetimePicker.hidden = FALSE;
        self.datetimePicker.datePickerMode = self.pickerStyle ==datePickerStyle_date ? UIDatePickerModeDate : UIDatePickerModeDateAndTime;
        [self.datetimePicker addTarget:self action:@selector(chooseDate:) forControlEvents:UIControlEventValueChanged];
        self.selectedDate = [NSDate date];
        self.labelCurrentTime.text = [BSUtility getDateTimeWithFormat:self.selectedDate Format:@"yyyy年MM月dd日EEEE"];//@"yyyy年MM月dd日#EEEE"];EEEE为星期几，EEE为周几
        return;
    }
    isToday = YES;
    self.customPicker.hidden = NO;
    self.datetimePicker.hidden = TRUE;
    self.customPicker.dataSource = self;
    self.customPicker.delegate = self;
    
    NSDate *date = [NSDate date];
    
    nowDateStr = [BSUtility getSystemDate];
    // Get Current Year
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy"];
    NSString *currentyearString = [NSString stringWithFormat:@"%@",
                                   [formatter stringFromDate:date]];
    
    
    // Get Current  Month
    [formatter setDateFormat:@"MM"];
    NSString *currentMonthString = [formatter stringFromDate:date];
    
    
    // Get Current  Date
    [formatter setDateFormat:@"dd"];
    NSString *currentDateString = [NSString stringWithFormat:@"%@",[formatter stringFromDate:date]];
    
    
    // Get Current  Hour
    [formatter setDateFormat:@"HH"];
    NSString *currentHourString = [NSString stringWithFormat:@"%@",[formatter stringFromDate:date]];
    
    // Get Current  Minutes
    [formatter setDateFormat:@"mm"];
    NSString *currentMinutesString = [NSString stringWithFormat:@"%@",[formatter stringFromDate:date]];
    
    // PickerView -  Years data
    
    yearArray = [[NSMutableArray alloc]init];
    
    
    for (int i = 1970; i <= 2050 ; i++)
    {
        [yearArray addObject:[NSString stringWithFormat:@"%d",i]];
        
    }
    
    
    // PickerView -  Months data
    
    
    monthArray = @[@"01",@"02",@"03",@"04",@"05",@"06",@"07",@"08",@"09",@"10",@"11",@"12"];
    
    
    // PickerView -  Hours data
    
    
    hoursArray = @[@"00",@"01",@"02",@"03",@"04",@"05",@"06",@"07",@"08",@"09",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21",@"22",@"23"];
    
    
    // PickerView -  mini data
    
    minutesArray = [[NSMutableArray alloc]init];
    
    for (int i = 0; i < 60; i++)
    {
        
        [minutesArray addObject:[NSString stringWithFormat:@"%02d",i]];
        
    }
    
    
    
    // PickerView -  days data
    
    DaysArray = [[NSMutableArray alloc]init];
    
    for (int i = 1; i <= 31; i++)
    {
        [DaysArray addObject:[NSString stringWithFormat:@"%d",i]];
        
    }
    customtTodayArray = [[NSMutableArray alloc]init];
    customAllArray = [[NSMutableArray alloc]init];
    NSDate *currentTime =  [BSUtility StrToDate:@"HH" DateStr:[BSUtility getDateTimeWithFormat:date Format:@"HH"]] ;
    NSString *currentRangeTime = [NSString stringWithFormat:@"%@-%@",[BSUtility getDateTimeWithFormat:currentTime Format:@"HH:mm"],[BSUtility getDateTimeWithFormat:[currentTime dateByAddingTimeInterval:60 *60] Format:@"HH:mm"]];
    //营业时间 7:00~21:00
    if (myHourRange.length >0) {
        NSArray *tmpStrs = [myHourRange componentsSeparatedByString:@" "];
        NSArray * subRangs = [tmpStrs[1] componentsSeparatedByString:@"-"];
        if (subRangs.count ==2)
        {
            NSDate *startTime = [BSUtility StrToDate:@"HH:mm" DateStr:subRangs[0]];
            NSDate *endTime = [BSUtility StrToDate:@"HH:mm" DateStr:subRangs[1]];
            while ([startTime compare: endTime] == NSOrderedAscending) {
                [customAllArray addObject: [NSString stringWithFormat:@"%@-%@",[BSUtility getDateTimeWithFormat:startTime Format:@"HH:mm"],[BSUtility getDateTimeWithFormat:[startTime dateByAddingTimeInterval:60 *60] Format:@"HH:mm"]] ];
                if([startTime compare: currentTime] != NSOrderedAscending)
                {
                    [customtTodayArray addObject: [NSString stringWithFormat:@"%@-%@",[BSUtility getDateTimeWithFormat:startTime Format:@"HH:mm"],[BSUtility getDateTimeWithFormat:[startTime dateByAddingTimeInterval:60 *60] Format:@"HH:mm"]] ];
                }
                startTime =[startTime dateByAddingTimeInterval:60 *60];
            }
        }
    }
    
    selectedYearRow = [yearArray indexOfObject:currentyearString];
    selectedMonthRow = [monthArray indexOfObject:currentMonthString];
    selectedDayRow = [DaysArray indexOfObject:currentDateString];
    
    [self.customPicker selectRow:selectedYearRow inComponent:0 animated:YES];
    [self.customPicker selectRow:selectedMonthRow inComponent:1 animated:YES];
    [self.customPicker selectRow:selectedDayRow inComponent:2 animated:YES];
    [self.customPicker selectRow:[customtTodayArray indexOfObject:currentRangeTime] inComponent:3 animated:YES];
    self.selectedStr = [NSString stringWithFormat:@"%@-%@-%@ %@",[yearArray objectAtIndex:[self.customPicker selectedRowInComponent:0]],[monthArray objectAtIndex:[self.customPicker selectedRowInComponent:1]],[DaysArray objectAtIndex:[self.customPicker selectedRowInComponent:2]],isToday ? [customtTodayArray objectAtIndex:[self.customPicker selectedRowInComponent:3]] : [customAllArray objectAtIndex:[self.customPicker selectedRowInComponent:3]]];
    self.labelCurrentTime.text = self.selectedStr;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIPickerViewDelegate


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSString * tmpSelectedDateStr = [NSString stringWithFormat:@"%@-%@-%@",[yearArray objectAtIndex:[self.customPicker selectedRowInComponent:0]],[monthArray objectAtIndex:[self.customPicker selectedRowInComponent:1]],[DaysArray objectAtIndex:[self.customPicker selectedRowInComponent:2]]];
    if ([tmpSelectedDateStr compare:[BSUtility getSystemDate]] ==NSOrderedAscending) { //判断选中的日期是否合法
        [self.customPicker selectRow:selectedYearRow inComponent:0 animated:YES];
        [self.customPicker selectRow:selectedMonthRow inComponent:1 animated:YES];
        [self.customPicker selectRow:selectedDayRow inComponent:2 animated:YES];
        return;
    }
    if (component == 0)
    {
        selectedYearRow = row;
        [self.customPicker reloadAllComponents];
    }
    else if (component == 1)
    {
        selectedMonthRow = row;
        [self.customPicker reloadAllComponents];
    }
    else if (component == 2)
    {
        selectedDayRow = row;
        [self.customPicker reloadAllComponents];
    }
    if (component != 3 ) {
        NSString *tmpSelectDate =  [NSString stringWithFormat:@"%@-%@-%@",[yearArray objectAtIndex:[self.customPicker selectedRowInComponent:0]],[monthArray objectAtIndex:[self.customPicker selectedRowInComponent:1]],[DaysArray objectAtIndex:[self.customPicker selectedRowInComponent:2]]];
        if ([tmpSelectDate isEqualToString:nowDateStr]) {//判断日期是否今天
            if (!isToday) { //从其他日期变成今日
                isToday = YES;
                NSString *selectedStr = [customAllArray objectAtIndex:[self.customPicker selectedRowInComponent:3]];
                [self.customPicker reloadAllComponents];
                [self.customPicker selectRow:[customtTodayArray indexOfObject:selectedStr] == NSNotFound ? 0 :  [customtTodayArray indexOfObject:selectedStr] inComponent:3 animated:YES];
            }
            isToday = YES;
        }
        else //跳变到其他日期
        {
            NSString *selectedStr = isToday ? [customtTodayArray objectAtIndex:[self.customPicker selectedRowInComponent:3]] : [customAllArray objectAtIndex:[self.customPicker selectedRowInComponent:3]];
            [self.customPicker reloadAllComponents];
            [self.customPicker selectRow:[customAllArray indexOfObject:selectedStr] == NSNotFound ? 0 :  [customAllArray indexOfObject:selectedStr] inComponent:3 animated:YES];
            isToday = NO;
        }
    }
    
    self.selectedStr = [NSString stringWithFormat:@"%@-%@-%@ %@",[yearArray objectAtIndex:[self.customPicker selectedRowInComponent:0]],[monthArray objectAtIndex:[self.customPicker selectedRowInComponent:1]],[DaysArray objectAtIndex:[self.customPicker selectedRowInComponent:2]],isToday ? [customtTodayArray objectAtIndex:[self.customPicker selectedRowInComponent:3]] : [customAllArray objectAtIndex:[self.customPicker selectedRowInComponent:3]]];
    self.labelCurrentTime.text = self.selectedStr;
}




#pragma mark - UIPickerViewDatasource

- (UIView *)pickerView:(UIPickerView *)pickerView
            viewForRow:(NSInteger)row
          forComponent:(NSInteger)component
           reusingView:(UIView *)view {
    
    // Custom View created for each component
    
    UILabel *pickerLabel = (UILabel *)view;
    
    if (pickerLabel == nil) {
        CGRect frame = CGRectMake(0.0, 0.0, 100, 50);
        pickerLabel = [[UILabel alloc] initWithFrame:frame];
        [pickerLabel setTextAlignment:NSTextAlignmentCenter];
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        [pickerLabel setFont:[UIFont systemFontOfSize:14.0f]];
    }

    if (component == 0)
    {
        pickerLabel.text =  [yearArray objectAtIndex:row]; // Year
    }
    else if (component == 1)
    {
        pickerLabel.text =  [monthArray objectAtIndex:row];  // Month
    }
    else if (component == 2)
    {
        pickerLabel.text =  [DaysArray objectAtIndex:row]; // Date
        
    }
    else if (component == 3)
    {
        
        pickerLabel.text =  isToday ?[customtTodayArray objectAtIndex:row]: [customAllArray objectAtIndex:row] ;
    }
    
    return pickerLabel;
}



- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    
    return 4;
    
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    
    if (component == 0)
    {
        return [yearArray count];
        
    }
    else if (component == 1)
    {
        return [monthArray count];
    }
    else if (component == 2)
    { // day
        
        if (selectedMonthRow == 0 || selectedMonthRow == 2 || selectedMonthRow == 4 || selectedMonthRow == 6 || selectedMonthRow == 7 || selectedMonthRow == 9 || selectedMonthRow == 11)
        {
            return 31;
        }
        else if (selectedMonthRow == 1)
        {
            int yearint = [[yearArray objectAtIndex:selectedYearRow]intValue ];
            
            if(((yearint %4==0)&&(yearint %100!=0))||(yearint %400==0)){
                return 29;
            }
            else
            {
                return 28; // or return 29
            }
        }
        else
        {
            return 30;
        }
        
    }
    else if (component == 3)
    { // custom
        return isToday ?  customtTodayArray.count :customAllArray.count ;
    }
    return 0;
}


#pragma mark --handle

- (IBAction)handleOk:(id)sender {
    [self.parentDialog dismiss];
}


- (void)chooseDate:(UIDatePicker *)sender {
    self.selectedDate = sender.date;
    self.labelCurrentTime.text = [BSUtility getDateTimeWithFormat:self.selectedDate Format:@"yyyy年MM月dd日EEEE"];//@"yyyy年MM月dd日#EEEE"];EEEE为星期几，EEE为周几
}
@end
