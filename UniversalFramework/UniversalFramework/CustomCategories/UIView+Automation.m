//
//  UIView+Automation.m
//  JiXie
//
//  Created by ORANLLC_IOS1 on 15/6/30.
//  Copyright (c) 2015年 ORANLLC_IOS1. All rights reserved.
//

#import "UIView+Automation.h"

@implementation UIView (Automation)

//默认检测 MytextField,MyInputView,UITextView
-(BOOL) emptyCheck
{
    return [self emptyCheck:@[NSClassFromString(@"UITextField"),NSClassFromString(@"UITextView") ]];
}
//请输入、请选择开头
-(NSString *) getNameFromplaceHolder:(NSString *) placeHolder
{
    NSArray *prefixList = @[@"请输入",@"请选择",@"请填写"];
    for (NSString *prefix in prefixList) {
        if ([placeHolder hasPrefix:prefix]) {
            return [placeHolder substringFromIndex:prefix.length];
        }
    }
    return placeHolder;
}
-(BOOL) emptyCheck :(NSArray *) classList
{
    __block BOOL result = TRUE;
    [BSUtility loopView:self condition:^BOOL(UIView * view) {
        for (Class c in classList) {
            if ([view isKindOfClass:c]) {
                NSString *text = [view valueForKey:@"text"];
                if (text.length ==0) {
                    NSString *placeHolder;
                    if ([[view valueForKey:@"placeholder"] isKindOfClass:[UILabel class]])
                    {
                        UILabel *l = (UILabel *) [view valueForKey:@"placeholder"];
                        placeHolder = l.text;
                    }
                    else
                        placeHolder = [view valueForKey:@"placeholder"];
                    NSString *emptyHint = placeHolder.length ==0 || [self getNameFromplaceHolder:placeHolder] == NULL ? @"信息不完整" : [NSString stringWithFormat:@"%@不能为空",[self getNameFromplaceHolder:placeHolder]];
                    TOASTSHOWUNDERVIEW(emptyHint, view, CGPointMake(0,10));
                    result = FALSE;
                    break;
                }
            }
        }
        return YES;
    } finded:^BOOL(UIView *findedView) {
        return !result;
    }];
    return result;
}

-(void) clearTextField
{
    for (int i =0; i < self.subviews.count; i++) {
        UIView *tmpView = [self.subviews objectAtIndex:i];
        [self clearTextField:tmpView];
    }
}
-(void)clearTextField:(UIView *)checkView
{
    if ([checkView isKindOfClass:[UITextField class]]) {
        UITextField *mytextField =(UITextField *)checkView;
        mytextField.text = @"";
        
    }
    for (int i =0; i < checkView.subviews.count; i++) {
        [self clearTextField:[checkView.subviews objectAtIndex:i ]];
        
    }
}



-(void) autoFill:(id)object
{
    UIViewController *vc = [BSUtility viewController:self];
    NSArray * plist = [object getPropertyList];
    for (NSString *pItem in plist) {
        NSString *mapItem = [vc propertyMap:pItem];
        if (mapItem.length >0) //匹配成功
        {
            id v = [vc valueForKey:mapItem];
            if ([v isKindOfClass:[UITextField class]] ||[ v isKindOfClass:[UITextView class]] || [v isKindOfClass:[UILabel class]]) {
                id kv = [object valueForKey:pItem];
                if ([kv isKindOfClass:[NSString class]]) {
                    [v setValue:kv forKey:@"text"];
                }
                else if ([kv isKindOfClass:[NSNumber class]]) {
                    [v setValue:((NSNumber *) kv).stringValue forKey:@"text"];
                }
                
            }
            if ([v isKindOfClass:[UIImageView class]]) {
            
            }
        }
        
        
    }
    
}

//自动设置kbMoving
-(void) autokbMovingView
{
    [BSUtility loopView:self condition:^BOOL(UIView * view) {
        if ([view isKindOfClass:[MyTextField class]] || [view isKindOfClass:[MyTextView class]]) {
            if ([view isKindOfClass:[MyTextField class]]) {
                MyTextField *f = (MyTextField *) view;
                f.kbMovingView = self;
            }
            if ([view isKindOfClass:[MyTextView class]]) {
                MyTextView *v = (MyTextView *)view;
                v.kbMovingView = self;
            }
        }
        return YES;
    } finded:^BOOL(UIView *findedView) {
        return false;
    }];
}

@end
