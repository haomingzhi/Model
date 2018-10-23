//
//  BarCodeViewController.m
//  compassionpark
//
//  Created by air on 2017/4/11.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import "BarCodeViewController.h"
#import "BUSystem.h"
@interface BarCodeViewController ()
@property (strong, nonatomic) IBOutlet UIView *containerView;
@property (strong, nonatomic) IBOutlet UIImageView *imgV;
@property (strong, nonatomic) IBOutlet UIButton *closeBtn;
@property (strong, nonatomic) IBOutlet UILabel *titleLb;
@property (strong, nonatomic) IBOutlet UILabel *detailLb;

@end

@implementation BarCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
}

-(void)fitMode
{
    _containerView.width = 300;
    _containerView.height = 185;
    _containerView.x = __SCREEN_SIZE.width/2.0 - _containerView.width/2.0;
    _containerView.y = __SCREEN_SIZE.height/2.0 - _containerView.height/2.0;
    _containerView.layer.cornerRadius = 2;
    _containerView.layer.masksToBounds = YES;
    
    _closeBtn.x = _containerView.width - _closeBtn.width;
    _closeBtn.y = 0;
    _imgV.width = 220;
    _imgV.height = 100;
    _imgV.x = _containerView.width/2.0 - _imgV.width/2.0;
    _imgV.y = 50;
    busiSystem.agent.userInfo.payCodeImage.isValid = YES;
     [busiSystem.agent.userInfo.payCodeImage displayRemoteImage:_imgV imageName:@"xx"];
    
    
    
    
    _titleLb.text = @"付款码";
    _titleLb.y = 20;
    _titleLb.font = [UIFont systemFontOfSize:15];
    _titleLb.textColor = kUIColorFromRGB(color_1);
    _titleLb.height = 17;
    _titleLb.x = _containerView.width/2.0 - _titleLb.width/2.0;
    
    _detailLb.y = _imgV.y + _imgV.height + 10;
    _detailLb.font = [UIFont systemFontOfSize:12];
      _detailLb.textColor = kUIColorFromRGB(color_1);
    
    _detailLb.text = @"用于在实体店向商家付款时出示使用,每次结算后更新";
    _detailLb.width = 300;
    _detailLb.x = _containerView.width/2.0 - _detailLb.width/2.0;
    _detailLb.textAlignment = NSTextAlignmentCenter;
    _detailLb.font = [UIFont systemFontOfSize:12];
    self.view.backgroundColor = [UIColor clearColor];
    _containerView.backgroundColor = kUIColorFromRGB(color_4);
        self.view.backgroundColor = [UIColor clearColor];
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
static BarCodeViewController *bvc;
+(BarCodeViewController *)toBarCodeVC:(UIViewController *)parentVC
{
    BarCodeViewController *  bvc = [[BarCodeViewController alloc] initWithNibName:@"BarCodeViewController" bundle:nil];
    bvc.view.height = __SCREEN_SIZE.height;
    bvc.view.width = __SCREEN_SIZE.width;
    
    //    epvc->_pwdTf.text = @"";
    //   DealPasswordViewController *dealvc = [DealPasswordViewController new];
    MyDialog *myDialog = [[MyDialog alloc] initWithViewController:bvc];
    //    vc.view.width = __SCREEN_SIZE.width;
    //    vc.doneCallBack = ^(NSString *pwd){
    //        [weakSelf toAddwithdraw:pwd];
    //    };
    //    epvc.view.layer.cornerRadius = 8;
    //    epvc.view.layer.masksToBounds = YES;
    //    [epvc.passwordTf addTarget:dealvc action:@selector(changeValue:) forControlEvents:UIControlEventEditingChanged];
    bvc->_parentVC = parentVC;
    
    [myDialog show];
    [bvc fitMode];
    //    myDialog.dismissOnTouchOutside = YES;
    //    myDialog.isDownAnimate = YES;
    return bvc;
    
}
- (IBAction)closeHandel:(id)sender {
    [self.parentDialog cancel];
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
