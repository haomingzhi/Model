//
//  ShareFriendViewController.m
//  compassionpark
//
//  Created by air on 2017/3/16.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import "ShareFriendViewController.h"
#import "BUSystem.h"

@interface ShareFriendViewController ()
@property (strong, nonatomic) IBOutlet UILabel *titleLb;
@property (strong, nonatomic) IBOutlet UIImageView *QRImgV;
@property (strong, nonatomic) IBOutlet UILabel *lineLb;
@property (strong, nonatomic) IBOutlet UILabel *detailLb;
@property (strong, nonatomic) IBOutlet UIButton *oneBtn;
@property (strong, nonatomic) IBOutlet UIButton *twoBtn;
@property (strong, nonatomic) IBOutlet UIButton *threeBtn;
@property (strong, nonatomic) IBOutlet UILabel *orLb;

@end

@implementation ShareFriendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)fitMode
{
    _orLb.backgroundColor = kUIColorFromRGB(color_4);
    _lineLb.height = 0.5;
    _lineLb.backgroundColor = kUIColorFromRGB(color_mainTheme);
    self.view.layer.cornerRadius = 8;
    self.view.layer.masksToBounds = YES;
    self.view.backgroundColor = kUIColorFromRGB(color_4);
    _oneBtn.customImgV.image = [UIImage imageContentWithFileName:@"pengyouquan"];//[UIImage imageContentWithFileName:@"weixin"];
    _oneBtn.customImgV.height = 40;
    _oneBtn.customImgV.width = 40;
    _oneBtn.customImgV.x = _oneBtn.width/2.0 - _oneBtn.customImgV.width/2.0;
    _oneBtn.customTitleLb.font = [UIFont systemFontOfSize:12];
    _oneBtn.customTitleLb.textColor = kUIColorFromRGB(color_7);
    _oneBtn.customTitleLb.text = @"朋友圈";//@"微信好友";
    _oneBtn.customTitleLb.y = 46;
    _oneBtn.customTitleLb.x = 0;
    _oneBtn.customTitleLb.width = 50;
    
      _twoBtn.customImgV.image = [UIImage imageContentWithFileName:@"weixin"];//[UIImage imageContentWithFileName:@"pengyouquan"];
    _twoBtn.customImgV.height = 40;
    _twoBtn.customImgV.width = 40;
    _twoBtn.customTitleLb.font = [UIFont systemFontOfSize:12];
    _twoBtn.customTitleLb.textColor = kUIColorFromRGB(color_7);
     _twoBtn.customTitleLb.text = @"微信好友";//@"朋友圈";
     _twoBtn.customTitleLb.y = 46;
     _twoBtn.customTitleLb.x = 0;
//     _twoBtn.customImgV.x = _threeBtn.width/2.0 - _threeBtn.customImgV.width/2.0;//_twoBtn.width/2.0 - _twoBtn.customImgV.width/2.0;

      _threeBtn.customImgV.image = [UIImage imageContentWithFileName:@"qq"];
    _threeBtn.customImgV.height = 32;
    _threeBtn.customImgV.width = 28;
    _threeBtn.customTitleLb.font = [UIFont systemFontOfSize:12];
    _threeBtn.customTitleLb.textColor = kUIColorFromRGB(color_7);
     _threeBtn.customTitleLb.text = @"QQ好友";
     _threeBtn.customTitleLb.y = 46;
     _threeBtn.customTitleLb.x = 0;
      _threeBtn.customImgV.x = _threeBtn.width/2.0 - _threeBtn.customImgV.width/2.0;
    _twoBtn.customImgV.x = _threeBtn.width/2.0 - _threeBtn.customImgV.width/2.0;
//    [busiSystem.agent.userInfo.shareQRCode download:self callback:@selector(getImgNotification:) extraInfo:nil];
}


-(void)getImgNotification:(BSNotification *)noti
{
//    if (noti.error == 0) {
//        ISTOLOGIN;
        BUImageRes *img = noti.target;
//        UIImageView *imgv = noti.extraInfo[@"obj"];
        _QRImgV.image =  [UIImage imageWithContentsOfFile:img.cacheThumbFile];
//    }
}
static ShareFriendViewController *sharevc;
+(ShareFriendViewController *)toShareVC
{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharevc = [[ShareFriendViewController alloc] init];
        
    });
    
    //   DealPasswordViewController *dealvc = [DealPasswordViewController new];
    MyDialog *myDialog = [[MyDialog alloc] initWithViewController:sharevc];
   // sharevc.view.width = __SCREEN_SIZE.width;
    //    vc.doneCallBack = ^(NSString *pwd){
    //        [weakSelf toAddwithdraw:pwd];
    //    };
    myDialog.mydelegate = sharevc;
    myDialog.bgColor = kUIColorFromRGBWithAlpha(color_12, 0.5);
    myDialog.isDownAnimate = NO;
    [myDialog show];
    //[myDialog showAtPosition:CGPointMake(0, 44 + 64) animated:NO];
    myDialog.dismissOnTouchOutside = YES;
    //[sharevc.collectionView reloadData];
    [sharevc fitMode];
    return sharevc;
}
- (IBAction)btnHandle:(UIButton*)btn {
    if (_callBack) {
        _callBack(@{@"tag":@(btn.tag)});
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
