//
//  CommonAPI.h
//  ulife
//
//  Created by air on 15/12/25.
//  Copyright © 2015年 ORANLLC_IOS1. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BUImageRes.h"
@interface BUPay : BUBase
@property(strong,nonatomic) NSString *title;
@property(strong,nonatomic) NSString *content;
@property(nonatomic) long openpopup;
@property(strong,nonatomic) NSString *btntext;
@property(strong,nonatomic) BUImageRes *backimage;
@property(strong,nonatomic) NSString *trbdId;
@property(strong,nonatomic) NSString *payInfo;//支付宝信息
@property(nonatomic) NSInteger payMethod;
@property(nonatomic) double flag;
@property(nonatomic) double sysmsgdata;
@property(nonatomic,strong) NSString * moneys;
@end
@interface CommonAPI : NSObject
+(id)managerWithVC:(UIViewController *)vc;
-(void)showDeleteAlert:(SEL)sel withTitle:(NSString *)title;
-(void)showAdminOption:(SEL)sel withUserId:(NSString *)userId withObj:(id)obj;
-(void)showPayOptionView:(SEL)sel withUserId:(NSString *)userId withObj:(id)obj;
-(void)deletePostSheet:(SEL)sel withUserId:(NSString *)userId withObj:(id)obj;
//删除全部帖子
-(void)removeAllPostSheet:(SEL)sel withUserId:(NSString *)userId withObj:(id)obj;
-(void)showAlert:(SEL)sel withTitle:(NSString *)title withMessage:(NSString *)msg withObj:(id)obj;
-(void)showPayMoneyView:(SEL)sel;
-(void)showConfirmView:(NSString *)title withMsg:(NSString *)msg;
-(void)showLinkOptionView:(NSDictionary *)dataDic withSel:(SEL)sel;
-(void)showSheetOption:(NSArray *)titles withSel:(SEL)sel withTitle:(NSString *)title;
+(void)tiRenToLogin:(NSString *)str;
-(void)showReportOption:(SEL)sel;//举报操作
-(void)showAlertView:(NSString *)title withMsg:(NSString *)msg withBtnTitle:(NSString *)btnTitle withSel:(SEL)sel;
-(void)showAlertView:(NSString *)title withMsg:(NSString *)msg withBtnTitle:(NSString *)btnTitle withSel:(SEL)sel withUserInfo:(id)userInfo;
-(void)showPhotoOption:(SEL)sel;//相册操作
-(void)showPhotoOption:(SEL)sel withUserInfo:(id)userInfo;
-(void)showPhotoOption:(SEL)sel withTarget:(id)obj withUserInfo:(id)userInfo;
-(void)showSheetOption:(NSArray *)titles withSel:(SEL)sel withTitle:(NSString *)title withUserInfo:(id)userInfo;
-(void)showSheetOption:(NSArray *)titles withTarget:(id)obsever withSel:(SEL)sel withTitle:(NSString *)title withUserInfo:(id)userInfo;
-(void)showAlertView:(NSString *)title withMsg:(NSString *)msg withBtnTitle:(NSString *)btnTitle withCancelBtnTitle:(NSString *)cancelBtnTitle withSel:(SEL)sel withUserInfo:(id)userInfo;//提示框
-(void)toPay:(NSDictionary *)dic withBlock:(void (^)(id ) ) block;
-(void)setTextAlert:(NSString*)title sel:(SEL)sel withUserId:(NSString *)userId withObj:(id)obj;
@end
