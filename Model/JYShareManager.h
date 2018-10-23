//
//  JYShareManager.h
//  ChaoLiu
//
//  Created by air on 15/11/4.
//  Copyright © 2015年 ORANLLC_IOS1. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JYShareManager : NSObject
+(id)manager;
-(void)showSheetView:(UIViewController *)vc  withShareTitle:(NSString *)title withShareContent:(NSString *)content withShareImgUrl:(NSString *)contentFile withUrl:(NSString *)url;
-(void)showSheetView:(UIViewController *)vc withObserver:(id)observer withSel:(SEL)sel withShareTitle:(NSString *)title withShareContent:(NSString *)contentFile withUrl:(NSString *)url;
-(void)toShare:(UIButton *)btn ;
-(void)toShareWithIndex:(NSInteger)index withContent:(NSString *)content withTitle:(NSString *)title withUrl:(NSString *)url withContentFile:(NSString *)contentFile;
-(void)showSheetView:(UIViewController *)vc withObserver:(id)observer withSel:(SEL)sel withBtnTitle:(NSString *)btnTitle withShareTitle:(NSString *)title withContent:(NSString *)content withShareContent:(NSString *)contentFile withUrl:(NSString *)url;
@property (nonatomic,strong) void (^handAction ) (id o);
@end
