//
//  DDTextView.m
//  NIM
//
//  Created by apple on 2018/7/30.
//  Copyright © 2018年 Netease. All rights reserved.
//

#import "DDTextView.h"
#import "UIView+NTES.h"
@interface DDTextView()<UITextViewDelegate>
@property(nonatomic,strong)UITextView *textView;

@property(nonatomic,strong)UILabel *limitLb;
@property(nonatomic,assign)NSInteger curCount;
@end

@implementation DDTextView
-(id)init
{
    self = [super init];
    if (self) {
        [self addSubview:self.textView];
        [self addSubview:self.placeholderLb];
        [self addSubview:self.limitLb];
        self.textView.delegate = self;
        //        [self.textView addObserver:self forKeyPath:@"text" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    }
    return self;
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"text"]) {
        _curCount = self.textView.text.length;
        [self setNeedsLayout];
    }
}
- (void)textViewDidChange:(UITextView *)textView
{
    _curCount = self.textView.text.length;
    if (_limitCount > 0 && _curCount >= _limitCount) {
        _curCount = _limitCount;
        self.textView.text = [self.textView.text substringToIndex:_limitCount];
    }
    if (_textChangeCallBack) {
        _textChangeCallBack(@{@"obj":textView});
    }
    [self setNeedsLayout];
}
-(void)dealloc
{
    self.textView.delegate  = nil;
    //    [self.textView removeObserver:self forKeyPath:@"text"];
}

-(void)setText:(NSString *)text
{
    _textView.text = text;
    _curCount = text.length;
    [self setNeedsLayout];
}

-(NSString *)text
{
    return  _textView.text;
}

-(UITextView *)textView
{
    if (!_textView) {
        _textView = [UITextView new];
        _textView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _textView.textContainer.lineFragmentPadding = 12;
//        _textView.textContainerInset =
    }
    return _textView;
}

-(void)setIsHiddenLimt:(BOOL)isHiddenLimt
{
    self.limitLb.hidden = isHiddenLimt;
    _isHiddenLimt = isHiddenLimt;
}

-(UILabel *)placeholderLb
{
    if (!_placeholderLb) {
        _placeholderLb = [UILabel new];
        _placeholderLb.width = 260;
        _placeholderLb.height = 20;
        _placeholderLb.text = @"发表问题，让大家来围观";
        _placeholderLb.textColor = UIColorFromRGB(0xE5E5E5);
        _placeholderLb.font = [UIFont systemFontOfSize:14];
        
    }
    return _placeholderLb;
}

-(UILabel *)limitLb
{
    if (!_limitLb) {
        _limitLb = [UILabel new];
        _limitLb.width = 120;
        _limitLb.height = 20;
        _limitLb.textColor = UIColorFromRGB(0xE5E5E5);
        _limitLb.font = [UIFont systemFontOfSize:14];
        _limitLb.textAlignment = NSTextAlignmentRight;
        
        
    }
    return _limitLb;
}

-(void)layoutSubviews
{
    _textView.height = self.height;
    _textView.width = self.width;
    _limitLb.text = [NSString stringWithFormat: @"%ld/%ld",_curCount ,_limitCount];
    _limitLb.top = self.height - 30;
    _limitLb.left = self.width - 18 - _limitLb.width;
    
    _placeholderLb.left = 18;
    _placeholderLb.top = 5;
    
    if (_curCount > 0) {
        _placeholderLb.hidden = YES;
    }
    else
    {
        _placeholderLb.hidden = NO;
    }
}
-(void)setLimitCount:(NSInteger)limitCount
{
    _limitCount = limitCount;
    [self setNeedsLayout];
}

-(BOOL)becomeFirstResponder
{
    return [_textView becomeFirstResponder];
    
}
@end
