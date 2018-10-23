//
//  TextViewCanChangeTableViewCell.m
//  yihui
//
//  Created by air on 15/9/10.
//  Copyright (c) 2015年 ORANLLC_IOS1. All rights reserved.
//

#import "TextViewTableViewCell.h"


@interface TextViewTableViewCell ()

@property (nonatomic,weak) IBOutlet MyTextView *textView;

@end


@implementation TextViewTableViewCell

- (void)awakeFromNib {
    // Initialization code
    _textView.width = __SCREEN_SIZE.width;
    self.width = __SCREEN_SIZE.width;
    [_textView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionOld context:nil];
    _textView.textDelegate = self;
}


- (void)textViewDidChange:(UITextView *)textView
{
 
  if(self.handleAction)
  {
      NSDictionary *dic = @{@"text":_textView.text};
      self.handleAction(dic);
  }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setCellData:(NSDictionary *)dataDic
{
    CGFloat minHeight = [dataDic[TextViewTableViewCell_minHeight] floatValue];
    _textView.text = dataDic[TextViewTableViewCell_text];
    _textView.placeholder.text = dataDic[TextViewTableViewCell_placeholder];
    _textView.kbMovingView=dataDic[TextViewTableViewCell_tableview];
    _textView.placeholder.textColor = kUIColorFromRGB(color_unSelColor);
    _textView.placeholder.font = [UIFont systemFontOfSize:14];
    _textView.placeholder.frame = CGRectMake(8,6,_textView.frame.size.width-16,_textView.placeholder.frame.size.height);
    _textView.height = MAX(_textView.contentSize.height, minHeight);
    self.height = _textView.height;
    [super setCellData:dataDic];
    
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"contentSize"]) {
        if(_textView.contentSize.height <= _textView.height)
            return;
        _textView.height = _textView.contentSize.height;
        self.height = _textView.height;
    }
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"] || [text isEqualToString:@""])
    {//删除

        return YES;
    }
    return YES;
}

-(UITextView *)textView
{
    return _textView;
}


-(void)dealloc
{
    [_textView removeObserver:self forKeyPath:@"contentSize"];
//    [_tap.view removeGestureRecognizer:_tap];
    NSLog(@"test tp dealloc");
}

-(id)heightOfCell
{
    return @(self.height);
}
@end
