//
//  TextViewCanChangeTableViewCell.m
//  yihui
//
//  Created by air on 15/9/10.
//  Copyright (c) 2015年 ORANLLC_IOS1. All rights reserved.
//

#import "TextViewCanChangeTableViewCell.h"
#import "JYCommonTool.h"
@implementation TextViewCanChangeTableViewCell
{
    UITapGestureRecognizer *_tap;
    IBOutlet MyTextView *_textView;
    NSIndexPath *_indexPath;
    CGFloat _oHeight;
    NSRange _posRange;
    NSInteger _maxCount;
    BOOL _canChange;
     NSInteger _curCount;
    IBOutlet UILabel *_countTipLb;
}
- (void)awakeFromNib {
    // Initialization code
    _textView.width = __SCREEN_SIZE.width;
    self.width = __SCREEN_SIZE.width;
    //    [_textView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
    _textView.textDelegate = self;
    
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    //    _posRange = textView.selectedRange;
    if (!_tap) {
        _tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapHandle:)];
    }
    [self.window addGestureRecognizer:_tap];
    return YES;
}
//- (void)textViewDidChangeSelection:(UITextView *)textView
//{
// _posRange = textView.selectedRange;
//}
-(void)tapHandle:(UITapGestureRecognizer *)tap
{
    [tap.view removeGestureRecognizer:tap];
    [self endEditing:YES];
}

- (void)textViewDidChange:(UITextView *)textView
{
    if(textView.markedTextRange != nil)
        return;
    if (textView.text.length > _maxCount) {
        textView.text = [textView.text substringToIndex:_maxCount];
    }
     _curCount = textView.text.length;
    _countTipLb.text = [NSString stringWithFormat:@"%ld/%ld",_curCount,_maxCount];
    if(self.handleAction)
    {
        NSDictionary *dic = @{@"text":_textView.text,@"indexPath":_indexPath?:[NSNull new]};
        self.handleAction(dic);
        //      _textView.height = MAX(_textView.contentSize.height + 80, (_minHeight == 0?30:_minHeight));
        //      _oHeight = self.height;
        //      self.height = _textView.height + 1 + _textView.y;
        //       textView.selectedRange = _posRange;
        //      if( _oHeight != self.height)
        //      {
        //         //NSMakeRange(textView.text.length, 0);
        //           CGPoint cursorPosition = [textView caretRectForPosition:textView.selectedTextRange.start].origin;
        //          NSValue *v = [NSValue valueWithCGPoint:cursorPosition];
        ////          _posRange = textView.selectedRange;
        //          NSValue *vr = [NSValue valueWithRange:_posRange];
        //           NSDictionary *dic = @{@"text":_textView.text,@"indexPath":_indexPath?:[NSNull new],@"point":v,@"range":vr};
        //      self.handleAction(dic);
        //      }
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

-(void)setCellData:(NSDictionary *)dataDic
{
    _textView.userInteractionEnabled = dataDic[@"canwrite"] == NULL ? YES : [dataDic[@"canwrite"] boolValue];
    //    CGFloat minHeight = [dataDic[@"minHeight"] floatValue];
    
    _textView.text = dataDic[@"text"];
    _indexPath = dataDic[@"indexPath"];
    if (dataDic[@"placeholder"]) {
        _textView.placeholder.text = dataDic[@"placeholder"];
    }
    
    //    _textView.kbMovingView=dataDic[@"tableView"];
    _textView.placeholder.textColor = kUIColorFromRGB(color_unSelColor);
    _textView.placeholder.font = [UIFont systemFontOfSize:14];
    _textView.placeholder.frame = CGRectMake(8,6,_textView.frame.size.width-16,_textView.placeholder.frame.size.height);
    
    //     _textView.height = MAX(_textView.contentSize.height, minHeight);
    //      self.height = _textView.height;
    
    
    if (dataDic[@"textViewPadding"]) {
        NSValue *n = dataDic[@"textViewPadding"];
        UIEdgeInsets s;
        [n getValue:&s];
        _textView.contentInset = s;
    }
    
//    [super setCellData:dataDic];
    
}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"contentSize"]) {
        if(_textView.contentSize.height <= _textView.height)
            return;
        if(self.handleAction)
        {
            NSDictionary *dic = @{@"text":_textView.text?:@"",@"indexPath":_indexPath?:[NSIndexPath indexPathForRow:0 inSection:0],@"refresh":@(YES)};
            _textView.height = MAX(_textView.contentSize.height  + 80, (_minHeight == 0?30:_minHeight));
            _oHeight = self.height;
            self.height = _textView.height + 1 + _textView.y;
            if (_oHeight != self.height) {
                
                
                //            [(UITableView *)self.superview.superview reloadData];
                self.handleAction(dic);
            }
        }
        
        
    }
    
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    //     _posRange = NSMakeRange(textView.selectedRange.location - 1,0);
    if ([textView.text length] > _maxCount) {//判断字符个数
        return NO;
    }
     if([JYCommonTool isAllChinese:text] || [JYCommonTool isAlphaOrNum:text]||[JYCommonTool isBiaoDianFuHao:text])
     {
          return YES;
     }
     else
    if ([text isEqualToString:@"\n"] || [text isEqualToString:@""])
    {//删除
        
        return YES;
    }
    return NO;
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    //   _posRange = textView.selectedRange;
//    if (_textView.height == _minHeight) {
//        _canChange = YES;
//        return;
//    }
//    _textView.height = _minHeight;//MAX(_textView.contentSize.height  + 80, (_minHeight == 0?30:_minHeight));
//    _canChange = NO;
//    _oHeight = self.height;
//    self.height = _textView.height + 1 + _textView.y;
//    if(self.handleAction)
//    {
//        NSDictionary *dic = @{@"text":_textView.text,@"indexPath":_indexPath?:[NSNull new]};
//        self.handleAction(dic);
//        _textView.selectedRange = _posRange;
//        [self.textView becomeFirstResponder];
//    }
}
- (void)textViewDidEndEditing:(UITextView *)textView
{
    if(self.handleAction)
    {
        if (_canChange) {
            _textView.height = MAX(_textView.contentSize.height + 80, (_minHeight == 0?30:_minHeight));
        }
        else
        {
            _posRange = textView.selectedRange;
            return;
        }
//        _oHeight = self.height;
//        self.height = _textView.height + 1 + _textView.y;
//        //               textView.selectedRange = _posRange;
//        if( _oHeight != self.height)
//        {
//            //NSMakeRange(textView.text.length, 0);
//            CGPoint cursorPosition = [textView caretRectForPosition:textView.selectedTextRange.start].origin;
//            NSValue *v = [NSValue valueWithCGPoint:cursorPosition];
//            //          _posRange = textView.selectedRange;
//            NSValue *vr = [NSValue valueWithRange:_posRange];
//            NSDictionary *dic = @{@"text":_textView.text,@"indexPath":_indexPath?:[NSNull new],@"point":v,@"range":vr};
//            self.handleAction(dic);
//        }
    }
}

-(UITextView *)textView
{
    [[self textInputMode] primaryLanguage];
    return _textView;}

-(void)fitMode
{
    self.textView.placeholder.text = @"";
    _textView.x = 10;
    _textView.y = 8;
    _textView.width = __SCREEN_SIZE.width - 30;
    _textView.placeholder.textColor = kUIColorFromRGB(color_3);
    _textView.placeholder.font = [UIFont systemFontOfSize:14];
    _textView.placeholder.frame = CGRectMake(0,0,_textView.frame.size.width,48);
    _textView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    _minHeight = 106;
    if(__SCREEN_SIZE.width == 375)
    {
        _minHeight = 178;
    }
    else if (__SCREEN_SIZE.width == 414)
    {
        _minHeight = 278;
    }else if(__SCREEN_SIZE.height == 480)
    {
        _minHeight = 80;
    }
    _textView.height = MAX(_textView.contentSize.height  + 80, (_minHeight == 0?30:_minHeight));
    _oHeight = self.height;
    self.height = _textView.height + 1 + _textView.y;
    _maxCount = 1000;
}


-(void)fitModeB
{
    self.textView.placeholder.text = @"请输入内容不超过200字！（请勿发布违法的内容，会被删除或封号哦）";
    _textView.x = 10;
    _textView.y = 8;
    _textView.width = __SCREEN_SIZE.width - 30;
    _textView.placeholder.textColor = kUIColorFromRGB(color_3);
    _textView.placeholder.font = [UIFont systemFontOfSize:14];
    _textView.placeholder.frame = CGRectMake(0,0,_textView.frame.size.width,48);
    _textView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    _minHeight = 106;
    if(__SCREEN_SIZE.width == 375)
    {
        _minHeight = 128;
    }
    else if (__SCREEN_SIZE.width == 414)
    {
        _minHeight = 158;
    }else if(__SCREEN_SIZE.height == 480)
    {
        _minHeight = 80;
    }
    _textView.height = MAX(_textView.contentSize.height  + 80, (_minHeight == 0?30:_minHeight));
    _oHeight = self.height;
    self.height = _textView.height + 1 + _textView.y;
    _maxCount = 200;
}


-(void)fitModeC
{
    self.textView.placeholder.x = 15;
    self.textView.placeholder.text = @"标题\n5-25个字";
    _textView.x = 10;
//    _textView.y = 8;
    _textView.width = __SCREEN_SIZE.width - 30;
    _textView.placeholder.textColor = kUIColorFromRGB(color_6);
    _textView.placeholder.font = [UIFont systemFontOfSize:14];
    _textView.placeholder.frame = CGRectMake(0,0,_textView.frame.size.width,48);
    _textView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    _minHeight = 39;
    _textView.height = _minHeight;//MAX(_textView.contentSize.height  + 80, (_minHeight == 0?30:_minHeight));
    _oHeight = self.height;
    self.height = 80;
    _maxCount = 25;
    _textView.y = 40 - _textView.height/2.0;
}
-(void)dealloc
{
    //    [_textView removeObserver:self forKeyPath:@"contentSize"];
    [_tap.view removeGestureRecognizer:_tap];
    NSLog(@"test tp dealloc");
}

-(id)heightOfCell
{
    return @(self.height);
}

-(void)fitPublishMode
{
    self.height = 150;
    UIImageView *imgv = [self.contentView viewWithTag:12112];
    if (!imgv) {
        imgv = [[UIImageView alloc] initWithFrame:CGRectMake(15, 10, 13, 19)];
        imgv.tag = 12112;
    }
    imgv.image = [UIImage imageContentWithFileName:@"pencil"];
    [self.contentView addSubview:imgv];
    
    _textView.height = 100;
    _textView.placeholder.text = @"我想说...";
    _textView.placeholder.textColor = kUIColorFromRGB(color_808080);
    _textView.placeholder.font = [UIFont systemFontOfSize:15];
    _textView.placeholder.frame = CGRectMake(0,7,_textView.frame.size.width,16);
    _textView.x = 41;
    _textView.y = 5;
      _textView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    _textView.width = __SCREEN_SIZE.width - _textView.x - 15;
    _maxCount = 100;
    
}

-(void)fitRentMode
{
    self.height = 150;
//    UIImageView *imgv = [self.contentView viewWithTag:12112];
//    if (!imgv) {
//        imgv = [[UIImageView alloc] initWithFrame:CGRectMake(15, 10, 20, 20)];
//        imgv.tag = 12112;
//    }
//    imgv.image = [UIImage imageContentWithFileName:@"pencil"];
//    [self.contentView addSubview:imgv];
    
    _textView.height = 140;
    _textView.placeholder.text = @"";
    _textView.placeholder.textColor = kUIColorFromRGB(color_808080);
    _textView.placeholder.font = [UIFont systemFontOfSize:15];
    _textView.placeholder.frame = CGRectMake(0,7,_textView.frame.size.width,16);
    _textView.x = 15;
    _textView.y = 5;
    _textView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    _textView.width = __SCREEN_SIZE.width - _textView.x - 15;
    _maxCount = 100;
}

-(void)fitRentModeB
{
    self.height = 70;
    //    UIImageView *imgv = [self.contentView viewWithTag:12112];
    //    if (!imgv) {
    //        imgv = [[UIImageView alloc] initWithFrame:CGRectMake(15, 10, 20, 20)];
    //        imgv.tag = 12112;
    //    }
    //    imgv.image = [UIImage imageContentWithFileName:@"pencil"];
    //    [self.contentView addSubview:imgv];
    
    _textView.height = 60;
    _textView.placeholder.text = @"";
    _textView.placeholder.textColor = kUIColorFromRGB(color_808080);
    _textView.placeholder.font = [UIFont systemFontOfSize:15];
    _textView.placeholder.frame = CGRectMake(0,7,_textView.frame.size.width,16);
    _textView.x = 15;
    _textView.y = 5;
    _textView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    _textView.width = __SCREEN_SIZE.width - _textView.x - 15;
    _maxCount = 80;
}

-(void)fitApplyUintMode{
    self.height = 120;
    //    UIImageView *imgv = [self.contentView viewWithTag:12112];
    //    if (!imgv) {
    //        imgv = [[UIImageView alloc] initWithFrame:CGRectMake(15, 10, 20, 20)];
    //        imgv.tag = 12112;
    //    }
    //    imgv.image = [UIImage imageContentWithFileName:@"pencil"];
    //    [self.contentView addSubview:imgv];
    
    _textView.height = 110;
    _textView.placeholder.text = @"";
    _textView.placeholder.textColor = kUIColorFromRGB(color_808080);
    _textView.placeholder.font = [UIFont systemFontOfSize:15];
    _textView.placeholder.frame = CGRectMake(0,7,_textView.frame.size.width,16);
    _textView.x = 15;
    _textView.y = 5;
    _textView.contentInset = UIEdgeInsetsMake(0, 10, 0, 0);
    _textView.width = __SCREEN_SIZE.width - _textView.x - 15;
    _maxCount = 255;
}

-(void)fitCreateRent{
    self.height = 70;
    //    UIImageView *imgv = [self.contentView viewWithTag:12112];
    //    if (!imgv) {
    //        imgv = [[UIImageView alloc] initWithFrame:CGRectMake(15, 10, 20, 20)];
    //        imgv.tag = 12112;
    //    }
    //    imgv.image = [UIImage imageContentWithFileName:@"pencil"];
    //    [self.contentView addSubview:imgv];
    
    _textView.height = 60;
    _textView.placeholder.text = @"";
    _textView.placeholder.textColor = kUIColorFromRGB(color_808080);
    _textView.placeholder.font = [UIFont systemFontOfSize:15];
    _textView.placeholder.frame = CGRectMake(0,7,_textView.frame.size.width,16);
    _textView.x = 15;
    _textView.y = 5;
    _textView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    _textView.width = __SCREEN_SIZE.width - 30;
    _maxCount = 25;
}

-(void)fitCreateRentB{
    self.height = 140;
    //    UIImageView *imgv = [self.contentView viewWithTag:12112];
    //    if (!imgv) {
    //        imgv = [[UIImageView alloc] initWithFrame:CGRectMake(15, 10, 20, 20)];
    //        imgv.tag = 12112;
    //    }
    //    imgv.image = [UIImage imageContentWithFileName:@"pencil"];
    //    [self.contentView addSubview:imgv];
    
    _textView.height = 130;
    _textView.placeholder.text = @"";
    _textView.placeholder.textColor = kUIColorFromRGB(color_808080);
    _textView.placeholder.font = [UIFont systemFontOfSize:15];
    _textView.placeholder.frame = CGRectMake(0,7,_textView.frame.size.width,16);
    _textView.x = 15;
    _textView.y = 5;
    _textView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    _textView.width = __SCREEN_SIZE.width - 30;
    _maxCount = 255;
}

-(void)fitAddressMode{
    self.height = 41;

    
    _textView.height = 74;
    _textView.placeholder.textColor = kUIColorFromRGB(color_8);
    _textView.placeholder.font = [UIFont systemFontOfSize:15];
    _textView.placeholder.frame = CGRectMake(0,7,_textView.frame.size.width,16);
    _textView.x = 101;
    _textView.y = 5;
    _textView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    _textView.width = __SCREEN_SIZE.width - 15 - 101;
    _maxCount = 105;
     
     UILabel *txtLb = [self.contentView viewWithTag:10332];
     if (!txtLb) {
          txtLb = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 54, 14)];
          txtLb.tag = 10332;
          txtLb.x = 15;
          txtLb.y = 14;
          txtLb.text = @"详细地址";
          txtLb.numberOfLines = 1;
          txtLb.textColor = kUIColorFromRGB(color_5);
          txtLb.font = [UIFont systemFontOfSize:14];
     }
     [txtLb sizeToFit];
     _countTipLb.hidden = YES;
     [self.contentView addSubview:txtLb];
}


-(void)fitPublishActMode
{
    UILabel *txtLb = [self.contentView viewWithTag:10332];
    if (!txtLb) {
       txtLb = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150, 40)];
        txtLb.tag = 10332;
        txtLb.x = 15;
        txtLb.y = 25;
        txtLb.text = @"标题\n5-25个字";
        txtLb.numberOfLines = 2;
        txtLb.textColor = kUIColorFromRGB(color_6);
        txtLb.font = [UIFont systemFontOfSize:15];
    }
    [txtLb sizeToFit];
    
    [self.contentView addSubview:txtLb];
    self.textView.placeholder.x = 15;
    self.textView.placeholder.text = @"";
    _textView.x = 10;
    //    _textView.y = 8;
    _textView.width = __SCREEN_SIZE.width - 30 - 47 - txtLb.width;
    _textView.contentSize = CGSizeMake(_textView.width, 46);
    _textView.placeholder.textColor = kUIColorFromRGB(color_6);
    _textView.placeholder.font = [UIFont systemFontOfSize:14];
    _textView.placeholder.frame = CGRectMake(0,0,_textView.frame.size.width,48);
    _textView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    _minHeight = 46;
    _textView.height = _minHeight;//MAX(_textView.contentSize.height  + 80, (_minHeight == 0?30:_minHeight));
    _oHeight = self.height;
    self.height = 80;
    _maxCount = 25;
    _textView.y = 40 - _textView.height/2.0;
    _textView.x = 47 + txtLb.x + txtLb.width;
}

-(void)fitCommentMode
{
    self.height = 150;
    UIImageView *imgv = [self.contentView viewWithTag:12112];
    if (!imgv) {
        imgv = [[UIImageView alloc] initWithFrame:CGRectMake(15, 10, 13, 19)];
        imgv.tag = 12112;
    }
    imgv.image = [UIImage imageContentWithFileName:@"pencil"];
    [self.contentView addSubview:imgv];
    
    _textView.height = 145;
//    _textView.placeholder.text = @"我想说...";
    _textView.placeholder.textColor = kUIColorFromRGB(color_8);
    _textView.placeholder.font = [UIFont systemFontOfSize:15];
    _textView.placeholder.frame = CGRectMake(0,7,_textView.frame.size.width,16);
    _textView.x = 41;
    _textView.y = 5;
    _textView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    _textView.width = __SCREEN_SIZE.width - _textView.x - 15;
    _maxCount = 240;
    self.backgroundColor = kUIColorFromRGB(color_4);
}


-(void)fitWriteEvaluationMode
{
     self.height = 130;
     
     _textView.height = 120;
     _textView.placeholder.textColor = kUIColorFromRGB(color_0xb0b0b0);
     _textView.placeholder.font = [UIFont systemFontOfSize:12];
     _textView.placeholder.frame = CGRectMake(8,8,_textView.frame.size.width,16);
     _textView.x = 15;
     _textView.y = 0;
     _textView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
     _textView.width = __SCREEN_SIZE.width - _textView.x - 15;
     _textView.textColor = kUIColorFromRGB(color_0x757575);
     _textView.font = [UIFont systemFontOfSize:12];
     _textView.backgroundColor = kUIColorFromRGB(color_0xf0f0f0);
     _maxCount = 100;
     _textView.layer.borderColor = kUIColorFromRGB(color_lineColor).CGColor;
     _textView.layer.borderWidth = 0.5;
//     self.backgroundColor = kUIColorFromRGB(color_0xf0f0f0);
     _countTipLb.width = 90;
     _countTipLb.textAlignment = NSTextAlignmentRight;
     _countTipLb.height = 12;
     _countTipLb.y = 100;
     _countTipLb.font = [UIFont systemFontOfSize:12];
     _countTipLb.textColor = kUIColorFromRGB(color_0xb0b0b0);
     _countTipLb.x = __SCREEN_SIZE.width - 25 - _countTipLb.width;
     _countTipLb.text = @"0/100";
}


-(void)fitPersonInfoSettingMode
{
    self.height = 150;
//    UIImageView *imgv = [self.contentView viewWithTag:12112];
//    if (!imgv) {
//        imgv = [[UIImageView alloc] initWithFrame:CGRectMake(15, 10, 20, 20)];
//        imgv.tag = 12112;
//    }
//    imgv.image = [UIImage imageContentWithFileName:@"pencil"];
//    [self.contentView addSubview:imgv];
    
    _textView.height = 145;
    //    _textView.placeholder.text = @"我想说...";
    _textView.placeholder.textColor = kUIColorFromRGB(color_8);
    _textView.placeholder.font = [UIFont systemFontOfSize:15];
    _textView.placeholder.frame = CGRectMake(0,7,_textView.frame.size.width,16);
    _textView.x = 15;
    _textView.y = 5;
    _textView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    _textView.width = __SCREEN_SIZE.width - _textView.x - 15;
    _maxCount = 240;
    self.backgroundColor = kUIColorFromRGB(color_4);
}

-(void)fitPublishEvaMode
{
     self.height = 150;
     _textView.height = 135;
     _textView.placeholder.textColor = kUIColorFromRGB(color_0xb0b0b0);
     _textView.placeholder.font = [UIFont systemFontOfSize:13];
     _textView.placeholder.frame = CGRectMake(0,2,_textView.frame.size.width,12);
     _textView.x = 15;
     _textView.y = 16;
     _textView.contentInset = UIEdgeInsetsMake(6, 10, 0, 0);
     _textView.font = [UIFont systemFontOfSize:12];
     _textView.width = __SCREEN_SIZE.width - _textView.x - 15;
     _textView.contentSize = CGSizeMake(_textView.width - 24, 85);
     _textView.scrollEnabled = NO;
     _textView.font = [UIFont systemFontOfSize:13];
     _maxCount = 140;
     _textView.backgroundColor = kUIColorFromRGB(color_2);
//     _textView.layer.borderColor = kUIColorFromRGB(color_lineColor).CGColor;
//     _textView.layer.borderWidth = 0.5;
     self.backgroundColor = kUIColorFromRGB(color_0xf0f0f0);
     _countTipLb.hidden = YES;
//     _countTipLb.width = 90;
//     _countTipLb.textAlignment = NSTextAlignmentRight;
//     _countTipLb.height = 12;
//     _countTipLb.y = 111;
//     _countTipLb.font = [UIFont systemFontOfSize:12];
//     _countTipLb.textColor = kUIColorFromRGB(color_0xb0b0b0);
//     _countTipLb.x = __SCREEN_SIZE.width - 25 - _countTipLb.width;
//     _countTipLb.text = @"0/140字";
}

-(void)fitPublishAnswerMode
{
     self.height = 121;
     _textView.height = 120;
     _textView.placeholder.textColor = kUIColorFromRGB(color_0xb0b0b0);
     _textView.placeholder.font = [UIFont systemFontOfSize:12];
     _textView.placeholder.frame = CGRectMake(0,4,_textView.frame.size.width,12);
     _textView.x = 15;
     _textView.y = 0;
     _textView.contentInset = UIEdgeInsetsMake(6, 10, 0, 0);
     _textView.font = [UIFont systemFontOfSize:12];
     _textView.width = __SCREEN_SIZE.width - _textView.x - 15;
     _textView.contentSize = CGSizeMake(_textView.width - 20, 110);
     _textView.scrollEnabled = NO;
     _maxCount = 100;
     _textView.backgroundColor = kUIColorFromRGB(color_0xf0f0f0);
     _textView.layer.borderColor = kUIColorFromRGB(color_lineColor).CGColor;
     _textView.layer.borderWidth = 0.5;
     self.backgroundColor = kUIColorFromRGB(color_2);
     _countTipLb.width = 90;
     _countTipLb.textAlignment = NSTextAlignmentRight;
     _countTipLb.height = 12;
     _countTipLb.y = 102;
     _countTipLb.font = [UIFont systemFontOfSize:12];
     _countTipLb.textColor = kUIColorFromRGB(color_0xb0b0b0);
     _countTipLb.x = __SCREEN_SIZE.width - 25 - _countTipLb.width;
     _countTipLb.text = @"0/100";
}
-(void)fitFeedbackMode
{
     self.height = 136;
          _textView.height = 120;
     _textView.placeholder.textColor = kUIColorFromRGB(color_0xb0b0b0);
     _textView.placeholder.font = [UIFont systemFontOfSize:12];
     _textView.placeholder.frame = CGRectMake(0,4,_textView.frame.size.width,12);
     _textView.x = 15;
     _textView.y = 15;
     _textView.contentInset = UIEdgeInsetsMake(6, 30, 0, 30);
     _textView.font = [UIFont systemFontOfSize:12];
     _textView.width = __SCREEN_SIZE.width - _textView.x - 15;
//       _textView.contentSize = CGSizeMake(_textView.width - 24, 110);
     _textView.scrollEnabled = NO;
     _maxCount = 100;
     _textView.backgroundColor = kUIColorFromRGB(color_2);
     _textView.layer.borderColor = kUIColorFromRGB(color_lineColor).CGColor;
     _textView.layer.borderWidth = 0.5;
     self.backgroundColor = kUIColorFromRGB(color_0xf0f0f0);
     _countTipLb.width = 90;
     _countTipLb.textAlignment = NSTextAlignmentRight;
     _countTipLb.height = 12;
     _countTipLb.y = 111;
     _countTipLb.font = [UIFont systemFontOfSize:12];
     _countTipLb.textColor = kUIColorFromRGB(color_0xb0b0b0);
     _countTipLb.x = __SCREEN_SIZE.width - 25 - _countTipLb.width;
     _countTipLb.text = @"0/100字";
}
-(void)fitApplySalesReturnMode
{
     self.height = 130;
     _textView.height = 120;
     _textView.placeholder.textColor = kUIColorFromRGB(color_0xb0b0b0);
     _textView.placeholder.font = [UIFont systemFontOfSize:12];
     _textView.placeholder.frame = CGRectMake(8,7,_textView.frame.size.width,12);
     _textView.x = 15;
     _textView.y = 0;
     _textView.contentInset = UIEdgeInsetsMake(0, 14, 10, 10);
     _textView.font = [UIFont systemFontOfSize:12];
     _textView.width = __SCREEN_SIZE.width - _textView.x - 15;
//     _textView.contentSize = CGSizeMake(_textView.width, 100);
     _textView.scrollEnabled = NO;
     _maxCount = 100;
     _textView.backgroundColor = kUIColorFromRGB(color_2);
     _textView.layer.borderColor = kUIColorFromRGB(color_lineColor).CGColor;
     _textView.layer.borderWidth = 0.5;
     self.backgroundColor = kUIColorFromRGB(color_0xf0f0f0);
     _countTipLb.width = 90;
     _countTipLb.textAlignment = NSTextAlignmentRight;
     _countTipLb.height = 12;
     _countTipLb.y = 100;
     _countTipLb.font = [UIFont systemFontOfSize:12];
     _countTipLb.textColor = kUIColorFromRGB(color_0xb0b0b0);
     _countTipLb.x = __SCREEN_SIZE.width - 25 - _countTipLb.width;
     _countTipLb.text = @"0/100";
}
-(void)fitPublishSecHandDealMode
{
     self.height = 126;
     _textView.height = 110;
     _textView.placeholder.textColor = kUIColorFromRGB(color_0xb0b0b0);
     _textView.placeholder.font = [UIFont systemFontOfSize:12];
     _textView.placeholder.frame = CGRectMake(0,4,_textView.frame.size.width,12);
     _textView.x = 5;
     _textView.y = 2;
     _textView.contentInset = UIEdgeInsetsMake(6, 10, 0, 0);
     _textView.font = [UIFont systemFontOfSize:12];
     _textView.width = __SCREEN_SIZE.width - _textView.x - 15;
     _textView.contentSize = CGSizeMake(_textView.width - 20, 110);
     _textView.scrollEnabled = NO;
     _maxCount = 500;
     _textView.backgroundColor = kUIColorFromRGB(color_2);
//     _textView.layer.borderColor = kUIColorFromRGB(color_lineColor).CGColor;
//     _textView.layer.borderWidth = 0.5;
     self.backgroundColor = kUIColorFromRGB(color_2);
     _countTipLb.width = 90;
     _countTipLb.textAlignment = NSTextAlignmentRight;
     _countTipLb.height = 12;
     _countTipLb.y = 111;
     _countTipLb.font = [UIFont systemFontOfSize:12];
     _countTipLb.textColor = kUIColorFromRGB(color_0xb0b0b0);
     _countTipLb.x = __SCREEN_SIZE.width - 25 - _countTipLb.width;
     _countTipLb.text = [NSString stringWithFormat:@"%ld/140字",_textView.text.length];
}

-(void)fitToDoorRecycleMode
{
     self.height = 130;
     _textView.height = 110;
     _textView.placeholder.textColor = kUIColorFromRGB(color_0xb0b0b0);
     _textView.placeholder.font = [UIFont systemFontOfSize:12];
     _textView.placeholder.frame = CGRectMake(0,4,_textView.frame.size.width,12);
     _textView.x = 5;
     _textView.y = 2;
     _textView.contentInset = UIEdgeInsetsMake(6, 10, 0, 0);
     _textView.font = [UIFont systemFontOfSize:12];
     _textView.width = __SCREEN_SIZE.width - _textView.x - 15;
     _textView.contentSize = CGSizeMake(_textView.width - 20, 110);
     _textView.scrollEnabled = NO;
     _maxCount = 140;
     _textView.backgroundColor = kUIColorFromRGB(color_2);
     //     _textView.layer.borderColor = kUIColorFromRGB(color_lineColor).CGColor;
     //     _textView.layer.borderWidth = 0.5;
     self.backgroundColor = kUIColorFromRGB(color_2);
     _countTipLb.width = 90;
     _countTipLb.textAlignment = NSTextAlignmentRight;
     _countTipLb.height = 12;
     _countTipLb.y = 111;
     _countTipLb.font = [UIFont systemFontOfSize:12];
     _countTipLb.textColor = kUIColorFromRGB(color_0xb0b0b0);
     _countTipLb.x = __SCREEN_SIZE.width - 25 - _countTipLb.width;
     _countTipLb.text = @"0/140字";
}
@end
