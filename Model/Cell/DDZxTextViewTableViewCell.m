//
//  DDZxTextViewTableViewCell.m
//  DDZX_js
//
//  Created by apple on 2018/8/27.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import "DDZxTextViewTableViewCell.h"
#import "UIView+NTES.h"
#import "DDTextView.h"

@interface DDZxTextViewTableViewCell()
@property(nonatomic,strong)DDTextView *textView;
@end

@implementation DDZxTextViewTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.textView];
 
    }
    return self;
}

-(DDTextView *)textView
{
    if (!_textView) {
        _textView = [DDTextView new];
        _textView.height = 74;
        _textView.isHiddenLimt = YES;
        _textView.width = UIScreenWidth - 36;
        _textView.layer.cornerRadius = 6;
        _textView.layer.masksToBounds = YES;
        _textView.layer.borderColor = UIColorFromRGB(0xE5E5E5).CGColor;
        _textView.layer.borderWidth = 0.5;
        _textView.textChangeCallBack = self.textChangeCallBack;
    }
    return _textView;
}

-(void) setTextChangeCallBack:(void (^)(NSDictionary *))textChangeCallBack
{
    _textView.textChangeCallBack = textChangeCallBack;
    _textChangeCallBack = textChangeCallBack;
}

-(void)setText:(NSString *)text
{
    _textView.text = text;
    
}

-(NSString *)text
{
    return _textView.text;
}

-(void)refresh:(NSDictionary *)dic
{
    _textView.text = dic[@"text"];
    _textView.placeholderLb.text = dic[@"placeholder"];
    _textView.placeholderLb.width = UIScreenWidth - 60;
    if (UIScreenWidth == 320) {
        _textView.placeholderLb.font = [UIFont systemFontOfSize:12];
    }
    if([dic[@"showLimit"] boolValue])
    {
         _textView.isHiddenLimt = NO;
    }
    if(dic[@"limitCount"])
    {
        _textView.limitCount = [dic[@"limitCount"] integerValue];
    }
        
    [self setNeedsLayout];
   
}

-(void)layoutSubviews
{
    [super layoutSubviews];
  
    _textView.left = 18;
    _textView.top = 7;
       _textView.height = self.height - 7 - 15;
}

@end
