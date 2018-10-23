//
//  CommonAPI.m
//  ulife
//
//  Created by air on 15/12/25.
//  Copyright © 2015年 ORANLLC_IOS1. All rights reserved.
//

#import "CommonAPI.h"
#import "BUSystem.h"
#import "LoginViewController.h"
#import "ZLPhotoPickerViewController.h"
#import "ZLPhotoAssets.h"
#import "SheetViewController.h"
#import <UniversalFramework/UniversalFramework.h>
#import "TakePhotoViewController.h"
//#import <AlipaySDK/AlipaySDK.h>
//#if TARGET_IPHONE_SIMULATOR
////#define NSLog(format, ...)
//#elif TARGET_OS_IPHONE
//#import <JYAllPay/JYAllPay.h>
//#endif
@implementation BUPay

- (id)init
{
    self = [super init];
    if (self) {
        self.deserializationMap = @{@"BUImageRes":@"BUImageRes"};
    }
    return self;
}

@end

@implementation CommonAPI
{
    UIViewController *_myVC;
    ZLPhotoPickerViewController *_pickerVC;
//#if TARGET_IPHONE_SIMULATOR
//    //#define NSLog(format, ...)
//#elif TARGET_OS_IPHONE
    JYAllPaySDK *_jyp;
//#endif

    void (^_block)(id);
}

static CommonAPI *a;
+(id)managerWithVC:(UIViewController *)vc
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        a = [[CommonAPI alloc] init];
//#if TARGET_IPHONE_SIMULATOR
//        //#define NSLog(format, ...)
//#elif TARGET_OS_IPHONE
        a->_jyp = [JYAllPaySDK manager];
        [a->_jyp initPay:@{kWxPayWay:kWxPayWay,kWxAppId:WXUrlSchemes,kWxAppDes:@""}];//微信应用id
//#endif
    });
    a->_myVC = vc;

    return a;
}

-(void)showAlert:(SEL)sel withTitle:(NSString *)title withMessage:(NSString *)msg withObj:(id)obj//确认提示框
{
    UIAlertController *avc = [UIAlertController alertControllerWithTitle:title  message:msg preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *sc = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        if ([_myVC respondsToSelector:sel]) {
            NSMutableDictionary *obdic = [NSMutableDictionary dictionaryWithDictionary:obj];
            obdic[@"code"] = @(0);
            [_myVC performSelector:sel withObject:obdic];
        }
        [avc dismissViewControllerAnimated:YES completion:nil];
    }];
     [sc setValue:kUIColorFromRGB(color_3) forKey:@"titleTextColor"];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        [avc dismissViewControllerAnimated:YES completion:nil];
        if ([_myVC respondsToSelector:sel]) {
            NSMutableDictionary *obdic = [NSMutableDictionary dictionaryWithDictionary:obj];
            obdic[@"code"] = @(-1);
            [_myVC performSelector:sel withObject:obdic];
        }
    }];
     [cancel setValue:kUIColorFromRGB(color_7) forKey:@"titleTextColor"];
//     [cancel setValue:[UIFont systemFontOfSize:15] forKey:@"font"];
    [avc addAction:sc];
    [avc addAction:cancel];
//     [BSUtility showDialogOkCancel:msg Context:@"" completion:^(NSInteger index) {
//          if (index == 1) {
//               if ([_myVC respondsToSelector:sel]) {
//                    NSMutableDictionary *obdic = [NSMutableDictionary dictionaryWithDictionary:obj];
//                    obdic[@"code"] = @(0);
//                    [_myVC performSelector:sel withObject:obdic];
//               }
//          }
//          else
//          {
//               if ([_myVC respondsToSelector:sel]) {
//                    NSMutableDictionary *obdic = [NSMutableDictionary dictionaryWithDictionary:obj];
//                    obdic[@"code"] = @(-1);
//                    [_myVC performSelector:sel withObject:obdic];
//               }
//          }
//     }];
    [_myVC presentViewController:avc animated:YES completion:^{

    }];
}

-(void)showDeleteAlert:(SEL)sel withTitle:(NSString *)title
{
    UIAlertController *avc = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *sc = [UIAlertAction actionWithTitle:title style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        //            if ([_myVC respondsToSelector:sel]) {
        //                [_myVC performSelector:sel withObject:nil];
        //            }
        [avc dismissViewControllerAnimated:YES completion:nil];
        [self showAlert:sel withTitle:title withMessage:@"确定删除吗？"withObj:nil];
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        [avc dismissViewControllerAnimated:YES completion:nil];
        if ([_myVC respondsToSelector:sel]) {
            [_myVC performSelector:sel withObject:@{@"code":@(-1)}];
        }
        
    }];
    [avc addAction:sc];
    [avc addAction:cancel];
    [_myVC presentViewController:avc animated:YES completion:^{
        
    }];
}

-(void)deleteUser:(SEL)sel withUserId:(NSString *)userId
{
    UIAlertController *avc = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *sc = [UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [avc dismissViewControllerAnimated:YES completion:nil];
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        [avc dismissViewControllerAnimated:YES completion:nil];
    }];
    [avc addAction:sc];
    [avc addAction:cancel];
    [_myVC presentViewController:avc animated:YES completion:^{
        
    }];
    
}

-(void)setTextAlert:(NSString*)title sel:(SEL)sel withUserId:(NSString *)userId withObj:(id)obj
{
     UIAlertController *avc = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleAlert];
     [avc addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
          //        NSLog(@"duo sss:%@",textField.text);
     }];
     UITextField *textField  = avc.textFields.firstObject;
     NSString *uname = obj[@"name"];
     if (uname&&![uname isEqualToString:@""]) {
          textField.text = uname;
     }
     else{
          textField.placeholder = @"续租天数";
     }
     textField.keyboardType = UIKeyboardTypeNumberPad;
     textField.clearButtonMode = UITextFieldViewModeWhileEditing;
     UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
          [avc dismissViewControllerAnimated:YES completion:nil];
     }];
     [avc addAction:cancel];
      [cancel setValue:kUIColorFromRGB(color_3) forKey:@"titleTextColor"];
     UIAlertAction *sc = [UIAlertAction actionWithTitle:@"提交" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
          UITextField *textField  = avc.textFields.firstObject;
          if (textField.text.length == 0) {
               [avc dismissViewControllerAnimated:YES completion:nil];
               HUDCRY(@"不能为空", 2);
               return ;
          }
          [avc dismissViewControllerAnimated:YES completion:nil];
          if ([_myVC respondsToSelector:sel]) {
               [_myVC performSelector:sel withObject:@{@"userInfo":obj,@"text":textField.text,@"tag":@(100),@"code":@(0)}];
          }
     }];
     [avc addAction:sc];
        [sc setValue:kUIColorFromRGB(color_3) forKey:@"titleTextColor"];
     [_myVC presentViewController:avc animated:YES completion:^{

     }];
}

-(void)setRemark:(SEL)sel withUserId:(NSString *)userId withObj:(id)obj
{
    UIAlertController *avc = [UIAlertController alertControllerWithTitle:@"设置备注" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [avc addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        //        NSLog(@"duo sss:%@",textField.text);
    }];
    UITextField *textField  = avc.textFields.firstObject;
    NSString *uname = obj[@"name"];
    if (uname&&![uname isEqualToString:@""]) {
        textField.text = uname;
    }
    else{
        textField.placeholder = @"1-8汉字";
    }
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        [avc dismissViewControllerAnimated:YES completion:nil];
    }];
    [avc addAction:cancel];
    UIAlertAction *sc = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        UITextField *textField  = avc.textFields.firstObject;
        if (textField.text.length > 8) {
            [avc dismissViewControllerAnimated:YES completion:nil];
            HUDCRY(@"备注字数不能小于1或大于8", 2);
            return ;
        }
               [avc dismissViewControllerAnimated:YES completion:nil];
    }];
    [avc addAction:sc];
    [_myVC presentViewController:avc animated:YES completion:^{
        
    }];
    
}

-(void)showAdminOption:(SEL)sel withUserId:(NSString *)userId withObj:(id)obj//显示多个操作
{
    UIAlertController *avc = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    if([obj[@"hasRemark"] boolValue])
    {
        UIAlertAction *sc = [UIAlertAction actionWithTitle:@"设置备注" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            
            [avc dismissViewControllerAnimated:YES completion:nil];
            [self setRemark:sel withUserId:userId withObj:obj];
        }];
        [avc addAction:sc];
    }
    NSString *commentTitle = @"禁止评论";
    if ([obj[@"comment"] isEqualToString:@"0"]) {
        commentTitle = @"启用评论";
    }
    UIAlertAction *sb = [UIAlertAction actionWithTitle:commentTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
               [avc dismissViewControllerAnimated:YES completion:nil];
    }];
    
    NSString *publishTitle = @"禁止发布";
    if([obj[@"publish"] isEqualToString:@"0"])
    {
        publishTitle = @"启用发布";
    }
    UIAlertAction *sd = [UIAlertAction actionWithTitle:publishTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [avc dismissViewControllerAnimated:YES completion:nil];
    }];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        [avc dismissViewControllerAnimated:YES completion:nil];
    }];
    
    [avc addAction:sb];
    [avc addAction:sd];
    if([obj[@"hasDelete"] boolValue])
    {
        UIAlertAction *sa = [UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [avc dismissViewControllerAnimated:YES completion:nil];
            [self deleteUser:sel withUserId:userId];
        }];
        [avc addAction:sa];
    }
    [avc addAction:cancel];
    [_myVC presentViewController:avc animated:YES completion:^{
        
    }];
    
}


-(void)showPayOptionView:(SEL)sel withUserId:(NSString *)userId withObj:(id)obj
{

 __weak  SheetViewController *svc = [SheetViewController toSheeVC:@[@"支付宝支付",@"微信支付"]];
    [svc setCallback:^(NSDictionary *dic) {
       
        NSInteger row = [dic[@"row"] integerValue];
        BOOL isCancel = [dic[@"isCancel"] boolValue];
        if(isCancel)
        {
            [svc.parentDialog cancel];
        }else
        if (row == 0) {
             [svc.parentDialog dismiss];
            if([_myVC respondsToSelector:sel])
            {
                [_myVC performSelector:sel withObject:@{@"payWay":@"1",@"money":obj}];
            }
        }
        else if (row == 1)
        {
             [svc.parentDialog dismiss];
            if([_myVC respondsToSelector:sel])
            {
                [_myVC performSelector:sel withObject:@{@"payWay":@"2",@"money":obj}];
            }
        }
       
    }];
}

-(void)deletePostSheet:(SEL)sel withUserId:(NSString *)userId withObj:(id)obj//删除帖子
{
    UIAlertController *avc = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *sc = [UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSString *msgId = @"";
        if ([obj[@"type"] integerValue] == 3) {
            //            BUUserCall *bc = busiSystem.userCallManager.userCallList[[obj[@"row"] integerValue] ];
            //            msgId = bc.MsgId;
        }
        else if ([obj[@"type"] integerValue] == 1)
        {
            //            BUContactInfo *nc = busiSystem.contactManager.MsgList[[obj[@"row"] integerValue] ];
            //
            //            msgId = nc.MsgId;
        }
        else if ([obj[@"type"] integerValue] == 2)
        {
            //            BUJoinMsg *ms = busiSystem.joinMsgManager.MsgList[[obj[@"row"] integerValue]];
            //            msgId = ms.MsgId;
        }
        //        [busiSystem.commonUserManager deleteAll:@[msgId] withTheType:[NSString stringWithFormat:@"%@",obj[@"type"]] withTheArea:busiSystem.agent.AreaId withDeleteType:@"1" withTargetUserId:userId observer:_myVC callback:sel extraInfo:@{}];
        
        [avc dismissViewControllerAnimated:YES completion:nil];
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        [avc dismissViewControllerAnimated:YES completion:nil];
    }];
    [avc addAction:sc];
    [avc addAction:cancel];
    [_myVC presentViewController:avc animated:YES completion:^{
        
    }];
    
}


-(void)deletePostAlert:(NSDictionary *)obj
{
    //    BUUserCall *bc = busiSystem.userCallManager.userCallList[[obj[@"row"] integerValue] ];
    //    [busiSystem.commonUserManager deleteAll:@[bc.MsgId] withTheType:@"3" withTheArea:busiSystem.agent.AreaId withDeleteType:@"1" withTargetUserId:obj[@"userId"] observer:_myVC callback:nil extraInfo:@{}];
}


-(void)removeAllPostSheet:(SEL)sel withUserId:(NSString *)userId withObj:(id)obj//删除全部帖子
{
    UIAlertController *avc = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *sc = [UIAlertAction actionWithTitle:@"清空所有记录" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        //        [busiSystem.commonUserManager deleteAll:@[] withTheType:[NSString stringWithFormat:@"%@",obj[@"type"]] withTheArea:busiSystem.agent.AreaId withDeleteType:@"2" withTargetUserId:userId observer:_myVC callback:sel extraInfo:@{}];
        
        [avc dismissViewControllerAnimated:YES completion:nil];
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        [avc dismissViewControllerAnimated:YES completion:nil];
    }];
    [avc addAction:sc];
    [avc addAction:cancel];
    [_myVC presentViewController:avc animated:YES completion:^{
        
    }];
}

-(void)showPayMoneyView:(SEL)sel
{
    UIAlertController *avc = [UIAlertController alertControllerWithTitle:@"请输入支付金额" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [avc addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        //        NSLog(@"duo sss:%@",textField.text);
    }];
    UITextField *textField  = avc.textFields.firstObject;
    textField.keyboardType =UIKeyboardTypeDecimalPad;
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        [avc dismissViewControllerAnimated:YES completion:nil];
    }];
    [avc addAction:cancel];
    UIAlertAction *sc = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        UITextField *textField  = avc.textFields.firstObject;
        //判断输入的是否为数字
        
        [avc dismissViewControllerAnimated:YES completion:nil];
        if ([_myVC respondsToSelector:sel]) {
            [_myVC performSelector:sel withObject:textField.text];
        }
        
    }];
    [avc addAction:sc];
    [_myVC presentViewController:avc animated:YES completion:^{
        
    }];
    
}

-(void)showConfirmView:(NSString *)title withMsg:(NSString *)msg
{
    UIAlertController *avc = [UIAlertController alertControllerWithTitle:title  message:msg preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *sc = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [avc dismissViewControllerAnimated:YES completion:nil];
    }];
    [avc addAction:sc];
    if ([sc valueForKey:@"titleTextColor"]) {
        [sc setValue:kUIColorFromRGB(color_1) forKey:@"titleTextColor"];
    }
    [_myVC presentViewController:avc animated:YES completion:^{
        
    }];
}

-(void)showAlertView:(NSString *)title withMsg:(NSString *)msg withBtnTitle:(NSString *)btnTitle withSel:(SEL)sel
{
    [self showAlertView:title withMsg:msg withBtnTitle:btnTitle withSel:sel withUserInfo:nil];
}
-(void)showAlertView:(NSString *)title withMsg:(NSString *)msg withBtnTitle:(NSString *)btnTitle  withSel:(SEL)sel withUserInfo:(id)userInfo
{
    [self showAlertView:title withMsg:msg withBtnTitle:btnTitle withCancelBtnTitle:@"取消" withSel:sel withUserInfo:userInfo];
}

-(void)showAlertView:(NSString *)title withMsg:(NSString *)msg withBtnTitle:(NSString *)btnTitle withCancelBtnTitle:(NSString *)cancelBtnTitle withSel:(SEL)sel withUserInfo:(id)userInfo
{
    UIAlertController *avc = [UIAlertController alertControllerWithTitle:title  message:msg preferredStyle:UIAlertControllerStyleAlert];
    

    
    UIAlertAction *sc = [UIAlertAction actionWithTitle:btnTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [avc dismissViewControllerAnimated:YES completion:nil];
        if ([_myVC respondsToSelector:sel]) {
            [_myVC performSelector:sel withObject:@{@"userInfo":userInfo,@"tag":@(100),@"code":@(0)}];
        }
        
    }];
    [avc addAction:sc];
    //    if ([sc valueForKey:@"titleTextColor"]) {
    [sc setValue:kUIColorFromRGB(color_3) forKey:@"titleTextColor"];
    //    }
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:cancelBtnTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        [avc dismissViewControllerAnimated:YES completion:nil];
        if ([_myVC respondsToSelector:sel]) {
            [_myVC performSelector:sel withObject:@{@"userInfo":userInfo,@"tag":@(101),@"code":@(-1)}];
        }
    }];
    [avc addAction:cancel];
    //    if ([cancel valueForKey:@"titleTextColor"]) {
    [cancel setValue:kUIColorFromRGB(color_3) forKey:@"titleTextColor"];
    //    }
    [_myVC presentViewController:avc animated:YES completion:^{
        
    }];
}

-(void)showLinkOptionView:(NSDictionary *)dataDic withSel:(SEL)sel
{
    UIAlertController *avc = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"%@可能是一个电话号码，你可以",dataDic[@"phone"]] message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *sc = [UIAlertAction actionWithTitle:@"呼叫" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        
        [avc dismissViewControllerAnimated:YES completion:nil];
        [BSUtility callPhone:dataDic[@"phone"]?:@"" view:_myVC.view];
    }];
    UIAlertAction *scd = [UIAlertAction actionWithTitle:@"复制" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [BSUtility copyStr:dataDic[@"phone"]];
        
        [avc dismissViewControllerAnimated:YES completion:nil];
    }];
    UIAlertAction *scf = [UIAlertAction actionWithTitle:@"添加到手机通讯录" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [BSUtility creatNewRecord:dataDic[@"phone"] phoneNumber:dataDic[@"phone"] withParentVC:_myVC];
        
        [avc dismissViewControllerAnimated:YES completion:nil];
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        [avc dismissViewControllerAnimated:YES completion:nil];
    }];
    [avc addAction:sc];
    [avc addAction:scd];
    [avc addAction:scf];
    [avc addAction:cancel];
    [_myVC presentViewController:avc animated:YES completion:^{
        
    }];
    
}


-(void)showSheetOption:(NSArray *)titles withSel:(SEL)sel withTitle:(NSString *)title
{
    [self showSheetOption:titles withSel:sel withTitle:title withUserInfo:nil];
}

-(void)showSheetOption:(NSArray *)titles withSel:(SEL)sel withTitle:(NSString *)title withUserInfo:(id)userInfo
{
    [self showSheetOption:titles withTarget:nil withSel:sel withTitle:title withUserInfo:userInfo];
}

-(void)showSheetOption:(NSArray *)titles withTarget:(id)obsever withSel:(SEL)sel withTitle:(NSString *)title withUserInfo:(id)userInfo
{
 __weak  SheetViewController *vc = [SheetViewController toSheeVC:titles];
    [vc setCallback:^(NSDictionary *dic) {
        NSInteger i = [dic[@"row"] integerValue];
        if ([dic[@"isCancel"] boolValue]) {
            if ([_myVC respondsToSelector:sel]) {
                            [_myVC performSelector:sel withObject:@{@"tag":@(999),@"userInfo":userInfo?:[NSNull new]}];
                        }
             [vc.parentDialog cancel];
        }
        else
        if ([obsever respondsToSelector:sel]) {
            [obsever performSelector:sel withObject:@{@"tag":@(i + 100),@"userInfo":userInfo?:[NSNull new]}];
              [vc.parentDialog dismiss];
        }
        else if ([_myVC respondsToSelector:sel]) {
            [_myVC performSelector:sel withObject:@{@"tag":@(i + 100),@"userInfo":userInfo?:[NSNull new]}];
             [vc.parentDialog dismiss];
        }
        else
        {
            [self performSelector:sel withObject:@{@"tag":@(i + 100),@"userInfo":userInfo?:[NSNull new]}];
            [vc.parentDialog dismiss];
        }
       
    }];
    //avc.view.tintColor = kUIColorFromRGB(color_15);
}

-(void)showReportOption:(SEL)sel
{
    [self showSheetOption:@[@"不实信息",@"淫秽色情",@"违法信息",@"有害信息",@"垃圾营销",@"其他"] withSel:sel withTitle:@"请选择举报理由"];
}

-(void)showPhotoOption:(SEL)sel withUserInfo:(id)userInfo
{
    [self showPhotoOption:sel withTarget:nil withUserInfo:userInfo];
}

-(void)showPhotoOption:(SEL)sel withTarget:(id)obj withUserInfo:(id)userInfo
{
    if (!sel) {
        sel = @selector(photoOption:);
    }
//    if (obj) {
//        [self showSheetOption:@[@"拍照",@"从手机相册选择"] withTarget:obj withSel:sel   withTitle:nil  withUserInfo:userInfo];
//    }
//    else
    NSMutableDictionary *um = [NSMutableDictionary dictionaryWithDictionary:userInfo];
    um[@"obj"] = obj;
    [self showSheetOption:@[@"拍照",@"从手机相册选择"] withSel:sel withTitle:nil  withUserInfo:um];
}

-(void)showPhotoOption:(SEL)sel
{
    [self showPhotoOption:sel withUserInfo:nil];
}

-(void)photoOption:(NSDictionary *)dic
{
    NSInteger tag = [dic[@"tag"] integerValue];
    NSDictionary *userInfo = dic[@"userInfo"];
    id o = userInfo[@"obj"];
    switch (tag - 100) {
        case 0:
        {
             [self addUmagePickerController:o withCount:[dic[@"userInfo"][@"count"] integerValue]];
        }
            break;
        case 1:
        {
//            _pickerVC = [[ZLPhotoPickerViewController alloc]init];
//            if (o) {
//                _pickerVC.delegate = o;
//            }
//            else
//            _pickerVC.delegate = _myVC;
//            if (dic[@"userInfo"]) {
//                _pickerVC.maxCount = [dic[@"userInfo"][@"count"] integerValue];
//            }
//            else
//            {
//                _pickerVC.maxCount = 9;
//            }
//            _pickerVC.status = PickerViewShowStatusCameraRoll;
//            [_pickerVC showPickerVc:_myVC.navigationController];
             TakePhotoViewController *vc = [TakePhotoViewController new];
             if (dic[@"userInfo"]) {
                   vc.imgsCount = [dic[@"userInfo"][@"count"] integerValue];
               }
               else
               {
                   vc.imgsCount = 9;
               }
             if (o) {
                  vc.photoVCdelgate = o;
             }
             else
                  vc.photoVCdelgate  = _myVC;
             [_myVC presentModalViewController:vc animated:YES];
        }
            break;
        default:
            break;
    }
}

#pragma mark --View
- (void)addUmagePickerController:(id)obj withCount:(NSInteger)count
{
     TakePhotoViewController *vc = [TakePhotoViewController new];
      vc.mode = 1;
     if (count != 0) {
          vc.imgsCount = count;
     }
else
{
     vc.imgsCount = 9;
}
     if (obj) {
          vc.photoVCdelgate = obj;
     }
     else
          vc.photoVCdelgate  = _myVC;
[_myVC presentModalViewController:vc animated:YES];
//    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
//    UIImagePickerController *picker = [[UIImagePickerController alloc] init];//初始化

//    picker.sourceType = sourceType;
//    [_myVC presentModalViewController:picker animated:YES];//进入照相界面
}


#pragma mark ---UIImagePickerControllerDelegate
//点击相册中的图片 货照相机照完后点击use  后触发的方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    //    ReplyViewController * rVC =[[ReplyViewController alloc] init];
    //    UINavigationController *nav = self.tabBarController.selectedViewController;
    //    WBStatusComposeViewController *vc = [WBStatusComposeViewController new];
    //    vc.isImageArr =YES;
    //    vc.type = WBStatusComposeViewTypeStatus;
    //    vc.imageArray =[NSMutableArray new];
    //    [vc.imageArray addObject:image];
    //    vc.hidesBottomBarWhenPushed =YES;
    //    vc.isResponder=YES;
    //    [nav pushViewController:vc animated:NO];
    //    rVC.imageArray =_imgArr;
    //    [_pickerVC setDelegate:nil];
    //    [self.navigationController pushViewController:vc animated:YES];
    [picker dismissModalViewControllerAnimated:YES];
}

//点击cancel 调用的方法
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissModalViewControllerAnimated:YES];
}


- (void)pickerViewControllerDoneAsstes:(NSArray *)assets{
    //    UINavigationController *nav = self.tabBarController.selectedViewController;
    //    _imgArr = [NSMutableArray array];
    //    [assets enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
    //        ZLPhotoAssets *asset = (ZLPhotoAssets *)obj;
    //        UIImage *img = [asset originImage];
    //        [_imgArr addObject:img];
    //    }];
    //    ReplyViewController * rVC =[[ReplyViewController alloc] init];
    //    WBStatusComposeViewController *vc = [WBStatusComposeViewController new];
    //    vc.type = WBStatusComposeViewTypeStatus;
    //    vc.imageArray = [NSMutableArray arrayWithArray:[(NSMutableArray*)_imgArr reverseObjectEnumerator].allObjects];
    //    vc.hidesBottomBarWhenPushed =YES;
    //    vc.isResponder=YES;
    //    vc.isImageArr =YES;
    //    [_pickerVC setDelegate:nil];
    //    [nav pushViewController:vc animated:YES];
    //    [_pickerVC dismissViewControllerAnimated:YES completion:nil];
}

+(void)tiRenToLogin:(NSString *)str
{
    //    HUDDISMISS;
    LoginViewController *loginVC =[LoginViewController new];
    busiSystem.agent.isLogin =NO;
    busiSystem.agent.isCancel =YES;
//    loginVC.type=4;
    UINavigationController *navSvc = [[UINavigationController alloc] initWithRootViewController:loginVC];
    [UIApplication sharedApplication].delegate.window.rootViewController =navSvc;
    [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"password"];
    [[NSUserDefaults standardUserDefaults]  synchronize];
    if (str&&![str isEqualToString:@""]) {
        HUDCRY(str, 2);
    }
    
}

-(void)toPay:(NSDictionary *)dic withBlock:(void (^)(id ) ) block{
    NSString *orderString = dic[@"payBody"];//busiSystem.getOrderListManager.orderAddResult.payBody;
    BUPay *pay = [BUPay new];
    pay.payInfo = orderString;
    pay.payMethod = [dic[@"method"] integerValue];
    [self goToPay:pay block:block];
}

-(void)goToPay:(BUPay *)order  block:(void (^)(id ) ) block
{
    //     HUDSHOW(@"正在加载,请稍等...");
    _block = block;
    [self performSelectorOnMainThread:@selector(goToPay:) withObject:order waitUntilDone:NO];
}

-(void)goToPay:(BUPay *)order
{
    NSString *info = order.payInfo?:@"";
    if (!info||[info isEqualToString:@""]) {
        HUDCRY(@"订单有误", TOAST_SHORTTIMER);
        return;
    }
    NSMutableDictionary *payInfo = [NSMutableDictionary dictionaryWithDictionary:@{}];
    UIWindow* windowtemp;
    BOOL b = NO;
    switch (order.payMethod) {
        case 1:
        {
            NSArray* views = [[UIApplication sharedApplication] windows];
            
            windowtemp = views[0];
            if (windowtemp.hidden) {
                windowtemp.hidden = NO;
            }
            else
            {
                b = YES;
                NSLog(@"no hidden");
            }
            payInfo = [NSMutableDictionary dictionaryWithDictionary:@{@"rt":info,@"appScheme":AliUrlSchemes}];
//#if TARGET_IPHONE_SIMULATOR
//            //#define NSLog(format, ...)
//#elif TARGET_OS_IPHONE
            [_jyp setPayWay:kAlipayWay];
//#endif
        }
            break;
        case 2:
        {
            NSData *JSONData = [order.payInfo dataUsingEncoding:NSUTF8StringEncoding];
            payInfo = [NSMutableDictionary dictionaryWithDictionary:[NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingMutableLeaves error:nil]] ;
            payInfo[@"packageValue"] = [payInfo[@"packagevalue"] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//#if TARGET_IPHONE_SIMULATOR
//            //#define NSLog(format, ...)
//#elif TARGET_OS_IPHONE
            [_jyp setPayWay:kWxPayWay];
//#endif
        }
            break;
        case 3:
        {
            return;
        }
            break;
        case 4:
        {
            return;
        }
            break;
        default:
            break;
    }
//#if TARGET_IPHONE_SIMULATOR
//    //#define NSLog(format, ...)
//#elif TARGET_OS_IPHONE
    [_jyp payOrder:payInfo callback:^(NSDictionary *resultDic) {

        switch (order.payMethod) {
            case 1:
            {
                if([resultDic[@"resultStatus"] integerValue] == 6002)
                {
                    HUDCRY(@"网络连接出错", TOAST_SHORTTIMER);
                    if (_block) {
                        _block(@{@"code":@1});
                    }
                    return ;
                }
                else if ([resultDic[@"resultStatus"] integerValue] == 4000)
                {
                    HUDCRY(@"订单支付失败!", TOAST_SHORTTIMER);
                    if (_block) {
                        _block(@{@"code":@1});
                    }
                    return ;
                }
                else if ([resultDic[@"resultStatus"] integerValue] == 9000)
                {
                    //                    busiSystem.orderManager.currentMyOrder.status = @"1";
                }
                else if ([resultDic[@"resultStatus"] integerValue] == 6001)
                {
                    HUDCRY(@"您已退出了支付宝支付!", TOAST_SHORTTIMER);
                    if (_block) {
                        _block(@{@"code":@1});
                    }
                    return ;
                }
                NSLog(@"zfb:%@",resultDic[@"resultStatus"]);

            }
                break;
            case 2:
            {
                NSLog(@"%@",resultDic);
                if([resultDic[@"errCode"] integerValue] == 0 )
                {
                    //                  busiSystem.orderManager.currentMyOrder.status = @"1";
                }
                else if([resultDic[@"errCode"] integerValue] == -1)
                {
                    HUDCRY(@"订单支付失败!", TOAST_SHORTTIMER);
                    if (_block) {
                        _block(@{@"code":@1});
                    }
                    return ;
                }
                else if([resultDic[@"errCode"] integerValue] == -2)
                {
                    HUDCRY(@"您已退出了微信支付!", TOAST_SHORTTIMER);
                    if (_block) {
                        _block(@{@"code":@1});
                    }
                    return ;
                }
            }
                break;
            case 3:
            {

            }
                break;
            case 4:
            {

            }
                break;
            default:
                break;
        }
        if (_block) {
            _block(@{@"code":@0});
        }
        if (!b) {
            windowtemp.hidden = YES;
        }

    }];
//#endif
    
}

@end
