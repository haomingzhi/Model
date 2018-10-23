//
//  AddGoodsNumberViewController.m
//  compassionpark
//
//  Created by Steve on 2017/2/3.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import "AddGoodsNumberViewController.h"
#import "AppDelegate.h"

@interface AddGoodsNumberViewController (){
     UIViewController *_pVC;
}

@end

@implementation AddGoodsNumberViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _titleLb.text = @"购买数量";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)sureAction:(UIButton *)sender {
    if (self.callBack) {
        self.callBack(@{@"number":_textField.text});
        _pVC.view.userInteractionEnabled = YES;
        [self.parentDialog dismiss];
    }
}

- (IBAction)reduceAction:(UIButton *)sender {
    NSInteger index  = [_textField.text integerValue];
    index --;
    _textField.text = [NSString stringWithFormat:@"%ld",(long)index];
}

- (IBAction)addAction:(UIButton *)sender {
    NSInteger index  = [_textField.text integerValue];
    index ++;
    _textField.text = [NSString stringWithFormat:@"%ld",(long)index];
    
}

- (IBAction)deleteAction:(UIButton *)sender {
    _pVC.view.userInteractionEnabled = YES;
    [self.parentDialog hide];
}


static AddGoodsNumberViewController *typevc;
+(AddGoodsNumberViewController *)createVC:(UIViewController *)parentVC
{
    //    static dispatch_once_t onceToken;
    //    dispatch_once(&onceToken, ^{
    typevc = [[AddGoodsNumberViewController alloc] init];
    //        typevc.dataArr = dataArr;
    //        [typevc.collectionView reloadData];
    //    });
    
    //    typevc.dataArr = dataArr;
    //    [typevc.collectionView reloadData];
    //   DealPasswordViewController *dealvc = [DealPasswordViewController new];
    MyDialog *myDialog = [[MyDialog alloc] initWithViewController:typevc];
    typevc.view.width = 135;//__SCREEN_SIZE.width;
    //    vc.doneCallBack = ^(NSString *pwd){
    //        [weakSelf toAddwithdraw:pwd];
    //    };
    //    myDialog.mydelegate = typevc;
    //    myDialog.bgColor = [UIColor clearColor];
    typevc->_pVC = parentVC;
    myDialog.hasKeyboard = YES;
//    myDialog.kbRect = [(AppDelegate *)[UIApplication sharedApplication].delegate kbRect];
    myDialog.outsideHitCallBack = ^(id o){
        [typevc.view endEditing:YES];
        typevc.view.y = __SCREEN_SIZE.height - typevc.view.height;
    };
    myDialog.isDownAnimate = NO;
    //    [myDialog showAtPosition:CGPointMake(0, 44 + 64) animated:NO];
    myDialog.dismissOnTouchOutside = YES;
    [myDialog show];
    parentVC.view.userInteractionEnabled = NO;
    return typevc;
    
}

-(void)fitVCMode{
    
    self.view.backgroundColor = kUIColorFromRGB(color_4);
    self.view.height = 135;
    self.view.width = __SCREEN_SIZE.width;
    self.view.x = 0;
    self.view.y = __SCREEN_SIZE.height - self.view.height;
    _textField.keyboardType = UIKeyboardTypeNumberPad;
    _textField.delegate = self;
    
    _deleteBtn.x  = __SCREEN_SIZE.width - 15 -_deleteBtn.width;
    _deleteBtn.y = 10;
    
    _addBtn.width = 37;
    _addBtn.height = 35;
    _addBtn.x = __SCREEN_SIZE.width-15-_addBtn.width;
    _addBtn.y = 39;
    _addBtn.layer.borderColor = kUIColorFromRGB(color_8).CGColor;
    _addBtn.layer.borderWidth = 0.5;
    [_addBtn setTitleColor:kUIColorFromRGB(color_7) forState:UIControlStateNormal];
    
    _textField.width = 80;
    _textField.height = 35;
    _textField.x = _addBtn.x+0.5-_textField.width;
    _textField.y = 39;
    _textField.layer.borderColor = kUIColorFromRGB(color_8).CGColor;
    _textField.layer.borderWidth = 0.5;
    
    _reduceBtn.width = 37;
    _reduceBtn.height = 35;
    _reduceBtn.x = _textField.x+0.5-_reduceBtn.width;
    _reduceBtn.y = 39;
    _reduceBtn.layer.borderColor = kUIColorFromRGB(color_8).CGColor;
    _reduceBtn.layer.borderWidth = 0.5;
    [_reduceBtn setTitleColor:kUIColorFromRGB(color_7) forState:UIControlStateNormal];
    
    _line.hidden = YES;
    
    _titleLb.x = 15;
    _titleLb.y = 48;
    _titleLb.textColor = kUIColorFromRGB(color_7);
    
    
    _sureBtn.x = 0 ;
    _sureBtn.y = 135 -44;
    _sureBtn.width = __SCREEN_SIZE.width;
    _sureBtn.height = 44;
    [_sureBtn setTitleColor:kUIColorFromRGB(color_5) forState:UIControlStateNormal];
    [_sureBtn setBackgroundColor:kUIColorFromRGB(color_3)];
    
    
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    self.view.y = __SCREEN_SIZE.height - self.view.height-216;
    _sureBtn.hidden = YES;
    return YES;
}


-(BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    NSInteger index = [textField.text integerValue];
    if (index>_maxNumber) {
        TOASTSHOW(@"超过库存");
        textField.text = [NSString stringWithFormat:@"%ld",_maxNumber];
    }
    self.sureBtn.hidden = NO;
    return YES;
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
