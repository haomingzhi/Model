//
//  CheckCityViewController.m
//  compassionpark
//
//  Created by air on 2017/3/31.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import "CheckCityViewController.h"
#import "BUSystem.h"
@implementation CheckCityViewController

//-(void)fitMode
//{
//    [super fitMode];
//    
//}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView;
{
    return 1;
}
- (nullable NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    
    
    
    BUBespokeCity *city = self.dataArr[row];
    NSString *str = city.name;
        NSMutableAttributedString * aAttributedString = [[NSMutableAttributedString alloc] initWithString:str];
        
        
        [aAttributedString addAttribute:NSForegroundColorAttributeName  //文字颜色
                                  value:kUIColorFromRGB(color_1)
                                  range:NSMakeRange(0,str.length)];
        
        [aAttributedString addAttribute:NSFontAttributeName             //文字字体
                                  value:[UIFont systemFontOfSize:16]
                                  range:NSMakeRange(0, str.length)];
        return aAttributedString;
    
    
    
    
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
}

- (void)doneHandle:(id)sender {
    //    NSString *str = @"";
         
    
    if (self.handleAction) {
        self.handleAction(@{@"row":@([self.areaPv selectedRowInComponent:0])});
        
    }
    [self.parentDialog dismiss];
}

-(id)init
{
    self = [super initWithNibName:@"EditAreaViewController" bundle:nil];
    return self;
}

static CheckCityViewController *cvc;
+(CheckCityViewController *)toEditAreaVC:(NSArray*)dataArr
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        cvc = [[CheckCityViewController alloc] init];
        
    });
    
    //   DealPasswordViewController *dealvc = [DealPasswordViewController new];
    MyDialog *myDialog = [[MyDialog alloc] initWithViewController:cvc];
    cvc.view.width = __SCREEN_SIZE.width;
    //    vc.doneCallBack = ^(NSString *pwd){
    //        [weakSelf toAddwithdraw:pwd];
    //    };
    cvc.dataArr = dataArr;
    [cvc.areaPv reloadAllComponents];
    myDialog.mydelegate = cvc;
    //    myDialog.bgColor = [UIColor clearColor];
    myDialog.isDownAnimate = NO;
    [myDialog showAtPosition:CGPointMake(0, __SCREEN_SIZE.height - 222) animated:YES];
    myDialog.dismissOnTouchOutside = YES;
    
    
    return cvc;
    
}
@end
