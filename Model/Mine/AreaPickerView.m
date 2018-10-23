//
//  AreaPickerView.m
//  areapicker
//
//  Created by Cloud Dai on 12-9-9.
//  Copyright (c) 2012年 clouddai.com. All rights reserved.
//

#import "AreaPickerView.h"
#import "BUSystem.h"

#define kDuration 0.3

@interface AreaPickerView ()


@end

@implementation AreaPickerView
{
    NSInteger selectedProvinceRow;
    NSInteger selectedCityRow;
    NSInteger selectedCountyRow;
}

- (id)initWithStyle:(AreaPickerStyle)pickerStyle
{
    
    self = [super init];
    if (self) {
        self.pickerStyle = pickerStyle;
        self.locatePicker.dataSource = self;
        self.locatePicker.delegate = self;
    }
        
    return self;
    
}

-(void) reloadData
{
//    if (busiSystem.areaManager.currentProvince == NULL) {
//        busiSystem.areaManager.currentProvince = busiSystem.areaManager.areas[0];
//    }
//    if (busiSystem.areaManager.currentCity == NULL) {
//        busiSystem.areaManager.currentCity = busiSystem.areaManager.currentProvince != NULL &&busiSystem.areaManager.currentProvince.citys.count >0 ?busiSystem.areaManager.currentProvince.citys[0] : NULL;
//    }
//    if (busiSystem.areaManager.currentCounty == NULL) {
//        busiSystem.areaManager.currentCounty = busiSystem.areaManager.currentCity != NULL &&busiSystem.areaManager.currentCity.countys.count >0 ?busiSystem.areaManager.currentCity.countys[0] : NULL;
//    }
//    [self.locatePicker reloadAllComponents];
//    if (self.pickerStyle  == AreaPickerWithProvince && busiSystem.areaManager.currentProvince != NULL)
//    {
//        NSInteger index = [busiSystem.areaManager.areas indexOfObject:busiSystem.areaManager.currentProvince];
//        [self.locatePicker selectRow:index inComponent:0 animated:YES];
//    }
//    else if (self.pickerStyle  == AreaPickerWithCity && busiSystem.areaManager.currentCity != NULL)
//    {
//        NSInteger index = [busiSystem.areaManager.currentProvince.citys indexOfObject:busiSystem.areaManager.currentCity];
//        [self.locatePicker selectRow:index inComponent:0 animated:YES];
//    }
//    else if (self.pickerStyle == AreaPickerWithCounty)
//    {
//        NSInteger index = [busiSystem.areaManager.currentCity.countys indexOfObject:busiSystem.areaManager.currentCounty];
//        [self.locatePicker selectRow:index inComponent:0 animated:YES];
//    }
//    self.labelSelected.text = [NSString stringWithFormat:@"%@ %@ %@",busiSystem.areaManager.currentProvince  ? busiSystem.areaManager.currentProvince.provinceName : @"",busiSystem.areaManager.currentCity ? busiSystem.areaManager.currentCity.cityName : @"",busiSystem.areaManager.currentCounty ? busiSystem.areaManager.currentCounty.countyName : @""];
 
}

-(void)viewDidLoad
{
//    if ((self.pickerStyle & AreaPickerWithProvince) == AreaPickerWithProvince)
//    {
//        if (busiSystem.areaManager.areas.count ==0)
//        {
//            HUDSHOW(@"正在加载数据...");
////            [busiSystem.areaManager updateAreaList:self callback:@selector(updateAreaListNotification:)];
//        }
//        else [self reloadData];
//    }
//    else  if ((self.pickerStyle & AreaPickerWithCity) == AreaPickerWithCity)
//    {
//        if (busiSystem.areaManager.currentProvince.citys.count ==0)
//        {
//            HUDSHOW(@"正在加载数据...");
////            [busiSystem.areaManager.currentProvince updateCitys:self callback:@selector(updateAreaListNotification:)];
//        }
//        else [self reloadData];
//    }
//    else if ((self.pickerStyle & AreaPickerWithCounty) == AreaPickerWithCounty)
//    {
//        if (busiSystem.areaManager.currentCity.countys.count ==0) {
//            HUDSHOW(@"正在加载数据...");
////            [busiSystem.areaManager.currentCity updateCountys:self callback:@selector(updateAreaListNotification:)];
//        }
//        else [self reloadData];
//    }
    
    
}

- (IBAction)handleOk:(id)sender {
    [self.parentDialog dismiss];
}

#pragma mark --Notification

-(void)updateAreaListNotification:(BSNotification *)noti
{
    ISTOLOGIN;
    if (noti.error.code ==0) {
        HUDDISMISS;
        [self reloadData];
    }
    else {
        HUDCRY(noti.error.domain, TOAST_LONGERTIMER);
        self.locatePicker.userInteractionEnabled = FALSE;
    }
}

#pragma mark - UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return (self.pickerStyle == (AreaPickerWithProvince | AreaPickerWithCity | AreaPickerWithCounty)) ? 3 :1;
//    NSInteger counter =0;
//    NSInteger pickerStyle = self.pickerStyle;
//    while (pickerStyle >0) {
//        counter ++;
//        pickerStyle = pickerStyle >> 1;
//    }
//    return counter;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (self.pickerStyle == (AreaPickerWithProvince | AreaPickerWithCity | AreaPickerWithCounty)) {
//        switch (component) {
//            case 0:
//            return busiSystem.areaManager.areas.count;
//            break;
//            case 1:
//            return busiSystem.areaManager.currentProvince.citys.count;
//            break;
//            case 2:
//            return busiSystem.areaManager.currentCity.countys.count;
//            break;
//            default:
//            return 0;
//        }
    }
    else {
//        return (self.pickerStyle == AreaPickerWithProvince) ? busiSystem.areaManager.areas.count : (self.pickerStyle == AreaPickerWithCity ? busiSystem.areaManager.currentProvince.citys.count : busiSystem.areaManager.currentCity.countys.count);
    }
    return 0;
}

//返回每一项值
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (self.pickerStyle == (AreaPickerWithProvince | AreaPickerWithCity | AreaPickerWithCounty)) {
//        switch (component) {
//            case 0:
//            return [[busiSystem.areaManager.areas objectAtIndex:row] provinceName];
//            break;
//            case 1:
//            return [[busiSystem.areaManager.currentProvince.citys objectAtIndex:row]cityName];
//            break;
//            case 2:
//            return [[busiSystem.areaManager.currentCity.countys objectAtIndex:row]countyName];
//            break;
//            default:
//            return 0;
//        }
    }
    else {
//        return (self.pickerStyle == AreaPickerWithProvince) ? [[busiSystem.areaManager.areas objectAtIndex:row] provinceName] : (self.pickerStyle == AreaPickerWithCity ? [[busiSystem.areaManager.currentProvince.citys objectAtIndex:row]cityName] : [[busiSystem.areaManager.currentCity.countys objectAtIndex:row]countyName]);
    }
    return @"";
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (self.pickerStyle == (AreaPickerWithProvince | AreaPickerWithCity | AreaPickerWithCounty)) {
        switch (component) {
            case 0:
//            busiSystem.areaManager.currentProvince = [busiSystem.areaManager.areas objectAtIndex:row];
//            self.labelSelected.text = busiSystem.areaManager.currentProvince.provinceName;
//            busiSystem.areaManager.currentCity = NULL;
//            busiSystem.areaManager.currentCounty = NULL;
            [self reloadData];
            [self.locatePicker selectRow:0 inComponent:1 animated:YES];
            [self.locatePicker selectRow:0 inComponent:2 animated:YES];
            break;
            case 1:
//            busiSystem.areaManager.currentCity = [busiSystem.areaManager.currentProvince.citys objectAtIndex:row];
//            self.labelSelected.text = [NSString stringWithFormat:@"%@ %@",busiSystem.areaManager.currentProvince.provinceName,busiSystem.areaManager.currentCity.cityName];
//            busiSystem.areaManager.currentCounty = NULL;
            [self reloadData];
            [self.locatePicker selectRow:0 inComponent:2 animated:YES];
            break;
            case 2:
//            busiSystem.areaManager.currentCounty = [busiSystem.areaManager.currentCity.countys objectAtIndex:row];
//            self.labelSelected.text = [NSString stringWithFormat:@"%@ %@ %@",busiSystem.areaManager.currentProvince.provinceName,busiSystem.areaManager.currentCity.cityName,busiSystem.areaManager.currentCounty.countyName];
            break;
            default:
            break;
        }
    }
    else {
        
//        switch (self.pickerStyle) {
//            case AreaPickerWithProvince:
//            busiSystem.areaManager.currentProvince = [busiSystem.areaManager.areas objectAtIndex:row];
//            self.labelSelected.text = busiSystem.areaManager.currentProvince.provinceName;
//            break;
//            case AreaPickerWithCity:
//            busiSystem.areaManager.currentCity = [busiSystem.areaManager.currentProvince.citys objectAtIndex:row];
//            self.labelSelected.text = [NSString stringWithFormat:@"%@",busiSystem.areaManager.currentCity.cityName];
//                break;
//            case AreaPickerWithCounty:
//            busiSystem.areaManager.currentCounty = [busiSystem.areaManager.currentCity.countys objectAtIndex:row];
//            self.labelSelected.text = [NSString stringWithFormat:@"%@",busiSystem.areaManager.currentCounty.countyName];
//            break;
//            default:
//            break;
//        }
    }
}


#pragma mark - animation

//- (void)showInView:(UIView *) view
//{
//    self.frame = CGRectMake(0, view.frame.size.height, self.frame.size.width, self.frame.size.height);
//    [view addSubview:self];
//    
//    [UIView animateWithDuration:0.3 animations:^{
//        self.frame = CGRectMake(0, view.frame.size.height - self.frame.size.height, self.frame.size.width, self.frame.size.height);
//    }];
//    
//}
//
//- (void)cancelPicker
//{
//    
//    [UIView animateWithDuration:0.3
//                     animations:^{
//                         self.frame = CGRectMake(0, self.frame.origin.y+self.frame.size.height, self.frame.size.width, self.frame.size.height);
//                     }
//                     completion:^(BOOL finished){
//                         [self removeFromSuperview];
//                         
//                     }];
//    
//}

@end
