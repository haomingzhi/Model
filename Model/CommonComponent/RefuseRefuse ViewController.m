//
//  RefuseRefuse ViewController.m
//  compassionpark
//
//  Created by air on 2017/4/10.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import "RefuseRefuse ViewController.h"
#import "SheetOptionViewController.h"
@interface RefuseRefuse_ViewController ()
@property (strong, nonatomic) IBOutlet UIView *containerView;
@property (strong, nonatomic) IBOutlet UILabel *titleLb;
@property (strong, nonatomic) IBOutlet UIButton *cancelBtn;
@property (strong, nonatomic) IBOutlet UIButton *sureBtn;
@property (strong, nonatomic) IBOutlet UILabel *hLineLb;
@property (strong, nonatomic) IBOutlet UILabel *vLineLb;
@property (strong, nonatomic) IBOutlet UIButton *checkBtn;
@property (strong, nonatomic)NSString *msg;
@end

@implementation RefuseRefuse_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void)fitMode
{
    _containerView.width = 260;
    _containerView.height = 154;
    self.titleLb.text = @"选择拒绝原因";;

    self.view.backgroundColor = [UIColor clearColor];
    _containerView.backgroundColor = kUIColorFromRGB(color_4);
    _checkBtn.layer.borderColor = kUIColorFromRGB(color_5).CGColor;
    _checkBtn.layer.borderWidth = 0.5;
    _checkBtn.layer.cornerRadius = 2;
    _checkBtn.layer.masksToBounds = YES;
    _checkBtn.width = 153;
    _checkBtn.height = 35;
    _checkBtn.y = 51;
    _checkBtn.x = 52;
 
    _titleLb.textColor = kUIColorFromRGB(color_1);
    _titleLb.font = [UIFont systemFontOfSize:16];

    
    _hLineLb.height = 0.5;
    _hLineLb.backgroundColor = kUIColorFromRGB(color_mainTheme);
    _hLineLb.width = 260;
    _vLineLb.x = 130;
    _vLineLb.width = 0.5;
    _vLineLb.backgroundColor = kUIColorFromRGB(color_mainTheme);
    [_cancelBtn setTitleColor:kUIColorFromRGB(color_mainTheme) forState:UIControlStateNormal];
    [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    _cancelBtn.height = 44;
    _cancelBtn.y = 110;
    [_sureBtn setTitleColor:kUIColorFromRGB(color_mainTheme) forState:UIControlStateNormal];
    [_sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    _sureBtn.y = 110;
    _sureBtn.height = 44;
    _containerView.x = __SCREEN_SIZE.width/2.0 - _containerView.width/2.0;
    _containerView.y = __SCREEN_SIZE.height/2.0 - _containerView.height/2.0;
    _containerView.layer.cornerRadius = 8;
    _containerView.layer.masksToBounds = YES;
    _checkBtn.layer.cornerRadius = 4;
    _checkBtn.layer.masksToBounds = YES;
    _checkBtn.layer.borderWidth = 0.5;
    _checkBtn.layer.borderColor = kUIColorFromRGB(color_5).CGColor;
    [_checkBtn setTitleColor:kUIColorFromRGB(color_1) forState:UIControlStateNormal];
    [_checkBtn setTitle:@"" forState:UIControlStateNormal];
    _checkBtn.customTitleLb.font = [UIFont systemFontOfSize:14];
    _checkBtn.customImgV.image = [UIImage imageContentWithFileName:@"more_down"];
    _checkBtn.customTitleLb.x = 130;
    _checkBtn.customTitleLb.text = @"价格未谈妥";
    _checkBtn.customTitleLb.x = 10;
    _checkBtn.customTitleLb.width = 125;
}

static RefuseRefuse_ViewController *rrvc;
+(RefuseRefuse_ViewController *)toRefuseVC:(UIViewController *)parentVC;
{
    RefuseRefuse_ViewController *  rrvc = [[RefuseRefuse_ViewController alloc] initWithNibName:@"RefuseRefuse ViewController" bundle:nil];
    rrvc.view.height = __SCREEN_SIZE.height;
    rrvc.view.width = __SCREEN_SIZE.width;
    
    //    epvc->_pwdTf.text = @"";
    //   DealPasswordViewController *dealvc = [DealPasswordViewController new];
    MyDialog *myDialog = [[MyDialog alloc] initWithViewController:rrvc];
    //    vc.view.width = __SCREEN_SIZE.width;
    //    vc.doneCallBack = ^(NSString *pwd){
    //        [weakSelf toAddwithdraw:pwd];
    //    };
//    epvc.view.layer.cornerRadius = 8;
//    epvc.view.layer.masksToBounds = YES;
    //    [epvc.passwordTf addTarget:dealvc action:@selector(changeValue:) forControlEvents:UIControlEventEditingChanged];
    rrvc->_parentVC = parentVC;
    
    [myDialog show];
    [rrvc fitMode];
    //    myDialog.dismissOnTouchOutside = YES;
    //    myDialog.isDownAnimate = YES;
    return rrvc;
    
}
- (IBAction)sureBtnHandle:(id)sender {
    if(self.handleAction)
    {
        self.handleAction(@{@"msg":self.msg});
    }
}
- (IBAction)cancelBtnHandle:(id)sender {
    [self.parentDialog cancel];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)showCheckItem:(id)sender {
    __weak RefuseRefuse_ViewController *weakSelf = self;
 SheetOptionViewController  *vc = [SheetOptionViewController createVC:self];
    [vc fitMode];
    vc.callBack = ^(NSDictionary *dic){
        weakSelf.msg = dic[@"title"];
        _checkBtn.customTitleLb.text = weakSelf.msg;
//        [weakSelf.checkBtn setTitle:weakSelf.msg forState:UIControlStateNormal];
        if (weakSelf.msg.length > 10) {
            weakSelf.checkBtn.customTitleLb.font = [UIFont systemFontOfSize:12];
        }
        else
        {
         weakSelf.checkBtn.customTitleLb.font = [UIFont systemFontOfSize:14];
        }
    };
    
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
