//
//  OnlyTextViewTableViewCell.m
//  ChaoLiu
//
//  Created by air on 15/8/6.
//  Copyright (c) 2015年 ORANLLC_IOS1. All rights reserved.
//

#import "TextViewCountTableViewCell.h"
const NSInteger commentMaxLength = 255;

//@interface OnlyTextViewTableViewCell() <UITextViewDelegate>
//
//@end

@implementation TextViewCountTableViewCell
{
    IBOutlet UILabel *_labelCommentLength;
    NSString *_placeholder;
    IBOutlet MyTextView *_textViewContent;
}
- (void)awakeFromNib {
    // Initialization code
    _textViewContent.borderWidth = 0;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewEditChanged:) name:UITextViewTextDidChangeNotification object:_textViewContent];

    
 }

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
#pragma mark -- UITextViewDelegate
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if (textView == _textViewContent) {
        if ([text isEqualToString:@"\n"] || [text isEqualToString:@""])
        {//删除
            if (range.location == 0) {
                _textViewContent.placeholder.hidden = NO;
            }
            else
            {
             _textViewContent.placeholder.hidden = YES;
            }
            _labelCommentLength.text = [NSString stringWithFormat:@"还可以输入%lu个字",commentMaxLength - range.location];
            return YES;
        }
        NSString *new = [textView.text stringByReplacingCharactersInRange:range withString:text];
        if(new.length > commentMaxLength){
            return NO;
            
        }
    }
    
    return YES;
}
// 监听文本改
-(void)textViewEditChanged:(NSNotification *)obj{
    UITextView *textView = (UITextView *)obj.object;
    NSString *toBeString = textView.text;
    NSString *lang = [textView.textInputMode primaryLanguage]; // 键盘输入模式
    if ([lang isEqualToString:@"zh-Hans"]) { // 简体中文输入，包括简体拼音，健体五笔，简体手写
        UITextRange *selectedRange = [textView markedTextRange];
        //获取高亮部分
        UITextPosition *position = [textView positionFromPosition:selectedRange.start offset:0];
        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if (!position) {
            if (toBeString.length > commentMaxLength) {
                textView.text = [toBeString substringToIndex:commentMaxLength];
            }
        }
        // 有高亮选择的字符串，则暂不对文字进行统计和限制
        else{
        }
    }
    // 中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
    else{
        if (toBeString.length > commentMaxLength) {
            textView.text = [toBeString substringToIndex:commentMaxLength];
        }
    }
    _labelCommentLength.text = [NSString stringWithFormat:@"还可以输入%lu个字",commentMaxLength - textView.text.length];
    if (self.handleAction) {
        self.handleAction(_textViewContent.text);
    }
}

-(void)dealloc
{

    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextViewTextDidChangeNotification object:_textViewContent];
}

-(void)setCellData:(NSDictionary *)dataDic
{
//    _textViewContent.kbMovingView =  dataDic[@"moveView"];
    UITableView *tableView = dataDic[@"tableView"];
    _textViewContent.kbMovingView = tableView ? tableView : self.superview.superview;
    _textViewContent.textDelegate = self;
//    _textViewContent.placeholder = [[UILabel alloc] init];
    _textViewContent.placeholder.textColor = kUIColorFromRGB(color_unSelColor);
    _textViewContent.textColor = [UIColor grayColor];
    _textViewContent.placeholder.font = [UIFont systemFontOfSize:16];
    _textViewContent.placeholder.frame = CGRectMake(8,_textViewContent.placeholder.frame.origin.y, __SCREEN_SIZE.width -16, _textViewContent.placeholder.frame.size.height);
    _textViewContent.textColor = [UIColor darkGrayColor];
    _labelCommentLength.textColor = [[UIColor grayColor] colorWithAlphaComponent:0.89];
    _textViewContent.placeholder.text = @"分享此刻你的心情";
//    _placeholder = dataDic[@"placeholder"];
    _textViewContent.text = dataDic[@"text"];
//     _textViewContent.placeholder.text = dataDic[@"placeholder"];
      [super setCellData:dataDic];
}


-(MyTextView *)textView
{
  return  _textViewContent;
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if (_handleTextViewDidBeginEditing) {
        _handleTextViewDidBeginEditing(textView);
    }
}

@end
