//
//  SheetOptionViewController.m
//  taihe
//
//  Created by air on 2016/12/6.
//  Copyright © 2016年 ORANLLC_IOS1. All rights reserved.
//

#import "SheetOptionViewController.h"

@interface SheetOptionViewController ()
{
    IBOutlet UILabel *_lineLb1;
    IBOutlet UIButton *_btnA;

    IBOutlet UILabel *_lineLb3;
    IBOutlet UILabel *_lineLb2;
    IBOutlet UILabel *_tipLb;
    IBOutlet UIButton *_sureBtn;
    IBOutlet UIButton *_notSureBtn;
    IBOutlet UIButton *_cancelBtn;
}
@end

@implementation SheetOptionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _lineLb1.height = 0.5;
    _lineLb1.backgroundColor = kUIColorFromRGB(color_lineColor);
    
    _lineLb2.height = 0.5;
    _lineLb2.backgroundColor = kUIColorFromRGB(color_lineColor);
    
    _lineLb3.height = 0.5;
    _lineLb3.backgroundColor = kUIColorFromRGB(color_lineColor);
    
    _tipLb.textColor = kUIColorFromRGB(color_1);
    
    [_sureBtn setTitleColor:kUIColorFromRGB(color_3) forState:UIControlStateNormal];
    [_notSureBtn setTitleColor:kUIColorFromRGB(color_3) forState:UIControlStateNormal];
    [_cancelBtn setTitleColor:kUIColorFromRGB(color_7) forState:UIControlStateNormal];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)handleAction:(UIButton *)btn {
    if (_callBack ) {
        _callBack (@{@"title":btn.titleLabel.text,@"obj":btn});
    }
    UIButton *b = btn;
    if (b.tag == 999) {
        [self.parentDialog cancel];
        return;
    }
    [self.parentDialog dismiss];
}

static SheetOptionViewController *typevc;
+(SheetOptionViewController *)createVC:(UIViewController *)parentVC
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        typevc = [[SheetOptionViewController alloc] init];
        //        typevc.dataArr = dataArr;
        //        [typevc.collectionView reloadData];
    });
    
    //    typevc.dataArr = dataArr;
    //    [typevc.collectionView reloadData];
    //   DealPasswordViewController *dealvc = [DealPasswordViewController new];
    MyDialog *myDialog = [[MyDialog alloc] initWithViewController:typevc];
    typevc.view.width = 200;//__SCREEN_SIZE.width;
    //    vc.doneCallBack = ^(NSString *pwd){
    //        [weakSelf toAddwithdraw:pwd];
    //    };
    //    myDialog.mydelegate = typevc;
        myDialog.bgColor = [UIColor clearColor];
    myDialog.isDownAnimate = NO;
        [myDialog showAtPosition:CGPointMake(__SCREEN_SIZE.width/2, 260) animated:NO];
        myDialog.dismissOnTouchOutside = YES;
//    [myDialog show];
    typevc.view.layer.cornerRadius = 6;
    typevc.view.layer.masksToBounds = YES;
    return typevc;
    
}

-(void)fitMode
{
    self.view.height = 176;
    _tipLb.hidden = YES;
    _btnA.x = 0;
    _btnA.y = 0;
    _btnA.width = 200;
    _lineLb1.y = 44;
    _lineLb2.y = 88;
    _lineLb3.y = 132;
    _sureBtn.y = 44;
    _notSureBtn.y = 88;
    _cancelBtn.y = 132;
    _sureBtn.width = _btnA.width;
     _notSureBtn.width = _btnA.width;
     _cancelBtn.width = _btnA.width;
    _btnA.height = 44;
    _sureBtn.height = _btnA.height;
     _notSureBtn.height = _btnA.height;
     _cancelBtn.height = _btnA.height;
    self.view.backgroundColor = kUIColorFromRGB(color_4);
    _sureBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [_btnA setTitleColor:kUIColorFromRGB(color_1) forState:UIControlStateNormal];
      [_sureBtn setTitleColor:kUIColorFromRGB(color_1) forState:UIControlStateNormal];
      [_notSureBtn setTitleColor:kUIColorFromRGB(color_1) forState:UIControlStateNormal];
      [_cancelBtn setTitleColor:kUIColorFromRGB(color_1) forState:UIControlStateNormal];
    
    [_btnA setTitle:@"价格未谈妥" forState:UIControlStateNormal];
      [_sureBtn setTitle:@"服务地址太远或其他场地问题" forState:UIControlStateNormal];
      [_notSureBtn setTitle:@"时间不允许" forState:UIControlStateNormal];
      [_cancelBtn setTitle:@"其他" forState:UIControlStateNormal];
    self.view.layer.borderColor = kUIColorFromRGB(color_5).CGColor;
    self.view.layer.borderWidth = 0.5;
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
