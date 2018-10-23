//
//  EditPriceViewController.m
//  compassionpark
//
//  Created by air on 2017/4/10.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import "EditPriceViewController.h"

@interface EditPriceViewController ()
@property (strong, nonatomic) IBOutlet UILabel *titleLb;
@property (strong, nonatomic) IBOutlet UILabel *detailLb;
@property (strong, nonatomic) IBOutlet UIButton *canCelBtn;
@property (strong, nonatomic) IBOutlet UIButton *suerBtn;
@property (strong, nonatomic) IBOutlet UILabel *vLineLb;
@property (strong, nonatomic) IBOutlet UIView *containerView;
@property (strong, nonatomic) IBOutlet UITextField *textTf;
@property(strong,nonatomic)UITapGestureRecognizer *tapGr;
@property (strong, nonatomic) IBOutlet UILabel *hLineLb;
@end

@implementation EditPriceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
}

-(void)fitMode
{
    _containerView.width = 260;
    _containerView.height = 154;
    self.titleLb.text = @"修改价格";;
    self.detailLb.text = @"共计";
    self.view.backgroundColor = [UIColor clearColor];
    _containerView.backgroundColor = kUIColorFromRGB(color_4);
    _textTf.layer.borderColor = kUIColorFromRGB(color_5).CGColor;
    _textTf.layer.borderWidth = 0.5;
    _textTf.layer.cornerRadius = 2;
    _textTf.layer.masksToBounds = YES;
    _textTf.keyboardType = UIKeyboardTypeDecimalPad;
    _textTf.width = 153;
    _textTf.height = 35;
    _textTf.y = 51;
    _textTf.x = 52;
    UIView *v = [UIView new];
    v.height = 2;
    v.width = 12;
    _textTf.leftView = v;
    _textTf.leftViewMode = UITextFieldViewModeAlways;
    _titleLb.textColor = kUIColorFromRGB(color_1);
    _titleLb.font = [UIFont systemFontOfSize:16];
    
    _detailLb.textColor = kUIColorFromRGB(color_1);
    _detailLb.font = [UIFont systemFontOfSize:15];
    _detailLb.x = 10;
    _detailLb.y = 51;
    _detailLb.height = 35;
    
    _hLineLb.height = 0.5;
    _hLineLb.backgroundColor = kUIColorFromRGB(color_mainTheme);
    _hLineLb.width = 260;
    _vLineLb.x = 130;
    _vLineLb.width = 0.5;
    _vLineLb.backgroundColor = kUIColorFromRGB(color_mainTheme);
    [_canCelBtn setTitleColor:kUIColorFromRGB(color_mainTheme) forState:UIControlStateNormal];
    [_canCelBtn setTitle:@"取消" forState:UIControlStateNormal];
    _canCelBtn.height = 44;
    _canCelBtn.y = 110;
    [_suerBtn setTitleColor:kUIColorFromRGB(color_mainTheme) forState:UIControlStateNormal];
    [_suerBtn setTitle:@"确认改进并接单" forState:UIControlStateNormal];
    _suerBtn.y = 110;
    _suerBtn.height = 44;
    _containerView.x = __SCREEN_SIZE.width/2.0 - _containerView.width/2.0;
    _containerView.y = __SCREEN_SIZE.height/2.0 - _containerView.height/2.0;
    _containerView.layer.cornerRadius = 8;
   _containerView.layer.masksToBounds = YES;
    if (!_tapGr) {
        _tapGr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    }
    self.view.userInteractionEnabled = YES;
    [ self.view addGestureRecognizer:_tapGr];
 }

-(void)tap:(UITapGestureRecognizer *)tap
{
//    [ self.view removeGestureRecognizer:_tapGr];
    [self.view endEditing:YES];
}
-(void)dealloc
{
 [ self.view removeGestureRecognizer:_tapGr];
    _tapGr = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

static EditPriceViewController *epvc;
+(EditPriceViewController *)toEditPriceVC:(UIViewController *)parentVC;
{
    EditPriceViewController *  epvc = [[EditPriceViewController alloc] init];
    epvc.view.height = __SCREEN_SIZE.height;
    epvc.view.width = __SCREEN_SIZE.width;
    
//    epvc->_pwdTf.text = @"";
    //   DealPasswordViewController *dealvc = [DealPasswordViewController new];
    MyDialog *myDialog = [[MyDialog alloc] initWithViewController:epvc];
    //    vc.view.width = __SCREEN_SIZE.width;
    //    vc.doneCallBack = ^(NSString *pwd){
    //        [weakSelf toAddwithdraw:pwd];
    //    };
    epvc.view.layer.cornerRadius = 8;
    epvc.view.layer.masksToBounds = YES;
//    [epvc.passwordTf addTarget:dealvc action:@selector(changeValue:) forControlEvents:UIControlEventEditingChanged];
    epvc->_parentVC = parentVC;
   
    [myDialog show];
     [epvc fitMode];
    //    myDialog.dismissOnTouchOutside = YES;
//    myDialog.isDownAnimate = YES;
    return epvc;

}
- (IBAction)cancelHandle:(id)sender {
    [self.parentDialog cancel];
}

- (IBAction)sureHandle:(id)sender {
    if (self.handleAction) {
        self.handleAction(@{@"price":_textTf.text});
    }
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
