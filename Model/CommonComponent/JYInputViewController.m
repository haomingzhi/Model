//
//  JYInputViewController.m
//  ulife
//
//  Created by air on 16/1/9.
//  Copyright © 2016年 ORANLLC_IOS1. All rights reserved.
//

#import "JYInputViewController.h"

#import "WBEmoticonInputView.h"
#import "WBStatusHelper.h"
#import "WBStatusLayout.h"
#import "WBStatusComposeTextParser.h"
@interface JYInputViewController ()<WBStatusComposeEmoticonViewDelegate,YYTextKeyboardObserver,YYTextViewDelegate>
{

    IBOutlet UIView *_menuView;
    IBOutlet UIButton *_otherBtn;
    IBOutlet UIButton *_emotionBtn;
    IBOutlet YYTextView *_textView;
    CGFloat _keybordHeight;
    WBEmoticonInputView *_emotionView;
    NSInteger _mode;
     YYTextView *_curTextView;
    NSInteger _kHeight;
    UIView *_emContainerView;
    BOOL _hasSendBtn;
}
@end

@implementation JYInputViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initTextView];
    _kHeight = 216 - 9;
    _hasSendBtn = YES;
    _curTextView = _textView;
     [[YYTextKeyboardManager defaultManager] addObserver:self];
    [_emotionBtn setImage:[WBStatusHelper imageNamed:@"compose_emoticonbutton_background"] forState:UIControlStateNormal];
    [_emotionBtn setImage:[WBStatusHelper imageNamed:@"compose_emoticonbutton_background_highlighted"] forState:UIControlStateHighlighted];
    UILabel *lineLb = [[UILabel alloc] initWithFrame:CGRectMake(0, 0,__SCREEN_SIZE.width, 0.5)];
    lineLb.backgroundColor = kUIColorFromRGB(color_0xcdcdcd);
    [self.view addSubview:lineLb];
     [_textView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionOld context:nil];
    _textView.bounces = NO;
//    _menuView.hidden = YES;
//    _textView.tintColor = [UIColor redColor];
    UILabel *lineLb2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0,__SCREEN_SIZE.width, 0.5)];
    lineLb2.backgroundColor = kUIColorFromRGB(color_0xcdcdcd);
    [_menuView addSubview:lineLb2];
    _emContainerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, __SCREEN_SIZE.width, _kHeight)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)emotionHandle:(id)sender {
    if (_emContainerView && (_curTextView.inputView == _emContainerView)) {
        _curTextView.inputView = nil;
        [_curTextView resignFirstResponder];
        [_curTextView reloadInputViews];
        [_curTextView becomeFirstResponder];
        [_emotionBtn setImage:[WBStatusHelper imageNamed:@"compose_emoticonbutton_background"] forState:UIControlStateNormal];
        [_emotionBtn setImage:[WBStatusHelper imageNamed:@"compose_emoticonbutton_background_highlighted"] forState:UIControlStateHighlighted];
    } else {
     _emotionView = [WBEmoticonInputView sharedView];
        _emotionView.height = 216 - 48;
        _emContainerView.backgroundColor = _emotionView.backgroundColor;
        if (_hasSendBtn) {
            [self addSendBtn:self withSel:@selector(sendAction:)];
        }
        _emotionView.x = 0;
        _emotionView.y = 0;
        [_emContainerView addSubview:_emotionView];
        _emotionView.delegate = self;
        _curTextView.inputView = _emContainerView;
        [_curTextView resignFirstResponder];
        [_curTextView reloadInputViews];
        [_curTextView becomeFirstResponder];
        [_emotionBtn setImage:[WBStatusHelper imageNamed:@"compose_keyboardbutton_background"] forState:UIControlStateNormal];
        [_emotionBtn setImage:[WBStatusHelper imageNamed:@"compose_keyboardbutton_background_highlighted"] forState:UIControlStateHighlighted];
    }
    

}

-(void)sendAction:(UIButton *)btn
{
    if ([_delegate respondsToSelector:@selector(JYInputViewhandleAction:)]) {
        [_delegate JYInputViewhandleAction:_curTextView];
    }

}
#pragma mark @protocol WBStatusComposeEmoticonView
- (void)emoticonInputDidTapText:(NSString *)text {
    if (text.length) {
        [_curTextView replaceRange:_curTextView.selectedTextRange withText:text];
    }
}
- (void)emoticonInputDidTapBackspace {
    [_curTextView deleteBackward];
}

-(void)setBtnListImgs:(NSArray *)imgArr withTitles:(NSArray *)tArr
{
    [imgArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(10 + 50 * idx, 9, 45, 45)];
        btn.tag = idx + 300;
        [btn setImage:[UIImage imageContentWithFileName:obj] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(otherListBtnHandle:) forControlEvents:UIControlEventTouchUpInside];
        [_menuView addSubview:btn];
        if (tArr.count == imgArr.count) {
            UILabel *textLb = [[UILabel alloc] initWithFrame:CGRectMake(10 + 50 * idx, 55, 45, 19)];
            textLb.tag = idx + 400;
            textLb.text = tArr[idx];
            textLb.textColor = kUIColorFromRGB(color_0x999999);
            textLb.font = [UIFont systemFontOfSize:12];
            textLb.textAlignment = NSTextAlignmentCenter;
            [_menuView addSubview:textLb];
            _menuView.height = 80;
        }
       
    }];
}

-(void)otherListBtnHandle:(UIButton *)btn
{
    if ([_delegate respondsToSelector:@selector(JYListBtnHandleAction:withIndex:)]) {
        [_delegate JYListBtnHandleAction:btn withIndex:btn.tag - 300];
    }
}

- (IBAction)otherHandle:(id)sender {
    if (_curTextView.inputView == _menuView) {
        _curTextView.inputView = nil;
        [_curTextView resignFirstResponder];
        [_curTextView reloadInputViews];
        [_curTextView becomeFirstResponder];
//        [_emotionBtn setImage:[WBStatusHelper imageNamed:@"compose_emoticonbutton_background"] forState:UIControlStateNormal];
//        [_emotionBtn setImage:[WBStatusHelper imageNamed:@"compose_emoticonbutton_background_highlighted"] forState:UIControlStateHighlighted];
    } else {
//        WBEmoticonInputView *v = [WBEmoticonInputView sharedView];
//        v.delegate = self;
//        _curTextView.tintColor = [UIColor clearColor];
        _curTextView.inputView = _menuView;
        [_curTextView resignFirstResponder];
        [_curTextView reloadInputViews];
        [_curTextView becomeFirstResponder];
//        [_emotionBtn setImage:[WBStatusHelper imageNamed:@"compose_keyboardbutton_background"] forState:UIControlStateNormal];
//        [_emotionBtn setImage:[WBStatusHelper imageNamed:@"compose_keyboardbutton_background_highlighted"] forState:UIControlStateHighlighted];
    }
    [_emotionBtn setImage:[WBStatusHelper imageNamed:@"compose_emoticonbutton_background"] forState:UIControlStateNormal];
    [_emotionBtn setImage:[WBStatusHelper imageNamed:@"compose_emoticonbutton_background_highlighted"] forState:UIControlStateHighlighted];


//    if (_menuView.hidden) {
//        _menuView.width = __SCREEN_SIZE.width;
//        _menuView.x = 0;
//        _menuView.height = 50;
//        _menuView.y = __SCREEN_SIZE.height - 64 - _menuView.height;
//        [self.view.superview addSubview:_menuView];
//        self.view.y =  __SCREEN_SIZE.height - 64 - _menuView.height - 45;
//        _menuView.hidden = NO;
//    }
//    else
//    {
////        _menuView.width = __SCREEN_SIZE.width;
////        _menuView.x = 0;
////        _menuView.height = 50;
////        _menuView.y = __SCREEN_SIZE.height - 64 - _menuView.height;
////        [self.view.superview addSubview:_menuView];
//        self.view.y =  __SCREEN_SIZE.height - 64 - 45;
//        _menuView.hidden = YES;
//    }
    
}

- (BOOL)textViewShouldBeginEditing:(YYTextView *)textView
{
    if ([_delegate respondsToSelector:@selector(JYBeginEditing:)]) {
        [_delegate JYBeginEditing:textView];
    }
    return YES;
}

- (BOOL)textViewShouldEndEditing:(YYTextView *)textView
{
    if ([_delegate respondsToSelector:@selector(JYEndEditing:)]) {
        [_delegate JYEndEditing:textView];
    }
    return YES;
}

//- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
//{
//    if (action == @selector(paste:)||action == @selector(cut:))
//        return NO;
//    return [super canPerformAction:action withSender:sender];
//}

- (void)initTextView {
//    if (_textView) return;
    _textView = [YYTextView new];
    [self.view addSubview:_textView];
    _textView.x =10;
    _textView.y = 6;
    _textView.width = 237;
    _textView.height = 32;
    if (kSystemVersion < 7) _textView.top = -64;
    NSString *placeholderPlainText = @"评论";
    if (placeholderPlainText) {
        NSMutableAttributedString *atr = [[NSMutableAttributedString alloc] initWithString:placeholderPlainText];
        atr.color = UIColorHex(808080);
        atr.font = [UIFont systemFontOfSize:14];
        _textView.placeholderAttributedText = atr;
    }
    _textView.width = __SCREEN_SIZE.width - 88;
    _textView.textContainerInset = UIEdgeInsetsMake(3, 6, 3, 6);
//    _textView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
//    _textView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _textView.extraAccessoryViewHeight = 0;
    _textView.showsVerticalScrollIndicator = NO;
    _textView.alwaysBounceVertical = YES;
    _textView.allowsCopyAttributedString = NO;
    _textView.font = [UIFont systemFontOfSize:14];
    _textView.textParser = [WBStatusComposeTextParser new];
    _textView.delegate = self;
    _textView.inputAccessoryView = [UIView new];
    _textView.borderColor = kUIColorFromRGB(color_0xcdcdcd);
    _textView.borderWidth = 0.5;
    _textView.layer.cornerRadius = 8;
    _textView.returnKeyType = UIReturnKeySend;
    WBTextLinePositionModifier *modifier = [WBTextLinePositionModifier new];
    modifier.font = [UIFont fontWithName:@"Heiti SC" size:14];
    modifier.paddingTop = 9;
    modifier.paddingBottom = 6;
    modifier.lineHeightMultiple = 1.5;
    _textView.linePositionModifier = modifier;
    
//    [_textView layoutIfNeeded];

}

-(void)setPlaceholderText:(NSString *)str
{
    if (str) {
        NSMutableAttributedString *atr = [[NSMutableAttributedString alloc] initWithString:str];
        atr.color = UIColorHex(808080);
        atr.font = [UIFont systemFontOfSize:14];
        _textView.placeholderText = str;
    }
}

#pragma mark @protocol YYTextViewDelegate
- (void)textViewDidChange:(YYTextView *)textView {
//    if (_textView.contentSize.height > 132) {
//        return;
//    }
//     _textView.height = _textView.contentSize.height;
//    self.view.height = _textView.height + 12;
//    self.view.y = _keybordHeight  - 64 - self.view.height;
}



- (void)dealloc {
    [[YYTextKeyboardManager defaultManager] removeObserver:self];
//    if (_mode != 1) {
          [_textView removeObserver:self forKeyPath:@"contentSize"];
//    }
//    else
//    {
//        _textView.delegate = nil;
//        _textView = nil;
//    }
    
}

- (void)keyboardChangedWithTransition:(YYTextKeyboardTransition)transition {
    CGRect toFrame = transition.toFrame;//[[YYTextKeyboardManager defaultManager] convertRect:transition.toFrame toView:self.view];
    _keybordHeight = CGRectGetMinY(toFrame);
    if (CGRectGetMinY(toFrame) != __SCREEN_SIZE.height) {
        self.view.y = CGRectGetMinY(toFrame) - 64 - self.view.height;
        if ([_delegate respondsToSelector:@selector(keyBoardViewHeightChange:)]) {
            [_delegate keyBoardViewHeightChange:self.view.y];
        }
    } else {
//        [UIView animateWithDuration:transition.animationDuration delay:0 options:transition.animationOption | UIViewAnimationOptionBeginFromCurrentState animations:^{
            self.view.y = __SCREEN_SIZE.height - self.view.height - 64;
        if ([_delegate respondsToSelector:@selector(keyBoardViewHeightChange:)]) {
            [_delegate keyBoardViewHeightChange:self.view.y];
        }
//        } completion:NULL];
    }
}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"contentSize"]) {
          if(_textView.contentSize.height <= 32 && _textView.height <= 32)
            return;
        if (_textView.contentSize.height > 132) {
            return;
        }
        _textView.height = _textView.contentSize.height;
        self.view.height = _textView.height + 12;
        self.view.y = _keybordHeight  - 64 - self.view.height;
           [_textView setNeedsDisplay];
        _textView.height = _textView.contentSize.height;
    }
    
}

- (BOOL)textView:(YYTextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
//        [textView resignFirstResponder];
        if ([_delegate respondsToSelector:@selector(JYInputViewhandleAction:)]) {
            [_delegate JYInputViewhandleAction:textView];
        }
        return NO;
    }
    return YES;
}


-(void)setCommentMode
{
    _emotionBtn.x = __SCREEN_SIZE.width - 40;
    _textView.width = __SCREEN_SIZE.width - 10 - 50;
    _otherBtn.hidden = YES;
}


-(void)setAddWordMode:(YYTextView *)textView
{
//    _mode = 1;
    _emotionBtn.x = 10;
    [_textView setHidden:YES];
//    _textView = nil;
    _otherBtn.hidden = YES;
    _curTextView = textView;
    _curTextView.extraAccessoryViewHeight = 0;
    _curTextView.showsVerticalScrollIndicator = NO;
    _curTextView.alwaysBounceVertical = YES;
    _curTextView.allowsCopyAttributedString = NO;
    _curTextView.font = [UIFont systemFontOfSize:16];
    _curTextView.textParser = [WBStatusComposeTextParser new];
    _curTextView.delegate = self;
    _curTextView.inputAccessoryView = [UIView new];
//    _curTextView.borderColor = kUIColorFromRGB(color_0xcdcdcd);
//    _curTextView.borderWidth = 0.5;
//    _curTextView.layer.cornerRadius = 8;
//    _curTextView.returnKeyType = UIReturnKeySend;
    WBTextLinePositionModifier *modifier = [WBTextLinePositionModifier new];
    modifier.font = [UIFont fontWithName:@"Heiti SC" size:16];
    modifier.paddingTop = 9;
    modifier.paddingBottom = 6;
    modifier.lineHeightMultiple = 1.3;
    _curTextView.linePositionModifier = modifier;
 _curTextView.textContainerInset = UIEdgeInsetsMake(3, 6, 3, 6);
    _kHeight = 216 - 37;
    _hasSendBtn = NO;
    _emContainerView.height = _kHeight;
}
-(void)breakTextView
{
    _textView.delegate = nil;
    _textView = nil;
}
-(void)focurs
{
    [_curTextView becomeFirstResponder];
}
-(void)setEmotionViewHeight:(CGFloat)height
{
_emContainerView.height = 216 - 37;
}
-(void)addSendBtn:(id)target withSel:(SEL)sel
{
//    self.height = kViewHeight - 15;
    UIButton *btn = (UIButton *)[_emContainerView viewWithTag:998];
    if (!btn) {
        btn  = [[UIButton alloc] initWithFrame:CGRectMake(_emContainerView.width - 80, _emContainerView.height - 36, 80, 36)];
    }
  
    btn.backgroundColor = kUIColorFromRGB(color_mainTheme);
    [btn setTitle:@"发送" forState:UIControlStateNormal];
    btn.tag = 998;
    [_emContainerView addSubview:btn];
    [btn addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
