//
//  UILabel+AttributedText.h
//  MiniClient
//
//  Created by Apple on 15-1-4.
//  Copyright (c) 2015年 SunnadaSoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (AttributedText)

-(void)strikeout;
-(void)strikeout:(NSInteger)start withLength:(NSInteger)length;
-(NSAttributedString *)richText:(NSString *)text color:(UIColor *) color;
-(NSAttributedString *)richText:(UIFont *) font text:(NSString *)text color:(UIColor *) color;
-(void)richText:(UIFont *) font text:(NSString *)text color:(UIColor *) color bgColor:(UIColor *) bgColor;

-(void)richTextMany:(NSString *)text color:(UIColor *) color;
-(NSMutableAttributedString*) getAttributedString:(UIFont *) font text:(NSString *)text color:(UIColor *) color;
-(NSMutableAttributedString*) getAttributedString:(UIFont *) font text:(NSString *)text color:(UIColor *) color attrStr:(NSAttributedString *)attrStr;
+(NSMutableAttributedString*) getAttributedString:(UIFont *) font text:(NSString *) text rictText:(NSString *)richText color:(UIColor *) color attrStr:(NSAttributedString *)attrStr;

//不同字体样式
-(NSMutableAttributedString *)getDifferFontAttributedString:(NSString *)text color:(UIColor *)color size:(float)size;
/**
 *  设置UILabel后缀，如果长度不足的时候，后缀一定要显示
 *
 *  @param suffix 后缀字符串
 */
-(void) setSuffix:(NSString *) suffix;
-(void)setHtmlStr:(NSString *)html;//UILabel显示HTML文本
-(void)richMText:(NSString *)text color:(UIColor *) color withFont:(UIFont *)font;
@end
