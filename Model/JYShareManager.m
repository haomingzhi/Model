//
//  JYShareManager.m
//  ChaoLiu
//
//  Created by air on 15/11/4.
//  Copyright © 2015年 ORANLLC_IOS1. All rights reserved.
//

#import "JYShareManager.h"
#import "ShareViewController.h"
@interface ShareInfo : NSObject
@property(nonatomic,strong)NSString *title;
@property(nonatomic,strong)NSString *imgStr;
@end

@implementation ShareInfo

@end

@implementation JYShareManager
{
    UIAlertController *_alert;
    NSString *_title;
    NSString * _url;
    NSString *_contentFile;
    NSString *_content;
    UIViewController *_parentViewController;
}


+(instancetype)manager
{
    
    static dispatch_once_t  onceToken;
    static JYShareManager * sSharedInstance;
    
    dispatch_once(&onceToken, ^{
        sSharedInstance = [[JYShareManager alloc] init];
    });
    return sSharedInstance;
}

-(void)setShareView:(UIView *)pView
{
    [self setShareView:pView style:0];
}

-(void)setCustomShareView
{
    
}

-(void)setShareView:(UIView *)pView style:(NSInteger) style
{
    
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 5,__SCREEN_SIZE.width - 16,(__SCREEN_SIZE.width - 16)/4)];
    //    v.borderWidth = 1;
    NSMutableArray *arr = [NSMutableArray array];
    
    if([UMWarp hasInstalledWx]&& style == 0)
    {
        NSArray *title = @[@"微信",@"朋友圈",@"QQ空间",@"新浪微博"];
        NSArray *imgs = @[@"weixin",@"friend",@"qqZone",@"sinaIcon"];
        for (int i = 0; i < 4; i ++) {
            ShareInfo *sInfo = [[ShareInfo alloc] init];
            sInfo.title = title[i];
            sInfo.imgStr = imgs[i];
            [arr addObject:sInfo];
        }
    }
    else
    if( [UMWarp hasInstalledWx]&& style == 1)
    {
        NSArray *title = @[@"微信",@"朋友圈"];
        NSArray *imgs = @[@"weixin",@"friend"];
        for (int i = 0; i < 2; i ++) {
            ShareInfo *sInfo = [[ShareInfo alloc] init];
            sInfo.title = title[i];
            sInfo.imgStr = imgs[i];
            [arr addObject:sInfo];
        }
        v.y = 16;
        v.width = (__SCREEN_SIZE.width - 16)/2;
        v.x = pView.width/2.0 - v.width/2.0 - 6;
        UILabel *lb = [[UILabel alloc] initWithFrame:CGRectMake(10, 6, 48, 24)];
        lb.font = [UIFont systemFontOfSize:14];
        lb.text = @"分享到";
        [pView addSubview:lb];
    }
    else if([UMWarp hasInstalledWx]&& style == 2)
    {
        NSArray *title = @[@"朋友圈",@"微信",@"新浪微博"];
        NSArray *imgs = @[@"friend",@"weixin",@"sinaIcon"];
        for (int i = 0; i < 3; i ++) {
            ShareInfo *sInfo = [[ShareInfo alloc] init];
            sInfo.title = title[i];
            sInfo.imgStr = imgs[i];
            [arr addObject:sInfo];
        }
    }
    
    else if(style == 1)
    {
        UILabel *lb = [[UILabel alloc] initWithFrame:CGRectMake(0, 30, pView.width - 10, 22)];
        lb.textColor = kUIColorFromRGB(color_0x2d2d2d);
        lb.text = @"请先安装微信";
        lb.textAlignment = NSTextAlignmentCenter;
        [pView addSubview:lb];
        return;
    }
    else
    {
        NSArray *title = @[@"QQ空间",@"新浪微博"];
        NSArray *imgs = @[@"QQzone",@"sina"];
        for (int i = 0; i < 2; i ++) {
            ShareInfo *sInfo = [[ShareInfo alloc] init];
            sInfo.title = title[i];
            sInfo.imgStr = imgs[i];
            [arr addObject:sInfo];
        }
    }
    
    for (NSInteger i = 0; i < arr.count; i++) {
        UIButton *btn = [[UIButton alloc] init];
        [v addSubview:btn];
        btn.tag = i * 100 + 1;
        //        btn.borderWidth = 1;
        [btn addTarget:self action:@selector( toShare:) forControlEvents:UIControlEventTouchUpInside];
        [btn addWidthConstraint:JYLayoutRelationGreaterThanOrEqual width:(__SCREEN_SIZE.width - 16)/4];
        [btn addHeightConstraint:JYLayoutRelationGreaterThanOrEqual width:(__SCREEN_SIZE.width - 16)/4];
        //        [btn setTitle:title[i] forState:UIControlStateNormal];
        UILabel *textLb = [[UILabel alloc] init];
        ShareInfo *si = arr[i];
        textLb.text = si.title;
        [btn addSubview:textLb];
        //        textLb.textColor = kUIColorFromRGB(color_0x212121);
        textLb.font = [UIFont systemFontOfSize:12];
        [textLb addWidthConstraint:JYLayoutRelationGreaterThanOrEqual width:20];
        [textLb addHeightConstraint:JYLayoutRelationGreaterThanOrEqual width:18];
        [textLb alignViewHCenter:50.0/320*__SCREEN_SIZE.width + 10];
        [btn setImage:[UIImage imageContentWithFileName:si.imgStr] forState:UIControlStateNormal];
        [btn setImageEdgeInsets:UIEdgeInsetsMake(-9.0/320*__SCREEN_SIZE.width, 0, 9.0/320*__SCREEN_SIZE.width, 0)];
        [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [btn alignViewVCenter:i * (__SCREEN_SIZE.width - 16.0/320*__SCREEN_SIZE.width)/3];
    }
    v.y = 23;
    v.x = 12;
    [pView addSubview:v];
}

//-(void)showSheetView:(UIViewController *)vc  withShareTitle:(NSString *)title withShareContent:(NSString *)content withShareImgUrl:(NSString *)contentFile withUrl:(NSString *)url
//{
//    _alert = [UIAlertController alertControllerWithTitle:@"\n\n\n\n\n\n" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
//    _title = title;
//    _url = url;
//    _content = content;
//    _contentFile = contentFile;
//    _parentViewController = vc;
//    [self setShareView:_alert.view style:2];
//    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
//        [_alert dismissViewControllerAnimated:YES completion:nil];
//    }];
//    [cancel setValue:kUIColorFromRGB(color_1) forKey:@"titleTextColor"];
//    [_alert addAction:cancel];
//    [vc presentViewController:_alert animated:YES completion:^{
//        NSLog(@"1");
//    }];
//    
//}

-(void)showSheetView:(UIViewController *)vc withObserver:(id)observer withSel:(SEL)sel withShareTitle:(NSString *)title withShareContent:(NSString *)contentFile withUrl:(NSString *)url
{
    [self showSheetView:vc withObserver:observer withSel:sel withBtnTitle:@"举报" withShareTitle:title withContent:title withShareContent:contentFile withUrl:url];
}

-(void)toShare:(UIButton *)btn
{
    [_alert dismissViewControllerAnimated:YES completion:nil];
    NSString *contentFile = _contentFile;
    NSString *title = _title;
    NSString *url = _url;
    NSString *content = _content;
//    NSInteger i = 0;
//    if (![UMWarp hasInstalledWx]) {
//        i = 2;
//    }
    switch (btn.tag - 101) {
            case 2:
        {
            [UMWarp share:_parentViewController title:title content:content image:contentFile whithPlatform:PlatformWeChat  withUrl:url];
        }
            break;
            case 0:
        {
            [UMWarp share:_parentViewController title:title content:content image:contentFile whithPlatform:PlatformTencent withUrl:url];
        }
            break;
                    case 1:
          {
              [UMWarp share:_parentViewController title:title content:content image:contentFile whithPlatform:PlatformQQ withUrl:url];
          }
              break;
//            case 2:
//        {
//            [UMWarp share:_parentViewController title:title content:content image:contentFile whithPlatform:PlatformSina withUrl:url];
//        }
//            break;
        default:
            break;
    }
}

-(void)showSheetView:(UIViewController *)vc  withShareTitle:(NSString *)title withShareContent:(NSString *)content withShareImgUrl:(NSString *)contentFile withUrl:(NSString *)url
{
     _alert = [UIAlertController alertControllerWithTitle:@"\n\n\n\n\n\n" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
     _title = title;
     _url = url;
     _content = content;
     _contentFile = contentFile;
     _parentViewController = vc;
     ShareViewController *svc = [ShareViewController toShareVC:@[@{@"oneTitle":@"朋友圈",@"twoTitle":@"微信好友",@"threeTitle":@"微信好友",@"oneImg":@"friend",@"twoImg":@"friend",@"threeImg":@"weixin"}]];
     [svc fitNoQQMode];
     __weak ShareViewController *weakSelf = svc;
     [svc setShareHandle:^(UIButton *btn) {
          [self toShare:btn];
          [weakSelf.parentDialog dismiss];
     }];
     //    [self setShareView:_alert.view style:3];
     //       UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
     //        [_alert dismissViewControllerAnimated:YES completion:nil];
     //    }];
     //    [cancel setValue:kUIColorFromRGB(color_1) forKey:@"titleTextColor"];
     //    [_alert addAction:cancel];
     //    [vc presentViewController:_alert animated:YES completion:^{
     //        NSLog(@"1");
     //    }];
     
}

-(void)showSheetView:(UIViewController *)vc withObserver:(id)observer withSel:(SEL)sel withBtnTitle:(NSString *)btnTitle withShareTitle:(NSString *)title withContent:(NSString *)content withShareContent:(NSString *)contentFile withUrl:(NSString *)url
{
    _alert = [UIAlertController alertControllerWithTitle:@"\n\n\n\n" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    _title = title;
    _content = content;
    _url = url;
    _contentFile = contentFile;
    _parentViewController = vc;
    [self setShareView:_alert.view];
    UIAlertAction *ok = [UIAlertAction actionWithTitle:btnTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        //        ReportViewController *rvc = [[ReportViewController alloc] initWithNibName:@"FeedbackViewController" bundle:nil];
        //        [vc.navigationController pushViewController:rvc animated:YES];
        if ([observer respondsToSelector:sel]) {
            [observer performSelector:sel withObject:nil];
        }
        
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        [_alert dismissViewControllerAnimated:YES completion:nil];
    }];
    
    
    [_alert addAction:ok];
    [_alert addAction:cancel];
    [vc presentViewController:_alert animated:YES completion:^{
        
    }];
    
}

/*-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
 {
 //根据`responseCode`得到发送结果,如果分享成功
 if(response.responseCode == UMSResponseCodeSuccess)
 {
 //得到分享到的微博平台名
 NSLog(@"share to sns name is %@",[[response.data allKeys] objectAtIndex:0]);
 }
 }*/

@end
