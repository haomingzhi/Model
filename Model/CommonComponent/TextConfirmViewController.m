//
//  TextConfirmViewController.m
//  taihe
//
//  Created by air on 2016/12/6.
//  Copyright © 2016年 ORANLLC_IOS1. All rights reserved.
//

#import "TextConfirmViewController.h"
#import "AppDelegate.h"
@interface TextConfirmViewController ()
{
    IBOutlet UILabel *_vLineLb;

    IBOutlet UILabel *_tipLb;
    IBOutlet UILabel *_hLineLb;
    IBOutlet UIButton *_sureBtn;
    IBOutlet UIButton *_cancelBtn;
    UIViewController *_pVC;
}



@end

@implementation TextConfirmViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _tipLb.textColor = kUIColorFromRGB(color_1);
    _vLineLb.width = 0.5;
    _vLineLb.backgroundColor = kUIColorFromRGB(color_lineColor);
    
    _hLineLb.height = 0.5;
    _hLineLb.backgroundColor = kUIColorFromRGB(color_lineColor);
    
    [_cancelBtn setTitleColor:kUIColorFromRGB(color_7) forState:UIControlStateNormal];
    [_sureBtn setTitleColor:kUIColorFromRGB(color_3) forState:UIControlStateNormal];
    _textView.layer.borderColor = kUIColorFromRGB(color_lineColor).CGColor;
    _textView.layer.borderWidth = 0.5;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)cancelHandle:(id)sender {
    [self.parentDialog cancel];
    _pVC.view.userInteractionEnabled = YES;
}

- (IBAction)sureHandle:(id)sender {
    if (_callBack) {
        _callBack(@{@"title":_textView.text});
    }
      [self.parentDialog dismiss];
     _pVC.view.userInteractionEnabled = YES;
}

static TextConfirmViewController *typevc;
+(TextConfirmViewController *)createVC:(UIViewController *)parentVC
{
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
        typevc = [[TextConfirmViewController alloc] init];
//        typevc.dataArr = dataArr;
//        [typevc.collectionView reloadData];
//    });
    
    //    typevc.dataArr = dataArr;
    //    [typevc.collectionView reloadData];
    //   DealPasswordViewController *dealvc = [DealPasswordViewController new];
    MyDialog *myDialog = [[MyDialog alloc] initWithViewController:typevc];
    typevc.view.width = 260;//__SCREEN_SIZE.width;
    //    vc.doneCallBack = ^(NSString *pwd){
    //        [weakSelf toAddwithdraw:pwd];
    //    };
//    myDialog.mydelegate = typevc;
//    myDialog.bgColor = [UIColor clearColor];
    typevc->_pVC = parentVC;
    myDialog.hasKeyboard = YES;
    myDialog.kbRect = [(AppDelegate *)[UIApplication sharedApplication].delegate kbRect];
    myDialog.outsideHitCallBack = ^(id o){
        [typevc.view endEditing:YES];
    };
    myDialog.isDownAnimate = NO;
//    [myDialog showAtPosition:CGPointMake(0, 44 + 64) animated:NO];
    myDialog.dismissOnTouchOutside = YES;
    [myDialog show];
    typevc.textView.kbMovingView = typevc.view;
    typevc.view.layer.cornerRadius = 6;
    typevc.view.layer.masksToBounds = YES;
      parentVC.view.userInteractionEnabled = NO;
    return typevc;

}

-(void)fitMode
{
    _tipLb.hidden = YES;
    _textView.hidden = YES;
    MyTextField *txtTf = [MyTextField new];
    txtTf.x = 15;
    txtTf.width = 230;
    txtTf.placeholder = @"请输入修改后的价格";
    txtTf.textAlignment = NSTextAlignmentLeft;
    txtTf.borderStyle = UITextBorderStyleNone;
    txtTf.layer.borderColor = kUIColorFromRGB(color_lineColor).CGColor;
    txtTf.layer.borderWidth = 0.5;
    txtTf.kbMovingView = self.view;
    txtTf.delegate = self;
    txtTf.height = 40;
    txtTf.y = 35;
    txtTf.keyboardType = UIKeyboardTypeDecimalPad;
    self.view.height = 154;
    _hLineLb.y = 110;
    _vLineLb.y = 110;
    _cancelBtn.y = 117;
    _sureBtn.y = 117;
    [self.view addSubview:txtTf];
    [txtTf addTarget:self action:@selector(changeValue:) forControlEvents:UIControlEventEditingChanged];
}



-(void)changeValue:(MyTextField *)txt
{
    txt.text = [txt.text substringToIndex:MIN(9, txt.text.length)];
    _textView.text = txt.text;
}

-(void)viewWillDisappear:(BOOL)animated
{
_textView.text = @"";
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
