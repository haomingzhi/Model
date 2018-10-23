//
//  NSMutableAttributedString+Strikeout.h
//  JiXie
//
//  Created by air on 15/5/26.
//  Copyright (c) 2015年 ORANLLC_IOS1. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableAttributedString (JYExtension)
-(NSMutableAttributedString *)strikeoutWithRange:(NSRange) aRange;//指定位置范围加删除线
-(NSMutableAttributedString *)strikeout;
-(NSMutableAttributedString *)redColorText;
-(NSMutableAttributedString *)redColorTextWithRange:(NSRange)aRange;
-(NSMutableAttributedString *)baseColorSet:(UIColor *)color withRange:(NSRange)aRange;
-(NSMutableAttributedString *)baseFontSet:(UIFont *)font withRange:(NSRange)aRange;
-(NSMutableAttributedString *)commonFont;
-(NSMutableAttributedString *)font:(UIFont*)font;
@end
