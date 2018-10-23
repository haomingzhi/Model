//
//  TwoSelectionViewController.m
//  oranllcshoping
//
//  Created by air on 2017/7/24.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import "TwoSelectionViewController.h"

@interface TwoSelectionViewController ()
{
     NSInteger _curCom;
}
@end

@implementation TwoSelectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(id)init
{
     self = [super initWithNibName:@"SingleSelectionViewController" bundle:nil];
     return self;
}

static TwoSelectionViewController *svc;

+(TwoSelectionViewController *)toSingleSelectionVC:(NSArray*)dataArr
{
     static dispatch_once_t onceToken;
     dispatch_once(&onceToken, ^{
          svc = [[TwoSelectionViewController alloc] init];
          
     });
     
     //   DealPasswordViewController *dealvc = [DealPasswordViewController new];
     MyDialog *myDialog = [[MyDialog alloc] initWithViewController:svc];
     svc.view.width = __SCREEN_SIZE.width;
     //    vc.doneCallBack = ^(NSString *pwd){
     //        [weakSelf toAddwithdraw:pwd];
     //    };
     svc.dataArr = dataArr;
     [svc.pickerView reloadAllComponents];
     myDialog.mydelegate = svc;
     //    myDialog.bgColor = [UIColor clearColor];
     myDialog.isDownAnimate = NO;
     [myDialog showAtPosition:CGPointMake(0, __SCREEN_SIZE.height - 272) animated:YES];
     myDialog.dismissOnTouchOutside = NO;
     
     
     return svc;
     
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView;
{
     return 2;
}
// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
//     if (component == 0) {
//          return self.dataArr.count;
//     }
//     else
//     {
//     return self.dataArr2.count;
//     }
     if (component == 0) {
          return self.dataArr.count;
     }
     else
     {
          NSDictionary *dic = self.dataArr[_curCom];
          NSArray *arr = dic[@"arr"];
          return arr.count;
     }
}

- (nullable NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component
{
     NSString *str ;
//     if (component == 0) {
//         str  = self.dataArr[row];
//     }
//     else
//     {
//          str = self.dataArr2[row];
//     }
     if (component == 0) {
          NSDictionary *dic = self.dataArr[row];
          str = dic[@"title"];
     }
     else
     {
          NSDictionary *dic = self.dataArr[_curCom];
          NSArray *arr = dic[@"arr"];
        str = arr[row];
     }
     NSMutableAttributedString * aAttributedString = [[NSMutableAttributedString alloc] initWithString:str];
     
     
     [aAttributedString addAttribute:NSForegroundColorAttributeName  //文字颜色
                               value:kUIColorFromRGB(color_3)
                               range:NSMakeRange(0,str.length)];
     
     [aAttributedString addAttribute:NSFontAttributeName             //文字字体
                               value:[UIFont systemFontOfSize:16]
                               range:NSMakeRange(0, str.length)];
     
     
     return aAttributedString;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
     if(component == 0)
     {
           _curCom = row;
      [self.pickerView reloadComponent:1];
     }
     else
     {
     self.curRow2 = row;
     }
}

-(void)setCurRow:(NSInteger)curRow
{
//     _curCom = curRow;
//     [self.pickerView selectRow:curRow inComponent:  self.curRow2  animated:NO];
     
}

-(void)setCurRow:(NSInteger)curRow withCom:(NSInteger )com
{
       self.curRow2 = curRow;
     _curCom = com;
     [self.pickerView selectRow:curRow inComponent:com animated:NO];
     
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
