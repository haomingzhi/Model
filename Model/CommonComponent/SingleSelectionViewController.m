//
//  SingleSelectionViewController.m
//  taihe
//
//  Created by air on 2016/11/18.
//  Copyright © 2016年 ORANLLC_IOS1. All rights reserved.
//

#import "SingleSelectionViewController.h"

@interface SingleSelectionViewController ()


@end

@implementation SingleSelectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initPickerView];
    [_cancelBtn setTitleColor:kUIColorFromRGB(color_3) forState:UIControlStateNormal];
    [_sureBtn setTitleColor:kUIColorFromRGB(color_3) forState:UIControlStateNormal];
    _sureBtn.x = __SCREEN_SIZE.width - 15 - _sureBtn.width;
    _cancelBtn.x = 15;
    _lineLb.width = __SCREEN_SIZE.width;
    _lineLb.height = 0.5;
    _lineLb.backgroundColor = kUIColorFromRGB(color_lineColor);
    _lineLb.y = 44;
}

-(void)initPickerView
{
    _pickerView.dataSource = self;
    _pickerView.delegate = self;

     _sureBtn.titleLabel.font = [UIFont systemFontOfSize:16];
     _cancelBtn.titleLabel.font = [UIFont systemFontOfSize:16];
}
-(void)viewDidLayoutSubviews
{
    [_pickerView.subviews objectAtIndex:1].layer.borderWidth = 0.5f;
    
    [_pickerView.subviews objectAtIndex:2].layer.borderWidth = 0.5f;
    
    [_pickerView.subviews objectAtIndex:1].layer.borderColor = kUIColorFromRGB(color_3).CGColor;
    
    [_pickerView.subviews objectAtIndex:2].layer.borderColor = kUIColorFromRGB(color_3).CGColor;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)sureHandle:(id)sender {
    NSString *str = @"";
    NSInteger ii = 0;
    if (_dataArr.count > 0) {
        
        ii = [_pickerView selectedRowInComponent:0];
         str = _dataArr[ii];
    }
   
    [self.parentDialog dismiss];
    if (_handleAction) {
        _handleAction(@{@"title":str,@"row":@(ii)});
    }
}

- (IBAction)cancelHandle:(id)sender {
    [self.parentDialog cancel];
}
// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView;
{
    return 1;
}
// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return _dataArr.count;
}
//- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(nullable UIView *)view {
//  
//}

//- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
//{
//
//}

//- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
//{
//    return _dataArr[row];
//}
- (nullable NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString *str = _dataArr[row];
    NSMutableAttributedString * aAttributedString = [[NSMutableAttributedString alloc] initWithString:str];
    
   
    [aAttributedString addAttribute:NSForegroundColorAttributeName  //文字颜色
                                   value:kUIColorFromRGB(color_3)
                                   range:NSMakeRange(0,str.length)];

        [aAttributedString addAttribute:NSFontAttributeName             //文字字体
                                        value:[UIFont systemFontOfSize:16]
                                         range:NSMakeRange(0, str.length)];
    
    
    return aAttributedString;
}
static SingleSelectionViewController *dealvc;
+(SingleSelectionViewController *)toSingleSelectionVC:(NSArray*)dataArr
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dealvc = [[SingleSelectionViewController alloc] init];
        
    });
    
    //   DealPasswordViewController *dealvc = [DealPasswordViewController new];
    MyDialog *myDialog = [[MyDialog alloc] initWithViewController:dealvc];
    dealvc.view.width = __SCREEN_SIZE.width;
    //    vc.doneCallBack = ^(NSString *pwd){
    //        [weakSelf toAddwithdraw:pwd];
    //    };
    dealvc.dataArr = dataArr;
    [dealvc.pickerView reloadAllComponents];
    myDialog.mydelegate = dealvc;
//    myDialog.bgColor = [UIColor clearColor];
    myDialog.isDownAnimate = NO;
    [myDialog showAtPosition:CGPointMake(0, __SCREEN_SIZE.height - 272) animated:YES];
    myDialog.dismissOnTouchOutside = NO;
  
    
    return dealvc;

}

-(void)setCurRow:(NSInteger)curRow
{
     _curRow = curRow;
  [dealvc.pickerView selectRow:_curRow inComponent:0 animated:NO];
   
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
