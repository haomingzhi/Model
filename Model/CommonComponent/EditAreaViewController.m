//
//  EditAreaViewController.m
//  compassionpark
//
//  Created by air on 2017/3/30.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import "EditAreaViewController.h"
#import "BUSystem.h"
@interface EditAreaViewController ()<MyDialogDelegate,UIPickerViewDataSource,UIPickerViewDelegate>
@property (strong, nonatomic) IBOutlet UILabel *lineLb;
@property (strong, nonatomic) IBOutlet UIButton *sureBtn;
@property (strong, nonatomic) IBOutlet UIButton *cancelBtn;


@end

@implementation EditAreaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initPickerView];
    [self fitMode];
    }

-(void)fitMode
{
    _lineLb.backgroundColor = kUIColorFromRGB(color_mainTheme);
    _lineLb.height = 0.5;
    _lineLb.y = 43.5;
    [_sureBtn setTitleColor:kUIColorFromRGB(color_mainTheme) forState:UIControlStateNormal];
    [_cancelBtn setTitleColor:kUIColorFromRGB(color_8) forState:UIControlStateNormal];
    _lineLb.width = __SCREEN_SIZE.width;
//    self.view.backgroundColor = kUIColorFromRGB(color_4);
    _sureBtn.x = __SCREEN_SIZE.width - 15 - _sureBtn.width;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidLayoutSubviews
{
    [_areaPv.subviews objectAtIndex:1].layer.borderWidth = 0.5f;
    
    [_areaPv.subviews objectAtIndex:2].layer.borderWidth = 0.5f;
    
    [_areaPv.subviews objectAtIndex:1].layer.borderColor = kUIColorFromRGB(color_3).CGColor;
    
    [_areaPv.subviews objectAtIndex:2].layer.borderColor = kUIColorFromRGB(color_3).CGColor;
}


-(void)initPickerView
{
    _areaPv.dataSource = self;
    _areaPv.delegate = self;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView;
{
    return 3;
}
// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if(component == 0)
    {
        
        
        return _dataArr.count;
    }
    else if (component == 1)
    {
        NSInteger sr = [_areaPv selectedRowInComponent:0];
        BUprovince *pro = _dataArr[sr];
        
        
        return pro.child.count;
    }
    else
    {
        NSInteger sr = [_areaPv selectedRowInComponent:0];
        BUprovince *pro = _dataArr[sr];
        NSInteger csr = [_areaPv selectedRowInComponent:1];
        BUCity *ct = pro.child[csr];
        
        
        return ct.child.count;
    }
}
- (nullable NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component
{
   
    if(component == 0)
    {
         BUprovince *pro = _dataArr[row];
        NSString *str = pro.region_name;
    NSMutableAttributedString * aAttributedString = [[NSMutableAttributedString alloc] initWithString:str];
    
    
    [aAttributedString addAttribute:NSForegroundColorAttributeName  //文字颜色
                              value:kUIColorFromRGB(color_1)
                              range:NSMakeRange(0,str.length)];
    
    [aAttributedString addAttribute:NSFontAttributeName             //文字字体
                              value:[UIFont systemFontOfSize:16]
                              range:NSMakeRange(0, str.length)];
           return aAttributedString;
    }
    else if (component == 1)
    {
        NSInteger sr = [_areaPv selectedRowInComponent:0];
         BUprovince *pro = _dataArr[sr];
      BUCity *ct = pro.child[row];
        NSString *str = ct.region_name;
        NSMutableAttributedString * aAttributedString = [[NSMutableAttributedString alloc] initWithString:str];
        
        
        [aAttributedString addAttribute:NSForegroundColorAttributeName  //文字颜色
                                  value:kUIColorFromRGB(color_1)
                                  range:NSMakeRange(0,str.length)];
        
        [aAttributedString addAttribute:NSFontAttributeName             //文字字体
                                  value:[UIFont systemFontOfSize:16]
                                  range:NSMakeRange(0, str.length)];
           return aAttributedString;
    }
    else
    {
        NSInteger sr = [_areaPv selectedRowInComponent:0];
        BUprovince *pro = _dataArr[sr];
        NSInteger csr = [_areaPv selectedRowInComponent:1];
        BUCity *ct = pro.child[csr];
      BUCounty *co = ct.child[row];
        NSString *str = co.region_name;
        NSMutableAttributedString * aAttributedString = [[NSMutableAttributedString alloc] initWithString:str];
        
        
        [aAttributedString addAttribute:NSForegroundColorAttributeName  //文字颜色
                                  value:kUIColorFromRGB(color_1)
                                  range:NSMakeRange(0,str.length)];
        
        [aAttributedString addAttribute:NSFontAttributeName             //文字字体
                                  value:[UIFont systemFontOfSize:16]
                                  range:NSMakeRange(0, str.length)];
           return aAttributedString;
    }
    
    
 
}



- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
  if(component == 0)
  {
      [_areaPv reloadComponent:1];
      [_areaPv reloadComponent:2];
  }
    else if (component == 1)
    {
    [_areaPv reloadComponent:2];
    }
}

static EditAreaViewController *evc;
+(EditAreaViewController *)toEditAreaVC:(NSArray*)dataArr
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        evc = [[EditAreaViewController alloc] init];
        
    });
    
    //   DealPasswordViewController *dealvc = [DealPasswordViewController new];
    MyDialog *myDialog = [[MyDialog alloc] initWithViewController:evc];
    evc.view.width = __SCREEN_SIZE.width;
    //    vc.doneCallBack = ^(NSString *pwd){
    //        [weakSelf toAddwithdraw:pwd];
    //    };
    evc.dataArr = dataArr;
    [evc.areaPv reloadAllComponents];
    myDialog.mydelegate = evc;
    //    myDialog.bgColor = [UIColor clearColor];
    myDialog.isDownAnimate = NO;
    [myDialog showAtPosition:CGPointMake(0, __SCREEN_SIZE.height - 222) animated:YES];
    myDialog.dismissOnTouchOutside = YES;
    
    
    return evc;
    
}

-(void)setCurRow:(NSInteger)curRow
{
//    _curRow = curRow;
//    [dealvc.pickerView selectRow:_curRow inComponent:0 animated:NO];
   
}
- (IBAction)cancelHandle:(id)sender {
    [self.parentDialog cancel];
}
- (IBAction)doneHandle:(id)sender {
//    NSString *str = @"";
    NSInteger ii = 0;
    NSString *areaName = @"";
    NSString *areaId = @"";
    NSString *provinceName = @"";
    NSString *provinceId = @"";
    NSString *cityId = @"";
    NSString *cityName = @"";
    if (_dataArr.count > 0) {
        
        ii = [_areaPv selectedRowInComponent:0];
       BUprovince *pro = _dataArr[ii];
        provinceName = pro.region_name;
        provinceId = pro.region_id;
       NSInteger iii = [_areaPv selectedRowInComponent:1];
      BUCity *ct = pro.child[iii];
        cityId = ct.region_id;
        cityName = ct.region_name;
       NSInteger iiii = [_areaPv selectedRowInComponent:2];
       BUCounty *co = ct.child[iiii];
        areaId = co.region_id;
        areaName = co.region_name;
//        str = _dataArr[ii];
       
    }
    
    if (_handleAction) {
        _handleAction(@{@"areaName":areaName,@"areaId":areaId,@"provinceName":provinceName,@"provinceId":provinceId,@"cityId":cityId,@"cityName":cityName});
        
    }
    [self.parentDialog dismiss];
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
