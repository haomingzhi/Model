//
//  AddressSelectionViewController.m
//  rentingshop
//
//  Created by air on 2018/4/3.
//  Copyright © 2018年 ORANLLC_IOS1. All rights reserved.
//

#import "AddressSelectionViewController.h"

@interface AddressSelectionViewController ()
@property (weak, nonatomic) IBOutlet UIButton *doneBtn;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;
@property (weak, nonatomic) IBOutlet UILabel *lineLb;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;

@end

@implementation AddressSelectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self fitMode];
     [self initPickerView];
}

-(void)fitMode
{
    [_cancelBtn setTitleColor:kUIColorFromRGB(color_0xf74056) forState:UIControlStateNormal];
     [_doneBtn setTitleColor:kUIColorFromRGB(color_0xf74056) forState:UIControlStateNormal];
     _titleLb.textColor = kUIColorFromRGB(color_5);
    _lineLb.width = __SCREEN_SIZE.width;
    _lineLb.height = 0.5;
    _lineLb.backgroundColor = kUIColorFromRGB(color_lineColor);
     if(__SCREEN_SIZE.width == 320)
     {
          _doneBtn.x = __SCREEN_SIZE.width - 5 - _doneBtn.width;
          _titleLb.x = __SCREEN_SIZE.width/2.0 - _titleLb.width/2.0;
     }
}

-(void)initPickerView
{
    _pickerView.dataSource = self;
    _pickerView.delegate = self;

    _doneBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    _cancelBtn.titleLabel.font = [UIFont systemFontOfSize:16];
}
-(void)viewDidLayoutSubviews
{
    [_pickerView.subviews objectAtIndex:1].layer.borderWidth = 0.5f;

    [_pickerView.subviews objectAtIndex:2].layer.borderWidth = 0.5f;

    [_pickerView.subviews objectAtIndex:1].layer.borderColor = kUIColorFromRGB(color_lineColor).CGColor;

    [_pickerView.subviews objectAtIndex:2].layer.borderColor = kUIColorFromRGB(color_lineColor).CGColor;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)sureHandle:(id)sender {
    NSString *str1 = @"";
     NSString *str2 = @"";
     NSString *str3 = @"";

     NSString *id1 = @"";
     NSString *id2 = @"";
     NSString *id3 = @"";


    NSInteger ii = 0;
    if (_dataArr.count > 0) {

        ii = [_pickerView selectedRowInComponent:0];
        NSDictionary *dic = _dataArr[ii];
         str1 = dic[@"title"];
         id1 = dic[@"id"];
         NSArray *aar = dic[@"arr"];
       NSDictionary *dic2 = aar[[_pickerView selectedRowInComponent:1]];
         str2 = dic2[@"title"];
         id2 = dic2[@"id"];

         NSArray *abr = dic2[@"arr"];
         NSDictionary *dic3 = abr[[_pickerView selectedRowInComponent:2]];
         str3 = dic3[@"title"];
         id3 = dic3[@"id"];
    }

    [self.parentDialog dismiss];
    if (_handleAction) {
         _handleAction(@{@"title1":str1,@"id1":id1?:@"",@"title2":str2,@"id2":id2,@"title3":str3,@"id3":id3});
    }
}

- (IBAction)cancelHandle:(id)sender {
    [self.parentDialog cancel];
}
// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView;
{
    return 3;
}
// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
     if (component == 0) {
           return _dataArr.count;
     }
          else if (component == 1)
          {
               NSInteger ii = [_pickerView selectedRowInComponent:0];
               NSDictionary *dic = _dataArr[ii];
               NSArray *arr = dic[@"arr"];
               return arr.count;
          }
     else
     {
          NSInteger i = [_pickerView selectedRowInComponent:0];
          NSDictionary *dic = _dataArr[i];
          NSArray *arr = dic[@"arr"];

          NSInteger ii = [_pickerView selectedRowInComponent:1];
          NSDictionary *dic2 = arr[ii];
          NSArray *arr2 = dic2[@"arr"];
          return arr2.count;
     }
}
//- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(nullable UIView *)view {
//
//}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
     if (component == 0) {
             [_pickerView reloadComponent:1];
            [_pickerView reloadComponent:2];
     }
     else if (component == 1)
     {

     [_pickerView reloadComponent:2];
     }

}

- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
     if (component == 0) {

          NSDictionary *dic = _dataArr[row];
          return dic[@"title"];
     }
     else if (component == 1)
     {
          NSInteger ii = [_pickerView selectedRowInComponent:0];
          NSDictionary *dic = _dataArr[ii];
          NSArray *arr = dic[@"arr"];
          NSDictionary *dic2 = arr[row];
          return dic2[@"title"];
     }
     else
     {
          NSInteger i = [_pickerView selectedRowInComponent:0];
          NSDictionary *dic = _dataArr[i];
          NSArray *arr = dic[@"arr"];

          NSInteger ii = [_pickerView selectedRowInComponent:1];
          NSDictionary *dic2 = arr[ii];
          NSArray *arr2 = dic2[@"arr"];
          NSDictionary *dic3 = arr2[row];
          return dic3[@"title"];
     }
}
//- (nullable NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component
//{
//    NSString *str = _dataArr[row];
//    NSMutableAttributedString * aAttributedString = [[NSMutableAttributedString alloc] initWithString:str];
//
//
//    [aAttributedString addAttribute:NSForegroundColorAttributeName  //文字颜色
//                              value:kUIColorFromRGB(color_3)
//                              range:NSMakeRange(0,str.length)];
//
//    [aAttributedString addAttribute:NSFontAttributeName             //文字字体
//                              value:[UIFont systemFontOfSize:16]
//                              range:NSMakeRange(0, str.length)];
//
//
//    return aAttributedString;
//}
static AddressSelectionViewController *dealvc;
+(AddressSelectionViewController *)toAddressSelectionVC:(NSArray*)dataArr
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dealvc = [[AddressSelectionViewController alloc] init];

    });

    //   DealPasswordViewController *dealvc = [DealPasswordViewController new];
    MyDialog *myDialog = [[MyDialog alloc] initWithViewController:dealvc];
    dealvc.view.width = __SCREEN_SIZE.width;
     dealvc.view.height = __SCREEN_SIZE.height;
    //    vc.doneCallBack = ^(NSString *pwd){
    //        [weakSelf toAddwithdraw:pwd];
    //    };
    dealvc.dataArr = dataArr;
    [dealvc.pickerView reloadAllComponents];
    myDialog.mydelegate = dealvc;
    //    myDialog.bgColor = [UIColor clearColor];
    myDialog.isDownAnimate = NO;
//       [myDialog showAtPosition:CGPointMake(0, 0) animated:YES];
    [myDialog showAtPosition:CGPointMake(0, __SCREEN_SIZE.height - 210) animated:YES];
    myDialog.dismissOnTouchOutside = NO;


    return dealvc;

}

//-(void)setCurRow:(NSInteger)curRow
//{
//    _curRow = curRow;
//    [dealvc.pickerView selectRow:_curRow inComponent:0 animated:NO];
//
//}

@end
