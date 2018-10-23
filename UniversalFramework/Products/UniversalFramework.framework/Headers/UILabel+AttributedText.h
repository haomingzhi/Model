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

-(void)richText:(NSString *)text color:(UIColor *) color;
-(void)richText:(UIFont *) font text:(NSString *)text color:(UIColor *) color;

-(NSMutableAttributedString*) getAttributedString:(UIFont *) font text:(NSString *)text color:(UIColor *) color;
-(NSMutableAttributedString*) getAttributedString:(UIFont *) font text:(NSString *)text color:(UIColor *) color attrStr:(NSAttributedString *)attrStr;

@end
