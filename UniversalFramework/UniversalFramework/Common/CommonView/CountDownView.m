//
//  CountDownView.m
//  UniversalFramework
//  倒计时试图
//  Created by ORANLLC_IOS1 on 15/10/29.
//  Copyright (c) 2015年 ORANLLC_IOS1. All rights reserved.
//

#import "CountDownView.h"


#define D_MINUTE	60
#define D_HOUR		3600
#define D_DAY		86400
#define D_WEEK		604800
#define D_YEAR		31556926

@implementation CountDownView
{
    UILabel *labelCountDown;
    NSString *_hintFormat;
    CGFloat countDownNum;
    UIColor *_markerColor;
    NSTimer *t;
    
}

+(id) shareInstance
{
    static CountDownView *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[CountDownView alloc] init];
    });
    return instance;
}

-(id) setFrame:(CGRect)frame andFormat:(NSString *)hintFormat countDownNum:(CGFloat)num font:(UIFont *)font color:(UIColor *)color markerColor:(UIColor *)markerColor
{
    labelCountDown = labelCountDown == NULL ? [[UILabel alloc ] initWithFrame:frame] : labelCountDown;
    labelCountDown.frame = frame;
    labelCountDown.textAlignment = NSTextAlignmentLeft;
    labelCountDown.textColor = color;
    labelCountDown.font = font;
    countDownNum = num;
    _hintFormat = hintFormat;
    _markerColor = markerColor;
    labelCountDown.attributedText = [self getcountDownStr];
    if (!labelCountDown.superview) {
        [self addSubview:labelCountDown];
    }
    return self;
}

-(NSAttributedString *) getcountDownStr
{
    return [self attachmentsForAttributedString:[[NSMutableAttributedString alloc] initWithString:_hintFormat ==0 ? @"" :_hintFormat attributes:@{NSFontAttributeName: labelCountDown.font}]];
}

/*
 * 查找所有表情文本并替换
 */
- (NSMutableAttributedString *)attachmentsForAttributedString:(NSMutableAttributedString *)attributedString
{
    NSString *markL       = @"[";
    NSString *markR       = @"]";
    NSString *string      = attributedString.string;
    NSMutableArray *stack = [[NSMutableArray alloc] init];
    
    int i =0;
    while (i < string.length) {
        NSString *s = [string substringWithRange:NSMakeRange(i, 1)];
        
        if (([s isEqualToString:markL]) || ((stack.count > 0) && [stack[0] isEqualToString:markL]))
        {
            if (([s isEqualToString:markL]) && ((stack.count > 0) && [stack[0] isEqualToString:markL]))
            {
                [stack removeAllObjects];
            }
            
            [stack addObject:s];
            
            if ([s isEqualToString:markR] || (i == string.length - 1))
            {
                NSMutableString *emojiStr = [[NSMutableString alloc] init];
                NSMutableString *emojiOri = [[NSMutableString alloc] init];
                for (int j =0; j < stack.count; j++) {
                    [emojiOri appendString:stack[j]];
                    if (j >=1 && j != stack.count -1) {
                        [emojiStr appendString:stack[j]];
                    }
                }
                //NSLog(@"emojiStr=%@",emojiStr);
                if ([@[@"yy",@"mm",@"dd",@"hh",@"mi",@"ss"] containsObject:emojiStr])
                {
                    NSRange range = NSMakeRange(i + 1 - emojiOri.length, emojiOri.length);
                    NSAttributedString *formatStr = [self formatOfCountDown:emojiStr];
                    [attributedString replaceCharactersInRange:range withAttributedString:formatStr];
                    i -= 4;
                    
                }
                [stack removeAllObjects];
            }
        }
        i++;
    }
    return attributedString;
}

/**
 *  格式化倒计时
 *
 *  @param format 格式化方式 yy mm dd hh mi ss
 *
 *  @return 格式化后的倒计时
 */
-(NSAttributedString *) formatOfCountDown:(NSString *) format
{
    NSString *formatStr;
    NSArray *formatList = @[@"yy",@"mm",@"dd",@"hh",@"mi",@"ss"];
    NSArray *minList = @[@(D_YEAR),@(D_DAY),@(D_DAY),@(D_HOUR),@(D_MINUTE),@(1)];
    NSInteger index = [formatList indexOfObject:format];
    if (index == NSNotFound) {
        formatStr = @"";
    }
    else {
        NSInteger num = countDownNum / [minList[index] integerValue];
        if (index ==1) {
            formatStr = [NSString stringWithFormat:@"%02ld",num/30];
        }
        else if (index ==2)
            formatStr = [NSString stringWithFormat:@"%02ld",num%30];
        else if (index ==3)
            formatStr = [NSString stringWithFormat:@"%02ld",num%24];
        else formatStr = [NSString stringWithFormat:@"%02ld",num%60];
    }
    return [[NSAttributedString alloc] initWithString:formatStr attributes:@{NSFontAttributeName: labelCountDown.font,NSForegroundColorAttributeName:_markerColor}];
}

-(void) startCountDown
{
    t = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(handleTimeout:) userInfo:nil repeats:YES];
    [t fire];
}

-(void) endCountDown
{
    [t invalidate];
}

-(void)handleTimeout:(NSTimer*)tm
{
    labelCountDown.attributedText = [self getcountDownStr];
    countDownNum--;
    if (countDownNum <=0) {
        [self endCountDown];
    }
}
@end
