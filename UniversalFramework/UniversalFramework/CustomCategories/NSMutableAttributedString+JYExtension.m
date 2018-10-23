//
//  NSMutableAttributedString+Strikeout.m
//  JiXie
//
//  Created by air on 15/5/26.
//  Copyright (c) 2015年 ORANLLC_IOS1. All rights reserved.
//

#import "NSMutableAttributedString+JYExtension.h"

@implementation NSMutableAttributedString (JYExtension)
-(NSMutableAttributedString *)strikeoutWithRange:(NSRange) aRange
{
//    NSString *text =  self.string;
    //    NSUInteger length = [text length];
    
    NSMutableAttributedString *attri = self;//[[NSMutableAttributedString alloc] initWithString:text];
    [attri addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:aRange];
    //    [attri addAttribute:NSStrikethroughColorAttributeName value:self.textColor range:NSMakeRange(0, length)];
    return attri;
}

-(NSMutableAttributedString *)strikeout
{
   return [self strikeoutWithRange:NSMakeRange(0, self.length)];
}

-(NSMutableAttributedString *)redColorText
{
    return [self redColorTextWithRange:NSMakeRange(0, self.length)];
}

-(NSMutableAttributedString *)redColorTextWithRange:(NSRange)aRange
{
    return [self baseColorSet:[UIColor redColor] withRange:aRange];
}

-(NSMutableAttributedString *)baseColorSet:(UIColor *)color withRange:(NSRange)aRange
{
    NSMutableAttributedString *attri = self;//[[NSMutableAttributedString alloc] initWithString:self.string];
     [attri addAttribute:NSForegroundColorAttributeName value:color range:aRange];
    return attri;
}

-(NSMutableAttributedString *)baseFontSet:(UIFont *)font withRange:(NSRange)aRange
{
    NSMutableAttributedString *attri = self;//[[NSMutableAttributedString alloc] initWithString:self.string];
    [attri addAttribute:NSFontAttributeName value:font range:aRange];
    return attri;
}

-(NSMutableAttributedString *)commonFont
{
   return  [self baseFontSet:[UIFont systemFontOfSize:14] withRange:NSMakeRange(0, self.length)];
}

-(NSMutableAttributedString *)font:(UIFont*)font
{
return  [self baseFontSet:font withRange:NSMakeRange(0, self.length)];
}


@end
