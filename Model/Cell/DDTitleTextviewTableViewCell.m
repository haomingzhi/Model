//
//  DDTitleTextviewTableViewCell.m
//  DDZX_js
//
//  Created by apple on 2018/9/18.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import "DDTitleTextviewTableViewCell.h"
#import "UIView+NTES.h"
@interface DDTitleTextviewTableViewCell()<UITextViewDelegate>
@property(nonatomic,strong)UILabel *titleLb;
@property(nonatomic,strong)UITextField *textTf;
@property(nonatomic,assign)NSInteger limitCount;
@property(nonatomic,strong)UILabel *placeholderLb;
@property(nonatomic,assign)NSInteger curCount;
@property(nonatomic,strong)UIScrollView *scrollView;
@end

@implementation DDTitleTextviewTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.titleLb];        
        [self.contentView addSubview:self.scrollView];
        [self.scrollView addSubview:[UIView new]];
        [self.scrollView addSubview:self.textTf];
        
//        [self.textTf addSubview:self.placeholderLb];
    }
    return self;
}

-(UILabel *)titleLb
{
    if (!_titleLb) {
        _titleLb = [UILabel new];
        _titleLb.font = [UIFont systemFontOfSize:14];
        _titleLb.textColor = UIColorFromRGB(0x3A424D);
    }
    return _titleLb;
}

-(UITextField *)textTf
{
    if (!_textTf) {
        _textTf = [UITextField new];
        _textTf.font = [UIFont systemFontOfSize:14];
        _textTf.textColor = UIColorFromRGB(0x3A424D);
        _textTf.textAlignment = NSTextAlignmentRight;
        [_textTf addTarget:self action:@selector(textViewDidChange:) forControlEvents:UIControlEventEditingChanged];
//        _textTf.delegate = self;
//        _textTf.textContainer.lineFragmentPadding = 0.0;
//        _textTf.alwaysBounceHorizontal = YES;
        //去除上下边距
//        _textTf.textContainer.maximumNumberOfLines = 1;
//        _textTf.textContainer.lineBreakMode = NSLineBreakByTruncatingHead;
//        _textTf.textContainerInset = UIEdgeInsetsZero;
    }
    return _textTf;
}
- (void)textViewDidChange:(UITextView *)tf
{
    _curCount = tf.text.length;
    if (_limitCount > 0) {
        if (_limitCount < tf.text.length) {
            tf.text = [tf.text substringToIndex:_limitCount];
             _curCount = tf.text.length;
        }
        
    }
    if (_textChangeallBack) {
        _textChangeallBack(@{@"obj":tf});
    }
        [self setNeedsLayout];
}

-(void)dealloc
{
    _textTf.delegate = nil;
}
-(UILabel *)placeholderLb
{
    if (!_placeholderLb) {
        _placeholderLb = [UILabel new];
        _placeholderLb.width = 110;
        _placeholderLb.height = 16;
        _placeholderLb.text = @"";
        _placeholderLb.textColor = UIColorFromRGB(0xE5E5E5);
        _placeholderLb.font = [UIFont systemFontOfSize:14];
        _placeholderLb.textAlignment = NSTextAlignmentRight;
    }
    return _placeholderLb;
}

-(UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [UIScrollView new];
        _scrollView.bounces = NO;
         [_scrollView setContentSize:CGSizeMake(self.textTf.width, 20)];
        _scrollView.alwaysBounceVertical = NO;
    }
    return _scrollView;
}

-(void)refresh:(NSDictionary *)dic
{
    self.titleLb.text = dic[@"title"];
    self.textTf.text = dic[@"text"];
//    self.placeholderLb.text = dic[@"placeholder"];
    self.textTf.placeholder = dic[@"placeholder"];
    if(dic[@"limit"])
    {
        _limitCount = [dic[@"limit"] integerValue];
    }
    _curCount = self.textTf.text.length;
    if (dic[@"mark"]) {
        NSString *st = dic[@"title"];
        NSRange rg = [st rangeOfString:dic[@"mark"]];
        NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:st];
        [attrStr addAttribute:NSForegroundColorAttributeName
                        value:UIColorFromRGB(0x3A424D)
                        range:NSMakeRange(0, attrStr.length)];
        [attrStr addAttribute:NSForegroundColorAttributeName
                        value:UIColorFromRGB(0xDC4141)
                        range:rg];
        _titleLb.attributedText =  attrStr;
    }
    [self setNeedsLayout];
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    return NO;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    self.titleLb.width = 100;
    self.titleLb.height = 20;
    self.titleLb.left = 18;
    self.titleLb.centerY = self.height/2.0;
    
    self.scrollView.width = self.width/2.0 + 40;
    self.scrollView.height = 34;
    self.scrollView.left = self.width - 18 - self.scrollView.width;
    self.scrollView.centerY = self.height/2.0;
    if (@available(iOS 11.0, *)) {
        
        self.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        
        
    }else {
        
    }
    
    self.textTf.width = self.width/2.0 + 40;
    self.textTf.height = 25;
//    self.textTf.centerY = self.height/2.0;
//    self.textTf.left = self.width - 18 - self.textTf.width;
    _placeholderLb.left = _textTf.width - _placeholderLb.width;
    _placeholderLb.top = 2;
//    NSMutableDictionary *attrDict = [NSMutableDictionary dictionary];
//    attrDict[NSFontAttributeName] = [UIFont systemFontOfSize:14];
//    CGSize tcsz = [_textTf.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:attrDict context:nil].size;
//    CGSize tcsz = [_textTf.text sizeWithFont: [UIFont boldSystemFontOfSize:15]
//                             constrainedToSize: CGSizeMake(327.0f, 9999999.0f)
//                                 lineBreakMode: UILineBreakModeClip];
//    [_textTf setContentSize:tcsz];
//    if (_textTf.contentSize.height <= _textTf.frame.size.height) {
//
//        [_textTf setUserInteractionEnabled:NO];
//    }
    if (_curCount > 0) {
        _placeholderLb.hidden = YES;
    }
    else
    {
        _placeholderLb.hidden = NO;
    }
    self.textTf.width = MAXFLOAT;
    [self.textTf sizeToFit];
    self.textTf.width = MAX(self.textTf.width, self.scrollView.width);
    self.textTf.height = 25;
    [self.scrollView setContentSize:CGSizeMake(self.textTf.width, 20)];
    [_scrollView setContentOffset:CGPointMake(CGRectGetWidth(_textTf.bounds) -CGRectGetWidth(_scrollView.bounds), 0) animated:NO];
}
@end
